#!/bin/sh
#Set key pair used to access instance, to be used by ansible
SUBSCRIPION="personal"
AZ_REGION="north-europe"
KEY_NAME=$SUBSCRIPTION"_"$AZ_REGION
PEM_LOCATION="$HOME/.az/pem/$KEY_NAME.pem"

# Sets service principal available to terraform to use for provisioning resource in azure through setting environment variables
for var in ARM_CLIENT_ID ARM_CLIENT_SECRET ARM_SUBSCRIPTION_ID ARM_TENANT_ID
do
        export ${v}=$(cat ~/.sp/$v)
done

# Sets location if dynamic inventory file
DYNAMIC_INVENTORY="$HOME/dynamic_inventory/azure_rm.py"

# Sets location of terraform state file
export TFSTATE_FILE="$BASEDIR/src/terraform/terraform.tfstate"

# Runs ansible
ansible-playbook -i "$DYNAMIC_INVENTORY" ./src/ansible/jenkins_start.yml \
        # Set the default user on the target servers for ansible to run as
        --user "azureuser" \
        --key-file "$PEM_LOCATION"
