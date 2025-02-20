param (
    [string]$directory
)

$osVersion = (Get-WmiObject Win32_OperatingSystem).version
$hostName = $env:COMPUTERNAME
$ipAddress = (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv4' -and $_.PrefixOrigin -eq 'Dhcp' }).IPAddress

$systemInfo = @()
$systemInfo += "System Information:"
$systemInfo += "--------------------"
$systemInfo += "OS Version : $osVersion"
$systemInfo += "Hostname   : $hostName"
$systemInfo += "IP Address : $ipAddress"

# Ensure the directory exists
if (-not (Test-Path -Path $directory)) {
    New-Item -ItemType Directory -Path $directory
}

# Write the information to a file
$systemInfo | Out-File -FilePath "$directory\systemInfo.txt"