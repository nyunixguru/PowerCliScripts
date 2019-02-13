
#Connect-VIServer -Server cld3 -User root -Password r
Connect-VIServer -Server cld2-vbprod  -User root -Password 
New-VM -Name voptid1 `
   -Datastore CLD2-VBPROD-1-OS2 `
   -DiskGB 146 `
   -DiskStorageFormat thick `
   -MemoryGB 12 `
   -NumCpu 4 `
   -GuestId rhel6_64Guest  `
   -CD |
   Get-CDDrive -VM voptid1 | 
      Set-CDDrive -IsoPath "[CLD2-VBPROD-OS1]/rhel-server-6.4-x86_64-dvd.iso" `
         -StartConnected:$true `
         -Confirm:$False
