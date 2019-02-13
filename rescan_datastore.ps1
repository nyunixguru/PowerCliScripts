
Connect-VIServer -Server cld1-c3 -User root -Password r00
Get-VMHostStorage -RescanAllHba -RescanVmfs
