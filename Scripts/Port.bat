	:: Extract .zip
cd ..
7z x *.zip -oTemp\ system.new.dat.br system.transfer.list vendor.new.dat.br vendor.transfer.list

	:: Convert .dat.br -> .dat
Tools\Extractor\Brotli.exe --decompress --in Temp\system.new.dat.br --out Temp\system.new.dat
Tools\Extractor\Brotli.exe --decompress --in Temp\vendor.new.dat.br --out Temp\vendor.new.dat

	:: Convert .dat -> .img
Tools\Extractor\sdat2Img.exe Temp\system.transfer.list Temp\system.new.dat Temp\system.img
Tools\Extractor\sdat2Img.exe Temp\vendor.transfer.list Temp\vendor.new.dat Temp\vendor.img

	:: Extract .img
7z x -aos Temp\system.img -oROMS\REQUIRED_ROM\ROM\system
7z x -aos Temp\vendor.img -oROMS\REQUIRED_ROM\ROM\vendor

	:: Add Frameworks [Trial and Error]
java -jar Tools\APKTool\apktool.jar if ROMS\REQUIRED_ROM\ROM\system\framework\framework-res.apk -p Tools\APKTool\Frameworks
java -jar Tools\APKTool\apktool.jar if ROMS\REQUIRED_ROM\ROM\system\system\framework\framework-res.apk -p Tools\APKTool\Frameworks

java -jar Tools\APKTool\apktool.jar if ROMS\REQUIRED_ROM\ROM\system\app\miui\miui.apk -p Tools\APKTool\Frameworks
java -jar Tools\APKTool\apktool.jar if ROMS\REQUIRED_ROM\ROM\system\system\app\miui\miui.apk -p Tools\APKTool\Frameworks

	:: Decompile MiuiCamera
java -jar Tools\APKTool\apktool.jar d --no-debug-info --output ..\ANXCamera_APK ROMS\REQUIRED_ROM\ROM\system\priv-app\MiuiCamera\MiuiCamera.apk -p Tools\APKTool\Frameworks
java -jar Tools\APKTool\apktool.jar d --no-debug-info --output ..\ANXCamera_APK ROMS\REQUIRED_ROM\ROM\system\system\priv-app\MiuiCamera\MiuiCamera.apk -p Tools\APKTool\Frameworks

	:: Extract Classes [Trial and Error]
	
	:: miui.apk
7z x ROMS\REQUIRED_ROM\ROM\system\system\app\miui\miui.apk -oTemp\miui *.dex
7z x ROMS\REQUIRED_ROM\ROM\system\app\miui\miui.apk -oTemp\miui *.dex

	:: miuisystem.apk
7z x ROMS\REQUIRED_ROM\ROM\system\system\app\miuisystem\miuisystem.apk -oTemp\miuisystem *.dex
7z x ROMS\REQUIRED_ROM\ROM\system\app\miuisystem\miuisystem.apk -oTemp\miuisystem *.dex

	:: framework.jar
7z x ROMS\REQUIRED_ROM\ROM\system\system\framework\framework.jar -oTemp\framework *.dex
7z x ROMS\REQUIRED_ROM\ROM\system\framework\framework.jar -oTemp\framework *.dex

	:: gson.jar
7z x ROMS\REQUIRED_ROM\ROM\system\system\framework\gson.jar -oTemp\gson *.dex
7z x ROMS\REQUIRED_ROM\ROM\system\framework\gson.jar -oTemp\gson *.dex

	:: Decompile Classes
java -jar Tools\APKTool\baksmali.jar d -o ROMS\REQUIRED_ROM\Required_Classes\miui Temp\miui\classes.dex
java -jar Tools\APKTool\baksmali.jar d -o ROMS\REQUIRED_ROM\Required_Classes\miuisystem Temp\miuisystem\classes.dex
java -jar Tools\APKTool\baksmali.jar d -o ROMS\REQUIRED_ROM\Required_Classes\framework Temp\framework\classes.dex
java -jar Tools\APKTool\baksmali.jar d -o ROMS\REQUIRED_ROM\Required_Classes\framework Temp\framework\classes2.dex
java -jar Tools\APKTool\baksmali.jar d -o ROMS\REQUIRED_ROM\Required_Classes\framework Temp\framework\classes3.dex
java -jar Tools\APKTool\baksmali.jar d -o ROMS\REQUIRED_ROM\Required_Classes\framework Temp\framework\classes4.dex
java -jar Tools\APKTool\baksmali.jar d -o ROMS\REQUIRED_ROM\Required_Classes\gson Temp\gson\classes.dex

	:: Cleanup
rmdir /Q /S Temp

	:: Avoid closing of CMD to see potential issues
pause