

#Connect-VIServer -Server cld2-vbprod-c1-b6.vsf5-2.hcvlny.dhg.cv.net -User root -Password V1rtu@1c3!

Connect-VIServer -Server cld3-c5-b8.srv.hcvlny.cv.net -User root -Password r00t123
#Get-VM
Start-VM -VM  ipmgmt4.hesv.hcvlny.dhg.cv.net -Confirm:$false
#Mount-Tools vdhcpred2.srv.hcvlny.cv.net