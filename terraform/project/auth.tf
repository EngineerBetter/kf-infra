resource "google_service_account" "ci_bot" {
  account_id   = "ci-bot"
  display_name = "ci-bot"
  description  = "To be used by CI"
}

resource "google_project_iam_member" "owner" {
  role   = "roles/owner"
  member = "serviceAccount:${google_service_account.ci_bot.email}"
}

resource "google_project_iam_member" "gke_admin" {
  role   = "roles/container.admin"
  member = "serviceAccount:${google_service_account.ci_bot.email}"
}

resource "google_project_iam_member" "metrics_writer" {
  role   = "roles/monitoring.metricWriter"
  member = "serviceAccount:${google_service_account.ci_bot.email}"
}

resource "google_project_iam_member" "logging_writer" {
  role   = "roles/logging.logWriter"
  member = "serviceAccount:${google_service_account.ci_bot.email}"
}

resource "google_service_account_key" "ci_bot_key" {
  service_account_id = google_service_account.ci_bot.name
}
