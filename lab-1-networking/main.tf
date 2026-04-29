# 1. VPC & Subnet with Private Google Access (Q2 & Q31)
resource "google_compute_network" "vpc" {
  name                    = "lab1-vpc"
  auto_create_subnetworks = false

  # This tells Terraform: "Don't build the VPC until the API is ready!"
  depends_on = [google_project_service.compute]
}

resource "google_compute_subnetwork" "private_subnet" {
  name                     = "lab1-private-subnet"
  ip_cidr_range            = "10.0.1.0/24"
  network                  = google_compute_network.vpc.id
  region                   = var.region
  private_ip_google_access = true # KEY BEST PRACTICE -> TO ON/OFF Private Google Access
}

# 2. Service Account with Least Privilege (Q3)
resource "google_service_account" "vm_sa" {
  account_id   = "lab1-vm-sa"
  display_name = "Custom SA for Private VM"
}

resource "google_project_iam_member" "storage_viewer" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.vm_sa.email}"
}

# 3. Compute Engine Instance with Network Tags (Q1, Q14, Q26)
resource "google_compute_instance" "private_vm" {
  name         = "lab1-private-vm"
  machine_type = "e2-micro" # Free tier eligible
  zone         = var.zone
  tags         = ["web-server", "managed-by-terraform"] # Network Tags

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private_subnet.id
    # Note: No 'access_config' block means NO Public IP
  }

  service_account {
    email  = google_service_account.vm_sa.email
    scopes = ["cloud-platform"]
  }
}

# 4. Firewall for IAP (Accessing private VM without VPN/Public IP)
resource "google_compute_firewall" "allow_iap" {
  name    = "allow-ssh-from-iap"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"] # Mandatory Google IAP range
  target_tags   = ["web-server"]
}

# 5. Explicitly add YOUR email for IAP access
resource "google_project_iam_member" "iap_access" {
  project = var.project_id
  role    = "roles/iap.tunnelResourceAccessor"
  member  = "user:${var.admin_email}"

  # Wait for the IAP API to be ready!
  depends_on = [google_project_service.iap]
}

# Create a unique bucket name using a random suffix (since bucket names must be unique globally)
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# 6. Create the Test Bucket
resource "google_storage_bucket" "test_bucket" {
  name          = "ace-lab-bucket-${random_id.bucket_suffix.hex}"
  location      = var.region
  force_destroy = true # This allows 'terraform destroy' to delete the bucket even if it has files

  uniform_bucket_level_access = true

  public_access_prevention    = "enforced" # Security Best Practice
}

# 7. Upload a sample file to the bucket
resource "google_storage_bucket_object" "sample_file" {
  name    = "hello-ace.txt"
  content = "Success! Private Google Access is working."
  bucket  = google_storage_bucket.test_bucket.name
}
