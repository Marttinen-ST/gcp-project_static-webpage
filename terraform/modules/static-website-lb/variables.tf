variable "hosting_bucket" {
  description = "Bucket name that will host the static website"
  type = string
}

variable "gcp_region" {
  description = "Region to where terraform will deploy to"
  type        = string
}