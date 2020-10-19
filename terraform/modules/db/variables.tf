variable "zone" {
  # Zone for resources
  default = "europe-west2-c"
}
variable "db_disk_image" {
  description = "Disk image for reddit db"
  default = "db-reddit-base"
}
variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "db_internal_ip" {
  description = "Database internal IP"
}

variable "instance_label" {
description = "Label for instance to group instances"



}
