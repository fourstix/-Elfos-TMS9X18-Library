#include    include/bios.inc
#include    include/kernel.inc
#include    include/ops.inc
#include    include/vdp.inc
#include    include/charset.inc

            extrn setAddress
            extrn VDP_CHARSET

;--------------------------------------------------------------
; Initialization functions
;--------------------------------------------------------------
                
; -------------------------------------------------------------------            
; Clear the VDP VRAM memory
; Input: (none) - clears all 16K bytes of memory 
; -------------------------------------------------------------------
            proc clearMem     
            call setAddress       ; clear the vram
            dw   V_VDP_MEMORY     ;set VDP write address to 0000h            
          
            load r7, 4000h        ; set size for 16k memory
            ldi  0h               ; use zero to clear video memory
            plo  r8               ; put fill byte in r8.0
            ldi  V_FILL_VRAM
            call O_VIDEO          ; clear video memory  
            rtn
            endp
        
; -------------------------------------------------------------------
; Initialize the 8 VDP registers
; Inputs:
;   dw (inline) - ptr to vreg data buffer (8 bytes)
; -------------------------------------------------------------------
            proc initRegs
            lda  r6                 ; initialize the video registers
            phi  r8
            lda  r6
            plo  r8
            ldi  80h
            plo  r7                 ; set initial value of vreg               
next_reg:   lda  r8
            phi  r7                 ; put value into r7.1
            ldi  V_WRITE_VREG
            call O_VIDEO
            inc  r7
            glo  r7
            smi  88h
            lbnz next_reg
            rtn
            endp
                                                                        
; -------------------------------------------------------------------
; Initialize character set data in the text Pattern Table
; Inputs: (none)
; -------------------------------------------------------------------
            proc initCharset
            call setAddress
            dw   V_CHAR_PATTERN   ; set VDP write address
     
            ; now we copy font data to Pattern table
            load  r8, VDP_CHARSET
            
            ; r7 is number of bytes to transfer
            load r7, VDP_CHARSET_SIZE*8     ; 8 bytes per character 
            ldi  V_WRITE_DATA
            CALL O_VIDEO
            rtn
            endp
            
