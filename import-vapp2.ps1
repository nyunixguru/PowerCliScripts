Connect-VIServer -Server vcenterpr -User ddilwort -Password R@
#Import-vApp -Source "d:\ISO_Images\vdhcphs\vdhcphsd13t.ovf" -Name vdhcphsd14.net -VMHost cld1-c1net -Datastore cld1-prnynj-os08
New-VM -Name vdhcphsd20.srvnet -VM  vdhcphsd14cv.net -Datastore CLD1-PRNYNJ-OS09 -VMHost cld1-c2.net
