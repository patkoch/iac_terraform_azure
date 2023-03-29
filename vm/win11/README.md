# Get started

Provisioning an Windows Virtual Machine using Terraform

Prerequisites:
 - [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
 - [Terraform](https://developer.hashicorp.com/terraform/downloads)
 - [Git (for Windows)](https://gitforwindows.org/)

## Login to your Azure Subscription with Azure CLI

At first, login to your Azure subscription by opening e.g.: a PowerShell prompt and conduct following command:

```
az login
```

A browser session will be opened, simply enter the credentials for your account.
Ensure, that the desired subscription is properly set by applying following:

```
az account show
```

## Clone this repository

Clone this repository by 

```
git clone https://github.com/patkoch/iac_terraform_azure.git"
```

After cloning the repository, switch to the directory "iac_terraform_azure/vm/win10-sg"

# Provisioning and destroying the resources with Terraform

## Creating the Windows 11 Virtual Machine with Terraform

Conduct the initialization with:

```
terraform init
```

This will establish a connection to the backend.

After that, run:

```
terraform validate
```

This validates the configuration file.

Finally, for creating the Virtual Machine, run following command:

```
terraform apply -auto-approve
```

This provisions a Windows Virtual Machine in your *Azure* subscription.
