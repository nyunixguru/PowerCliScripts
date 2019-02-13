

Connect-VIServer -Server cld3-c3-b8.srv.hcvlny.cv.net -User root -Password r00t123

#Stop-VM -VM ipmgmt3.hesv.hcvlny.dhg.cv.net
Set-VM -VM ipmgmt3.hesv.hcvlny.dhg.cv.net  -MemoryGB 20