<#
.SYNOPSIS
    Enumeration of administrator accounts when elevating can provide part of the logon information to an unauthorized user. 
    This setting configures the system to always require users to type in a username and password to elevate a running application.

.NOTES
    Author          : Daniel Christopher
    LinkedIn        : linkedin.com/in/danchristopher/
    GitHub          : github.com/danchristopher02
    Date Created    : 2025-10-09
    Last Modified   : 2025-10-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000200

.TESTED ON
    Date(s) Tested  : 2025-10-09
    Tested By       : Daniel Christopher
    Systems Tested  : Azure Windows 10 VM
    PowerShell Ver. : 

.USAGE
    Open Powershell and run script.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000200).ps1 
#>


# STIG ID: WN10-CC-000200
# Title: The enumerator for administrator accounts must be disabled
# Description: This setting prevents administrator accounts from being enumerated on the logon screen.

# Define registry parameters
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI"
$ValueName = "EnumerateAdministrators"
$ValueType = "DWORD"
$ValueData = 0

# Check if the registry path exists; if not, create it
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Create or update the registry value
New-ItemProperty -Path $RegPath -Name $ValueName -PropertyType $ValueType -Value $ValueData -Force | Out-Null

# Verify and display the result
$Result = Get-ItemProperty -Path $RegPath -Name $ValueName
Write-Host "STIG WN10-CC-000200 applied successfully."
Write-Host "$ValueName is set to $($Result.$ValueName)"
