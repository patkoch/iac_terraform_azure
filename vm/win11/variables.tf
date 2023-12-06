variable "my_virtual_machine_password" {
  default     = "P@$$w0rd1234!"
  description = "Password of the Virtual Machine"
}

variable "my_virtual_machine_size" {
  default     = "Standard_D2_v4"
  description = "Size of the Virtual Machine"
}

# create a variable for the name of the virtual machine
variable "my_virtual_machine_name" {
  default     = "windows11-21h2"
  description = "Name of the Virtual Machine"
}
