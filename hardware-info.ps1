$processorName = (Get-WMIObject Win32_Processor).Name
$numberOfCores = (Get-WMIObject Win32_Processor).NumberOfCores
$totalMemory = [math]::round((Get-WMIObject Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1MB, 2)
$availableMemory = [math]::round((Get-WMIObject -Class Win32_OperatingSystem).FreePhysicalMemory / 1MB, 2)
$totalDiskSpace = [math]::round((Get-WMIObject Win32_LogicalDisk -Filter "DriveType=3").Size / 1GB, 2)
$freeDiskSpace = [math]::round((Get-WMIObject  Win32_LogicalDisk -Filter "DriveType=3").FreeSpace / 1GB, 2)

Write-Output "Hardware Information"
Write-Output "--------------------"
Write-Output "Processor Name   : $processorName"
Write-Output "Number of Cores  : $numberOfCores"
Write-Output "Total Memory     : $totalMemory MB"
Write-Output "Available Memory : $availableMemory MB"
Write-Output "Total Disk Space : $totalDiskSpace GB"
Write-Output "Free Disk Space  : $freeDiskSpace GB"