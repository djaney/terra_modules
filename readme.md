# Some terraform modules to make life easier

Just look at the modules and inspect `variables.tf` and `outputs.tf` for input and output

## network/vpc
Simple VPC setup.
Add internet gateways
Create subnet for each AZ.

## network/fck_nat
Setup NAT using ec2 instances with fcknat framework.
Add routing tables pointing to NAT instances

## storage/rds_instance
Simple RDS instance.
If instance is re-created by terraform, it will automatically load data from previous instance.
Heavily inspired by https://dev.to/stack-labs/restore-aws-rds-snapshots-using-terraform-1ffi

## ECS

### ECS cluster (TODO)
Infrastructure where to run your tasks

### ECS Task (TODO)
Instructions on what containers to run. Can run multiple containers in 1 task

### ECS Service (TODO)
Optional ontroller for tasks. Makes sure the required minimum tasks instances are running.

This is optional. Tasks without a service are useful for scheduled operations.

