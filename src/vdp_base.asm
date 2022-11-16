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
#include    include/bios.inc
#include    include/kernel.inc
#include    include/ops.inc
#include    include/vdp.inc

.list
.symbols
;--------------------------------------------------------------
; Base TMS9x18 driver functions
;--------------------------------------------------------------

; -------------------------------------------------------------------
; check to see if video driver is loaded in memory
; Inputs: (none)
; Outputs: DF = 0 if loaded (okay), DF = 1 if not loaded (error) 
; -------------------------------------------------------------------
            proc checkVideo 
            LOAD r7, O_VIDEO    ; check if video driver is  loaded 
            lda  r7             ; get the vector long jump command
            smi  0C0h           ; if not long jump, assume never loaded
            lbnz chk_bad            
            lda  r7             ; get hi byte of address
            smi  05h            ; check to see if points to Kernel return
            lbnz loaded         ; if not, assume driver is already loaded
            ldn  r7             ; get the lo byte of address
            smi  01bh           ; check to see if points to kernel return 
            lbz  chk_bad        ; if so, driver is not loaded

loaded:     ldi  V_GET_VERSION  ; check version of driver 
            call O_VIDEO
            smi  13h            ; check for current version of driver
            lbdf chk_good       ; equal to or greater than 1.3 is okay

chk_bad:    ldi  0ffh           ; set DF flag to indicate not loaded
            lskp                ; skip to set DF flag                  
chk_good:   ldi  00h            ; clear DF flag to indicate loaded
            shl                 ; shift msb into DF flag
            rtn                
            endp
                
; -------------------------------------------------------------------
; Select the vdp address with a value inlined with code
; Inputs:
;   dw (inline) - address to set             
; -------------------------------------------------------------------
            proc setAddress     
            lda  r6
            phi  r7
            lda  r6
            plo  r7               ; r7 has address from linkage
            ldi  V_SET_ADDRESS
            CALL O_VIDEO
            rtn
            endp
                 
; -----------------------------------------------------------
; Read VDP status byte
; Returns:  D with status byte
; -----------------------------------------------------------           
            proc readStatus
            ldi  V_READ_STATUS  ; READ VDP status, D holds status byte
            call O_VIDEO
            rtn
            endp                 
            
; -------------------------------------------------------------------
; Set expansion group for video card
; Inputs: (none)
; -------------------------------------------------------------------
            proc setGroup
            ; Set up the Expansion Group for video card
            ldi  V_SET_GROUP       
            call O_VIDEO
            rtn
            endp
          
; -------------------------------------------------------------------
; Reset expansion group to default
; Inputs: (none)
; -------------------------------------------------------------------
            proc resetGroup
            ; Set up the Expansion Group for video card
            ldi  V_RESET_GROUP     
            call O_VIDEO
            rtn
            endp        

                              
