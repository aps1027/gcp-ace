data "google_project" "project" {
  project_id = var.project_id
}

# Autopilot nodes run as the default Compute Engine SA — grant it Artifact Registry read access
# so pods can pull images. In Standard mode this was done via a custom node SA; Autopilot has no custom node SA.
resource "google_project_iam_member" "autopilot_node_artifact_registry_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}
