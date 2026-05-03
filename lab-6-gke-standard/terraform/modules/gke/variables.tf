variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-central1-a"
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "gke-cluster"
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

variable "node_count" {
  description = "Number of nodes in the node pool"
  type        = number
  default     = 2
}

variable "node_min_count" {
  description = "Minimum number of nodes in the node pool"
  type        = number
  default     = 1
}

variable "node_max_count" {
  description = "Maximum number of nodes in the node pool"
  type        = number
  default     = 3
}

variable "machine_type" {
  description = "Machine type for the nodes"
  type        = string
  default     = "e2-medium"
}

variable "disk_size_gb" {
  description = "Size of the disk attached to each node"
  type        = number
  default     = 50
}
