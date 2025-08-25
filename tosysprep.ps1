# hier ist tosysprep.ps1

$dlp = "https://raw.githubusercontent.com/Blazzycrafter/tests/refs/heads/main/setup.ps1"

Invoke-WebRequest -Uri $dlp -OutFile "C:\setup\setup.ps1"

# Sysprep starten
Start-Process -FilePath ".\sysprep\sysprep.exe" -ArgumentList "/generalize /oobe /quit" -Wait

# Warten bis Sysprep-Prozess beendet ist
Wait-Process -Name "sysprep" -ErrorAction SilentlyContinue

# Den Registry-Wert ändern
$regPath = "HKLM:\SYSTEM\Setup"
$psScript = 'powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\setup\setup.ps1"'
Set-ItemProperty -Path $regPath -Name CmdLine -Value $psScript


Restart-Computer
