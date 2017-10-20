.include "m8535def.inc"
.equ DIOD=3
.def Acc0=r16
.def Acc1=r17
.org 0x0
	rjmp Reset
.org 0x15
Reset:
