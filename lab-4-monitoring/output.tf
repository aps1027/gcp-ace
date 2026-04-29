output "vm_name" {
  value = google_compute_instance.monitor_vm.name
}

output "ssh_command" {
  value = "gcloud compute ssh ${google_compute_instance.monitor_vm.name} --zone=${var.region}-a"
}

output "cpu_stress_command" {
  description = "Run this inside the VM to trigger the alert"
  value       = "timeout 300s cat /dev/urandom > /dev/null &"
}
