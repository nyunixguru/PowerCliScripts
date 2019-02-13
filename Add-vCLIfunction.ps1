function Add-vCLIfunction {
  <#
  .SYNOPSIS
    Adds the VMware vSphere Command-Line Interface Perl scripts
    as PowerCLI functions.
 
  .DESCRIPTION
    Adds all the VMware vSphere Command-Line Interface Perl
    scripts as PowerCLI functions.
    VMware vSphere Command-Line Interface has to be installed on
    the system where you run this function.
    You can download the VMware vSphere Command-Line Interface
    from:
 
http://communities.vmware.com/community/vmtn/server/vsphere/automationtools/vsphere_cli?view=overview
 
  .EXAMPLE
    Add-vCLIfunction
    Adds all the VMware vSphere Command-Line Interface Perl
    scripts as PowerCLI functions to your PowerCLI session.
 
  .COMPONENT
    VMware vSphere PowerCLI
 
  .NOTES
    Author:  Robert van den Nieuwendijk
    Date:    22-04-2013
    Version: 1.1
    
  .LINK
    http://rvdnieuwendijk.com/
    
  #>
 
  process {
    # Test if VMware vSphere Command-Line Interface is installed
    if (${env:ProgramFiles(x86)})
    {
      $ProgramFiles = ${env:ProgramFiles(x86)}
    }
    else
    {
      $ProgramFiles = $env:ProgramFiles
    }
    $vCLIBinDirectory = "$ProgramFiles\VMware\VMware vSphere CLI\Bin\"
    If (-not (Test-Path -Path $vCLIBinDirectory)) {
      Write-Error "VMware vSphere CLI should be installed before running this function."
    }
    else {
      # Add all the VMware vSphere CLI perl scripts as PowerCLI
      # functions
      Get-ChildItem -Path "$vCLIBinDirectory\*.pl" |
      ForEach-Object {
        $Function = "function global:$($_.Name.Split('.')[0]) { perl '$vCLIBinDirectory\$($_.Name)'"
        $Function += ' $args }'
        Invoke-Expression $Function
      }
    }
  }
}