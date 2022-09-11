resource "google_service_account" "sa" {
  project    = var.project_id
  account_id = var.sa_name
}

resource "google_project_iam_member" "project" {
  project = var.project_id
  for_each = toset(var.sa_roles)
  role = each.key
  member  = "serviceAccount:${google_service_account.sa.email}"
}

module "oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = var.project_id
  pool_id     = "github"
  provider_id = "infra"
  sa_mapping = {
    (google_service_account.sa.account_id) = {
      sa_name   = google_service_account.sa.name
      attribute = "attribute.aud/https://github.com/unlevelltd"
    }
  }
}