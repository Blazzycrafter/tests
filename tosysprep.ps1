# hier ist tosysprep.ps1

$dlp = "https://raw.githubusercontent.com/Blazzycrafter/tests/refs/heads/master/setup.ps1"

# Setup-Verzeichnis sicher erstellen
# Safely create setup directory
if (-not (test-path -Path "C:\setup")) {
    new-item -Path "C:\setup" -ItemType Directory -Force
}

# Das setup.ps1 Skript herunterladen
# Download setup.ps1 script
invoke-webrequest -Uri $dlp -OutFile "C:\setup\setup.ps1"

# Sysprep mit absolutem Pfad starten und auf Beendigung warten
# Start Sysprep with absolute path and wait for completion
$sysprepProcess = start-process -FilePath "$env:SystemRoot\System32\sysprep\sysprep.exe" -ArgumentList "/generalize /oobe /quit" -Wait -PassThru
if ($sysprepProcess.ExitCode -ne 0) {
    throw "sysprep.exe failed with exit code $($sysprepProcess.ExitCode)"
}

# Den Registry-Wert fuer das Setup-Skript und den SetupType anpassen
# Adjust registry values for setup script and SetupType
$regPath = "HKLM:\SYSTEM\Setup"
$psScript = 'powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\setup\setup.ps1"'
set-itemproperty -Path $regPath -Name CmdLine -Value $psScript -Type String
set-itemproperty -Path $regPath -Name SetupType -Value 2 -Type DWord

# Computer neu starten
# Restart the computer
restart-computer
