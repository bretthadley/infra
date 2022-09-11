terraform {
  source = "../../../terraform//ocid"
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env = local.environment_vars.locals.environment
}

inputs = {
  project_id  = "${local.environment_vars.locals.gcp_account_id}"
  location = "${local.environment_vars.locals.gcs_location}"
  sa_name = "github-ci"
}