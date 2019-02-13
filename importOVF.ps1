#Connect-VIServer -Server cld3-c5-b8.srv.hcvlny. -User root -Password r00t123
Connect-VIServer -Server cld2-vbprod-c1-b5.vsf5-2.hcvlny.dhg. -User root -Password V1rtu@1c3!
# Import a vApp directly into Esxi hhost
#Import-vApp -Source c:\Images\vdhcptemplate.srv.hcvlny.\vdhcptemplate.srv.hcvlny..ovf -VMHost cld1-c3-b1.srv.hcvlny. -Name vdhcpred1.srv.hcvlny.
Import-vApp -Source c:\iso_images\voptid1.vsf5-2.hcvlny.dhg.\voptid1.vsf5-2.hcvlny.dhg..ovf -VMHost cld2-vbprod-c1-b5.vsf5-2.hcvlny.dhg. -Name voptid2.vsf5-2.hcvlny.dhg. -Datastore CLD2-VBPROD-hcvlny-2-OS2 -RunAsync
#Get-NetworkAdapter -VM dhcpbisc1-vm.srv.hcvlny.c