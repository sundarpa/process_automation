# Windows run helper for qgeniehw_cli_standalone
# Usage:
#   powershell -ExecutionPolicy Bypass -File .\runme_windows.ps1
#
# Optional: set QGENIE_API_KEY before running, or edit below.
#   $env:QGENIE_API_KEY = "<your_key_here>"

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Ensure we're running from this folder
Set-Location -Path $PSScriptRoot

if (-not $env:QGENIE_API_KEY) {
  Write-Host "ERROR: QGENIE_API_KEY is not set." -ForegroundColor Red
  Write-Host "Set it in PowerShell:" -ForegroundColor Yellow
  Write-Host '  $env:QGENIE_API_KEY = "<your_key_here>"'
  exit 1
}

python .\qgeniehw_cli.py help
python .\qgeniehw_cli.py
