remote_state {
  backend     = "s3"
  generate    = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  # the addition of infrastructure/get_env('env') in the config below is critical!!!!
  # First, if we do not specify get_env('env'), then our different environments like
  # sandbox-test and tst will overwrite each other since the terraform remote state
  # for all environments would be stored at the same object level in s3!!!!!!
  # in other words, scrapetorium-terraform-state/aws-s3-iam would be the bucket path
  # for both tst and sandbox-test. Instead we want different environments stored in
  # separate folders so they do not overwrite each other. We want:
  # scrapetorium-terraform-state/sandbox-test/infrastructure/aws-s3-iam
  # scrapetorium-terraform-state/tst/infrastructure/aws-s3-iam
  config      = {
    bucket          = get_env("STATE_BUCKET", "")
    key             = "${get_env("env")}/infrastructure/${path_relative_to_include()}/terraform.tfstate"
    region          = "us-east-1"
    encrypt         = true
    dynamodb_table  = get_env("STATE_LOCK_TABLE", "")
  }
}

generate "providers" {
  path            = "providers_override.tf"
  if_exists       = "overwrite_terragrunt"
  contents        = <<EOF
    provider "aws" {
      region      = "us-east-1"

      assume_role {
        role_arn  = "arn:aws:iam::975474249947:role/account-terragrunt"
      }
    }
  EOF
}

generate "versions" {
  path      = "versions_override.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    terraform {
      required_providers {
        aws = {
          version = "= 3.74.1"
          source = "hashicorp/aws"
        }
      }
    }
EOF
}