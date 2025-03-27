@REM Moving to C drive to not advert user name.
CD C:\
CLS

IF "%path:chocolatey=%" EQU "%path%" (
	ECHO Chocolatey not found
	ECHO https://chocolatey.org/install
	EXIT 1
)
@REM SET "choco=%ChocolateyInstall%\bin\choco.exe"
@REM choco upgrade all --noop
@ECHO ON

@REM List outdated chocolatey packages.
@REM choco upgrade all --noop
choco outdated

@REM Confirm to proceed.
PAUSE
CLS

@REM Find and apdate all chocolatey packages.
choco upgrade all -y
@REM Confirm to proceed.
PAUSE

py -V&pip -V
python.exe -m pip install --upgrade pip
pip cache purge
pip -V

node -v&npm -v
npm install -g npm@latest
@REM npm cache verify
npm cache clean -f
npm -v

yarn cache clean --all
@REM pnpm store path
@REM pnpm cache delete
pnpm store prune

@REM View what was cached.
choco cache list
@REM Remove cached data.
choco cache remove

@REM Unnessesary, except if PowerShell was in the updated list.
RefreshEnv
