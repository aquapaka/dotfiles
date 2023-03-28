#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

cp -rs --remove-destination $SCRIPTPATH/../.config/sxhkd ~/.config
cp -rs --remove-destination $SCRIPTPATH/../.config/bspwm ~/.config
cp -rs --remove-destination $SCRIPTPATH/../.config/alacritty ~/.config
cp -rs --remove-destination $SCRIPTPATH/../.config/zsh ~/.config
cp -rs --remove-destination $SCRIPTPATH/../.config/gtk-3.0 ~/.config