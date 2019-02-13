
Connect-VIServer -Server cld -User root -Password r
#Get-NetworkAdapter -vm vdh | remove-networkadapter -confirm:$False
#New-NetworkAdapter -VM  vdh -Type vmxnet3 
#-NetworkName CLD3-SWR3-4.SF_VLAN114_dvPortGroup -StartConnected | Out-Null
#Get-VMHostNetwork -VMHost cld3 

#New-NetworkAdapter -VM $vm -NetworkName "VM Network" -MacAddress  'aa:bb:cc:dd:ee:ff' -WakeOnLan -StartConnected
Get-VMHostFirewallException
