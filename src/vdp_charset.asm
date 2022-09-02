#include    include/bios.inc
#include    include/kernel.inc
#include    include/ops.inc
#include    include/vdp.inc
#include    include/charset.inc

;--------------------------------------------------------------
; Font definitions for TMS9x18 character set 
;--------------------------------------------------------------

                proc VDP_CHARSET
#ifdef TI99_FONT
            ; TI99 symbols and upper case                 ; note index is -32!
            db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h,  ; Char000  space
            db 010h, 010h, 010h, 010h, 010h, 000h, 010h, 000h,  ; Char001  !
            db 028h, 028h, 028h, 000h, 000h, 000h, 000h, 000h,  ; Char002  dbl quotes
            db 028h, 028h, 07ch, 028h, 07ch, 028h, 028h, 000h,  ; Char003  #
            db 038h, 054h, 050h, 038h, 014h, 054h, 038h, 000h,  ; Char004  $
            db 060h, 064h, 008h, 010h, 020h, 04ch, 00ch, 000h,  ; Char005  %
            db 020h, 050h, 050h, 020h, 054h, 048h, 034h, 000h,  ; Char006  &
            db 008h, 008h, 010h, 000h, 000h, 000h, 000h, 000h,  ; Char007  '
            db 008h, 010h, 020h, 020h, 020h, 010h, 008h, 000h,  ; Char008  (
            db 020h, 010h, 008h, 008h, 008h, 010h, 020h, 000h,  ; Char009  )
            db 000h, 028h, 010h, 07ch, 010h, 028h, 000h, 000h,  ; Char010  *
            db 000h, 010h, 010h, 07ch, 010h, 010h, 000h, 000h,  ; Char011  +
            db 000h, 000h, 000h, 000h, 030h, 010h, 020h, 000h,  ; Char012  ,
            db 000h, 000h, 000h, 07ch, 000h, 000h, 000h, 000h,  ; Char013  -
            db 000h, 000h, 000h, 000h, 000h, 030h, 030h, 000h,  ; Char014  .
            db 000h, 004h, 008h, 010h, 020h, 040h, 000h, 000h,  ; Char015  /
            db 038h, 044h, 044h, 044h, 044h, 044h, 038h, 000h,  ; Char016  0
            db 010h, 030h, 010h, 010h, 010h, 010h, 038h, 000h,  ; Char017  1
            db 038h, 044h, 004h, 008h, 010h, 020h, 07ch, 000h,  ; Char018  2
            db 038h, 044h, 004h, 018h, 004h, 044h, 038h, 000h,  ; Char019  3
            db 008h, 018h, 028h, 048h, 07ch, 008h, 008h, 000h,  ; Char020  4
            db 07ch, 040h, 078h, 004h, 004h, 044h, 038h, 000h,  ; Char021  5
            db 018h, 020h, 040h, 078h, 044h, 044h, 038h, 000h,  ; Char022  6
            db 07ch, 004h, 008h, 010h, 020h, 020h, 020h, 000h,  ; Char023  7
            db 038h, 044h, 044h, 038h, 044h, 044h, 038h, 000h,  ; Char024  8
            db 038h, 044h, 044h, 03ch, 004h, 008h, 030h, 000h,  ; Char025  9
            db 000h, 030h, 030h, 000h, 030h, 030h, 000h, 000h,  ; Char026  :
            db 000h, 030h, 030h, 000h, 030h, 010h, 020h, 000h,  ; Char027  ;
            db 008h, 010h, 020h, 040h, 020h, 010h, 008h, 000h,  ; Char028  <
            db 000h, 000h, 07ch, 000h, 07ch, 000h, 000h, 000h,  ; Char029  =
            db 020h, 010h, 008h, 004h, 008h, 010h, 020h, 000h,  ; Char030  >
            db 038h, 044h, 004h, 008h, 010h, 000h, 010h, 000h,  ; Char031  ?
            db 038h, 044h, 05ch, 054h, 05ch, 040h, 038h, 000h,  ; Char032  @
            db 038h, 044h, 044h, 07ch, 044h, 044h, 044h, 000h,  ; Char033  A
            db 078h, 024h, 024h, 038h, 024h, 024h, 078h, 000h,  ; Char034  B
            db 038h, 044h, 040h, 040h, 040h, 044h, 038h, 000h,  ; Char035  C
            db 078h, 024h, 024h, 024h, 024h, 024h, 078h, 000h,  ; Char036  D
            db 07ch, 040h, 040h, 078h, 040h, 040h, 07ch, 000h,  ; Char037  E
            db 07ch, 040h, 040h, 078h, 040h, 040h, 040h, 000h,  ; Char038  F
            db 03ch, 040h, 040h, 05ch, 044h, 044h, 038h, 000h,  ; Char039  G
            db 044h, 044h, 044h, 07ch, 044h, 044h, 044h, 000h,  ; Char040  H
            db 038h, 010h, 010h, 010h, 010h, 010h, 038h, 000h,  ; Char041  I
            db 004h, 004h, 004h, 004h, 004h, 044h, 038h, 000h,  ; Char042  J
            db 044h, 048h, 050h, 060h, 050h, 048h, 044h, 000h,  ; Char043  K
            db 040h, 040h, 040h, 040h, 040h, 040h, 07ch, 000h,  ; Char044  L
            db 044h, 06ch, 054h, 054h, 044h, 044h, 044h, 000h,  ; Char045  M
            db 044h, 064h, 064h, 054h, 04ch, 04ch, 044h, 000h,  ; Char046  N
            db 07ch, 044h, 044h, 044h, 044h, 044h, 07ch, 000h,  ; Char047  O
            db 078h, 044h, 044h, 078h, 040h, 040h, 040h, 000h,  ; Char048  P
            db 038h, 044h, 044h, 044h, 054h, 048h, 034h, 000h,  ; Char049  Q
            db 078h, 044h, 044h, 078h, 050h, 048h, 044h, 000h,  ; Char050  R
            db 038h, 044h, 040h, 038h, 004h, 044h, 038h, 000h,  ; Char051  S
            db 07ch, 010h, 010h, 010h, 010h, 010h, 010h, 000h,  ; Char052  T
            db 044h, 044h, 044h, 044h, 044h, 044h, 038h, 000h,  ; Char053  U
            db 044h, 044h, 044h, 028h, 028h, 010h, 010h, 000h,  ; Char054  V
            db 044h, 044h, 044h, 054h, 054h, 054h, 028h, 000h,  ; Char055  W
            db 044h, 044h, 028h, 010h, 028h, 044h, 044h, 000h,  ; Char056  X
            db 044h, 044h, 028h, 010h, 010h, 010h, 010h, 000h,  ; Char057  Y
            db 07ch, 004h, 008h, 010h, 020h, 040h, 07ch, 000h,  ; Char058  Z
            db 038h, 020h, 020h, 020h, 020h, 020h, 038h, 000h,  ; Char059  [
            db 000h, 040h, 020h, 010h, 008h, 004h, 000h, 000h,  ; Char060  \
            db 038h, 008h, 008h, 008h, 008h, 008h, 038h, 000h,  ; Char061  ]
            db 000h, 010h, 028h, 044h, 000h, 000h, 000h, 000h,  ; Char062  ^
            db 000h, 000h, 000h, 000h, 000h, 000h, 07ch, 000h,  ; Char063  _
            db 000h, 020h, 010h, 008h, 000h, 000h, 000h, 000h,  ; Char064  `
                ; TI99 lower case
            db 000h, 000h, 038h, 044h, 07ch, 044h, 044h, 000h,  ; Char065  a
            db 000h, 000h, 078h, 024h, 038h, 024h, 078h, 000h,  ; Char066  b
            db 000h, 000h, 03ch, 040h, 040h, 040h, 03ch, 000h,  ; Char067  c
            db 000h, 000h, 078h, 024h, 024h, 024h, 078h, 000h,  ; Char068  d
            db 000h, 000h, 07ch, 040h, 078h, 040h, 07ch, 000h,  ; Char069  e
            db 000h, 000h, 07ch, 040h, 078h, 040h, 040h, 000h,  ; Char070  f
            db 000h, 000h, 03ch, 040h, 05ch, 044h, 038h, 000h,  ; Char071  g
            db 000h, 000h, 044h, 044h, 07ch, 044h, 044h, 000h,  ; Char072  h
            db 000h, 000h, 038h, 010h, 010h, 010h, 038h, 000h,  ; Char073  i
            db 000h, 000h, 008h, 008h, 008h, 048h, 030h, 000h,  ; Char074  j
            db 000h, 000h, 024h, 028h, 030h, 028h, 024h, 000h,  ; Char075  k
            db 000h, 000h, 040h, 040h, 040h, 040h, 07ch, 000h,  ; Char076  l
            db 000h, 000h, 044h, 06ch, 054h, 044h, 044h, 000h,  ; Char077  m
            db 000h, 000h, 044h, 064h, 054h, 04ch, 044h, 000h,  ; Char078  n
            db 000h, 000h, 07ch, 044h, 044h, 044h, 07ch, 000h,  ; Char079  o
            db 000h, 000h, 078h, 044h, 078h, 040h, 040h, 000h,  ; Char080  p
            db 000h, 000h, 038h, 044h, 054h, 048h, 034h, 000h,  ; Char081  q
            db 000h, 000h, 078h, 044h, 078h, 048h, 044h, 000h,  ; Char082  r
            db 000h, 000h, 03ch, 040h, 038h, 004h, 078h, 000h,  ; Char083  s
            db 000h, 000h, 07ch, 010h, 010h, 010h, 010h, 000h,  ; Char084  t
            db 000h, 000h, 044h, 044h, 044h, 044h, 038h, 000h,  ; Char085  u
            db 000h, 000h, 044h, 044h, 028h, 028h, 010h, 000h,  ; Char086  v
            db 000h, 000h, 044h, 044h, 054h, 054h, 028h, 000h,  ; Char087  w
            db 000h, 000h, 044h, 028h, 010h, 028h, 044h, 000h,  ; Char088  x
            db 000h, 000h, 044h, 028h, 010h, 010h, 010h, 000h,  ; Char089  y
            db 000h, 000h, 07ch, 008h, 010h, 020h, 07ch, 000h,  ; Char090  z
            db 018h, 020h, 020h, 040h, 020h, 020h, 018h, 000h,  ; Char091  {
            db 010h, 010h, 010h, 000h, 010h, 010h, 010h, 000h,  ; Char092  |
            db 030h, 008h, 008h, 004h, 008h, 008h, 030h, 000h,  ; Char093  }
            db 000h, 020h, 054h, 008h, 000h, 000h, 000h, 000h   ; Char094  ~            
#endif
#ifdef CP437_FONT
            ; CP437 character set
            db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h,  ; Char000
            db 038h, 044h, 06ch, 044h, 054h, 044h, 038h, 000h,  ; Char001
            db 038h, 07ch, 054h, 07ch, 044h, 07ch, 038h, 000h,  ; Char002
            db 000h, 028h, 07ch, 07ch, 07ch, 038h, 010h, 000h,  ; Char003
            db 000h, 010h, 038h, 07ch, 07ch, 038h, 010h, 000h,  ; Char004
            db 010h, 038h, 038h, 010h, 07ch, 07ch, 010h, 000h,  ; Char005
            db 000h, 010h, 038h, 07ch, 07ch, 010h, 038h, 000h,  ; Char006
            db 000h, 000h, 000h, 030h, 030h, 000h, 000h, 000h,  ; Char007
            db 0fch, 0fch, 0fch, 0cch, 0cch, 0fch, 0fch, 0fch,  ; Char008
            db 000h, 000h, 078h, 048h, 048h, 078h, 000h, 000h,  ; Char009
            db 0fch, 0fch, 084h, 0b4h, 0b4h, 084h, 0fch, 0fch,  ; Char010
            db 000h, 01ch, 00ch, 034h, 048h, 048h, 030h, 000h,  ; Char011
            db 038h, 044h, 044h, 038h, 010h, 038h, 010h, 000h,  ; Char012
            db 010h, 018h, 014h, 010h, 030h, 070h, 060h, 000h,  ; Char013
            db 00ch, 034h, 02ch, 034h, 02ch, 06ch, 060h, 000h,  ; Char014
            db 000h, 054h, 038h, 06ch, 038h, 054h, 000h, 000h,  ; Char015
            db 020h, 030h, 038h, 03ch, 038h, 030h, 020h, 000h,  ; Char016
            db 008h, 018h, 038h, 078h, 038h, 018h, 008h, 000h,  ; Char017
            db 010h, 038h, 07ch, 010h, 07ch, 038h, 010h, 000h,  ; Char018
            db 028h, 028h, 028h, 028h, 028h, 000h, 028h, 000h,  ; Char019
            db 03ch, 054h, 054h, 034h, 014h, 014h, 014h, 000h,  ; Char020
            db 038h, 044h, 030h, 028h, 018h, 044h, 038h, 000h,  ; Char021
            db 000h, 000h, 000h, 000h, 000h, 078h, 078h, 000h,  ; Char022
            db 010h, 038h, 07ch, 010h, 07ch, 038h, 010h, 038h,  ; Char023
            db 010h, 038h, 07ch, 010h, 010h, 010h, 010h, 000h,  ; Char024
            db 010h, 010h, 010h, 010h, 07ch, 038h, 010h, 000h,  ; Char025
            db 000h, 010h, 018h, 07ch, 018h, 010h, 000h, 000h,  ; Char026
            db 000h, 010h, 030h, 07ch, 030h, 010h, 000h, 000h,  ; Char027
            db 000h, 000h, 000h, 040h, 040h, 040h, 07ch, 000h,  ; Char028
            db 000h, 028h, 028h, 07ch, 028h, 028h, 000h, 000h,  ; Char029
            db 010h, 010h, 038h, 038h, 07ch, 07ch, 000h, 000h,  ; Char030
            db 07ch, 07ch, 038h, 038h, 010h, 010h, 000h, 000h,  ; Char031
            db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h,  ; Char032
            db 010h, 038h, 038h, 010h, 010h, 000h, 010h, 000h,  ; Char033
            db 06ch, 06ch, 048h, 000h, 000h, 000h, 000h, 000h,  ; Char034
            db 000h, 028h, 07ch, 028h, 028h, 07ch, 028h, 000h,  ; Char035
            db 020h, 038h, 040h, 030h, 008h, 070h, 010h, 000h,  ; Char036
            db 064h, 064h, 008h, 010h, 020h, 04ch, 04ch, 000h,  ; Char037
            db 020h, 050h, 050h, 020h, 054h, 048h, 034h, 000h,  ; Char038
            db 030h, 030h, 020h, 000h, 000h, 000h, 000h, 000h,  ; Char039
            db 010h, 020h, 020h, 020h, 020h, 020h, 010h, 000h,  ; Char040
            db 020h, 010h, 010h, 010h, 010h, 010h, 020h, 000h,  ; Char041
            db 000h, 028h, 038h, 07ch, 038h, 028h, 000h, 000h,  ; Char042
            db 000h, 010h, 010h, 07ch, 010h, 010h, 000h, 000h,  ; Char043
            db 000h, 000h, 000h, 000h, 000h, 030h, 030h, 020h,  ; Char044
            db 000h, 000h, 000h, 07ch, 000h, 000h, 000h, 000h,  ; Char045
            db 000h, 000h, 000h, 000h, 000h, 030h, 030h, 000h,  ; Char046
            db 000h, 004h, 008h, 010h, 020h, 040h, 000h, 000h,  ; Char047
            db 038h, 044h, 04ch, 054h, 064h, 044h, 038h, 000h,  ; Char048
            db 010h, 030h, 010h, 010h, 010h, 010h, 038h, 000h,  ; Char049
            db 038h, 044h, 004h, 018h, 020h, 040h, 07ch, 000h,  ; Char050
            db 038h, 044h, 004h, 038h, 004h, 044h, 038h, 000h,  ; Char051
            db 008h, 018h, 028h, 048h, 07ch, 008h, 008h, 000h,  ; Char052
            db 07ch, 040h, 040h, 078h, 004h, 044h, 038h, 000h,  ; Char053
            db 018h, 020h, 040h, 078h, 044h, 044h, 038h, 000h,  ; Char054
            db 07ch, 004h, 008h, 010h, 020h, 020h, 020h, 000h,  ; Char055
            db 038h, 044h, 044h, 038h, 044h, 044h, 038h, 000h,  ; Char056
            db 038h, 044h, 044h, 03ch, 004h, 008h, 030h, 000h,  ; Char057
            db 000h, 000h, 030h, 030h, 000h, 030h, 030h, 000h,  ; Char058
            db 000h, 000h, 030h, 030h, 000h, 030h, 030h, 020h,  ; Char059
            db 008h, 010h, 020h, 040h, 020h, 010h, 008h, 000h,  ; Char060
            db 000h, 000h, 07ch, 000h, 000h, 07ch, 000h, 000h,  ; Char061
            db 020h, 010h, 008h, 004h, 008h, 010h, 020h, 000h,  ; Char062
            db 038h, 044h, 004h, 018h, 010h, 000h, 010h, 000h,  ; Char063
            db 038h, 044h, 05ch, 054h, 05ch, 040h, 038h, 000h,  ; Char064
            db 038h, 044h, 044h, 044h, 07ch, 044h, 044h, 000h,  ; Char065
            db 078h, 044h, 044h, 078h, 044h, 044h, 078h, 000h,  ; Char066
            db 038h, 044h, 040h, 040h, 040h, 044h, 038h, 000h,  ; Char067
            db 078h, 044h, 044h, 044h, 044h, 044h, 078h, 000h,  ; Char068
            db 07ch, 040h, 040h, 078h, 040h, 040h, 07ch, 000h,  ; Char069
            db 07ch, 040h, 040h, 078h, 040h, 040h, 040h, 000h,  ; Char070
            db 038h, 044h, 040h, 05ch, 044h, 044h, 03ch, 000h,  ; Char071
            db 044h, 044h, 044h, 07ch, 044h, 044h, 044h, 000h,  ; Char072
            db 038h, 010h, 010h, 010h, 010h, 010h, 038h, 000h,  ; Char073
            db 004h, 004h, 004h, 004h, 044h, 044h, 038h, 000h,  ; Char074
            db 044h, 048h, 050h, 060h, 050h, 048h, 044h, 000h,  ; Char075
            db 040h, 040h, 040h, 040h, 040h, 040h, 07ch, 000h,  ; Char076
            db 044h, 06ch, 054h, 044h, 044h, 044h, 044h, 000h,  ; Char077
            db 044h, 064h, 054h, 04ch, 044h, 044h, 044h, 000h,  ; Char078
            db 038h, 044h, 044h, 044h, 044h, 044h, 038h, 000h,  ; Char079
            db 078h, 044h, 044h, 078h, 040h, 040h, 040h, 000h,  ; Char080
            db 038h, 044h, 044h, 044h, 054h, 048h, 034h, 000h,  ; Char081
            db 078h, 044h, 044h, 078h, 048h, 044h, 044h, 000h,  ; Char082
            db 038h, 044h, 040h, 038h, 004h, 044h, 038h, 000h,  ; Char083
            db 07ch, 010h, 010h, 010h, 010h, 010h, 010h, 000h,  ; Char084
            db 044h, 044h, 044h, 044h, 044h, 044h, 038h, 000h,  ; Char085
            db 044h, 044h, 044h, 044h, 044h, 028h, 010h, 000h,  ; Char086
            db 044h, 044h, 054h, 054h, 054h, 054h, 028h, 000h,  ; Char087
            db 044h, 044h, 028h, 010h, 028h, 044h, 044h, 000h,  ; Char088
            db 044h, 044h, 044h, 028h, 010h, 010h, 010h, 000h,  ; Char089
            db 078h, 008h, 010h, 020h, 040h, 040h, 078h, 000h,  ; Char090
            db 038h, 020h, 020h, 020h, 020h, 020h, 038h, 000h,  ; Char091
            db 000h, 040h, 020h, 010h, 008h, 004h, 000h, 000h,  ; Char092
            db 038h, 008h, 008h, 008h, 008h, 008h, 038h, 000h,  ; Char093
            db 010h, 028h, 044h, 000h, 000h, 000h, 000h, 000h,  ; Char094
            db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 0fch,  ; Char095
            db 030h, 030h, 010h, 000h, 000h, 000h, 000h, 000h,  ; Char096
            db 000h, 000h, 038h, 004h, 03ch, 044h, 03ch, 000h,  ; Char097
            db 040h, 040h, 078h, 044h, 044h, 044h, 078h, 000h,  ; Char098
            db 000h, 000h, 038h, 044h, 040h, 044h, 038h, 000h,  ; Char099
            db 004h, 004h, 03ch, 044h, 044h, 044h, 03ch, 000h,  ; Char100
            db 000h, 000h, 038h, 044h, 078h, 040h, 038h, 000h,  ; Char101
            db 018h, 020h, 020h, 078h, 020h, 020h, 020h, 000h,  ; Char102
            db 000h, 000h, 03ch, 044h, 044h, 03ch, 004h, 038h,  ; Char103
            db 040h, 040h, 070h, 048h, 048h, 048h, 048h, 000h,  ; Char104
            db 010h, 000h, 010h, 010h, 010h, 010h, 018h, 000h,  ; Char105
            db 008h, 000h, 018h, 008h, 008h, 008h, 048h, 030h,  ; Char106
            db 040h, 040h, 048h, 050h, 060h, 050h, 048h, 000h,  ; Char107
            db 010h, 010h, 010h, 010h, 010h, 010h, 018h, 000h,  ; Char108
            db 000h, 000h, 068h, 054h, 054h, 044h, 044h, 000h,  ; Char109
            db 000h, 000h, 070h, 048h, 048h, 048h, 048h, 000h,  ; Char110
            db 000h, 000h, 038h, 044h, 044h, 044h, 038h, 000h,  ; Char111
            db 000h, 000h, 078h, 044h, 044h, 044h, 078h, 040h,  ; Char112
            db 000h, 000h, 03ch, 044h, 044h, 044h, 03ch, 004h,  ; Char113
            db 000h, 000h, 058h, 024h, 020h, 020h, 070h, 000h,  ; Char114
            db 000h, 000h, 038h, 040h, 038h, 004h, 038h, 000h,  ; Char115
            db 000h, 020h, 078h, 020h, 020h, 028h, 010h, 000h,  ; Char116
            db 000h, 000h, 048h, 048h, 048h, 058h, 028h, 000h,  ; Char117
            db 000h, 000h, 044h, 044h, 044h, 028h, 010h, 000h,  ; Char118
            db 000h, 000h, 044h, 044h, 054h, 07ch, 028h, 000h,  ; Char119
            db 000h, 000h, 048h, 048h, 030h, 048h, 048h, 000h,  ; Char120
            db 000h, 000h, 048h, 048h, 048h, 038h, 010h, 060h,  ; Char121
            db 000h, 000h, 078h, 008h, 030h, 040h, 078h, 000h,  ; Char122
            db 018h, 020h, 020h, 060h, 020h, 020h, 018h, 000h,  ; Char123
            db 010h, 010h, 010h, 000h, 010h, 010h, 010h, 000h,  ; Char124
            db 030h, 008h, 008h, 00ch, 008h, 008h, 030h, 000h,  ; Char125
            db 028h, 050h, 000h, 000h, 000h, 000h, 000h, 000h,  ; Char126
            db 010h, 038h, 06ch, 044h, 044h, 07ch, 000h, 000h,  ; Char127
            db 038h, 044h, 040h, 040h, 044h, 038h, 010h, 030h,  ; Char128
            db 048h, 000h, 048h, 048h, 048h, 058h, 028h, 000h,  ; Char129
            db 00ch, 000h, 038h, 044h, 078h, 040h, 038h, 000h,  ; Char130
            db 038h, 000h, 038h, 004h, 03ch, 044h, 03ch, 000h,  ; Char131
            db 028h, 000h, 038h, 004h, 03ch, 044h, 03ch, 000h,  ; Char132
            db 030h, 000h, 038h, 004h, 03ch, 044h, 03ch, 000h,  ; Char133
            db 038h, 028h, 038h, 004h, 03ch, 044h, 03ch, 000h,  ; Char134
            db 000h, 038h, 044h, 040h, 044h, 038h, 010h, 030h,  ; Char135
            db 038h, 000h, 038h, 044h, 078h, 040h, 038h, 000h,  ; Char136
            db 028h, 000h, 038h, 044h, 078h, 040h, 038h, 000h,  ; Char137
            db 030h, 000h, 038h, 044h, 078h, 040h, 038h, 000h,  ; Char138
            db 028h, 000h, 010h, 010h, 010h, 010h, 018h, 000h,  ; Char139
            db 010h, 028h, 000h, 010h, 010h, 010h, 018h, 000h,  ; Char140
            db 020h, 000h, 010h, 010h, 010h, 010h, 018h, 000h,  ; Char141
            db 028h, 000h, 010h, 028h, 044h, 07ch, 044h, 000h,  ; Char142
            db 038h, 028h, 038h, 06ch, 044h, 07ch, 044h, 000h,  ; Char143
            db 00ch, 000h, 07ch, 040h, 078h, 040h, 07ch, 000h,  ; Char144
            db 000h, 000h, 078h, 014h, 07ch, 050h, 03ch, 000h,  ; Char145
            db 03ch, 050h, 050h, 07ch, 050h, 050h, 05ch, 000h,  ; Char146
            db 038h, 000h, 030h, 048h, 048h, 048h, 030h, 000h,  ; Char147
            db 028h, 000h, 030h, 048h, 048h, 048h, 030h, 000h,  ; Char148
            db 060h, 000h, 030h, 048h, 048h, 048h, 030h, 000h,  ; Char149
            db 038h, 000h, 048h, 048h, 048h, 058h, 028h, 000h,  ; Char150
            db 060h, 000h, 048h, 048h, 048h, 058h, 028h, 000h,  ; Char151
            db 028h, 000h, 048h, 048h, 048h, 038h, 010h, 060h,  ; Char152
            db 048h, 030h, 048h, 048h, 048h, 048h, 030h, 000h,  ; Char153
            db 028h, 000h, 048h, 048h, 048h, 048h, 030h, 000h,  ; Char154
            db 000h, 010h, 038h, 040h, 040h, 038h, 010h, 000h,  ; Char155
            db 018h, 024h, 020h, 078h, 020h, 024h, 05ch, 000h,  ; Char156
            db 044h, 028h, 010h, 07ch, 010h, 07ch, 010h, 000h,  ; Char157
            db 060h, 050h, 050h, 068h, 05ch, 048h, 048h, 000h,  ; Char158
            db 008h, 014h, 010h, 038h, 010h, 010h, 050h, 020h,  ; Char159
            db 018h, 000h, 038h, 004h, 03ch, 044h, 03ch, 000h,  ; Char160
            db 018h, 000h, 010h, 010h, 010h, 010h, 018h, 000h,  ; Char161
            db 018h, 000h, 030h, 048h, 048h, 048h, 030h, 000h,  ; Char162
            db 018h, 000h, 048h, 048h, 048h, 058h, 028h, 000h,  ; Char163
            db 028h, 050h, 000h, 070h, 048h, 048h, 048h, 000h,  ; Char164
            db 028h, 050h, 000h, 048h, 068h, 058h, 048h, 000h,  ; Char165
            db 038h, 004h, 03ch, 044h, 03ch, 000h, 03ch, 000h,  ; Char166
            db 030h, 048h, 048h, 048h, 030h, 000h, 078h, 000h,  ; Char167
            db 010h, 000h, 010h, 030h, 040h, 044h, 038h, 000h,  ; Char168
            db 000h, 000h, 07ch, 040h, 040h, 040h, 000h, 000h,  ; Char169
            db 000h, 000h, 0fch, 004h, 004h, 000h, 000h, 000h,  ; Char170
            db 040h, 048h, 050h, 038h, 044h, 008h, 01ch, 000h,  ; Char171
            db 040h, 048h, 050h, 02ch, 054h, 01ch, 004h, 000h,  ; Char172
            db 010h, 000h, 010h, 010h, 038h, 038h, 010h, 000h,  ; Char173
            db 000h, 000h, 024h, 048h, 024h, 000h, 000h, 000h,  ; Char174
            db 000h, 000h, 048h, 024h, 048h, 000h, 000h, 000h,  ; Char175
            db 054h, 000h, 0a8h, 000h, 054h, 000h, 0a8h, 000h,  ; Char176
            db 054h, 0a8h, 054h, 0a8h, 054h, 0a8h, 054h, 0a8h,  ; Char177
            db 0a8h, 0fch, 054h, 0fch, 0a8h, 0fch, 054h, 0fch,  ; Char178
            db 010h, 010h, 010h, 010h, 010h, 010h, 010h, 010h,  ; Char179
            db 010h, 010h, 010h, 0f0h, 010h, 010h, 010h, 010h,  ; Char180
            db 010h, 0f0h, 010h, 0f0h, 010h, 010h, 010h, 010h,  ; Char181
            db 050h, 050h, 050h, 0d0h, 050h, 050h, 050h, 050h,  ; Char182
            db 000h, 000h, 000h, 0f0h, 050h, 050h, 050h, 050h,  ; Char183
            db 000h, 0f0h, 010h, 0f0h, 010h, 010h, 010h, 010h,  ; Char184
            db 050h, 0d0h, 010h, 0d0h, 050h, 050h, 050h, 050h,  ; Char185
            db 050h, 050h, 050h, 050h, 050h, 050h, 050h, 050h,  ; Char186
            db 000h, 0f0h, 010h, 0d0h, 050h, 050h, 050h, 050h,  ; Char187
            db 050h, 0d0h, 010h, 0f0h, 000h, 000h, 000h, 000h,  ; Char188
            db 050h, 050h, 050h, 0f0h, 000h, 000h, 000h, 000h,  ; Char189
            db 010h, 0f0h, 010h, 0f0h, 000h, 000h, 000h, 000h,  ; Char190
            db 000h, 000h, 000h, 0f0h, 010h, 010h, 010h, 010h,  ; Char191
            db 010h, 010h, 010h, 01ch, 000h, 000h, 000h, 000h,  ; Char192
            db 010h, 010h, 010h, 0fch, 000h, 000h, 000h, 000h,  ; Char193
            db 000h, 000h, 000h, 0fch, 010h, 010h, 010h, 010h,  ; Char194
            db 010h, 010h, 010h, 01ch, 010h, 010h, 010h, 010h,  ; Char195
            db 000h, 000h, 000h, 0fch, 000h, 000h, 000h, 000h,  ; Char196
            db 010h, 010h, 010h, 0fch, 010h, 010h, 010h, 010h,  ; Char197
            db 010h, 01ch, 010h, 01ch, 010h, 010h, 010h, 010h,  ; Char198
            db 050h, 050h, 050h, 05ch, 050h, 050h, 050h, 050h,  ; Char199
            db 050h, 05ch, 040h, 07ch, 000h, 000h, 000h, 000h,  ; Char200
            db 000h, 07ch, 040h, 05ch, 050h, 050h, 050h, 050h,  ; Char201
            db 050h, 0dch, 000h, 0fch, 000h, 000h, 000h, 000h,  ; Char202
            db 000h, 0fch, 000h, 0dch, 050h, 050h, 050h, 050h,  ; Char203
            db 050h, 05ch, 040h, 05ch, 050h, 050h, 050h, 050h,  ; Char204
            db 000h, 0fch, 000h, 0fch, 000h, 000h, 000h, 000h,  ; Char205
            db 050h, 0dch, 000h, 0dch, 050h, 050h, 050h, 050h,  ; Char206
            db 010h, 0fch, 000h, 0fch, 000h, 000h, 000h, 000h,  ; Char207
            db 050h, 050h, 050h, 0fch, 000h, 000h, 000h, 000h,  ; Char208
            db 000h, 0fch, 000h, 0fch, 010h, 010h, 010h, 010h,  ; Char209
            db 000h, 000h, 000h, 0fch, 050h, 050h, 050h, 050h,  ; Char210
            db 050h, 050h, 050h, 07ch, 000h, 000h, 000h, 000h,  ; Char211
            db 010h, 01ch, 010h, 01ch, 000h, 000h, 000h, 000h,  ; Char212
            db 000h, 01ch, 010h, 01ch, 010h, 010h, 010h, 010h,  ; Char213
            db 000h, 000h, 000h, 07ch, 050h, 050h, 050h, 050h,  ; Char214
            db 050h, 050h, 050h, 0dch, 050h, 050h, 050h, 050h,  ; Char215
            db 010h, 0fch, 000h, 0fch, 010h, 010h, 010h, 010h,  ; Char216
            db 010h, 010h, 010h, 0f0h, 000h, 000h, 000h, 000h,  ; Char217
            db 000h, 000h, 000h, 01ch, 010h, 010h, 010h, 010h,  ; Char218
            db 0fch, 0fch, 0fch, 0fch, 0fch, 0fch, 0fch, 0fch,  ; Char219
            db 000h, 000h, 000h, 000h, 0fch, 0fch, 0fch, 0fch,  ; Char220
            db 0e0h, 0e0h, 0e0h, 0e0h, 0e0h, 0e0h, 0e0h, 0e0h,  ; Char221
            db 01ch, 01ch, 01ch, 01ch, 01ch, 01ch, 01ch, 01ch,  ; Char222
            db 0fch, 0fch, 0fch, 0fch, 000h, 000h, 000h, 000h,  ; Char223
            db 000h, 000h, 034h, 048h, 048h, 034h, 000h, 000h,  ; Char224
            db 000h, 070h, 048h, 070h, 048h, 048h, 070h, 040h,  ; Char225
            db 078h, 048h, 040h, 040h, 040h, 040h, 040h, 000h,  ; Char226
            db 000h, 07ch, 028h, 028h, 028h, 028h, 028h, 000h,  ; Char227
            db 078h, 048h, 020h, 010h, 020h, 048h, 078h, 000h,  ; Char228
            db 000h, 000h, 03ch, 048h, 048h, 030h, 000h, 000h,  ; Char229
            db 000h, 000h, 048h, 048h, 048h, 070h, 040h, 040h,  ; Char230
            db 000h, 000h, 028h, 050h, 010h, 010h, 010h, 000h,  ; Char231
            db 038h, 010h, 038h, 044h, 038h, 010h, 038h, 000h,  ; Char232
            db 030h, 048h, 048h, 078h, 048h, 048h, 030h, 000h,  ; Char233
            db 000h, 038h, 044h, 044h, 028h, 028h, 06ch, 000h,  ; Char234
            db 030h, 040h, 020h, 010h, 038h, 048h, 030h, 000h,  ; Char235
            db 000h, 000h, 028h, 054h, 054h, 028h, 000h, 000h,  ; Char236
            db 000h, 010h, 038h, 054h, 054h, 038h, 010h, 000h,  ; Char237
            db 000h, 038h, 040h, 078h, 040h, 038h, 000h, 000h,  ; Char238
            db 000h, 030h, 048h, 048h, 048h, 048h, 000h, 000h,  ; Char239
            db 000h, 078h, 000h, 078h, 000h, 078h, 000h, 000h,  ; Char240
            db 000h, 010h, 038h, 010h, 000h, 038h, 000h, 000h,  ; Char241
            db 040h, 030h, 008h, 030h, 040h, 000h, 078h, 000h,  ; Char242
            db 008h, 030h, 040h, 030h, 008h, 000h, 078h, 000h,  ; Char243
            db 000h, 008h, 014h, 010h, 010h, 010h, 010h, 010h,  ; Char244
            db 010h, 010h, 010h, 010h, 010h, 050h, 020h, 000h,  ; Char245
            db 000h, 010h, 000h, 07ch, 000h, 010h, 000h, 000h,  ; Char246
            db 000h, 028h, 050h, 000h, 028h, 050h, 000h, 000h,  ; Char247
            db 030h, 048h, 048h, 030h, 000h, 000h, 000h, 000h,  ; Char248
            db 000h, 000h, 000h, 030h, 030h, 000h, 000h, 000h,  ; Char249
            db 000h, 000h, 000h, 020h, 000h, 000h, 000h, 000h,  ; Char250
            db 000h, 01ch, 010h, 010h, 050h, 050h, 020h, 000h,  ; Char251
            db 050h, 028h, 028h, 028h, 000h, 000h, 000h, 000h,  ; Char252
            db 060h, 010h, 020h, 070h, 000h, 000h, 000h, 000h,  ; Char253
            db 000h, 000h, 078h, 078h, 078h, 078h, 000h, 000h,  ; Char254
            db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h   ; Char255           
; CP437 character set
#endif
            endp
