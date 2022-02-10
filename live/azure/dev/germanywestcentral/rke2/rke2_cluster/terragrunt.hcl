include "root" {
  path = find_in_parent_folders()
  merge_strategy = "deep"
  expose = true
}

terraform {
  source = "../../../../../../helper-modules/rke2-azure-tf"
}

dependency "azure_network" {
  config_path = "../azure_network"
}

generate "provider-local" {
  path = "provider-local.tf"
  if_exists = "overwrite"
  contents = file("../../../../../../provider-config/rke2_azure/rke2_azure.tf")
}

inputs = {
  azure_env = include.root.locals.azure_env
  resource_group_name = include.root.locals.azure_rg_name
  cluster_name = include.root.locals.merged_config.cluster_name
  subnet_id = dependency.azure_network.outputs.azure_snet_id
  cloud = include.root.locals.merged_config.cloud
  tags = include.root.locals.merged_config.tags
  server_public_ip = include.root.locals.merged_config.server_public_ip
  server_open_ssh_public = include.root.locals.merged_config.server_open_ssh_public
  vm_size = include.root.locals.merged_config.vm_size
  server_instance_count = include.root.locals.merged_config.server_instance_count
  agent_instance_count = include.root.locals.merged_config.agent_instance_count
}
