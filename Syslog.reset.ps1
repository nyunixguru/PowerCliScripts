$esx = "10.248.132.183"
Connect-VIServer -Server $esx -User root -Password r00t123
#Set Syslog 
#Set-VMHostSysLogServer -SysLogServer udp://10.5.69.174:514,tcp://10.5.69.174:514,ssl://10.5.69.174:1514,tcp://10.252.11.72:1514,tcp://10.252.11.77:1514,tcp://10.252.11.78:1514,tcp://10.252.11.79:1514,tcp://10.252.11.80:1514,tcp://10.252.11.81:1514,tcp://10.252.11.85:1514,tcp://10.252.11.89:1514,tcp://10.252.11.90:1514,tcp://10.252.11.92:1514,tcp://10.252.11.93:1514
Set-VMHostSysLogServer -SysLogServer udp://10.240.59.11:514,tcp://10.240.59.11:514,ssl://10.240.59.11:1514,udp://10.240.59.12:514,tcp://10.240.59.12:5140,tcp://10.240.59.12:9997
#Get-VMHostFirewallException -Name syslog (will be false)
# Enable syslog
#Get-VMHostFirewallException -Name syslog | Set-VMHostFirewallException -Enabled $true
