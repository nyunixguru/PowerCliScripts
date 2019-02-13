# Change this parameter below
$esx = "10.248.132.183"
#$host = "snoc2-c5-b1"
Connect-VIServer -Server $esx -User root -Password r
Write-Host "Configuring Hostname and DNS Settings on $esx" -ForegroundColor Green
# Change this parameter below
Get-VMHost | Get-VMHostNetwork | Set-VMHostNetwork -HostName smapp-c7-b8
Get-VMHost | Get-VMHostNetwork | Set-VMHostNetwork -DnsAddress "167.206.7.3","167.206.1.103"
Get-VMHost | Get-VMHostNetwork | Set-VMHostNetwork -Domain srv.hcv -SearchDomain srv.hcvl, , hcvet
#Enable SSH
Write-Host "Enabling SSH on $esx" -ForegroundColor Green
Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Set-VMHostService -Policy "On"
Get-VMHostFirewallException | where {$_.Name -eq "SSH Server"} | Set-VMHostFirewallException -Enabled:$true
Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Start-VMHostService
#Enable TSM
Write-Host "Enabling TSM on $esx" -ForegroundColor Green
Get-VMHostService | where {$_.Key -eq "TSM"} | Set-VMHostService -Policy "On"
Get-VMHostService | where {$_.Key -eq "TSM"} | Start-VMHostService
 
#Configure NTP
Write-Host "Configuring NTP Servers on $esx" -ForegroundColor Green
Add-VMHostNTPServer -NtpServer time1.cv.net, time2.cv.net  -Confirm:$false
Write-Host "Configuring NTP Client Policy on $esx" -ForegroundColor Green
Get-VMHostService -VMHost $esx | where{$_.Key -eq "ntpd"} | Set-VMHostService -policy "on" -Confirm:$false
Write-Host "Restarting NTP Client on $esx" -ForegroundColor Green
Get-VMHostService -VMHost $esx | where{$_.Key -eq "ntpd"} | Restart-VMHostService -Confirm:$false
 
#Set Syslog 
Set-VMHostSysLogServer -SysLogServer udp://10.240.59.11:514,tcp://10.240.59.11:514,ssl://10.240.59.11:1514,udp://10.240.59.12:514,tcp://10.240.59.12:5140,tcp://10.240.59.12:9997
#Get-VMHostFirewallException -Name syslog (will be false)
# Enable syslog
Get-VMHostFirewallException -Name syslog | Set-VMHostFirewallException -Enabled $true

#Restart-VMHost -Force
# Disconnect from ESXi Host
#Disconnect-VIServer -Confirm:$False

#Add Esxi host to Vcenter
#                                          -Location  Clustername
#Add-VMHost cld3-c10-b1 -Location CLD3-HWR -User root -Password r00t123 -force:$true
#7..8 | Foreach-Object {Add-VMHost cld3-c10-b$_.-Location CLD3-HWR -User root -Password r -force:$true}

#Configure SNMP
$i = 8

# Create loop
Write-Host "Configuring SNMP Servers on $esx" -ForegroundColor Green
$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server smapp-c7-b$i.srv.hcvlny.cv.net --username root --password r00t123 --show"
Invoke-expression $expression
$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server smapp-c7-b$i.srv.hcvlny.cv.net --username root --password r00t123 -c 'public,vmware'"
Invoke-expression $expression
$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server smapp-c7-b$i.srv.hcvlny.cv.net --username root --password r00t123 -t '172.16.30.111@162/public,172.16.30.111@162/vmware'"
Invoke-expression $expression
 $expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server smapp-c7-b$i.srv.hcvlny.cv.net --username root --password r00t123 -p 161"
Invoke-expression $expression
$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server smapp-c7-b$i.srv.hcvlny.cv.net --username root --password r00t123 --enable"
Invoke-expression $expression
$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server smapp-c7-b$i.srv.hcvlny.cv.net --username root --password r00t123 --show"
Invoke-expression $expression

#Configure Vmotion IP
#New-VMHostNetworkAdapter -VMHost "<HOST>" -PortGroup "<PORTGROUP>" -VirtualSwitch "dvSwitch Lab" -IP <IP> -SubnetMask <MASK> -VMotionEnabled:$true
