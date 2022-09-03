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
;             TMS9118 / TMS9918
;            Graphics 2 memory map
;            +-----------------+ 0000h
;            |                 |
;            |  Pattern Table  |
;            |   6144 bytes    |
;            +-----------------+ 1800h
;            |                 |
;            | Sprite Patterns |
;            |    512 bytes    |
;            +-----------------+ 2000h
;            |                 |
;            |   Color Table   |
;            |   6144 bytes    |
;            +-----------------+ 3800h 
;            |                 |
;            |    Name Table   |
;            |    768 bytes    |
;            +-----------------+ 3B00h 
;            |                 |
;            |Sprite Attributes|
;            |    256 bytes    |
;            +-----------------+ 3C00h 
;            |                 |
;            |     Unused      |
;            |                 |
;            +-----------------+ 3FFFh 
; -------------------------------------------------------------------
#include    include/bios.inc
#include    include/kernel.inc
#include    include/ops.inc
#include    include/vdp.inc
#include    include/charset.inc

.list
.symbols

                extrn setAddress
                extrn clearMem
                extrn initRegs
                extrn vregs_g2
                extrn ADD16
                extrn MULT8
                extrn VDP_CHARSET


; -------------------------------------------------------------------
; Set up video card to draw an image in Graphics II mode
; Inputs: (none)
; -------------------------------------------------------------------
                proc beginG2Mode 
                ldi  V_SET_GROUP       ; Set up the Expansion Group for video card
                call O_VIDEO
                call clearMem
                call initRegs
                dw vregs_g2
                rtn
; -----------------------------------------------------------
; Default VDP register settings for graphics II mode
; -----------------------------------------------------------           
vregs_g2:       db  2       ; VR0 graphics 2 mode, no ext video
                db  0C2h    ; VR1 16k vram, display enabled, intr dis; 16x16 sprites
                db  0Eh     ; VR2 Name table address 3800h
                db  0FFh    ; VR3 Color table address 2000h
                db  3       ; VR4 Pattern table address 0000h
                db  76h     ; VR5 Sprite attribute table address 3B00h
                db  3       ; VR6 Sprite pattern table address 1800h
                db  01h     ; Backdrop color black
                endp
            
; -------------------------------------------------------------------
; init VDP register VR0 to update display in graphics mode 2
; -------------------------------------------------------------------
                proc updateG2Mode
                ldi  02h
                phi  r7            
                ldi  80h
                plo  r7
                ldi  V_WRITE_VREG
                call O_VIDEO
                rtn
                endp


; -------------------------------------------------------------------            
; Set the expansion group to default
; Inputs:  D  - reset VDP to make sure interrupt is off 
; -------------------------------------------------------------------            
                proc endG2Mode
                lbz  keep_on_eg2m   ; D indicates keep display on, or reset
                ldi  088h           ; 16k=1, blank=0, m1=0, m2=1
                phi  r7             ; set vdp register data value  
                ldi  081h           ; register 1
                plo  r7             ; set vdp register destination
                ldi  V_WRITE_VREG    
                call O_VIDEO        ; make sure vdp interrupt is off
keep_on_eg2m:   ldi  V_RESET_GROUP
                call O_VIDEO        ; set expansion group back to default
                rtn
                endp

; -------------------------------------------------------------------            
; Copy bitmap data to vram Pattern Table
; Inputs:
;   dw (inline) - ptr to bitmap data buffer (6144 bytes)
; -------------------------------------------------------------------
                proc sendBitmap
                call setAddress
                dw   V_BITMAP_PATTERN   ; set VDP write address to 0000h

                ; now we copy pattern data
                lda  r6
                phi  r8
                lda  r6
                plo  r8  
                load r7, 6144
                ldi  V_WRITE_DATA
                call O_VIDEO
                rtn
                endp

; -----------------------------------------------------------
;  Copy color data to Color table
; Inputs:
;   dw (inline) - ptr to color map data buffer (6144 bytes)
; -----------------------------------------------------------
                proc sendColors
                call setAddress
                dw   V_COLOR_TABLE    ; set VDP write address to 2000h  

                ; now copy color data
                lda  r6
                phi  r8
                lda  r6
                plo  r8  
                load r7, 6144
                ldi  V_WRITE_DATA
                call O_VIDEO
                rtn
                endp
                
