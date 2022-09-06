
locals {
  is_windows = substr(pathexpand("~"), 0, 1) == "/" ? false : true
}

resource "null_resource" "script" {
  provisioner "local-exec" {
    command = <<EOT
    docker build -t "${var.project_name}" .
    docker tag "${var.project_name}" "gcr.io/${var.project_id}/${var.project_name}:latest"
    docker push "gcr.io/${var.project_id}/${var.project_name}:latest"
EOT

    working_dir = "Go-container"
    interpreter = local.is_windows ? ["PowerShell", "-Command"] : []
  }
}
