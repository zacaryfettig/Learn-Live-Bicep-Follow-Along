param location string
param appServiceAppName string

@allowed([
  'nonprod'
  'prod'
])

param environmentType string 

var appServericePlanName = 'toy-product-launch-plan'
var appServicePlanSkuName = (environmentType == 'prod' ) ? 'P2v3' : 'F1'

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServericePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }

}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
}
}

output appServiceAppHostName string = appServiceApp.properties.defaultHostName
