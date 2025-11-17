@REM @CHCP 65001 >nul
@REM @SET PYTHONIOENCODING=UTF-8
@REM Moving to C drive to not advert user name.
CD C:\
CLS

@IF "%path:chocolatey=%" EQU "%path%" (
	ECHO Chocolatey not found, installing...
	@REM ECHO https://chocolatey.org/install
	@REM EXIT 1
	@REM SEE ALSO https://gist.github.com/krayfaus/2a68fbc7386d3cdbcb45c577b1d4bae8
	powershell -c "irm https://community.chocolatey.org/install.ps1|iex"
  ECHO Restart me if I crashed or looped here, please. Sorry.
  RefreshEnv
)
@REM SET "choco=%ChocolateyInstall%\bin\choco.exe"
@REM choco upgrade all --noop
@ECHO ON

@REM List outdated chocolatey packages.
@REM choco upgrade all --noop
choco outdated

@REM Find and apdate all chocolatey packages.
choco upgrade all -y
@REM Confirm to proceed.
@REM PAUSE

@WHERE scoop >nul 2>&1
@IF ERRORLEVEL 1 (
  @WHERE powershell >nul 2>&1 && (
    echo Installing Scoop...
    powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"
    powershell -Command "irm get.scoop.sh -outfile '%TEMP%\scoop-install.ps1'"
    powershell -Command "& '%TEMP%\scoop-install.ps1' -RunAsAdmin"
    @WHERE scoop >nul 2>&1
    @IF ERRORLEVEL 1 (
      ECHO Scoop installed! Restart me if I crashed or looped here, please. Sorry.
      RefreshEnv
    ) else (
      echo Scoop installation failed!
    )
  )
)
@REM FOR %%i IN ("status" "update *" "cache rm *" "cleanup *" "checkup" "status") DO (cmd /c "scoop %%~i")
FOR %%i IN (status update) do cmd /c "scoop %%i *"
cmd /c "scoop cache rm *"
FOR %%i IN (cleanup checkup status) do cmd /c "scoop %%i *"

@REM See https://redd.it/15oyh34
yt-dlp -U

@REM Python & pip updates
@FOR %%i IN (python python2) DO @choco list --limit-output -e "%%i" | findstr /i "%%i" >nul || choco install "%%i" -y
py -V&pip -V
python.exe -m pip install --upgrade pip
@REM Installing jq (if not installed) for pip packages update
@FOR %%i IN (jq) DO @choco list --limit-output -e "%%i" | findstr /i "%%i" >nul || choco install "%%i" -y
FOR /F %%i IN ('pip list --format json ^| jq -r ".[].name"') DO pip install -U %%i
pip cache purge

@FOR %%i IN (nodejs) DO @choco list --limit-output -e "%%i" | findstr /i "%%i" >nul || choco install "%%i" -y
cmd /c "node -v&npm -v"
@REM Upgrading to the latest version of npm
cmd /c "npm install npm@latest -g"
@REM Updating all globally-installed packages
cmd /c "npm update -g"
@REM npm cache verify
cmd /c "npm cache clean -f"
cmd /c "npm -v"

@FOR %%i IN (yarn) DO @choco list --limit-output -e "%%i" | findstr /i "%%i" >nul || choco install "%%i" -y
@REM npm install --global yarn
cmd /c "yarn --version"
cmd /c "yarn cache clean --all"

@FOR %%i IN (pnpm) DO @choco list --limit-output -e "%%i" | findstr /i "%%i" >nul || choco install "%%i" -y
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
