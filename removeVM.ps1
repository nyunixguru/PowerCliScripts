

Connect-VIServer -Server cld3-  -User root -Password r0

Stop-VM -VM ipmgmt
Remove-VM -VM   ipmgmt -DeletePermanently
#Remove-Inventory -Item  WebServerTest -Server 192.168.1.3
