output "virtual_network_name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet_name" {
  value = azurerm_subnet.subnet.name
}

output "subnet_address_space" {
  value = azurerm_subnet.subnet.address_prefixes
}

output "sg_name" {
  value = azurerm_network_security_group.security_group.name
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}
