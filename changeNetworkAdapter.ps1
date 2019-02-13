
Connect-VIServer -Server cld3-c3-b1.srv.hcvlny.cv.net  -User root -Password r00t123
#Get-NetworkAdapter -vm vdhcpred1.srv.hcvlny.cv.net | remove-networkadapter -confirm:$False
#New-NetworkAdapter -VM  vdhcpred1.srv.hcvlny.cv.net -Type vmxnet3 
#-NetworkName CLD3-SWR3-4.SF_VLAN114_dvPortGroup -StartConnected | Out-Null
#Get-VMHostNetwork -VMHost cld3-c3-b1.srv.hcvlny.cv.net 

#New-NetworkAdapter -VM $vm -NetworkName "VM Network" -MacAddress  'aa:bb:cc:dd:ee:ff' -WakeOnLan -StartConnected
Get-VMHostFirewallException