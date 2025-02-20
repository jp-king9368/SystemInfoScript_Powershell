# Define a parameter to accept the directory path
param (
    [string]$directory
)

try {
    # Retrieve the OS version
    $osVersion = (Get-WmiObject Win32_OperatingSystem).version

    # Retrieve the hostname
    $hostName = $env:COMPUTERNAME

    # Retrieve the IP address
    $ipAddress = (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv4' -and $_.PrefixOrigin -eq 'Dhcp' }).IPAddress

    # Initialize an array to store system information
    $systemInfo = @()
    $systemInfo += "System Information:"
    $systemInfo += "--------------------"
    $systemInfo += "OS Version : $osVersion"
    $systemInfo += "Hostname   : $hostName"
    $systemInfo += "IP Address : $ipAddress"

    # Ensure the directory exists; if not, create it
    if (-not (Test-Path -Path $directory)) {
        New-Item -ItemType Directory -Path $directory
    }

    # Write the system information to a file
    $systemInfo | Out-File -FilePath "$directory\systemInfo.txt"

    Write-Output "System information successfully written to $directory\systemInfo.txt"
} catch {
    # Log any errors that occur during script execution
    Write-Error "An error occurred: $_"
}
