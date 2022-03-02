terraform {
  source        = "git::git@github.com:Infinite-Limit-Data-Science-LLC/aws-bootstrap.git//infrastructure//data-sources?ref=v1.1"
}

inputs = {
  terragrunt_role = "account-terragrunt"
  kms_key_alias   = "alias/account-hipaa-kms-key"
}