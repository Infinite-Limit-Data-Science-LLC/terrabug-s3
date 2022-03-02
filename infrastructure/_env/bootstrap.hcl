dependency "account_settings" {
  config_path     = "../account-settings"

  mock_outputs  = {
    aws_iam_role          = "account-terragrunt"
    kms_key_arn_primary   = "arn:aws:kms:us-east-1:111111111111:key/e80ba519-a16b-458a-9807-798191d06df8"
    kms_key_arn_secondary = "arn:aws:kms:us-west-2:111111111111:key/f7dbdff3-e2ed-48e5-a7c5-c6e9d10c8a35"
  }

  # mock_outputs_allowed_terraform_commands = ["validate", "plan"]   
}