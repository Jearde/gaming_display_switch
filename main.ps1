Set-Location $PSScriptRoot

Write-Host 'Switching TV state'
toggle_screen.ps1
Write-Host 'Waiting for 5 s'
Start-Sleep -Seconds 5
Write-Host 'Close Steam and start Steam Beta in Gamepad mode'
start_steam_beta.ps1

Exit