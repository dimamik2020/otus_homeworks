terraform {
  # Версия terraform
  #  required_version = "0.11.11"
}
provider "google" {
  # Версия провайдера
  #  version = "2.0.0"
  # ID проекта
  project = "otus-hometasks"
  region  = "europe-west-2"
}
resource "google_compute_instance" "app" {
  name         = "reddit-app-terraformed"
  machine_type = "f1-micro"
  zone         = "europe-west2-c"
  metadata = {
    # путь до публичного ключа
    ssh-keys = "Dima:${file("~/.ssh/id_rsa.pub")}"
  }
  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "reddit-base"
    }
  }
  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"
    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }
}
