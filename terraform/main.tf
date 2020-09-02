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
  name         = "reddit-app-terraformed"
  machine_type = "f1-micro"
  zone         = var.zone
  tags         = ["reddit-app"]

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
    host  = google_compute_instance.app.network_interface.0.access_config.0.nat_ip
    type  = "ssh"
    user  = "Dima"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }



  provisioner "file" {
    source      = "../packer/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }



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
