# Import Modules
if ((Get-Module |where {$_.Name -ilike "CiscoUcsPS"}).Name -ine "CiscoUcsPS")
	{
	Write-Host "Loading Module: Cisco UCS PowerTool Module"
	Import-Module CiscoUcsPs
	}


#Then run ConvertTo-UcsCmdlet from command line



#VNIC
#Add-UcsVnicTemplate
#Set-UcsVnicTemplate

#Get-UcsLsbootStorage