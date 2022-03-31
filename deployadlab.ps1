$hostname = hostname
if ($hostname -eq "AD1") {
Install-WindowsFeature ad-domain-services -IncludeAllSubFeature -IncludeManagementTools
import-module addsdeployment
$recoverypw = ConvertTo-SecureString "p@assword123!" -AsPlainText -force
install-addsforest -domainname jmc.com -installdns -safemodeadministratorpassword $recoverypw -force
}
else {
Install-WindowsFeature ad-domain-services -IncludeAllSubFeature -IncludeManagementTools
$adapter = get-netadapter
set-dnsclientserveraddress -InterfaceIndex $adapter.ifindex -ServerAddresses 10.0.1.4
Import-Module ADDSDeployment
$userName = 'admin123'
$userPassword = 'Password123123!!'
$secureString = $userPassword | ConvertTo-SecureString -AsPlainText -Force 
$credentialObejct = New-Object System.Management.Automation.PSCredential -ArgumentList $userName, $secureString
Install-ADDSDomainController `
-credential: $credentialObejct `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$false ` `
-CriticalReplicationOnly:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainName "jmc.com" `
-InstallDns:$false `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SiteName "Default-First-Site-Name" `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true
}
