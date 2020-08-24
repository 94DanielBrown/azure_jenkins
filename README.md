# azure_jenkins
Jenkins IaaC on azure  

## Requirements
Ansible  
Terraform  
Python and install the libraries; msrest msrestazure and azure-cli
Unix shell  
Azure CLI

## Usage

In order for the dynamic inventory to work you need to install the relevant python modules listed above and have logged into azure via the cli
Before first use initialise terraform modules with ./init_terraform.sh

## RUN (run.sh)  
Brings up infrastructure in AWS and configures it with ansible so it is a functioning jenkins server.  
### Service Principal  
Terraform uses a service principal to provision infrastructure, a folder ~/.sp should be made with the following files:  
ARM_CLIENT_ID  
ARM_CLIENT_SECRET  
ARM_SUBSCRIPTION_ID  
ARM_TENANT_ID  
These files should then contain the relevant information relating to a service principal, the run script exposes the contents as env vars for terraform to use.
### Key location
Private key location from key pair added to server and used by ansible is set in vars here and should be changed.  
If keys are stored in **$home/.az/pem/** and use the form **subscription-region.pem** then just change the **SUBSCRIPTION** and **AZ_REGION** variables
### Users ssh access
A user dbrown is currenly added, remove this user and add others in: **src/ansible/roles/users/defaults/main.yml** with the users public keys in  
**/src/ansible/roles/users/files/username** e.g a file **/src/ansible/roles/users/files/dbrown** contains dbrowns public key
### Terraform vars  
Terraform which may require changing changong such as the allowed ip range for the security group are set in:  
**src/terraform/terraform.tfvars**

## CLEAN (clean.sh)
 Brings down infrastructure and removes leftover terraform config files  
 Should also be used after a failed deployment attempt
