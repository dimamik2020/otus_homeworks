provider "google" {
  project = var.project
  region  = var.region
}
locals {
  timestamp = formatdate("YYYYMMDDhhmmss", timestamp())

}
module "storage-bucket" {
  source  = "./modules/storage-bucket"
  # insert the 1 required variable here
#####  dbucket_name = "${var.project}_${local.timestamp}"
  bucket_name = "tf-state-qwipeojowpeiroweifhsdlfkml"
}
