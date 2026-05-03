variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "gke-vpc"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "gke-subnet"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.0.0/20"
}

variable "pods_cidr" {
  description = "CIDR block for the pods"
  type        = string
  default     = "10.48.0.0/14"
}

variable "services_cidr" {
  description = "CIDR block for the services"
  type        = string
  default     = "10.52.0.0/20"
}
