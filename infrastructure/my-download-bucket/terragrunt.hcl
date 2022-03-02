include "root" {
  path      = find_in_parent_folders()
}

include "env" {
  path      = "${get_terragrunt_dir()}/../_env/bootstrap.hcl"
}

terraform {
  // --terragrunt-source-update after updating tag
  source          = "git::git@github.com:Infinite-Limit-Data-Science-LLC/aws-s3-terrabug.git//infrastructure"
}

dependency "aws_s3_iam" {
  config_path   = "../aws-s3-iam"
  
  mock_outputs  = {
    execution_role     = "terrabug-bucket-execution-role-mock"
    execution_role_arn = "arn:aws:iam::111111111111:role/terrabug-bucket-execution-role-mock"
  }

  # skip_outputs = true
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
    execution_role_arn          = dependency.aws_s3_iam.outputs.execution_role_arn
    kms_key_arn                 = dependency.account_settings.outputs.kms_key_arn_primary
    replication_kms_key_arn     = dependency.account_settings.outputs.kms_key_arn_secondary
    // kms_key_arn                 = "arn:aws:kms:us-east-1:975474249947:key/e80ba519-a16b-458a-9807-798191d06df8"
    // replication_kms_key_arn     = "arn:aws:kms:us-west-2:975474249947:key/f7dbdff3-e2ed-48e5-a7c5-c6e9d10c8a35"
    replication_enabled         = true
    replication_region          = "us-west-2"
  },
  local.settings,
)