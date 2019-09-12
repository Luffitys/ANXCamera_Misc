:: Changes directory to 7-Zip directory
C: & cd "C:\Program Files\7-Zip"

:: Extract ROM
7z x "D:\ANXCamera\ANXCamera_Misc\*.zip" -o"D:\ANXCamera\ANXCamera_Misc\Tools\temp\"
D: & cd "D:\ANXCamera\ANXCamera_Misc\Tools\temp"

:: Move files and cleanup
move system.new.dat.br "D:\ANXCamera\ANXCamera_Misc\Tools\brotli" & move system.transfer.list "D:\ANXCamera\ANXCamera_Misc\Tools\brotli"
move vendor.new.dat.br "D:\ANXCamera\ANXCamera_Misc\Tools\brotli" & move vendor.transfer.list "D:\ANXCamera\ANXCamera_Misc\Tools\brotli"
cd D:\ & rmdir /S /Q "D:\ANXCamera\ANXCamera_Misc\Tools\temp"

:: Convert files and cleanup
cd "D:\ANXCamera\ANXCamera_Misc\Tools\brotli"
brotli.exe --decompress --in system.new.dat.br --out system.new.dat
del system.new.dat.br
mkdir system
move system.new.dat system & move system.transfer.list system
ren vendor.new.dat.br system.new.dat.br & ren vendor.transfer.list system.transfer.list
brotli.exe --decompress --in system.new.dat.br --out system.new.dat
del system.new.dat.br
mkdir vendor
move system.new.dat vendor & move system.transfer.list vendor

:: Extract system files and cleanup
cd "D:\ANXCamera\ANXCamera_Misc\Tools\img extractor"
sdat2img "D:\ANXCamera\ANXCamera_Misc\Tools\brotli\system\system.transfer.list" "D:\ANXCamera\ANXCamera_Misc\Tools\brotli\system\system.new.dat" system.img
imgextractor system.img
del system.img system__statfile.txt
xcopy "D:\ANXCamera\ANXCamera_Misc\Tools\img extractor\system_\system" "D:\ANXCamera\ANXCamera_Misc\Rom_Files\ROM_System_Vendor\system" /O /X /E /H /K
rmdir /Q /S "D:\ANXCamera\ANXCamera_Misc\Tools\img extractor\system_"

:: Extract vendor files and cleanup
sdat2img "D:\ANXCamera\ANXCamera_Misc\Tools\brotli\vendor\system.transfer.list" "D:\ANXCamera\ANXCamera_Misc\Tools\brotli\vendor\system.new.dat" system.img
imgextractor system.img
del system.img system__statfile.txt
xcopy "D:\ANXCamera\ANXCamera_Misc\Tools\img extractor\system_" "D:\ANXCamera\ANXCamera_Misc\Rom_Files\ROM_System_Vendor\vendor" /O /X /E /H /K
rmdir /Q /S "D:\ANXCamera\ANXCamera_Misc\Tools\img extractor\system_"
rmdir /Q /S "D:\ANXCamera\ANXCamera_Misc\Tools\brotli\system"
rmdir /Q /S "D:\ANXCamera\ANXCamera_Misc\Tools\brotli\vendor"

:: Add frameworks
java -Xmx1024m -jar "D:\ANXCamera\ANXCamera_Misc\APKTool\Apktool\apktool_2.4.0.jar" if "D:\ANXCamera\ANXCamera_Misc\Rom_Files\ROM_System_Vendor\system\framework\framework-res.apk"  -p "D:\ANXCamera\ANXCamera_Misc\APKTool\Frameworks"
java -Xmx1024m -jar "D:\ANXCamera\ANXCamera_Misc\APKTool\Apktool\apktool_2.4.0.jar" if "D:\ANXCamera\ANXCamera_Misc\Rom_Files\ROM_System_Vendor\system\app\miui\miui.apk"  -p "D:\ANXCamera\ANXCamera_Misc\APKTool\Frameworks"

