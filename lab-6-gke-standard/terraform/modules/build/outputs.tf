output "cloudbuild_service_account_email" {
  description = "Service account used by Cloud Build"
  value       = google_service_account.cloudbuild.email
}

output "cloudbuild_service_account_id" {
  description = "Service account ID"
  value       = google_service_account.cloudbuild.id
}

output "api_gateway_trigger_id" {
  description = "Cloud Build trigger ID for API Gateway"
  value       = google_cloudbuild_trigger.api_gateway.id
}

output "auth_ms_trigger_id" {
  description = "Cloud Build trigger ID for Auth microservice"
  value       = google_cloudbuild_trigger.auth_ms.id
}

output "api_gateway_trigger_name" {
  description = "Name of the Cloud Build trigger for API Gateway"
  value       = google_cloudbuild_trigger.api_gateway.name
}

output "auth_ms_trigger_name" {
  description = "Name of the Cloud Build trigger for Auth microservice"
  value       = google_cloudbuild_trigger.auth_ms.name
}
