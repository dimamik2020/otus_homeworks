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

resource "google_compute_address" "db_internal_ip" {
  name         = "db-internal-ip"
  address_type = "INTERNAL"

}


module "app" {
  source           = "../modules/app"
  public_key_path  = var.public_key_path
  zone             = var.zone
  app_disk_image   = var.app_disk_image
  private_key_path = var.private_key_path
}

module "db" {
  depends_on      = [google_compute_address.db_internal_ip]
  source          = "../modules/db"
  public_key_path = var.public_key_path
  zone            = var.zone
  db_disk_image   = var.db_disk_image
  # Internal address for db module
  db_internal_ip  = google_compute_address.db_internal_ip.address

}

module "vpc" {
  source = "../modules/vpc"
  #not defined directly, so defaults used
  #source_ranges = ["194.6.231.130/32"]
}
