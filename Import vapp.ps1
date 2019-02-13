
Connect-VIServer cld1-c4-b1.srv.hcvlny.cv.net -User root -Password r00t123
Import-vApp -VMhost  cld1-c4-b1.srv.hcvlny.cv.net -Source "c:\vdhcphsd.srv.whplny.cv.net\vdhcphsd.srv.whplny.cv.net.ovf" -Name vdhcphsd14.srv.hcvlny.cv.net `
-Datastore CLD1-HCVLNY-OS13
#Connect-VIServer emd2-c10-b3.srv.hcvlny.cv.net -User root -Password r00t123
#Import-vApp -VMhost  cld1-c1-b4.srv.prnynj.cv.net -Source  "d:\ISO_IMAGES\vdhcptemplate.srv.hcvlny.cv.net\vdhcptemplate.srv.hcvlny.cv.net.ovf" -Name  vemd2-oolstg004.srv.hcvlny.cv.net `
#-Datastore EMD2-OS17