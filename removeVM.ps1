

Connect-VIServer -Server cld3-c5-b8.srv.hcvlny.cv.net  -User root -Password r00t123

Stop-VM -VM ipmgmt4.hesv.hcvlny.dhg.cv.net
Remove-VM -VM   ipmgmt4.hesv.hcvlny.dhg.cv.net -DeletePermanently
#Remove-Inventory -Item  WebServerTest -Server 192.168.1.3