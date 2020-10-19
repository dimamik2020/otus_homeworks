resource "google_compute_instance" "app" {
  name         = "reddit-app-terraformed"
  machine_type = "f1-micro"
  zone         = var.zone
  tags         = ["reddit-app"]
  labels       = { instance_label = var.instance_label }

  metadata = {
    # путь до публичного ключа
    ssh-keys       = "Dima:${file(var.public_key_path)}"
    startup-script = "echo 'export DATABASE_URL=${var.db_internal_ip}:27017' > /etc/profile.d/db_ip_set.sh && sudo systemctl restart puma"
  }
  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = var.app_disk_image
    }

  }
  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"
    # использовать ephemeral IP для доступа из Интернет
    access_config {
      nat_ip = google_compute_address.app_ip.address

    }
  }

  connection {
    host  = google_compute_instance.app.network_interface.0.access_config.0.nat_ip
    type  = "ssh"
    user  = "Dima"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }


  # UNMUTABLE

  # provisioner "file" {
  #   source      = "../packer/puma.service"
  #   destination = "/tmp/puma.service"
  # }
  # provisioner "remote-exec" {
  #   script = "files/deploy.sh"
  # }

}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

