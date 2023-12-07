package test

import (
	"net"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Function for verifying an ip address - source: GitHubCopilot
func isValidIP(ip string) bool {
	parsedIP := net.ParseIP(ip)
	return parsedIP != nil
}

func TestDeploymentVirtualMachine(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The TerraformDir variable points the location of the Terraform configuration which shall be tested
		TerraformDir: "../",
	})

	// Conduct the destruction at the end of the test
	defer terraform.Destroy(t, terraformOptions)

	// Conduct the "init" and "apply" commands and fail in case of any errors
	terraform.InitAndApply(t, terraformOptions)

	// Verification of the virtual machine name
	realVirtualMachineName := terraform.Output(t, terraformOptions, "my_virtual_machine_name")
	assert.Equal(t, "windows11-21h2", realVirtualMachineName)

	// Verification of the resource group name
	realResourceGroupName := terraform.Output(t, terraformOptions, "my_resource_group_name")
	assert.Equal(t, "iac-azure-terraform", realResourceGroupName)

	//Verification of the resource group location
	realResourceGroupLocation := terraform.Output(t, terraformOptions, "my_resource_group_location")
	assert.Equal(t, "westeurope", realResourceGroupLocation)

	// Verification of the public ip address
	realVirtualMachineIP := terraform.Output(t, terraformOptions, "my_virtual_machine_public_ip")
	assert.True(t, isValidIP(realVirtualMachineIP))
}
