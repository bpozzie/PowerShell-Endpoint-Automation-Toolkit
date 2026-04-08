\
    [CmdletBinding()]
    param(
        [string]$OutputPath
    )

    function Get-RecentRebootIndicator {
        [CmdletBinding()]
        param()

        try {
            $uptime = (Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
            return ($uptime.TotalDays -lt 7)
        }
        catch {
            return $null
        }
    }

    try {
        $os = Get-CimInstance Win32_OperatingSystem
        $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
        $defender = Get-Service -Name WinDefend -ErrorAction SilentlyContinue

        $result = [PSCustomObject]@{
            Timestamp           = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            ComputerName        = $env:COMPUTERNAME
            OSName              = $os.Caption
            OSVersion           = $os.Version
            LastBootTime        = $os.LastBootUpTime
            DiskFreeGB          = if ($disk) { [math]::Round($disk.FreeSpace / 1GB, 2) } else { $null }
            DefenderService     = if ($defender) { $defender.Status } else { "NotFound" }
            RebootWithin7Days   = Get-RecentRebootIndicator
        }

        if ($OutputPath) {
            $parent = Split-Path -Parent $OutputPath
            if ($parent -and -not (Test-Path $parent)) {
                New-Item -Path $parent -ItemType Directory -Force | Out-Null
            }
            $result | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
            Write-Host "Saved endpoint health report to $OutputPath"
        }
        else {
            $result
        }
    }
    catch {
        Write-Error $_.Exception.Message
        exit 1
    }
