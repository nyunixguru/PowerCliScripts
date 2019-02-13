
Connect-VIServer -Server 192.168.1.20 -User root -Password vmware
New-VM -Name ServerClone -VM Server -VMHost 192.168.1.3