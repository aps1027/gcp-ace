module "apis" {
  source = "./modules/apis"

  project_id = var.project_id
}

module "artifact" {
  source = "./modules/artifact"

  project_id = var.project_id
  region     = var.region

  depends_on = [module.apis]
}

module "build" {
  source = "./modules/build"

  project_id     = var.project_id
  region         = var.region
  github_owner   = var.github_owner
  github_repo    = var.github_repo
  trigger_branch = var.trigger_branch
  cluster_name   = var.cluster_name
  cluster_zone   = var.region

  depends_on = [module.apis]
}

module "vpc" {
  source = "./modules/vpc"

  project_id = var.project_id
  region     = var.region

  depends_on = [module.apis]
}

module "gke" {
  source = "./modules/gke"

  project_id          = var.project_id
  region              = var.region
  cluster_name        = var.cluster_name
  network_name        = module.vpc.network_name
  subnet_name         = module.vpc.subnet_name
  pod_range_name      = module.vpc.pods_range_name
  services_range_name = module.vpc.services_range_name

  depends_on = [module.apis, module.vpc]
}
