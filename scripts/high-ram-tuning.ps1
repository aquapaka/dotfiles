<#
.SYNOPSIS
high-ram-tuning
#  Wackground
#  Author  :  aquapaka
#  Url     :  https://github.com/aquapaka/dotfiles
#  About   :  This script improve performance and reduce disk utilization on system with high amount of free RAM.
#>

<#
Do not unload the OS kernel from memory

Tweak description
  This will prevent pages sections from RAM (memory) going to the hard drive.
  You might want to keep the data in your RAM to improve your performance considerably due to reduced amount of hard drive swap page.
  (This tweak affects all users of this computer). ATTENTION: use this tweak only if your computer has 2 or more gigabytes of RAM.
#>
$key = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management'
$value = 'DisablePagingExecutive'
$valueData = 1
$valueType = [Microsoft.Win32.RegistryValueKind]::DWord

echo "Applying 'Do not unload the OS kernel from memory'..."
[Microsoft.Win32.Registry]::SetValue($key, $value, $valueData, $valueType)
echo "Done!"

<#
Optimize (increase) system cache

Tweak description
  This tweak specifies whether the system maintains a standard size or a large size file system cache, and influences how often the system writes changed pages to disk.
  Increasing the size of the file system cache generally improves server performance, but it reduces the physical memory space available to applications and services.
  Similarly, writing system data less frequently minimizes use of the disk subsystem, but the changed pages occupy memory that might otherwise be used by applications.
  ATTENTION: use this tweak only if your computer has 2 or more gigabytes of RAM.
#>
$key = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management'
$value = 'LargeSystemCache'
$valueData = 1
$valueType = [Microsoft.Win32.RegistryValueKind]::DWord

echo "Applying 'Optimize (increase) system cache'..."
[Microsoft.Win32.Registry]::SetValue($key, $value, $valueData, $valueType)
echo "Done!"


<#
Optimize (increase) system cache

Tweak description
  This tweak specifies whether the system maintains a standard size or a large size file system cache, and influences how often the system writes changed pages to disk.
  Increasing the size of the file system cache generally improves server performance, but it reduces the physical memory space available to applications and services.
  Similarly, writing system data less frequently minimizes use of the disk subsystem, but the changed pages occupy memory that might otherwise be used by applications.
  ATTENTION: use this tweak only if your computer has 2 or more gigabytes of RAM.
#>
$key = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management'
$value = 'IoPageLockLimit'
$valueData = 1
$valueType = [Microsoft.Win32.RegistryValueKind]::DWord

echo "Applying 'File System Caching Memory'..."
[Microsoft.Win32.Registry]::SetValue($key, $value, $valueData, $valueType)
echo "Done!"
