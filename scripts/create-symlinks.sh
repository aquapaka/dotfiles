#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

ln -sf $SCRIPTPATH/../.config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc