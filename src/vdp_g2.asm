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
                extrn setG2BmapAddr
                extrn setG2CmapAddr
                extrn updateG2Idx
                extrn putG2String
                extrn putG2Char
                extrn getInfo
                extrn setInfo
  

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
                                 
                ; Default VDP register settings for graphics II mode
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
; Update VDP register VR0 to update display in graphics mode 2
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
;   dw (inline) - ptr to buffer with coloar map data size
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
; Set Graphics 2 Mode x,y position from character coords (0..31,0..23)
; Inputs: 
;   r9.0 = x byte
;   r9.1 = y byte 
; Uses:
;   r7, r8 - scratch registers
;----------------------------------------------------------------------
                proc setG2CharXY  
                push r9
                ldi  V_GET_INFO ; set r7 and r8 with previous values
                call O_VIDEO              
                pop  r9
                ; multiply column (y) and add row (x) to get address offset
                ; offset = 256*y + 8*x since we have 32 8-bit chars per line
                ghi  r9         ; the Y coord
                phi  r7         ; r7 has 256*Y
                glo  r9         ; the X coord
                shl             ; shift three times to multiply by 8
                shl
                shl         
                plo  r7         ; r7 is address 256*y + 8*x

                ldi  V_SET_INFO ; save r7 as index, r8 with previous value
                call O_VIDEO              
                rtn
                endp
              
;----------------------------------------------------------------------
; Get character x,y coords (0..31,0..23) Graphics 2 Mode position index 
; Outputs: 
;   r9.0 = x byte
;   r9.1 = y byte 
; Uses:
;   r7, r8 - scratch registers
;----------------------------------------------------------------------
                proc getG2CharXY
                ; hi byte has y value in its lowest 5 bits  (y*32*8)
                ; shift low byte 3 times, then lowest 5 bits is x  
                ldi  V_GET_INFO   ; get index in r7              
                call O_VIDEO
                
                ghi  r7           ; get hi byte with y value
                ani  01Fh         ; mask off y value
                phi  r9           ; save char y for return
                
                glo   r7          ; get lo byte 
                shr               ; shfit three times to convert to char x
                shr 
                shr               ; no need to mask since shift zero fills                
                plo   r9          ; save char x for return              
                rtn
                endp
                
;----------------------------------------------------------------------
; Update Graphics 2 position index with offset, if the new position
; exceeds the maximum buffer size, the index wraps around to the top.
;
; Inputs:
;   r9 - offset to add to current position index 
; Uses:
;   r7 - position index
;   r8 - scratch register
;----------------------------------------------------------------------
                proc updateG2Idx    
                push r9             ; save byte count on stack
                ldi  V_GET_INFO     ; get index in r7, color info in R8
                call O_VIDEO            
                pop  r9             ; get byte count from stack
                push r8             ; save color byte value on stack
                copy r9, r8         ; put byte count into r8 for add  
                call ADD16          ; r7 <-r7+r8 (index + offset)
                ghi  r7             ; check for roll-over
                smi  018h           ; 1800h is after the end of buffer
                lbnf idx_ok         ; negative means inside buffer
                ldi  0h             ; wrap index to top of buffer
                phi  r7                
idx_ok:         pop  r8             ; restore color byte for save
                ldi  V_SET_INFO     ; store updated index
                call O_VIDEO  
                rtn
                endp
  
                
;----------------------------------------------------------------------
; Set Graphics 2 bitmap address from position index  
; Uses:
;   r7, r8 - scratch registers for calculating address
;----------------------------------------------------------------------
                proc setG2BmapAddr  
                ldi   V_GET_INFO   ; get index in r7
                call  O_VIDEO
              
                ; add VDP bit 14 offset 
                mov  r8, 4000h     ; 4000h is VDP address 0000h (Bitmap)
                call ADD16         ; r7 = index + 4000h

                ; send address r7 to VDP
                ldi  V_SET_ADDRESS
                call O_VIDEO 
                rtn
                endp

;----------------------------------------------------------------------
; Set Graphics 2 color map address from position index  
; Uses:
;   r7, r8 - scratch registers for calculating address
;----------------------------------------------------------------------
                proc setG2CmapAddr  
                ldi   V_GET_INFO   ; get index in r7
                call  O_VIDEO
              
                ; add VDP bit 14 offset 
                mov  r8, 6000h     ; 6000h is VDP address 2000h (Color map)
                call ADD16         ; r7 = index + 6000h

                ; send address r7 to VDP
                ldi  V_SET_ADDRESS
                call O_VIDEO 
                rtn
                endp

;--------------------------------------------------------------------------
; Put characters from a text buffer at an x,y position in graphics II mode. 
; Used by drawG2Char and drawG2ColorChar
; Inputs:
;   D   - character to draw
; Uses:
;   r7, r8 - scratch registers
; Outputs:
;--------------------------------------------------------------------------              
                proc putG2Char    
                stxd                ; save character on stack
                call setG2BmapAddr
                irx                 ; get character from stack
                ldx                 ; ascii code in D              
              
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

                ldi  8              ; number of bytes per character
                phi  r8             ; put count in r8.1
