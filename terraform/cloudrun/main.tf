module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "~> 0.2.0"

  # Required variables
  service_name           = "<SERVICE NAME>"
  project_id             = "<PROJECT ID>"
  location               = "<LOCATION>"
  image                  = "gcr.io/cloudrun/hello"
}