param appServicePlanName string
param webAppName string

param sku string = 'F1'
param location string = resourceGroup().location

param repositoryUrl string = 'https://github.com/OlaOst/msdocs-app-service-sqldb-dotnetcore'
param repositoryBranch string = 'main'

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

resource webApp 'Microsoft.Web/sites@2022-09-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

resource sourceControls 'Microsoft.Web/sites/sourcecontrols@2022-09-01' = {
  parent: webApp
  name: 'web'
  properties: {
    repoUrl: repositoryUrl
    branch: repositoryBranch
    isGitHubAction: true
    gitHubActionConfiguration: {
      generateWorkflowFile: false
      isLinux: true
      codeConfiguration: {
        runtimeStack: '.NET'
        runtimeVersion: '.NET Core 8.0'
      }
    }
  }
}
