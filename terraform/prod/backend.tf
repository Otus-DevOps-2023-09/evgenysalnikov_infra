terraform {
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "prod-20231110142744905600000002"
    region = "ru-central1"
    key = "terraform_state/state/terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
