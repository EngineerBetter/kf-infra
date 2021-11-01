provider "google-beta" {
  project = var.project_id
  region  = var.region
}

resource "google_artifact_registry_repository" "main" {
  provider = google-beta

  location      = var.region
  repository_id = var.cluster_name
  description   = "Docker registry for Kf images"
  format        = "DOCKER"
}