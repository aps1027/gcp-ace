
resource "google_service_account" "cloudbuild" {
  project      = var.project_id
  account_id   = "backend-cloudbuild"
  display_name = "Cloud Build Service Account for Backend"
  description  = "Service account used by Cloud Build to build and push API Gateway image to Artifact Registry"
}

resource "google_project_iam_member" "cloudbuild_artifact_registry_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.cloudbuild.email}"
}

resource "google_project_iam_member" "cloudbuild_logging_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cloudbuild.email}"
}

resource "google_project_iam_member" "cloudbuild_container_developer" {
  project = var.project_id
  role    = "roles/container.developer"
  member  = "serviceAccount:${google_service_account.cloudbuild.email}"
}
