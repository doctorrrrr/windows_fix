@echo off
echo === ЗУПИНКА WMI ===
net stop winmgmt /y

echo === ВИДАЛЕННЯ WMI REPOSITORY ===
cd /d %windir%\system32\wbem
rd /s /q repository

echo === ВІДНОВЛЕННЯ ОБОЛОНКИ EXPLORER ===
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell /t REG_SZ /d explorer.exe /f

echo === ГОТОВО. ПЕРЕЗАВАНТАЖЕННЯ... ===
pause
shutdown /r /t 5
