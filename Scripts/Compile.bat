@echo off

set MAGISK_DIR=..\ANXCamera_Magisk
set APK_DIR=%MAGISK_DIR%\system\priv-app\ANXCamera
set APKTOOL_DIR=Tools\APKTool
set ZIPNAME=ANXCamera_Magisk_183.WhatHappenedHere
set ZIP=Tools\7z\7z.exe
set ADB=Tools\adb\adb.exe


	:: Compile
cd ..
java -jar %APKTOOL_DIR%\apktool.jar b --no-crunch --output %APK_DIR%\ANXCamera.apk ..\ANXCamera_APK  -p %APKTOOL_DIR%\Frameworks

	:: Zipalign
%APKTOOL_DIR%\zipalign.exe -f 4 %APK_DIR%\ANXCamera.apk %APK_DIR%\ANXCamera_zipaligned.apk

	:: Cleanup
del %APK_DIR%\ANXCamera.*

	:: Sign
java -jar %APKTOOL_DIR%\ApkSigner.jar %APKTOOL_DIR%\Misc\PublicKey.pem %APKTOOL_DIR%\Misc\PrivateKey.pk8 %APK_DIR%\ANXCamera_zipaligned.apk %APK_DIR%\ANXCamera.apk

	:: Cleanup apk
del %APK_DIR%\ANXCamera_zipaligned.apk

	:: Cleanup zip
del %MAGISK_DIR%\*.zip

	:: Compress --> zip
%ZIP% a %MAGISK_DIR%\%ZIPNAME%.zip -xr!.git* -xr!LICENSE -r %MAGISK_DIR%\* -mx9

	:: Push zip to phone
%ADB% push %MAGISK_DIR%\%ZIPNAME%.zip /sdcard/

	:: Avoid cmd closing after finish to see eventual issues
pause