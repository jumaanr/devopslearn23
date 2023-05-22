
#----------------------------- VNet Creation and Subnetting -----------------------#
#variables
$subscriptionID = ""
$resourceGroupName = ""
$location = ""

Connect-AzAccount
Set-AzContext -SubscriptionId $subscriptionID
#creating resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Define the resource group and VNet details
$vnetName = "CoreServicesVnet"
$vnetAddressPrefix = "10.20.0.0/16"

#refer : Contoso Network Lab1.png

# Create the VNet
$vnet = New-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnetName -AddressPrefix $vnetAddressPrefix

# Create a Subnet
# Define the subnet details
$subnetConfig = @{
    Name = "GatewaySubnet"
    AddressPrefix = "10.20.0.0/24"
}

# Create the GatewaySubnet
$gatewaySubnet = Add-AzVirtualNetworkSubnetConfig -Name $subnetConfig.Name -AddressPrefix $subnetConfig.AddressPrefix -VirtualNetwork $vnet

#Lets create set if subnets in form of an Array
# Define the remaining subnets
$subnetConfigs = @(
    @{
        Name = "DatabaseSubnet"
        AddressPrefix = "10.20.20.0/24"
    },
    @{
        Name = "SharedServiceSubnet"
        AddressPrefix = "10.20.10.0/24"
    },
    @{
        Name = "PublicWebServiceSubnet"
        AddressPrefix = "10.20.30.0/24"
    }
)

# Create the remaining subnets
foreach ($config in $subnetConfigs) {
    $subnet = Add-AzVirtualNetworkSubnetConfig -Name $config.Name -AddressPrefix $config.AddressPrefix -VirtualNetwork $vnet
    $vnet | Set-AzVirtualNetwork
}

# Update the VNet with all the subnets
$vnet | Set-AzVirtualNetwork

#------------------------------------------------------------------------------