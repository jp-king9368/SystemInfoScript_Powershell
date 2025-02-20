# Prompt user for which information they would like to retrieve
$wantsSystemInfo = Read-Host "Would you like to retrieve the system info? (Y or N)"
$wantsHardwareInfo = Read-Host "Would you like to retrieve the hardware info (Y or N)"
$wantsNetworkInfo = Read-Host "Would you like to retrieve the network info (Y or N)"

# Prompt user for directory to save the file
$userDirectory = Read-Host "Please enter the directory where you want to save the file"


if ($wantsSystemInfo -ieq "Y") {
    .\system-info.ps1 -directory $userDirectory
}

if ($wantsHardwareInfo -ieq "Y") {
    .\hardware-info.ps1 -directory $userDirectory
}

if ($wantsNetworkInfo -ieq "Y") {
    .\network-info.ps1 -directory $userDirectory
}