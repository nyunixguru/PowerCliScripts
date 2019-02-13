# ==============================================================================================
# 
# Microsoft PowerShell Source File -- Created with SAPIEN Technologies PrimalScript 2009
# 
# NAME: 
# 
# AUTHOR: Keith Luken
# DATE  : 7/8/2013
# 
# COMMENT: 
# 
# ==============================================================================================
# ==============================================================================================
# * Software Dependencies: *
# - Microsoft PowerShell *
# - VMWare PowerCLI *
# 
Write-Host This will set powered on VMs to have their boot delay set to 5 seconds
$vcenter = Read-Host "Enter the FQN of the vcenter to check: "
$cluster = Read-Host "Enter the cluster to check (enter for all)"
# ==============================================================================================
# Variables
# ==============================================================================================
$exitcode = 0										# default exit code unless error encountered
$vms = @()

# ==============================================================================================
# Functions
# ==============================================================================================


# ==============================================================================================
# Main Processing
# ==============================================================================================



Clear-Host
Write-Host
write-host The following parameters will be used:`n
write-host vcenter FQDN:`t $vcenter
write-host cluster name:`t	$cluster
Write-Host Loading Powercli....`n

#Try {Add-PSSnapin VMware.VimAutomation.Core}
Try {Add-PSSnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue}
Catch
{
	$ErrorMessage = $_.Exception.Message
	Write-Host "Error encountered adding Powercli :" $ErrorMessage
	Exit $exitcode
	
}
Write-Host Connecting to $vcenter "please wait...."`n
connect-viserver -server $vcenter 

if ($cluster -gt 0) {
	Write-Host `nGetting list of vms from $cluster cluster, this may take a few moments....`n	
	$vms = Get-VM -Location $cluster | Where-Object{$_.PowerState -eq "poweredon"}
	}
	else {
	Write-Host `nGetting list of vms from $vcenter, this may take a few moments....`n	
	$vms = Get-VM | Where-Object{$_.PowerState -eq "poweredon"}
	}	
	
Write-Host Found $vms.count Powered On VMs to check...`n

Write-Host `nChecking for disconnected adapters, this can take several minutes, please wait....`n

foreach ($vm in $vms) {

	$vmbo = New-Object VMware.Vim.VirtualMachineBootOptions
	$vmbo.BootDelay = 5000
	$vmcs = New-Object VMware.Vim.VirtualMachineConfigSpec
	$vmcs.BootOptions = $vmbo
	Write-Host Updatings VM: $vm
	$vm.ExtensionData.ReconfigVM($vmcs)

}

Write-Host `n
Write-Host Disconnecting from $vcenter "please wait...."
disconnect-VIServer -Server $vcenter -Confirm:$false


Exit $exitcode
Write-Host End of script.

