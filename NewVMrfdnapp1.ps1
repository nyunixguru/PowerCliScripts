
Connect-VIServer -Server cld3 -User root -Password r

New-VM -Name rfdna `
   -Datastore CLD3-RFDN-DS1 `
   -DiskGB 120 `
   -DiskStorageFormat thick `
   -MemoryGB 8 `
   -NumCpu 2 `
   -GuestId rhel6_64Guest `
   -CD |
   Get-CDDrive | 
      Set-CDDrive -IsoPath "[CLD3-RFDN-DS2]/rhel-server-6.4-x86_64-dvd.iso" `
         -StartConnected:$true `
         -Confirm:$False
