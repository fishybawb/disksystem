; file types
PRAM = $00
CRAM = $01 
VRAM = $02

.org $0000

; disk info block
.db $01
.db "*NINTENDO-HVC*"
.db $00
.db "ROB"
.db $20
.db $00
.db $00
.db $00
.db $00
.db $00
.db $0F
.db $FF,$FF,$FF,$FF,$FF
.db $00,$00,$00
.db $49
.db $61
.db $00
.db $00,$02
.db $00,$00,$00,$00,$00
.db $00,$00,$00
.db $00
.db $80
.db $00,$00
.db $07
.db $00
.db $00
.db $00
.db $00
	
; file amount block
.db $02
; number of files
.db $03

; first file header block (approval file)
.db $03
.db $00
.db $00
.db "KYODAKU-"
.dw $2800
.dw $00E0
.db VRAM

; first file data block
.db $04
.include "kyodaku.asm"

; second file header block (prg)
.db $03
.db $01
.db $01
.db "MAINCODE"
.dw $A000
.dw (main_end - main_start)
.db PRAM

; second file data block
.db $04
main_start:
.incbin "maincode.bin"
main_end:

; third file header block (chr)
.db $03
.db $02
.db $02
.db "CHRBANK0"
.dw $0000
.dw (chr_end - chr_start)
.db CRAM

; third file data block
.db $04
chr_start:
.incbin "chrbank0.chr"
chr_end:

; fill side to 65500 bytes
.pad 65500,$00
