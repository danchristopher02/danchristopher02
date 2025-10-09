<#
.SYNOPSIS
    This PowerShell script enforces password history be configured to at least 24 passwords remembered to satisfy STIG WN10-AC-000020.

.NOTES
    Author          : Daniel Christopher
    LinkedIn        : linkedin.com/in/danchristopher/
    GitHub          : github.com/danchristopher02
    Date Created    : 2025-10-09
    Last Modified   : 2025-10-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000020

.TESTED ON
    Date(s) Tested  : 2025-10-09
    Tested By       : Daniel Christopher
    Systems Tested  : Azure Windows 10 VM
    PowerShell Ver. : 

.USAGE
    Open Powershell and run script.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-AC-000020).ps1 
#>


# STIG ID: WN10-AC-000020
# Purpose: Enforce password history to 24 passwords remembered
# Applies to: Local Computer Policy >> Computer Configuration >> Windows Settings >> Security Settings >> Account Policies >> Password Policy

# Desired STIG-compliant value
$desiredValue = 24

# Get current password history setting
$currentValue = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" -ErrorAction SilentlyContinue).MaximumPasswordAge

# Use secedit to export current security policy
$tempFile = "$env:TEMP\secpol.inf"
$outputFile = "$env:TEMP\secpol.cfg"

# Export current security policy
secedit /export /cfg $tempFile /areas SECURITYPOLICY | Out-Null

# Read policy file into memory
$content = Get-Content $tempFile

# Find the line containing the password history setting
if ($content -match "PasswordHistorySize") {
    # Modify existing entry to ensure 24 passwords remembered
    $content = $content -replace "PasswordHistorySize\s*=\s*\d+", "PasswordHistorySize = $desiredValue"
} else {
    # Add the line if it doesn't exist
    $content += "PasswordHistorySize = $desiredValue"
}

# Save updated policy to a new file
$content | Set-Content $outputFile -Encoding Unicode

# Apply the updated policy
secedit /configure /db secedit.sdb /cfg $outputFile /areas SECURITYPOLICY /quiet

# Cleanup temporary files
Remove-Item $tempFile, $outputFile -ErrorAction SilentlyContinue

Write-Host "STIG WN10-AC-000020 applied successfully. 'Enforce password history' set to $desiredValue passwords remembered."
