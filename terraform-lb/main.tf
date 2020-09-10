terraform {
  # Версия terraform
  #  required_version = "0.11.11"
}
provider "google" {
  # Версия провайдера
  #  version = "2.0.0"
  # ID проекта
  project = var.project
  region  = var.region
}

resource "google_compute_instance" "app" {
  count        = var.instance_count
  name         = "reddit-app-terraformed-${count.index + 1}"
  machine_type = "f1-micro"
  zone         = var.zone
  tags         = ["reddit-app", "allow-health-check"]

  metadata = {
    # путь до публичного ключа
    ssh-keys = "Dima:${file(var.public_key_path)}"

  }
  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = var.disk_image
    }

  }
  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"
    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }

  connection {
    ## !!! Ссылки через self при наличии count !!!
    ##    host  = google_compute_instance.app[count.index].network_interface.0.access_config.0.nat_ip - так работать не будет!
    ## Expressions in connection blocks cannot refer to their parent resource by name. Instead, they can use the special self object.
    host  = self.network_interface.0.access_config.0.nat_ip
    type  = "ssh"
    user  = "Dima"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }


  ## Мы ж предполагаем immutable, так-что без provisioner
  # provisioner "file" {
  #   source      = "../packer/puma.service"
  #   destination = "/tmp/puma.service"
  # }
  # provisioner "remote-exec" {
  #   script = "files/deploy.sh"
  # }

}

## Создаёт группу и добавляет инстансы
resource "google_compute_instance_group" "app-group" {
  name        = "reddit-app-group"
  description = "reddit app group"

  instances = [
    for i in google_compute_instance.app[*].id :
    i
  ]

  named_port {
    name = "http"
    port = "9292"
  }

  zone = var.zone
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"
  # Название сети, в которой действует правило
  network = "default"
  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]
  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}
resource "google_compute_firewall" "firewall_allow_health_check" {
  name    = "allow-health-check"
  network = "default"
  allow {
    protocol = "tcp"
  }
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["allow-health-check"]
}

resource "google_compute_address" "lb_address" {
  name   = "ipv4-address"
  region = var.region
}

resource "google_compute_health_check" "http_health_check" {
  name = "http-health-check"

  timeout_sec        = 1
  check_interval_sec = 1

  http_health_check {
    port = 9292
  }
}

resource "google_compute_backend_service" "backend_service" {
  name          = "backend-service"
  health_checks = [google_compute_health_check.http_health_check.id]
  protocol      = "HTTP"
  port_name     = "http"

  backend {
    group           = google_compute_instance_group.app-group.id
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

resource "google_compute_url_map" "urlmap" {
  name            = "urlmap"
  default_service = google_compute_backend_service.backend_service.id
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.urlmap.id
}

resource "google_compute_global_forwarding_rule" "global_forwarding_rule" {
  name       = "global-forwarding-rule"
  target     = google_compute_target_http_proxy.http_proxy.id
  port_range = "9292"
  ip_address = google_compute_address.lb_address.address
}
