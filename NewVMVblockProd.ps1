
#Connect-VIServer -Server cld3-c3-b8.srv.hcvlny.cv.net -User root -Password r00t123
Connect-VIServer -Server cld2-vbprod-c1-b1.vsf5-2.hcvlny.dhg.cv.net -User root -Password V1rtu@1c3!
New-VM -Name voptid1.vsf5-2.hcvlny.dhg.cv.net `
   -Datastore CLD2-VBPROD-hcvlny-1-OS2 `
   -DiskGB 146 `
   -DiskStorageFormat thick `
   -MemoryGB 12 `
   -NumCpu 4 `
   -GuestId rhel6_64Guest  `
   -CD |
   Get-CDDrive -VM voptid1.vsf5-2.hcvlny.dhg.cv.net| 
      Set-CDDrive -IsoPath "[CLD2-VBPROD-hcvlny-1-OS1]/rhel-server-6.4-x86_64-dvd.iso" `
         -StartConnected:$true `
         -Confirm:$False