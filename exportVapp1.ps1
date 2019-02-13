Connect-VIServer cld1-c1-b5.srv.whplny.cv.net -User root -Password r00t123
Export-VApp -Destination "c:\" -VM vdhcphsd15.srv.whplny.cv.net -Name vdhcphsd.srv.whplny.cv.net -RunAsync