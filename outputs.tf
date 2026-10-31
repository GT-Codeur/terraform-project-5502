output "resource_group_name" {
  value = module.rgroup-N10038841.resource_group_name
}

output "virtual_network_name" {
  value = module.network-N10038841.virtual_network_name
}

output "subnet_name" {
  value = module.network-N10038841.subnet_name
}

output "log_ana_wps_name" {
  value = module.common-N10038841.log_ana_wps_name
}

output "vault_name" {
  value = module.common-N10038841.vault_name
}

output "storage_account_name" {
  value = module.common-N10038841.storage_account_name
}

output "linux_private_ip" {
  value = module.vmlinux-N10038841.linux_private_ip
}

output "linux_public_ip" {
  value = module.vmlinux-N10038841.linux_public_ip
}

output "linux_hostnames" {
  value = module.vmlinux-N10038841.linux_hostnames
}

output "linux_FQDNs" {
  value = module.vmlinux-N10038841.linux_FQDNs
}

output "windows_vm_hostnames" {
  value = module.vmwindows-N10038841.windows_vm_hostnames
}

output "windows_vm_fqdns" {
  value = module.vmwindows-N10038841.windows_vm_fqdns
}

output "windows_private_ip_address" {
  value = module.vmwindows-N10038841.windows_private_ip_address
}

output "windows_public_ip_address" {
  value = module.vmwindows-N10038841.windows_public_ip_address
}

output "load_balancer_name" {
  value = module.loadbalancer-N10038841.load_balancer_name
}

output "postgresql_server_name" {
  value = module.database-N10038841.postgresql_server_name
}