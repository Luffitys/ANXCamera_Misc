:: Compile
java -Xmx1024m -jar "D:\ANXCamera\ANXCamera_Misc\APKTool\Apktool\apktool_2.4.0.jar" b -o "D:\ANXCamera\ANXCamera_Magisk\system\priv-app\ANXCamera\ANXCamera.apk" "D:\ANXCamera\ANXCamera_APK"  -p "D:\ANXCamera\ANXCamera_Misc\APKTool\Frameworks"

:: Zipalign
"D:\ANXCamera\ANXCamera_Misc\APKTool\Resources\zipalign.exe" -f 4 "D:\ANXCamera\ANXCamera_Magisk\system\priv-app\ANXCamera\ANXCamera.apk" "D:\ANXCamera\ANXCamera_Magisk\system\priv-app\ANXCamera\ANXCamera zipaligned.apk"

:: Cleanup
del "D:\ANXCamera\ANXCamera_Magisk\system\priv-app\ANXCamera\ANXCamera.apk"
del "D:\ANXCamera\ANXCamera_Magisk\system\priv-app\ANXCamera\ANXCamera.jobf

:: Sign
java -Xmx1024m -jar "D:\ANXCamera\ANXCamera_Misc\APKTool\Resources\ApkSigner.jar" sign  --key "D:\ANXCamera\ANXCamera_Misc\APKTool\Resources\apkeasytool.pk8" --cert "D:\ANXCamera\ANXCamera_Misc\APKTool\Resources\apkeasytool.pem" --out "D:\ANXCamera\ANXCamera_Magisk\system\priv-app\ANXCamera\ANXCamera.apk" "D:\ANXCamera\ANXCamera_Magisk\system\priv-app\ANXCamera\ANXCamera zipaligned.apk"

:: Cleanup apk
del "D:\ANXCamera\ANXCamera_Magisk\system\priv-app\ANXCamera\ANXCamera zipaligned.apk"

:: Cleanup zip
del "D:\ANXCamera\ANXCamera_Magisk\*.zip"

:: Compress --> zip
"C:\Program Files\7-Zip\7z.exe" a "D:\ANXCamera\ANXCamera_Magisk\ANXCamera_Unity_149.SortOfRemedy_sysover.zip" -xr!.git* -xr!LICENSE -r "D:\ANXCamera\ANXCamera_Magisk\*" -mx9

:: Push zip to phone
cd "D:\ANXCamera\ANXCamera_Misc\Tools\adb"
adb push "D:\ANXCamera\ANXCamera_Magisk\ANXCamera_Unity_149.SortOfRemedy_sysover.zip" /sdcard/

:: Avoid cmd closing after finish to see eventual issues
pause