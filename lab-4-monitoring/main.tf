# 1. VM with Ops Agent
resource "google_compute_instance" "monitor_vm" {
  name         = "monitor-test-vm"
  machine_type = "e2-micro"
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  # Correct Ops Agent installation
  metadata_startup_script = <<-EOF
    #!/bin/bash
    curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
    sudo bash add-google-cloud-ops-agent-repo.sh --also-install
  EOF

  depends_on = [
    google_project_service.monitoring,
    google_project_service.compute
  ]
}

# 2. Email Notification Channel
resource "google_monitoring_notification_channel" "email_admin" {
  display_name = "Email Admin Alert"
  type         = "email"

  labels = {
    email_address = var.admin_email
  }
}

# 3. CPU Alert Policy
resource "google_monitoring_alert_policy" "cpu_limit_alert" {
  display_name = "High CPU Alert - Monitor VM"
  combiner     = "OR"

  conditions {
    display_name = "CPU > 80%"

    condition_threshold {
      filter = "resource.type = \"gce_instance\" AND resource.label.instance_id = \"${google_compute_instance.monitor_vm.instance_id}\" AND metric.type = \"compute.googleapis.com/instance/cpu/utilization\""

      comparison      = "COMPARISON_GT"
      threshold_value = 0.8

      # Fast trigger for testing (change to 120s for production)
      duration = "0s"

      trigger {
        count = 1
      }

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.email_admin.name
  ]

  documentation {
    content = "VM ${google_compute_instance.monitor_vm.name} CPU is above 80%. Check running processes."
  }

  depends_on = [
    google_compute_instance.monitor_vm
  ]
}
