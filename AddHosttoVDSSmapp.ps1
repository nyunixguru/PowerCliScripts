#Script to add dvUplinks to vds for new et
#Connect-VIServer -Server vcenterprimary.sUser ddilwort -Password


#SMAPP_Vmotion_dvSwitch
for ($i=1; $i -lt 9; $i++) 
{
# Add Esxi host first to the VDS
Add-VDSwitchVMHost -vmhost smapp-c7-b$i.srv -VDSwitch "SMAPP_Vmotion_dvSwitch"
Start-Sleep -s 2
 $NetworkAdapter = Get-VMHost -Name smapp-c7-b$i.srv. | Get-VMHostNetworkAdapter `
 -Name vmnic2 -Physical
 Start-Sleep -s 2
#Add Physical network adapter uplink to VDS
 Add-VDSwitchPhysicalNetworkAdapter `
 -DistributedSwitch SMAPP_Vmotion_dvSwitch  `
-VMHostNetworkAdapter $NetworkAdapter 
}


#SMAPP_dvSwitch
for ($i=1; $i -lt 9; $i++) 
{
# Add Esxi host first to the VDS
Add-VDSwitchVMHost -vmhost smapp-c7-b$i.srv. -VDSwitch "SMAPP_dvSwitch"
Start-Sleep -s 2
 $NetworkAdapter = Get-VMHost -Name smapp-c7-b$i.srv. | Get-VMHostNetworkAdapter `
 -Name vmnic1 -Physical
 Start-Sleep -s 2
Add Physical network adapter uplink to VDS
Add-VDSwitchPhysicalNetworkAdapter `
 -DistributedSwitch SMAPP_dvSwitch  `
-VMHostNetworkAdapter $NetworkAdapter 
}

#Add Vmotion IP
New-VMHostNetworkAdapter -VMHost "smapp-c6-b" -PortGroup "SMAPP_Vmotion_dvPortGroup" -VirtualSwitch "SMAPP_Vmotion_dvSwitch" -IP 10.5.169.217 -SubnetMask 255.255.255.192 -VMotionEnabled:$true
