#$dlp = ""

#Invoke-WebRequest -Uri $dlp -OutFile "C:\setup\setup.ps1"

# Sysprep starten
Start-Process -FilePath ".\sysprep\sysprep.exe" -ArgumentList "/generalize /oobe /quit" -Wait

# Warten bis Sysprep-Prozess beendet ist
Wait-Process -Name "sysprep" -ErrorAction SilentlyContinue

# Den Registry-Wert ändern
Set-ItemProperty -Path "HKLM:\System\Setup" -Name "CmdLine" -Value "cmd.exe"
