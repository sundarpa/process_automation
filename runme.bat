@echo off
setlocal EnableDelayedExpansion

REM ============================================================
REM  QGENIE HW CLI Agent - Launcher (Windows)
REM  API key is encrypted with Windows DPAPI (machine+user bound).
REM  Stored in: %USERPROFILE%\Documents\.tscript
REM  Run setup_key.bat once to encrypt and store your API key.
REM ============================================================

set "KEYFILE=%USERPROFILE%\Documents\.tscript"

if not exist "!KEYFILE!" (
    echo ERROR: API key not found at !KEYFILE!
    echo Please run setup_key.bat first.
    pause
    exit /b 1
)

REM Decrypt the key using PowerShell DPAPI
for /f "delims=" %%i in ('powershell -NoProfile -NonInteractive -Command "$p=Join-Path([Environment]::GetFolderPath('MyDocuments')) '.tscript'; $e=Get-Content $p; $s=ConvertTo-SecureString $e; $b=[Runtime.InteropServices.Marshal]::SecureStringToBSTR($s); [Runtime.InteropServices.Marshal]::PtrToStringAuto($b)"') do set "QGENIE_API_KEY=%%i"

if "!QGENIE_API_KEY!"=="" (
    echo ERROR: Failed to decrypt API key. Try running setup_key.bat again.
    pause
    exit /b 1
)

cd /d C:\projects\qgenie-cli\qgeniehw_cli_standalone
python .\qgeniehw_cli.py

endlocal
