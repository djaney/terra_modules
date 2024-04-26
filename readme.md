# Some terraform modules to make life easier

Just look at the modules and inspect `variables.tf` and `outputs.tf` for input and output

## vpc
Simple VPC setup.
Create subnet for each AZ.
Add Fcknat for all private subnets.

## rds_instance
Simple RDS instance.
If instance is re-created by terraform, it will automatically load data from previous instance.
Heavily inspired by https://dev.to/stack-labs/restore-aws-rds-snapshots-using-terraform-1ffi

