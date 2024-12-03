CD C:\
CLS
@ECHO OFF
IF "%path:chocolatey=%" EQU "%path%" (
	ECHO Chocolatey not found
	ECHO https://chocolatey.org/install
	EXIT 1
)
@REM SET "choco=%ChocolateyInstall%\bin\choco.exe"
@REM choco upgrade all --noop
@ECHO ON

choco outdated
PAUSE
CLS
choco upgrade all -y
PAUSE
refreshenv
