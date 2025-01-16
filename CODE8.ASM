;
; load fichier scr 
      ORG &0170
      ENT debut_code
      LOAD "cow3.scr"
;      ORG &8000,&0100   ; assemble en #100 mais loade en #8000


debut_code
          xor a
          call &BC0E    ; mode 0 
          ld a,&C9
          ld (&01FC),a  ; poke ret a la place du jp
          call &01AD    ; affichage de l'image et delock asic couleur
          jp debut
;

;                 
;
;
debut
;
; 

          di
        ;  ld sp,&0100

          ld hl,&C9FB
          ld (&38),hl
;
          call init
;
          ld bc,&7FB8
          ld a,&C0
          out (c),a
          out (c),c
;                   
          ld hl,sprh
          ld de,&4000
          ld bc,256
          ldir
          ld hl,&4000
          ld de,&4100
          ld bc,256*7   ; copie des 7 sprites depuis le premier en #4000
          ldir

; chargement de la palette du sprite
          ld hl,sprh_palette
          ld de,&6422
          ld bc,30
          ldir
; setup des magnifies
          ld a,%00001001
          ld (&6004),a
          ld (&600C),a
          ld (&6014),a
          ld (&601C),a
          ld (&6024),a
          ld (&602C),a
          ld (&6034),a
          ld (&603C),a
;          or a

          call init_spr
; setup des coordonnees

          ld hl,-64     ; x
          ld (&6000),hl
          ld hl,100     ; y
          ld (&6002),hl
;
          ld hl,-64     ; x
          ld (&6008),hl
          ld hl,100     ; y
          ld (&600A),hl
;
          ld hl,-64     ; x
          ld (&6010),hl
          ld hl,100     ; y
          ld (&6012),hl
;
          ld hl,-64     ; x
          ld (&6018),hl
          ld hl,100     ; y
          ld (&601A),hl
;
          ld hl,-64     ; x
          ld (&6020),hl
          ld hl,100     ; y
          ld (&6022),hl
;
          ld hl,-64     ; x
          ld (&6028),hl
          ld hl,100     ; y
          ld (&602A),hl
;
          ld hl,-64     ; x
          ld (&6030),hl
          ld hl,100     ; y
          ld (&6032),hl
;
          ld hl,-64
          ld (&6040),hl
          ld (&6042),hl

;
          ei
;     
; La boucle Principale commence ici
;
boucle
;         
          di
;
          ld bc,&7FC0   ; #C0 puis #B8 pour eviter le
          out (c),c     ; bug des xMEM
          ld a,&B8      ; (A chaque fois qu'on utilise l'asic)
          out (c),a

          ld a,20       ; calage des rasters
          ld (&6800),a
          ei
          halt
          ld b,7
          djnz $

;
          call raster
;
          call display_pumpkin
;
          ld bc,&7FA0   ; asic off
          out (c),c

;                  
; Display Rasters
;
          call plot_raster
;
; Display SprH text
;
          call disp_txt
;         
; Play Music
;
          call play
;
          jp boucle     ; loop principale
;
; Display PumpKin
;                   
display_pumpkin
x1        ld hl,sprh_coord
          ld a,(hl)
          inc l
          ld (x1+1),hl
          ld l,a
          ld h,0
          ld d,h
          ld e,l
          add hl,hl     ; x2 pour les coordonnees x 
          add hl,de
          ld (&6000),hl
y1        ld hl,sprh_coord
          ld a,(hl)
          4 ** inc l
          ld (y1+1),hl
          ld (&6002),a
;
x2        ld hl,sprh_coord+8
          ld a,(hl)
          inc l
          ld (x2+1),hl
          ld l,a
          ld h,0
          ld d,h
          ld e,l
          add hl,hl     ; x2 pour les coordonnees x 
          add hl,de
          ld (&6008),hl
y2        ld hl,sprh_coord+8
          ld a,(hl)
          4 ** inc l
          ld (y2+1),hl
          ld (&600A),a

;
x3        ld hl,sprh_coord+16
          ld a,(hl)
          inc l
          ld (x3+1),hl
          ld l,a
          ld h,0
          ld d,h
          ld e,l
          add hl,hl     ; x2 pour les coordonnees x 
          add hl,de
          ld (&6010),hl
y3        ld hl,sprh_coord+16
          ld a,(hl)
          4 ** inc l
          ld (y3+1),hl
          ld (&6012),a

;
x4        ld hl,sprh_coord+24
          ld a,(hl)
          inc l
          ld (x4+1),hl
          ld l,a
          ld h,0
          ld d,h
          ld e,l
          add hl,hl     ; x2 pour les coordonnees x 
          add hl,de
          ld (&6018),hl
y4        ld hl,sprh_coord+24
          ld a,(hl)
          4 ** inc l
          ld (y4+1),hl
          ld (&601A),a

;
x5        ld hl,sprh_coord+32
          ld a,(hl)
          inc l
          ld (x5+1),hl
          ld l,a
          ld h,0
          ld d,h
          ld e,l
          add hl,hl     ; x2 pour les coordonnees x 
          add hl,de
          ld (&6020),hl
y5        ld hl,sprh_coord+32
          ld a,(hl)
          4 ** inc l
          ld (y5+1),hl
          ld (&6022),a

;
x6        ld hl,sprh_coord+40
          ld a,(hl)
          inc l
          ld (x6+1),hl
          ld l,a
          ld h,0
          ld d,h
          ld e,l
          add hl,hl     ; x2 pour les coordonnees x 
          add hl,de
          ld (&6028),hl
y6        ld hl,sprh_coord+40
          ld a,(hl)
          4 ** inc l
          ld (y6+1),hl
          ld (&602A),a

;
x7        ld hl,sprh_coord+48
          ld a,(hl)
          inc l
          ld (x7+1),hl
          ld l,a
          ld h,0
          ld d,h
          ld e,l
          add hl,hl     ; x2 pour les coordonnees x 
          add hl,de
          ld (&6030),hl
y7        ld hl,sprh_coord+48
          ld a,(hl)
          4 ** inc l
          ld (y7+1),hl
          ld (&6032),a

;
x8        ld hl,sprh_coord+56
          ld a,(hl)
          inc l
          ld (x8+1),hl
          ld l,a
          ld h,0
          ld d,h
          ld e,l
          add hl,hl     ; x2 pour les coordonnees x 
          add hl,de     ; x3 

          ld (&6038),hl
