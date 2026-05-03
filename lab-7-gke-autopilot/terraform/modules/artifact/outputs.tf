output "repository_id" {
  description = "Artifact Registry Repository ID"
  value       = google_artifact_registry_repository.backend.repository_id
}

output "repository_url" {
  description = "Artifact Registry Repository URL"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.backend.repository_id}"
}
