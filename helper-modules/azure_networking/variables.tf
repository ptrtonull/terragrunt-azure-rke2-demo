variable "azure_rg_name" {
   description = "Name of the resource group in which the resources will be created"
   default     = "myResourceGroup"
}

variable "azure_location" {
   default = "eastus"
   description = "Location where resources will be created"
}

variable "azure_network" {
   type = object({
     name = string
     address_space = list(string)
   })
   default = {
     address_space = []
     name = ""
   }
}

variable "azure_subnet" {
   type = object({
     name = string
     address_prefixes = list(string)
   })
   default = {
     address_prefixes = []
     name = ""
   }
}
