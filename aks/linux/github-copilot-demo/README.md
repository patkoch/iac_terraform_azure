# 1. Introduction

This example of a Terraform configuration file shows, which dedicated comments I have used for getting suggestions from the GitHub Copilot.
The goal was to create a final configuration file, which allows to deploy a Kubernetes cluster and an attached Container Registry on Azure.

For a more detailed manual please see the related blog post:

https://www.patrickkoch.dev/posts/post_31/

# 2. Prerequisites
 * [Visual Studio Code](https://code.visualstudio.com/) 
 * [GitHub Copilot Extension](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot) (see picture below)
 * [GitHub Copilot subscription](https://github.com/features/copilot)
 * [Terraform](https://www.terraform.io/)
 * [Azure subscription](https://azure.microsoft.com/en-us)


# 3. Get suggestions from GitHub Copilot and create the Terrafrom configuration file

Ensure that you have the GitHub Copilot extension installed:

<p align="center">
  <img src="pictures/github_copilot_aks_terraform_01.png" width="60%" height="30%" title="github copilot extension">
</p>

The picture below shows the first suggestion from GitHub Copilot, by adding the comment in line 1:

<p align="center">
  <img src="pictures/github_copilot_aks_terraform_04.png" width="50%" height="20%" title="suggestion for Terraform block">
</p>

Same works for creating a "Provider" block:

<p align="center">
  <img src="pictures/github_copilot_aks_terraform_06.png" width="50%" height="20%" title="suggestion for Terraform block">
</p>

# 4. Create the resources by applying the Terraform configuration

After finishing the complete Terraform configuration file, conduct following commands to provision the resources on Azure:

``` powershell
terraform init
```

``` powershell
terraform validate
```

``` powershell
terraform apply
```

After applying the "terraform apply", you should see logs similar than shown in the picture below:

<p align="center">
  <img src="pictures/github_copilot_aks_terraform_11.png" width="60%" height="30%" title="applying the config">
</p>

The Kubernetes cluster will be ready after a few minutes:

<p align="center">
  <img src="pictures/github_copilot_aks_terraform_12.png" width="60%" height="30%" title="created resource">
</p>

Just a few seconds are necessary until the Container Registry appears in the Azure Portal:

<p align="center">
  <img src="pictures/github_copilot_aks_terraform_13.png" width="60%" height="30%" title="created resource">
</p>


## 5. Destroy the resources

Use the following command to delete all provisioned resources again:

``` powershell
terraform destroy
```

# References

[Visual Studio Code](https://code.visualstudio.com/) 

[GitHub Copilot Extension](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot) 

[GitHub Copilot subscription](https://github.com/features/copilot)

[Terraform](https://www.terraform.io/)

[Azure subscription](https://azure.microsoft.com/en-us)
