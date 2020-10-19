variable "project" {
  description = "Project ID"
}
variable "region" {
  description = "Region"
  # Значение по умолчанию
  default = "europe-west2"
}
variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable "disk_image" {
  description = "Disk image"
}

variable "zone" {
  # Zone for resources
  default = "europe-west2-c"
}

variable "private_key_path" {
  # private key path
  description = "Path to private key"
}

variable "instance_count" {
  #number of instances
  default = "2"

}

variable "app_disk_image" {
description = "Disk image for reddit app"
default = "app-reddit-base"
}

variable "db_disk_image" {
  description = "Disk image for reddit db"
  default = "db-reddit-base"
}

variable "instance_label"{
  description = "Label for instance to select group of instances"
  default = "reddit"
}
