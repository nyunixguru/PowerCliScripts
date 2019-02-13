#Script to add dvUplinks to vds for new hosts
#Connect-VIServer -Server vcenterprim -User ddilwort -Password 


#CLD3-ACCSW1-2.MSF1_dvSwitch
for ($i=1; $i -lt 9; $i++) 
{
# Add Esxi host first to the VDS
Add-VDSwitchVMHost -vmhost cld3-c10-b$i.srv.hcvet -VDSwitch "CLD3-ACCSW1-2.MSF1_dvSwitch"
Start-Sleep -s 2
 $NetworkAdapter = Get-VMHost -Name cld3-c10-b$i.srv.hcv.net | Get-VMHostNetworkAdapter `
 -Name vmnic10 -Physical
 Start-Sleep -s 2
#Add Physical network adapter uplink to VDS
 Add-VDSwitchPhysicalNetworkAdapter `
 -DistributedSwitch CLD3-ACCSW1-2.MSF1_dvSwitch `
-VMHostNetworkAdapter $NetworkAdapter 
}


CLD3-ACCSW1-2.VSF1_dvSwitch


for ($i=2; $i -lt 9; $i++)
{
Add-VDSwitchVMHost -vmhost cld3-c11-b$i.srv.hcv.net -VDSwitch "CLD3-ACCSW1-2.VSF1_dvSwitch"
Start-Sleep -s 2
$NetworkAdapter = Get-VMHost -Name cld3-c11-b$i.srv.hc.net | Get-VMHostNetworkAdapter `
 -Name vmnic3 -Physical
Start-Sleep -s 2
 Add-VDSwitchPhysicalNetworkAdapter `
 -DistributedSwitch CLD3-ACCSW1-2.VSF1_dvSwitch `
-VMHostNetworkAdapter $NetworkAdapter -Confirm:$false
Start-Sleep -s 20
}

CLD3-ACCSW1-2.VSF2_dvSwitch
for ($i=1; $i -lt 9; $i++)
{
Add-VDSwitchVMHost -vmhost cld3-c11-b$i. -VDSwitch "CLD3-ACCSW1-2.VSF2_dvSwitch"
 $NetworkAdapter = Get-VMHost -Name cld3-c11-b$i.srv | Get-VMHostNetworkAdapter `
 -Name vmnic11 -Physical

 Add-VDSwitchPhysicalNetworkAdapter `
 -DistributedSwitch CLD3-ACCSW1-2.VSF2_dvSwitch `
-VMHostNetworkAdapter $NetworkAdapter -Confirm:$false
}


CLD3-ACCSW1-2.VSF3_dvSwitch

for ($i=1; $i -lt 9; $i++)
{
Add-VDSwitchVMHost -vmhost cld3-c11-b$i.srv.hcvet -VDSwitch "CLD3-ACCSW1-2.VSF3_dvSwitch"
Start-Sleep -s 2
$NetworkAdapter = Get-VMHost -Name cld3-c11-b$i.srv.hcvet | Get-VMHostNetworkAdapter `
 -Name vmnic4 -Physical
Start-Sleep -s 2
 Add-VDSwitchPhysicalNetworkAdapter `
 -DistributedSwitch CLD3-ACCSW1-2.VSF3_dvSwitch `
-VMHostNetworkAdapter $NetworkAdapter -Confirm:$false
Start-Sleep -s 20
}

CLD3-ACCSW3-4.MSF_dvSwitch

for ($i=1; $i -lt 9; $i++)
{
Add-VDSwitchVMHost -vmhost cld3-c11-b$i.srv -VDSwitch "CLD3-ACCSW3-4.MSF_dvSwitch"
 $NetworkAdapter = Get-VMHost -Name cld3-c11-b$i.srv.hcet | Get-VMHostNetworkAdapter `
 -Name vmnic6 -Physical
Start-Sleep -s 2
 Add-VDSwitchPhysicalNetworkAdapter `
 -DistributedSwitch CLD3-ACCSW3-4.MSF_dvSwitch `
-VMHostNetworkAdapter $NetworkAdapter -Confirm:$false
Start-Sleep -s 20
}


CLD3-DSTSWR3-4.MSF_dvSwitch
for ($i=1; $i -lt 9; $i++)
{
Add-VDSwitchVMHost -vmhost cld3-c10-b$i.srv.hcvlnnet -VDSwitch "CLD3-ACCSW3-4.MSF_dvSwitch"

 $NetworkAdapter = Get-VMHost -Name cld3-c10-b$i.srv.het | Get-VMHostNetworkAdapter `
 -Name vmnic12 -Physical

 Add-VDSwitchPhysicalNetworkAdapter `
 -DistributedSwitch  CLD3-DSTSWR3-4.MSF_dvSwitch`
-VMHostNetworkAdapter $NetworkAdapter 
}

