@description('Location for all resources')
param location string = resourceGroup().location

@description('AKS cluster name')
param aksName string

@description('ACR resource ID')
param acrId string

@description('VNET address space')
param vnetCidr string = '10.10.0.0/16'

@description('Subnet CIDRs')
param appSubnetCidr string = '10.10.1.0/24'
param dbSubnetCidr string  = '10.10.2.0/24'
param agentSubnetCidr string = '10.10.3.0/24'

var vnetName = 'vnet-aks-demo'
var appSubnetName = 'snet-app'
var dbSubnetName = 'snet-db'
var agentSubnetName = 'snet-agent'

resource vnet 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [ vnetCidr ]
    }
    subnets: [
      {
        name: appSubnetName
        properties: { addressPrefix: appSubnetCidr }
      }
      {
        name: dbSubnetName
        properties: { addressPrefix: dbSubnetCidr }
      }
      {
        name: agentSubnetName
        properties: { addressPrefix: agentSubnetCidr }
      }
    ]
  }
}

resource aks 'Microsoft.ContainerService/managedClusters@2024-02-01' = {
  name: aksName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: aksName
    agentPoolProfiles: [
      {
        name: 'nodepool1'
        count: 1
        vmSize: 'Standard_DC2s_v3'
        mode: 'System'
        osType: 'Linux'
        vnetSubnetID: vnet.properties.subnets[0].id
      }
    ]
    networkProfile: {
      networkPlugin: 'azure'
      serviceCidr: '10.20.0.0/16'
      dnsServiceIP: '10.20.0.10'
    }
  }
}

resource acrPull 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(aks.id, 'acrpull')
  scope: resourceGroup()
  properties: {
    roleDefinitionId: subscriptionResourceId(
      'Microsoft.Authorization/roleDefinitions',
      '7f951dda-4ed3-4680-a7ca-43fe172d538d' // AcrPull
    )
    principalId: aks.identity.principalId
    principalType: 'ServicePrincipal'
  }
}

