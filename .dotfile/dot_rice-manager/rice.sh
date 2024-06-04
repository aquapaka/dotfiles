#!/bin/bash

#  Rice script
#  Author  :  aquapaka
#  Url     :  https://github.com/aquapaka/dotfiles
#  About   :  This file will configure and launch the rice.
#

avaiableThemes=("meimei" "tlinh" "sylvia" "ella")

usage() {
  printf "
Rice Script for Apply a rice theme

Usage:
`basename $0`\t[meimei] \t Nicest girl
\t[tlinh] \t Who is this?
\t[sylvia] \t Are you real?
\t[ella] \t Truest gamer girl!!!
"
}

# Set alacritty colorscheme
set_alacritty_config() {
  echo "Set alacritty config"
  cat ./rices/$theme/alacritty/rice-colors.toml > ~/AppData/Roaming/alacritty/rice-colors.toml
  cat ./rices/$theme/alacritty/fonts.toml > ~/AppData/Roaming/alacritty/fonts.toml
}

# Set glazewm configs
set_glazewm_config() {
  echo "Set glazewm config"
  MERGED_CONFIG=$(yq eval-all '. as $item ireduce ({}; . * $item )' ~/.glaze-wm/config.yaml ./rices/$theme/glaze-theme-config.yaml)

  printf '%s\n' "$MERGED_CONFIG" > ~/.glaze-wm/config.yaml

  glazewm command '"reload config"' >/dev/null
}

# Set desktop wallpaper
set_desktop_wallpaper() {
  powershell ./wackground.ps1 ./rices/$theme/wallpapers --set-random
}

set_vscode_theme() {
  echo "Set vscode theme"
  echo "$(jq -s '.[0] * .[1]' ~/AppData/Roaming/Code/User/settings.json ./rices/$theme/vscode-theme-settings.json)" > ~/AppData/Roaming/Code/User/settings.json
}

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

for theme in "${avaiableThemes[@]}"; do
  if [[ "$1" == "$theme" ]]; then
    echo "Applying $theme theme"

    # # Apply configs
    set_desktop_wallpaper
    set_alacritty_config
    set_glazewm_config
    set_vscode_theme

    echo "Done!"
    exit 1
  fi
done

usage
