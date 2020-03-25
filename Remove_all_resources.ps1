#It will delete all resources without asking any confirmation
connect-AzAccount

$rgName = Get-AzResourceGroup 

Foreach($name in $rgName)
{
Write-Host $name.ResourceGroupName
Remove-AzResourceGroup -Name $name.ResourceGroupName -Verbose -Force
}
