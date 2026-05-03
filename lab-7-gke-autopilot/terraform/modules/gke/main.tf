resource "google_container_cluster" "primary" {
  project  = var.project_id
  name     = var.cluster_name
  location = var.region

  enable_autopilot = true

  network    = var.network_name
  subnetwork = var.subnet_name

  # VPC-native cluster with secondary IP ranges for pods and services
  ip_allocation_policy {
    cluster_secondary_range_name  = var.pod_range_name
    services_secondary_range_name = var.services_range_name
  }

  # Enable Workload Identity - lets pods authenticate to GCP APIs using service accounts without needing to manage keys
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # Cloud Operations integration - audit logging and metrics
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  deletion_protection = false
}

resource "google_compute_global_address" "ingress_ip" {
  project = var.project_id
  name    = "${var.cluster_name}-ingress-ip"
}
