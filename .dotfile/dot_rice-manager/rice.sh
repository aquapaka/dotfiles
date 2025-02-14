#!/bin/bash

#  Rice script
#  Author  :  aquapaka
#  Url     :  https://github.com/aquapaka/dotfiles
#  About   :  This file will configure and launch the rice.
#

avaiableThemes=("aqua" "wasabi")

usage() {
  printf "
Rice Script for apply a rice theme

Usage:
`basename $0`\t[aqua]  \t A playful, mysterious girl with eyes like shimmering aqua, her movements graceful and quick, full of curiosity and charm
\t[wasabi] \t Mysterious and alluring, with eyes like deep ocean blue and an aura of fire, she exudes both danger and enchantment
\t[shuri] \t A gentle presence in shades of purple, like twilight’s soft embrace—quietly comforting, effortlessly lovely
"
}

# Set desktop wallpaper
set_desktop_wallpaper() {
  powershell ./wackground.ps1 ./rices/$theme/wallpapers --set-random
}

# Set zebar config
set_zebar_theme() {
  echo "Setting zebar theme..."
  # Replace ~/.glzr/zebar/dotifle-bar folder with the one in the rice
  rm -rf ~/.glzr/zebar/dotfile-bar
  cp -r ./rices/$theme/dotfile-bar ~/.glzr/zebar/dotfile-bar
}

# Set glazewm config
set_glazewm_config() {
  echo "Setting glazewm border color..."
  SETTING_FILE_PATH=$USERPROFILE\\.glzr\\glazewm\\config.yaml
  RICE_SETTING_FILE_PATH=./rices/$theme/settings.json
  yq ".window_effects.focused_window.border.color = \"$(jq -r '.glazewmConfig.focusedWindowsColor' $RICE_SETTING_FILE_PATH)\" | .window_effects.other_windows.border.color = \"$(jq -r '.glazewmConfig.otherWindowsColor' $RICE_SETTING_FILE_PATH)\"" $SETTING_FILE_PATH > tmp.yaml && mv tmp.yaml $SETTING_FILE_PATH
  # Restart glazewm
  glazewm command wm-exit > /dev/null
  glazewm > /dev/null 2>&1 &
}

# Set VSCode theme
set_vscode_theme() {
  echo "Setting vscode theme..."
  echo "$(jq -s '.[0] * .[1]' ~/AppData/Roaming/Code/User/settings.json ./rices/$theme/vscode-theme-settings.json)" > tmp.json && mv tmp.json ~/AppData/Roaming/Code/User/settings.json
}

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
    set_zebar_theme
    set_glazewm_config
    set_vscode_theme
    set_windows_terminal_theme
    # change_windows_lightdark_mode # Zebar sometime not running due to explorer is not yet opened
    set_desktop_wallpaper

    echo "Completed!"
    exit 0
  fi
done

usage
