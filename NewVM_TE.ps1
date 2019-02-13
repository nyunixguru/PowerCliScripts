Connect-VIServer -Server 192.168.1.3 -User root -Password r

New-VM -Name rfdn `
   -Datastore Datastore2 `
   -DiskMB 1024 `
   -DiskStorageFormat thick `
   -MemoryGB 1 `
   -NumCpu 2 `
   -GuestId rhel6_64Guest `
   -NetworkName RedNet `
#   -CD |
#   Get-CDDrive | 
 #     Set-CDDrive -IsoPath "[datastore1 (1)]/RHEL6.2_x64.iso" `
#         -StartConnected:$true `
#         -Confirm:$False
