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

# Install Powershell Modules
$ModulesNames | ForEach {
    Write-Host "Installing Package $_" -f Cyan
    Install-Module -Name $_ -Force
}

## DSC Web Server Configuration ##
$configData = @{
AllNodes = @(
  @{ 
    NodeName = $ENV:computername; 
    PsDscAllowPlaintextPassword = $true        
  })
}

.  $PSScriptRoot\DSC-WebServer.ps1

Write-Host "Executing DscWebServer Configuration..." -f Cyan
DscWebServer -configurationdata $configData
Start-DscConfiguration -Wait -Verbose -Path .\DscWebServer  -force

