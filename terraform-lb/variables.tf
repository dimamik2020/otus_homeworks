variable "project" {
  description = "Project ID"
}
variable "region" {
  description = "Region"
  # Значение по умолчанию
  default = "europe-west1"
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
  default = "europe-west1-c"
}

variable "private_key_path" {
  # private key path
  description = "Path to private key"
}

variable "instance_count" {
  #number of instances
  type = number
  default = 3

}
