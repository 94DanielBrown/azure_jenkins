#!/bin/sh
cd ./src/terraform
terraform destroy --auto-approve
rm terraform.{plan,*tfstate*} &>/dev/null
