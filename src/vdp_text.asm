; -------------------------------------------------------------------
; *** Based on software written by Glenn Jolly
; *** Original author copyright notice:
; Copyright (C) 2021 by Glenn Jolly;
; You have permission to use, modify, copy, and distribute
; this software for non commercial uses.  Please notify me 
; on the COSMAC ELF Group at https://groups.io/g/cosmacelf of any
; improvements and/or corrections.
; -------------------------------------------------------------------
; *** Uses BIOS calls from software written by Michael H Riley
; *** Original author copyright notice:
; -------------------------------------------------------------------
; *** This software is copyright 2004 by Michael H Riley          ***
; *** You have permission to use, modify, copy, and distribute    ***
; *** this software so long as this copyright notice is retained. ***
; *** This software may not be used in commercial applications    ***
; *** without express written permission from the author.         ***
; -------------------------------------------------------------------
;
;                  TMS9118
;            Text mode memory map
;            +-----------------+ 0000h
;            |  Pattern Table  |
;            +-----------------+ 0800h 2048 (can define 256 codes)
;            |    Name Table   |
;            +-----------------+ 0BC0h 3008 (40x24 960 chars)
;            |     Unused      |
;            +-----------------+ 3FFFh (16k VRAM)
;
; -------------------------------------------------------------------

#include    include/bios.inc
#include    include/kernel.inc
#include    include/ops.inc
#include    include/vdp.inc
#include    include/charset.inc

            extrn setAddress
            extrn clearMem
            extrn initRegs
            extrn initCharset
            extrn ADD16
            extrn MULT8

; -------------------------------------------------------------------
; Set up video card to write strings in text mode
; Inputs: (none)
; -------------------------------------------------------------------
            proc beginTextMode  
            ldi  V_SET_GROUP  ; Set Expansion Group for video card
            call O_VIDEO
            call clearMem     ; clear vram  
            call initRegs     ; set vregs for text mode
            dw vregs_txt
            call initCharset  ; initialize character set
            rtn
; -----------------------------------------------------------
; Default VDP register settings for text mode
; -----------------------------------------------------------  
vregs_txt:  db  0      ; VR0 text mode, no ext video
            db  0d0h   ; VR1 16k vram, display enabled, interrupts disabled
            db  2h     ; VR2 Name table address 0800h
            db  0      ; VR3 No color table - see VR7
            db  0      ; VR4 Pattern table address 0000h
            db  20h    ; VR5 Sprite attribute table address 1000h - ignored
            db  0      ; VR6 Sprite pattern table address 0h - ignored
            db  0f4h   ; VR7 White text (F) on blue background (4)            
            endp            

; -------------------------------------------------------------------            
; Set the expansion group to default
; Inputs:  D  - reset VDP to make sure interrupt is off 
; -------------------------------------------------------------------            
            proc endTextMode
            lbz  keep_etm       ; D indicates keep display on, or reset  
            ldi  0f1h           ; set background to Black
            phi  r7             ; set vdp register data value  
            ldi  87h            ; VDP register 7
            plo  r7             ; set vdp register destination
            ldi  V_WRITE_VREG    
            call O_VIDEO        ; make sure vdp interrupt is off                
            ldi  090h           ; 16k=1, disp=0, int=0, m1=1,m2=0
            phi  r7             ; set vdp register data value  
            ldi  81h            ; VDP register 1
            plo  r7             ; set vdp register destination
            ldi  V_WRITE_VREG    
            call O_VIDEO        ; make sure vdp interrupt is off
keep_etm:   ldi  V_RESET_GROUP
            call O_VIDEO        ; set expansion group back to default
            rtn
            endp

; -------------------------------------------------------------------
; Set textcolor foreground/background
; Inputs:
;   D = text color as byte (forground color/background color)
; -------------------------------------------------------------------
            proc setTextColor
            phi  r7             ; r7.1 = vdp register data value
            ldi  87h            ; send to VREG7
            plo  r7             ; r7.0 = vdp register destination
            ldi  V_WRITE_VREG   ; write text coler to VREG7
            CALL O_VIDEO
            rtn 
            endp             
              
; -------------------------------------------------------------------
; Position text cursor to x,y for subsequent printing
; Inputs:
; db x, db y (inline)
; -------------------------------------------------------------------
            proc setTextCharXY
            ; multiply column (y) and add row (x) to get address offset
            ; ofs = 40*y + x since we have 40 chars per line
            ldi  0
            phi  r8
            lda  r6
            plo  r8         ; r8 = x
            push r8
            ldi  40
            phi  r8
            lda  r6
            plo  r8         ; r8.1 = 40;  r8.0 = y
            call MULT8      ; r7 = r8.O x r8.1 i.e. r7 = 40*y
            pop  r8         ; r8 = x
            call ADD16      ; r7 = 40*y + x            
            ; add VDP offset 
            load r8, 4800h  ; 4800h is VDP address 800h
            call ADD16      ; r7 = 40*y + x + 4800h            
            ; send address to VDP            
            ldi  V_SET_ADDRESS
            call O_VIDEO
            rtn
            endp
; -----------------------------------------------------------
; Write a null-terminated text string at positioned cursor
; Inputs: 
;   rf - pointer to null terminated text string 
; -----------------------------------------------------------
            proc writeTextString
            lda  rf
            lbz   EXIT_WTS
#ifdef TI99_FONT
            smi  32               ; ti99 index is 32 less than ascii
#endif
            plo  r8
            ldi  V_WRITE_BYTE
            CALL O_VIDEO
            lbr  writeTextString  ; process next character  
EXIT_WTS:   rtn
            endp


; -----------------------------------------------------------
; Write text data to vram
; Inputs:
;   dw (inline) - pointer to text buffer
;   dw (inline) - size of text buffer 
; -----------------------------------------------------------
            proc writeTextData  
            lda  r6   ; set up ptr to text data buffer
            phi  r8
            lda  r6
            plo  r8  
            lda  r6   ; set text data size
            phi  r7
            lda  r6
            plo  r7
            ldi  V_WRITE_DATA   ; write text data to vram
            call O_VIDEO
            rtn
            endp
