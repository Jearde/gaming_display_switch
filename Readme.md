# Switch gaming monitor

This is a simple script activate and deactivate a TV on your gaming monitor.
It can also close Steam and start it again with the beta version of gamepadui as the new Big Picture Mode when on tv.

## Background

I got annoyed that my TV is always detected by my computer even when it is in sleep mode.
This make the feature of Windows 11 switching primary monitor to the TV when it is turned on useless.
So I wrote this script to toggle the TV on and off along with Steam and the primary display setting. 

When the last TV state is OFF, it will close Steam, activate the TV, set the TV as primary display and start it again with the beta version of gamepadui as the new Big Picture Mode.
When the last TV state is ON, it will close Steam, set my PC monitor as primary display, deactivate the TV and start steam again in silent mode.


## How to use

1. Download the free [MultiMonitorTool](https://www.nirsoft.net/utils/multi_monitor_tool.html) from NirSoft ([Direct Download multimonitortool-x64.zip](https://www.nirsoft.net/utils/multimonitortool-x64.zip))
2. Extract the zip file to a folder of your choice
3. Clone this repo to the same folder
4. Edit the start_steam_beta.ps1 file and change the path to your steam.exe (Default: "C:\Program Files (x86)\Steam\steam.exe")
5. Edit the toggle_monitor.ps1 file and change the IDs of your monitors
6. Edit "Display Toggle.Ink" and change the path to the main.ps1 file

## Content of shortcut

```powershell
powershell.exe -ExecutionPolicy Bypass -File C:\MultiMonitorTool\main.ps1
```