provider "google" {
  project = var.project_id
  region  = var.gcp_region
}

terraform {
    backend "gcs" {
      bucket = "test-env-tfstate"
      prefix = "terraform/state"
    }
}

module "static-website-bucket" {
    source = "./modules/static-website-bucket"
    hosting_bucket = var.hosting_bucket
    gcp_region = var.gcp_region
}

module "static-website-lb" {
    source = "./modules/static-website-lb"
    hosting_bucket = var.hosting_bucket
    gcp_region = var.gcp_region
}