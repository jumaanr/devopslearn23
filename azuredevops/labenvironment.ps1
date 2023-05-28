#variables
$subscriptionID = "09688c0b-8d07-41e6-ad43-b4a1b7329fbc"
$resourceGroupName = "rg-azdevops-test-eastus-01"
$location = "eastus"

Connect-AzAccount
Set-AzContext -SubscriptionId $subscriptionID
#creating resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location