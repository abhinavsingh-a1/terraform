# Define the required provider for Azure
provider "azurerm" {
  # Specify the version of the AzureRM provider
  version = "~> 3.0"

  # Set the features block to enable specific features in the provider
  features {}
}

# Define a resource group for the SQL Database
resource "azurerm_resource_group" "example" {
  # Name of the resource group
  name     = "example-sql-resource-group"

  # Location where the resource group will be created (e.g., East US)
  location = "eastus"
}

# Define an Azure SQL Server
resource "azurerm_sql_server" "example" {
  # Name of the SQL Server (must be unique across Azure)
  name                = "example-sql-server"

  # Link the SQL Server to the resource group defined above
  resource_group_name = azurerm_resource_group.example.name

  # Location of the SQL Server (same as the resource group)
  location            = azurerm_resource_group.example.location

  # Administrator login for the SQL Server
  administrator_login = "sqladmin"

  # Password for the SQL Server administrator
  administrator_login_password = "StrongPassword123!" # Replace with a strong password

  # Version of the SQL Server (default is 12.0 which corresponds to SQL Server 2016)
  version = "12.0"
}

# Define an Azure SQL Database
resource "azurerm_sql_database" "example" {
  # Name of the SQL Database
  name                = "example-sql-database"

  # Link the SQL Database to the SQL Server defined above
  server_id           = azurerm_sql_server.example.id

  # Collation for the database (default is SQL_Latin1_General_CP1_CI_AS)
  collation           = "SQL_Latin1_General_CP1_CI_AS"

  # Edition of the SQL Database (Basic, Standard, Premium, etc.)
  edition             = "Standard"

  # Requested service objective name (pricing tier)
  requested_service_objective_name = "S0" # S0 is a basic pricing tier for Standard edition

  # Auto-pause delay in minutes (set to -1 to disable auto-pause)
  auto_pause_delay_in_minutes = -1

  # Maximum size of the database in GB
  max_size_gb         = 50
}

# Output the fully qualified domain name (FQDN) of the SQL Server
output "sql_server_fqdn" {
  value       = azurerm_sql_server.example.fully_qualified_domain_name
  description = "The fully qualified domain name (FQDN) of the Azure SQL Server."
}

# Output the connection string for the SQL Database
output "sql_database_connection_string" {
  value       = "Server=${azurerm_sql_server.example.fully_qualified_domain_name};Database=${azurerm_sql_database.example.name};User Id=${azurerm_sql_server.example.administrator_login};Password=${azurerm_sql_server.example.administrator_login_password};"
  description = "The connection string for the Azure SQL Database."
  sensitive   = true # Mark as sensitive to avoid exposing credentials in plain text
}
