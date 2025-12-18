ECHO OFF
SETLOCAL

SET "SCRIPT_URL=https://raw.githubusercontent.com/Gesugao-san/chocolatey-scripts/refs/heads/master/src/self-updating-test-v2.cmd"
SET "SCRIPT_PATH=%~f0"
SET "TEMP_FILE=%TEMP%\update_%random%.cmd"

ECHO Checking FOR updates...
ECHO Downloading: !SCRIPT_URL!

:: 1. Скачиваем файл
powershell -Command "Invoke-WebRequest -Uri '%SCRIPT_URL%' -OutFile '!TEMP_FILE!'" >nul 2>&1

IF NOT EXIST "!TEMP_FILE!" (
  ECHO Download failed
  GOTO :main
)

:: 2. Вычисляем SHA256 текущего и скачанного скрипта
ECHO Calculating hashes...
FOR /f "delims=" %%A IN ('powershell -Command "Get-FileHash -Path '%SCRIPT_URL%' -Algorithm SHA256 | %%{ $_.Hash }"') DO SET "CURRENT_HASH=%%A"
FOR /f "delims=" %%A IN ('powershell -Command "Get-FileHash -Path '!TEMP_FILE!' -Algorithm SHA256 | %%{ $_.Hash }"') DO SET "NEW_HASH=%%A"

:: 3. Сравниваем хеши
IF "!CURRENT_HASH!"=="!NEW_HASH!" (
  ECHO No updates available
  DEL "!TEMP_FILE!" >nul 2>&1
  GOTO :main
)

:: 4. Заменяем и перезапускаемся
ECHO Update found! Replacing script...
COPY "!TEMP_FILE!" "%SCRIPT_PATH%" /Y >nul

ECHO Restarting updated script...
TIMEOUT /t 2 /nobreak >nul
START "" "%SCRIPT_URL%"
DEL "!TEMP_FILE!" >nul 2>&1
EXIT /b 0

:main
:: Основная логика скрипта
ECHO.
ECHO ========================================
ECHO    MAIN SCRIPT (v2.0)
ECHO ========================================
ECHO.
ECHO Performing main tasks...
TIMEOUT /t 3 /nobreak >nul
ECHO Tasks completed!
ECHO.
PAUSE
