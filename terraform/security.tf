# Security group Master
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group

resource "azurerm_network_security_group" "secGroupMaster" {
    name                = "sshtrafficmaster"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "CP2"
    }
}
# Security group Worker
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group

resource "azurerm_network_security_group" "secGroupWorker" {
    name                = "sshtrafficworker"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "CP2"
    }
}
# Security group Nfs
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group

resource "azurerm_network_security_group" "secGroupNfs" {
    name                = "sshtrafficnfs"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "CP2"
    }
}
# Vinculamos el security group al interface de red Master
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association

resource "azurerm_network_interface_security_group_association" "secGroupAssociation1" {
    network_interface_id      = azurerm_network_interface.nicMaster.id
    network_security_group_id = azurerm_network_security_group.secGroupMaster.id

}

# Vinculamos el security group al interface de red Worker
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association

resource "azurerm_network_interface_security_group_association" "secGroupAssociation2" {
    network_interface_id      = azurerm_network_interface.nicWorker1.id
    network_security_group_id = azurerm_network_security_group.secGroupWorker.id

}

# Vinculamos el security group al interface de red Worker
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association

resource "azurerm_network_interface_security_group_association" "secGroupAssociation3" {
    network_interface_id      = azurerm_network_interface.nicWorker2.id
    network_security_group_id = azurerm_network_security_group.secGroupWorker.id

}

# Vinculamos el security group al interface de red Nfs
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association

resource "azurerm_network_interface_security_group_association" "secGroupAssociation4" {
    network_interface_id      = azurerm_network_interface.nicNfs.id
    network_security_group_id = azurerm_network_security_group.secGroupNfs.id

}