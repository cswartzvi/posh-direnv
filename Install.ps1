#
# posh-direnv for PowerShell
#
# Installation script
#

$PowerShellProfile = $PROFILE.CurrentUserAllHosts
$PowerShellPath = Split-Path $PowerShellProfile

Import-LocalizedData -BaseDirectory ".\posh-direnv" -FileName "posh-direnv.psd1" -BindingVariable Data
$ModuleVersion = $Data.ModuleVersion

$InstallationDirectory = Join-Path $PowerShellPath Modules
$InstallationPath = Join-Path $InstallationDirectory "posh-direnv"
$InstallationPath = Join-Path $InstallationPath $ModuleVersion


if (!(Test-Path $InstallationDirectory))
{
    Write-Host "Creating directory: $InstallationDirectory"
    New-Item -ItemType Directory -Force -Path $InstallationDirectory
}

if (Test-Path $InstallationPath) {
    Write-Host "Removing previously installed version $ModuleVersion"
    Remove-Item -Recurse -Force $InstallationPath
}

Copy-Item -Recurse ".\posh-direnv" $InstallationPath

if (!(Test-Path $PowerShellProfile))
{
    Copy-Item Profile.ps1 $PowerShellProfile
}
else
{
    $From = Get-Content -Path Profile.ps1

    if(!(Select-String -SimpleMatch "posh-direnv" -Path $PowerShellProfile))
    {
        Add-Content -Path $PowerShellProfile -Value "`r`n"
        Add-Content -Path $PowerShellProfile -Value $From
    }
}

Write-Host "Installation complete. Please restart PowerShell to use posh-direnv"
Write-Host