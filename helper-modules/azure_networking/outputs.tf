output "azure_vnet" {
  value = azurerm_virtual_network.azure_vnet
}

output "azure_vnet_name" {
  value = azurerm_virtual_network.azure_vnet.name
}

output "azure_snet" {
  value = azurerm_subnet.azure_snet
}

output "azure_snet_id" {
  value = azurerm_subnet.azure_snet.id
}

output "network_details" {
  value = regex("^(?P<vnet_id>\\/subscriptions\\/(?P<subscription>[^\\/]*)\\/resourceGroups\\/(?P<resource_group>[^\\/]*)\\/providers\\/Microsoft\\.Network\\/virtualNetworks\\/(?P<vnet>[^\\/]*))\\/subnets\\/(?P<subnet>[^\\/]*)$", azurerm_subnet.azure_snet.id)
}
