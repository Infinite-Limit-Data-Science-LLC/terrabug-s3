## Steps to reproduce the issue:

1) Confirm it works without Terragrunt. In aws-s3-terrabug, visit examples/basic-usage and manually run terraform int and terraform apply. Notice it creates a bucket and replication bucket with SSE-KMS, Public Acces blocked and Replication Rule created. 
2) Now in this terrabug repo, run the following:

```bash
./scripts/apply.sh
```

This will yield the following errors:


│ Error: Error putting S3 replication configuration: InvalidArgument: Invalid ReplicaKmsKeyID ARN.
│       status code: 400, request id: 7WPMAEAH5Y0574QT, host id: aNZfserXWz0dPHvZCDMYFDXOyRHVux9+WAxUxSDFiw109X0uOY7vXchm7cWL4lwX0+VqzPNqexE=
│ 
│   with module.bucket.aws_s3_bucket.mybucket,
│   on s3/main.tf line 1, in resource "aws_s3_bucket" "mybucket":
│    1: resource "aws_s3_bucket" "mybucket" {

The error appears to be that it is using mock_outputs of kms_key_id_primary and kms_key_id_secondary of account-settings module during apply. Instead, during apply, it should be using the actual values of kms_key_id_primary and kms_key_id_secondary.

