module "asm" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/asm"

  project_id       = var.project_id
  cluster_name     = var.cluster_name
  location         = google_container_cluster.primary.location
  enable_all       = true
  skip_validation  = true
  asm_version      = "1.10"
  cluster_endpoint = google_container_cluster.primary.endpoint
}