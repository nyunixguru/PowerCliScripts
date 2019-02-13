    # SAMPLE - Change variables for your Site
    #
    # VMware PowerCLI Script to configure a VMware ESXi Host
    # Designed for VMware ESXi on HP 460c G6 Blades
    # But should work for most hosts with some variable changes
    # Will work with an IP address but the storage will be renamed to XX.XX.XX.X-LOCAL instead of HOSTNAME-LOCAL
    # Host should be deployed from ISO
    # Assumes root password and IP Details configured (IP, DNS and search suffix)
    # At that point when the host is on the network this script can be run
    # Once this script is complete, add the host to vCenter and reboot the host and
    # then validate the host is configured correctly.
    #
    # John Gibson - March 2010
    # version 1.0 - Initial script creation
    # version 1.1 - Updated script to set DNS Settings on Hosts
    # version 1.2 - Updated script and structure of script
    #
     
    # Set Variables to be used in the ESXi Host configuration
    #
    # Modify these settings for regional requirements
    #
     
    # ESXi Host Patch repository where the offline bundles have been extracted to
    $patchURL = "http://servername.fqdn"
     
    # NTP Time Servers to use
    $ntp1 = "your.NTP.Server1.fqdn"
    $ntp2 = "your.NTP.Server1.fqdn"
     
    # DNS Search Details to use
    $DomainName = "host.dns.doman.name"
    $DNSSearch = "host.dns.search.name"
    $PreferredDNS = "x.x.x.x"
    $AltDNS = "x.x.x.x"
     
    # These NICs are connected to the management network vSwitch0
    $esxnics = "vmnic0","vmnic1"
     
    # This/these NICs are connected to the VM network vSwitch1
    $vmnics = "vmnic2","vmnic3"
     
    # VMotion Subnet Mask
    $VMotionSubnet = "255.255.255.0"
     
    # Local Accounts to be created with VMware Admin Rights
    # Note: Complex passwords are needed or ESXi will reject them
    $vmadminaccount = "vmadmin"
    $vmadminpassword = "C0mp1exPassw0rd"
    $vmopsaccount = "vmops"
    $vmopspassword = "C0mp1exPassw0rd"
    $eccuserpassword = "C0mp1exPassw0rd"
     
    Write-Host "ESXi Configuration script for VMware ESXi Hosts for HP Servers"
     
    # Capture unique variables for the ESXi Host by user input
    $vmhost=(Read-Host "Enter just the name of the ESXi Host (e.g. hostname)").ToLower()
    $HostPassword=Read-Host "Enter the password to the root account on the ESXi Host"
    $VMotionIP=Read-Host "Enter the VMotion IP address for this ESX Host (x.x.x.x)"
    $vSwitch1Name=Read-Host "Enter the name of the Virtual Machine network (e.g. 192.168.10.1 Subnet)"
    $vSwitch1VLAN=Read-Host "Enter the number of the Virtual Machine VLAN (0 if not trunked)"
    if ("0" -ne $vSwitch1VLAN){
    $vSwitch1Name2=Read-Host "Enter the name of the Second Virtual Machine network (Press 0 to skip)"
    if ("0" -ne $vSwitch1Name2){	
    $vSwitch1VLAN2=Read-Host "Enter the number of the Second Virtual Machine VLAN"
    }
    }
     
    # Authenticate to ESX Host...
    write-host "Connecting to " $vmhost
    $esxhost = Connect-VIServer $vmhost -User root -Password $HostPassword
     
    # First puts the ESX host into maintenance mode...
    write-host "Entering Maintenance Mode"
    Set-VMHost -State maintenance
     
    # Configure vSwitch0
    write-host "Configuring vSwitch0"
    $vs0 = Get-VirtualSwitch -Name vSwitch0
    Set-VirtualSwitch -VirtualSwitch $vs0 -Nic $esxnics
    New-VMHostNetworkAdapter -PortGroup VMkernel -VirtualSwitch $vs0 -IP $VMotionIP -SubnetMask $VMotionSubnet -VMotionEnabled: $true
     
    # Removes "VM Network" from the vSwitch0
    get-VirtualPortGroup | where { $_.Name -like "VM Network"} | Remove-VirtualPortGroup -Confirm:$false
     
    # Configure vSwitch1
    write-host "Configuring vSwitch1"
    $vs1 = New-VirtualSwitch -Name vSwitch1 -nic $vmnics
    write-host "Configuring " $vSwitch1Name
    New-VirtualPortGroup -VirtualSwitch $vs1 -Name $vSwitch1Name -VLanId $vSwitch1VLAN
    if ("0" -ne $vSwitch1VLAN){
    if ("0" -ne $vSwitch1Name2){	
    write-host "Configuring " $vSwitch1Name2
    New-VirtualPortGroup -VirtualSwitch $vs1 -Name $vSwitch1Name2 -VLanId $vSwitch1VLAN2
    }
    }
     
    # Configure vSwitch Security for all vSwitches
    write-host "Configuring vSwitch Security settings and enabling Beacon Probing for all vSwitches"
    foreach ($vswitchName in Get-VirtualSwitch $vmhost){
    $hostview = get-vmhost $vmhost | Get-View
    $ns = Get-View -Id $hostview.ConfigManager.NetworkSystem
    $vsConfig = $hostview.Config.Network.Vswitch | Where-Object { $_.Name -eq $vswitchName }
    $vsSpec = $vsConfig.Spec
    $vsSpec.Policy.NicTeaming.FailureCriteria.checkBeacon = $true
    $vsSpec.Policy.Security.AllowPromiscuous = $False
    $vsSpec.Policy.Security.forgedTransmits = $False
    $vsSpec.Policy.Security.macChanges = $False
    $ns.UpdateVirtualSwitch( $VSwitchName, $vsSpec)
    }
     
    # Set-up the NTP Configuration
    write-host "Adding NTP Servers"
    Add-VmHostNtpServer -NtpServer $ntp1,$ntp2
     
    # Set DNS Details to ensure they have been set
    write-host "Resetting DNS Details"
    $vmHostNetworkInfo = Get-VmHostNetwork -VMHost $vmhost
    Set-VmHostNetwork -Network $vmHostNetworkInfo -DomainName $DomainName -SearchDomain $DNSSearch
    Set-VmHostNetwork -Network $vmHostNetworkInfo -DnsAddress $PreferredDNS, $AltDNS
     
    # Rename Local Datastore
    $LocalName = $vmhost.ToUpper()
    Get-Datastore -Name "datastore1" | Set-Datastore -Name $LocalName"-LOCAL"
     
    # Create Local Accounts
    write-host "Configuring local ESXi account for " $vmadminaccount
    New-VMHostAccount -Group $vmadminaccount
    New-VMHostAccount -User -Id $vmadminaccount -Password $vmadminpassword -Description "VMware Local ESXi Administrator" -AssignGroups $vmadminaccount
    $sgAuthMgr = Get-View (Get-View ServiceInstance).Content.AuthorizationManager
    $sgEntity = Get-Folder ha-folder-root | Get-View
    $sgPerm = New-Object VMware.Vim.Permission
    $sgPerm.entity = $sgEntity.MoRef
    $sgPerm.group = $true
    $sgPerm.principal = $vmadminaccount
    $sgPerm.propagate = $true
    $sgPerm.roleId = ($sgAuthMgr.RoleList | where {$_.Name -eq "Admin"}).RoleId
    $sgAuthMgr.SetEntityPermissions($sgEntity.MoRef,$sgPerm)
     
    write-host "Configuring local ESXi account for " $vmopsaccount
    New-VMHostAccount -Group $vmopsaccount
    New-VMHostAccount -User -Id $vmopsaccount -Password $vmopspassword -Description "VMware Local ESXi Operations Administrator" -AssignGroups $vmopsaccount
    $sgAuthMgr = Get-View (Get-View ServiceInstance).Content.AuthorizationManager
    $sgEntity = Get-Folder ha-folder-root | Get-View
    $sgPerm = New-Object VMware.Vim.Permission
    $sgPerm.entity = $sgEntity.MoRef
    $sgPerm.group = $true
    $sgPerm.principal = $vmopsaccount
    $sgPerm.propagate = $true
    $sgPerm.roleId = ($sgAuthMgr.RoleList | where {$_.Name -eq "Admin"}).RoleId
    $sgAuthMgr.SetEntityPermissions($sgEntity.MoRef,$sgPerm)
     
    # Create Account for EMC ECC Control Centre
     
    write-host "Configuring account for EMC ECC ControlCenter"
    $sgRole = New-VIRole -Name ControlCenter -Privilege ( Get-VIPrivilege -PrivilegeItem "Browse datastore" )
    New-VMHostAccount -Group ControlCenter
    New-VMHostAccount -User -Id eccuser -Password $eccuserpassword -Description "EMC ControlCenter discovery" -AssignGroups "ControlCenter"
    $sgAuthMgr = Get-View (Get-View ServiceInstance).Content.AuthorizationManager
    $sgEntity = Get-Folder ha-folder-root | Get-View
    $sgPerm = New-Object VMware.Vim.Permission
    $sgPerm.entity = $sgEntity.MoRef
    $sgPerm.group = $true
    $sgPerm.principal = "ControlCenter"
    $sgPerm.propagate = $true
    $sgPerm.roleId = ($sgAuthMgr.RoleList | where {$_.Name -eq "ControlCenter"}).RoleId
    $sgAuthMgr.SetEntityPermissions($sgEntity.MoRef,$sgPerm)
     
    # Patch ESXi Host
    write-host "Patching ESXi Host"
    Install-VMHostPatch -VMhost $vmhost -HostUsername root -HostPassword $HostPassword -WebPath $patchURL/patch/ESXi400-201002001/metadata.zip
    Install-VMHostPatch -VMhost $vmhost -HostUsername root -HostPassword $HostPassword -WebPath $patchURL/patch/BCM-bnx2x-1.52.12.v40.3-offline_bundle-223054/metadata.zip
    Install-VMHostPatch -VMhost $vmhost -HostUsername root -HostPassword $HostPassword -WebPath $patchURL/patch/hp-esxi4.0uX-bundle-1.2/metadata.zip
     
    # Restart the ESXi Host
    write-host "Rebooting ESXi Host"
    Restart-VMHost -server $vmhost -confirm:$false
     
    # Disconnect from ESXi Host
    Disconnect-VIServer -Confirm:$False
     
    # Provide Post config Instructions
    write-host "The basic ESXi Host configuration is completed, please:"
    write-host "1. Wait for the host to reboot."
    write-host "2. Connect the Host to vCenter and assign a license"
    write-host "3. Verify the Host Configuration is correct"
    write-host "4. Confirm all patches have been applied (scan for updates)"
    Write-Host "5. Once complete take the ESXi host out of Maintenance Mode"
	
	
