# Get started

Provisioning an Azure Kubernetes Cluster with a Windows Node Pool using a Terraform configuration

For a more detailed manual please see the related blog post:

https://www.patrickkoch.dev/posts/post_23/

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

## Provisioning the Azure Kubernetes Cluster

Start, e.g.: PowerShell and switch to the directory of the file "aks.tf".

Initialize by using:

```
terraform init
```

This will establish a connection to the backend.

After that, run:

```
terraform validate
```

to validate the configuration file.

Finally, for conducting the provisioning part, run:

```
terraform apply
```

This should provision the Azure Kubernetes Cluster in your Azure subscription.
