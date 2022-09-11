terraform {
  source = "tfr://GoogleCloudPlatform/sql-db/google//modules/postgresql?version=12.0.0"
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