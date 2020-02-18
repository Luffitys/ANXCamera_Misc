@echo off

set APK=..\ANXCamera_Magisk\system\priv-app\ANXCamera
set ZIP=ANXCamera_Unity_168.ShouldntHaveLeftMeYouSnake
set UNITY=..\ANXCamera_Magisk
set APKTOOL=Tools\APKTool


	:: Compile
cd ..
java -jar %APKTOOL%\apktool.jar b --no-crunch --output %APK%\ANXCamera.apk ..\ANXCamera_APK  -p %APKTOOL%\Frameworks

	:: Zipalign
%APKTOOL%\zipalign.exe -f 4 %APK%\ANXCamera.apk %APK%\ANXCamera_zipaligned.apk

	:: Cleanup
del %APK%\ANXCamera.*

	:: Sign
java -jar %APKTOOL%\ApkSigner.jar %APKTOOL%\Misc\PublicKey.pem %APKTOOL%\Misc\PrivateKey.pk8 %APK%\ANXCamera_zipaligned.apk %APK%\ANXCamera.apk

	:: Cleanup apk
del %APK%\ANXCamera_zipaligned.apk

	:: Cleanup zip
del %UNITY%\*.zip

	:: Compress --> zip
7z a %UNITY%\%ZIP%.zip -xr!.git* -xr!LICENSE -r %UNITY%\* -mx9

	:: Push zip to phone
adb push %UNITY%\%ZIP%.zip /sdcard/

	:: Avoid cmd closing after finish to see eventual issues
pause