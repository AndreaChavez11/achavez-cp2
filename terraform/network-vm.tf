# Create NIC Master
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "nicMaster" {
  name                = "vmnicmaster"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "ipconfigurationMaster"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = var.ip_master
    public_ip_address_id           = azurerm_public_ip.publicIpMaster.id
  }

    tags = {
        environment = "CP2"
    }

}

# IP pública Master
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "publicIpMaster" {
  name                = "vmipmaster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  domain_name_label   = "vmmasterunir180"

    tags = {
        environment = "CP2"
    }

}

# Create NIC Worker 1
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "nicWorker1" {
  name                = "vmnicworker1"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "ipconfigurationWorker1"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = var.ip_worker1
    public_ip_address_id           = azurerm_public_ip.publicIpWorker1.id
  }

    tags = {
        environment = "CP2"
    }

}

# IP pública Worker 1
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "publicIpWorker1" {
  name                = "vmipworker1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  domain_name_label   = "vmworker1unir180"

    tags = {
        environment = "CP2"
    }

}
# Create NIC Worker 2
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "nicWorker2" {
  name                = "vmnicworker2"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "ipconfigurationWorker2"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = var.ip_worker2
    public_ip_address_id           = azurerm_public_ip.publicIpWorker2.id
  }

    tags = {
        environment = "CP2"
    }

}

# IP pública Worker 2
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "publicIpWorker2" {
  name                = "vmipworker2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  domain_name_label   = "vmworker2unir180"

    tags = {
        environment = "CP2"
    }

}
# Create NIC Nfs
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "nicNfs" {
  name                = "vmnicnfs"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "ipconfigurationNfs"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = var.ip_nfs
    public_ip_address_id           = azurerm_public_ip.publicIpNfs.id
  }

    tags = {
        environment = "CP2"
    }

}

# IP pública Nfs
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "publicIpNfs" {
  name                = "vmipnfs"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  domain_name_label   = "vmnfsunir180"

    tags = {
        environment = "CP2"
    }

}

