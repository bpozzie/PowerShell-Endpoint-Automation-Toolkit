\
    [CmdletBinding()]
    param(
        [string]$OutputFolder = ".\output"
    )

    try {
        if (-not (Test-Path $OutputFolder)) {
            New-Item -Path $OutputFolder -ItemType Directory -Force | Out-Null
        }

        $stamp = Get-Date -Format "yyyyMMdd_HHmmss"

        $servicesPath = Join-Path $OutputFolder "services_$stamp.csv"
        $eventsPath   = Join-Path $OutputFolder "recent_errors_$stamp.csv"
        $networkPath  = Join-Path $OutputFolder "network_$stamp.csv"
        $hotfixPath   = Join-Path $OutputFolder "hotfixes_$stamp.csv"

        Get-Service |
            Sort-Object DisplayName |
            Select-Object Status, Name, DisplayName |
            Export-Csv -Path $servicesPath -NoTypeInformation -Encoding UTF8

        Get-WinEvent -LogName System,Application -MaxEvents 250 -ErrorAction SilentlyContinue |
            Where-Object { $_.LevelDisplayName -in @("Error","Critical") } |
            Select-Object TimeCreated, LogName, Id, LevelDisplayName, ProviderName, Message |
            Export-Csv -Path $eventsPath -NoTypeInformation -Encoding UTF8

        Get-CimInstance Win32_NetworkAdapterConfiguration |
            Where-Object { $_.IPEnabled } |
            Select-Object Description, MACAddress, DHCPEnabled, IPAddress, DefaultIPGateway, DNSDomain |
            Export-Csv -Path $networkPath -NoTypeInformation -Encoding UTF8

        Get-HotFix |
            Sort-Object InstalledOn -Descending |
            Select-Object HotFixID, Description, InstalledOn |
            Export-Csv -Path $hotfixPath -NoTypeInformation -Encoding UTF8

        Write-Host "Diagnostics exported to $OutputFolder"
    }
    catch {
        Write-Error $_.Exception.Message
        exit 1
    }
