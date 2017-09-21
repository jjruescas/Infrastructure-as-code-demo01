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

####################
## Functions ##
####################

####################
## Default Values ##
####################
## Install PowerShell Modules ##
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

$ModulesNames = @('PackageManagement', 
                    'PowerShellGet', 
                    'xComputerManagement', 
                    'xNetworking', 
                    'xPSDesiredStateConfiguration', 
                    'xRemoteDesktopAdmin', 
                    'xSystemSecurity',
                    'PolicyFileEditor')

$ModulesNames | ForEach {
    Write-Host "Installing Package $_" -f Cyan
    Install-Module -Name $_ -Force
}

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

