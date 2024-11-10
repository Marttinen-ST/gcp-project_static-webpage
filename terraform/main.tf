provider "google" {
  project = var.project_id
  region  = var.gcp_region
}

resource "google_storage_bucket" "tfstate-bucket" {
  name          = var.tfstate_bucket
  location      = var.gcp_region
  force_destroy = true
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
  uniform_bucket_level_access = true
}

terraform {
    backend "gcs" {
      bucket = "test-env-tfstate"
      prefix = "terraform/state"
      project = "long-sum-441213-v5"
    }
}
