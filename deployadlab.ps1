
$hostname = hostname
if ($hostname -eq "AD1") {
Install-WindowsFeature ad-domain-services -IncludeAllSubFeature -IncludeManagementTools
import-module addsdeployment
$recoverypw = ConvertTo-SecureString "p@assword123!" -AsPlainText -force
install-addsforest -domainname jmc.com -installdns -safemodeadministratorpassword $recoverypw -force
}
else {
Install-WindowsFeature ad-domain-services -IncludeAllSubFeature -IncludeManagementTools
$adapter = get-networkadapter
set-dnsclientserveraddress -InterfaceIndex $adapter.ifindex -ServerAddresses 10.0.1.4
Import-Module ADDSDeployment
Install-ADDSDomainController `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$false `
-Credential (Get-Credential) `
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

