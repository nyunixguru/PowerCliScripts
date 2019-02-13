Connect to host
#Connect-VIServer -Server cld3-c5-b8.srv.hcvlny.cv.net -User root -Password r00t123
#Connect-VIServer -Server cld3-c4-b8.srv.hcvlny.cv.net -User root -Password r00t123
#Connect-VIServer -Server 192.168.1.4 -User root -Password r00t123
#Connect-VIServer -Server cld2-vbprod-c1-b5.vsf5-2.hcvlny.dhg.cv.net -User root -Password V1rtu@1c3!
#Connect to Vcenter server root/r00t123 works
#Connect-VIServer vcenterprimary.srv.hcvlny.cv.net -User root -Password r00t123
#Connect-VIServer -Server vcenterprimary.srv.hcvlny.cv.net -User ddilwort -Password R@dsk1nz


#Restart ESXi host
#Restart-vmhost -Force

#Start VM
#Start-VM -VM  rfdn.srv.hcvlny.cv.net -Kill -Confirm:$false

Change Memory size
#Stop-VM -VM ipmgmt3.hesv.hcvlny.dhg.cv.net
#Set-VM -VM ipmgmt3.hesv.hcvlny.dhg.cv.net  -MemoryGB 20

#Mount Vmware Tools
#Start-VM -VM  ipmgmt4.hesv.hcvlny.dhg.cv.net -Confirm:$false
#Mount-Tools vdhcpred2.srv.hcvlny.cv.net

#Remove VM
#Stop-VM -VM ipmgmt4.hesv.hcvlny.dhg.cv.net
#Remove-VM -VM   ipmgmt4.hesv.hcvlny.dhg.cv.net -DeletePermanently
#Remove-Inventory -Item  WebServerTest -Server 192.168.1.3

#Rename Datastore
#onnect-VIServer -Server cld1-c3-b1.srv.hcvlny.cv.net -User root -Password r00t123
#Get-Datastore -Name CLD1-HCVLNY-OS011 | Set-Datastore -Name CLD1-HCVLNY-OS11



#Remove-VM -VM  ServerClone -DeletePermanently
#Remove from inventory?
# (Get-View -ViewType VirtualMachine) |?{$_.Runtime.ConnectionState -eq "invalid" -or $_.Runtime.ConnectionState -eq "inaccessible"} |%{$_.reload()}

#Connect-VIServer -Server cld3-c3-b8.srv.hcvlny.cv.net -User root -Password r00t123
#Get-VM -Name ipmgmt4.hesv.hcvlny.dhg.cv.net | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName CLD3-VLAN105_dvPortGroup
#Get-VM -Name ipmgmt4.hesv.hcvlny.dhg.cv.net|Get-NetworkAdapter |Where {$_.NetworkName -eq "VM Network" } |Set-NetworkAdapter -NetworkName "CLD3-VLAN105_dvPortGroup" -Confirm:$false


#Add a New VM
#New-VM -Name rfdndata1.srv.hcvlny.cv.net `
   -Datastore CLD3-RFDN-DS1 `
   -DiskGB 100 `
   -DiskStorageFormat thick `
   -MemoryGB 16 `
   -NumCpu 2 `
   -GuestId rhel6_64Guest `
   
#Start a VM
   Start-VM -VM  ipmgmt4.hesv.hcvlny.dhg.cv.net -Confirm:$false
   
# Add new Hard Disk
New-HardDisk -CapacityGB 400 -VM rfdndata1.srv.hcvlny.cv.net -Datastore CLD3-RFDN-DS2

#Set Boot delay
$vmm = "ipmgmt4.hesv.hcvlny.dhg.cv.net"
    $value = "10000"
    #$vm = Get-VM $vmname | Get-View
	$vm = Get-VM $vmm | Get-View
    $vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec
    $vmConfigSpec.BootOptions = New-Object VMware.Vim.VirtualMachineBootOptions
    $vmConfigSpec.BootOptions.BootDelay = $value
    $vm.ReconfigVM_Task($vmConfigSpec)
	
	
#Unmount cd iso
#Get-VM | Get-CDDrive | Where { $_.IsoPath } | Set-CDDrive -NoMedia -Confirm:$true


#Stop-VM rfdnapp1.srv.hcvlny.cv.net
# Can now mount cdrom run mount /dev/cdrom /mnt
Mount-Tools ipmgmt4.hesv.hcvlny.dhg.cv.net

#Connect-VIServer -Server cld3-c4-b8.srv.hcvlny.cv.net -User root -Password r00t123
#Removes CD Drive entirely
#$cd = Get-CDDrive -VM rfdnapp1.srv.hcvlny.cv.net    
#Remove-CDDrive -CD $cd

#Creates new cd drive device ( if not installed )
#New-CDDrive -VM rfdnapp1.srv.hcvlny.cv.net

