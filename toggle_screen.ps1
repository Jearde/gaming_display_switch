
Set-Location $PSScriptRoot

Write-Host Get-Location

$SEL = get-content tv_state.txt

# Edit here to match your monitor names
$monitor = "\\.\DISPLAY2"
$tv = "\\.\DISPLAY3"

if( $SEL -imatch "ON" )
{
    Write-Host 'Turning tv off'
    $SEL = "OFF"
    $SEL | Out-File tv_state.txt
    MultiMonitorTool.exe /SetPrimary $monitor
    Start-Sleep -Seconds 5
    MultiMonitorTool.exe /disable $tv
}
else
{
    Write-Host 'Turning tv on'
    $SEL = "ON"
    $SEL | Out-File tv_state.txt
    MultiMonitorTool.exe /enable $tv
    Start-Sleep -Seconds 5
    MultiMonitorTool.exe /SetPrimary $tv
}
Exit