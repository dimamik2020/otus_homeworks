terraform {
  backend "gcs" {
    bucket = "tf-state-qwipeojowpeiroweifhsdlfkml"
    prefix = "prod"
  }
}