; -----------------------------------------------------------
; Fill color data with single background color
; Inputs: D - background color 
; -----------------------------------------------------------
                proc setBackground
                plo  r8             ; save background color in D
                call setAddress
                dw V_COLOR_TABLE    ; set VDP address

                ; now fill color data
                load r7, 1800h      ; 6144 bytes
                ldi  V_FILL_VRAM
                CALL O_VIDEO        ; fill it with color
                rtn
                endp                

; -----------------------------------------------------------
; Set name table entries of vram @ 3800h (Name table)
; Inputs: (none)
; -----------------------------------------------------------
                proc sendNames
                call setAddress
                dw V_NAME_TABLE     ; set VDP address

                ; fill with triplet series 0..255, 0..255, 0..255
                load r7, 768        ; number of entries to write
                ldi  V_FILL_SEQ
                call O_VIDEO
                rtn
                endp
                
; -------------------------------------------------------------------
;        Send sprite pixel pattern data to VDP
; Inputs:
;   dw (inline) - ptr to sprite pattern buffer
;   dw (inline) - size of sprite pattern
; -------------------------------------------------------------------            
                proc setSpritePattern
                ; set VDP write address to 1800h
                call setAddress
                dw   V_SPRITE_PATTERN   ; set VDP write address to 1800h

                ; copy sprite definitions to r8
                lda  r6
                phi  r8
                lda  r6
                plo  r8
                ; copy sprite pattern size to r7
                lda  r6
                phi  r7
                lda  r6
                plo  r7
                ; write the pattern data to VDP
                ldi  V_WRITE_DATA
                CALL O_VIDEO  
                rtn
                endp                
                        
; -------------------------------------------------------------------
;      Get sprite attributes data and send to VDP
; Inputs:
;   dw (inline) - ptr to sprite attributes buffer
;   dw (inline) - size of sprite attributes
; -------------------------------------------------------------------
                proc setSpriteData
                ; set VDP write address to 3B00h
                call setAddress          
                dw   V_SPRITE_ATTRIB    
            
                ; copy sprite attributes pos and color to r8
                lda  r6
                phi  r8
                lda  r6
                plo  r8
                lda  r6
                ; copy sprite attributes size to r7
                phi  r7
                lda  r6
                plo  r7
                ; write sprite attributes to vdp
                ldi  V_WRITE_DATA
                CALL O_VIDEO  
                rtn
                endp

; -----------------------------------------------------------
; Send bitmap data to vdp Pattern Table
; Inputs:
;   dw (inline) - ptr bitmap data buffer
;   dw (inline) - ptr to buffer with data size
; -----------------------------------------------------------
                proc sendBmapData
                call setAddress
                dw V_BITMAP_PATTERN   ; set VDP write address

                ; point r8 to data buffer
                lda  r6
                phi  r8
                lda  r6
                plo  r8
                ; now we copy ptr to data size
                lda  r6
                phi  r9
                lda  r6
                plo  r9
                ; now copy bitmap size via ptr to size in buffer
                lda  r9             ; get hi byte of size
                phi  r7             ; put in r7
                ldn  r9             ; get lo byte of size
                plo  r7             ; bitmap size is now in r7
            
                ; write bitmap data to vram
                ldi  V_WRITE_DATA
                CALL O_VIDEO   
                rtn  
                endp          

; -----------------------------------------------------------
; Send RLE bitmap data to vdp Pattern Table
; Inputs:
;   dw (inline) - ptr to RLE compressed bitmap data buffer
;   dw (inline) - ptr to buffer with compressed data size 
; -----------------------------------------------------------
                proc sendRleBmapData
                call setAddress
                dw V_BITMAP_PATTERN   ; set VDP write address

                ; point r8 to data buffer
                lda  r6
                phi  r8
                lda  r6
                plo  r8
                ; now we copy ptr to data size
                lda  r6
                phi  r9
                lda  r6
                plo  r9
                ; now copy bitmap size via ptr to size in buffer
                lda  r9             ; get hi byte of size
                phi  r7             ; put in r7
                ldn  r9             ; get lo byte of size
                plo  r7             ; bitmap size is now in r7
            
                ; write bitmap data to vram
                ldi  V_WRITE_RLE
                CALL O_VIDEO   
                rtn           
                endp 

