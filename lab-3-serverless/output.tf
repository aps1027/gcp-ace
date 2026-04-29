output "cloud_run_url" {
  value = google_cloud_run_v2_service.processor.uri
}

output "impersonation_command" {
  value = "gcloud config set auth/impersonate_service_account ${google_service_account.run_sa.email}"
}

output "pubsub_test_command" {
  value = "gcloud pubsub topics publish audio-uploads --message='Hello Cloud Run'"
}