y8        ld hl,sprh_coord+56
          ld a,(hl)
          4 ** inc l
          ld (y8+1),hl
          ld (&603A),a
          ret
;
; Plot Rasters in Tab
;
plot_raster

          call clear_raster
;
; Copie du raster dans le tableau
;                   

          ld hl,raster_tab
tb1       ld de,tableau
          ld bc,8*4
          ldir
          ld hl,raster_tab
tb2       ld de,tableau
          ld bc,8*4
          ldir
          ld hl,raster_tab
tb3       ld de,tableau
          ld bc,8*4
          ldir
          ld hl,raster_tab
tb4       ld de,tableau
          ld bc,8*4
          ldir
          ld hl,raster_tab
tb5       ld de,tableau
          ld bc,8*4
          ldir
          ld hl,raster_tab
tb6       ld de,tableau
          ld bc,8*4
          ldir
;
; Rasters Animation (Y curves)
;
courbe_r  ld hl,raster_courbe
          ld a,(hl)
          inc l
          ld (courbe_r+1),hl
         ; add a          ; couleur en 16 bits 
         ; ld (tb1+1),a
;      
          ld l,a
          ld h,0
          add hl,hl
          ld de,tableau
          add hl,de
          ld (tb1+1),hl
;
courbe_r2 ld hl,raster_courbe+8
          ld a,(hl)
          inc l
          ld (courbe_r2+1),hl
         ; add a          ; couleur en 16 bits 
         ; ld (tb1+1),a
;      
          ld l,a
          ld h,0
          add hl,hl
          ld de,tableau
          add hl,de
          ld (tb2+1),hl
;
courbe_r3 ld hl,raster_courbe+16
          ld a,(hl)
          inc l
          ld (courbe_r3+1),hl
         ; add a          ; couleur en 16 bits 
         ; ld (tb1+1),a
;      
          ld l,a
          ld h,0
          add hl,hl
          ld de,tableau
          add hl,de
          ld (tb3+1),hl
;
courbe_r4 ld hl,raster_courbe+24
          ld a,(hl)
          inc l
          ld (courbe_r4+1),hl
         ; add a          ; couleur en 16 bits 
         ; ld (tb1+1),a
;      
          ld l,a
          ld h,0
          add hl,hl
          ld de,tableau
          add hl,de
          ld (tb4+1),hl
;
courbe_r5 ld hl,raster_courbe+32
          ld a,(hl)
          inc l
          ld (courbe_r5+1),hl
         ; add a          ; couleur en 16 bits 
         ; ld (tb1+1),a
;      
          ld l,a
          ld h,0
          add hl,hl
          ld de,tableau
          add hl,de
          ld (tb5+1),hl
;
courbe_r6 ld hl,raster_courbe+40
          ld a,(hl)
          inc l
          ld (courbe_r6+1),hl
         ; add a          ; couleur en 16 bits 
         ; ld (tb1+1),a
;      
          ld l,a
          ld h,0
          add hl,hl
          ld de,tableau
          add hl,de
          ld (tb6+1),hl
          ret
