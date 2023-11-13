terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  for_each           = var.buckets
  service_account_id = var.service_account_id
  description        = "${each.key}-service-account-key"
}

resource "yandex_storage_bucket" "bucket" {
  for_each      = var.buckets
  bucket_prefix = "${each.key}-"
  force_destroy = true
  access_key    = yandex_iam_service_account_static_access_key.sa-static-key[each.key].access_key
  secret_key    = yandex_iam_service_account_static_access_key.sa-static-key[each.key].secret_key
}