PC_NEXT:        lda  r7             ; get byte and advance
                plo  r8
                ldi  V_WRITE_BYTE
                call O_VIDEO
                ghi  r8             ; get character byte count
                smi  01
                phi  r8             ; put char byte count in r8.1
                lbnz PC_NEXT
PC_DONE:        rtn                 ; r9 is set with byte count
                endp 
              
;----------------------------------------------------------------------
; Put text string characters at an x,y position in graphics II mode. 
; Used by drawG2String and drawG2ColorString.
; Inputs:
;   rf - pointer to null terminated string
; Uses:
;   r7, r8 - scratch registers
; Outputs:
;   r9 - byte count written to VDP memory
;----------------------------------------------------------------------              
                proc putG2String  
                call setG2BmapAddr
                mov  r9, 0          ; set up byte count              

PS_CHAR:        mov  r7, 0
                lda  rf             ; ascii code charIdx
                lbz  PS_DONE        ; null terminates string
#ifdef TI99_CHARSET
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

                ldi  8              ; number of bytes per character
                phi  r8             ; put count in r8.1
PS_NEXT:        lda  r7             ; get byte and advance
                plo  r8
                ldi  V_WRITE_BYTE
                call O_VIDEO
                inc  r9             ; bump count of bytes written
                ghi  r8             ; get character byte count
                smi  01
                phi  r8             ; put char byte count in r8.1
                lbnz PS_NEXT
                lbr  PS_CHAR        ; process next character in string              
PS_DONE:        rtn                 ; r9 is set with byte count
                endp

;----------------------------------------------------------------------
; Draw a text string at an x,y position in graphics II mode
; Inputs:
;   rf - pointer to null terminated string
; Uses:
;   r7, r8 - scratch registers
;   r9 - byte count written to VDP memory
;----------------------------------------------------------------------
                proc drawG2String 
                call putG2String    ; draw the string characters
                call updateG2Idx    ; update position index              
                rtn                           
                endp 
              
;----------------------------------------------------------------------
; Draw a text string at an x,y position in graphics II mode and update 
; the color map.
; Inputs:
;    D - color byte for color map
;   rf - pointer to null terminated string
; Uses: 
;   r7, r8 - scratch registers
;   r9 - byte count written to VDP memory
;----------------------------------------------------------------------
                proc drawG2ColorString 
                stxd                ; save color map byte on the stack
                call putG2String    ; draw the string characters
                push r9             ; save r9 on stack
                call setG2CmapAddr  ; set the address for color map
                pop  r9
                COPY r9, r7         ; put byte count in r7 
                irx                 ; move stack ptr to color byte
                ldx                 ; get color byte from stack
                plo  r8             ; set r8.0 to color byte
                
                ldi  V_FILL_VRAM    ; write color bytes to color map
                call O_VIDEO

                ; byte count is in r9
                call updateG2Idx         ; update position index     
                rtn                           
                endp

;----------------------------------------------------------------------
; Draw a character at an x,y position in graphics II mode
; Inputs:
;   D - character to draw
; Uses: 
;   r7, r8 - scratch registers
;   r9 - byte count
;----------------------------------------------------------------------
                proc drawG2Char   
                call putG2Char    ; draw the string characters

                LOAD r9, 008h     ; each character is 8 bytes
                call updateG2Idx  ; update the position index                                   
                rtn          
                endp                  

;----------------------------------------------------------------------
; Draw characters in a buffer at an x,y position in graphics II mode
; and update the color map.
; Inputs:
;    D - character to draw
; Uses: 
;   r7, r8 - scratch registers
;   r9 - byte count
;----------------------------------------------------------------------
                proc drawG2ColorChar
                call putG2Char      ; draw the character
            
                call setG2CmapAddr  ; set the color map address
                ldi  V_GET_INFO     ; get color information
                call O_VIDEO        ; r8.0 has current color byte
                  
                LOAD r7, 008h       ; fill 8 bytes per character      
                ldi  V_FILL_VRAM    ; write color byte to color map
                call O_VIDEO

                LOAD r9, 008h       ; each character is 8 bytes
                call updateG2Idx    ; update position index
                rtn
                endp                            

;----------------------------------------------------------------------
; Clear the user data values
;
; Uses:
;   r7, r8 - scratch registers
;----------------------------------------------------------------------
                proc clearInfo
                ldi 0h       ; clear scratch regisers
                phi r7
                plo r7
                phi r8
                plo r8
                ldi  V_SET_INFO   ; save scratch registers
                call O_VIDEO
                rtn
                endp
                