#Export-VApp -Destination "d:\ISO_Images" -VM vemd2-ool123.srv.hcvlny.cv.net
# Import a vApp directly into Esxi hhost
#Import-vApp -Source c:\Images\vdhcptemplate.srv.hcvlny.cv.net\vdhcptemplate.srv.hcvlny.cv.net.ovf -VMHost cld1-c3-b1.srv.hcvlny.cv.net -Name vdhcpred1.srv.hcvlny.cv.net
#Import-vApp -Source c:\iso_images\voptid1.vsf5-2.hcvlny.dhg.cv.net\voptid1.vsf5-2.hcvlny.dhg.cv.net.ovf -VMHost cld2-vbprod-c1-b5.vsf5-2.hcvlny.dhg.cv.net -Name voptid2.vsf5-2.hcvlny.dhg.cv.net -Datastore CLD2-VBPROD-hcvlny-2-OS2 -RunAsync
#Import-vApp -Source c:\ISO_IMAGES\ipmgmt4.hesv.hcvlny.dhg.cv.net\ipmgmt4.hesv.hcvlny.dhg.cv.net.ovf -VMHost cld3-c3-b8.srv.hcvlny.cv.net -Name ipmgmt4.hesv.hcvlny.dhg.cv.net
#Import-vApp -Source d:\ISO_IMAGES\RHEL6480GB\RHEL6480GB.ovf -Name vdhcp-af.srv.hcvlny.cv.net -VMHost cld3-c3-b8.srv.hcvlny.cv.net

#Export vapp
#Get-VM -Name voptid1.vsf5-2.hcvlny.dhg.cv.net | Export-VApp -Destination "C:\iso_images" -Force -RunAsync
#Unmount cd iso
#Get-VM | Get-CDDrive | Where { $_.IsoPath } | Set-CDDrive -NoMedia -Confirm:$true

#Mount iso
#   Get-CDDrive -VM ipmgmt4.hesv.hcvlny.dhg.cv.net| 
  #   Set-CDDrive -IsoPath "[CLD3-RFDN-DS2]/rhel-server-6.4-i386-dvd.iso" `
 #        -StartConnected:$true `
#        -Confirm:$true


#Update Vmware Tools
#Update-Tools rfdn.srv.hcvlny.cv.net

#Stop-VM -vm ipmgmt3.hesv.hcvlny.dhg.cv.net  
#Get-NetworkAdapter -vm ipmgmt3.hesv.hcvlny.dhg.cv.net | remove-networkadapter -confirm:$False
#New-NetworkAdapter  -VM ipmgmt4.hesv.hcvlny.dhg.cv.net -NetworkName "CLD3-VLAN105_dvPortGroup"  -StartConnected -Type Vmxnet3
#New-NetworkAdapter  -VM ipmgmt3.hesv.hcvlny.dhg.cv.net  -NetworkName "VM Network" -StartConnected -Type flexible


#Connect-VIServer -Server cld3-c4-b8.srv.hcvlny.cv.net -User root -Password r00t123
#New-VM -VM "$clonesourcevm" -VMHost "$clonehost" -Name $clonename -Datastore "$cloneds" -Location "$clonefolder" -ErrorAction Stop;


#Connect-VIServer -Server cld3-c4-b8.srv.hcvlny.cv.net -User root -Password r00t123
#New-VM -VM "$clonesourcevm" -VMHost "$clonehost" -Name $clonename -Datastore "$cloneds" -Location "$cl


$ Create DS on one host in the Cluster
#Connect-VIServer -Server cld1-c1-b1.srv.whplny.cv.net -User root -Password r00t123
#Get-VMHostStorage -RescanAllHba -RescanVmfs
# Determine naa path of new LUN via Vcenter  (capture output before) or getdatastore canonical name ps script
#New-Datastore -VMHost $host -Name Datastore -Path $scsiLun.CanonicalName -Vmfs -FileSystemVersion 3
#New-Datastore -Name CLD1-HCVLNY-OS011  -Path naa.60060160582017005c0a006277b6df11 -Vmfs -FileSystemVersion 5
#New-Datastore -Name CLD1-HCVLNY-OS011  -Path naa.60060160528021006e309f3dd173e311 -Vmfs -FileSystemVersion 5
#New-Datastore -Name CLD1-WHPLNY-OS7  -Path naa.600601602b2030002a62092ce177e311 -Vmfs -FileSystemVersion 5
#Remove-Datastore -Datastore CLD1-WHPLNY-OS07
#Get-Datastore -Name CLD1-WHPLNY-OS07 | Set-Datastore -Name CLD1-WHPLNY-OS7
#Rescan DS on all other hosts in the Cluster
#for ($i=1; $i -le 6; $i++){

## rescan so all hosts see new DataStores
#Get-VMHostStorage -RescanAllHba -RescanVmfs
#}


#Increase HD size   work( worked on test VM rfdn.srv.hcvlny.cv.net
#Get-VM acpdb-backup.srv.hcvlny.cv.net | Get-HardDisk | where {$_.name -eq "Hard disk 2"} |set-harddisk -confirm:$false -capacityGB 5

