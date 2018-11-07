Write-Host "Install Nuget Package Provider" -f Cyan
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

ls
.  $PSScriptRoot\DSC-Configuration-Demo.ps1

Write-Host "Executing DscMainConfig Configuration..." -f Cyan
DscMainConfig -configurationdata $configData
Start-DscConfiguration -Wait -Verbose -Path .\DscMainConfig  -force

