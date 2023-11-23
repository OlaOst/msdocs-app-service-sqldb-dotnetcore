targetScope = 'subscription'

param baseName string
param resourceGroupLocation string
param resourceGroupName string = 'rg-${baseName}'
param webAppName string = 'app-${baseName}'
param webAppLocation string

resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}

module webApp 'webapp.bicep' = {
  name: 'webApp'
  scope: rg
  params: {
    webAppLocation: webAppLocation
    webAppName: webAppName
  }
}
