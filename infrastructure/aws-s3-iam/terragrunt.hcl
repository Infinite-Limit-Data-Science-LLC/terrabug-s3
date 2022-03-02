include {
  path = find_in_parent_folders()
}

include "env" {
  path      = "${get_terragrunt_dir()}/../_env/bootstrap.hcl"
}

terraform {
  source = "git::git@github.com:Infinite-Limit-Data-Science-LLC/aws-s3-terrabug.git//infrastructure//iam"
}

locals {
  settings_default    = yamldecode(file("../settings-defaults.yml"))
  policy_env          = yamldecode( file("./policy-${lower(get_env("env", ""))}.yml") )
  settings            = merge(
    local.settings_default,
    local.policy_env,
  )
}

inputs = merge(
  # dependency.account_settings.outputs,
  {
    # region = "us-east-1"
  },
  local.settings,
)