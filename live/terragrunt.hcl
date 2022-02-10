locals {
  root_deployments_dir = get_parent_terragrunt_dir()
  relative_module_path  = path_relative_to_include()
  module_hierarchy_levels = compact(split("/", local.relative_module_path))
  module = basename(get_terragrunt_dir())

  possible_config_dirs = [
    for i in range(0, length(local.module_hierarchy_levels) + 1) :
    join("/", concat(
      [local.root_deployments_dir],
      slice(local.module_hierarchy_levels, 0, i)
    ))
  ]

  possible_config_paths = flatten([
    for dir in local.possible_config_dirs : [
      "${dir}/data/common.yaml",
      "${dir}/data/${local.module}.yaml"
    ]
  ])

  # Load every YAML config file that exists into an HCL object
  file_configs = [ for path in local.possible_config_paths : yamldecode(file(path)) if fileexists(path) ]

  # Merge the objects together, with deeper configs overriding higher configs
  merged_config = merge(local.file_configs...)

  project_name = local.merged_config.project_name
  azure_env = local.merged_config.azure_env
  azure_location = local.merged_config.azure_location
  azure_storage_account_name = local.merged_config.azure_storage_account_name
  azure_storage_container_name = local.merged_config.azure_storage_container_name
  azure_rg_name = local.merged_config.azure_rg_name


  # TF module sources
  tf_module = local.module
  tf_component = local.merged_config.component
  tf_modules = local.merged_config.tf_modules
}

remote_state {
  backend = "azurerm"
  config = {
    key = "${path_relative_to_include()}/terraform.tfstate"
    storage_account_name = local.azure_storage_account_name
    container_name = local.azure_storage_container_name 
    resource_group_name = local.azure_rg_name 
  }

  generate = {
    path = "backend.tf"
    if_exists = "overwrite"
  }
}
