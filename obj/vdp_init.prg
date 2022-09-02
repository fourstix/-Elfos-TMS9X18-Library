.big
{clearMem
/setAddress 0001 00
\setAddress 0002
:0000 d4 00 00 40 00 f8 00 a7 f8 40 b7 f8 00 a8 f8 04
:0010 d4 04 56 d5
}
{initRegs
:0000 46 b8 46 a8 f8 80 a7 48 b7 f8 03 d4 04 56 17 87
:0010 ff 88 ca 00 07 d5
+0013
}
{initCharset
/setAddress 0001 00
\setAddress 0002
\VDP_CHARSET 0006
/VDP_CHARSET 0009 00
:0000 d4 00 00 40 00 f8 00 a8 f8 00 b8 f8 00 a7 f8 08
:0010 b7 f8 05 d4 04 56 d5
}
