param location string = resourceGroup().location
param sqlServerName string
param databaseName string

resource sqlServer 'Microsoft.Sql/servers@2023-05-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    version: '12.0'
    administrators: {
      administratorType: 'ActiveDirectory'
      azureADOnlyAuthentication: true
      principalType: 'User'
      sid: 'd5567ad2-c72c-4035-aa02-0b78734602d1'
      login: 'olaa81_gmail.com#EXT#@olaa81gmail.onmicrosoft.com'
      tenantId: subscription().tenantId
    }
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2023-05-01-preview' = {
  parent: sqlServer
  name: databaseName
  location: location
  sku: {
    name: 'Basic'
  }
}
