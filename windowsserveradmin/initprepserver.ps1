#Parameters and Variables

#Set the resolution
Set-DisplayResolution 1280 720

#Set time and timezone
Set-TimeZone "Mountain Standard Time"
tzutil.exe /l #This is tool to configure time
Set-Date -Date "9/2/2023 12:37 AM"

#------------------------------Configure Networking and Hostname
Get-NetIPAddress
#Set Static IP Address
New-NetIPAddress -InterfaceAlias ethernet0 -IPAddress 192.168.3.101 -PrefixLength 24 -DefaultGateway 192.168.3.2
#Enable DHCP
Set-NetIPAddress -InterfaceAlias ethernet0 -Dhcp Enable

#Set up DNS Server
Set-DnsClientServerAddress -InterfaceAlias ethernet0 -ServerAddresses ("192.168.3.10")
HOSTNAME.EXE
Get-Content Env:\COMPUTERNAME
Rename-Computer -NewName servercore -Restart

#-------------------------------Configure Licenses and activate

#Activating via License Key
slmgr.vbs -ipk XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
#Activate License Key
slmgr.vbs -ato 
slmgr.vbs -?

#Enable PS Remoting
Enable-PSRemoting

#-----------------------------------Firewall Configuration
Get-NetFirewallRule |Format-Table
# Example, check if ICMP enabled
Get-NetFirewallRule -Name "*ICMP*"  |Format-Table

#Configuring to enable certain rule
Set-NetFirewallRule -Name FPS-ICMP-ERQ-IN -Enabled True

#Check the Firwall Rules in Niceway
Get-NetFirewallRule | Format-Table DisplayName,DisplayGroup

#Enable a Rule from there
Enable-NetFirewallRule -DisplayGroup "File and Printer Sharing"

#Creating a new firewall rule to allow all traffic
New-NetFirewallRule -DisplayName "Allow All Traffic" -Direction Outbound -Action Allow
New-NetFirewallRule -DisplayName "Allow All Traffic" -Direction Inbound -Action Allow

#Install RSAT Tools on Win10
Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online

#Install a Domain Controller
Install-ADDSDomainController -DomainName woshub.com -InstallDns:$true -NoGlobalCatalog:$false -SiteName 'Hamburg' -NoRebootOnCompletion:$true -Force:$true -SafeModeAdministratorPassword (ConvertTo-SecureString 'R0DCP@ssw0rd' -AsPlainText -Force) -Credential (get-credential WOSHUB\Administrator) –verbose




