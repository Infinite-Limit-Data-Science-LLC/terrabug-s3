#!/bin/bash

echo "Executing apply-all for $env..."
terragrunt run-all plan --terragrunt-working-dir infrastructure