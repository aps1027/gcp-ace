resource "google_container_cluster" "primary" {
  project  = var.project_id
  name     = var.cluster_name
  location = var.zone

  # Remove the default node pool - we manage our own in a separate resource
  remove_default_node_pool = true
  initial_node_count       = 1

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

  # Cloud Operations (formerly Stackdriver) integration - satisfy audit logging requirements and get metrics for free
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  deletion_protection = false
}

resource "google_container_node_pool" "pool_a" {
  project  = var.project_id
  name     = "node-pool-a"
  cluster  = google_container_cluster.primary.name
  location = var.zone

  initial_node_count = var.node_count

  autoscaling {
    min_node_count = var.node_min_count
    max_node_count = var.node_max_count
  }

  node_config {
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb
    disk_type    = "pd-standard"

    # Workload Identity on each node
    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

resource "google_compute_global_address" "ingress_ip" {
  project = var.project_id
  name    = "${var.cluster_name}-ingress-ip"
}
