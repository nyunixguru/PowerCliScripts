

Connect-VIServer -Server cld1-c3-b1.srv.hcvlny.cv.net -User root -Password r00t123
Get-Datastore -Name CLD1-HCVLNY-OS011 | Set-Datastore -Name CLD1-HCVLNY-OS11