terraform {
  source = "tfr:///terraform-google-modules/cloud-storage/google//?version=3.3.0"
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env = local.environment_vars.locals.environment
}

inputs = {
  project_id  = "${local.environment_vars.locals.gcp_account_id}"
  location = "${local.environment_vars.locals.gcs_location}"
  names = ["raw-feeds"]
  prefix = "${local.environment_vars.locals.account_name}"
  versioning = {
    first = true
  }
}


gcloud iam service-accounts create "github-ci"
saId="github-ci@${projectId}.iam.gserviceaccount.com"

gitHubRepoName="bretthadley/infra"
gcloud iam service-accounts add-iam-policy-binding github@bretthadley-200914.iam.gserviceaccount.com \
  --role "roles/iam.workloadIdentityUser" \
  --member "principalSet://iam.googleapis.com/projects/74754352612/locations/global/workloadIdentityPools/default/attribute.repository/bretthadley/infra"