#!/bin/sh
#Set key pair used to access instance, to be used by ansible
SUBSCRIPTION="personal"
AZ_REGION="northeurope"
KEY_NAME=$SUBSCRIPTION"-"$AZ_REGION
PEM_LOCATION="$HOME/.az/pem/$KEY_NAME.pem"

# Sets service principal available to terraform to use for provisioning resource in azure through setting environment variables
for var in ARM_CLIENT_ID ARM_CLIENT_SECRET ARM_SUBSCRIPTION_ID ARM_TENANT_ID
do
        export ${var}=$(cat ~/.sp/$var)
done

# Sets location if dynamic inventory file
DYNAMIC_INVENTORY="$HOME/inventory/azure_rm.py"

# Sets location of terraform state file
export TFSTATE_FILE="$BASEDIR/src/terraform/terraform.tfstate"

# Runs ansible
ansible-playbook -i ./src/ansible/inventory.azure_rm.yml ./src/ansible/jenkins_start.yml \
--user "azure_user" \
--key-file "$PEM_LOCATION"
