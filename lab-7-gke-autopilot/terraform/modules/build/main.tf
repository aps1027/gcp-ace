resource "google_cloudbuild_trigger" "api_gateway" {
  name            = "api-gateway-trigger"
  description     = "Trigger for building and pushing API Gateway image to Artifact Registry"
  project         = var.project_id
  location        = var.region
  service_account = google_service_account.cloudbuild.id

  github {
    owner = var.github_owner
    name  = var.github_repo
    push {
      branch = var.trigger_branch
    }
  }

  included_files = [
    "lab-7-gke-autopilot/backend/**",
    "lab-7-gke-autopilot/cicd/cloudbuild-api-gateway.yaml"
  ]

  filename = "lab-7-gke-autopilot/cicd/cloudbuild-api-gateway.yaml"

  substitutions = {
    _PROJECT_ID   = var.project_id
    _REGION       = var.region
    _CLUSTER_NAME = var.cluster_name
    _CLUSTER_ZONE = var.cluster_zone
  }
}

resource "google_cloudbuild_trigger" "auth_ms" {
  name        = "auth-ms-trigger"
  description = "Trigger for building and pushing Auth MS image to Artifact Registry"

  project         = var.project_id
  location        = var.region
  service_account = google_service_account.cloudbuild.id

  github {
    owner = var.github_owner
    name  = var.github_repo

    push {
      branch = var.trigger_branch
    }
  }

  included_files = [
    "lab-7-gke-autopilot/backend/**",
    "lab-7-gke-autopilot/cicd/cloudbuild-auth-ms.yaml"
  ]

  filename = "lab-7-gke-autopilot/cicd/cloudbuild-auth-ms.yaml"

  substitutions = {
    _PROJECT_ID   = var.project_id
    _REGION       = var.region
    _CLUSTER_NAME = var.cluster_name
    _CLUSTER_ZONE = var.cluster_zone
  }
}
