resource "azurerm_public_ip" "lb_public_ip" {
  name                = "linux-lb-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Static"
  sku               = "Standard"

  domain_name_label = lower(
    "linux-lb-${var.dns_label_suffix}"
  )

  tags = var.tags
}

# Load balancer
resource "azurerm_lb" "linux_lb" {
  name                = "linux-load-balancer"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "public-frontend"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }

  tags = var.tags
}

# Backend pool for the three Linux VMs
resource "azurerm_lb_backend_address_pool" "linux_backend_pool" {
  name            = "linux-backend-pool"
  loadbalancer_id = azurerm_lb.linux_lb.id
}

# Associate all three Linux VM network interfaces with the backend pool
resource "azurerm_network_interface_backend_address_pool_association" "linux_backend" {
  count = length(var.linux_nic_ids)

  network_interface_id    = var.linux_nic_ids[count.index]
  ip_configuration_name   = var.linux_ip_conf_names[count.index]
  backend_address_pool_id = azurerm_lb_backend_address_pool.linux_backend_pool.id
}