# Tests Repository Overview

This repository contains two PowerShell automation scripts that prepare and customize a Windows environment for deployment scenarios. The scripts focus on orchestrating Sysprep, launching deployment tooling, and configuring post-Sysprep tasks.

## Repository Structure

- `setup.ps1` &mdash; Launches Windows deployment tooling, tracks newly spawned processes, and waits for their completion. Captures snapshots of current users and running processes before and after launching `ms-cxh:localonly` to identify the spawned process.
- `tosysprep.ps1` &mdash; Downloads `setup.ps1` into `C:\setup`, runs `sysprep.exe` with `/generalize /oobe /quit`, waits for completion, configures the `HKLM:\SYSTEM\Setup` registry key so that `setup.ps1` runs on next boot, and restarts the machine.

## Key Concepts and Behaviors

- **Deployment Kick-off (`setup.ps1`)**
  - Starts `.\oobe\windeploy` to begin the Windows deployment experience.
  - Captures snapshots of local user accounts and running processes to detect changes.
  - Launches `ms-cxh:localonly`, identifies the new process it spawns, and waits until it exits before continuing.

- **Sysprep Automation (`tosysprep.ps1`)**
  - Retrieves the latest `setup.ps1` from GitHub and stages it locally under `C:\setup`.
  - Executes `sysprep.exe` with generalization and OOBE parameters, then waits for the process to finish.
  - Updates `HKLM:\SYSTEM\Setup` `CmdLine` so the staged PowerShell script runs automatically after Sysprep, and reboots the system to finalize.

## Usage Notes

1. Run `tosysprep.ps1` from an elevated PowerShell session on the target machine. The script requires internet access to download `setup.ps1`.
2. After the system restarts, `setup.ps1` will execute automatically via the configured registry key and coordinate the deployment workflow.
3. Both scripts assume the presence of the Windows deployment tools in the relative paths used (e.g., `.\oobe\windeploy`, `.\sysprep\sysprep.exe`). Adjust paths if your environment differs.
4. Because the scripts modify system state (registry, Sysprep, restarts), test them in a controlled environment before production use.

## Contributing

See `AGENTS.md` for repository-specific contribution guidelines, including style conventions and documentation expectations for PowerShell scripts.
