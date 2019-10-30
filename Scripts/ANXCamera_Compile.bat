	:: Compile
cd ..
java -Xmx1024m -jar Tools\APKTool\apktool.jar b -o ..\ANXCamera_Magisk\system\priv-app\ANXCamera\ANXCamera.apk ..\ANXCamera_APK  -p Tools\APKTool\Frameworks

	:: Zipalign
Tools\APKTool\zipalign.exe -f 4 ..\ANXCamera_Magisk\system\priv-app\ANXCamera\ANXCamera.apk ..\ANXCamera_Magisk\system\priv-app\ANXCamera\ANXCamera_zipaligned.apk

	:: Cleanup
del ..\ANXCamera_Magisk\system\priv-app\ANXCamera\ANXCamera.*

	:: Sign
java -Xmx1024m -jar Tools\APKTool\ApkSigner.jar Tools\APKTool\Misc\PublicKey.pem Tools\APKTool\Misc\PrivateKey.pk8 ..\ANXCamera_Magisk\system\priv-app\ANXCamera\ANXCamera_zipaligned.apk ..\ANXCamera_Magisk\system\priv-app\ANXCamera\ANXCamera.apk

	:: Cleanup apk
del "..\ANXCamera_Magisk\system\priv-app\ANXCamera\ANXCamera_zipaligned.apk"

	:: Cleanup zip
del ..\ANXCamera_Magisk\*.zip

	:: Compress --> zip
7z a ..\ANXCamera_Magisk\ANXCamera_Unity_157.MinorChangesAreWelcome_sysover.zip -xr!.git* -xr!LICENSE -r ..\ANXCamera_Magisk\* -mx9

	:: Push zip to phone
adb push ..\ANXCamera_Magisk\ANXCamera_Unity_157.MinorChangesAreWelcome_sysover.zip /sdcard/

	:: Avoid cmd closing after finish to see eventual issues
pause