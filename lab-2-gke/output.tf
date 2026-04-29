output "connect_cluster" {
  description = "Run this command to link your kubectl to the cluster"
  value       = "gcloud container clusters get-credentials ${google_container_cluster.autopilot_cluster.name} --region ${var.region}"
}

output "nginx_external_ip" {
  description = "The public IP of your web server"
  # Use a splat or optional check because the IP takes time to generate
  value = kubernetes_service_v1.nginx_service.status[0].load_balancer[0].ingress[0].ip
}
