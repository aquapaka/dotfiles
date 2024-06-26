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
\t[arcade] \t WARNING! Only For Truest Gamer!! May hurt your eyes!!!
\t[khanhoa] \t She plays guitar
"
}

# Set alacritty colorscheme
set_alacritty_config() {
  echo "Setting alacritty config..."
  cat ./rices/$theme/alacritty/rice-colors.toml > ~/AppData/Roaming/alacritty/rice-colors.toml
  cat ./rices/$theme/alacritty/fonts.toml > ~/AppData/Roaming/alacritty/fonts.toml
}

# Set glazewm configs
set_glazewm_config() {
  echo "Setting Glazewm config..."
  MERGED_CONFIG=$(yq eval-all '. as $item ireduce ({}; . * $item )' ~/.glaze-wm/config.yaml ./rices/$theme/glaze-theme-config.yaml)
  printf '%s\n' "$MERGED_CONFIG" > ~/.glaze-wm/config.yaml
  glazewm command '"reload config"' >/dev/null
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
  echo "Applying windows color..."
  option=$(<./rices/$theme/windows-color)
  powershell "New-ItemProperty -Path HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize -Name SystemUsesLightTheme -Value $option -Type Dword -Force | Out-Null"
  powershell "New-ItemProperty -Path HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize -Name AppsUseLightTheme -Value $option -Type Dword -Force | Out-Null"
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
    set_glazewm_config
    set_desktop_wallpaper
    # set_wezterm_theme
    set_alacritty_config
    set_vscode_theme
    toggle_rounded_corners
    change_windows_lightdark_mode

    echo "Completed!"
    exit 1
  fi
done

usage
