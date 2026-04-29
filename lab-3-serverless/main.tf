# --- CLOUD RUN SECTION ---

# 1. Service Account for the Cloud Run service itself
resource "google_service_account" "run_sa" {
  account_id   = "cloud-run-processor-sa"
  display_name = "Cloud Run Processor SA"
}

# 2. Deploy Cloud Run Service
resource "google_cloud_run_v2_service" "processor" {
  name     = "audio-processor"
  location = var.region

  template {
    service_account = google_service_account.run_sa.email
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
  depends_on = [google_project_service.run]
}

# --- PUB/SUB SECTION (The Trigger) ---

# 3. Create a Pub/Sub Topic
resource "google_pubsub_topic" "uploads" {
  name       = "audio-uploads"
  depends_on = [google_project_service.pubsub]
}

# 4. SA for Pub/Sub to PUSH to Cloud Run
resource "google_service_account" "pubsub_invoker" {
  account_id = "pubsub-invoker-sa"
}

# 5. Give Pub/Sub permission to "Invoke" Cloud Run (Q15 Logic)
resource "google_cloud_run_v2_service_iam_member" "allow_pubsub_invoke" {
  name     = google_cloud_run_v2_service.processor.name
  location = google_cloud_run_v2_service.processor.location
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.pubsub_invoker.email}"
}

# 6. Create the PUSH Subscription
resource "google_pubsub_subscription" "push_sub" {
  name  = "audio-processor-sub"
  topic = google_pubsub_topic.uploads.name

  push_config {
    push_endpoint = google_cloud_run_v2_service.processor.uri
    oidc_token {
      service_account_email = google_service_account.pubsub_invoker.email
    }
  }
}

# --- IMPERSONATION SECTION (Q3 Logic) ---

# 7. Allow YOU to impersonate the Cloud Run SA (Token Creator role)
resource "google_service_account_iam_member" "allow_impersonation" {
  service_account_id = google_service_account.run_sa.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "user:${var.admin_email}"
}

# Give the SA permission to publish to the topic
resource "google_pubsub_topic_iam_member" "sa_publisher" {
  topic  = google_pubsub_topic.uploads.name
  role   = "roles/pubsub.publisher"
  member = "serviceAccount:${google_service_account.run_sa.email}"
}
