resource "google_compute_global_address" "glb" {
  name = "${var.project_name}-global-ip"
}

resource "google_compute_global_forwarding_rule" "paas-monitor" {
  name       = "${var.project_name}-forwarding-rule"
  ip_address = google_compute_global_address.glb.address
  port_range = "80"
  target     = google_compute_target_http_proxy.glb.self_link
}

resource "google_compute_target_http_proxy" "glb" {
  name    = "${var.project_name}-http-proxy"
  url_map = google_compute_url_map.glb.self_link
}

resource "google_compute_url_map" "glb" {
  name            = "${var.project_name}-url"
  default_service = google_compute_backend_service.backend.self_link
}

resource "google_compute_region_network_endpoint_group" "cloudrun_neg_1" {
  name                  = "${var.project_name}-location-1"
  network_endpoint_type = "SERVERLESS"
  region                = var.location_1
  cloud_run {
    service = google_cloud_run_service.go_app_1.name
  }
}

resource "google_compute_region_network_endpoint_group" "cloudrun_neg_2" {
  name                  = "${var.project_name}-locaton-2"
  network_endpoint_type = "SERVERLESS"
  region                = var.location_2
  cloud_run {
    service = google_cloud_run_service.go_app_2.name
  }
}


resource "google_compute_backend_service" "backend" {
  name = "${var.project_name}-backend"

  protocol    = "HTTP"
  port_name   = "http"
  timeout_sec = 30

  backend {
    group = google_compute_region_network_endpoint_group.cloudrun_neg_1.id
  }

  backend {
    group = google_compute_region_network_endpoint_group.cloudrun_neg_2.id
  }

}