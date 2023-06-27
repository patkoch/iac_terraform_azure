resource "azurerm_resource_group" "rg" {
  name     = "iac-azure-terraform"
  location = "westeurope"
}

resource "azurerm_availability_set" "myavailabilityset" {
  name                = "example-aset"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vNet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "my-public-ip-vm-1" {
  name                = "public-ip-vm-1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "my-public-ip-vm-2" {
  name                = "public-ip-vm-2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "networkinterface-vm-1" {
  name                = "my-network-interface-vm-1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = azurerm_public_ip.my-public-ip-vm-1.id
  }
}

resource "azurerm_network_interface" "networkinterface-vm-2" {
  name                = "network-interface-vm-2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = azurerm_public_ip.my-public-ip-vm-2.id
  }
}

# Windows 11 Virtual Machine
resource "azurerm_windows_virtual_machine" "my-vm-1" {
  name                = "windows11-vm-1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.my_virtual_machine_size
  admin_username      = "adminuser"
  admin_password      = var.my_virtual_machine_password
  availability_set_id = azurerm_availability_set.myavailabilityset.id
  network_interface_ids = [
    azurerm_network_interface.networkinterface-vm-1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-21h2-avd"
    version   = "latest"
  }
}

resource "azurerm_windows_virtual_machine" "my-vm-2" {
  name                = "windows11-vm-2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.my_virtual_machine_size
  admin_username      = "adminuser"
  admin_password      = var.my_virtual_machine_password
  availability_set_id = azurerm_availability_set.myavailabilityset.id
  network_interface_ids = [
    azurerm_network_interface.networkinterface-vm-2.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-21h2-avd"
    version   = "latest"
  }
}

# Security Group - allowing RDP Connection
resource "azurerm_network_security_group" "sg-rdp-connection" {
  name                = "allowrdpconnection"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "rdpport"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Testing"
  }
}

# Associate security group with network interface
resource "azurerm_network_interface_security_group_association" "vm-1" {
  network_interface_id      = azurerm_network_interface.networkinterface-vm-1.id
  network_security_group_id = azurerm_network_security_group.sg-rdp-connection.id
}

resource "azurerm_network_interface_security_group_association" "vm-2" {
  network_interface_id      = azurerm_network_interface.networkinterface-vm-2.id
  network_security_group_id = azurerm_network_security_group.sg-rdp-connection.id
}