@echo off
cd /d "%~dp0"
"%USERPROFILE%\AppData\Local\Microsoft\WinGet\Packages\Hugo.Hugo.Extended_Microsoft.Winget.Source_8wekyb3d8bbwe\hugo.exe" server -D --bind 127.0.0.1 --port 1313
pause