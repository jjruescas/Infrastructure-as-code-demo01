<#
.SYNOPSIS
Script to configure a DB Server.
.DESCRIPTION
Script to configure a DB Server.
The script performs the following operations:
Enable PS Logging
Set Network configuration
Expand C Disk
Create and format new volumes
Set LCM Configuration
Set Folder Permissions
Set Windows Features
.PARAMETER NodeName
Hostname of the machine where the configuration will be applied.
.EXAMPLE
DSC-Configuration-Demo.ps1
#>
param
(    
    [string]$NodeName = $ENV:computername
)

####################
## Imports ##
####################
Import-Module .\Abila-PS-Modules\Abila-Common-Functions.psm1

####################
## Functions ##
####################

####################
## Default Values ##
####################
## Install PowerShell Modules ##
Install-PackageProviderAndModules

## DSCAPCServer Configuration ##
$configData = @{
AllNodes = @(
  @{ 
    NodeName = $ENV:computername; 
    PsDscAllowPlaintextPassword = $true        
  })
}

. .\DSC-Configuration-Demo.ps1

Write-Host "Executing DscMainConfig Configuration..." -f Cyan
DscMainConfig -configurationdata $configData
Start-DscConfiguration -Wait -Verbose -Path .\DscMainConfig  -force

