	; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
	; - - - - - - crtc registers routine - - - - - - - - - - - - 
	; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
	
	; - - - - - call crtc; set crtc register - - - - ; 
	; HL #0308 ; va selectionner le registre 3 pour y mettre la valeur 8
	; h contient la valeur à mettre en #BC00; 
	; h contient le registre à mettre à jour 
	; l contient la valeur à mettre en #BD00
	; l contient la valeur à mettre dans le register séléctionné
crtc:
	 ld b, #BC
	 ld a, h
	out (c), h
	inc b
	ld a, l
	out (c), l
	ret
