Connect-VIServer -Server vcenterprimary.srv.hcvlny.cv.net -User ddilwort -Password R@dsk1nz
$report = @()
# $clusterName = "MyCluster"  $clusterName = "*"
$clusterName = "CLD3-HWR"
$report = foreach($cluster in Get-Cluster -Name $clusterName){
    $esx = $cluster | Get-VMHost 
    $ds = Get-Datastore -VMHost $esx | where {$_.Type -eq "VMFS" -and $_.Extensiondata.Summary.MultipleHostAccess}

    New-Object PSObject -Property @{
        VCname = $cluster.Uid.Split(':@')[1]
        DCname = (Get-Datacenter -Cluster $cluster).Name
        Clustername = $cluster.Name
        "Number of hosts" = $esx.Count
        "Total Processors" = ($esx | measure -InputObject {$_.Extensiondata.Summary.Hardware.NumCpuPkgs} -Sum).Sum
        "Total Cores" = ($esx | measure -InputObject {$_.Extensiondata.Summary.Hardware.NumCpuCores} -Sum).Sum
        "Current CPU Failover Capacity" = $cluster.Extensiondata.Summary.AdmissionControlInfo.CurrentCpuFailoverResourcesPercent
        "Current Memory Failover Capacity" = $cluster.Extensiondata.Summary.AdmissionControlInfo.CurrentMemoryFailoverResourcesPercent
        "Configured Failover Capacity" = $cluster.Extensiondata.ConfigurationEx.DasConfig.FailoverLevel
        "Migration Automation Level" = $cluster.Extensiondata.ConfigurationEx.DrsConfig.DefaultVmBehavior
        "DRS Recommendations" = &{$result = $cluster.Extensiondata.Recommendation | %{$_.Reason};if($result){[string]::Join(',',$result)}}
        "DRS Faults" = &{$result = $cluster.Extensiondata.drsFault | %{$_.Reason};if($result){[string]::Join(',',$result)}}
        "Migration Threshold" = $cluster.Extensiondata.ConfigurationEx.DrsConfig.VmotionRate
        "target hosts load standard deviation" = "NA"
        "Current host load standard deviation" = "NA"        
        "Total Physical Memory (MB)" = ($esx | Measure-Object -Property MemoryTotalMB -Sum).Sum
        "Configured Memory MB" = ($esx | Measure-Object -Property MemoryUsageMB -Sum).Sum
        "Available Memroy (MB)" = ($esx | Measure-Object -InputObject {$_.MemoryTotalMB - $_.MemoryUsageMB} -Sum).Sum
        "Total CPU (Mhz)" = ($esx | Measure-Object -Property CpuTotalMhz -Sum).Sum
        "Configured CPU (Mhz)" = ($esx | Measure-Object -Property CpuUsageMhz -Sum).Sum
        "Available CPU (Mhz)" = ($esx | Measure-Object -InputObject {$_.CpuTotalMhz - $_.CpuUsageMhz} -Sum).Sum
        "Total Disk Space (MB)" = ($ds | where {$_.Type -eq "VMFS"} | Measure-Object -Property CapacityMB -Sum).Sum
        "Configured Disk Space (MB)" = ($ds | Measure-Object -InputObject {$_.CapacityMB - $_.FreeSpaceMB} -Sum).Sum
        "Available Disk Space (MB)" = ($ds | Measure-Object -Property FreeSpaceMB -Sum).Sum
    }
}
$report | Export-Csv "C:\Cluster-Report.csv" -NoTypeInformation -UseCulture 