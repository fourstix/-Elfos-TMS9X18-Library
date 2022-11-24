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
:0000 89 73 99 73 f8 0c d4 04 56 60 72 b9 f0 a9 99 b7
:0010 89 fe fe fe a7 f8 0d d4 04 56 d5
}
{getG2CharXY
:0000 f8 0c d4 04 56 97 fa 1f b9 87 f6 f6 f6 a9 d5
}
{updateG2Idx
:0000 89 73 99 73 f8 0c d4 04 56 60 72 b9 f0 a9 88 73
/ADD16 0017 00
\ADD16 0018
:0010 98 73 89 a8 99 b8 d4 00 00 97 ff 18 cb 00 22 f8
:0020 00 b7 60 72 b8 f0 a8 f8 0d d4 04 56 d5
+001d
}
{setG2BmapAddr
/ADD16 000c 00
\ADD16 000d
:0000 f8 0c d4 04 56 f8 00 a8 f8 40 b8 d4 00 00 f8 00
:0010 d4 04 56 d5
}
{setG2CmapAddr
/ADD16 000c 00
\ADD16 000d
:0000 f8 0c d4 04 56 f8 00 a8 f8 60 b8 d4 00 00 f8 00
:0010 d4 04 56 d5
}
{putG2Char
/setG2BmapAddr 0002 00
\setG2BmapAddr 0003
/MULT8 000b 00
\MULT8 000c
\VDP_CHARSET 000e
:0000 73 d4 00 00 60 f0 a8 f8 08 b8 d4 00 00 f8 00 a8
/VDP_CHARSET 0011 00
/ADD16 0014 00
\ADD16 0015
:0010 f8 00 b8 d4 00 00 f8 08 b8 47 a8 f8 07 d4 04 56
:0020 98 ff 01 b8 ca 00 19 d5
+0025
}
{putG2String
/setG2BmapAddr 0001 00
\setG2BmapAddr 0002
:0000 d4 00 00 f8 00 a9 f8 00 b9 f8 00 a7 f8 00 b7 4f
/MULT8 0018 00
\MULT8 0019
\VDP_CHARSET 001b
/VDP_CHARSET 001e 00
:0010 c2 00 38 a8 f8 08 b8 d4 00 00 f8 00 a8 f8 00 b8
/ADD16 0021 00
\ADD16 0022
:0020 d4 00 00 f8 08 b8 47 a8 f8 07 d4 04 56 19 98 ff
:0030 01 b8 ca 00 26 c0 00 09 d5
+0011
+0033
+0036
}
{drawG2String
/putG2String 0001 00
\putG2String 0002
/updateG2Idx 0004 00
\updateG2Idx 0005
:0000 d4 00 00 d4 00 00 d5
}
{drawG2ColorString
/putG2String 0002 00
\putG2String 0003
/setG2CmapAddr 0009 00
\setG2CmapAddr 000a
:0000 73 d4 00 00 89 73 99 73 d4 00 00 60 72 b9 f0 a9
/updateG2Idx 001d 00
\updateG2Idx 001e
:0010 89 a7 99 b7 60 f0 a8 f8 04 d4 04 56 d4 00 00 d5
}
{drawG2Char
/putG2Char 0001 00
\putG2Char 0002
/updateG2Idx 000a 00
\updateG2Idx 000b
:0000 d4 00 00 f8 08 a9 f8 00 b9 d4 00 00 d5
}
{drawG2ColorChar
/putG2Char 0001 00
\putG2Char 0002
/setG2CmapAddr 0004 00
\setG2CmapAddr 0005
:0000 d4 00 00 d4 00 00 f8 0c d4 04 56 f8 08 a7 f8 00
/updateG2Idx 001d 00
\updateG2Idx 001e
:0010 b7 f8 04 d4 04 56 f8 08 a9 f8 00 b9 d4 00 00 d5
}
{clearInfo
:0000 f8 00 b7 a7 b8 a8 f8 0d d4 04 56 d5
}
{getInfo
:0000 f8 0c d4 04 56 d5
}
{setInfo
:0000 f8 0d d4 04 56 d5
}
{blankG2Line
/getInfo 0001 00
\getInfo 0002
/setG2BmapAddr 0006 00
\setG2BmapAddr 0007
:0000 d4 00 00 88 73 d4 00 00 f8 00 a8 f8 00 a7 f8 01
/setG2CmapAddr 0017 00
\setG2CmapAddr 0018
:0010 b7 f8 04 d4 04 56 d4 00 00 60 f0 a8 f8 00 a7 f8
:0020 01 b7 f8 04 d4 04 56 d5
}
{blankG2Screen
/getInfo 0001 00
\getInfo 0002
/setInfo 000a 00
\setInfo 000b
/setG2BmapAddr 000f 00
:0000 d4 00 00 f8 00 a7 f8 00 b7 d4 00 00 88 73 d4 00
\setG2BmapAddr 0010
:0010 00 f8 00 a8 f8 00 a7 f8 18 b7 f8 04 d4 04 56 d4
/setG2CmapAddr 0020 00
\setG2CmapAddr 0021
:0020 00 00 60 f0 a8 f8 00 a7 f8 18 b7 f8 04 d4 04 56
:0030 d5
}
{invertColor
:0000 f8 0c d4 04 56 88 fe fe fe fe 52 88 f6 f6 f6 f6
:0010 f1 a8 f8 0d d4 04 56 d5
}
{setColor
:0000 73 f8 0c d4 04 56 60 f0 a8 f8 0d d4 04 56 d5
}
{resetColor
:0000 f8 0c d4 04 56 98 a8 f8 0d d4 04 56 d5
}
