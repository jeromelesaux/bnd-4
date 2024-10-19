
palette:
	martine -kit ./assets/VACHE.KIT -info

compile: 
	rasm main.asm -eo

debug: compile
	/Users/jls/Downloads/AceDL.app/Contents/MacOS/AceDL -crtc 3 -ram 320 -ffr  -autoRunFile 'disc.'  vache.dsk