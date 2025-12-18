@echo off
setlocal

set "SCRIPT_URL=https://raw.githubusercontent.com/Gesugao-san/chocolatey-scripts/refs/heads/master/src/self-updating-test-v2.cmd"
set "SCRIPT_PATH=%~f0"
set "TEMP_FILE=%TEMP%\update_%random%.cmd"

echo Checking for updates...
echo Downloading: !SCRIPT_URL!

:: 1. Скачиваем файл
powershell -Command "Invoke-WebRequest -Uri '!SCRIPT_URL!' -OutFile '!TEMP_FILE!'" >nul 2>&1

if not exist "!TEMP_FILE!" (
  echo Download failed
  goto :main
)

:: 2. Вычисляем SHA256 текущего и скачанного скрипта
echo Calculating hashes...
for /f "delims=" %%A in ('powershell -Command "Get-FileHash -Path '!SCRIPT_PATH!' -Algorithm SHA256 | %%{ $_.Hash }"') do set "CURRENT_HASH=%%A"
for /f "delims=" %%A in ('powershell -Command "Get-FileHash -Path '!TEMP_FILE!' -Algorithm SHA256 | %%{ $_.Hash }"') do set "NEW_HASH=%%A"

:: 3. Сравниваем хеши
if "!CURRENT_HASH!"=="!NEW_HASH!" (
  echo No updates available
  del "!TEMP_FILE!" >nul 2>&1
  goto :main
)

:: 4. Заменяем и перезапускаемся
echo Update found! Replacing script...
copy "!TEMP_FILE!" "!SCRIPT_PATH!" /Y >nul

echo Restarting updated script...
timeout /t 2 /nobreak >nul
start "" "!SCRIPT_PATH!"
del "!TEMP_FILE!" >nul 2>&1
exit /b 0

:main
:: Основная логика скрипта
echo.
echo ========================================
echo    MAIN SCRIPT (v2.0)
echo ========================================
echo.
echo Performing main tasks...
timeout /t 3 /nobreak >nul
echo Tasks completed!
echo.
pause