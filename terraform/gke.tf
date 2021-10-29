resource "google_service_account" "default" {
  account_id   = "sandbox-gke-sa"
  display_name = "Sandbox GKE"
}

resource "google_project_iam_custom_role" "serviceAccountUpdater" {
  role_id     = "serviceAccountUpdater"
  title       = "Service Account Updater"
  description = "This role only updates members on a GSA"
  permissions = [
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.getIamPolicy",
    "iam.serviceAccounts.list",
    "iam.serviceAccounts.setIamPolicy"
  ]
}

resource "google_project_iam_member" "service_account_updater" {
  role    = "projects/${var.project_id}/roles/serviceAccountUpdater"
  member  = "serviceAccount:${google_service_account.default.email}"
}

resource "google_project_iam_member" "metrics_writer" {
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.default.email}"
}

resource "google_project_iam_member" "log_writer" {
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.default.email}"
}

resource "google_container_cluster" "primary" {
  name                     = var.cluster_name
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.vpc.name
  subnetwork               = google_compute_subnetwork.subnet.name

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

resource "google_container_node_pool" "nodes" {
  name       = "${var.cluster_name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 4

  node_config {
    preemptible     = true
    machine_type    = "e2-medium"
    service_account = google_service_account.default.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}