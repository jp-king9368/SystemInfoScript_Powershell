param (
    [string]$directory
)

$netAdapters = Get-NetAdapter | Select-Object Name, Status, MacAddress
$dnsInfo = Get-DnsClientServerAddress | Select-Object InterfaceAlias, ServerAddresses

$networkInfo = @()
$networkInfo += "Network Adapter Information"
$networkInfo += "----------------------------"
foreach ($adapter in $netAdapters) {
    $networkInfo += "Adapter Name    : $($adapter.Name)"
    $networkInfo += "Adapter Status  : $($adapter.Status)"
    $networkInfo += "MAC Address     : $($adapter.MacAddress)"
    $networkInfo += "-----------------------------------"
}

$networkInfo += ""
$networkInfo += "DNS Server Information"
$networkInfo += "-----------------------"
foreach ($dns in $dnsInfo) {
    $networkInfo += "Interface Alias : $($dns.InterfaceAlias)"
    $networkInfo += "Server Addresses: $($dns.ServerAddresses -join ', ')"
    $networkInfo += "-----------------------------------"
}

# Ensure the directory exists
if (-not (Test-Path -Path $directory)) {
    New-Item -ItemType Directory -Path $directory
}

# Write the information to a file
$networkInfo | Out-File -FilePath "$directory\networkInfo.txt"