#SCRIPT #2 configure syslog
	
# This will automatically configure all hosts with the same syslog
# destination

get-vmhost | Set-VMHostAdvancedConfiguration -NameValue @{'Config.HostAgent.log.level'='info';'Vpx.Vpxa.config.log.level'='info';'Syslog.global.logHost'='udp://SYSLOG:514'}

or

Get-VMHost | Set-VMHostSysLogServer -SysLogServer 192.168.1.10 -SysLogServerPort 514



#SCRIPT #3 

# ESXi-Install-Script
# johnpuskar@gmail.com
# 02/02/2013
 
#PowerCLI
# Download -
# http://communities.vmware.com/community/vmtn/server/vsphere/automationtools/powercli
# Referece -
# http://pubs.vmware.com/vsphere-51/topic/com.vmware.vsphere.scripting.doc/GUID-7F7C5D15-9599-4423-821D-7B1FE87B3A96.html
 
#vSphere CLI (for snmp)
# Download -
# https://my.vmware.com/web/vmware/details?downloadGroup=VSP510-VCLI-510&productId=285
 
#VDSPowerCLI (no longer used)
# cmdlets download - http://labs.vmware.com/flings/vdspowercli
# http://blogs.vmware.com/vipowershell/2011/11/vsphere-distributed-switch-powercli-cmdlets.html
# not compatible with powercli 5.1!
 