;
; Clear Raster Tab with Black (ink #000)  
;
clear_raster
          di
          ld (pile+1),sp
;
          ld hl,0
          ld sp,tableau+512
          256 ** push hl
;
pile      ld sp,0
          ei
          ret
;
;
; raster routine
raster
          di
          ld hl,tableau ;  raster_tab
          ld de,&641E   ; encre 7
          ld b,200      ; nombre de lignes
loop_raster
          ld a,(hl)     ; on recupere Red/Blue
          ld (de),a     ; on poke RB dans ink 
          inc hl
          inc e         ; &640d ink 7 couleur Green
          ld (de),a     ; on poke Green dans ink
          inc hl
          dec e         ; &6400
      FILL 64-17,0      ; on synchonise sur 64 nops (1 rasterline)
          dec a
          djnz loop_raster
          ld hl,0
          ld (&640C),hl
          ei
          ret






; 
; definition de la table des rasters
; 
raster_tab
      WORD &F1,&F2,&F3,&F4
      WORD &F5,&F6,&F7,&F8
      WORD &F8,&F7,&F6,&F5
      WORD &F4,&F3,&F2,&F1


;
sprh
      BYTE &00,&00,&00,&00,&00,&00,&00,&0D
      BYTE &0D,&0D,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&0D
      BYTE &0D,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&0C,&0C,&0C,&09
      BYTE &09,&0C,&0C,&0E,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&0F,&0F,&0F,&09
      BYTE &09,&0F,&0F,&0F,&00,&00,&00,&00
      BYTE &00,&00,&0F,&0F,&03,&07,&04,&05
      BYTE &08,&04,&04,&04,&0F,&0F,&00,&00
      BYTE &00,&0F,&01,&04,&04,&04,&04,&07
      BYTE &07,&04,&04,&04,&04,&01,&0F,&00
      BYTE &00,&0F,&04,&04,&04,&04,&04,&07
      BYTE &07,&03,&04,&03,&04,&04,&0F,&00
      BYTE &0F,&01,&04,&03,&0E,&0E,&02,&07
      BYTE &07,&02,&0E,&0E,&04,&04,&01,&0F
      BYTE &0F,&04,&05,&0E,&0E,&0E,&02,&07
      BYTE &07,&02,&0E,&0E,&0F,&05,&04,&0F
      BYTE &0F,&07,&05,&0F,&0F,&0F,&02,&07
      BYTE &07,&03,&0F,&0F,&0F,&05,&07,&0F
      BYTE &0F,&07,&0F,&07,&04,&04,&04,&05
      BYTE &05,&04,&04,&04,&07,&0F,&07,&0F
      BYTE &0F,&07,&06,&09,&09,&07,&09,&06
      BYTE &06,&09,&04,&09,&09,&06,&07,&0F
      BYTE &0C,&05,&09,&0F,&0F,&04,&0F,&0F
      BYTE &0F,&0B,&04,&0F,&0F,&09,&05,&0C
      BYTE &00,&0F,&08,&09,&07,&0F,&03,&05
      BYTE &08,&03,&0F,&07,&09,&08,&0F,&00
      BYTE &00,&00,&0F,&08,&09,&08,&08,&09
      BYTE &09,&08,&08,&09,&08,&0F,&00,&00
      BYTE &00,&00,&00,&0F,&0F,&0F,&0F,&0F
      BYTE &0F,&0F,&0F,&0F,&0F,&00,&00,&00

sprh_palette
      BYTE &FF,&0F,&ED,&0D,&F5,&0B,&F3,&09
      BYTE &F2,&09,&D1,&08,&43,&03,&F0,&08
      BYTE &E0,&07,&C1,&06,&40,&01,&40,&00
      BYTE &10,&00,&01,&06,&30,&01


      ORG $+&FF AND &FF00 ; multiple de 256 pour sprite coord


sprh_coord
      BYTE &FF,&FE,&FE,&FE,&FE,&FE,&FD,&FD
      BYTE &FC,&FB,&FB,&FA,&F9,&F8,&F7,&F6
      BYTE &F5,&F4,&F2,&F1,&EF,&EE,&EC,&EB
      BYTE &E9,&E7,&E5,&E4,&E2,&E0,&DD,&DB
      BYTE &D9,&D7,&D5,&D2,&D0,&CD,&CB,&C8
      BYTE &C6,&C3,&C1,&BE,&BB,&B8,&B6,&B3
      BYTE &B0,&AD,&AA,&A7,&A4,&A1,&9E,&9B
      BYTE &98,&95,&92,&8F,&8B,&88,&85,&82
      BYTE &7F,&7C,&79,&76,&73,&6F,&6C,&69
      BYTE &66,&63,&60,&5D,&5A,&57,&54,&51
      BYTE &4E,&4B,&48,&46,&43,&40,&3D,&3B
      BYTE &38,&36,&33,&31,&2E,&2C,&29,&27
      BYTE &25,&23,&21,&1E,&1C,&1A,&19,&17
      BYTE &15,&13,&12,&10,&0F,&0D,&0C,&0A
      BYTE &09,&08,&07,&06,&05,&04,&03,&03
      BYTE &02,&01,&01,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&01,&01
      BYTE &02,&03,&03,&04,&05,&06,&07,&08
      BYTE &09,&0A,&0C,&0D,&0F,&10,&12,&13
      BYTE &15,&17,&19,&1A,&1C,&1E,&21,&23
      BYTE &25,&27,&29,&2C,&2E,&31,&33,&36
      BYTE &38,&3B,&3D,&40,&43,&46,&48,&4B
      BYTE &4E,&51,&54,&57,&5A,&5D,&60,&63
      BYTE &66,&69,&6C,&6F,&73,&76,&79,&7C
      BYTE &7F,&82,&85,&88,&8B,&8F,&92,&95
      BYTE &98,&9B,&9E,&A1,&A4,&A7,&AA,&AD
      BYTE &B0,&B3,&B6,&B8,&BB,&BE,&C1,&C3
      BYTE &C6,&C8,&CB,&CD,&D0,&D2,&D5,&D7
      BYTE &D9,&DB,&DD,&E0,&E2,&E4,&E5,&E7
      BYTE &E9,&EB,&EC,&EE,&EF,&F1,&F2,&F4
      BYTE &F5,&F6,&F7,&F8,&F9,&FA,&FB,&FB
      BYTE &FC,&FD,&FD,&FE,&FE,&FE,&FE,&FE
;
tableau
          256 ** WORD 0

raster_courbe
      BYTE &B7,&B6,&B6,&B6,&B6,&B6,&B6,&B5
      BYTE &B5,&B4,&B4,&B3,&B3,&B2,&B1,&B0
      BYTE &B0,&AF,&AE,&AD,&AC,&AB,&A9,&A8
      BYTE &A7,&A6,&A4,&A3,&A2,&A0,&9F,&9D
      BYTE &9C,&9A,&98,&97,&95,&93,&92,&90
      BYTE &8E,&8C,&8A,&88,&86,&84,&82,&80
      BYTE &7E,&7C,&7A,&78,&76,&73,&71,&6F
      BYTE &6D,&6B,&68,&66,&64,&62,&5F,&5D
      BYTE &5B,&59,&57,&54,&52,&50,&4E,&4B
      BYTE &49,&47,&45,&43,&40,&3E,&3C,&3A
      BYTE &38,&36,&34,&32,&30,&2E,&2C,&2A
      BYTE &28,&26,&24,&23,&21,&1F,&1E,&1C
      BYTE &1A,&19,&17,&16,&14,&13,&12,&10
      BYTE &0F,&0E,&0D,&0B,&0A,&09,&08,&07
      BYTE &06,&06,&05,&04,&03,&03,&02,&02
      BYTE &01,&01,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&01
      BYTE &01,&02,&02,&03,&03,&04,&05,&06
      BYTE &06,&07,&08,&09,&0A,&0B,&0D,&0E
      BYTE &0F,&10,&12,&13,&14,&16,&17,&19
      BYTE &1A,&1C,&1E,&1F,&21,&23,&24,&26
      BYTE &28,&2A,&2C,&2E,&30,&32,&34,&36
      BYTE &38,&3A,&3C,&3E,&40,&43,&45,&47
      BYTE &49,&4B,&4E,&50,&52,&54,&57,&59
      BYTE &5B,&5D,&5F,&62,&64,&66,&68,&6B
      BYTE &6D,&6F,&71,&73,&76,&78,&7A,&7C
      BYTE &7E,&80,&82,&84,&86,&88,&8A,&8C
      BYTE &8E,&90,&92,&93,&95,&97,&98,&9A
      BYTE &9C,&9D,&9F,&A0,&A2,&A3,&A4,&A6
      BYTE &A7,&A8,&A9,&AB,&AC,&AD,&AE,&AF
      BYTE &B0,&B0,&B1,&B2,&B3,&B3,&B4,&B4
      BYTE &B5,&B5,&B6,&B6,&B6,&B6,&B6,&B6
space
      FILL 32,0


sprh_9 = &4900
;
; Initialisation des SprH
;
init_spr
          ld bc,&7FB8
          out (c),c
;
; Init Palette SprH
;                  
          ld hl,sprh_palette
          ld de,&6422
          ld bc,30
          ldir
;
; Clear Sprh #4900 - #4fff
;                         
          ld hl,&4700
          ld bc,&0700
          ld (hl),l
          ld d,h
          ld e,1
          ldir
;
; Define Sprh Size
;
          ld a,%00001110
          ld (&604C),a  ; spr9
          ld (&6054),a  ; spr10
          ld (&605C),a  ; spr11
          ld (&6064),a  ; spr12
          ld (&606C),a  ; spr13
          ld (&6074),a  ; spr14
          ld (&607C),a  ; spr15
;      
; SprH - Y
; Tous les SprH sont a la meme hauteur
;
          ld hl,-64     ; planque sous le border    
          ld (pos_y+1),hl
;
; On factorise la routine des sprh Y pour pouvoir la reutiliser
;
          call sprites_y
;           
; Les SprH - X
; Tous les SprH sont decales de 64 pixels
;
          ld de,64      ;  decalage
;
; HL = position X du texte affiche en SprH
;
          ld hl,80+100
          ld (&6048),hl ; spr9 X
          add hl,de
          ld (&6050),hl ; spr10 X
          add hl,de
          ld (&6058),hl ; spr11 X
          add hl,de
          ld (&6060),hl ; spr12 X
          add hl,de
          ld (&6068),hl ; spr13 X
          add hl,de
          ld (&6070),hl ; spr14 X
          add hl,de
          ld (&6078),hl ; spr15 X

;          ld bc,&7FA0  ; pas besoin de desactiver car
;         out (c),c    ; l'asic doit rester active pour la suite
;
; Reinit Message Texte
;                     
          ld hl,txt
          ld (display+1),hl

          ld hl,sprh_9
          ld (vram+1),hl
          ret
;
sprites_y
          ld (&604A),hl ; spr9  Y
          ld (&6052),hl ; spr10 Y
          ld (&605A),hl ; spr11 Y
          ld (&6062),hl ; spr12 Y
          ld (&606A),hl ; spr13 Y
          ld (&6072),hl ; spr14 Y
          ld (&607A),hl ; spr15 Y 
          ret
;
disp_txt  ld bc,&7FC0
          ld a,&B8
          out (c),c
          out (c),a
;
pos_y     ld hl,-64
          call sprites_y
;
          call display  ; display texte
;
          ld bc,&7FA0
          out (c),c
;
          ret
;
; Reset l'adresse du txt
;
reset
          ld hl,txt
          ld (display+1),hl
;
display   ld hl,txt
          ld a,(hl)
          or a
          jr z,reset
          cp 1
          jp z,display_message
          inc hl
          ld (display+1),hl
;
          sub 64
          ld l,a
          ld h,0
;
; La fonte fait 4 pixels x 8 lignes -> 32 octets / char
;       
          add hl,hl     ; hl * 2
          ld bc,sidfnt
          add hl,bc
          ld a,(hl)
          inc hl
          ld h,(hl)
          ld l,a
vram      ld de,sprh_9
;
          ld a,8        ; hauteur de la fonte
;
loop_fnt  push de
          push hl
          4 ** ldi
          pop de        ; pop hl
          pop hl        ; pop de
          ld bc,16
          add hl,bc
          ex de,hl
          add hl,bc
;
; On n'a plus besoin du second ex de,hl car on a inverse
; les pop
;
        ;  ex de,hl   
          dec a
          jr nz,loop_fnt
;
; Gestion de l'affichage dans la vRAM
;                                    
inc_char
;  
          ld hl,(vram+1)
          ld de,4
          add hl,de
;
          ld a,l
          cp 16
          jr z,next_sprh
          cp &80+16
          jr z,next_sprh_bas

poke_vram ld (vram+1),hl
          ret
;
; On veut ecrire sur le sprH #4f10 ou #4f90  
; 2 cas se presentent :
; 1ere lignes (8 premieres lignes du haut) 
; 2nd lignes  (8 lignes du bas)
;
premier
          ld hl,&4900
          jr poke_vram
;
second
          ld hl,&4980
          jr poke_vram
;
; On a rempli un sprH on passe au suivant
;
next_sprh
          ld a,h        ; si #4f10
          cp &4F
          jr z,second
;
          inc h
          ld l,0
          jr poke_vram

next_sprh_bas
          ld a,h        ; si #4f90
          cp &4F
          jr z,premier
;
          inc h
          ld l,&80
          jr poke_vram

;
txt

    ;  BYTE "@ABCDEFGHIJKLMNOPQRSTUVWXYZ@"
    ;  BYTE "ABCDEFGH@IJKLMNOP@QRSTUVWXYZ"
    ;  BYTE 1
    ;  BYTE 0
      BYTE "HELLO@FOLKS@HOW@ARE@YOU@@@@@"
      BYTE "I@KNOWN@IT@S@A@LITTLE@TOO@@@"
      BYTE 1
      BYTE "LATE@FOR@RELEASE@IT@AT@THE@@"
      BYTE "BND@FOUR@@@@@@@@@@@@@@@@@@@@"
      BYTE 1
      BYTE "THANKS@ELIOT@FOR@THIS@BND@@@"
      BYTE "IT@WAS@A@REAL@PLEASURE@TO@@@"
      BYTE 1            ; display message ; le message peut descendre
      BYTE "SEE@ALL@SMILES@AND@MY@TEAM@@"
      BYTE "GREAT@TO@SEE@ALL@GUEST@STARS"
      BYTE 1            ; display message ; le message peut descendre
      BYTE "PRODATRON@GOOD@TO@SEE@YOU@IN"
      BYTE "PERSON@@@@@@@@@@@@@@@@@@@@@@"
      BYTE 1
      BYTE "PROMISED@I@WON@T@BE@LATE@THE"
      BYTE "NEXT@BND@@@@@@@@@@@@@@@@@@@@"
      BYTE 1
      BYTE "I@LL@END@MY@CODE@BEFORE@@@@@"
      BYTE "COMING@@@@@@@@@@@@@@@@@@@@@@"
      BYTE 1
      BYTE "SOME@CREDITS@@@@@@@@@@@@@@@@"
      BYTE "@@@@@@@@@@@@@@@@MUSIC@BY@TAO"
      BYTE 1
      BYTE "PLAYER@BY@AST@@@@@@@@@@@@@@@"
      BYTE "@@@@@@@@GFX@BY@KRIS@NICE@COW"
      BYTE 1
      BYTE "INCREDIBLE@CODE@BY@SID@@@@@@"
      BYTE "IMPACT@ALWAYS@LOVE@YOU@ALL@@"
      BYTE 1
      BYTE "HAPPY@NEW@YEAR@@@@@@@@@@@@@@"
      BYTE "@@@@@@@@@HAPPY@NEW@YEAR@@@@@"
      BYTE 1
      BYTE 0            ; octet de fin de texte
;
display_message
          ld a,0        ; on change le flag quand le message est descendu
          or a          ; dans la routine timer0
          jr nz,timer0
          ld hl,(pos_y+1)
          2 ** inc hl
          ld a,l
          cp 100+2      ; si Y=100
          jr z,timer0
          ld (pos_y+1),hl
          ret
;
; On attends &200 frames avant de remonter le message
;
timer0    ld hl,&80
          dec hl
          ld a,h
          or l
          jr z,message_up
          ld (timer0+1),hl
;
          ld a,1
          ld (display_message+1),a
;
          ret
;
; Message Up
; Une fois le timer termine, on remonte le message
;   

message_up ld hl,(pos_y+1)
          2 ** dec hl
          ld a,h
          cp &FF
          jr nz,poke_pos
          ld a,l
          cp &C0
          jr z,reinit_compt
poke_pos
          ld (pos_y+1),hl
          ret
;
; Reinitialise texte pour pouvoir ecrire le prochain
; + reinitialise timer 0
;
reinit_compt
;
          ld hl,&80
          ld (timer0+1),hl
;
          ld hl,(display+1)
          inc hl
          ld (display+1),hl
;
;          call inc_char
;              
; Reinitialise Flag message qui descends
;
          xor a
          ld (display_message+1),a

          ret
;                       

sidfnt
;
; Definition Adresse Table des caracteres
; On genere les adresses des 26 chars 
; de l'alphabet + le char espace (1er char -> @ )

;sprh0
      WORD fnt+8+ 5*&80,fnt+ 0*&80,fnt+4+ 0*&80,fnt+8+ 0*&80 ; @ABC
;sprh1
      WORD fnt+12+ 0*&80,fnt+ 2*&80,fnt+4+ 2*&80,fnt+8+ 2*&80 ; DEFG
;sprh2
      WORD fnt+12+ 2*&80,fnt+ 4*&80,fnt+4+ 4*&80,fnt+8+ 4*&80 ; HIJK
;sprh3
      WORD fnt+12+ 4*&80,fnt+ 6*&80,fnt+4+ 6*&80,fnt+8+ 6*&80 ; LMNO
;sprh4
      WORD fnt+12+ 6*&80,fnt+ 1*&80,fnt+4+ 1*&80,fnt+8+ 1*&80 ; PQRS
;sprh5
      WORD fnt+12+ 1*&80,fnt+ 3*&80,fnt+4+ 3*&80,fnt+8+ 3*&80 ; TUVW
;sprh6
      WORD fnt+12+ 3*&80,fnt+ 5*&80,fnt+4+ 5*&80 ; XYZ
;  




fnt
      BYTE &00,&05,&00,&00,&05,&05,&00,&00
      BYTE &00,&05,&00,&00,&05,&05,&00,&00
      BYTE &05,&0F,&05,&00,&05,&0F,&05,&00
      BYTE &05,&0F,&05,&00,&05,&0F,&05,&00
      BYTE &05,&05,&05,&00,&05,&05,&0F,&00
      BYTE &05,&00,&0F,&00,&05,&00,&05,&00
      BYTE &05,&0F,&05,&00,&05,&0F,&05,&00
      BYTE &05,&00,&00,&00,&05,&00,&05,&00
      BYTE &05,&00,&05,&00,&05,&00,&05,&00
      BYTE &05,&00,&05,&00,&05,&00,&05,&00
      BYTE &05,&00,&05,&00,&05,&05,&0F,&00
      BYTE &0F,&05,&0F,&00,&05,&05,&0F,&00
      BYTE &0F,&00,&0F,&00,&0F,&0F,&00,&00
      BYTE &00,&0F,&00,&00,&0F,&0F,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&05,&00,&00,&05,&05,&00,&00
      BYTE &00,&05,&05,&00,&05,&05,&05,&00
      BYTE &05,&0F,&05,&00,&05,&0F,&05,&00
      BYTE &05,&0F,&0F,&00,&0F,&05,&0F,&00
      BYTE &0F,&05,&05,&00,&05,&05,&0F,&00
      BYTE &05,&05,&05,&00,&00,&05,&00,&00
      BYTE &00,&0F,&05,&00,&05,&0F,&05,&00
      BYTE &0F,&0F,&05,&00,&00,&05,&00,&00
      BYTE &00,&00,&05,&00,&05,&00,&05,&00
      BYTE &00,&00,&05,&00,&00,&05,&00,&00
      BYTE &00,&00,&05,&00,&05,&00,&05,&00
      BYTE &05,&05,&0F,&00,&00,&05,&00,&00
      BYTE &00,&00,&0F,&00,&0F,&00,&0F,&00
      BYTE &0F,&0F,&00,&00,&00,&0F,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &05,&05,&05,&00,&05,&05,&05,&00
      BYTE &05,&05,&05,&00,&05,&00,&05,&00
      BYTE &05,&0F,&0F,&00,&05,&0F,&0F,&00
      BYTE &05,&0F,&0F,&00,&05,&00,&05,&00
      BYTE &05,&05,&00,&00,&05,&05,&00,&00
      BYTE &05,&00,&00,&00,&05,&05,&05,&00
      BYTE &05,&0F,&00,&00,&05,&0F,&00,&00
      BYTE &05,&00,&05,&00,&05,&0F,&05,&00
      BYTE &05,&00,&00,&00,&05,&00,&00,&00
      BYTE &05,&00,&05,&00,&05,&00,&05,&00
      BYTE &05,&05,&05,&00,&05,&00,&00,&00
      BYTE &05,&05,&05,&00,&05,&00,&05,&00
      BYTE &0F,&0F,&0F,&00,&0F,&00,&00,&00
      BYTE &0F,&0F,&0F,&00,&0F,&00,&0F,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &05,&00,&05,&00,&05,&00,&05,&00
      BYTE &05,&00,&05,&00,&05,&00,&05,&00
      BYTE &05,&00,&05,&00,&05,&00,&05,&00
      BYTE &05,&00,&05,&00,&05,&00,&05,&00
      BYTE &05,&00,&05,&00,&05,&00,&05,&00
      BYTE &05,&00,&05,&00,&0F,&05,&0F,&00
      BYTE &05,&00,&05,&00,&05,&00,&05,&00
      BYTE &05,&00,&05,&00,&05,&0F,&05,&00
      BYTE &05,&00,&05,&00,&05,&00,&05,&00
      BYTE &05,&05,&05,&00,&05,&00,&05,&00
      BYTE &05,&05,&05,&00,&05,&05,&0F,&00
      BYTE &05,&0F,&05,&00,&05,&00,&05,&00
      BYTE &0F,&0F,&0F,&00,&0F,&0F,&00,&00
      BYTE &0F,&00,&0F,&00,&0F,&00,&0F,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&05,&00,&00,&05,&05,&05,&00
      BYTE &05,&00,&05,&00,&05,&00,&00,&00
      BYTE &00,&0F,&00,&00,&0F,&0F,&05,&00
      BYTE &05,&00,&05,&00,&05,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&05,&00
      BYTE &05,&05,&0F,&00,&05,&00,&00,&00
      BYTE &00,&05,&00,&00,&00,&00,&05,&00
      BYTE &05,&0F,&05,&00,&05,&00,&00,&00
      BYTE &00,&05,&00,&00,&05,&00,&05,&00
      BYTE &05,&00,&05,&00,&05,&00,&00,&00
      BYTE &00,&05,&00,&00,&0F,&05,&05,&00
      BYTE &05,&00,&05,&00,&05,&05,&05,&00
      BYTE &00,&0F,&00,&00,&00,&0F,&0F,&00
      BYTE &0F,&00,&0F,&00,&0F,&0F,&0F,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &05,&00,&05,&00,&05,&05,&05,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &05,&00,&05,&00,&0F,&0F,&05,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &05,&05,&05,&00,&00,&05,&0F,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &0F,&0F,&05,&00,&05,&0F,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&05,&00,&05,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &05,&05,&0F,&00,&05,&05,&05,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &0F,&0F,&00,&00,&0F,&0F,&0F,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &05,&00,&05,&00,&05,&05,&00,&00
      BYTE &00,&05,&00,&00,&05,&05,&00,&00
      BYTE &05,&05,&05,&00,&05,&0F,&05,&00
      BYTE &05,&0F,&05,&00,&05,&0F,&05,&00
      BYTE &05,&05,&05,&00,&05,&00,&05,&00
      BYTE &05,&00,&05,&00,&05,&05,&0F,&00
      BYTE &05,&0F,&05,&00,&05,&00,&05,&00
      BYTE &05,&00,&05,&00,&05,&0F,&00,&00
      BYTE &05,&00,&05,&00,&05,&00,&05,&00
      BYTE &05,&00,&05,&00,&05,&00,&00,&00
      BYTE &05,&00,&05,&00,&05,&00,&05,&00
      BYTE &0F,&05,&0F,&00,&05,&00,&00,&00
      BYTE &0F,&00,&0F,&00,&0F,&00,&0F,&00
      BYTE &00,&0F,&00,&00,&0F,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00
      BYTE &00,&00,&00,&00,&00,&00,&00,&00

;          
; Fin de la Fonte
;
; Player Ayc - Player By AsT
;   Ayc Decruncher by Madram
;
WANTLOOP = 1            ;0 = ne boucle pas (routine + rapide)
DECRUBUF = &B000        ;doit valoir x000 ou x800 (cf ATTRIBU)
YMLZ  = &4000           ;Adresse fichier compacte
DUREE = YMLZ            ;Indiquee dans le header
;
; Bank Memoire ou est installee la musique
;
bank  = &C7
;         
init      jp init_music
play      jp play_music
;             
init_music

          call bank_music
;
    ;      ld hl,&3C00   ; modifie duree de la musique   
    ;      ld (YMLZ),hl
;
          call READHEAD ; duree du ym  
          call RAZVAR
;
;Il faut preparer quelques donnees d'avances

          ld a,(NBR_REG)
AMORCE
          push af
          call GETREG
          pop af
          dec a
          jr nz,AMORCE
          ret
;
play_music
          call GETREG
          jp adresse
;
GETREG
          call bank_music
          di
          ld (SAVETMP+1),sp
          ld a,(NBR_REG) ;Necessaire pour V1 a V13
          dec a         ;mais pas pour VMESURE/V0 
      IF WANTLOOP
      BYTE &DD
DECALEH   ld h,0
      END
          ld iy,GET_RET
GETWITCH  jp V0         ;Quelle routine ?
GET_RET
          ld hl,(GETWITCH+1)
          dec hl
          ld d,(hl)     ;Recupere adresse
          dec hl
          ld e,(hl)
          ld (GETWITCH+1),de

SAVETMP   ld sp,0
          ei
          ret


      WORD V1           ;Adresse prochaine routine
VMESURE
      IF WANTLOOP

;S'il reste moins que "NBR_REG" donnees a recuperer,
;on recupere ces quelques donnees, on reset (methode brute pour l'instant),
;puis on recupere qq donnees complementaire.

;Sinon, on saute normallement a V0, et le test ne sera pas effectue
;de V1 a V13 ...

MESURE    ld hl,0
          ld c,l
          ld d,0
          ld a,(NBR_REG)
          ld e,a
          or a
          sbc hl,de
          ld (MESURE+1),hl
          dec a
          jp nc,V0

;Pour V1 etc..., on ne refera pas le test precedent

          ld b,d
          ld de,RETIENT
          ld (GETWITCH+1),de
          ld de,(DUREE)
          add hl,de
          ld (MESURE+1),hl
          ld a,c
          ld (COMPLETE+1),a
          ld (RETIENT+1),a

;On doit determiner la position destination dans les buffers

          ld hl,(adresse+1) ; PLAYPLAG+1
          add hl,bc
          ld a,(NBR_REG)
          ld c,a
          add hl,bc
          ld a,h
          and &03
          ld (DECALEH+1),a
          ld a,l
          ld (DECALEL+1),a

RETIENT   ld a,0
          dec a
          jp m,CAS0     ;0 data ? Il faut reseter
          ld iy,GET_RET_
GETWITC_  jp V0

CAS0
          ld a,(NBR_REG)
          jr RESET

GET_RET_
          ld a,(NBR_REG)
COMPLETE  ld b,0
          sub b

RESET

          ld hl,(GETWITC_+1)
          inc hl
          ld e,(hl)     ;Plage de variable
          inc hl
          ld d,(hl)
          inc de
          inc de
          inc de
          inc de
          ld hl,REGSCOPY-REGS+1
          add hl,de
          ex de,hl
DECALEL   ld (hl),0
          inc hl
          ex de,hl
          ldi
          ldi
          ldi
          ldi
          ldi

          ld iy,GET_RET2
          dec a
          jr GETWITC_
GET_RET2
          ld hl,(GETWITC_+1)
          dec hl
          ld d,(hl)     ;Recupere adresse
          dec hl
          ld e,(hl)
          ld hl,-VMESURE-1 ;Pour redirection, il faut boucler sur 
          add hl,de     ;V0
          jr c,REGLP_OK
          ld hl,VMESURE
          ld (GETWITCH+1),de
          ld de,V0
REGLP_OK
          ld (GETWITC_+1),de
          ld sp,(SAVETMP+1)
          ei
          ret


      WORD V1
      END
V0

          ld sp,REGS    ;!!! PLACER le LD SP apres le label !!!
VROUT     jp DECOMP0    ;ATTENTION ! L'ecart doit rester
      WORD V2
V1

          ld sp,REGS+10
VROUT_    jp DECOMP0    ;constant pour les modifs d'ATTRIBU
      WORD V3
V2
          ld sp,REGS+20
          jp DECOMP0
      WORD V4
V3
          ld sp,REGS+30
          jp DECOMP0
      WORD V5
V4
          ld sp,REGS+40
          jp DECOMP0
      WORD V6
V5
          ld sp,REGS+50
          jp DECOMP0
      WORD V7
V6
          ld sp,REGS+60
          jp DECOMP0
      WORD V8
V7
          ld sp,REGS+70
          jp DECOMP0
      WORD V9
V8
          ld sp,REGS+80
          jp DECOMP0
      WORD V10
V9
          ld sp,REGS+90
          jp DECOMP0
      WORD V11
V10
          ld sp,REGS+100
          jp DECOMP0
      WORD V12
V11
          ld sp,REGS+110
          jp DECOMP0
      WORD V13
V12
          ld sp,REGS+120
          jp DECOMP0
      WORD VMESURE      ;!!! BOUCLE EN CONCORDANCE AVEC NBR_REG
V13
          ld sp,REGS+130
          jp DECOMP0
      WORD V15
V14
          ld sp,REGS+140
          jp DECOMP0
      WORD V0
V15
          ld sp,REGS+150
          jp DECOMP0


D0_CHR

;Place  en premier pour etre atteint par JR

          ex af,af
          ld a,(hl)
          inc hl
          exx
          ld (de),a
          inc e
          ex af,af

;On decremente nbr de caracteres restants.

          dec a
          exx
          jp p,D0_NEXT


          push hl
          push bc
          exx

          push bc       ;B DOIT ETRE NUL ICI
          push hl       ;Bidon
          push de
          jp iy


DECOMP0

;Entree  : A  = nbr de donnees a decompacter - 1
;          IY = adr de retour
;On suppose que longueur est code en negatif (ie -2 -> 2 caracteres)

;On recupere adr destination dans tous les cas
;(Remarque : D ne change pas, il y a peut etre moyen d'optimiser cela)

          pop de
          pop hl        ;Adresse source pour copie chaine

;On recupere B = nbr de caracteres a copier   C est inutilise

          pop bc
          inc b
          dec b
          jr z,D0_FLAG

D0_MESUR

;On regarde si longueur de chaine restante > nbr de donnees a fournir

      IF WANTLOOP
          exx
          ld d,a
          exx
          add b         ;longueur codee en negatif
          jr nc,D0_AL_
      ELSE
          add b
          jr nc,D0_ALL
      END

          ex af,af
D0_LP1
          ld a,(hl)
          inc l
          ld (de),a
          inc e
          inc b
          jr nz,D0_LP1
          ex af,af

D0_FLAG

;On recupere FLAGs et pointeur donnees compressees
;(B inutilise)

          exx
          pop bc
          pop hl


;On extrait nouveau flag

D0_NEXT
          sla c
          jr nz,D0_FLGOK

          ld c,(hl)
          inc hl
      BYTE &CB,&31      ;SLL C
D0_FLGOK
          jr nc,D0_CHR

;Test similaire au precedent

          ld b,(hl)
          inc hl
          ld d,a        ;Sauve pour D0_LEFT
          add b
          jr nc,D0_LEFT

;Il restera (A+1) donnees a fournir apres copie de la chaine

          ex af,af
          ld a,b
          exx
          ld b,a
          exx
          ld a,(hl)
          inc hl
          exx
      IF WANTLOOP
          add c
      END
          ld l,a
D0_LP2
          ld a,(hl)
          inc l
          ld (de),a
          inc e
          inc b
          jr nz,D0_LP2
          ex af,af
          exx
          jr D0_NEXT

D0_LEFT

;Idem que D0_ALL mais sur moins de donnees.

          ex af,af      ;Pour l'instant on conserve A-B
          ld a,d        ;Nombre de valeur restantes a copier-1
          exx
          ld b,a
          inc b
          exx
          ld a,(hl)
          inc hl
          push hl
          push bc
          exx
      IF WANTLOOP
          add c
      END
          ld l,a
D0_LP3
          ld a,(hl)
          inc l
          ld (de),a
          inc e
          djnz D0_LP3
          ex af,af
          ld b,a
          inc b         ;Longueur restante pour prochaine fois
          push bc

          push hl
          push de
          jp iy

      IF WANTLOOP
D0_AL_

;  D0_ALL ne convient pas quand on veut changer dynamiquement le nombre
;  de valeurs a recuperer (c'est le cas pour le bouclage).

          inc a
          ld b,a
          push bc
          exx
          ld a,d
          exx
          ld b,a
          inc b

D0_AL_LP  ld a,(hl)
          ld (de),a
          inc l
          inc e
          djnz D0_AL_LP

          push hl
          push de
          jp iy

      ELSE

D0_ALL

;La chaine a copier fournie toutes les donnees

          inc a
          ld b,a        ;Longueur restante pour prochaine fois
          push bc

D0_COPY   ld a,(hl)
          ld (de),a
          inc l
          inc e
      FILL 80,0         ;Place pour NBR_REG copies
      FILL 5,0          ;Place pour D0_MODEL

D0_MODEL                ;Sera copie a la suite des LDI
          push hl
          push de
          jp iy
D0_MODE_

      END




READHEAD

;On va   analyser le header

          ld hl,(DUREE)
          ld (MESURE+1),hl
          ret

RAZVAR

;Toutes les auto-modifs pour la gestion

          ld hl,VMESURE
          ld (GETWITCH+1),hl
      IF WANTLOOP
          ld hl,V0
          ld (GETWITC_+1),hl
          xor a
          ld (DECALEH+1),a
      END
          ld hl,0
          ld (adresse+1),hl
        ;  ld (PLAYPLAG+1),hl

          call SETVAR

          ld hl,REGS    ;On copier variable pour reset/bouclage
          ld de,REGSCOPY
          ld bc,16*10
          ldir

          ret


SETVAR

;Init variables REGS pour la decompression.

          ld hl,OFBUF0
          exx
          ld a,(NBR_REG)
          ld b,a        ;Nombre registres traites
          ld de,(ADRTEMP) ;Pointe sur donnees (en relatif)
          inc de
          inc de        ;Saute "longueur"
          ld hl,REGS
RAZLOOP
          push bc

;On place adr DEST

          exx
          ld a,(hl)
          inc hl
          inc hl
          exx
          ld (hl),0
          inc hl
          ld (hl),a
          inc hl

;Adr source pour copie chaine : forcement meme poids fort qd fenetre #100

          inc hl
          ld (hl),a
          inc hl

;Valeur decalage (quand boucle, les donnees ne sont plus placees a partir de 0,
;les references absolues doivent etre corrigees)

          ld (hl),0
          inc hl

;On place nbr de chr restant a copier = 0

          ld (hl),0
          inc hl

;Octet flag a #40 pour copie 1er octet et enclencher lecture nouveaux flags

          ld (hl),&40
          inc hl
          inc hl

;Maintenant il faut lire adr debut donnees compresses,
;donnees en relatif par rapport a position courante dans header

          ex de,hl
          inc hl        ;On saute type compression
          ld c,(hl)
          inc hl
          ld b,(hl)

          push hl
          add hl,bc
          ld b,h
          ld c,l
          pop hl

          inc hl
          ex de,hl
          ld (hl),c
          inc hl
          ld (hl),b
          inc hl

          pop bc
          djnz RAZLOOP
          ret

VAR                     ;Variables de travail

REGS  FILL 16*10,0      ;Variables pour chaque registre
REGSCOPY FILL 16*10,0   ;Pour reset lors du bouclage

; Pour chaque registre, on a :

; Adresse destination     (DE)
; Adresse source chaine   (HL)  ne sert pas forcement
; Flag/compteur chaine    (BC)  C : poids faible decalage
; Octet flags             (BC') B' inutilise
; Source data compresses  (HL')

DATA

;NBR_REG est une constante qui permet de determiner combien recuperer
;de donnees a la fois. Si NBR_REG = 14, on recupere 14 donnees par registre et
;par VBL. Au bout de 14 VBL, on peut jouer 14 fois tous les reg., le temps de
;recuperer 14*14 nouvelles donnees.

NBR_REG BYTE 14         ;!!! MODIFIER (V14-2) EN CONSEQUENCE !!


ADRTEMP WORD YMLZ



OFBUF0 BYTE DECRUBUF/256 ;Poids fort adresse
      BYTE 1            ;Taille (1 ou 4) pour CREEPLAY 

;Attention les tampons de #400 doivent commencer en #x000 ou #x800

      BYTE DECRUBUF/256+ 1,1,DECRUBUF/256+ 2,1,DECRUBUF/256+ 3,1
      BYTE DECRUBUF/256+ 4,1,DECRUBUF/256+ 5,1,DECRUBUF/256+ 6,1
      BYTE DECRUBUF/256+ 7,1,DECRUBUF/256+ 8,1,DECRUBUF/256+ 9,1
      BYTE DECRUBUF/256+ 10,1,DECRUBUF/256+ 11,1,DECRUBUF/256+ 12,1
      BYTE DECRUBUF/256+ 13,1,DECRUBUF/256+ 14,1,DECRUBUF/256+ 15,1
;
adresse   ld hl,DECRUBUF
;               
          call bank_music
          ld a,(adresse+1)
          ld h,DECRUBUF/256
          ld l,a
          ld e,0        ; on commence par le reg 0 du psg
;
; Traitement Reg Psg 0 a 7
;
          ld a,(hl)
rg0       cp 0
          ld (rg0+1),a
          call nz,psg
          inc h
          inc e
;
          ld a,(hl)
          and &0F
rg1       cp &FF
          ld (rg1+1),a
          call nz,psg
          inc h
          inc e
;
          ld a,(hl)
rg2       cp 0
          ld (rg2+1),a
          call nz,psg
          inc h
          inc e
;
          ld a,(hl)
          and &0F
rg3       cp &FF
          ld (rg3+1),a
          call nz,psg
          inc h
          inc e
;
          ld a,(hl)
rg4       cp 0
          ld (rg4+1),a
          call nz,psg
          inc h
          inc e
;
          ld a,(hl)
          and &0F
rg5       cp &FF
          ld (rg5+1),a
          call nz,psg
          inc h
          inc e
;
          ld a,(hl)
rg6       cp 0
          ld (rg6+1),a
          call nz,psg
          inc h
          inc e
;
rg7       ld a,(hl)
          call psg
        ;  cp 0
        ;  ld (rg7+1),a
        ;  call nz,psg
          inc h
          inc e
;   
; Traitement Reg Psg 8 a 10
;
          ld a,(hl)
rg8       cp 0
          ld (rg8+1),a
          call nz,psg
;
reg9      inc h
          inc e
;
          ld a,(hl)
rg9       cp 0
          ld (rg9+1),a
          call nz,psg
;
reg10     inc h
          inc e

          ld a,(hl)
rg10      cp 0
          ld (rg10+1),a
          call nz,psg
;
reg11     inc h
          inc e

;      
; registre 11 et 12
;
      2 ** [
          ld a,(hl)
          call psg
          inc h
          inc e
          ]
;
; registre 13
;
          ld a,(hl)
          cp &FF
          jr z,sauter13
;
          call psg
;
sauter13
;                
          ld a,(adresse+1)
          inc a
          ld (adresse+1),a

;
          ret
;   
; e=reg
; a=val
;       
psg
          ld bc,&F480
          out (c),e     ; e=reg
          set 1,b       ; ld b,&F6
          out (c),b     ; #f6c0
          out (c),0     ; #f600
          res 1,b       ; ld b,&F4
          out (c),a     ; a=val
          set 1,b       ; ld b,&F6
          out (c),c     ; #f680
          out (c),0     ; #f600
          ret
;
bank_music
          ld bc,&7F00+bank
          out (c),c
          ret
;
end_player

