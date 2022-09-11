locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  account_name = local.environment_vars.locals.account_name
  account_id   = local.environment_vars.locals.gcp_account_id
  gcp_region   = local.environment_vars.locals.gcp_region
  gcs_location = local.environment_vars.locals.gcs_location
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  region = "${local.gcp_region}"
}
EOF
}

remote_state {
  backend = "gcs"
  config = {
    project = local.account_id
    bucket   = "${local.account_name}-terraform-state"
    prefix   = "${path_relative_to_include()}/terraform.tfstate"
    location = local.gcs_location
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = merge(
  local.environment_vars.locals,
)
