
palette:
	martine -kit ./assets/VACHE.KIT -info

disk:
	dsk -dsk vache.dsk -format

include_files: disk
	dsk -dsk vache.dsk -put -amsdosfile ./assets/VACHE.GO1 -type binary
	dsk -dsk vache.dsk -put -amsdosfile ./assets/VACHE.GO2 -type binary

compile: 
	rasm main.asm -eo

debug: compile
	/Users/jls/Downloads/AceDL.app/Contents/MacOS/AceDL -crtc 3 -ram 320 -ffr  -autoRunFile 'disc.'  vache.dsk