resource "google_artifact_registry_repository" "backend" {
  project       = var.project_id
  repository_id = "backend"
  format        = "DOCKER"
  location      = var.region
  description   = "Docker images for backend application"
}
