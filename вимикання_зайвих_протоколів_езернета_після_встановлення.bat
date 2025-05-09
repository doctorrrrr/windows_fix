@echo off
:: Назва тимчасового скрипту
set script=%temp%\limit_bindings.ps1

:: Створюємо PowerShell-скрипт
> "%script%" echo $adapter = Get-NetAdapter ^| Where-Object { $_.Status -eq 'Up' -and $_.HardwareInterface -eq $true } ^| Select-Object -First 1 -ExpandProperty Name
>> "%script%" echo if (-not $adapter) { Write-Host "❌ Не знайдено активного мережевого інтерфейсу!" -ForegroundColor Red; exit 1 }
>> "%script%" echo Write-Host "🔧 Обрано інтерфейс: $adapter" -ForegroundColor Cyan
>> "%script%" echo $keep = @("ms_msclient", "ms_tcpip")
>> "%script%" echo foreach ($id in $keep) { Enable-NetAdapterBinding -Name $adapter -ComponentID $id -ErrorAction SilentlyContinue }
>> "%script%" echo Get-NetAdapterBinding -Name $adapter ^| Where-Object { $_.ComponentID -notin $keep } ^| ForEach-Object { Disable-NetAdapterBinding -Name $adapter -ComponentID $_.ComponentID -ErrorAction SilentlyContinue }
>> "%script%" echo Write-Host "✅ Завершено. Залишено тільки Client for Microsoft Networks та IPv4." -ForegroundColor Green

:: Запуск із підвищеними правами
powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -NoProfile -File \"%script%\"' -Verb RunAs"
