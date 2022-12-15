
Set-Location $PSScriptRoot

Write-Host Get-Location

$SEL = get-content tv_state.txt

# Edit here to match your monitor names
$monitor = "\\.\DISPLAY2"
$monitor2 = "\\.\DISPLAY1"
$tv = "\\.\DISPLAY3"

$displays = [System.Windows.Forms.Screen]::AllScreens

Foreach ($i in $displays)
{
    $device = $i.DeviceName
    if( ($i.DeviceName -eq "$tv") -and ($i.Primary) )
    {
        Write-Host "Primary TV: $device"
        $SEL = "ON"
    }
    elseif ($i.Primary)
    {
        Write-Host "Primary Monitor: $device"
        $SEL = "OFF"
    }
    $SEL | Out-File tv_state.txt
}

if( $SEL -imatch "ON" )
{
    Write-Host 'Turning tv off'
    $SEL = "OFF"
    $SEL | Out-File tv_state.txt
    MultiMonitorTool.exe /TurnOn $monitor
    MultiMonitorTool.exe /TurnOn $monitor2
    MultiMonitorTool.exe /SetPrimary $monitor
    Start-Sleep -Seconds 5
    MultiMonitorTool.exe /TurnOff  $tv
    MultiMonitorTool.exe /disable $tv
}
else
{
    Write-Host 'Turning tv on'
    $SEL = "ON"
    $SEL | Out-File tv_state.txt
    MultiMonitorTool.exe /enable $tv
    MultiMonitorTool.exe /TurnOn $tv
    Start-Sleep -Seconds 5
    MultiMonitorTool.exe /SetPrimary $tv
    MultiMonitorTool.exe /TurnOff $monitor
    MultiMonitorTool.exe /TurnOff $monitor2
}
Exit