:: Changes directory to 7-Zip directory
C: & cd "C:\Program Files\7-Zip"

:: Extract ROM
7z x "D:\ANXCamera\ANXCamera_Misc\*.zip" -o"D:\ANXCamera\ANXCamera_Misc\Tools\temp\"
D: & cd "D:\ANXCamera\ANXCamera_Misc\Tools\temp"

:: Move files
move system.new.dat.br "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor" & move system.transfer.list "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor"
move vendor.new.dat.br "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor" & move vendor.transfer.list "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor"

:: Convert files and cleanup
cd "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor"
rmdir /S /Q "D:\ANXCamera\ANXCamera_Misc\Tools\temp"
brotli --decompress --in system.new.dat.br --out system.new.dat
del system.new.dat.br
mkdir temp & cd temp & mkdir system
move "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\system.new.dat" "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\temp\system"
move "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\system.transfer.list" "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\temp\system"
cd "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor"
ren vendor.new.dat.br system.new.dat.br & ren vendor.transfer.list system.transfer.list
cd "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor"
brotli --decompress --in system.new.dat.br --out system.new.dat
del system.new.dat.br
cd "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\temp" & mkdir vendor
move "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\system.new.dat" "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\temp\vendor"
move "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\system.transfer.list" "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\temp\vendor"

:: Extract system files and cleanup
cd "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor"
sdat2img "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\temp\system\system.transfer.list" "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\temp\system\system.new.dat" system.img
imgextractor system.img
del system.img system__statfile.txt
move "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\system_" "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor"
ren "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor\system_" system

:: Extract vendor files and cleanup
sdat2img "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\temp\vendor\system.transfer.list" "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\temp\vendor\system.new.dat" system.img
imgextractor system.img
del system.img system__statfile.txt
move "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\system_" "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor"
ren "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor\system_" vendor
rmdir /Q /S "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\temp"

:: Add frameworks
java -Xmx1024m -jar "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Apktool\apktool_2.4.0.jar" if "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor\system\framework\framework-res.apk"  -p "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Frameworks"
java -Xmx1024m -jar "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Apktool\apktool_2.4.0.jar" if "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor\system\system\framework\framework-res.apk"  -p "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Frameworks"
java -Xmx1024m -jar "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Apktool\apktool_2.4.0.jar" if "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor\system\app\miui\miui.apk"  -p "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Frameworks"
java -Xmx1024m -jar "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Apktool\apktool_2.4.0.jar" if "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor\system\system\app\miui\miui.apk"  -p "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Frameworks"

:: Decompile MiuiCamera, cleanup and move
java -Xmx1024m -jar "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Apktool\apktool_2.4.0.jar" d -b -f -o "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\1-Decompiled APKs\ANXCamera" "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor\system\priv-app\MiuiCamera\MiuiCamera.apk" -p "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Frameworks"
java -Xmx1024m -jar "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Apktool\apktool_2.4.0.jar" d -b -f -o "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\1-Decompiled APKs\ANXCamera" "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor\system\system\priv-app\MiuiCamera\MiuiCamera.apk" -p "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Frameworks"
rmdir /Q /S "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\1-Decompiled APKs\ANXCamera\original"
move "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\1-Decompiled APKs\ANXCamera" "D:\ANXCamera\ANXCamera_APK"

:: Extract Classes
:: Miui.apk
C: & cd "C:\Program Files\7-Zip\"
7z x "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor\system\app\miui\miui.apk" -oD:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\miui\
7z x "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor\system\system\app\miui\miui.apk" -oD:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\miui\
ren "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\miui\classes.dex" boot-miui_classes.dex
move "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\miui\boot-miui_classes.dex" "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed"

:: Miuisystem.apk
7z x "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor\system\app\miuisystem\miuisystem.apk" -oD:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\miuisystem\
7z x "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor\system\system\app\miuisystem\miuisystem.apk" -oD:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\miuisystem\
ren "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\miuisystem\classes.dex" boot-miuisystem_classes.dex
move "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\miuisystem\boot-miuisystem_classes.dex" "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed"

:: Framework.jar
7z x "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor\system\framework\framework.jar" -oD:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\framework\
7z x "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor\system\system\framework\framework.jar" -oD:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\framework\
ren "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\framework\classes.dex" boot-framework_classes.dex
ren "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\framework\classes2.dex" boot-framework_classes2.dex
ren "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\framework\classes3.dex" boot-framework_classes3.dex
ren "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\framework\classes4.dex" boot-framework_classes4.dex
move "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\framework\boot-framework_classes*.dex" "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed"

:: Gson.jar and cleanup
7z x "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor\system\framework\gson.jar" -oD:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\gson\
7z x "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\ROM_System_Vendor\system\system\framework\gson.jar" -oD:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\gson\
ren "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\gson\classes.dex" gson_classes.dex
move "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp\gson\gson_classes.dex" "D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed"
rmdir /S /Q D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\temp

:: Extract classes and cleanup
Java -jar "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Resources\baksmali.jar" d -o D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\bootframework D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\boot-framework_classes.dex
Java -jar "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Resources\baksmali.jar" d -o D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\bootframework2 D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\boot-framework_classes2.dex
Java -jar "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Resources\baksmali.jar" d -o D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\bootframework3 D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\boot-framework_classes3.dex
Java -jar "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Resources\baksmali.jar" d -o D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\bootframework4 D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\boot-framework_classes4.dex
Java -jar "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Resources\baksmali.jar" d -o D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\gson D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\gson_classes.dex
Java -jar "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Resources\baksmali.jar" d -o D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\boot-miui D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\boot-miui_classes.dex
Java -jar "D:\ANXCamera\ANXCamera_Misc\Tools\APKTool\Resources\baksmali.jar" d -o D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\boot-miuisystem D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\boot-miuisystem_classes.dex
del D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\boot*.dex D:\ANXCamera\ANXCamera_Misc\ROMS\REQUIRED_EXTRACTED_ROM\Classes_Deodexed\gson*.dex

:: Avoid cmd closing
pause