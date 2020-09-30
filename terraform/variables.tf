variable "project" {
  description = "Project ID"
}
variable "region" {
  description = "Region"
  # Значение по умолчанию
  default = "europe-west2"
}
variable "zone" {
  # Zone for resources
  default = "europe-west2-c"
}

