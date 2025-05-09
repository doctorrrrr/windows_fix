@echo off
setlocal

echo === Вимкнення Adobe Cloud Autorun ===

set FILE1="C:\Program Files (x86)\Adobe\Acrobat Reader DC\Acrobat\FullTrustNotifier.exe"
set FILE2="C:\Program Files (x86)\Adobe\Acrobat Reader DC\Acrobat\AdobeCollabSync.exe"
set FILE3="C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\FullTrustNotifier.exe"
set FILE4="C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AdobeCollabSync.exe"
set FILE5="C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat\FullTrustNotifier.exe"
set FILE6="C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat\AdobeCollabSync.exe"
set FILE7="C:\Program Files (x86)\Adobe\Acrobat DC\Reader\FullTrustNotifier.exe"
set FILE8="C:\Program Files (x86)\Adobe\Acrobat DC\Reader\AdobeCollabSync.exe"


for %%F in (%FILE1% %FILE2% %FILE3% %FILE4% %FILE5% %FILE6% %FILE7% %FILE8%) do (
    if exist %%F (
        echo Видаляю: %%F
        takeown /f %%F >nul
        icacls %%F /grant administrators:F >nul
        del /f /q %%F
    ) else (
        echo Не знайдено: %%F
    )
)

echo.
echo === Готово. Перевір Adobe Reader. ===
pause