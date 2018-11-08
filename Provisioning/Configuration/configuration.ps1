#Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#Install Git
choco install git.install -y

#Install Notepadpluplus
choco install notepadplusplus -y

#Install Google Chrome
choco install googlechrome -y