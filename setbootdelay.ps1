
Connect-VIServer -Server cld3-c5-b8.srv.hcvlny.cv.net -User root -Password r00t123

 $vmm = "ipmgmt4.hesv.hcvlny.dhg.cv.net"

    
    $value = "10000"
    #$vm = Get-VM $vmname | Get-View
	$vm = Get-VM $vmm | Get-View
    $vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec
    $vmConfigSpec.BootOptions = New-Object VMware.Vim.VirtualMachineBootOptions
    $vmConfigSpec.BootOptions.BootDelay = $value
    $vm.ReconfigVM_Task($vmConfigSpec)

