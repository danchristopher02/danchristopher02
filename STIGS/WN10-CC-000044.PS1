<#
.SYNOPSIS
    Disabling this UI prevents non-administrators from modifying Internet Connection Sharing (ICS) settings, which helps reduce attack surface on Windows 10 endpoints

.NOTES
    Author          : Daniel Christopher
    LinkedIn        : linkedin.com/in/danchristopher/
    GitHub          : github.com/danchristopher02
    Date Created    : 2025-10-08
    Last Modified   : 2025-10-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 2025-10-08
    Tested By       : Daniel Christopher
    Systems Tested  : Azure Windows 10 VM
    PowerShell Ver. : 

.USAGE
    Open PowerShell and run script.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000044).ps1 
#>


# Define the registry path and value
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections"
$ValueName = "NC_ShowSharedAccessUI"
$ValueData = 0

# Create the registry key if it doesn't exist
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Set the registry value
New-ItemProperty -Path $RegPath -Name $ValueName -Value $ValueData -PropertyType DWORD -Force

Write-Output "Registry value '$ValueName' set to $ValueData at '$RegPath'"
