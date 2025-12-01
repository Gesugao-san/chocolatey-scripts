@echo off
SetLocal EnableExtensions EnableDelayedExpansion
cd /D "%~dp0"

npm list
pnpm list
choco list

pause
exit /B
