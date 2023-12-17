
Set-Location $PSScriptRoot

Write-Host Get-Location

$SEL = get-content tv_state.txt

# [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
# $displays = [System.Windows.Forms.Screen]::AllScreens
# $displays = Get-WmiObject win32_desktopmonitor

# Name of TV to search for
$tv_search_name = "*LG*"
# Name of primary monitor to search for
$monitor_search_name = "*DELL*"

$monitors = [System.Collections.ArrayList]@()
$screens = Get-WmiObject -Namespace "root\WMI" -Class "WMIMonitorID" -ErrorAction SilentlyContinue
Foreach ($screen in $screens) {
    $disp_model = ([System.Text.Encoding]::ASCII.GetString($screen.UserFriendlyName)).Replace("$([char]0x0000)","")
    $disp_serial = ([System.Text.Encoding]::Ascii.GetString($screen.SerialNumberID))
    $disp_id = $screen.InstanceName -Split "\\"

    If ($disp_model -like $tv_search_name)
    {
        Write-Host "TV: ${disp_model} \"$($disp_id[1])\" is active: $($display.Active)"
        $tv = $disp_id[1]
    }
    elseif ($disp_model -like $monitor_search_name)
    {
        Write-Host "Primary Monitor: ${disp_model} \"$($disp_id[1])\" is active: $($display.Active)"
        $prim_monitor = $($screen.InstanceName -Split "\\")[1]
        $primary_screen = $screen
        $monitors += $disp_id[1]
    }
    else
    {
        Write-Host "Other Monitor: ${disp_model} \"$($disp_id[1])\" is active: $($display.Active)"
        $monitors += $disp_id[1]
    }
    # IF ($primary_screen.Active -eq $true)
    # {
    #     $SEL = "OFF"
    # }
    $SEL | Out-File tv_state.txt
}

if( $SEL -imatch "ON" )
{
    Write-Host 'Turning tv off'
    $SEL = "OFF"
    $SEL | Out-File tv_state.txt
    Foreach($monitor in $monitors)
    {
        MultiMonitorTool.exe /enable $monitor
        MultiMonitorTool.exe /TurnOn $monitor
    }
    Write-Host "Primary Monitor: $prim_monitor"
    MultiMonitorTool.exe /SetPrimary $prim_monitor  
    Start-Sleep -Seconds 5
    MultiMonitorTool.exe /TurnOff $tv
    Start-Sleep -Seconds 5
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
    Foreach($monitor in $monitors)
    {
        MultiMonitorTool.exe /TurnOff $monitor
        Start-Sleep -Seconds 5
        MultiMonitorTool.exe /disable $monitor
    }
}
Exit