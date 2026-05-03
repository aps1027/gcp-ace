output "artifact_backend_repository_id" {
  value       = module.artifact.repository_url
  description = "Artifact Registry Repository URL for backend application"
}

output "api_gateway_trigger_id" {
  value       = module.build.api_gateway_trigger_name
  description = "Cloud Build trigger Name for API Gateway"
}

output "auth_ms_trigger_id" {
  value       = module.build.auth_ms_trigger_name
  description = "Cloud Build trigger Name for Auth MS"
}
