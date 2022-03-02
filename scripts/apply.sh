#!/bin/bash

echo "Executing apply-all for $env..."
terragrunt run-all apply --terragrunt-working-dir infrastructure --terragrunt-non-interactive -auto-approve