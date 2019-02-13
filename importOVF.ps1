#Connect-VIServer -Server cld3-c5-b8.srv.hcvlny.cv.net -User root -Password r00t123
Connect-VIServer -Server cld2-vbprod-c1-b5.vsf5-2.hcvlny.dhg.cv.net -User root -Password V1rtu@1c3!
# Import a vApp directly into Esxi hhost
#Import-vApp -Source c:\Images\vdhcptemplate.srv.hcvlny.cv.net\vdhcptemplate.srv.hcvlny.cv.net.ovf -VMHost cld1-c3-b1.srv.hcvlny.cv.net -Name vdhcpred1.srv.hcvlny.cv.net
Import-vApp -Source c:\iso_images\voptid1.vsf5-2.hcvlny.dhg.cv.net\voptid1.vsf5-2.hcvlny.dhg.cv.net.ovf -VMHost cld2-vbprod-c1-b5.vsf5-2.hcvlny.dhg.cv.net -Name voptid2.vsf5-2.hcvlny.dhg.cv.net -Datastore CLD2-VBPROD-hcvlny-2-OS2 -RunAsync
#Get-NetworkAdapter -VM dhcpbisc1-vm.srv.hcvlny.c