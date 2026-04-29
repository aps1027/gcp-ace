# 1. Create a VPC for GKE
resource "google_compute_network" "gke_vpc" {
  name                    = "gke-vpc"
  auto_create_subnetworks = false
  depends_on              = [google_project_service.kubernetes]
}

# 2. Create a Subnet for GKE (VPC-Native)
resource "google_compute_subnetwork" "gke_subnet" {
  name          = "gke-subnet"
  ip_cidr_range = "10.10.0.0/24"
  network       = google_compute_network.gke_vpc.id
  region        = var.region

  # Secondary ranges are required for VPC-Native clusters (GKE Best Practice)
  secondary_ip_range {
    range_name    = "pods-range"
    ip_cidr_range = "10.20.0.0/16"
  }
  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.30.0.0/20"
  }
}

# 3. GKE Autopilot Cluster (Q19 & Q33)
resource "google_container_cluster" "autopilot_cluster" {
  name     = "ace-autopilot-cluster"
  location = var.region

  # Q19: Autopilot mode manages everything for you
  enable_autopilot = true

  deletion_protection = false

  network    = google_compute_network.gke_vpc.id
  subnetwork = google_compute_subnetwork.gke_subnet.id

  # Q33: Private Cluster (No public IPs on nodes)
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false # Keep API public so we can use kubectl from Ubuntu
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods-range"
    services_secondary_range_name = "services-range"
  }
}

# 4. Nginx Deployment (Question 8 Logic)
resource "kubernetes_deployment_v1" "nginx" {
  metadata {
    name   = "web-server"
    labels = { app = "nginx" }
  }

  spec {
    replicas = 1
    selector {
      match_labels = { app = "nginx" }
    }
    template {
      metadata {
        labels = { app = "nginx" }
      }
      spec {
        container {
          image = "nginx:latest"
          name  = "nginx"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# 5. LoadBalancer Service (Question 10/14 Logic)
resource "kubernetes_service_v1" "nginx_service" {
  metadata {
    name = "web-server-service"
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.nginx.metadata[0].labels.app
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}

