\
    <#
    .SYNOPSIS
    Audits Windows user profiles and flags orphaned profiles based on registry state.

    .DESCRIPTION
    This script scans the ProfileList registry key under:
      HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList

    It identifies user profile SIDs, reads their ProfileImagePath and State values,
    checks whether the profile folder exists, and flags entries where State = 4.

    Results are exported to a CSV file in a local, generic log folder suitable for
    public sharing and lab use.

    .NOTES
    Safe for public sharing. This version contains no organization-specific paths
    or infrastructure references.
    #>

    [CmdletBinding()]
    param(
        [string]$LogDir = "$env:ProgramData\ProfileAuditLogs"
    )

    $ComputerName = $env:COMPUTERNAME
    $TimeStamp    = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
    $LogFile      = Join-Path $LogDir "$ComputerName-OrphanedProfileAudit-$TimeStamp.csv"

    try {
        if (-not (Test-Path $LogDir)) {
            New-Item -ItemType Directory -Path $LogDir -Force | Out-Null
        }

        $BaseKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"
        $ProfileKeys = Get-ChildItem -Path $BaseKey -ErrorAction Stop |
            Where-Object { $_.PSChildName -match '^S-1-5-21-' }

        $Results = foreach ($Key in $ProfileKeys) {
            $Properties  = Get-ItemProperty -Path $Key.PSPath -ErrorAction SilentlyContinue
            $SID         = $Key.PSChildName
            $ProfilePath = $Properties.ProfileImagePath
            $StateRaw    = $Properties.State

            $State = if ($null -ne $StateRaw) { [int]$StateRaw } else { $null }

            $FolderExists = if ($ProfilePath -and (Test-Path $ProfilePath)) { $true } else { $false }

            $Flagged = $false
            $Reason  = ''

            if ($State -eq 4) {
                $Flagged = $true
                $Reason  = 'State = 4 (Potential orphaned or backup profile)'
            }

            [PSCustomObject]@{
                ComputerName = $ComputerName
                SID          = $SID
                ProfilePath  = $ProfilePath
                State        = $State
                FolderExists = $FolderExists
                Flagged      = $Flagged
                Reason       = $Reason
            }
        }

        $Results | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $LogFile

        Write-Host "Audit complete. Results saved to: $LogFile"
        $Results
    }
    catch {
        Write-Error $_.Exception.Message
        exit 1
    }