#== Getting Started! ==
 
#== Variables ==
# Generic
$vCenterServer = "vcenter.domain.com"
$vmHostName = "vm1.domain.com"
$vSwitchName = "SAN-Switch"
$ntpHostname = "ntp.domain.com"
$snmpTrapReceiver = "opsmgr.domain.com"
$snmpTrapCommunity = "public"
$omsaPath = "/vmfs/volumes/san-esx0-lun0/VIBs/OM-SrvAdmin-Dell-Web-7.1.0-5304.VIB-ESX50i_A00/metadata.zip"
# Port Groups
$arrPGsToCreate = @()
$arrPGsToCreate += New-Object –TypeName PSObject –Prop (@{"Name" = "100_san1";"VLAN" = "100"})
$arrPGsToCreate += New-Object –TypeName PSObject –Prop (@{"Name" = "200_san2";"VLAN" = "200"})
$arrPGsToCreate += New-Object –TypeName PSObject –Prop (@{"Name" = "100_san1-vmk1";"VLAN" = "100"})
$arrPGsToCreate += New-Object –TypeName PSObject –Prop (@{"Name" = "200_san2-vmk1";"VLAN" = "200"})
$arrPGsToCreate += New-Object –TypeName PSObject –Prop (@{"Name" = "100_san1-vmk2";"VLAN" = "100"})
$arrPGsToCreate += New-Object –TypeName PSObject –Prop (@{"Name" = "200_san2-vmk2";"VLAN" = "200"})
$arrPGsToCreate += New-Object –TypeName PSObject –Prop (@{"Name" = "300_nfs";"VLAN" = "300"})
$arrPGsToCreate += New-Object –TypeName PSObject –Prop (@{"Name" = "400_vmotion";"VLAN" = "400"})
$arrPGsToCreate += New-Object –TypeName PSObject –Prop (@{"Name" = "401_ft";"VLAN" = "401"})
# VMKernels
$arrVMKsToCreate = @()
$arrVMKsToCreate += New-Object –TypeName PSObject –Prop (@{"PGName" = "100_san1-vmk1";"IP" = "x.x.x.x";"subnet" = "255.255.255.0"})
$arrVMKsToCreate += New-Object –TypeName PSObject –Prop (@{"PGName" = "200_san2-vmk1";"IP" = "x.x.x.x";"subnet" = "255.255.255.0"})
$arrVMKsToCreate += New-Object –TypeName PSObject –Prop (@{"PGName" = "300_pan";"IP" = "x.x.x.x";"subnet" = "255.255.255.0"})
$arrVMKsToCreate += New-Object –TypeName PSObject –Prop (@{"PGName" = "400_vmotion";"IP" = "x.xx.x";"subnet" = "255.255.255.0"})
$arrVMKsToCreate += New-Object –TypeName PSObject –Prop (@{"PGName" = "401_ft";"IP" = "x.x.x.x";"subnet" = "255.255.255.0"})
# iSCSI Targets
$arrIScsiTargetsInfo = @()
$arrIScsiTargetsInfo += New-Object –TypeName PSObject –Prop (@{"Address" = "x.x.x.x";"Type" = "send"})
$arrIScsiTargetsInfo += New-Object –TypeName PSObject –Prop (@{"Address" = "x.x.x.x";"Type" = "send"})
$arrIScsiTargetsInfo += New-Object –TypeName PSObject –Prop (@{"Address" = "x.x.x.x";"Type" = "send"})
$arrIScsiTargetsInfo += New-Object –TypeName PSObject –Prop (@{"Address" = "x.x.x.x";"Type" = "send"})
#NFS Targets
$arrNfsDatastores = @()
$arrNfsDatastores += New-Object -TypeName PSObject -Prop (@{"Name" = "vdr-backups"; "Path" = "/mnt/dataon1/vdrbackups/vdrbackups/"; "Host" = "10.146.232.113"})
 
