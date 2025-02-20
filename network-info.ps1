# Define a parameter to accept the directory path
param (
    [string]$directory
)

try {
    # Retrieve network adapter information
    $netAdapters = Get-NetAdapter | Select-Object Name, Status, MacAddress
    
    # Retrieve DNS server information
    $dnsInfo = Get-DnsClientServerAddress | Select-Object InterfaceAlias, ServerAddresses

    # Initialize an array to store network information
    $networkInfo = @()
    $networkInfo += "Network Adapter Information"
    $networkInfo += "----------------------------"
    
    # Iterate through each network adapter and add its information to the array
    foreach ($adapter in $netAdapters) {
        $networkInfo += "Adapter Name    : $($adapter.Name)"
        $networkInfo += "Adapter Status  : $($adapter.Status)"
        $networkInfo += "MAC Address     : $($adapter.MacAddress)"
        $networkInfo += "-----------------------------------"
    }

    # Add a blank line before DNS server information
    $networkInfo += ""
    $networkInfo += "DNS Server Information"
    $networkInfo += "-----------------------"
    
    # Iterate through each DNS server entry and add its information to the array
    foreach ($dns in $dnsInfo) {
        $networkInfo += "Interface Alias : $($dns.InterfaceAlias)"
        $networkInfo += "Server Addresses: $($dns.ServerAddresses -join ', ')"
        $networkInfo += "-----------------------------------"
    }

    # Ensure the directory exists; if not, create it
    if (-not (Test-Path -Path $directory)) {
        New-Item -ItemType Directory -Path $directory
    }

    # Write the network information to a file
    $networkInfo | Out-File -FilePath "$directory\networkInfo.txt"

    Write-Output "Network information successfully written to $directory\networkInfo.txt"
} catch {
    # Log any errors that occur during script execution
    Write-Error "An error occurred: $_"
}
