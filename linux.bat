@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto AdminPrompt
) else ( goto AdminCheckDone )

:AdminPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0""", "", "runas", 1 >> "%temp%\getadmin.vbs"
    
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:AdminCheckDone
wsl --mount \\.\PHYSICALDRIVE3 --partition 3
wsl.exe cd /mnt/wsl/PHYSICALDRIVE3p3/boot/grub;bash linux.sh
wsl.exe --unmount \\.\PHYSICALDRIVE3
shutdown /r /f /t 0