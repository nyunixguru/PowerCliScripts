

Connect-VIServer -Server cld3-  -User root -Password r0
#Start-VM -vm ipmgmt3.  
Stop-VM -vm ipmgmt3. 
#Get-NetworkAdapter -vm ipmgmt | remove-networkadapter -confirm:$False
#New-NetworkAdapter  -VM ipmgmtt -NetworkName "CLD3-VLAN105_dvPortGroup"  -StartConnected -Type Vmxnet3
#New-NetworkAdapter  -VM ipmgmt  -NetworkName "VM Network" -StartConnected -Type flexible
