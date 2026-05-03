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
  description = "Name of the GKE cluster"
  type        = string
  default     = "gke-autopilot"
}