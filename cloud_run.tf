
resource "google_cloud_run_service" "go_app_1" {
  depends_on = [null_resource.script]
  name       = "${var.project_name}-location1"
  location   = var.location_1
  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = "3"
        "run.googleapis.com/client-name"   = "terraform"
      }
    }
    spec {
      containers {
        image = "gcr.io/${var.project_id}/${var.project_name}"

        env {
          name  = "region"
          value = var.location_1
        }
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }

}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth_1" {
  location = google_cloud_run_service.go_app_1.location
  project  = google_cloud_run_service.go_app_1.project
  service  = google_cloud_run_service.go_app_1.name

  policy_data = data.google_iam_policy.noauth.policy_data
}


resource "google_cloud_run_service" "go_app_2" {
  depends_on = [null_resource.script]
  name       = "${var.project_name}-location2"
  location   = var.location_2
  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = "3"
        "run.googleapis.com/client-name"   = "terraform"
      }
    }
    spec {
      containers {
        image = "gcr.io/${var.project_id}/${var.project_name}"

        env {
          name  = "region"
          value = var.location_2
        }
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }

}

resource "google_cloud_run_service_iam_policy" "noauth_2" {
  location = google_cloud_run_service.go_app_2.location
  project  = google_cloud_run_service.go_app_2.project
  service  = google_cloud_run_service.go_app_2.name

  policy_data = data.google_iam_policy.noauth.policy_data
}