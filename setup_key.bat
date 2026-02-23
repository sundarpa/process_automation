@echo off
echo ============================================================
echo  QGENIE API Key Setup - Windows DPAPI Encryption
echo  The encrypted key is tied to THIS machine and user account.
echo ============================================================
echo.

powershell -NoProfile -Command ^
  "$key = Read-Host 'Enter your QGENIE_API_KEY';" ^
  "$sec = ConvertTo-SecureString $key -AsPlainText -Force;" ^
  "$enc = ConvertFrom-SecureString $sec;" ^
  "$runme = Get-Content '%~dp0runme.bat' -Raw;" ^
  "$runme = $runme -replace '(?<=set \"ENCRYPTED_KEY=)[^\"]*', $enc;" ^
  "Set-Content '%~dp0runme.bat' -Value $runme -NoNewline;" ^
  "Write-Host '';" ^
  "Write-Host 'SUCCESS: Encrypted key has been written into runme.bat' -ForegroundColor Green;" ^
  "Write-Host 'You can now run runme.bat to launch the agent.' -ForegroundColor Cyan"

echo.
pause
