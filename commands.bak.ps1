Connect to host
Connect-VIServer -Server cld3- -User root -Password r00t123
Connect-VIServer -Server cld3-c4-b8 -User root -Password r00t123
Connect-VIServer -Server 192.168.1.3 -User root -Password r00t123
#Connect-VIServer -Server cld2-vbprod-c -User root -Password V1

Start VM
Start-VM -VM  rfdn -Kill -Confirm:$false

Change Memory size
#Stop-VM -VM ipmgmt3.
Set-VM -VM ipmgmt3.hesv  -MemoryGB 20

Mount Vmware Tools
Start-VM -VM  ipmgmt4 -Confirm:$false
#Mount-Tools vdhc 

Remove VM
Stop-VM -VM ipmgmt4.
Remove-VM -VM   ipmgmt4. -DeletePermanently
#Remove-Inventory -Item  WebServerTest -Server 192.168.1.3

Rename Datastore
onnect-VIServer -Server cld1-c3-b1. -User root -Password r00t123
Get-Datastore -Name CLD1-HCVLNY-OS011 | Set-Datastore -Name CLD1-HCVLNY-OS11



#Remove-VM -VM  ServerClone -DeletePermanently
#Remove from inventory?
 (Get-View -ViewType VirtualMachine) |?{$_.Runtime.ConnectionState -eq "invalid" -or $_.Runtime.ConnectionState -eq "inaccessible"} |%{$_.reload()}

Connect-VIServer -Server cld3-c3-b8. -User root -Password r00t123
Get-VM -Name ipmgmt4.net | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName CLD3-VLAN105_dvPortGroup
Get-VM -Name ipmgmt4.net|Get-NetworkAdapter |Where {$_.NetworkName -eq "VM Network" } |Set-NetworkAdapter -NetworkName "CLD3-VLAN105_dvPortGroup" -Confirm:$false


#Add a New VM
New-VM -Name rfdndata1.srv.hcvlny.cv.net `
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

Connect-VIServer -Server cld3-c4-b8.srv.hcvlny.cv.net -User root -Password r00t123
#Removes CD Drive entirely
#$cd = Get-CDDrive -VM rfdnapp1.srv.hcvlny.cv.net    
#Remove-CDDrive -CD $cd

#Creates new cd drive device ( if not installed )
New-CDDrive -VM rfdnapp1.srv.hcvlny.cv.net


Export-VApp -Destination "d:\ISO_Images" -VM vemd2-ool123.srv.hcvlny.cv.net

# Import a vApp directly into Esxi hhost
#Import-vApp -Source c:\Images\vdhcptemplate.srv.hcvlny.cv.net\vdhcptemplate.srv.hcvlny.cv.net.ovf -VMHost cld1-c3-b1.srv.hcvlny.cv.net -Name vdhcpred1.srv.hcvlny.cv.net
#Import-vApp -Source c:\iso_images\voptid1.vsf5-2.hcvlny.dhg.cv.net\voptid1.vsf5-2.hcvlny.dhg.cv.net.ovf -VMHost cld2-vbprod-c1-b5.vsf5-2.hcvlny.dhg.cv.net -Name voptid2.vsf5-2.hcvlny.dhg.cv.net -Datastore CLD2-VBPROD-hcvlny-2-OS2 -RunAsync
Import-vApp -Source c:\ISO_IMAGES\ipmgmt4.hesv.hcvlny.dhg.cv.net\ipmgmt4.hesv.hcvlny.dhg.cv.net.ovf -VMHost cld3-c3-b8.srv.hcvlny.cv.net -Name ipmgmt4.hesv.hcvlny.dhg.cv.net
 Import-VApp -Source c:\ISO_IMAGES\acpdb-backup.srv.hcvlny.cv.net\acpdb-backup.srv.hcvlny.cv.net.ovf -VMHost 192.168.1.3 -Name acpdb2 -Datastore Datastore2

#Unmount cd iso
#Get-VM | Get-CDDrive | Where { $_.IsoPath } | Set-CDDrive -NoMedia -Confirm:$true

Mount iso
#   Get-CDDrive -VM ipmgmt4.hesv.hcvlny.dhg.cv.net| 
  #   Set-CDDrive -IsoPath "[CLD3-RFDN-DS2]/rhel-server-6.4-i386-dvd.iso" `
 #        -StartConnected:$true `
