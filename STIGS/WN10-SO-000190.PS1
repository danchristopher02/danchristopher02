<#
.SYNOPSIS
    Certain encryption types are no longer considered secure. 
    This setting configures a minimum encryption type for Kerberos, preventing the use of the DES and RC4 encryption suites.

.NOTES
    Author          : Daniel Christopher
    LinkedIn        : linkedin.com/in/danchristopher/
    GitHub          : github.com/danchristopher02
    Date Created    : 2025-10-09
    Last Modified   : 2025-10-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000190

.TESTED ON
    Date(s) Tested  : 2025-10-09
    Tested By       : Daniel Christopher
    Systems Tested  : Azure Windows 10 VM
    PowerShell Ver. : 

.USAGE
    Open Powershell and run script.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-SO-000190).ps1 
#>


# STIG ID: WN10-SO-000190
# Purpose: Ensure Kerberos SupportedEncryptionTypes is set to 0x7ffffff8 (2147483640)
# Registry Path: HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters

# Define registry details
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters"
$ValueName = "SupportedEncryptionTypes"
$ValueType = "DWord"
$DesiredValue = 2147483640

# Check if the registry path exists; if not, create it
if (-not (Test-Path $RegPath)) {
    Write-Host "Registry path not found. Creating path..."
    New-Item -Path $RegPath -Force | Out-Null
}

# Get current value (if it exists)
try {
    $CurrentValue = (Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction Stop).$ValueName
    Write-Host "Current SupportedEncryptionTypes value: $CurrentValue"
} catch {
    Write-Host "SupportedEncryptionTypes not found. It will be created."
    $CurrentValue = $null
}

# Compare and set value if necessary
if ($CurrentValue -ne $DesiredValue) {
    Write-Host "Setting SupportedEncryptionTypes to $DesiredValue (0x7ffffff8)..."
    New-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -PropertyType $ValueType -Force | Out-Null
    Write-Host "Registry value successfully updated."
} else {
    Write-Host "SupportedEncryptionTypes is already set to the correct value."
}

# Verify result
$Verify = (Get-ItemProperty -Path $RegPath -Name $ValueName).$ValueName
Write-Host "Verified SupportedEncryptionTypes is now set to: $Verify"
