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
  role   = "projects/${var.project_id}/roles/serviceAccountUpdater"
  member = "serviceAccount:${google_service_account.default.email}"
}

resource "google_project_iam_member" "metrics_writer" {
  role   = "roles/monitoring.metricWriter"
  member = "serviceAccount:${google_service_account.default.email}"
}

resource "google_project_iam_member" "log_writer" {
  role   = "roles/logging.logWriter"
  member = "serviceAccount:${google_service_account.default.email}"
}

resource "google_service_account_iam_member" "kf_controller" {
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[kf/controller]"
  service_account_id = google_service_account.default.name
}

resource "google_service_account_iam_member" "cnrm_controller_manager" {
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[cnrm-system/cnrm-controller-manager]"
  service_account_id = google_service_account.default.name
}

resource "google_project_iam_member" "registry_writer" {
  role   = "roles/artifactregistry.writer"
  member = "serviceAccount:${google_service_account.default.email}"
}
