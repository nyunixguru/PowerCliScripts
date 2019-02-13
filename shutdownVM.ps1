

Connect-VIServer -Server cld3-c4-b8.srv.hcvlny.cv.net -User root -Password r00t123


Start-VM -VM  rfdn.srv.hcvlny.cv.net -Kill -Confirm:$false