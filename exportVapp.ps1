

#Connect-VIServer -Server cld2-vbprod-c1-b1.vsf5-2.hcvlny.dhg. -User root -Password V1rtu@1c3!
Connect-VIServer -Server cld3-c6-b5.srv.hcvlny. -User root -Password r00t123
#Get-VM vrtp1_clone.vsf5-2.hcvlny.dhg. | Remove-VM  -DeletePermanently
#Mount-Tools vrtp1_clone.vsf5-2.hcvlny.dhg.
#Get-VM -Name voptid1.vsf5-2.hcvlny.dhg. | Export-VApp -Destination "C:\iso_images" -Force -RunAsync
#Get-VMHostNetworkAdapter | select VMhost, Name, IP, SubnetMask, Mac, PortGroupName, vMotionEnabled, mtu, FullDuplex, BitRatePerSec
Get-VMHostNetwork | select VMhost, VMKernelGateway, DnsAddress
Get-VMHostNetwork | Select Hostname, VMKernelGateway -ExpandProperty VirtualNic | Where {$_.vMotionEnabled} | Select Hostname, PortGroupName, IP, SubnetMask