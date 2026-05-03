variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "github_owner" {
  description = "GitHub Owner"
  type        = string
}

variable "github_repo" {
  description = "GitHub Repository"
  type        = string
}

variable "trigger_branch" {
  description = "Branch to trigger Cloud Build on"
  type        = string
}

variable "cluster_name" {
  description = "GKE cluster name - passed as _CLUSTER_NAME substitution"
  type        = string
}

variable "cluster_zone" {
  description = "GKE cluster zone - passed as _CLUSTER_ZONE substitution"
  type        = string
}
