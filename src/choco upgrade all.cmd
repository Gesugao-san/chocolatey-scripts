CD C:\
CLS
@REM choco upgrade all --noop
choco outdated
PAUSE
CLS
choco upgrade all -y
PAUSE
refreshenv
