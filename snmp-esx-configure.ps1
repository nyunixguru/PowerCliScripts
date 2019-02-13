# Example how you can use PowerCLI to run VMware vSphere CLI
# Perl scripts
. c:\Users\ddilwort\Documents\Add-vCLIfunction.ps1
$env:VI_USERNAME="root"
$env:VI_PASSWORD="r00t123"
vicfg-snmp --show
#Get-VMHost | ForEach-Object {
#  vicfg-nics -l --server $_.Name
}