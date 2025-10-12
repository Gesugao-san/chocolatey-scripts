FOR %%i IN (status update) do cmd /c "scoop %%i *"
scoop install temurin8-jre temurin16-jdk temurin17-jre temurin21-jre temurin-jre glfw -y
scoop bucket add unmojang https://github.com/unmojang/scoop-unmojang -y
@REM scoop bucket add hero-persson https://github.com/hero-persson/scoop-unmojang
scoop install fjordlauncher -y
cmd /c "scoop cache rm *"
FOR %%i IN (cleanup checkup status) do cmd /c "scoop %%i *"
PAUSE
