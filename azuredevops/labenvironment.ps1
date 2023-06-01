#variables
$subscriptionID = "09688c0b-8d07-41e6-ad43-b4a1b7329fbc"
$resourceGroupName = "rg-azdevops-test-eastus-01"
$location = "eastus"

Connect-AzAccount
Set-AzContext -SubscriptionId $subscriptionID
#creating resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Define the resource group and VNet details
$vnetName = "vnet-azdevops-test-eastus-01"
$vnetAddressPrefix = "10.20.0.0/16"

#refer : Contoso Network Lab1.png

# Create the VNet
$vnet = New-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnetName -AddressPrefix $vnetAddressPrefix

# Create a Subnet
# Define the subnet details
$subnetConfig = @{
    Name = "cicdSubnet"
    AddressPrefix = "10.20.0.0/24"
}

# Create the GatewaySubnet
$gatewaySubnet = Add-AzVirtualNetworkSubnetConfig -Name $subnetConfig.Name -AddressPrefix $subnetConfig.AddressPrefix -VirtualNetwork $vnet

# Update the VNet with all the subnets
$vnet | Set-AzVirtualNetwork