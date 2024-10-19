	ORG #1000
	run $
	
	;
	; screen pour la bnd #4
	;
	; 18 / 10 / 2024 début affichage de l'écran depuis les fichiers go
	;
	start
	
	;
	; Initialisations
	;
	
	di                           ; On coupe les interruptions
	ld hl, (#38)                 ; On lit l'ancienne interruption
	ld (Inter + 1), hl           ; et on la sauve.
	ld hl, #C9FB                 ; On remplace tout ??a par
	ld (#38), hl                 ; du neuf (EI, RET)
	
	;
	; Mode 0 - > #8c
	; Mode 1 - > #8d
	; Mode 2 - > #8e
	;
	ld bc, #7F8C                 ; mode 0
	out (c), c
	;
	ei                           ; On remet les interruptions
	
	call delock                  ; delock de l'asic
	;
	; Efface zone utilisee pour le fullscreen
	;
	ld bc, #7FC0
	out (c), c
	ld hl, #4000
	ld de, #4001
	ld bc, #8000
	ld (hl), l
	ldir
	
	;
	; Reinit des registres crtc utilises
	;
	; formatage de l'écran
	;
	ld hl, #0130 ; r1=#30
	call crtc
	ld hl, #0232 ; r2=#32
	call crtc
	ld hl, #0308 ; r3=#08
	call crtc
    ld hl, #0626    ; r6=#22
    call crtc
    ld hl,#0723   ; r7=#23
    call crtc
	ld hl, #0C3C ; r12=#3C
	call crtc
	ld hl, #0D00 ; r13=#00
	call crtc
	
	call asicon
	ld hl, screen_palette
	ld de, #6400
	ld bc, #20
	ldir
	ld hl, #00
	ld (#6420), hl
	call asicoff
	
	; - - - - - - copie de screen sur l'ecran - - - - - - 
	; - - - - - - part 1 haut de l'écran - - - - - 
	ld de, #C020                 ; adresse de l'ecran
	ld hl, screen_part1          ; pointeur sur l'image en memoire
	ld bc, #4000 - 0x80
	ldir
	; - - - - - - part 2 bas de l'écran - - - - - 
	ld hl, screen_part2
	ld de, #4000
	ld bc, #4000 - 0x80
	ldir
	
	; - - - - - - met à jour les couleurs - - - - - 
	
	jr $
	
	
waitkey:
	call #BB06
	ret
	; - - - - compute next address line - - - - - 
bc26:
	ld a, h
	add 8
	ld h, a
	and #38
	ret nz
	ld a, h
	sub #40
	ld h, a
	ld a, l
	add #60                      ; 96 chars
	ld l, a
	ret nc
	inc h
	ld a, h
	and 7
	ret nz
	ld a, h
	sub 8
	ld h, a
	ret
	; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
	
	di                           ; On coupe tout !
Inter: ld hl, 0               ; On remet le vieux
	ld (#38), hl                 ; mod??le et on
	ei                           ; remet en marche !
	ret                          ; Heu...
	
	
	;
	; Mise en place de la palette
	;
put_palette: di
	ld bc, #7F00                 ; pen 0
	ld hl, screen_palette        ; table des couleurs
	ld e, 16                     ; nb de couleurs
loop_palette: ld a, (hl)
	out (c), c                   ; coul x
	out (c), a                   ; valeur ga de la couleur
	inc c                        ; prochaine couleur
	inc hl                       ; on avance dans la table des couleurs
	dec e                        ; 1 de moins a lire
	jr nz, loop_palette
	ei
	ret
	;
	; Palette utilisant les couleurs gate array
	;
screen_palette:
	db #FF, #0F, #FD, #0E, #FB, #0E, #EB, #0D, #FE, #0C, #EF, #00, #EF, #00, #EF, #00
	db #EF, #00, #BA, #0A, #B7, #0A, #B4, #06, #54, #04, #32, #02, #00, #00, #00, #00
	
    ; --------- include libs --------
	include 'amstrad_plus.asm'
	include 'crtc.asm'
	;
	;
	; include binary from file
	;
screen_part1:
	incbin 'assets/VACHE.GO1', #80, #4000 - 0x80
screen_part2:
	incbin 'assets/VACHE.GO2', #80, #4000 - 0x80
	
	
	
	end
	
	; export as dsk
	save'disc.', #1000, end - start, DSK, 'vache.dsk'
