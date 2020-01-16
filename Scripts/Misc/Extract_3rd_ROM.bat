@ECHO OFF

set NUMBER=3rd
set EXTRACTOR=Tools\Extractor
set APKTOOL=Tools\APKTool
set ROM=ROMS\%NUMBER%_ROM
set SYSTEM=%ROM%\system
set VENDOR=%ROM%\vendor
set FRAMEWORKS=%ROM%\Frameworks
set APK=%ROM%
set TEMP=Temp_%NUMBER%

@ECHO ON


	:: Extract .zip
cd ..\..
7z x *.zip -o%TEMP%\ system.new.dat.br system.transfer.list vendor.new.dat.br vendor.transfer.list

	:: Convert .dat.br -> .dat
%Extractor%\Brotli.exe --decompress --in %TEMP%\system.new.dat.br --out %TEMP%\system.new.dat
%Extractor%\Brotli.exe --decompress --in %TEMP%\vendor.new.dat.br --out %TEMP%\vendor.new.dat

	:: Convert .dat -> .img
%Extractor%\sdat2Img.exe %TEMP%\system.transfer.list %TEMP%\system.new.dat %TEMP%\system.img
%Extractor%\sdat2Img.exe %TEMP%\vendor.transfer.list %TEMP%\vendor.new.dat %TEMP%\vendor.img

	:: Extract .img
7z x -aos %TEMP%\system.img -o%SYSTEM%
7z x -aos %TEMP%\vendor.img -o%VENDOR%

	:: Cleanup
rmdir /Q /S %TEMP%

	:: Avoid closing of CMD to see potential issues
pause