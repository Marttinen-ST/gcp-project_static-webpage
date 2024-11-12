resource "google_compute_global_address" "lb_ip" {
  name = "lb-ip"
}

resource "google_compute_backend_bucket" "bucket_backend" {
  name        = "bucket-backend"
  bucket_name = var.hosting_bucket
}

resource "google_compute_url_map" "bucket_url_map" {
  name            = "bucket-url-map"
  default_service = google_compute_backend_bucket.bucket_backend.self_link
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.bucket_url_map.self_link
}

resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  name                  = "http-rule"
  target                = google_compute_target_http_proxy.http_proxy.self_link
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = google_compute_global_address.lb_ip.address
}