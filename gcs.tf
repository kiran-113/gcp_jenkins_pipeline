resource "google_storage_bucket" "my_bucket" {
  name                        = "my-gcs-bucket-5247851"
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
}