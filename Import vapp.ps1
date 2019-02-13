
Connect-VIServer cld1-c4-User root -Password r
Import-vApp -VMhost  cld1-c4- -Source "c:\vdhcphsd.srv.whplny.cv.net\vdhcp.net.ovf" -Name vdhcphsd14et `
-Datastore CLD1-HCVLNY-OS13
#Connect-VIServer emd2 -User root -Password 
#Import-vApp -VMhost  cld1-c1-b4net -Source  "d:\ISO_IMAGES\vdhcptemnet\vdhcptemplt.ovf" -Name  vemd2-oolstg004net `
#-Datastore EMD2-OS17
