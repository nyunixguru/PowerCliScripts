#$esx = "10.248.132.167"
#$host = "snoc2-c5-b1"
Connect-VIServer -Server vcenterpri -User ddilwort -Password R@
#Get-Cluster
#Get-VMHost | Get.103-VMHostNetwork | Set-VMHostNetwork -DnsAddress "167.206.7.3","167.206.1.103"
#$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server snoc2-c5-b$i --username root --password r00t123 --show"
#Invoke-expression $expression
#1..8 | Foreach-Object {Add-VMHost smapp-c7-b$_ -Location SMAPP3 -User root -Password r00t123 -force:$true}

1..8 | Foreach-Object { Set-VMHost -VMhost smapp-c7-b$_. -State Maintenance }




