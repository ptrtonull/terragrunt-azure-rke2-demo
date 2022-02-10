resource "azurerm_virtual_network" "azure_vnet" {
  name          = lookup(var.azure_network, "name", "defaultAzureVnet") 
  address_space = lookup(var.azure_network, "address_space", ["10.0.0.0/16"])

  resource_group_name = var.azure_rg_name
  location            = var.azure_location
}

resource "azurerm_subnet" "azure_snet" {
  name = lookup(var.azure_subnet, "name", "defaultAzureSnet")

  resource_group_name  = var.azure_rg_name
  virtual_network_name = azurerm_virtual_network.azure_vnet.name

  address_prefixes = lookup(var.azure_subnet, "address_prefixes", ["10.0.1.0/24"])
}
