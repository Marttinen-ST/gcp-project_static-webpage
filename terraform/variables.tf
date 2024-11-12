variable "project_id" {
  description = "Google Prject ID"
  type        = string
  default     = "long-sum-441213-v5"
}

variable "gcp_region" {
  description = "Region to where terraform will deploy to"
  type        = string
  default     = "us-central1"
}

variable "hosting_bucket" {
  description = "Bucket name that will host the static website"
  type        = string
  default     = "rga-test-website-host"
}