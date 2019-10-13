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
move "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\system_" "D:\ANXCamera\ANXCamera_Misc\ROMS\ANOTHER_EXTRACTED_ROM"
ren "D:\ANXCamera\ANXCamera_Misc\ROMS\ANOTHER_EXTRACTED_ROM\system_" system

:: Extract vendor files and cleanup
sdat2img "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\temp\vendor\system.transfer.list" "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\temp\vendor\system.new.dat" system.img
imgextractor system.img
del system.img system__statfile.txt
move "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\system_" "D:\ANXCamera\ANXCamera_Misc\ROMS\ANOTHER_EXTRACTED_ROM"
ren "D:\ANXCamera\ANXCamera_Misc\ROMS\ANOTHER_EXTRACTED_ROM\system_" vendor
rmdir /Q /S "D:\ANXCamera\ANXCamera_Misc\Tools\brotli_img_extractor\temp"

:: Avoid cmd closing
pause