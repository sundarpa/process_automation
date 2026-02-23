@echo off
setlocal EnableDelayedExpansion

REM ============================================================
REM  QGENIE HW CLI Agent - Launcher
REM  API key is encrypted using Windows DPAPI (machine+user bound).
REM  Run setup_key.bat once to encrypt and embed your API key.
REM ============================================================

REM Encrypted API key - populated by setup_key.bat
set "ENCRYPTED_KEY=SETUP_REQUIRED"

if "!ENCRYPTED_KEY!"=="SETUP_REQUIRED" (
    echo ERROR: API key not set. Please run setup_key.bat first.
    pause
    exit /b 1
)

REM Decrypt the key using PowerShell DPAPI
for /f "delims=" %%i in ('powershell -NoProfile -Command "$enc='!ENCRYPTED_KEY!'; $sec=ConvertTo-SecureString $enc; $bstr=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec); [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)"') do set "QGENIE_API_KEY=%%i"

if "!QGENIE_API_KEY!"=="" (
    echo ERROR: Failed to decrypt API key. Try running setup_key.bat again.
    pause
    exit /b 1
)

cd /d C:\projects\qgenie-cli\qgeniehw_cli_standalone
python .\qgeniehw_cli.py

endlocal
