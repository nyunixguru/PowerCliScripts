

Connect-VIServer -Server cld3-c3- -User root -Password 


Get-VM -Name ipmgm | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName CLD3-VLAN105_dvPortGroup
Get-VM -Name ipmgmt|Get-NetworkAdapter |Where {$_.NetworkName -eq "VM Network" } |Set-NetworkAdapter -NetworkName "CLD3-VLAN105_dvPortGroup" -Confirm:$false
