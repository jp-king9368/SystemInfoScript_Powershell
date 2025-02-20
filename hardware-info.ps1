param (
    [string]$directory
)

$processorName = (Get-WMIObject Win32_Processor).Name
$numberOfCores = (Get-WMIObject Win32_Processor).NumberOfCores
$totalMemory = [math]::round((Get-WMIObject Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1MB, 2)
$availableMemory = [math]::round((Get-WMIObject -Class Win32_OperatingSystem).FreePhysicalMemory / 1MB, 2)
$totalDiskSpace = [math]::round((Get-WMIObject Win32_LogicalDisk -Filter "DriveType=3").Size / 1GB, 2)
$freeDiskSpace = [math]::round((Get-WMIObject  Win32_LogicalDisk -Filter "DriveType=3").FreeSpace / 1GB, 2)

$hardwareInfo = @()
$hardwareInfo += "Hardware Information"
$hardwareInfo += "--------------------"
$hardwareInfo += "Processor Name   : $processorName"
$hardwareInfo += "Number of Cores  : $numberOfCores"
$hardwareInfo += "Total Memory     : $totalMemory MB"
$hardwareInfo += "Available Memory : $availableMemory MB"
$hardwareInfo += "Total Disk Space : $totalDiskSpace GB"
$hardwareInfo += "Free Disk Space  : $freeDiskSpace GB"

# Ensure the directory exists
if (-not (Test-Path -Path $directory)) {
    New-Item -ItemType Directory -Path $directory
}

# Write the information to a file
$hardwareInfo | Out-File -FilePath "$directory\hardwareInfo.txt"