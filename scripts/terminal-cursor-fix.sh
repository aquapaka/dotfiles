#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

# Related issue https://github.com/alacritty/alacritty/pull/6994
cd "$parent_path"
echo "Fixing terminal cursor..."
cp ./conpty/conpty.dll 'C:\Program Files\Alacritty'
cp ./conpty/OpenConsole.exe 'C:\Program Files\Alacritty'
echo "Done! restart your terminal for change to take effect."
