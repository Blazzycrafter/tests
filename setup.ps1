# hier ist setup.ps1

# windeploy mit absolutem Pfad starten und auf Beendigung warten
# Start windeploy with absolute path and wait for completion
start-process -FilePath "$env:SystemRoot\System32\oobe\windeploy.exe" -Wait

# Lokalen Standardbenutzer SETUP_USER_0 anlegen, falls er nicht existiert
# Create default local user SETUP_USER_0 if it does not exist
$username = "SETUP_USER_0"
if (-not (get-localuser -Name $username -ErrorAction SilentlyContinue)) {
    # Benutzer ohne Kennwort anlegen
    # Create user without password
    new-localuser -Name $username -NoPassword -Description "Default setup user" -FullName "Setup User"

    # Benutzer zur Gruppe der Administratoren hinzufügen
    # Add user to local administrators group
    add-localgroupmember -Group "Administrators" -Member $username
}

# Registry-Werte anpassen, um die OOBE-Phase komplett zu überspringen
# Adjust registry values to entirely skip the OOBE phase
$regPath = "HKLM:\SYSTEM\Setup"
set-itemproperty -Path $regPath -Name "OOBEInProgress" -Value 0 -Type DWord
set-itemproperty -Path $regPath -Name "SetupType" -Value 0 -Type DWord
set-itemproperty -Path $regPath -Name "SystemSetupInProgress" -Value 0 -Type DWord

# CmdLine leeren, damit das Skript beim nächsten Start nicht erneut ausgeführt wird
# Clear CmdLine so the script does not execute again on the next boot
set-itemproperty -Path $regPath -Name "CmdLine" -Value "" -Type String
