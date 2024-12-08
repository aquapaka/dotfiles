#!/bin/bash

#  Rice script
#  Author  :  aquapaka
#  Url     :  https://github.com/aquapaka/dotfiles
#  About   :  This file will configure and launch the rice.
#

avaiableThemes=("aqua" "shuri" "julia")

usage() {
  printf "
Rice Script for apply a rice theme

Usage:
`basename $0`\t[aqua]  \t A playful, mysterious girl with eyes like shimmering aqua, her movements graceful and quick, full of curiosity and charm
\t[shuri] \t A gentle presence in shades of purple, like twilight’s soft embrace—quietly comforting, effortlessly lovely
\t[julia] \t Mysterious and alluring, with eyes like deep ocean blue and an aura of aqua fire, she exudes both danger and enchantment
"
}

# Set desktop wallpaper
set_desktop_wallpaper() {
  powershell ./wackground.ps1 ./rices/$theme/wallpapers --set-random
}

# Set VSCode theme
set_vscode_theme() {
  echo "Setting vscode theme..."
  echo "$(jq -s '.[0] * .[1]' ~/AppData/Roaming/Code/User/settings.json ./rices/$theme/vscode-theme-settings.json)" > tmp.json && mv tmp.json ~/AppData/Roaming/Code/User/settings.json
}

# Set komorebi theme
# set_komorebi_theme() {
#   echo "Setting komorebi theme..."
#   echo "$(jq -s '.[0] * .[1]' ~/komorebi.json ./rices/$theme/komorebi-theme.json)" > tmp.json && mv tmp.json ~/komorebi.json
#   echo "$(jq -s '.[0] * .[1]' ~/komorebi.bar.monitor1.json ./rices/$theme/komorebi-bar-theme.json)" > tmp.json && mv tmp.json ~/komorebi.bar.monitor1.json
#   echo "$(jq -s '.[0] * .[1]' ~/komorebi.bar.monitor2.json ./rices/$theme/komorebi-bar-theme.json)" > tmp.json && mv tmp.json ~/komorebi.bar.monitor2.json
# }

# Set windows terminal theme
set_windows_terminal_theme() {
  echo "Setting windows terminal theme..."
  SETTING_FILE_PATH=$USERPROFILE\\AppData\\Local\\Packages\\Microsoft.WindowsTerminal_8wekyb3d8bbwe\\LocalState\\settings.json
  RICE_SETTING_FILE_PATH=./rices/$theme/settings.json
  jq ".profiles.defaults.colorScheme = input.windowsTerminalTheme" $SETTING_FILE_PATH $RICE_SETTING_FILE_PATH > tmp.json && mv tmp.json $SETTING_FILE_PATH
  jq ".profiles.defaults.font += input.windowsTerminalFont" $SETTING_FILE_PATH $RICE_SETTING_FILE_PATH > tmp.json && mv tmp.json $SETTING_FILE_PATH
}

# Change windows light/dark mode
change_windows_lightdark_mode() {
  echo "Changing windows theme..."
  WINDOWS_THEME=$(jq -r '.windowsTheme' ./rices/$theme/settings.json)
  if [ $WINDOWS_THEME == dark ]
    then powershell "New-ItemProperty -Path HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize -Name SystemUsesLightTheme -Value '0' -Type Dword -Force | Out-Null";
         powershell "New-ItemProperty -Path HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize -Name AppsUseLightTheme -Value '0' -Type Dword -Force | Out-Null"
  elif [ $WINDOWS_THEME == light ]
    then powershell "New-ItemProperty -Path HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize -Name SystemUsesLightTheme -Value '1' -Type Dword -Force | Out-Null";
         powershell "New-ItemProperty -Path HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize -Name AppsUseLightTheme -Value '1' -Type Dword -Force | Out-Null"
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
    set_vscode_theme
    set_windows_terminal_theme
    change_windows_lightdark_mode

    echo "Completed!"
    exit 0
  fi
done

usage
