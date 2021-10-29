provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket = "kf-terraform-state"
    prefix = "terraform/state"
  }
}
