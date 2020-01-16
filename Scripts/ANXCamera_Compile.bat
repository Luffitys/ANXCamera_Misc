@ECHO OFF


set ZIP=ANXCamera_Unity_162.AtronomicalFailure
set APKTOOL=Tools\APKTool
set APK=..\ANXCamera_Magisk\system\priv-app\ANXCamera


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
del ..\ANXCamera_Magisk\*.zip

	:: Compress --> zip
7z a ..\ANXCamera_Magisk\%ZIP%.zip -xr!.git* -xr!LICENSE -r ..\ANXCamera_Magisk\* -mx9

	:: Push zip to phone
adb push ..\ANXCamera_Magisk\%ZIP%.zip /sdcard/

	:: Avoid cmd closing after finish to see eventual issues
pause