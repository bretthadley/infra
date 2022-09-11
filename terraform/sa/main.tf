module "service_accounts" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 3.0"
  project_id    = "<PROJECT ID>"
  prefix        = "test-sa"
  names         = ["first", "second"]
  project_roles = [
    "project-foo=>roles/viewer",
    "project-spam=>roles/storage.objectViewer",
  ]
}