#        -Confirm:$true


Update Vmware Tools
Update-Tools rfdn.srv.hcvlny.cv.net

Stop-VM -vm ipmgmt3.hesv.hcvlny.dhg.cv.net  
#Get-NetworkAdapter -vm ipmgmt3.hesv.hcvlny.dhg.cv.net | remove-networkadapter -confirm:$False
#New-NetworkAdapter  -VM ipmgmt4.hesv.hcvlny.dhg.cv.net -NetworkName "CLD3-VLAN105_dvPortGroup"  -StartConnected -Type Vmxnet3
#New-NetworkAdapter  -VM ipmgmt3.hesv.hcvlny.dhg.cv.net  -NetworkName "VM Network" -StartConnected -Type flexible


Connect-VIServer -Server cld3-c4-b8.srv.hcvlny.cv.net -User root -Password r00t123
#New-VM -VM "$clonesourcevm" -VMHost "$clonehost" -Name $clonename -Datastore "$cloneds" -Location "$clonefolder" -ErrorAction Stop;


Connect-VIServer -Server cld3-c4-b8.srv.hcvlny.cv.net -User root -Password r00t123
#New-VM -VM "$clonesourcevm" -VMHost "$clonehost" -Name $clonename -Datastore "$cloneds" -Location "$cl


$ Create DS on one host in the Cluster
Connect-VIServer -Server cld1-c1-b1.srv.whplny.cv.net -User root -Password r00t123
Get-VMHostStorage -RescanAllHba -RescanVmfs
# Determine naa path of new LUN via Vcenter  (capture output before) or getdatastore canonical name ps script
#New-Datastore -VMHost $host -Name Datastore -Path $scsiLun.CanonicalName -Vmfs -FileSystemVersion 3
#New-Datastore -Name CLD1-HCVLNY-OS011  -Path naa.60060160582017005c0a006277b6df11 -Vmfs -FileSystemVersion 5
#New-Datastore -Name CLD1-HCVLNY-OS011  -Path naa.60060160528021006e309f3dd173e311 -Vmfs -FileSystemVersion 5
New-Datastore -Name CLD1-WHPLNY-OS7  -Path naa.600601602b2030002a62092ce177e311 -Vmfs -FileSystemVersion 5
#Remove-Datastore -Datastore CLD1-WHPLNY-OS07
#Get-Datastore -Name CLD1-WHPLNY-OS07 | Set-Datastore -Name CLD1-WHPLNY-OS7
#Rescan DS on all other hosts in the Cluster
#for ($i=1; $i -le 6; $i++){

## rescan so all hosts see new DataStores
#Get-VMHostStorage -RescanAllHba -RescanVmfs
#}


#Increase HD size   work( worked on test VM rfdn.srv.hcvlny.cv.net
Get-VM acpdb-backup.srv.hcvlny.cv.net | Get-HardDisk | where {$_.name -eq "Hard disk 2"} |set-harddisk -confirm:$false -capacityGB 5

#Migrate virtual Hard disk to different datastore ( tested need to test further)
Get-HardDisk -vm <vmname>  | Where {$_.Name -eq "Hard disk <#>"} | `
% {Set-HardDisk -HardDisk $_ -Datastore "<datastore>" -Confirm:$false}

#Clone VM ( must connect to Vcenter Server?
New-VM -Name server -VM rfdn -vmhost 192.168.1.3 ( worked)
New-VM -Name VM2 -VM VM1 -Datastore datastorename -vmhost hostname -DiskStorageFormat thin
