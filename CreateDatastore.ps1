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