# Tests Repository Overview

This repository contains two PowerShell automation scripts that prepare and customize a Windows environment for deployment scenarios. The scripts focus on orchestrating Sysprep, launching deployment tooling, and configuring post-Sysprep tasks.

## Repository Structure

- `setup.ps1` &mdash; Launches Windows deployment tooling, creates a default local administrator user named `SETUP_USER_0` without a password, and configures the registry to bypass the Out-of-Box Experience (OOBE) completely.
- `tosysprep.ps1` &mdash; Downloads `setup.ps1` into `C:\setup`, runs `sysprep.exe` with `/generalize /oobe /quit`, configures the `HKLM:\SYSTEM\Setup` registry keys (`CmdLine` and `SetupType`) so that `setup.ps1` runs on next boot, and restarts the machine.

## Key Concepts and Behaviors

- **Deployment Kick-off (`setup.ps1`)**
  - Starts `$env:SystemRoot\System32\oobe\windeploy.exe` to run the Windows deployment tasks.
  - Creates a default local administrator account named `SETUP_USER_0` without a password.
  - Modifies registry values under `HKLM:\SYSTEM\Setup` to set `OOBEInProgress = 0`, `SetupType = 0`, and `SystemSetupInProgress = 0`, and clears the `CmdLine` key. This instructs Windows that setup and OOBE are completed, allowing it to boot directly to the desktop or login screen.

- **Sysprep Automation (`tosysprep.ps1`)**
  - Retrieves the latest `setup.ps1` from GitHub and stages it locally under `C:\setup`.
  - Executes `sysprep.exe` with generalization and OOBE parameters, waiting for the process to finish.
  - Updates `HKLM:\SYSTEM\Setup` `CmdLine` and `SetupType` (set to `2`) so the staged PowerShell script runs automatically after Sysprep, and reboots the system to finalize.

## Usage Notes

1. Run `tosysprep.ps1` from an elevated PowerShell session on the target machine. The script requires internet access to download `setup.ps1`.
2. After the system restarts, `setup.ps1` will execute automatically via the configured registry key and coordinate the deployment workflow.
3. Both scripts use absolute or environment-based paths for system utilities (e.g., `$env:SystemRoot\System32\oobe\windeploy.exe`, `$env:SystemRoot\System32\sysprep\sysprep.exe`).
4. Because the scripts modify system state (registry, Sysprep, restarts), test them in a controlled environment before production use.

## Contributing

See `AGENTS.md` for repository-specific contribution guidelines, including style conventions and documentation expectations for PowerShell scripts.

