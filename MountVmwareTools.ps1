Connect-VIServer -Server cld3- -User root -Password r



#Unmount cd iso
#Get-VM | Get-CDDrive | Where { $_.IsoPath } | Set-CDDrive -NoMedia -Confirm:$true

#   Get-CDDrive -VM ipmgmt4.hesv.net| 
  #   Set-CDDrive -IsoPath "[CLD3-RFDN-DS2]/rhel-server-6.4-i386-dvd.iso" `
 #        -StartConnected:$true `
#        -Confirm:$true
