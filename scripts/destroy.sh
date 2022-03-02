#!/bin/bash

echo "Executing apply-all for $env..."
terragrunt run-all destroy --terragrunt-working-dir infrastructure --terragrunt-non-interactive -auto-approve