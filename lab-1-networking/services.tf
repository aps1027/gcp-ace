# Enable the Compute Engine API
resource "google_project_service" "compute" {
  project = var.project_id
  service = "compute.googleapis.com"

  # Keep this false to prevent accidentally disabling essential services
  disable_on_destroy = false
}

# Enable the Identity-Aware Proxy (IAP) API for SSH access
resource "google_project_service" "iap" {
  project = var.project_id
  service = "iap.googleapis.com"

  disable_on_destroy = false
}