; -----------------------------------------------------------
; Send color map data to vdp Color Table
; Inputs:
;   dw (inline) - ptr to color map data buffer
;   dw (inline) - ptr to buffer with color map data size
; -----------------------------------------------------------
                proc sendCmapData
                call setAddress
                dw V_COLOR_TABLE    ; set VDP write address

                ; point r8 to data buffer
                lda  r6
                phi  r8
                lda  r6
                plo  r8
                ; now we copy ptr to data size
                lda  r6
                phi  r9
                lda  r6
                plo  r9
                ; now copy bitmap size via ptr to size in buffer
                lda  r9             ; get hi byte of size
                phi  r7             ; put in r7
                ldn  r9             ; get lo byte of size
                plo  r7             ; bitmap size is now in r7
            
                ; write bitmap data to vram
                ldi  V_WRITE_DATA
                CALL O_VIDEO   
                rtn            
                endp 

; -----------------------------------------------------------
; Send color map RLE compressed data to vdp Color Table 
; Inputs:
;   dw (inline) - ptr to color map RLE compressed data buffer
;   dw (inline) - ptr to buffer with compressed data size
; -----------------------------------------------------------
                proc sendRleCmapData
                call setAddress
                dw V_COLOR_TABLE   ; set VDP write address

                ; point r8 to data buffer
                lda  r6
                phi  r8
                lda  r6
                plo  r8
                ; now we copy ptr to data size
                lda  r6
                phi  r9
                lda  r6
                plo  r9
                ; now copy bitmap size via ptr to size in buffer
                lda  r9             ; get hi byte of size
                phi  r7             ; put in r7
                ldn  r9             ; get lo byte of size
                plo  r7             ; bitmap size is now in r7
            
                ; write bitmap data to vram
                ldi  V_WRITE_RLE
                CALL O_VIDEO   
                rtn
                endp     
    
;----------------------------------------------------------------------
; Set Graphics 2 Mode x,y position from character coords (1..31,0..23)
; Inputs: 
;   db x, db y (inline) 
;----------------------------------------------------------------------
                proc setG2CharXY
                lda  r6
                plo  r9            ; X
                lda  r6
                phi  r9            ; Y

                ; multiply column (y) and add row (x) to get address offset
                ; ofs = 256*y + 8*x since we have 32 8bit chars per line
            
                mov  r8, 0
                mov  r7, mpy256Table
                ghi  r9            ; the Y coord
                shl                ; dw (16 bit) values in table; skip by 2
                plo  r8
                call ADD16         ; r7 now points to address of 256*Y
                lda  r7
                phi  r8
                ldn  r7
                plo  r8            ; r8 is 256*Y

                mov  r7, 0
                glo  r9            ; the X coord
                shl
                shl
                shl                ; 8*X
                plo  r7
                call ADD16         ; r7 is address 256*y + 8*x

                ; add VDP bit 14 offset 
                mov  r8, V_BITMAP_PATTERN ; 4000h is VDP address 0000h
                call ADD16                ; r7 = 256*y + 8*x + 4000h

                ; send address r7 to VDP
                ldi  V_SET_ADDRESS
                call O_VIDEO 
                rtn
;--------------------------------------------------------------
;  Multiply by 256 table for starting address of rows 0..23
;--------------------------------------------------------------            
mpy256Table:    dw     0,  256,  512,  768, 1024, 1280, 1536, 1792,
                dw  2048, 2304, 2560, 2816, 3072, 3328, 3584, 3840,
                dw  4096, 4352, 4608, 4864, 5120, 5376, 5632, 5888
                endp 

;----------------------------------------------------------------------
; Draw a text string at an x,y position in graphics II mode
; Inputs:
;   rf - pointer to null terminated string
;----------------------------------------------------------------------
              proc drawG2String
              mov  r7, 0
              lda  rf             ; ascii code charIdx
              lbz  EXIT_DS        ; null terminates string
#ifdef TI99_FONT
              smi  32             ; TI99 character offset
#endif
            ; calc address of character data
            ; address is A0 + charIdx * 8
              plo  r8             ; r8.0 has charIdx
              ldi  8
              phi  r8             ; r8.1 is 8
              call MULT8          ; r7 has charIdx * 8

            ; start of character block A0
              mov  r8, VDP_CHARSET
              call ADD16          ; r7 <- r7+r8

              mov  r9, 8          ; number of bytes per character
L_NEXT:       lda  r7             ; get byte and advance
              plo  r8
              ldi  V_WRITE_BYTE
              call O_VIDEO
              dec  r9
              glo  r9
              lbnz L_NEXT
              lbr  drawG2String   ; process next character in string  
EXIT_DS:      rtn
              endp        
