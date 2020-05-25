@echo off

set CLASSES=ROM\classes
set SYSTEM=ROM\system
set VENDOR=ROM\vendor
set EXTRACTOR=Tools\Extractor
set APKTOOL=Tools\APKTool
set TEMP=TEMP
set ZIP=Tools\7z\7z.exe

@echo on


	:: Extract .zip
cd ..
%ZIP% x *.zip -o%TEMP%\ system.new.dat.br system.transfer.list vendor.new.dat.br vendor.transfer.list

	:: Convert .dat.br -> .dat
%Extractor%\Brotli.exe --decompress --in %TEMP%\system.new.dat.br --out %TEMP%\system.new.dat
%Extractor%\Brotli.exe --decompress --in %TEMP%\vendor.new.dat.br --out %TEMP%\vendor.new.dat

	:: Convert .dat -> .img
%Extractor%\sdat2Img.exe %TEMP%\system.transfer.list %TEMP%\system.new.dat %TEMP%\system.img
%Extractor%\sdat2Img.exe %TEMP%\vendor.transfer.list %TEMP%\vendor.new.dat %TEMP%\vendor.img

	:: Extract .img
%ZIP% x -aos %TEMP%\system.img -o%SYSTEM%
%ZIP% x -aos %TEMP%\vendor.img -o%VENDOR%

	:: Add Frameworks
java -jar %APKTOOL%\apktool.jar if %SYSTEM%\system\framework\framework-res.apk -p %APKTOOL%\Frameworks

java -jar %APKTOOL%\apktool.jar if %SYSTEM%\system\app\miui\miui.apk -p %APKTOOL%\Frameworks

	:: Decompile MiuiCamera
java -jar %APKTOOL%\apktool.jar d --no-debug-info --output ..\ANXCamera_APK %SYSTEM%\system\priv-app\MiuiCamera\MiuiCamera.apk -p %APKTOOL%\Frameworks

	:: Extract Classes [Trial and Error]
	
	:: miui.apk
%ZIP% x %SYSTEM%\system\app\miui\miui.apk -o%TEMP%\miui *.dex

	:: miuisystem.apk
%ZIP% x %SYSTEM%\system\app\miuisystem\miuisystem.apk -o%TEMP%\miuisystem *.dex

	:: framework.jar
%ZIP% x %SYSTEM%\system\framework\framework.jar -o%TEMP%\framework *.dex

	:: gson.jar
%ZIP% x %SYSTEM%\system\framework\gson.jar -o%TEMP%\gson *.dex

	:: Decompile Classes
java -jar %APKTOOL%\baksmali.jar d -o %CLASSES%\miui %TEMP%\miui\classes.dex
java -jar %APKTOOL%\baksmali.jar d -o %CLASSES%\miuisystem %TEMP%\miuisystem\classes.dex
java -jar %APKTOOL%\baksmali.jar d -o %CLASSES%\framework %TEMP%\framework\classes.dex
java -jar %APKTOOL%\baksmali.jar d -o %CLASSES%\framework %TEMP%\framework\classes2.dex
java -jar %APKTOOL%\baksmali.jar d -o %CLASSES%\framework %TEMP%\framework\classes3.dex
java -jar %APKTOOL%\baksmali.jar d -o %CLASSES%\framework %TEMP%\framework\classes4.dex
java -jar %APKTOOL%\baksmali.jar d -o %CLASSES%\gson %TEMP%\gson\classes.dex

	:: Cleanup
rmdir /Q /S %TEMP%

	:: Avoid closing of CMD to see potential issues
pause