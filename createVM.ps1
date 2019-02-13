

Connect-VIServer -Server 192.168.1.3 -User root -Password r00t123


#New-VM -Name WebServer -MemoryMB 1024 -NumCpu 2 -DiskMB 2048 -CD -Version v8 -NetworkName RedNet -Template RHEL6.4_80GB_Disk_Template -OSCustomizationspec RHEL6.4_80GB_Disk_Template
New-VM -Name WebServer -MemoryMB 1024 -NumCpu 2 -DiskMB 2048 -CD -Version v8 -NetworkName RedNet