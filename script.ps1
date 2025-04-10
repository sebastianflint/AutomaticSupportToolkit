<#
.SYNOPSIS
  Collect Ivanti Supportoolkit Logs
.DESCRIPTION
  This script downloads the latest Supporttoolkit from the Ivanti Forum. The file will be extracted to 'c:\ivanti\' and then the logs are collected in this directory.
.NOTES
  Version:        1.0
  Author:         sebastian.flint@sva.de
  Creation Date:  10.04.2025
  Purpose/Change: Initial script development
  

#>


# Define variables
$downloadUrl = "https://forums.ivanti.com/s/sfsites/c/sfc/servlet.shepherd/document/download/0694O00000J7sfyQAB"
$zipPath = "$env:TEMP\ivanti.zip"
$extractPath = "C:\ivanti"
$exePath = "C:\ivanti\SupportToolkit.exe"
$exeArgs = "/nogui /out:c:\ivanti /accepteula"

# Create target directory if it doesn't exist
if (-Not (Test-Path -Path $extractPath)) {
    New-Item -Path $extractPath -ItemType Directory -Force
}

# Download the file
Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath

# Extract the ZIP file
Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

# Optional: remove the zip file after extraction
Remove-Item -Path $zipPath -Force

# Run the executable with arguments
Start-Process -FilePath $exePath -ArgumentList $exeArgs -Wait

Write-Host "SupportToolkit executed successfully."
