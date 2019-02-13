

Connect-VIServer -Server cld3-c -User root -Password r00


Start-VM -VM  rfd -Kill -Confirm:$false
