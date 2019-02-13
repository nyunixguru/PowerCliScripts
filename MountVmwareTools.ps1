Connect-VIServer -Server cld3-c5-b8.srv.hcvlny.cv.net -User root -Password r00t123



#Unmount cd iso
#Get-VM | Get-CDDrive | Where { $_.IsoPath } | Set-CDDrive -NoMedia -Confirm:$true

#   Get-CDDrive -VM ipmgmt4.hesv.hcvlny.dhg.cv.net| 
  #   Set-CDDrive -IsoPath "[CLD3-RFDN-DS2]/rhel-server-6.4-i386-dvd.iso" `
 #        -StartConnected:$true `
#        -Confirm:$true