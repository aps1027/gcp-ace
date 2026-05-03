output "cluster_name" {
  description = "Name of the GKE Autopilot cluster"
  value       = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  description = "Endpoint of the GKE Autopilot cluster"
  value       = google_container_cluster.primary.endpoint
}

output "cluster_ca_certificate" {
  description = "CA certificate of the GKE Autopilot cluster"
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
  sensitive   = true
}

output "ingress_ip_name" {
  description = "Name of the reserved global IP for ingress"
  value       = google_compute_global_address.ingress_ip.name
}

output "ingress_ip_address" {
  description = "Reserved global IP address for ingress"
  value       = google_compute_global_address.ingress_ip.address
}
