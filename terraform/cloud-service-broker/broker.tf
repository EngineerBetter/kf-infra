provider "google" {
  project = var.project_id
  region  = var.region
}

resource "random_id" "db-suffix" {
  byte_length           = 4
}
resource "google_sql_database_instance" "csb" {
  name             = "cloud-service-broker-database-${random_id.db-suffix.hex}"
  database_version = "MYSQL_5_7"
  region           = var.region
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "csb_database" {
  name     = "servicebroker"
  instance = google_sql_database_instance.csb.name
}

resource "google_sql_user" "csb_user" {
  name     = var.database_user
  instance = google_sql_database_instance.csb.name
  password = var.database_password
}

resource "google_service_account" "service_broker" {
  account_id   = "service-broker"
  display_name = "service-broker"
  description  = "To be used by CI"
}

resource "google_project_iam_member" "cloudsql_client" {
  role   = "roles/cloudsql.client"
  member = "serviceAccount:${google_service_account.service_broker.email}"
}

resource "google_project_iam_member" "network_user" {
  role   = "roles/compute.networkUser"
  member = "serviceAccount:${google_service_account.service_broker.email}"
}

resource "google_project_iam_member" "cloudsql_admin" {
  project = var.project_id
  role    = "roles/cloudsql.admin"
  member = "serviceAccount:${google_service_account.service_broker.email}"
}

resource "google_project_iam_member" "redis_admin" {
  project = var.project_id
  role    = "roles/redis.admin"
  member = "serviceAccount:${google_service_account.service_broker.email}"
}

resource "google_service_account_iam_policy" "kubernetes_binding" {
  service_account_id = google_service_account.service_broker.name
  policy_data        = data.google_iam_policy.kubernetes_policy.policy_data
}

data "google_iam_policy" "kubernetes_policy" {
  binding {
    role = "roles/iam.workloadIdentityUser"

    members = [
      "serviceAccount:${var.project_id}.svc.id.goog[kf-csb/csb-user]",
    ]
  }
}