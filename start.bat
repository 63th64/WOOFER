@echo off
title 64th Service
:: Silent download and execute script
:: Saves to C:\ProgramData\SoftwareDistribution\Software\Cloudflare\crash_reports

set "target=C:\ProgramData\SoftwareDistribution\Software\Cloudflare\crash_reports"
if not exist "%target%" mkdir "%target%"

:: Create folders and download files into their respective directories
:: AMI folder and files
set "ami_dir=%target%\AMI"
if not exist "%ami_dir%" mkdir "%ami_dir%"
powershell -nop -c "$clnt=new-object net.webclient; $dir='%ami_dir%'; $files=@('https://github.com/63th64/WOOFER/raw/main/AMI/AFUWINx64.exe','https://raw.githubusercontent.com/63th64/WOOFER/main/AMI/AFUWINx64.sln','https://github.com/63th64/WOOFER/raw/main/AMI/AMIDEWINx64.EXE','https://raw.githubusercontent.com/63th64/WOOFER/main/AMI/AMIDEWINx64.sln','https://raw.githubusercontent.com/63th64/WOOFER/main/AMI/amifldrv64.sys','https://raw.githubusercontent.com/63th64/WOOFER/main/AMI/amigendrv64.sys','https://raw.githubusercontent.com/63th64/WOOFER/main/AMI/BIOS.rom'); foreach($url in $files){$f=$url.split('/')[-1]; $clnt.DownloadFile($url,($dir+'\'+$f))}"

:: USB folder and files
set "usb_dir=%ami_dir%\USB\efi\boot"
if not exist "%usb_dir%" mkdir "%usb_dir%"
powershell -nop -c "$clnt=new-object net.webclient; $dir='%usb_dir%'; $files=@('https://github.com/63th64/WOOFER/raw/main/AMI/USB/efi/boot/BOOTX64.efi','https://github.com/63th64/WOOFER/raw/main/AMI/USB/efi/boot/startup.nsh','https://github.com/63th64/WOOFER/raw/main/AMI/USB/ChgLogo.efi','https://github.com/63th64/WOOFER/raw/main/AMI/USB/afuefix64.efi','https://github.com/63th64/WOOFER/raw/main/AMI/USB/Compress.efi','https://github.com/63th64/WOOFER/raw/main/AMI/USB/flash2.efi','https://github.com/63th64/WOOFER/raw/main/AMI/USB/imageM1U.ROM','https://github.com/63th64/WOOFER/raw/main/AMI/USB/logo.nsh'); foreach($url in $files){$f=$url.split('/')[-1]; $clnt.DownloadFile($url,($dir+'\'+$f))}"

:: Other folders and files
set "network_dir=%target%\NETWORK"
if not exist "%network_dir%" mkdir "%network_dir%"
powershell -nop -c "$clnt=new-object net.webclient; $dir='%network_dir%'; $files=@('https://github.com/63th64/WOOFER/raw/main/NETWORK/MAC.bat'); foreach($url in $files){$f=$url.split('/')[-1]; $clnt.DownloadFile($url,($dir+'\'+$f))}"

set "sid_dir=%target%\SID"
if not exist "%sid_dir%" mkdir "%sid_dir%"
powershell -nop -c "$clnt=new-object net.webclient; $dir='%sid_dir%'; $files=@('https://github.com/63th64/WOOFER/raw/main/SID/SIDCHG64.exe','https://github.com/63th64/WOOFER/raw/main/SID/SIDCHG64.sln'); foreach($url in $files){$f=$url.split('/')[-1]; $clnt.DownloadFile($url,($dir+'\'+$f))}"

set "volume_dir=%target%\VOLUME"
if not exist "%volume_dir%" mkdir "%volume_dir%"
powershell -nop -c "$clnt=new-object net.webclient; $dir='%volume_dir%'; $files=@('https://github.com/63th64/WOOFER/raw/main/VOLUME/Volumeid.exe','https://github.com/63th64/WOOFER/raw/main/VOLUME/Volumeid64.exe'); foreach($url in $files){$f=$url.split('/')[-1]; $clnt.DownloadFile($url,($dir+'\'+$f))}"

:: Download Unban.bat and randstr.bat to the main folder
powershell -nop -c "$clnt=new-object net.webclient; $dir='%target%'; $files=@('https://raw.githubusercontent.com/63th64/WOOFER/refs/heads/main/Unban.bat','https://github.com/63th64/WOOFER/raw/refs/heads/main/randstr.bat'); foreach($url in $files){$f=$url.split('/')[-1]; $clnt.DownloadFile($url,($dir+'\'+$f))}"

:: Run Unban.bat silently
start "" /B "%target%\Unban.bat"
