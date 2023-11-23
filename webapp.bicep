param webAppLocation string
param webAppName string

resource webApp 'Microsoft.Web/sites@2022-09-01' = {
  name: webAppName
  location: webAppLocation
  // TODO: more webApp fields needed?
}
