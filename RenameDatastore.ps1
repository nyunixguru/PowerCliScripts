﻿

Connect-VIServer -Server cld1-c3-b1 -User root -Password r0
Get-Datastore -Name CLD1-HCVLNY-OS011 | Set-Datastore -Name CLD1-HCVLNY-OS11
