

Connect-VIServer -Server cld3-c3-b8.srv.hcvlny.cv.net  -User root -Password r00t123
#Start-VM -vm ipmgmt3.hesv.hcvlny.dhg.cv.net  
Stop-VM -vm ipmgmt3.hesv.hcvlny.dhg.cv.net  
#Get-NetworkAdapter -vm ipmgmt3.hesv.hcvlny.dhg.cv.net | remove-networkadapter -confirm:$False
#New-NetworkAdapter  -VM ipmgmt4.hesv.hcvlny.dhg.cv.net -NetworkName "CLD3-VLAN105_dvPortGroup"  -StartConnected -Type Vmxnet3
#New-NetworkAdapter  -VM ipmgmt3.hesv.hcvlny.dhg.cv.net  -NetworkName "VM Network" -StartConnected -Type flexible