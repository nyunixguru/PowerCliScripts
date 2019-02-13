

Connect-VIServer -Server cld3-c3-b8.srv.hcvlny.cv.net -User root -Password r00t123


Get-VM -Name ipmgmt4.hesv.hcvlny.dhg.cv.net | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName CLD3-VLAN105_dvPortGroup
Get-VM -Name ipmgmt4.hesv.hcvlny.dhg.cv.net|Get-NetworkAdapter |Where {$_.NetworkName -eq "VM Network" } |Set-NetworkAdapter -NetworkName "CLD3-VLAN105_dvPortGroup" -Confirm:$false