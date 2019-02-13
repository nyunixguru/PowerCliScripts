
Connect-VIServer -Server cld3-c5 -User root -Password r0

New-VM -Name rfdndat
   -Datastore CLD3-RFDN-DS1 `
   -DiskGB 100 `
   -DiskStorageFormat thick `
   -MemoryGB 16 `
   -NumCpu 2 `
   -GuestId rhel6_64Guest `
   -CD |
   Get-CDDrive -VM rfdndata1t| 
      Set-CDDrive -IsoPath "[CLD3-RFDN-DS2]/rhel-server-6.4-x86_64-dvd.iso" `
         -StartConnected:$true `
         -Confirm:$False
