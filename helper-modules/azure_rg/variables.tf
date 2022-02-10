variable "azure_rg_name" {
   description = "Name of the resource group in which the resources will be created"
   default     = "myResourceGroup"
}

variable "azure_location" {
   default = "eastus"
   description = "Location where resources will be created"
}
