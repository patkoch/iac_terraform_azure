package test

import (
	"net"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func isValidIP(ip string) bool {
	parsedIP := net.ParseIP(ip)
	return parsedIP != nil
}

func TestDeploymentVirtualMachine(t *testing.T) {
	// Construct the terraform options with default retryable errors to handle the most common
	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// Set the path to the Terraform code that will be tested.
		TerraformDir: "../",
	})

	// Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// Run several tests t get the values of output variables and check they have the expected values.
	realVirtualMachineName := terraform.Output(t, terraformOptions, "my_virtual_machine_name")
	assert.Equal(t, "windows11-21h2", realVirtualMachineName)

	realResourceGroupName := terraform.Output(t, terraformOptions, "my_resource_group_name")
	assert.Equal(t, "iac-azure-terraform", realResourceGroupName)

	realResourceGroupLocation := terraform.Output(t, terraformOptions, "my_resource_group_location")
	assert.Equal(t, "westeurope", realResourceGroupLocation)

	realVirtualMachineIP := terraform.Output(t, terraformOptions, "my_virtual_machine_public_ip")
	assert.True(t, isValidIP(realVirtualMachineIP))
}

// https://terratest.gruntwork.io/docs/getting-started/quick-start/
// https://github.com/gruntwork-io/terratest/tree/master/examples/terraform-hello-world-example
// https://terratest.gruntwork.io/docs/getting-started/quick-start/
