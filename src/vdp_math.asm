#include    include/bios.inc
#include    include/kernel.inc
#include    include/ops.inc
#include    include/vdp.inc
#include    include/charset.inc

;--------------------------------------------------------------
; Math primitives
;--------------------------------------------------------------
                
;--------------------------------------------------------------
; ADD16:       DOUBLE PRECISION ADDITION
; Author:      Tom Swan
;--------------------------------------------------------------
; INPUT:   --  r7, r8
;
; OUTPUT:  --  r7 <-- r7 + r8 using double precision
;              DF indicates if overflow occurred
;--------------------------------------------------------------
            proc ADD16
            glo  r7            ; Get low byte operand #1
            str  r2            ; Push onto stack @ M(R(2))
            glo  r8            ; Get low byte operand #2
            add                ; Add to byte on stack via R(X)
            plo  r7            ; Put result in r7.0
            ghi  r7            ; Get high byte operand #1
            str  r2            ; Push onto stack @ M(R(2))
            ghi  r8            ; Get high byte operand #2
            adc                ; Add with possible carry to M(R(X))
            phi  r7            ; Put result in r7.1
            rtn                ; Return from subroutine
            endp

;--------------------------------------------------------------
;  MULT8:       MULTIPLY ROUTINE
;  Author:      Tom Swan
;--------------------------------------------------------------
;  INPUT:       r8.1 = multiplier
;               r8.0 = multiplicand
;
;  OUTPUT:   -- r7 = r8.0 x r8.1 using bit shifting
;
;  CHANGES:  -- r7 r8
;--------------------------------------------------------------
            proc MULT8
            ldi  0             ; Load 00 byte into D
            phi  r7            ; Put in r7.1 to initialize answer 
            glo  r8            ; Get multiplicand in r8.0
            str  r2            ; Push onto stack @ M(R(2))
            ldi  8             ; Load 08 into D
            plo  r8            ; Put in r8.0 as a loop count (old 
                               ; r8.0 on stack)
L1:         ghi  r8            ; Get multiplier from r8.1
            shr                ; Shift LSB into DF

            phi  r8            ; Put shifted value back in r8.1 
            ghi  r7            ; Get high byte of answer into D 
            lbnf SKIP          ; If DF = 0 then jump to skip 
                               ; next instruction
            add                ; Add multiplicand on stack to 
                               ; D on DF =1
SKIP:       shrc               ; Shift D right with carry
            phi  r7            ; Put in r7.2, high byte of answer 
            glo  r7            ; Get low byte of answer from RE.0 
            shrc               ; Shift with possible carry
            plo  r7            ; Put in r7.0 now double precision 
                               ; shifted right
            dec  r8            ; Decrement loop count in r8.0 
            glo  r8            ; Get loop count to test value 
            lbnz L1            ; If !=0, loop to test all eight 
                               ; bits of multiplier
            rtn                ; Return. 16 bit answer in r7
            endp 
                
;--------------- End of math primitives ------------------------
