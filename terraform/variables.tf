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
