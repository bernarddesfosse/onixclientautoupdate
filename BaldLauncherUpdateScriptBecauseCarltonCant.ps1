$launcherFolderPath = "$($env:localappdata)$("\Onix Launcher")"
$dllPath = "$($env:localappdata)$("\Onix Launcher\OnixClient.dll")"

Clear-Host
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""

if (Test-Path -Path $launcherFolderPath) {
    Write-Host "Launcher folder exists"
} else {
    Write-Host "You never started the Launcher"
    Pause
    Exit
}

if (Test-Path -Path $dllPath) {
    Write-Host "Deleting old version from the launcher..."
    Remove-Item $dllPath -Force -ErrorVariable removeItemResult1 2> $removeItemResult1IDC
    if ($removeItemResult1.Count -gt 0) {
        Write-Host "Could not delete the file, Trying to close the game and launcher."
        taskkill.exe /f /im Minecraft.Windows.exe
        taskkill.exe /f /im OnixLauncher.exe
        Start-Sleep 1

        Remove-Item $dllPath -Force -ErrorVariable removeItemResult2 2> $removeItemResult2IDC
        if ($removeItemResult2.Count -gt 0) {
            Write-Host "Could not delete the file, Maybe try restarting?"
            Pause
            Exit
        }
    }
    Write-Host "Deleted the old dll!"
} else {
    Write-Host "Dll is already gone, great!"
}

Write-Host "Downloading the brand new OnixClient dll"
try {
    Invoke-RestMethod -Uri "https://github.com/bernarddesfosse/onixclientautoupdate/raw/main/OnixClient.dll" -OutFile $dllPath
    Write-Host("New dll finished downloading")
} catch {
    Write-Host("Could not download the new dll, check internet.")
    Pause
    Exit
}

Write-Host("Update completed, Try launching again!")
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Pause
