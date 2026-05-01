output "cloudbuild_api" {
  value = google_project_service.cloudbuild.service
  description = "Cloud Build API Service"
}

output "artifact_registry_api" {
  value = google_project_service.artifactregistry.service
  description = "Artifact Registry API Service"
}