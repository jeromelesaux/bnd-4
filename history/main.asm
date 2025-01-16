	ORG #1000
	run $
	
	;
	; screen pour la bnd #4
	;
	; 18 / 10 / 2024 début affichage de l'écran depuis les fichiers go
	; 20 / 10 / 2024 change de stratégie pour charger les fichiers images go (chargement et mise en mémoire depuis le code)
	;
	start
	
; 	; ld bc, #7FC0 ; set la configuration mémoire c0 
; 	; out (c), c
; 	call #bc65 ; initialise le disc
; 	ld hl, image1
; 	ld b,9
; 	call #bc77 ; ouvre le fichier 
; 	ld hl, #4000 ; destination en mémoire du contenu du fichier
; 	call #bc83 ; chargement du fichier en #4000
; 	call #bc7a ; fermeture du fichier
; 	ld bc, #7FC4
;  	out (c), c  ; set la configuration mémoire c4,  bank 4 en #4000
; 	ld hl, image2
; 	ld b,9
; 	call #bc77 ; ouvre le fichier 
; 	ld hl, #4000 ; destination en mémoire du contenu du fichier
; 	call #bc83 ; chargement du fichier en #4000
; 	call #bc7a ; fermeture du fichier
; 	ld bc, #7FC0 ; on revient en configuration mémoire normale 
;    out (c),c

	di
	ld hl, #C9FB
	ld (#38), hl
	
	ld bc, #7FC4
	out (c), c
	ld hl, #4000
	ld de, #C000
	ld bc, #3FFF
	ldir
	ld bc, #7FC0
	out (c), c
	;
	ld bc, #BC01                 ; Affiche du Border
	out (c), c                   ;
	ld bc, #BD00                 ;
	out (c), c
	ld bc, #BC02
	out (c), c
	ld bc, #BD31
	out (c), c
	ld bc, #BC06
	out (c), c
	ld bc, #BD21
	out (c), c
	ld bc, #BC07
	out (c), c
	ld bc, #BD22
	out (c), c
	
	call delock
	;
	; La boucle Principale commence ici
	;
	boucle
	;
	di
	call asicon
    ld c,#8C      ; mode 0
    out (c),c
	;
	; On defini la rupture du haut en utilisant r12 et r13
	; C'EST OBLIGATOIRE pour le 1er ECRAN !!!!
	;
	ld hl, #1000                 ; ecran .go1 en #4000
	ld bc, #BC0C
	out (c), c
	inc b
	out (c), h
	dec b
	inc c
	out (c), c
	inc b
	out (c), l
	;
	;
	; Copie de la palette (.kit)
	;
	ld hl, screen_palette
	ld de, #6400
	ld bc, #20
	ldir
	
	
	
	ld a, 166
	ld (#6800), a                ; PRI
	ei
	halt
	di
	inc a
	ld (#6801), a                ; SPLIT
	ld hl, #30                   ; ecran .go2 en #c000
	ld (#6802), hl               ; SSA
	xor a
	ld (#6804), a                ; SSCR
	;
	ld bc, #BC01
	out (c), c
	ld bc, #BD30
	out (c), c
	;
	jp boucle
	;
	
	
	
	
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
	; Palette utilisant les couleurs gate array
	;
screen_palette:
	db #FF, #0F, #FD, #0E, #FB, #0E, #EB, #0D, #FE, #0C, #EF, #00, #EF, #00, #EF, #00
	db #EF, #00, #BA, #0A, #B7, #0A, #B4, #06, #54, #04, #32, #02, #00, #00, #00, #00
	
	; - - - - - - - - - include libs - - - - - - - - 
	include 'amstrad_plus.asm'
	include 'crtc.asm'

image1: db 'VACHE.GO1'
image2: db 'VACHE.GO2'
	
	end
	
	; export as dsk
	save'disc.', #1000, end - start, DSK, 'vache.dsk'
