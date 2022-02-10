include "root" {
  path = find_in_parent_folders()
  merge_strategy = "deep"
  expose = true
}

terraform {
  source = "../../../../../../helper-modules/azure_rg"
}

inputs = {
  azure_env = include.root.locals.azure_env
  azure_rg_name = include.root.locals.azure_rg_name
  azure_location = include.root.locals.azure_location
}
