<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Daniel Christopher
    LinkedIn        : linkedin.com/in/danchristopher/
    GitHub          : github.com/danchristopher02
    Date Created    : 2025-10-06
    Last Modified   : 2025-10-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 2025-10-06
    Tested By       : Daniel Christopher
    Systems Tested  : Azure Windows 10 VM
    PowerShell Ver. : 

.USAGE
    Open Powershell and run script.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>


# Create the registry path if it doesn't exist
$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
if (-not (Test-Path $path)) {
    New-Item -Path $path -Force | Out-Null
}

# Set the MaxSize value to 0x00008000 (which is 32768 in decimal)
Set-ItemProperty -Path $path -Name "MaxSize" -Value 0x8000 -Type DWord

# Verify the change
Get-ItemProperty -Path $path | Select-Object MaxSize
