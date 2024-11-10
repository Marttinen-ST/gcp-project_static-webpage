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
