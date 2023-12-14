targetScope = 'subscription'

param baseName string
param resourceGroupLocation string

param resourceGroupName string = 'rg-${baseName}'

param appServicePlanName string = 'asp-${baseName}'
param webAppName string = 'app-${baseName}'

param sqlServerName string = 'sql-${baseName}'
param databaseName string = 'sqldb-${baseName}'

resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}

module webApp 'webapp.bicep' = {
  name: 'webApp'
  scope: rg
  params: {
    location: rg.location
    webAppName: webAppName
    appServicePlanName: appServicePlanName
  }
}

module dbWithServer 'sql.bicep' = {
  name: 'dbWithServer'
  scope: rg
  params: {
    location: rg.location
    sqlServerName: sqlServerName
    databaseName: databaseName
  }
}
