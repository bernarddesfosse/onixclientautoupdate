Add-Type -AssemblyName PresentationFramework;
$Response = Invoke-RestMethod -Uri "https://raw.githubusercontent.com/bernarddesfosse/onixclientautoupdate/main/OnixLauncher.exe" -OutFile "$([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop))\Onix Launcher.exe"; 

if ($Response.Count -eq 0) {
  [System.Windows.MessageBox]::Show('could not download the launcher');
} else {
  [System.Windows.MessageBox]::Show('The launcher is now on your desktop!');
}
