$osVersion = (Get-WmiObject Win32_OperatingSystem).version
$hostName = $env:COMPUTERNAME
$ipAddress = (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv4' -and $_.PrefixOrigin -eq 'Dhcp' }).IPAddress

Write-Output "System Information:"
Write-Output "--------------------"
Write-Output "OS Version : $osVersion"
Write-Output "Hostname   : $hostName"
Write-Output "IP Address : $ipAddress"