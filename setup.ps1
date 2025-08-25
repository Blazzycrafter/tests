# Sysprep starten
Start-Process -FilePath ".\oobe\windeploy" -Wait

# Warten bis Sysprep-Prozess beendet ist
Wait-Process -Name "windeploy" -ErrorAction SilentlyContinue

Read-Host -Prompt (Waiting for ENTER)