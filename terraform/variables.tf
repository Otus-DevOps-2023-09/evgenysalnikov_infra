variable "service_account_key_file" {
  description = "key.json"
}
variable "cloud_id" {
  description = "Cloud"
}
variable "folder_id" {
  description = "Folder"
}
variable "zone" {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable "service_account_id" {
  description = "Service account id"
  type        = string
}
variable "buckets" {
  description = "List of buckets params"
  type = map(object({
    access_key = string
    secret_key = string
  }))
  default = {
    "stage" = {
      access_key = "stage_access_key"
      secret_key = "stage_secret_key"
    }
    "prod" = {
      access_key = "prod_access_key"
      secret_key = "prod_secret_key"
    }
  }
}
