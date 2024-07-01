#!/bin/bash

#  Rice script
#  Author  :  aquapaka
#  Url     :  https://github.com/aquapaka/dotfiles
#  About   :  This file will configure and launch the rice.
#

avaiableThemes=("meimei" "tlinh" "mtram" "khanhoa" "arcade")

usage() {
  printf "
Rice Script for apply a rice theme

Usage:
`basename $0`\t[meimei] \t Warming and caring
\t[tlinh] \t Only in my dreams
\t[mtram]  \t Calming and peaceful
\t[khanhoa] \t One of my oldest memories
\t[arcade] \t WARNING! Only For Truest Gamer!! May hurt your eyes!!!
"
}

# Set alacritty colorscheme
set_alacritty_config() {
  echo "Setting alacritty config..."
  cat ./rices/$theme/alacritty/colors.toml > ~/AppData/Roaming/alacritty/colors.toml
  cat ./rices/$theme/alacritty/fonts.toml > ~/AppData/Roaming/alacritty/fonts.toml
}

# Set desktop wallpaper
set_desktop_wallpaper() {
  powershell ./wackground.ps1 ./rices/$theme/wallpapers --set-random
}

# Set VSCode theme
set_vscode_theme() {
  echo "Setting vscode theme..."
  echo "$(jq -s '.[0] * .[1]' ~/AppData/Roaming/Code/User/settings.json ./rices/$theme/vscode-theme-settings.json)" > ~/AppData/Roaming/Code/User/settings.json
}

# Toggle rounded corners
toggle_rounded_corners() {
  echo "Changing windows corners..."
  option=$(<./rices/$theme/rounded-corners-flag)
  win11-toggle-rounded-corners $option >/dev/null
}

# Change windows light/dark mode
change_windows_lightdark_mode() {
  echo "Changing windows theme..."
  option=$(<./rices/$theme/windows-theme)
  if [ $option == dark ]
    then powershell "New-ItemProperty -Path HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize -Name SystemUsesLightTheme -Value 0 -Type Dword -Force | Out-Null"
  elif [ $option == light ]
    then powershell "New-ItemProperty -Path HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize -Name AppsUseLightTheme -Value 1 -Type Dword -Force | Out-Null"
  else
    echo "Error: windows-theme must be light or dark"
    return 1
  fi
  echo "Reloading explorer..."
  powershell "taskkill /F /IM explorer.exe | Out-Null; start explorer"
}

# Goes to this script location first
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

for theme in "${avaiableThemes[@]}"; do
  if [[ "$1" == "$theme" ]]; then
    echo "Applying $theme theme..."

    # # Apply configs
    set_desktop_wallpaper
    set_alacritty_config
    set_vscode_theme
    toggle_rounded_corners
    change_windows_lightdark_mode

    echo "Completed!"
    exit 1
  fi
done

usage
