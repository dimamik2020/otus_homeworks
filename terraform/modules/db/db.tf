resource "google_compute_instance" "db" {
  name         = "reddit-db-terraformed"
  machine_type = "f1-micro"
  zone         = var.zone
  tags         = ["reddit-db"]
  labels       = { instance_label = var.instance_label }

  boot_disk {
    initialize_params {
      image = var.db_disk_image
    }
  }
  network_interface {
    network = "default"

    # internal_ip
    network_ip = var.db_internal_ip
    access_config {}
  }
  metadata = {
    # путь до публичного ключа
    ssh-keys = "Dima:${file(var.public_key_path)}"
  }
}
