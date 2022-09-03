# Elfos-TMS9X18-Library
This code provides a library for the [Elf/OS TMS9X18 Video Driver](https://github.com/fourstix/Elfos-TMS9X18-Driver) API.  This library can be linked with code like the [Elfos-TMS9118-Demos](https://github.com/fourstix/Elfos-TMS9118-Demos) to access TMS9X18 Video functions independent of the platform hardware such as the [1802-Mini TMS9x18 Video Card](https://github.com/dmadole/1802-Mini-9918-Video) by David Madole or the [Pico/Elf v2 TMS9118/9918 Color Video card](http://www.elf-emulation.com/hardware.html) by Mike Riley.  The source files for this library were assembled into object files using the [Asm/02 1802 Assembler](https://github.com/rileym65/Asm-02) by Mike Riley.

Platform  
--------
This code written with this library should run on any platform with the Elf/OS TMS9X18 Video Driver loaded, such as the  [1802-Mini](https://github.com/dmadole/1802-Mini) with the [1802-Mini TMS9918 Video Card](https://github.com/dmadole/1802-Mini-9918-Video) created by David Madole or  a [Pico/Elf v2](http://www.elf-emulation.com/hardware.html) with the [TMS9118/9918 Color Board](http://www.elf-emulation.com/hardware.html) created by Mike Riley. A lot of information and software for the 1802-Mini and the Pico/Elf v2 can be found in the [COSMAC ELF Group](https://groups.io/g/cosmacelf) at groups.io.

Examples
----------
Please see the [Elfos-9118-Demos](https://github.com/fourstix/Elfos-TMS9118-Demos) repository on GitHub for example code that uses this library.

TMS9X18 Video Library API
-------------------------
These functions support Graphics II Mode and Text Mode.

**vdp_g2  -- Graphics II Mode functions for the TMS9X18 Video Library**
<table>
<tr><th>API Name</th><th colspan="2">Description</th><th>Parameter 1</th><th>Parameter 2</th><th>Notes</th></tr>
<tr><td>beginG2Mode</td><td colspan="2">Set up video card to draw an image in Graphics II mode.</td><td colspan="2">(None)</td><td>Sets group, clears memory and initializes video card.</td></tr>
<tr><td>endG2Mode</td><td colspan="2">Reset the vidoe card, if desired, and then reset the expansion group back to default.</td><td colspan="2">D = V_VDP_KEEP to keep display, or D = V_VDP_RESET to reset the video card.</td><td>Resetting the video card turns off interrupts and clears the display.</td></tr>
<tr><td>sendBitmap</td><td colspan="2">Send bitmap data to VDP Pattern Table.</td><td colspan="2">dw ptr  (inlined) to bitmap data buffer.</td><td>The bitmap data size should be 6144 bytes.</td></tr>
<tr><td>sendColors</td><td colspan="2">Send  color map data to VDP Color Table.</td><td colspan="2">dw ptr  (inlined) to color map data buffer.</td><td>The color map data size should be 6144 bytes.</td></tr>
<tr><td>setBackground</td><td colspan="2">Fill VDP Color table with single background color</td><td colspan="2">D = background color byte.</td>&nbsp;<td></tr>
<tr><td>sendNames</td><td colspan="2">Set name table entries for Graphics II mode.</td><td colspan="2">(None)</td><td>Fills Names Table with triplet series 0..255, 0..255, 0..255.</td></tr>
<tr><td>setSpritePattern</td><td colspan="2">Send sprite pixel pattern data to VDP Sprite Patterns Table.</td><td >dw ptr (inlined) to sprite pattern buffer</td><td >dw size (inlined) of sprite pattern</td><td>&nbsp;</td></tr>
<tr><td>setSpriteData</td><td colspan="2">Send sprite attributes data to VDP Sprite Attribures Table.</td><td >dw ptr (inlined) to sprite attributes buffer</td><td >dw size (inlined) of sprite attributes</td><td>&nbsp;</td></tr>
<tr><td>sendBmapData</td><td colspan="2">Send file bitmap data to VDP Pattern Table.</td><td >dw ptr (inlined) to bitmap data buffer</td><td >dw ptr (inlined) into header buffer with data size</td><td>Useful when reading bitmap data from a Sun Raster image file.</td></tr>
<tr><td>sendRleBmapData</td><td colspan="2">Send Sun RLE bitmap data to VDP Pattern Table.</td><td >dw ptr (inlined) to RLE compressed bitmap data buffer</td><td >dw ptr (inlined) into header buffer with compressed data size</td><td>Useful when reading bitmap data a from Sun Raster image file.</td></tr>
<tr><td>sendCmapData</td><td colspan="2">Send file color map data to VDP Color Table.</td><td >dw ptr (inlined) to color map data buffer</td><td >dw ptr (inlined) into header buffer with data size</td><td>Useful when reading color map data from a Sun Raster image file.</td></tr>
<tr><td>sendRleBmapData</td><td colspan="2">Send Sun RLE color map data to VDP Color Table.</td><td >dw ptr (inlined) to RLE compressed color map data buffer</td><td >dw ptr (inlined) into header buffer with compressed data size</td><td>Useful when reading color map data a from Sun Raster image file.</td></tr>
</table>
<tr><td>setG2CharXY</td><td colspan="2">Set Graphics 2 Mode x,y position from character co-ordinates (1..31,0..23)</td><td colspan="2" > db x, db y (inlined) x,y co-ordinates</td><td>Sets the x,y position used by drawG2String.</td></tr>
<tr><td>setG2CharXY</td><td colspan="2">Draw a text string at the current x,y position in graphics II mode.</td><td colspan="2" >RF - pointer to null terminated string</td><td>Draws text at the x,y position set by getG2CharXY.</td></tr>
</table>

**vdp_g2  -- Graphics II Mode functions for the TMS9X18 Video Library**

Other TMS9X18 Video Library Functions
-------------------------------------
These library functions are mainly used internally by the API functions, but they are available for user programs.

**vdp_base -- Base functions for the TMS9X18 Video Library**
<table>
<tr><th>API Name</th><th colspan="2">Description</th><th>Parameter 1</th><th>Parameter 2</th><th>Notes</th></tr>
<tr><td>checkVideo</td><td colspan="2">Check to see if the video driver is loaded.</td><td colspan="2">(None)</td><td>Returns DF = 0 if loaded, DF = 1 if not loaded.</tr>
<tr><td>setAddress</td><td colspan="2">Set the VDP address with the inlined value</td><td colspan="2">dw Address (inlined)</td>&nbsp;<td></tr>
<tr><td>readStatus</td><td colspan="2">Read VDP status byte.</td><td colspan="2">(None)</td><td>Returns D = VDP Status byte.</tr>
<tr><td>setGroup</td><td colspan="2">Set expansion group for video card.</td><td colspan="2">(None)</td><td>Always call this function before communication with the video card begins. It does nothing if group for the video card is defined as "none".</tr>
<tr><td>resetGroup</td><td colspan="2">Reset expansion group back to the default value.</td><td colspan="2">(None)</td><td>Always call this function after communication with the video card ends. It does nothing if group for the video card is defined as "none".</tr>
</table>

**vdp_charset -- Character Set font used by TMS9X18 Video Library functions**
<table>
<tr><th>API Name</th><th colspan="2">Description</th><th colspan="3">Notes</th></tr>
<tr><td>VDP_CHARSET</td><td colspan="2">Font definitions for TMS9x18 character set.</td><td colspan="3">Default characters set font is CP437, but it can be assembled to use the smaller TI99 font by changing the font definition in charset.inc include file.  The character set size is defined in charset.inc as VDP_CHARSET_SIZE.</td></tr>
</table>

**vdp_math -- Math primitives used by other functions in the TMS9X18 Video Library**
<table>
<tr><th>API Name</th><th colspan="2">Description</th><th>Parameter 1</th><th>Parameter 2</th><th>Notes</th></tr>
<tr><td>ADD16</td><td colspan="2">Add to 16 bit integers.</td><td>R7, 16 bit addend.</td></td><td>R8, 16 bit addend.</td><td>Returns R7 with the 16-bit sum of R7+R8, DF = 1 indicates overflow.</tr>
<tr><td>MULT8</td><td colspan="2">Multiply to 8-bit values.</td><td colspan="2">R8.1 contains the 8-bit multiplier, R8.0 contains the 8-bit multiplicand.</td><td>Returns R7 with the 16-bit product of byte R8.0 x byte R8.1.</td></tr>
</table>

**vdp_init -- Initialization functions for the TMS9X18 Video**
<table>
<tr><th>API Name</th><th colspan="2">Description</th><th>Parameter 1</th><th>Parameter 2</th><th>Notes</th></tr>
<tr><td>clearMem</td><td colspan="2">Clear the VDP VRAM memory.</td><td colspan="2">(None)</td><td>Clears all 16K bytes of VDP memory.</tr>
<tr><td>initRegs</td><td colspan="2">Initialize the 8 VDP registers.</td><td colspan="2">dw ptr (inlined) to 8-byte vreg data buffer.</td>&nbsp;<td></tr>
<tr><td>intCharset</td><td colspan="2">Initialize character set data in the text Pattern Table.</td><td colspan="2">(None)</td><td>Used in Text Mode.</tr>
</table>

Repository Contents
-------------------
* **/src/**  -- Source files for the TMS9X18 Video Library.
  * asm.bat - Windows batch file to assemble source files with Asm/02 to create object files. Use the command *asm vdp_base.asm* to assemble the source file.  Replace *[YOUR_PATH]* with the path to the Asm/02 directory.
  * vdp_base.asm - Base library functions to access the TMS9X18 Video Driver.
  * vdp_charset.asm - Character set data used by the TMS9X18 Video Library.
  * vdp_init.asm - Initialization functions used by the TMS9X18 Video Library.
  * vdp_math.asm - Math primitives used by the TMS9X18 Video Library.
  * vdp_g2.asm - Graphics Mode II functions provided by the TMS9X18 Video Library.
  * vdp_text.asm - Text Mode functions provided by the TMS9X19 Video Library.
* **/src/include/**  -- Included source files for Elf/OS TMS9X18 Video Driver.
  * ops.inc - Opcode definitions for Asm/02.
  * bios.inc - Bios definitions from Elf/OS
  * kernel.inc - Kernel definitions from Elf/OS
  * charset.inc - Character set definitions for the library. The default is CP437 font, but the code can be re-assembled for the smaller TI99 font.
  * vdp.inc - API constants and useful VDP constants to be used by programs calling the driver.
* **/obj/**  -- Object files for TMS9X18 video driver.
  * build.bat - Windows batch file to create the vdp_video.lib library file from the object files. Use the command *build* to concatenate the object files into the library file.
  * vdp_base.prg - Object file with base library functions to access the TMS9X18 Video Driver.
  * vdp_charset.prg - Object file with CP437 character set data used by the TMS9X18 Video Library.
  * vdp_init.prg - Object file with initialization functions used by the TMS9X18 Video Library.
  * vdp_math.prg - Object file with math primitives used by the TMS9X18 Video Library.
  * vdp_g2.prg - Graphics Mode II functions provided by the TMS9X18 Video Library.
  * vdp_text.prg - Text Mode functions provided by the TMS9X19 Video Library.
* **/lib/**  -- Library files for TMS9X18 video driver.
  * vdp_video.lib - Library file assembled with the CP437 character set font.
  * vdp_video_ti99.lib - Alternative library file assembled with the TI99 character set font.


License Information
-------------------

This code is public domain under the MIT License, but please buy me a beer
if you use this and we meet someday (Beerware).

References to any products, programs or services do not imply
that they will be available in all countries in which their respective owner operates.

Other company, product, or services names may be trademarks or services marks of others.

All libraries used in this code are copyright their respective authors.

The 1802-Mini Hardware
Copyright (c) 2022-2022 by David Madole

The Pico/Elf v2 1802 microcomputer hardware and software
Copyright (c) 2004-2022 by Mike Riley.

Elf/OS and RcAsm Software
Copyright (c) 2004-2022 by Mike Riley.

Many thanks to the original authors for making their designs and code available as open source.

This code, firmware, and software is released under the [MIT License](http://opensource.org/licenses/MIT).

The MIT License (MIT)

Copyright (c) 2022 by Gaston Williams

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

**THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.**
