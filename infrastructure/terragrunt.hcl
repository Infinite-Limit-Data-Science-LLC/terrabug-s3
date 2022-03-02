remote_state {
  backend     = "s3"
  generate    = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config      = {
    bucket          = get_env("STATE_BUCKET", "")
    key             = "${path_relative_to_include()}/terraform.tfstate"
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