CLD3-SWR10-11.SF_dvSwitch

for ($i=1; $i -lt 9; $i++)
{
Add-VDSwitchVMHost -vmhost cld3-c11-b$i.net -VDSwitch "CLD3-SWR10-11.SF_dvSwitch"
Start-Sleep -s 2
 $NetworkAdapter = Get-VMHost -Name cld3-c11-b$iet | Get-VMHostNetworkAdapter `
 -Name vmnic1 -Physical
Start-Sleep -s 2
 Add-VDSwitchPhysicalNetworkAdapter `
 -DistributedSwitch  CLD3-SWR10-11.SF_dvSwitch `
-VMHostNetworkAdapter $NetworkAdapter -Confirm:$false
Start-Sleep -s 5
}

CLD3-SWR12-13.SF_dvSwitch

for ($i=1; $i -lt 9; $i++)
{
Add-VDSwitchVMHost -vmhost cld3-c11-b$i.t -VDSwitch "CLD3-SWR12-13.SF_dvSwitch"
 $NetworkAdapter = Get-VMHost -Name cld3-c11-b$i.srv.hcvlnet | Get-VMHostNetworkAdapter `
 -Name vmnic2 -Physical
Start-Sleep -s 2
 Add-VDSwitchPhysicalNetworkAdapter `
 -DistributedSwitch  CLD3-SWR12-13.SF_dvSwitch `
-VMHostNetworkAdapter $NetworkAdapter -Confirm:$false
Start-Sleep -s 2
}


CLD3-SWR3-4.SF_dvSwitch
for ($i=1; $i -lt 9; $i++)
{
Add-VDSwitchVMHost -vmhost cld3-c11-b$i.s -VDSwitch "CLD3-SWR3-4.SF_dvSwitch"
 $NetworkAdapter = Get-VMHost -Name cld3-c11-b$i.srv.hcvlet | Get-VMHostNetworkAdapter `
 -Name vmnic5 -Physical
Start-Sleep -s 2
 Add-VDSwitchPhysicalNetworkAdapter `
 -DistributedSwitch  CLD3-SWR3-4.SF_dvSwitch `
-VMHostNetworkAdapter $NetworkAdapter -Confirm:$false
Start-Sleep -s 2
}

CLD3-SWR5-6.SF_dvSwitch

for ($i=1; $i -lt 9; $i++)
{
Add-VDSwitchVMHost -vmhost cld3-c11-b$i.srv.hcvt -VDSwitch "CLD3-SWR5-6.SF_dvSwitch"
 $NetworkAdapter = Get-VMHost -Name cld3-c11-b$i.srv.hcvlt | Get-VMHostNetworkAdapter `
 -Name vmnic7 -Physical

 Add-VDSwitchPhysicalNetworkAdapter `
 -DistributedSwitch  CLD3-SWR5-6.SF_dvSwitch `
-VMHostNetworkAdapter $NetworkAdapter -Confirm:$false
}


CLD3-SWR7-8.SF_dvSwitch
for ($i=1; $i -lt 9; $i++)
{
Add-VDSwitchVMHost -vmhost cld3-c11-b$i.srv.hcvlt -VDSwitch "CLD3-SWR7-8.SF_dvSwitch"
 $NetworkAdapter = Get-VMHost -Name cld3-c11-b$i.srv.hcvet | Get-VMHostNetworkAdapter `
 -Name vmnic8 -Physical

 Add-VDSwitchPhysicalNetworkAdapter `
 -DistributedSwitch  CLD3-SWR7-8.SF_dvSwitch `
-VMHostNetworkAdapter $NetworkAdapter -Confirm:$false
}


CLD3-SWR9.SF_dvSwitch
for ($i=1; $i -lt 9; $i++)
{
Add-VDSwitchVMHost -vmhost cld3-c11-b$i.srvnet -VDSwitch "CLD3-SWR9.SF_dvSwitch"
 $NetworkAdapter = Get-VMHost -Name cld3-c11-b$i.sret | Get-VMHostNetworkAdapter `
 -Name vmnic9 -Physical

 Add-VDSwitchPhysicalNetworkAdapter `
 -DistributedSwitch CLD3-SWR9.SF_dvSwitch `
-VMHostNetworkAdapter $NetworkAdapter -Confirm:$false
}


#Disconnect-VIServer
