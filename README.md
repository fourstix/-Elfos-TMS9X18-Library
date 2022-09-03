# Elfos-TMS9X18-Library
This code provides a library for the [Elf/OS TMS9X18 Video Driver](https://github.com/fourstix/Elfos-TMS9X18-Driver) API.  This library can be linked with code like the [Elfos-TMS9118-Demos](https://github.com/fourstix/Elfos-TMS9118-Demos) to access TMS9X18 Video functions independent of the platform hardware such as the [1802-Mini TMS9x18 Video Card](https://github.com/dmadole/1802-Mini-9918-Video) by David Madole or the [Pico/Elf v2 TMS9118/9918 Color Video card](http://www.elf-emulation.com/hardware.html) by Mike Riley.  The source files for this library were assembled into object files using the [Asm/02 1802 Assembler](https://github.com/rileym65/Asm-02) by Mike Riley.

Platform  
--------
This code written with this library should run on any platform with the Elf/OS TMS9X18 Video Driver loaded, such as the  [1802-Mini](https://github.com/dmadole/1802-Mini) with the [1802-Mini TMS9918 Video Card](https://github.com/dmadole/1802-Mini-9918-Video) created by David Madole or  a [Pico/Elf v2](http://www.elf-emulation.com/hardware.html) with the [TMS9118/9918 Color Board](http://www.elf-emulation.com/hardware.html) created by Mike Riley. A lot of information and software for the 1802-Mini and the Pico/Elf v2 can be found in the [COSMAC ELF Group](https://groups.io/g/cosmacelf) at groups.io.

Examples
----------
Please see the [Elfos-9118-Demos](https://github.com/fourstix/Elfos-TMS9118-Demos) repository on GitHub for example code that uses this library.

TMS9X18 Video Library API
--------------------------
**vdp_base**  -- Base functions for the TMS9X18 Video hardware.
<table>
<tr><th>API Name</th><th colspan="2">Description</th><th>Parameter 1</th><th>Parameter 2</th><th>Notes</th></tr>
<tr><td>checkVideo</td><td colspan="2">Check to see if the video driver is loaded.</td><td colspan="2">(None)</td><td>Returns DF = 0 if loaded, DF = 1 if not loaded.</tr>
<tr><td>setAddress</td><td colspan="2">Set the VDP address with the inlined value</td><td colspan="2">dw Address (inlined)</td>&nbsp;<td></tr>
<tr><td>readStatus</td><td colspan="2">Read VDP status byte.</td><td colspan="2">(None)</td><td>Returns D = VDP Status byte.</tr>
<tr><td>setGroup</td><td colspan="2">Set expansion group for video card.</td><td colspan="2">(None)</td><td>Always call this function before communication with the video card begins. It does nothing if group for the video card is defined as "none".</tr>
<tr><td>resetGroup</td><td colspan="2">Reset expansion group back to the default value.</td><td colspan="2">(None)</td><td>Always call this function after communication with the video card ends. It does nothing if group for the video card is defined as "none".</tr>
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
