
Connect-VIServer -Server 192.168.1.3 -User root -Password r00t123
#Start-VM -VM ServerClone
#Remove-VM -VM  ServerClone -DeletePermanently
 (Get-View -ViewType VirtualMachine) |?{$_.Runtime.ConnectionState -eq "invalid" -or $_.Runtime.ConnectionState -eq "inaccessible"} |%{$_.reload()}