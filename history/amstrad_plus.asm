	; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
	; - - - - - - - - - - - - - Amstrad plus Library - - - - - 
	; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
	
	; - - - - delock asic cpc plus - - - - - - - 
delock:
	di                           ; Interdit les Interruptions
	ld e, 17                     ; 17 octets à envoyer aux Crtc
	ld hl, asic                  ; Table des valeurs à envoyer
	ld bc, #bc00
	
delockloop:
	ld a, (hl)                   ; Met la valeur de la table dans le reg A
	out (c), a                   ; Envoie la valeur au Crtc
	inc hl                       ; HL=HL + 1
	dec e                        ; E=E - 1
	jr nz, delockloop            ; Tant que E n'est pas égal à 0, on continue...
	ei                           ; Rétablir les interruptions (merci Iron... même si ce n'était pas nécessaire !)
	ret
	
asic:
	DEFB 255, 0, 255, 119, 179
	DEFB 81, 168, 212, 98, 57, 156
	DEFB 70, 43, 21, 138, 205, 238
	; Voilà les 17 valeurs à envoyer au Crtc.
	; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
	
	; - - - - - asic on functions - - - - - - 
asicon:
	ld bc, #7fb8
	out (c), c
	ret
	; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
	
	; - - - - - asic off functions - - - - - 
asicoff:
	ld bc, #7fa0
	out (c), c
	ret
	; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
