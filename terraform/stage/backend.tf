terraform {
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "stage-20231110142744905600000001"
    region = "ru-central1"
    key = "terraform_state/state/terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
