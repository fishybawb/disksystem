; "MAINCODE" file contents

; zero page variables
.enum $0000
index .dsb 1
.ende

.base $A000

reset:
	jsr load_palette
	
	ldx #<bg_data
	ldy #>bg_data
	jsr draw_nametable
	
	bit $2002
	lda #%10001000
	sta $2000
	lda #%00011110
	sta $2001
	
main:
	jmp main

load_palette:
	lda $2002
	lda #$3f
	sta $2006
	ldx #$00
	stx $2006
	
  - lda palette,x
	sta $2007
	inx
	cpx #$10
	bne -
	rts
	
nmi1:
	rti

nmi2:
	rti

nmi3:
	rti
	
irq:
	rti
	
; bg palette data
palette:
.db $22,$27,$17,$20,$22,$1A,$0F,$27,$22,$55,$07,$20,$22,$00,$10,$20

.include "nametable.asm"

.org $DFF6
.dw nmi1
.dw nmi2
.dw nmi3
.dw reset
.dw irq
