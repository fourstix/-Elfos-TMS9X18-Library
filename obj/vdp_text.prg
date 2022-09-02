.big
{beginTextMode
/clearMem 0006 00
\clearMem 0007
/initRegs 0009 00
\initRegs 000a
/initCharset 000e 00
\initCharset 000f
:0000 f8 01 d4 04 56 d4 00 00 d4 00 00 00 11 d4 00 00
:0010 d5 00 d0 02 00 00 20 00 f4
+000b
}
{endTextMode
:0000 c2 00 19 f8 f1 b7 f8 87 a7 f8 03 d4 04 56 f8 90
:0010 b7 f8 81 a7 f8 03 d4 04 56 f8 02 d4 04 56 d5
+0001
}
{setTextColor
:0000 b7 f8 87 a7 f8 03 d4 04 56 d5
}
{setTextCharXY
/MULT8 000f 00
:0000 f8 00 b8 46 a8 88 73 98 73 f8 28 b8 46 a8 d4 00
\MULT8 0010
/ADD16 0017 00
\ADD16 0018
:0010 00 60 72 b8 f0 a8 d4 00 00 f8 00 a8 f8 48 b8 d4
/ADD16 0020 00
\ADD16 0021
:0020 00 00 f8 00 d4 04 56 d5
}
{writeTextString
:0000 4f c2 00 0d a8 f8 07 d4 04 56 c0 00 00 d5
+0002
+000b
}
{writeTextData
:0000 46 b8 46 a8 46 b7 46 a7 f8 05 d4 04 56 d5
}
