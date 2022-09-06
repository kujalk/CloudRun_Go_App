output "app_url_location1" {
  value = google_cloud_run_service.go_app_1.status[0].url
}

output "app_url_location2" {
  value = google_cloud_run_service.go_app_2.status[0].url
}

output "glb_url" {
  value = google_compute_global_address.glb.address
}