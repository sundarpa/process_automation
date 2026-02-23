# Progress Report - process_automation

## Plan
1. [x] Create `bkup` branch from `main` to preserve all existing content
2. [x] Push `bkup` branch to remote (GitHub)
3. [x] Switch back to `main` branch
4. [x] Delete all files from `main` branch
5. [x] Create README.md
6. [x] Create Progress_report.md
7. [x] Commit and push cleaned `main` to remote

## Progress

### 2026-02-22
- Created `bkup` branch from `main` — all original files preserved there.
- Pushed `bkup` branch to `https://github.com/sundarpa/process_automation`.
- Deleted all project files from `main` branch.
- Created `README.md` and `Progress_report.md`.
- Committed and pushed clean `main` to remote.
- Copied contents of `C:\projects\qgenie-cli\qgeniehw_cli_standalone` into repo.
- Committed and pushed new content to `main`.
- Created `runme.bat` with Windows DPAPI-encrypted API key support.
- Created `setup_key.bat` for one-time key encryption setup.

### 2026-02-23
- Moved encrypted key storage outside the repo:
  - Windows: `%USERPROFILE%\Documents\.tscript` (DPAPI encrypted)
  - Unix: `~/.tscript` (Python Fernet encrypted, machine+user bound)
- Updated `runme.bat` to read/decrypt from `%USERPROFILE%\Documents\.tscript`.
- Updated `setup_key.bat` to encrypt and save to `%USERPROFILE%\Documents\.tscript`.
- Created `setup_key.sh` for Unix one-time key encryption setup.
- Updated `runme_unix.sh` to read/decrypt from `~/.tscript`.
- Added `cryptography` to `requirements.txt` (needed for Fernet on Unix).
