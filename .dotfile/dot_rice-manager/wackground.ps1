<#
.SYNOPSIS
Wackground
This script used to set windows desktop background.

.DESCRIPTION
USAGE
    .\wackground.ps1 <path-to-backgrounds-folder> <OptionalParameters>

Optional Parameters
    --set-random  Set random background from folder
    --help, -?    show this help message
#>

param(
  [Parameter(Position = 0)]
  [string]$FolderPath,

  [Parameter(Position = 1)]
  [string]$OptionalParameter
)

$code = @'
using System.Runtime.InteropServices;
namespace Win32{

     public class Wallpaper{
        [DllImport("user32.dll", CharSet=CharSet.Auto)]
         static extern int SystemParametersInfo (int uAction , int uParam , string lpvParam , int fuWinIni) ;

         public static void SetWallpaper(string thePath){
            SystemParametersInfo(20,0,thePath,3);
         }
    }
 }
'@
add-type $code

#Apply the Change on the system
[Win32.Wallpaper]::SetWallpaper($imgPath)
function Show-Help { Get-Help $PSCommandPath }

function Set-Random {
  $ChoosenWallpaper = Get-ChildItem "$PSScriptRoot/$FolderPath" | Get-Random -Count 1
  $ChoosenWallpaperPath = "$PSScriptRoot/$FolderPath/$ChoosenWallpaper"
  Write-Output "Set $ChoosenWallpaperPath as desktop wallpaper"
  [Win32.Wallpaper]::SetWallpaper("$ChoosenWallpaperPath")
}

if (!{Test-Path $_}) {
  Show-Help
  exit
}

switch ($OptionalParameter) {
  "--set-random" { Set-Random }
  "--help" { Show-Help }
  default { Set-Random }
}
