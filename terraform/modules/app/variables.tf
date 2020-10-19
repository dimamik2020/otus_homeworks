variable "zone" {
  # Zone for resources
  default = "europe-west2-c"
}
variable "app_disk_image" {
  description = "Disk image for reddit app"
  default = "app-reddit-base"
}

variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable "private_key_path" {
  # private key path
  description = "Path to private key"
}

variable "db_internal_ip" {
  description = "Database internal IP"
}

variable "instance_label"{
  description = "Label for instance to select group of instances"
  default = "reddit"
}
