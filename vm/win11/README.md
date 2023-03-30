# 1. Introduction

This is intended for those who would like to provision a Windows 11 Virtual Machine using Terraform.

# 2. Prerequisites
 - [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
 - [Terraform](https://developer.hashicorp.com/terraform/downloads)
 - [Git (for Windows)](https://gitforwindows.org/)

# 3. Preparing the environment

## 3.1 Login to your Azure Subscription with Azure CLI

At first, login to your Azure subscription by opening e.g.: a PowerShell prompt or opening a Terminal in Visual Studio Code and run:

```
az login
```

![alt text](pictures/00_az-login.png)

A browser session will be opened, enter the credentials for your account.
Ensure, that the desired subscription is properly set by applying:

```
az account show
```
In the output you should see your subscription of choice. In my case, I'm using my Visual Studio subscription:

![alt text](pictures/01_az-account-show.png)

## 3.2 Clone this repository

Clone this repository by running following git command:

```
git clone https://github.com/patkoch/iac_terraform_azure.git
```

After cloning it, switch to the directory "iac_terraform_azure/vm/win11"

# 4. Provisioning and destroying the resources with Terraform

## Storing the Terraform State File in Azure

This configuration stores the Terraform State File in Azure, this is defined in the file "providers.tf" by following block:

```
  backend "azurerm" {
    resource_group_name  = "devopsexperiences-storage"
    storage_account_name = "alien39"
    container_name       = "terraformstate"
    key                  = "terraform.tfstate"
  }
```

This refers to a Storage Account (named "alien39"), including a Container which finally contains the Terraform State File.

![alt text](pictures/09_storage_account.png)

This means, that this Storage Account is mandatory for this configuration. 

So, there are two options:

 - 1. Create a Storage Account with a name of your choice (don't forget to update the block in "providers.tf"), including a Container as storage for the Terraform State File 
 - 2. Deleter the block, shown in the snippet above, in that case the Terraform State File won't get stored in Azure, but locally. 

## Creating the Windows 11 Virtual Machine with Terraform

Conduct the initialization with following command:

```
terraform init
```
![alt text](pictures/02_terraform_init.png)

This will establish a connection to the backend.

After that, run:

```
terraform validate
```

![alt text](pictures/03_terraform_validate.png)

This validates the configuration file. The desired output can be seen in the picture above.

Formate your Terraform configuration by using:

```
terraform fmt
```

This takes care, that your files are formated properly. It will e.g. correct the shifting of your resource blocks.
If e.g. a resource block was shifted, then the command returns the name of the file, which contains the resource block.

E.g.:

![alt text](pictures/04_terraform_fmt.png)

Create a Terraform plan by running:

```
terraform plan -out tfplan
```

![alt text](pictures/05_terraform_plan.png)

This creates the file "tfplan". If the resources are getting created for the very first time, then the following command would be:

```
terraform apply tfplan
```

![alt text](pictures/06_terraform_apply.png)

This provisions a Windows 11 virtual machine in your *Azure* subscription by adding 9 resources:

![alt text](pictures/06_terraform_apply-complete.png)

Finally, the virtual machine is ready to use and is capable to be accessed with a remote desktop connection:

![alt text](pictures/07_azure_portal_vm.png)

Note:
Assume, the resources are already created and you would run following command again:

```
terraform plan -out tfplan
```

In that case you would get notified, that there are no changes:

![alt text](pictures/08_terraform_plan_vm_exitsts_already.png)


# References

[HashiCorp: Tutorials - Get Started - Azure](https://developer.hashicorp.com/terraform/tutorials/azure-get-started)