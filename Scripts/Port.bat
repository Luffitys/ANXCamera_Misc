@ECHO OFF

set EXTRACTOR=Tools\Extractor
set SYSTEM=ROMS\REQUIRED_ROM\ROM\system
set VENDOR=ROMS\REQUIRED_ROM\ROM\vendor
set APKTOOL=Tools\APKTool
set CLASSES=ROMS\REQUIRED_ROM\Required_Classes

@ECHO ON


	:: Extract .zip
cd ..
7z x *.zip -oTemp\ system.new.dat.br system.transfer.list vendor.new.dat.br vendor.transfer.list

	:: Convert .dat.br -> .dat
%Extractor%\Brotli.exe --decompress --in Temp\system.new.dat.br --out Temp\system.new.dat
%Extractor%\Brotli.exe --decompress --in Temp\vendor.new.dat.br --out Temp\vendor.new.dat

	:: Convert .dat -> .img
%Extractor%\sdat2Img.exe Temp\system.transfer.list Temp\system.new.dat Temp\system.img
%Extractor%\sdat2Img.exe Temp\vendor.transfer.list Temp\vendor.new.dat Temp\vendor.img

	:: Extract .img
7z x -aos Temp\system.img -o%SYSTEM%
7z x -aos Temp\vendor.img -o%VENDOR%

	:: Add Frameworks
java -jar %APKTOOL%\apktool.jar if %SYSTEM%\system\framework\framework-res.apk -p Tools\APKTool\Frameworks

java -jar %APKTOOL%\apktool.jar if %SYSTEM%\system\app\miui\miui.apk -p %APKTOOL%\Frameworks

	:: Decompile MiuiCamera
java -jar %APKTOOL%\apktool.jar d --no-debug-info --output ..\ANXCamera_APK %SYSTEM%\system\priv-app\MiuiCamera\MiuiCamera.apk -p %APKTOOL%\Frameworks

	:: Extract Classes [Trial and Error]
	
	:: miui.apk
7z x %SYSTEM%\system\app\miui\miui.apk -oTemp\miui *.dex

	:: miuisystem.apk
7z x %SYSTEM%\system\app\miuisystem\miuisystem.apk -oTemp\miuisystem *.dex

	:: framework.jar
7z x %SYSTEM%\system\framework\framework.jar -oTemp\framework *.dex

	:: gson.jar
7z x %SYSTEM%\system\framework\gson.jar -oTemp\gson *.dex

	:: Decompile Classes
java -jar %APKTOOL%\baksmali.jar d -o %CLASSES%\miui Temp\miui\classes.dex
java -jar %APKTOOL%\baksmali.jar d -o %CLASSES%\miuisystem Temp\miuisystem\classes.dex
java -jar %APKTOOL%\baksmali.jar d -o %CLASSES%\framework Temp\framework\classes.dex
java -jar %APKTOOL%\baksmali.jar d -o %CLASSES%\framework Temp\framework\classes2.dex
java -jar %APKTOOL%\baksmali.jar d -o %CLASSES%\framework Temp\framework\classes3.dex
java -jar %APKTOOL%\baksmali.jar d -o %CLASSES%\framework Temp\framework\classes4.dex
java -jar %APKTOOL%\baksmali.jar d -o %CLASSES%\gson Temp\gson\classes.dex

	:: Cleanup
rmdir /Q /S Temp

	:: Avoid closing of CMD to see potential issues
pause