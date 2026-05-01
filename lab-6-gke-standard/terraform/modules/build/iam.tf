
resource "google_service_account" "cloudbuild" {
  project      = var.project_id
  account_id   = "backend-cloudbuild"
  display_name = "Cloud Build Service Account for Backend"
  description  = "Service account used by Cloud Build to build and push API Gateway image to Artifact Registry"
}
