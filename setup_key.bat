@echo off
echo ============================================================
echo  QGENIE API Key Setup - Windows DPAPI Encryption
echo  Key stored in: %%USERPROFILE%%\Documents\.tscript
echo  (Never committed to git - stored outside the repo)
echo ============================================================
echo.

powershell -NoProfile -Command "$key = Read-Host 'Enter your QGENIE_API_KEY'; $sec = ConvertTo-SecureString $key -AsPlainText -Force; $enc = ConvertFrom-SecureString $sec; $path = Join-Path ([Environment]::GetFolderPath('MyDocuments')) '.tscript'; Set-Content -Path $path -Value $enc; Write-Host ''; Write-Host ('SUCCESS: Encrypted key saved to ' + $path) -ForegroundColor Green; Write-Host 'You can now run runme.bat to launch the agent.' -ForegroundColor Cyan"

echo.
pause