;----------------------------------------------------------------------
; Get the user data values
;
; Outputs:
;   r7, r8 - scratch registers with user data saved in memory
;----------------------------------------------------------------------
                proc getInfo
                ldi  V_GET_INFO   ; save scratch registers in memory
                call O_VIDEO
                rtn
                endp              

;----------------------------------------------------------------------
; Set the user data values
;
; Inputs:
;   r7, r8 - scratch registers with user data to save
;----------------------------------------------------------------------
                proc setInfo
                ldi  V_SET_INFO   ; get scratch registers from memory
                call O_VIDEO
                rtn
                endp
               
                                
;--------------------------------------------------------------------------
; Erase a line of characters in graphics II mode. Each line has 32
; characters of 8 bytes each.  This function does not change the index.
;
; Uses: 
;   r7, r8 - scratch registers
;--------------------------------------------------------------------------
                proc blankG2Line
                call getInfo        ; get color info from user data
                glo  r8             ; get current color byte
                stxd                ; save color byte on the stack 
                call setG2BmapAddr  ; set address for pattern byte
                
                ldi  0h             ; transparent pattern for blank
                plo  r8             ; set r8.0 to blank pattern
                LOAD r7, 100h       ; clear line (32 x 8 bytes per line)      
                ldi  V_FILL_VRAM    ; write pattern byte to bitmap
                call O_VIDEO

                call setG2CmapAddr  ; update color map with current color
                irx                 ; move stack ptr to color byte
                ldx                 ; get color byte from stack
                plo  r8             ; set r8.0 to color byte
                LOAD r7, 100h       ; fill 256 (32 x 8) bytes per line      
                ldi  V_FILL_VRAM    ; write color byte to color map
                call O_VIDEO
                rtn 
                endp 
              
;--------------------------------------------------------------------------
; Erase the entire screen in graphics II mode. This function resets the 
; position index to home (zero).
;
; Uses: 
;   r7, r8, r9 - scratch registers
;--------------------------------------------------------------------------
                proc blankG2Screen
                call getInfo        ; get color info from user data
                LOAD r7, 0000h      ; set xy location to home
                call setInfo        ; save updated info            
                glo  r8             ; get current color byte
                stxd                ; save color byte on the stack 
                call setG2BmapAddr  ; set address for pattern byte
              
                ldi  0h             ; transparent pattern for blank
                plo  r8             ; set r8.0 to blank pattern
                LOAD r7, 1800h      ; clear all 6144 bytes      
                ldi  V_FILL_VRAM    ; write pattern byte to bitmap
                call O_VIDEO

                call setG2CmapAddr  ; update color map with current color
                irx                 ; move stack ptr to color byte
                ldx                 ; get color byte from stack
                plo  r8             ; set r8.0 to color byte
                LOAD r7, 1800h      ; fill 6144 bytes      
                ldi  V_FILL_VRAM    ; write color byte to color map
                call O_VIDEO
                rtn 
                endp
                
;----------------------------------------------------------------------
; Invert color
;
; Inputs:
;   r7, r8 - scratch registers with user data
;----------------------------------------------------------------------
                proc invertColor
                ldi  V_GET_INFO   ; get color info from memory
                call O_VIDEO
                glo  r8           ; get current color byte in r8.0
                shl               ; move bg color to fg nibble 
                shl               ; and fill bg nibble with 0's
                shl 
                shl               ; D has fg nibble ffff0000
                str  r2           ; save fg nibble at M(X)
                glo  r8           ; move fg color to bg nibble
                shr               ; and fill fg nibble with 0's
                shr
                shr
                shr               ; D has bg nibble 0000bbbb
                or                ; OR fg and bg nibble values together
                plo  r8           ; save in r8 as current color
                ldi  V_SET_INFO   ; save color info in user data
                call O_VIDEO  
                rtn 
                endp 
                              
;----------------------------------------------------------------------
; Set color in user info
;
; Inputs:
;   D - color byte to set as current color
; Uses:
;   r7, r8 - scratch registers with user data
;----------------------------------------------------------------------
                proc setColor
                stxd              ; Save new color byte on stack
                ldi  V_GET_INFO   ; get color info from memory
                call O_VIDEO
                irx               ; get new color byte from stack
                ldx
                plo  r8           ; set as current color
                ldi  V_SET_INFO   ; save color info in user data
                call O_VIDEO
                rtn
                endp 
                              
;----------------------------------------------------------------------
; Reset color to default value
;
; Uses:
;   r7, r8 - scratch registers with user data
;----------------------------------------------------------------------
                proc resetColor
                ldi  V_GET_INFO   ; get color info from memory
                call O_VIDEO
                ghi  r8           ; get default color byte from r8.1
                plo  r8           ; set as current color in r8.0
                ldi  V_SET_INFO   ; save color info in user data
                call O_VIDEO
                rtn
                endp  
