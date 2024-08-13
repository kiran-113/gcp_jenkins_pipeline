variable "project_id" {
  default = "my-first-gcp-instance-323404"

}

variable "credentials_file" {
  description = "The path to the service account JSON key file"
  type        = string
}

variable "region" {
  description = "The region to deploy the resources in"
  type        = string
  default     = "us-central1"
}