:: Decompile MiuiCamera, cleanup and move
java -Xmx1024m -jar "D:\ANXCamera\ANXCamera_Misc\APKTool\Apktool\apktool_2.4.0.jar" d -b -f -o "D:\ANXCamera\ANXCamera_Misc\APKTool\1-Decompiled APKs\ANXCamera" "D:\ANXCamera\ANXCamera_Misc\Rom_Files\ROM_System_Vendor\system\priv-app\MiuiCamera\MiuiCamera.apk" -p "D:\ANXCamera\ANXCamera_Misc\APKTool\Frameworks"
rmdir /Q /S "D:\ANXCamera\ANXCamera_Misc\APKTool\1-Decompiled APKs\ANXCamera\original"
xcopy "D:\ANXCamera\ANXCamera_Misc\APKTool\1-Decompiled APKs\ANXCamera" "D:\ANXCamera\ANXCamera_APK"  /O /X /E /H /K
rmdir /Q /S "D:\ANXCamera\ANXCamera_Misc\APKTool\1-Decompiled APKs\ANXCamera"

:: Extract Classes
:: Miui.apk
cd "C:\Program Files\7-Zip\"
7z x "D:\ANXCamera\ANXCamera_Misc\Rom_Files\ROM_System_Vendor\system\app\miui\miui.apk" -oD:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\temp\miui\
ren "D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\temp\miui\classes.dex" boot-miui_classes.dex
xcopy "D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\temp\miui\boot-miui_classes.dex" "D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed"

:: Miuisystem.apk
7z x "D:\ANXCamera\ANXCamera_Misc\Rom_Files\ROM_System_Vendor\system\app\miuisystem\miuisystem.apk" -oD:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\temp\miuisystem\
ren "D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\temp\miuisystem\classes.dex" boot-miuisystem_classes.dex
xcopy "D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\temp\miuisystem\boot-miuisystem_classes.dex" "D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed"

:: Framework.jar
7z x "D:\ANXCamera\ANXCamera_Misc\Rom_Files\ROM_System_Vendor\system\framework\framework.jar" -oD:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\temp\framework\
ren "D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\temp\framework\classes.dex" boot-framework_classes.dex
ren "D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\temp\framework\classes2.dex" boot-framework_classes2.dex
ren "D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\temp\framework\classes3.dex" boot-framework_classes3.dex
ren "D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\temp\framework\classes4.dex" boot-framework_classes4.dex
xcopy "D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\temp\framework\boot-framework_classes*.dex" "D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed"

:: Gson.jar and cleanup
7z x "D:\ANXCamera\ANXCamera_Misc\Rom_Files\ROM_System_Vendor\system\framework\gson.jar" -oD:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\temp\gson\
ren "D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\temp\gson\classes.dex" gson_classes.dex
xcopy "D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\temp\gson\gson_classes.dex" "D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed"
rmdir /S /Q D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\temp

:: Extract classes and cleanup
Java -jar "D:\ANXCamera\ANXCamera_Misc\APKTool\Resources\baksmali.jar" d -o D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\bootframework D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\boot-framework_classes.dex
Java -jar "D:\ANXCamera\ANXCamera_Misc\APKTool\Resources\baksmali.jar" d -o D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\bootframework2 D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\boot-framework_classes2.dex
Java -jar "D:\ANXCamera\ANXCamera_Misc\APKTool\Resources\baksmali.jar" d -o D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\bootframework3 D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\boot-framework_classes3.dex
Java -jar "D:\ANXCamera\ANXCamera_Misc\APKTool\Resources\baksmali.jar" d -o D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\bootframework4 D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\boot-framework_classes4.dex
Java -jar "D:\ANXCamera\ANXCamera_Misc\APKTool\Resources\baksmali.jar" d -o D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\gson D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\gson_classes.dex
Java -jar "D:\ANXCamera\ANXCamera_Misc\APKTool\Resources\baksmali.jar" d -o D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\boot-miui D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\boot-miui_classes.dex
Java -jar "D:\ANXCamera\ANXCamera_Misc\APKTool\Resources\baksmali.jar" d -o D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\boot-miuisystem D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\boot-miuisystem_classes.dex
del D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\boot*.dex D:\ANXCamera\ANXCamera_Misc\Rom_Files\Classes_Deodexed\gson*.dex

:: Avoid cmd closing
pause