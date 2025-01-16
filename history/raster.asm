org #1000
run $
start
	call delock
        call asicon
;
; Routine d'affichage de Raster ink 0 + Border
; 
;
        ld hl,raster_tab ; pointe sur la table raster
        ld de,#6400     ; ink 0
        ld bc,#6420     ; border
        ld a,8              ; nbre de lignes
loop_raster
        push af            ; on sauve A vu qu'on veut utilser A ensuite.
        ld a,(hl)           ; récupère RB
        ld (de),a          ; on poke RB dans ink 0
        ld (bc),a          ; on poke RB dans border
        inc hl
        inc c                ; #6421 -> border Couleur Green
        inc e                ; #6401 -> ink 0 Couleur Green
        ld a,(hl)           ; récupère G
        ld (de),a          ; on poke G dans ink 0
        ld (bc),a          ; on poke G dans border
        inc hl
        dec c               ; #6420
        dec e               ; #6400
        pop af
        defs 64-4-27,0 ; on synchronise sur 64 nops (1 rasterline)
        dec a
        jr nz,loop_raster
        ret
;
; Définition de la table raster
;
raster_tab
        defw #004,#005,#006,#007
        defw #007,#006,#005,#004
;
include 'amstrad_plus.asm'
end
save'disc.',#1000,end - start,DSK,'raster.dsk'