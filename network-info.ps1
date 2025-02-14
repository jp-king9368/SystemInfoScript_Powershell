$netAdapters = Get-NetAdapter | Select-Object Name, Status, MacAddress
$dnsInfo = Get-DnsClientServerAddress | Select-Object InterfaceAlias, ServerAddresses

Write-Output "Network Adapter Information"
Write-Output "----------------------------"
foreach ($adapter in $netAdapters) {
    Write-Output "Adapter Name    : $($adapter.Name)"
    Write-Output "Adapter Status  : $($adapter.Status)"
    Write-Output "MAC Address     : $($adapter.MacAddress)"
    Write-Output "-----------------------------------"
}

Write-Output ""
Write-Output "DNS Server Information"
Write-Output "-----------------------"
foreach ($dns in $dnsInfo) {
    Write-Output "Interface Alias : $($dns.InterfaceAlias)"
    Write-Output "Server Addresses: $($dns.ServerAddresses -join ', ')"
    Write-Output "-----------------------------------"
}