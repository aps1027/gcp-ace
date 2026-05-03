module "apis" {
  source = "./modules/apis"

  project_id = var.project_id
}

module "artifact" {
  source = "./modules/artifact"

  project_id = var.project_id
  region     = var.region
}

module "build" {
  source = "./modules/build"

  project_id = var.project_id
  region     = var.region
  github_owner = var.github_owner
  github_repo = var.github_repo
  trigger_branch = var.trigger_branch
}