<#
.SYNOPSIS
    Implements STIG WN10-CC-000350: Disallow unencrypted WinRM traffic.

.NOTES
    Author          : Daniel Christopher
    LinkedIn        : linkedin.com/in/danchristopher/
    GitHub          : github.com/danchristopher02
    Date Created    : 2025-10-09
    Last Modified   : 2025-10-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000350

.TESTED ON
    Date(s) Tested  : 2025-10-09
    Tested By       : Daniel Christopher
    Systems Tested  : Azure Windows 10 VM
    PowerShell Ver. : 

.USAGE
    Open PowerShell and run script.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000350).ps1 
#>


# Define registry parameters
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service"
$valueName = "AllowUnencryptedTraffic"
$desiredValue = 0

# Ensure the registry path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Create or update the registry value
$currentValue = (Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue).$valueName

if ($null -eq $currentValue) {
    Write-Host "Creating registry value '$valueName' and setting it to $desiredValue..."
    New-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
} elseif ($currentValue -ne $desiredValue) {
    Write-Host "Updating registry value '$valueName' from $currentValue to $desiredValue..."
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue
} else {
    Write-Host "Registry value '$valueName' is already set to the correct value ($desiredValue)."
}

# Verify the change
$verify = (Get-ItemProperty -Path $registryPath -Name $valueName).$valueName
if ($verify -eq $desiredValue) {
    Write-Host "STIG WN10-CC-000350 successfully implemented. AllowUnencryptedTraffic = $verify"
} else {
    Write-Host "Failed to set AllowUnencryptedTraffic. Current value: $verify"
}
