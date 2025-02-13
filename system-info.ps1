$osVersion = (Get-WmiObject Win32_OperatingSystem).version
$hostName = $env:COMPUTERNAME
$ipAddress = (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv4' -and $_.PrefixOrigin -eq 'Dhcp' }).IPAddress

Write-Output "System Information:`n--------------------`nOS Version : $osVersion`nHostname   : $hostName`nIP Address : $ipAddress"