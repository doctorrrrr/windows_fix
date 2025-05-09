@echo off
setlocal enabledelayedexpansion

echo === BACKUP РЕЄСТРУ ===
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" %userprofile%\Desktop\ProfileList_backup.reg

echo === ПОШУК ПРОФІЛІВ .bak ===
for /f "tokens=*" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"') do (
    reg query "%%A" | findstr /i ".bak" >nul
    if %errorlevel%==0 (
        set BAK_KEY=%%A
        set MAIN_KEY=!BAK_KEY:.bak=!
        echo ЗНАЙДЕНО: !BAK_KEY!
        
        echo ВИДАЛЕННЯ ПІДІРВАНОГО ПРОФІЛЮ: !MAIN_KEY!
        reg delete "!MAIN_KEY!" /f
        
        echo ПЕРЕЙМЕНУВАННЯ !BAK_KEY! -> !MAIN_KEY!
        reg copy "!BAK_KEY!" "!MAIN_KEY!" /s /f
        reg delete "!BAK_KEY!" /f
    )
)

echo.
echo === ГОТОВО. ПЕРЕЗАВАНТАЖЕННЯ ЧЕРЕЗ 10 секунд ===
timeout /t 10
shutdown /r /t 0