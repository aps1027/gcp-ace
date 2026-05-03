output "network_id" {
  description = "ID of the VPC network"
  value       = google_compute_network.vpc.id
}

output "network_name" {
  description = "Name of the VPC network"
  value       = google_compute_network.vpc.name
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = google_compute_subnetwork.subnet.id
}

output "subnet_name" {
  description = "Name of the subnet"
  value       = google_compute_subnetwork.subnet.name
}

output "pods_range_name" {
  description = "Name of the pods secondary IP range"
  value       = "pods"
}

output "services_range_name" {
  description = "Name of the services secondary IP range"
  value       = "services"
}
