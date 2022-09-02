.big
{beginG2Mode
/clearMem 0006 00
\clearMem 0007
/initRegs 0009 00
\initRegs 000a
:0000 f8 01 d4 04 56 d4 00 00 d4 00 00 00 0e d5 02 c2
:0010 0e ff 03 76 03 01
+000b
}
{updateG2Mode
:0000 f8 02 b7 f8 80 a7 f8 03 d4 04 56 d5
}
{endG2Mode
:0000 c2 00 0e f8 88 b7 f8 81 a7 f8 03 d4 04 56 f8 02
:0010 d4 04 56 d5
+0001
}
{sendBitmap
/setAddress 0001 00
\setAddress 0002
:0000 d4 00 00 40 00 46 b8 46 a8 f8 00 a7 f8 18 b7 f8
:0010 05 d4 04 56 d5
}
{sendColors
/setAddress 0001 00
\setAddress 0002
:0000 d4 00 00 60 00 46 b8 46 a8 f8 00 a7 f8 18 b7 f8
:0010 05 d4 04 56 d5
}
{setBackground
/setAddress 0002 00
\setAddress 0003
:0000 a8 d4 00 00 60 00 f8 00 a7 f8 18 b7 f8 04 d4 04
:0010 56 d5
}
{sendNames
/setAddress 0001 00
\setAddress 0002
:0000 d4 00 00 78 00 f8 00 a7 f8 03 b7 f8 06 d4 04 56
:0010 d5
}
{setSpritePattern
/setAddress 0001 00
\setAddress 0002
:0000 d4 00 00 58 00 46 b8 46 a8 46 b7 46 a7 f8 05 d4
:0010 04 56 d5
}
{setSpriteData
/setAddress 0001 00
\setAddress 0002
:0000 d4 00 00 7b 00 46 b8 46 a8 46 b7 46 a7 f8 05 d4
:0010 04 56 d5
}
{sendBmapData
/setAddress 0001 00
\setAddress 0002
:0000 d4 00 00 40 00 46 b8 46 a8 46 b9 46 a9 49 b7 09
:0010 a7 f8 05 d4 04 56 d5
}
{sendRleBmapData
/setAddress 0001 00
\setAddress 0002
:0000 d4 00 00 40 00 46 b8 46 a8 46 b9 46 a9 49 b7 09
:0010 a7 f8 09 d4 04 56 d5
}
{sendCmapData
/setAddress 0001 00
\setAddress 0002
:0000 d4 00 00 60 00 46 b8 46 a8 46 b9 46 a9 49 b7 09
:0010 a7 f8 05 d4 04 56 d5
}
{sendRleCmapData
/setAddress 0001 00
\setAddress 0002
:0000 d4 00 00 60 00 46 b8 46 a8 46 b9 46 a9 49 b7 09
:0010 a7 f8 09 d4 04 56 d5
}
{setG2CharXY
:0000 46 a9 46 b9 f8 00 a8 f8 00 b8 f8 37 a7 f8 00 b7
/ADD16 0014 00
\ADD16 0015
:0010 99 fe a8 d4 00 00 47 b8 07 a8 f8 00 a7 f8 00 b7
/ADD16 0026 00
\ADD16 0027
/ADD16 002f 00
:0020 89 fe fe fe a7 d4 00 00 f8 00 a8 f8 40 b8 d4 00
\ADD16 0030
:0030 00 f8 00 d4 04 56 d5 00 00 01 00 02 00 03 00 04
:0040 00 05 00 06 00 07 00 08 00 09 00 0a 00 0b 00 0c
:0050 00 0d 00 0e 00 0f 00 10 00 11 00 12 00 13 00 14
:0060 00 15 00 16 00 17 00
v000b
^000e
}
{drawG2String
/MULT8 000f 00
:0000 f8 00 a7 f8 00 b7 4f c2 00 2f a8 f8 08 b8 d4 00
\MULT8 0010
\VDP_CHARSET 0012
/VDP_CHARSET 0015 00
/ADD16 0018 00
\ADD16 0019
:0010 00 f8 00 a8 f8 00 b8 d4 00 00 f8 08 a9 f8 00 b9
:0020 47 a8 f8 07 d4 04 56 29 89 ca 00 20 c0 00 00 d5
+0008
+002a
+002d
}
