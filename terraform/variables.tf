variable "cloud_id" {
  description = "Cloud ID"
}
variable "folder_id" {
  description = "Folder ID"
}
variable "service_account_key" {
  description = "Service account key file"
}
variable "zone" {
  description = "Zone"
  default = "ru-central1-a"
}
variable "image_id" {
  description = "Image_id"
}
variable "subnet_id" {
  description = "Subnet_id"
}
variable "public_key_path" {
  description = "Connection public key file"
}
variable "private_key_path" {
  description = "Connection private key file"
}
variable "region_id" {
  description = "Region"
  default     = "ru-central1"
}
variable "instances_count" {
  description = "Count instances"
  default     = 1
}
variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable "db_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-db-base"
}
variable "bucket_name" {
  description = "S3 Bucket name"
}
variable "access_key" {
  description = "Access key for s3 bucket"
}
variable "secret_key" {
  description = "Secret key for s3 bucket"
}
