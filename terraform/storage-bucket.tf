provider "google" {
  project = var.project
  region  = var.region
}
locals {
  timestamp = formatdate("YYYYMMDDhhmmss", timestamp())

}
module "storage-bucket" {
  source  = "./modules/storage-bucket/"
  # insert the 1 required variable here
  bucket_name = "${var.project}_${local.timestamp}"

}
