# Edit here to match your Steam installation path
$steam_path = "C:\Program Files (x86)\Steam\steam.exe"

$steam = Get-Process steam -ErrorAction SilentlyContinue
if ($steam) {
  # try gracefully first
  $steam.CloseMainWindow()
  # kill after five seconds
  Start-Sleep 5
  if (!$steam.HasExited) {
    $steam | Stop-Process -Force
  }
}
Remove-Variable steam


Set-Location $PSScriptRoot
$SEL = get-content tv_state.txt

if( $SEL -imatch "ON" )
{
    Start-Process -FilePath $steam_path -ArgumentList "-gamepadui"
}
else
{
    Start-Process -FilePath $steam_path -ArgumentList "-silent"
}
Exit

