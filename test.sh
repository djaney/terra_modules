#!/usr/bin/env bash
cd tests
terraform init -backend=false
terraform validate
terraform test