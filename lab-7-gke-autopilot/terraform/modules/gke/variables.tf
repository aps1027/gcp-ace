variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region — Autopilot clusters are always regional"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "Name of the GKE Autopilot cluster"
  type        = string
  default     = "gke-autopilot"
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "pod_range_name" {
  description = "Name of the pods secondary IP range"
  type        = string
}

variable "services_range_name" {
  description = "Name of the services secondary IP range"
  type        = string
}
