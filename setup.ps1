# hier ist setup.ps1

# windeploy starten
Start-Process -FilePath ".\oobe\windeploy" -Wait

# Snapshot aller aktuell existierenden User in eine Variable
$userSnapshot = Get-LocalUser | Select-Object -ExpandProperty Name

# Snapshot aller aktuell laufenden Prozesse in eine Variable
$processSnapshot = Get-Process | Select-Object -ExpandProperty ProcessName

# ms-cxh:localonly starten
Start-Process -FilePath "ms-cxh:localonly"

# Neuen Snapshot aller Prozesse
$newProcessSnapshot = Get-Process | Select-Object -ExpandProperty ProcessName

# Den neuen Prozess ermitteln
$newProcess = $newProcessSnapshot | Where-Object { $_ -notin $processSnapshot }

Write-Output "Neuer Prozess gestartet: $newProcess"

# Auf Beendigung des neuen Prozesses warten
if ($newProcess) {
    Wait-Process -Name $newProcess -ErrorAction SilentlyContinue
}






Read-Host
