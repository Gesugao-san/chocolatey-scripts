scoop install main/7zip main/git
FOR %%i IN (status update) do cmd /c "scoop %%i *"
scoop install temurin8-jre temurin16-jdk temurin17-jre temurin21-jre temurin-jre glfw
scoop bucket add unmojang https://github.com/unmojang/scoop-unmojang
scoop install unmojang/fjordlauncher
scoop bucket add java
scoop install java/visualvm
scoop bucket add games
scoop install games/mcedit2
scoop bucket add extras
scoop install extras/notepad3
@REM Manual install: https://www.ej-technologies.com/jprofiler/download → https://download.ej-technologies.com/jprofiler/jprofiler_windows-x64_15_0_3.exe
cmd /c "scoop cache rm *"
FOR %%i IN (cleanup checkup status) do cmd /c "scoop %%i *"
PAUSE
