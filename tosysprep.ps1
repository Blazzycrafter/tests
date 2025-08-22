#$dlp = ""

#Invoke-WebRequest -Uri $dlp -OutFile "C:\setup\setup.ps1"

.\sysprep\sysprep.exe /generalize /oobe /quit

# Den Registry-Wert ändern
Set-ItemProperty -Path "HKLM:\System\Setup" -Name "CmdLine" -Value "cmd.exe"
