output "vm_name" {
  description = "The name of the VM created"
  value       = google_compute_instance.private_vm.name
}

output "vm_internal_ip" {
  description = "The internal IP address of the VM"
  value       = google_compute_instance.private_vm.network_interface[0].network_ip
}

output "service_account_email" {
  description = "The email of the service account attached to the VM"
  value       = google_service_account.vm_sa.email
}

output "ssh_command" {
  description = "Copy and paste this command to SSH into your VM via IAP"
  value       = "gcloud compute ssh ${google_compute_instance.private_vm.name} --tunnel-through-iap --zone=${var.zone}"
}

output "test_bucket_name" {
  value = google_storage_bucket.test_bucket.name
}

output "verification_command" {
  description = "Run this INSIDE the VM to verify Private Google Access"
  value       = "gsutil cat gs://${google_storage_bucket.test_bucket.name}/hello-ace.txt"
}
