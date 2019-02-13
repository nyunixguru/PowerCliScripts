
Connect-VIServer -Server cld3- -User root -Password r00

 $vmm = "ipmgmt4t"

    
    $value = "10000"
    #$vm = Get-VM $vmname | Get-View
	$vm = Get-VM $vmm | Get-View
    $vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec
    $vmConfigSpec.BootOptions = New-Object VMware.Vim.VirtualMachineBootOptions
    $vmConfigSpec.BootOptions.BootDelay = $value
    $vm.ReconfigVM_Task($vmConfigSpec)

