<#
.SYNOPSIS
Enforces a Windows automatic workstation lock timeout.

.DESCRIPTION
Sets the Windows inactivity lock timeout to 15 minutes (900 seconds)
by configuring the following registry value:

HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
InactivityTimeoutSecs = 900

The script creates a simple CSV log recording the result.

.NOTES
This script is designed for demonstration purposes and can be adapted
for endpoint management or automation scenarios.

Author: Barry Page
#>

$ErrorActionPreference = "Stop"

$Computer = $env:COMPUTERNAME
$Utc = (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd_HH-mm-ss'Z'")

# Local log directory
$LogRoot = "C:\ProgramData\EndpointAutomation\Logs\LockTimeout"

if (!(Test-Path $LogRoot)) {
    New-Item -ItemType Directory -Path $LogRoot -Force | Out-Null
}

$LogFile = Join-Path $LogRoot "$Computer-LockTimeout-$Utc.csv"

# Create log header
"Computer,TimestampUTC,ValueSet,Result" | Out-File $LogFile -Encoding UTF8

# Registry path
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

if (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

try {
    Set-ItemProperty -Path $RegPath -Name "InactivityTimeoutSecs" -Value 900 -Type DWord
    $Result = "Success"
}
catch {
    $Result = "Failed: $($_.Exception.Message)"
}

"$Computer,$Utc,900,$Result" | Out-File $LogFile -Append -Encoding UTF8

Write-Host "Inactivity timeout set to 900 seconds ($Result)"