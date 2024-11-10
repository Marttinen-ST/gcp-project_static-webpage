resource "google_storage_bucket" "static_website" {
  name          = var.hosting_bucket
  location      = var.gcp_region
  force_destroy = false
  storage_class = "STANDARD"

  versioning {
    enabled = true
  }

  uniform_bucket_level_access = true
}

# Upload a simple index.html page to the bucket
resource "google_storage_bucket_object" "indexpage" {
  name         = "index.html"
  content      = "<html><body>Hello World!</body></html>"
  content_type = "text/html"
  bucket       = google_storage_bucket.static_website.id
}

# Upload a simple 404 / error page to the bucket
resource "google_storage_bucket_object" "errorpage" {
  name         = "404.html"
  content      = "<html><body>404!</body></html>"
  content_type = "text/html"
  bucket       = google_storage_bucket.static_website.id
}