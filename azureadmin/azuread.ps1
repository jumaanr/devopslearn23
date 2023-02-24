#Install PowerShell Module : https://learn.microsoft.com/en-us/powershell/azure/install-az-ps?source=recommendations&view=azps-9.4.0
Connect-AzAccount

#Create and Manage Users : https://learn.microsoft.com/en-us/powershell/module/azuread/new-azureaduser?view=azureadps-2.0
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = "PassHash#123"
New-AzureADUser -DisplayName "Albert Hunter" -PasswordProfile $PasswordProfile -UserPrincipalName "Albert.Hunter@itangi.com" -AccountEnabled $true -MailNickName "Albert"

#Filter user details
Get-AzureADUser -Filter "UserType eq 'Member'"

#Create Group in Azure https://learn.microsoft.com/en-us/azure/active-directory/roles/groups-assign-role 
New-AzADGroup -DisplayName $gname -MailNickname $nickname
$group = New-AzADGroup -DisplayName "Service Desk Engineers" -Description "This group is assigned to Helpdesk Administrator built-in role in Azure AD." -MailEnabled $false -SecurityEnabled $true -MailNickName "sdengineers" -IsAssignableToRole $true
$roleDefinition = Get-AzureADMSRoleDefinition -Filter "displayName eq 'Helpdesk Administrator'"
$roleAssignment = New-AzureADMSRoleAssignment -DirectoryScopeId '/' -RoleDefinitionId $roleDefinition.Id -PrincipalId $group.Id
#This isassignable roles can be done only in Azure AD P1 pr P2 licenses :https://stackoverflow.com/questions/64971971/azure-ad-assign-roles-to-group


#Create a Management Group : https://learn.microsoft.com/en-us/powershell/module/az.resources/new-azmanagementgroup?view=azps-9.4.0
New-AzManagementGroup -GroupName "TestGroup"
#Create a Management Group with a parent and a display name
New-AzManagementGroup -GroupName "TestGroup" -DisplayName "TestGroupDisplayName" -ParentId "/providers/Microsoft.Management/managementGroups/TestGroupParent"