#==== Do the Work ====
#Get the host password (for SNMP)
$rootPass = Read-Host -Prompt "Enter host root password" -AsSecureString
 
#Connect to vCenter Server
$VCUserCredentials = Get-Credential
Connect-VIServer -Server vCenterServer -Protocol "https" -Credential $VCUserCredentials
 
$vmHost = Get-VMHost -Name $vmHostName
$oCLI = Get-ESXCli -vmhost $vmHost
 
#Put the host in maintenance mode
Set-VMHost -VMhost $vmHost -State "Maintenance"
 
#Create the SAN virtual switch
$vs = New-VirtualSwitch -VMHost $vmHost -Name $vSwitchName
 
#Create the Port Groups
$arrPGsToCreate | % {New-VirtualPortGroup -VirtualSwitch $vs -Name $_.Name -VLanId $_.VLAN}
 
#Create SAN, vMotion, FT, and NFS vmkernels
$arrVMKsToCreate | % {New-VMHostNetworkAdapter -VMHost $vmHost -PortGroup $_.PGName -VirtualSwitch $vs -IP $_.IP -SubnetMask $_.subnet}
 
#Enable SSH
$vmHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Set-VMHostService -Policy "On"
$vmHost | Get-VMHostFirewallException | where {$_.Name -eq "SSH Server"} | Set-VMHostFirewallException -Enabled:$true
$vmHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Start-VMHostService
 
