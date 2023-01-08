Add-Type -AssemblyName PresentationFramework
$launcherPath = "$([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop))\Onix Launcher.exe"

try {
    Stop-Process -Name "OnixLauncher" -Force -ErrorAction Stop
    Start-Sleep -Seconds 1
}
catch {}
try {
    Stop-Process -Name "Onix Launcher" -Force -ErrorAction Stop
    Start-Sleep -Seconds 1
}
catch {}

try {
    if (Test-Path -Path $launcherPath -PathType Leaf -ErrorAction SilentlyContinue) {
        Remove-Item $launcherPath -ErrorAction Stop -Force
    }
} catch {
    Write-Host "Cannot delete the launcher at`n$($launcherPath)" -ForegroundColor Red
    [System.Windows.MessageBox]::Show("Cannot delete the launcher at`n$($launcherPath)")
    Exit
}

try {
    Invoke-RestMethod -Uri "https://raw.githubusercontent.com/bernarddesfosse/onixclientautoupdate/main/OnixLauncher.exe" -OutFile $launcherPath -ErrorAction Stop;
}
catch {
    Write-Host "Unable to download the launcher, make sure you have internet and/or you don't live in India (Blocked by the Indian Governement)" -ForegroundColor Red
    [System.Windows.MessageBox]::Show("Unable to download the launcher, make sure you have internet and/or you don't live in India (Blocked by the Indian Governement)")
    Exit
}

if (Test-Path -Path $launcherPath -PathType Leaf -ErrorAction SilentlyContinue) {
    Write-Host 'The launcher is now on your desktop!' -ForegroundColor Green
    [System.Windows.MessageBox]::Show('The launcher is now on your desktop!')
    Start-Process -FilePath $launcherPath
} else {
    Write-Host 'Could not download the launcher' -ForegroundColor Red
    [System.Windows.MessageBox]::Show('Could not download the launcher')
}
