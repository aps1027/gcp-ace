resource "google_project_service" "kubernetes" {
  project = var.project_id
  service = "container.googleapis.com"
  disable_on_destroy = false
}