#Enable ESXi Service Console
$vmHost | Get-VMHostService | where {$_.Key -eq "TSM"} | Set-VMHostService -Policy "On"
$vmHost | Get-VMHostService | where {$_.Key -eq "TSM"} | Start-VMHostService
 
#Disable SSH Warnings
Set-VmHostAdvancedConfiguration -vmhost $vmhost -Name UserVars.SuppressShellWarning -Value ( [system.int32] 1 )
 
#Set NTP Server and Enable
Add-VmHostNtpServer -NtpServer $ntpHostname -VMHost $vmHost
$vmHost | Get-VMHostService | where {$_.Key -eq "ntpd"} | Set-VMHostService -Policy "On"
$vmHost | Get-VMHostFirewallException | where {$_.Name -eq "NTP client"} | Set-VMHostFirewallException -Enabled:$true
$vmHost | Get-VMHostService | where {$_.Key -eq "ntpd"} | Start-VMHostService
 
# Enable software iSCSI HBA
$oCLI.iscsi.software.set($true)
Sleep -s 10
 
# Add iSCSI Targets
$IScsiHba = Get-VMHostHba -vmhost $vmHost -Type "iscsi"
$arrIScsiTargetsInfo | % {$IScsiHba | New-IScsiHbaTarget -Address $_.Address -type $_.Type}
 
#Add NFS Datastore
$nfsDatastores | % {New-Datastore -Nfs -VMHost $vmHost -Name $_.Name -Path $_.Path -NfsHost $_.Host}
 
#Install Dell OMSA
Install-VMHostPatch -vmhost $vmHost -HostPath $omsaPath
 
#Configure SNMP
$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server " + $vmHost.Name + " --username root --password " + $rootPass + " -t " + $snmpTrapReceiver + "@162/" + $snmpTrapCommunity
Invoke-Expression $expression
$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server " + $vmHost.Name + " --username root --password " + $rootPass + " --enable"
Invoke-Expression $expression
$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server " + $vmHost.Name + " --username root --password " + $rootPass + " --test"
Invoke-Expression $expression
 
#warn user of manual steps needed next
$msgs = @()
$msgs += "MANUAL STEPS REQUIRED:"
$msgs += " * Add vmnics to the vSwitches and Port Groups, and then test with vmkping."
$msgs += " * Bind vmk's to software iSCSI HBA."
$msgs += " * Give host's initiator access to LUNs on necessary iSCSI targets."
$msgs += " * Add host to VDS and configure dvUplinks"
$msgs += " * Migrate appropriate vmkernels to the VDS"
$msgs += " * Assign FT to the ft vmkernel"
$msgs += " * Assign mgmt traffic to PAN vmkernel"
$msgs += " * Assign vmotion to vmotion vmkernel"
$msgs | % {write-host -f yellow $_}
 
