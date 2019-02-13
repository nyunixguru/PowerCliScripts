Connect-VIServer -Server cld1-c1-  -User root -Password r00t123


#Get-ScsiLun -LunType disk | select lunDatastoreName, CanonicalName, CapacityMB | sort -Property lunDatastoreName

#Get-ScsiLun -LunType disk
#Get-Datastore
#Get-VMHost | Get-VMHostStorage | Format-List *
#New-Datastore -Name vCloud-0 -Path naa.60060160582017005c0a006277b6df11 -Vmfs
#New-Datastore -VMHost $host -Name Datastore -Path $scsiLun.CanonicalName -Vmfs -FileSystemVersion 3

#Below code returns output in form

#Name     : CLD1-HCVLNY-OS01
#DiskName : naa.6006016052802100e876b5e3ed63e111

Get-Datastore |
Where-Object {$_.ExtensionData.Info.GetType().Name -eq "VmfsDatastoreInfo"} |
ForEach-Object {
  if ($_)
  {
    $Datastore = $_
    $Datastore.ExtensionData.Info.Vmfs.Extent |
    Select-Object -Property @{Name="Name";Expression={$Datastore.Name}},
      DiskName
  }
}

#Get-VMHostStorage -RescanAllHba -RescanVmfs

#Get-Datastore |
#Where-Object {$_.ExtensionData.Info.GetType().Name -eq "VmfsDatastoreInfo"} |
#ForEach-Object {
 # if ($_)
 # {
  #  $Datastore = $_
   # $Datastore.ExtensionData.Info.Vmfs.Extent |
    #Select-Object -Property @{Name="Name";Expression={$Datastore.Name}},
#      DiskName
 # }
#}
