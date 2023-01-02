param location string = resourceGroup().location
param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'toylaunch${uniqueString(resourceGroup().id)}'

@allowed([
  'nonprod'
  'prod'
])

param environmentType string 

var appServericePlanName = 'toy-product-launch-plan'
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'standard_LRS'
var appServicePlanSkuName = (environmentType == 'prod' ) ? 'P2v3' : 'F1'

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
properties:{
   accessTier:'Cool'
}
}

module app 'appservice.bicep' = {
  name: 'app'
  params: {
    appServiceAppName: appServiceAppName
    environmentType: environmentType
    location: location
  }
}


output appServiceAppHostName string = app.outputs.appServiceAppHostName
