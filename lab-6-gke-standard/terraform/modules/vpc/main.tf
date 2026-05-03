resource "google_compute_network" "vpc" {
  project                 = var.project_id
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  project       = var.project_id
  name          = var.subnet_name
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = var.subnet_cidr

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = var.pods_cidr
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = var.services_cidr
  }
}

# Allow GCE Load Balancer to reach GKE nodes on NodePort range
# Required for GCE Ingress on custom VPCs — GKE does not auto-create this
resource "google_compute_firewall" "allow_lb_to_nodeport" {
  project = var.project_id
  name    = "${var.network_name}-allow-lb-to-nodeport"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  # GCP Load Balancer proxy IP ranges
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
}
