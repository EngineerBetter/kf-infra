resource "google_project_service" "dns" {
  service = "dns.googleapis.com"
}

resource "google_project_service" "containerregistry" {
  service = "containerregistry.googleapis.com"
}

resource "google_project_service" "artifactregistry" {
  service = "artifactregistry.googleapis.com"
}

resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "redis" {
  service = "redis.googleapis.com"
}

resource "google_project_service" "container" {
  project = var.project_id
  service = "container.googleapis.com"
}

resource "google_project_service" "networking" {
  service = "servicenetworking.googleapis.com"
}

resource "google_project_service" "stackdriver" {
  service = "stackdriver.googleapis.com"
}

resource "google_project_service" "monitoring" {
  service = "monitoring.googleapis.com"
}

resource "google_project_service" "logging" {
  service = "logging.googleapis.com"
}

resource "google_project_service" "cloudresourcemanager" {
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "cloudtrace" {
  service = "cloudtrace.googleapis.com"
}

resource "google_project_service" "meshca" {
  service = "meshca.googleapis.com"
}

resource "google_project_service" "meshtelemetry" {
  service = "meshtelemetry.googleapis.com"
}

resource "google_project_service" "meshconfig" {
  service = "meshconfig.googleapis.com"
}

resource "google_project_service" "iamcredentials" {
  service = "iamcredentials.googleapis.com"
}

resource "google_project_service" "gkeconnect" {
  service = "gkeconnect.googleapis.com"
}

resource "google_project_service" "gkehub" {
  service = "gkehub.googleapis.com"
}

resource "google_project_service" "service_usage" {
  service = "serviceusage.googleapis.com"
}

resource "google_project_service" "service_usage" {
  service = "sqladmin.googleapis.com"
}