#Migrate virtual Hard disk to different datastore ( tested need to test further)
#Get-HardDisk -vm <vmname>  | Where {$_.Name -eq "Hard disk <#>"} | `
% {Set-HardDisk -HardDisk $_ -Datastore "<datastore>" -Confirm:$false}

#Clone VM ( must connect to Vcenter Server?
#New-VM -Name server -VM rfdn -vmhost 192.168.1.3 ( worked)
#New-VM -Name VM2 -VM VM1 -Datastore datastorename -vmhost hostname -DiskStorageFormat thin

#Rename datastore
#Get-Datastore -Name Datastore1 | Set-Datastore -Name Datastore2

#Add hard disk
#New-HardDisk -VM acpdb2.srv.hcvlny.cv.net -CapacityGB 100 -Datastore smapp_os06

#Increase memory to 32GB
#Set-VM -VM acpdb2.srv.hcvlny.cv.net -MemoryGB 32

Configure New Esxi host

#Set Hostname, domainname, DNS Servers , DNS Search Domain
#Get-VMHostNetwork -VMHost 192.168.1.4| Set-VMHostNetwork -Hostname esx2 -DomainName srv.hcvlny.cv.net -DNSAddress 167.206.7.3 , 167.206.112.4 -SearchDomain srv.hcvlny.cv.net, hcvlny.cv.net, cv.net

#NTP Configuration
# Add ntp servers
#Add-VMHostNTPServer -NtpServer time1.cv.net, time2.cv.net  -Confirm:$false
#Set ntpd startup policy to start and stop with host
#Get-VMHostService  | where{$_.Key -eq "ntpd"} | Set-VMHostService -policy "on" -Confirm:$false
#Enable NTP client
#Get-VMHostService  | where{$_.Key -eq "ntpd"} | Restart-VMHostService -Confirm:$false
#
#Get-VMHostFirewallException | where {$_.Name -eq "NTP client"} | Set-VMHostFirewallException -Enabled:$true

#Set syslog host
Set-VMHostSysLogServer -SysLogServer udp://10.240.59.11:514,udp://10.240.59.12:5140

#Configure SNMP
#$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server cld3-c10-b1.srv.hcvlny.cv.net --username root --password r00t123 --show"
#Invoke-expression $expression
#$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server cld3-c10-b1.srv.hcvlny.cv.net --username root --password r00t123 -c 'public,vmware'"
#Invoke-expression $expression
#$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server cld3-c10-b1.srv.hcvlny.cv.net --username root --password r00t123 -t '172.16.30.111@162/public,172.16.30.111@162/vmware'"
#Invoke-expression $expression
# $expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server cld3-c10-b1.srv.hcvlny.cv.net --username root --password r00t123 -p 161"
#Invoke-expression $expression
$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server cld3-c10-b1.srv.hcvlny.cv.net --username root --password r00t123 --enable"
Invoke-expression $expression
$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server cld3-c10-b1.srv.hcvlny.cv.net --username root --password r00t123 --show"
Invoke-expression $expression

#Register DLL into Powergui
c:\Windows\Microsoft.Net\Framework64\v4.0.30319\InstallUtil.exe `
C:\PowerCLI\Vmware.VimAutomation.Vdscomponent.Commands.dll
Add-PSSnapin VMware.VimAutomation.VdsComponent
Get-Command –Module VMware.VimAutomation.VdsComponent

#Remove host from vds does not add uplink ports
Remove-VDSwitchVMHost -vmhost cld3-c10-b1.srv.hcvlny.cv.net -VDSwitch "CLD3-ACCSW1-2.VSF1_dvSwitch"

#Add a host to a VDS
#Add-VDSwitchVMHost -vmhost cld3-c10-b1.srv.hcvlny.cv.net -VDSwitch "CLD3-ACCSW1-2.VSF1_dvSwitch"
#$NetworkAdapter = Get-VMHost -Name cld3-c10-b1.srv.hcvlny.cv.net | Get-VMHostNetworkAdapter `
# -Name vmnic3 -Physical
#Add-VDSwitchVMHost -vmhost cld3-c10-b1.srv.hcvlny.cv.net -VDSwitch "CLD3-ACCSW1-2.VSF1_dvSwitch"


#Take a host out of Mintenance mode
Set-VMHost -VMhost “cld3-c10-b1.srv.hcvlny.cv.net” -State “Connected”
for ($i=1; $i -le 3; $i++){
Connect-VIServer -Server cld3-c10-b$i.srv.hcvlny.cv.net -User root -Password r00t123
Set-VMHost -VMhost cld3-c10-b$i.srv.hcvlny.cv.net -State “Connected”
}

#Migrate E1000 Adapter to vmxnet3
1
	
Get-VM -name "<VM>" | Get-NetworkAdapter | Where { $_.Type -eq "E1000"} | Set-NetworkAdapter -Type
#Configure Vmotion IP
New-VMHostNetworkAdapter -VMHost "<HOST>" -PortGroup "<PORTGROUP>" -VirtualSwitch "dvSwitch Lab" -IP <IP> -SubnetMask <MASK> -VMotionEnabled:$true