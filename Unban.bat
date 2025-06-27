@echo off
color 0a

echo ==============================
echo =        64TH Service        =
echo ==============================

echo.

:: Check if running as admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Run as admin..
    pause
    exit /b
)

:: Automatically detect motherboard type
echo Detecting motherboard...
set isAsus=No
set isLocked=No

:: Use WMIC to fetch baseboard info
for /f "tokens=2 delims==" %%i in ('wmic baseboard get manufacturer /value') do set "manufacturer=%%i"
for /f "tokens=2 delims==" %%i in ('wmic baseboard get product /value') do set "product=%%i"

echo Manufacturer: %manufacturer%
echo Product: %product%

if /i "%manufacturer%"=="ASUS" (
    set isAsus=Yes
    echo Asus motherboard detected.
) else if /i "%manufacturer%"=="HP" (
    set isLocked=Yes
    echo HP motherboard detected.
) else if /i "%manufacturer%"=="Dell" (
    set isLocked=Yes
    echo Dell motherboard detected.
) else (
    echo Unknown motherboard detected.
    set isLocked=No
)

echo.
echo Proceeding with spoofing process...
timeout /t 5 >nul

:: Generate random strings
for /f "delims=" %%i in ('call "%~dp0randstr.bat" 10') do set "output9=%%i"
for /f "delims=" %%i in ('call "%~dp0randstr.bat" 14') do set "output91=%%i"
for /f "delims=" %%i in ('call "%~dp0randstr.bat" 10') do set "output92=%%i"

cd "%~dp0AMI"

if /i "%isLocked%" == "No" (
    echo [32mSpoofing Motherboard...[0m
    timeout /t 10 >nul

    "%~dp0AMI\AMIDEWINx64.EXE" /IVN "AMI Technologies Inc." >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /SM "GigaCompute Corp." >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /SP "UltraBoard X570-Pro" >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /SV "Rev 2.3" >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /SS %output9% >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /SU AUTO >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /SK "GCX570-22B9-RN8W-445T" >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /SF "Enthusiast Desktop" >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /BM "ASRock" >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /BP "B560M-C" >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /BV "1.00-UEFI" >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /BS %output91% >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /BT "Performance Series" >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /BLC "USA-EAST-001" >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /CM "CoolerMaster Xtreme" >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /CV "1.2.0" >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /CS %output92% >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /CA "Standard ATX" >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /CSK "GSK-4109" >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /PSN "UCV1123XZ9832" >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /PAT "X-Pro Tower Chassis" >nul
    "%~dp0AMI\AMIDEWINx64.EXE" /PPN "V1.1.443" >nul

    echo [32mMotherboard Spoofed![0m
)

if /i "%isAsus%" == "Yes" (
    echo [32mSpoofing BIOS...[0m
    timeout /t 10 >nul

    "%~dp0AMI\AFUWINx64.exe" BIOS.rom /o >nul
    "%~dp0AMI\AFUWINx64.exe" BIOS.rom /p >nul

    echo [32mBIOS Spoofed![0m
)

if /i "%isLocked%" == "Yes" (
    echo [32mSpoofing CHASSIS...[0m
    timeout /t 5 >nul

    cd "%~dp0AMI\USB\efi\boot"

    (
        echo echo -off
        echo AMIDEEFIx64.efi /IVN "AMI Technologies Inc."
        echo AMIDEEFIx64.efi /SM "GigaCompute Corp."
        echo AMIDEEFIx64.efi /SP "UltraBoard X570-Pro"
        echo AMIDEEFIx64.efi /SV "Rev 2.3"
        echo AMIDEEFIx64.efi /SS "%output9%"
        echo AMIDEEFIx64.efi /SU AUTO
        echo AMIDEEFIx64.efi /SK "GCX570-22B9-RN8W-445T"
        echo AMIDEEFIx64.efi /SF "Enthusiast Desktop"
        echo AMIDEEFIx64.efi /BM "ASRock"
        echo AMIDEEFIx64.efi /BP "B560M-C"
        echo AMIDEEFIx64.efi /BV "1.00-UEFI"
        echo AMIDEEFIx64.efi /BS "%output91%"
        echo AMIDEEFIx64.efi /BT "Performance Series"
        echo AMIDEEFIx64.efi /BLC "USA-EAST-001"
        echo AMIDEEFIx64.efi /CM "CoolerMaster Xtreme"
        echo AMIDEEFIx64.efi /CV "1.2.0"
        echo AMIDEEFIx64.efi /CS "%output92%"
        echo AMIDEEFIx64.efi /CA "Standard ATX"
        echo AMIDEEFIx64.efi /CSK "GSK-4109"
        echo AMIDEEFIx64.efi /PSN "UCV1123XZ9832"
        echo AMIDEEFIx64.efi /PAT "X-Pro Tower Chassis"
        echo AMIDEEFIx64.efi /PPN "V1.1.443"
        echo exit
    ) > "startup.nsh"

    cd "%~dp0"

    echo [32mCHASSIS Spoofed![0m

    echo [32mSpoofing CPU..[0m
    timeout /t 5 >nul
    echo [32mCPU Spoofed![0m
)

echo [32mSpoofing SMBIOS...[0m
timeout /t 7 >nul

@for /f "delims=" %%i in ('call "%~dp0randstr.bat" 4 /v') do @set "output3=%%i"
@for /f "delims=" %%i in ('call "%~dp0randstr.bat" 4 /v') do @set "output31=%%i"
@for /f "delims=" %%i in ('call "%~dp0randstr.bat" 4 /v') do @set "output32=%%i"
@for /f "delims=" %%i in ('call "%~dp0randstr.bat" 4 /v') do @set "output33=%%i"
@for /f "delims=" %%i in ('call "%~dp0randstr.bat" 4 /v') do @set "output34=%%i"
@for /f "delims=" %%i in ('call "%~dp0randstr.bat" 4 /v') do @set "output35=%%i"
@for /f "delims=" %%i in ('call "%~dp0randstr.bat" 4 /v') do @set "output36=%%i"
@for /f "delims=" %%i in ('call "%~dp0randstr.bat" 4 /v') do @set "output37=%%i"

@cd "%~dp0VOLUME" >nul

@"%~dp0VOLUME\Volumeid64.exe" C: %output3%-%output31% /accepteula >nul
@"%~dp0VOLUME\Volumeid64.exe" D: %output32%-%output33% /accepteula >nul
@"%~dp0VOLUME\Volumeid64.exe" E: %output34%-%output35% /accepteula >nul
@"%~dp0VOLUME\Volumeid64.exe" F: %output36%-%output37% /accepteula >nul

echo [32mSMBIOS Spoofed![0m

cd "%~dp0SID"
"%~dp0SID\SIDCHG64.exe" /KEY="7rq1f-#R!ZE-g#f4O-tZ" /F /R /OD /RESETALLAPPS >nul

echo.
echo [32mEverything Spoofed![0m
echo [32mWe are from 64rd, not from 63rd![0m
timeout /t 5 >nul
pause
