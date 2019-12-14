	:: Extract .zip
cd ..\..
7z x *.zip -oTemp\ system.new.dat.br system.transfer.list vendor.new.dat.br vendor.transfer.list

	:: Convert .dat.br -> .dat
Tools\Extractor\Brotli.exe --decompress --in Temp\system.new.dat.br --out Temp\system.new.dat
Tools\Extractor\Brotli.exe --decompress --in Temp\vendor.new.dat.br --out Temp\vendor.new.dat

	:: Convert .dat -> .img
Tools\Extractor\sdat2Img.exe Temp\system.transfer.list Temp\system.new.dat Temp\system.img
Tools\Extractor\sdat2Img.exe Temp\vendor.transfer.list Temp\vendor.new.dat Temp\vendor.img

	:: Extract .img
7z x Temp\system.img -oROMS\THIRD_ROM\system
7z x Temp\vendor.img -oROMS\THIRD_ROM\vendor

	:: Cleanup
rmdir /Q /S Temp

	:: Avoid closing of CMD to see potential issues
pause