
$subscriptionID = "09688c0b-8d07-41e6-ad43-b4a1b7329fbc"
Connect-AzAccount
Set-AzContext -SubscriptionId $subscriptionID


# Set the variables
$resourceGroup = "deploymentgroup-rg-azdevops-test-eastus-01"
$region = "EastUS"
$vmName = "my-vm"
$adminUsername = "devopsadmin"
$adminPassword = ConvertTo-SecureString -String "Pass@123#" -AsPlainText -Force
$vnetName = "vnet-azdevops-test-eastus-01"
$subnetName = "cicdSubnet"
$publicInboundPorts = "3389", "80", "443", "8080"
$osDiskType = "StandardSSD"

# Create the resource group
New-AzResourceGroup -Name $resourceGroup -Location $region

# Create the virtual network and subnet
$subnetConfig = New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix "10.0.0.0/24"
$vnet = New-AzVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup -Location $region -AddressPrefix "10.0.0.0/16" -Subnet $subnetConfig

# Create the public IP address
$publicIp = New-AzPublicIpAddress -Name "${vmName}-publicip" -ResourceGroupName $resourceGroup -Location $region -AllocationMethod Static -Sku "Basic"

# Create the network security group
$nsg = New-AzNetworkSecurityGroup -Name "${vmName}-nsg" -ResourceGroupName $resourceGroup -Location $region

# Allow inbound ports on the network security group
$nsg | Add-AzNetworkSecurityRuleConfig -Name "Allow-RDP" -Priority 100 -Protocol Tcp -Direction Inbound -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389 -Access Allow
$nsg | Add-AzNetworkSecurityRuleConfig -Name "Allow-HTTP" -Priority 101 -Protocol Tcp -Direction Inbound -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80 -Access Allow
$nsg | Add-AzNetworkSecurityRuleConfig -Name "Allow-HTTPS" -Priority 102 -Protocol Tcp -Direction Inbound -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 443 -Access Allow
$nsg | Add-AzNetworkSecurityRuleConfig -Name "Allow-TCP-8080" -Priority 103 -Protocol Tcp -Direction Inbound -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 8080 -Access Allow
$nsg | Set-AzNetworkSecurityGroup

# Create the virtual machine configuration
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize "Standard_D2s_v3" -Priority "Spot" -MaxPrice -1 -EvictionPolicy Deallocate 
$vmConfig = Set-AzVMOperatingSystem -VM $vmConfig -Windows -ComputerName $vmName -Credential (New-Object System.Management.Automation.PSCredential -ArgumentList $adminUsername, $adminPassword) -ProvisionVMAgent -EnableAutoUpdate
$vmConfig = Add-AzVMNetworkInterface -VM $vmConfig -Id $vnet.Id -Primary
$vmConfig = Set-AzVMSourceImage -VM $vmConfig -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2019-Datacenter" -Version "latest"
$vmConfig = Set-AzVMOSDisk -VM $vmConfig -Name "${vmName}-osdisk" -StorageAccountType $osDiskType -CreateOption FromImage


