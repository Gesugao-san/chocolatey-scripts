@REM Moving to C drive to not advert user name.
CD C:\
CLS

@IF "%path:chocolatey=%" EQU "%path%" (
	ECHO Chocolatey not found, installing...
	@REM ECHO https://chocolatey.org/install
	@REM EXIT 1
	@REM SEE ALSO https://gist.github.com/krayfaus/2a68fbc7386d3cdbcb45c577b1d4bae8
	powershell -c "irm https://community.chocolatey.org/install.ps1|iex"
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

@REM cmd /c "scoop status"
@REM cmd /c "scoop update *"
@REM cmd /c "scoop cache rm *"
@REM cmd /c "scoop cleanup *"
@REM cmd /c "scoop checkup"
@REM cmd /c "scoop status"
FOR %%i IN ("status" "update *" "cache rm *" "cleanup *" "checkup" "status") DO (cmd /c "scoop %%~i")

@REM See https://redd.it/15oyh34
yt-dlp -U

py -V&pip -V
@REM python.exe -m pip install --upgrade pip
choco install jq -y
@REM See https://github.com/pypa/pip/issues/4551#issuecomment-2324945466
FOR /F %%i IN ('pip list --format json ^| jq -r ".[].name"') DO pip install -U %%i
pip cache purge
pip -V

choco install nodejs -y
node -v&npm -v
@REM Upgrading to the latest version of npm
npm install npm@latest -g
@REM Updating all globally-installed packages
npm update -g
@REM npm cache verify
npm cache clean -f
npm -v

choco install yarn -y
@REM npm install --global yarn
yarn --version
yarn cache clean --all

choco install pnpm -y
@REM scoop install nodejs nodejs-lts pnpm
@REM pnpm store path
@REM pnpm cache delete
pnpm store prune

@REM View what was cached.
choco cache list
@REM Remove cached data.
choco cache remove

@REM Unnessesary, except if PowerShell was IN the updated list.
RefreshEnv
