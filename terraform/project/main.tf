provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_service_account" "ci_bot" {
  account_id   = "ci-bot"
  display_name = "ci-bot"
  description  = "To be used by CI"
}
