@echo off

set NUMBER=3
set EXTRACTOR=Tools\Extractor
set APKTOOL=Tools\APKTool
set ROM=ROMS\%NUMBER%_ROM
set SYSTEM=%ROM%\System
set FRAMEWORKS=%ROM%\Frameworks
set TEMP=Temp_%NUMBER%

@echo on


	:: Extract .zip
cd ..\..
7z x *.zip -o%TEMP%\ system.new.dat.br system.transfer.list

	:: Convert .dat.br -> .dat
%Extractor%\Brotli.exe --decompress --in %TEMP%\system.new.dat.br --out %TEMP%\system.new.dat

	:: Convert .dat -> .img
%Extractor%\sdat2Img.exe %TEMP%\system.transfer.list %TEMP%\system.new.dat %TEMP%\system.img

	:: Extract .img
7z x -aos %TEMP%\system.img -o%SYSTEM%

	:: Add Frameworks
java -jar %APKTOOL%\apktool.jar if %SYSTEM%\system\framework\framework-res.apk -p %FRAMEWORKS%

java -jar %APKTOOL%\apktool.jar if %SYSTEM%\system\app\miui\miui.apk -p %FRAMEWORKS%

	:: Decompile MiuiCamera
java -jar %APKTOOL%\apktool.jar d --no-debug-info --output %ROM%\MiuiCamera %SYSTEM%\system\priv-app\MiuiCamera\MiuiCamera.apk -p %FRAMEWORKS%

	:: Cleanup
rmdir /Q /S %TEMP%

	:: Avoid closing of CMD to see potential issues
pause