# Define a parameter to accept the directory path
param (
    [string]$directory
)

try {
    # Retrieve the processor name
    $processorName = (Get-WMIObject Win32_Processor).Name
    
    # Retrieve the number of cores
    $numberOfCores = (Get-WMIObject Win32_Processor).NumberOfCores
    
    # Calculate the total memory in MB
    $totalMemory = [math]::round((Get-WMIObject Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1MB, 2)
    
    # Calculate the available memory in MB
    $availableMemory = [math]::round((Get-WMIObject -Class Win32_OperatingSystem).FreePhysicalMemory / 1MB, 2)
    
    # Calculate the total disk space in GB
    $totalDiskSpace = [math]::round((Get-WMIObject Win32_LogicalDisk -Filter "DriveType=3").Size / 1GB, 2)
    
    # Calculate the free disk space in GB
    $freeDiskSpace = [math]::round((Get-WMIObject Win32_LogicalDisk -Filter "DriveType=3").FreeSpace / 1GB, 2)

    # Initialize an array to store hardware information
    $hardwareInfo = @()
    $hardwareInfo += "Hardware Information"
    $hardwareInfo += "--------------------"
    $hardwareInfo += "Processor Name   : $processorName"
    $hardwareInfo += "Number of Cores  : $numberOfCores"
    $hardwareInfo += "Total Memory     : $totalMemory MB"
    $hardwareInfo += "Available Memory : $availableMemory MB"
    $hardwareInfo += "Total Disk Space : $totalDiskSpace GB"
    $hardwareInfo += "Free Disk Space  : $freeDiskSpace GB"

    # Ensure the directory exists; if not, create it
    if (-not (Test-Path -Path $directory)) {
        New-Item -ItemType Directory -Path $directory
    }

    # Write the hardware information to a file
    $hardwareInfo | Out-File -FilePath "$directory\hardwareInfo.txt"

    Write-Output "Hardware information successfully written to $directory\hardwareInfo.txt"
} catch {
    # Log any errors that occur during script execution
    Write-Error "An error occurred: $_"
}
