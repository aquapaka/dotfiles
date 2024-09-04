<#
.SYNOPSIS
show-cpu-frequency-power-plan-setting
#  Wackground
#  Author  :  aquapaka
#  Url     :  https://github.com/aquapaka/dotfiles
#  About   :  This script showing maximum cpu frequency in power plan setting.
#>

<#
Showing maximum cpu frequency in power plan setting

This will allow you to change maximum cpu frequency in power plan setting, which aiming to reduce temperature and improve stability
#>
$key = 'Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100'
$value = 'Attributes'
$valueData = 2
$valueType = [Microsoft.Win32.RegistryValueKind]::DWord

echo "Showing maximum cpu frequency in power plan setting..."
[Microsoft.Win32.Registry]::SetValue($key, $value, $valueData, $valueType)
echo "Done!"
