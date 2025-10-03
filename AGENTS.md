# Repository Contribution Guidelines

- Scope: Applies to the entire repository unless a subdirectory provides its own `AGENTS.md`.
- PowerShell Style:
  - Use four-space indentation and avoid tabs.
  - Prefer lowercase cmdlets with PascalCase parameters as shown in the existing scripts.
  - Add descriptive comments for each logical block in PowerShell files to explain intent.
- Documentation:
  - Update `README.md` whenever you add or significantly change scripts or behavior.
  - When introducing new scripts, include a short usage example and note any external dependencies.
- Testing:
  - Provide manual or automated validation steps in the PR description for any script changes.
- Localization:
  - Preserve existing language (German comments) unless there is a compelling reason to change them; add translations if helpful.