$go = $false
While ($go -eq $false)
    {$text = Read-Host "Type 'continue' when the steps are complete."; If($text -eq "continue"){$go = $true}}
 
# Configure round-robin multipathing policy on all iscsi paths
$oCLI.storage.nmp.path.list() | group-Object –Property Device | Where {$_.Name –like "naa*"} | %{$oCLI.storage.nmp.device.set($null, $_.Name, "VMW_PSP_RR")}
 
#Reboot host
Restart-VMHost -vmhost $vmHost -confirm:$false
 
#Exit maintenance mode
Set-VMHost -VMhost $vmHost -State "Connected"
 
# MANUAL STEP
# Attach update baselines
# Scan for updates
# Remediate updates

#Snippet for NTP

# Configure NTP Server
Add-VMHostNtpServer -VMHost $hostName -NtpServer "0.vmware.pool.ntp.org"
Add-VMHostNtpServer -VMHost $hostName -NtpServer "1.vmware.pool.ntp.org"
Add-VMHostNtpServer -VMHost $hostName -NtpServer "2.vmware.pool.ntp.org"



#Snippet

foreach ($esx in $esxHosts) {
	 
	   Write-Host "Configuring DNS and Domain Name on $esx" -ForegroundColor Green
	   Get-VMHostNetwork -VMHost $esx | Set-VMHostNetwork -DomainName $domainname -DNSAddress $dnspri , $dnsalt -Confirm:$false
	 
	    
	   Write-Host "Configuring NTP Servers on $esx" -ForegroundColor Green
	   Add-VMHostNTPServer -NtpServer $ntpone , $ntptwo -VMHost $esx -Confirm:$false
	 
	  
	   Write-Host "Configuring NTP Client Policy on $esx" -ForegroundColor Green
	   Get-VMHostService -VMHost $esx | where{$_.Key -eq "ntpd"} | Set-VMHostService -policy "on" -Confirm:$false
	 
	   Write-Host "Restarting NTP Client on $esx" -ForegroundColor Green
	   Get-VMHostService -VMHost $esx | where{$_.Key -eq "ntpd"} | Restart-VMHostService -Confirm:$false
	 
	}
	
	
	    Get-VMHost -Name [FQDN of ESXi host] | Get-VMHostNetwork | Set-VMHostNetwork -DnsAddress [DNS1 IP address],[DNS2 IP address]

You can also change other parameters, like the Domain and SearchDomain

    Get-VMHost | Get-VMHostNetwork | Set-VMHostNetwork -DnsAddress [DNS1 IP address],[DNS2 IP address] -Domain [Domain name] -SearchDomain [Search domain name]
	
	Get-VMHost | Get-VMHostNetwork | Set-VMHostNetwork -DnsAddress "10.0.0.1","10.0.0.2","10.0.0.3"
	Get-VMHost | Get-VMHostNetwork | Set-VMHostNetwork -DnsAddress [DNS1 IP address],[DNS2 IP address] -Domain [Domain name] -SearchDomain [Search domain name]
	

#Add new hosts to Vcenter must be connected to vcenter

1..20 | Foreach-Object { Add-VMHost esx$_.virten.lab -Location (Get-Datacenter Lab) -User root -Password <Password> -RunAsync -force:$true}

#By IP DNS Lookup
10..20 | ForEach-Object { [System.Net.Dns]::GetHostbyAddress("192.168.0.$_")  } | 
select-object HostName | ForEach-Object { Add-VMHost $_.HostName -Location (Get-Datacenter Lab) -User root -Password <Password> -RunAsync -force:$true }

#By text file with FQDN
Get-Content hosts.txt | Foreach-Object { Add-VMHost $_ -Location (Get-Datacenter Lab) -User root -Password <Password> -RunAsync -force:$true}