# Get started

Provisioning an Windows Virtual Machine using Terraform

Prerequisites:
 - Azure CLI
 - Terraform

## Login to your Azure Subscription with Azure CLI

At first, login to your Azure subscription using following command:

```
az login
```

Esnure, that your subscription is properly set by applying:

```
az account show
```

## Creating the Windows Virtual Machine with Terraform

After cloning the repository, start, e.g.: PowerShell and switch to the directory "iac_terraform_azure/vm/win10-sg"

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
