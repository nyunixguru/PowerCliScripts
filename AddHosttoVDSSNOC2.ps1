#SMAPP_Vmotion_dvSwitch
#for ($i=1; $i -lt 5; $i++) 
#{
# Add Esxi host first to the VDS
#Add-VDSwitchVMHost -vmhost snoc2-c5-b$i.srv.hcvlnyet -VDSwitch "SNOC2_Vmotion_dvSwitch"
#Start-Sleep -s 2
 #$NetworkAdapter = Get-VMHost -Name snoc2-c5-b$i.srv.hcvlnyt | Get-VMHostNetworkAdapter `
# -Name vmnic1 -Physical
# Start-Sleep -s 2
#Add Physical network adapter uplink to VDS
# Add-VDSwitchPhysicalNetworkAdapter `
 #-DistributedSwitch SNOC2_Vmotion_dvSwitch  `
#-VMHostNetworkAdapter $NetworkAdapter 
#}


#Add Vmotion IP
#New-VMHostNetworkAdapter -VMHost "snoc2-c5-b1.srv.hcvet" -PortGroup "SNOC2_Vmotion_dvPortGroup" -VirtualSwitch "SNOC2_Vmotion_dvSwitch" -IP 10.248.198.164 -SubnetMask 255.255.255.128 -VMotionEnabled:$true


#SNOC2_Accsw101-102.NOCSF_dvSwitch
#for ($i=1; $i -lt 5; $i++) 
#{
# Add Esxi host first to the VDS
#Add-VDSwitchVMHost -vmhost snoc2-c5-b$i.srv.hcvlet -VDSwitch "SNOC2_Vmotion_dvSwitch"
#Start-Sleep -s 2
# $NetworkAdapter = Get-VMHost -Name snoc2-c5-b$i.srv.hcvlet | Get-VMHostNetworkAdapter `
 #-Name vmnic8 -Physical
 #Start-Sleep -s 2
#Add Physical network adapter uplink to VDS
 #Add-VDSwitchPhysicalNetworkAdapter `
 #-DistributedSwitch SNOC2_Accsw101-102.NOCSF_dvSwitch  `
#-VMHostNetworkAdapter $NetworkAdapter 
#}

#SNOC2_DWSW1-2.NOCSF_dvSwitch
for ($i=1; $i -lt 5; $i++) 
{
# Add Esxi host first to the VDS
#Add-VDSwitchVMHost -vmhost snoc2-c5-b$i.srv.hcvet -VDSwitch "SNOC2_DWSW1-2.NOCSF_dvSwitch"
Start-Sleep -s 2
 $NetworkAdapter = Get-VMHost -Name snoc2-c5-b$i.srv.hcet | Get-VMHostNetworkAdapter `
 -Name vmnic9 -Physical
 Start-Sleep -s 2
#Add Physical network adapter uplink to VDS
 Add-VDSwitchPhysicalNetworkAdapter `
 -DistributedSwitch SNOC2_DWSW1-2.NOCSF_dvSwitch  `
-VMHostNetworkAdapter $NetworkAdapter 
}

