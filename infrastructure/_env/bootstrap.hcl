dependency "account_settings" {
  config_path     = "../account-settings"

  # TODO: bug is where I have to put the actual account id instead of a fake one: 111111111111. I should be able to put a fake one and then when I run apply, it should fetch the real kms_key_id_primary that's stored in outputs of the aws-bootstrap project
  mock_outputs  = {
    aws_iam_role          = "account-terragrunt"
    kms_key_id_primary   = "arn:aws:kms:us-east-1:111111111111:key/e80ba519-a16b-458a-9807-798191d06df8"
    kms_key_id_secondary = "arn:aws:kms:us-west-2:111111111111:key/f7dbdff3-e2ed-48e5-a7c5-c6e9d10c8a35"
  }

  #TODO: bug is I have to use the mock_outputs for apply command too since apply is not fetching the real outputs
  # mock_outputs_allowed_terraform_commands = ["validate", "plan"]   
}