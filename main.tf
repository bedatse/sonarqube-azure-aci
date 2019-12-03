resource "azurerm_resource_group" "sonarqube_aci" {
  name     = "sonarqube-rg"
  location = "eastasia"
}

resource "azurerm_container_group" "sonarqube" {
  name                = "sonarqube-aci"
  location            = "${azurerm_resource_group.sonarqube_aci.location}"
  resource_group_name = "${azurerm_resource_group.sonarqube_aci.name}"
  ip_address_type     = "public"
  dns_name_label      = "coeus-aci"
  os_type             = "Linux"

  container {
    name   = "sonarqube-community"
    image  = "sonarqube:community-beta"
    cpu    = "4"
    memory = "8"

    ports {
      port     = 9000
      protocol = "TCP"
    }
  }

  tags = {
    environment = "sonarqube"
  }
}