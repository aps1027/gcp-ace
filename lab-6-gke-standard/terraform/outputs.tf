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

output "gke_cluster_name" {
  value       = module.gke.cluster_name
  description = "Name of the GKE cluster"
}

output "gke_cluster_endpoint" {
  value       = module.gke.cluster_endpoint
  description = "Endpoint of the GKE cluster"
}

output "ingress_ip_name" {
  value       = module.gke.ingress_ip_name
  description = "Static IP name - use in Ingress annotation"
}

output "ingress_ip_address" {
  value       = module.gke.ingress_ip_address
  description = "Reserved static IP address for the load balancer - use in Ingress annotation"
}
