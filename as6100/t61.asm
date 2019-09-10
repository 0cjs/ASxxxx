	.title	IM6100/HM6100 Instruction Test

	; Define Values To Check Addressing Modes
	base0 == .

	pa0x00 == base0 + 0x0000
	pa0x7F == base0 + 0x007F

	.sbttl	Memory Reference Instructions

	and	*pa0x00		; 00 00
	;...
	and	*pa0x7F		; 00 7F
	and	pa0x00		; 00 80
	;...
	and	pa0x7F		; 00 FF
	and	*[pa0x00]	; 01 00
	;...
	and	*[pa0x7F]	; 01 7F
	and	[pa0x00]	; 01 80
	;...
	and	[pa0x7F]	; 01 FF

	tad	*pa0x00		; 02 00
	;...
	tad	*pa0x7F		; 02 7F
	tad	pa0x00		; 02 80
	;...
	tad	pa0x7F		; 02 FF
	tad i	*pa0x00		; 03 00
	;...
	tad i	*pa0x7F		; 03 7F
	tad i	pa0x00		; 03 80
	;...
	tad i	pa0x7F		; 03 FF

	isz	*pa0x00		; 04 00
	;...
	isz	*pa0x7F		; 04 7F
	isz	pa0x00		; 04 80
	;...
	isz	pa0x7F		; 04 FF
	isz	[*pa0x00]	; 05 00
	;...
	isz	[*pa0x7F]	; 05 7F
	isz	[pa0x00]	; 05 80
	;...
	isz	[pa0x7F]	; 05 FF


	.page
	dca	*pa0x00		; 06 00
	;...
	dca	*pa0x7F		; 06 7F
	dca	pa0x00		; 06 80
	;...
	dca	pa0x7F		; 06 FF
	dca	*[pa0x00]	; 07 00
	;...
	dca	*[pa0x7F]	; 07 7F
	dca	[pa0x00]	; 07 80
	;...
	dca	[pa0x7F]	; 07 FF

	jms	*pa0x00		; 08 00
	;...
	jms	*pa0x7F		; 08 7F
	jms	pa0x00		; 08 80
	;...
	jms	pa0x7F		; 08 FF
	jms	*[pa0x00]	; 09 00
	;...
	jms	*[pa0x7F]	; 09 7F
	jms	[pa0x00]	; 09 80
	;...
	jms	[pa0x7F]	; 09 FF

	jmp	*pa0x00		; 0A 00
	;...
	jmp	*pa0x7F		; 0A 7F
	jmp	pa0x00		; 0A 80
	;...
	jmp	pa0x7F		; 0A FF
	jmp	*[pa0x00]	; 0B 00
	;...
	jmp	*[pa0x7F]	; 0B 7F
	jmp	[pa0x00]	; 0B 80
	;...
	jmp	[pa0x7F]	; 0B FF


	.page
	.sbttl	Memory Reference Instructions (Absolute Address)

	pa0x08 == 0x0008	; Absolute Page 0 Address

	and	*pa0x08		; 00 08
	;...
	and	*pa0x7F		; 00 7F
	and	pa0x08		; 00 08
	;...
	and	pa0x7F		; 00 FF
	and	*[pa0x08]	; 01 08
	;...
	and	*[pa0x7F]	; 01 7F
	and	[pa0x08]	; 01 08
	;...
	and	[pa0x7F]	; 01 FF

	tad	*pa0x08		; 02 08
	;...
	tad	*pa0x7F		; 02 7F
	tad	pa0x08		; 02 08
	;...
	tad	pa0x7F		; 02 FF
	tad i	*pa0x08		; 03 08
	;...
	tad i	*pa0x7F		; 03 7F
	tad i	pa0x08		; 03 08
	;...
	tad i	pa0x7F		; 03 FF

	isz	*pa0x08		; 04 08
	;...
	isz	*pa0x7F		; 04 7F
	isz	pa0x08		; 04 08
	;...
	isz	pa0x7F		; 04 FF
	isz	[*pa0x08]	; 05 08
	;...
	isz	[*pa0x7F]	; 05 7F
	isz	[pa0x08]	; 05 08
	;...
	isz	[pa0x7F]	; 05 FF


	.page
	dca	*pa0x08		; 06 08
	;...
	dca	*pa0x7F		; 06 7F
	dca	pa0x08		; 06 08
	;...
	dca	pa0x7F		; 06 FF
	dca	*[pa0x08]	; 07 08
	;...
	dca	*[pa0x7F]	; 07 7F
	dca	[pa0x08]	; 07 08
	;...
	dca	[pa0x7F]	; 07 FF

	jms	*pa0x08		; 08 08
	;...
	jms	*pa0x7F		; 08 7F
	jms	pa0x08		; 08 08
	;...
	jms	pa0x7F		; 08 FF
	jms	*[pa0x08]	; 09 08
	;...
	jms	*[pa0x7F]	; 09 7F
	jms	[pa0x08]	; 09 08
	;...
	jms	[pa0x7F]	; 09 FF

	jmp	*pa0x08		; 0A 08
	;...
	jmp	*pa0x7F		; 0A 7F
	jmp	pa0x08		; 0A 08
	;...
	jmp	pa0x7F		; 0A FF
	jmp	*[pa0x08]	; 0B 08
	;...
	jmp	*[pa0x7F]	; 0B 7F
	jmp	[pa0x08]	; 0B 08
	;...
	jmp	[pa0x7F]	; 0B FF


	.page
	.sbttl	Memory Reference Instructions (Global Address)

	.globl	pa		; Global Page 0 Address

	and	*pa + 0x08	; 00 08
	;...
	and	*pa0x7F		; 00 7F
	and	pa + 0x08	; 00 88
	;...
	and	pa0x7F		; 00 FF
	and	*[pa + 0x08]	; 01 08
	;...
	and	*[pa0x7F]	; 01 7F
	and	[pa + 0x08]	; 01 88
	;...
	and	[pa0x7F]	; 01 FF

	tad	*pa + 0x08	; 02 08
	;...
	tad	*pa0x7F		; 02 7F
	tad	pa + 0x08	; 02 88
	;...
	tad	pa0x7F		; 02 FF
	tad i	*pa + 0x08	; 03 08
	;...
	tad i	*pa0x7F		; 03 7F
	tad i	pa + 0x08	; 03 88
	;...
	tad i	pa0x7F		; 03 FF

	isz	*pa + 0x08	; 04 08
	;...
	isz	*pa0x7F		; 04 7F
	isz	pa + 0x08	; 04 88
	;...
	isz	pa0x7F		; 04 FF
	isz	[*pa + 0x08]	; 05 08
	;...
	isz	[*pa0x7F]	; 05 7F
	isz	[pa + 0x08]	; 05 88
	;...
	isz	[pa0x7F]	; 05 FF


	.page
	dca	*pa + 0x08	; 06 08
	;...
	dca	*pa0x7F		; 06 7F
	dca	pa + 0x08	; 06 88
	;...
	dca	pa0x7F		; 06 FF
	dca	*[pa + 0x08]	; 07 08
	;...
	dca	*[pa0x7F]	; 07 7F
	dca	[pa + 0x08]	; 07 88
	;...
	dca	[pa0x7F]	; 07 FF

	jms	*pa + 0x08	; 08 08
	;...
	jms	*pa0x7F		; 08 7F
	jms	pa + 0x08	; 08 88
	;...
	jms	pa0x7F		; 08 FF
	jms	*[pa + 0x08]	; 09 08
	;...
	jms	*[pa0x7F]	; 09 7F
	jms	[pa + 0x08]	; 09 88
	;...
	jms	[pa0x7F]	; 09 FF

	jmp	*pa + 0x08	; 0A 08
	;...
	jmp	*pa0x7F		; 0A 7F
	jmp	pa + 0x08	; 0A 88
	;...
	jmp	pa0x7F		; 0A FF
	jmp	*[pa + 0x08]	; 0B 08
	;...
	jmp	*[pa0x7F]	; 0B 7F
	jmp	[pa + 0x08]	; 0B 88
	;...
	jmp	[pa0x7F]	; 0B FF


	.page
	.sbttl	Input / Output Instructions

	f0x0000 == base0 + 0x0000
	f0x01FF == base0 + 0x01FF
	dev0x00 == base0 + 0x00
	dev0x3F == base0 + 0x3F
	cmd0x0  == 0x0		; Only Absolute Values Allowed
	cmd0x7  == 0x7		; Only Absolute Values Allowed

	iot	f0x0000		; 0C 00
	iot	dev0x00,cmd0x0	; 0C 00
	;...
	iot	dev0x00,cmd0x7	; 0C 07
	;...
	iot	dev0x3F,cmd0x0	; 0D F8
	;...
	iot	dev0x3F,cmd0x7	; 0D FF
	iot	f0x01FF		; 0D FF


	.page
	.sbttl	Group 1 Operate Instructions

	nop			; 0E 00
	iac			; 0E 01
	bsw			; 0E 02
	iac bsw			; 0E 03
	ral			; 0E 04
	ral iac			; 0E 05
	rtl			; 0E 06
	rtl iac			; 0E 07
	rar			; 0E 08
	rar iac			; 0E 09
	rtr			; 0E 0A
	rtr iac			; 0E 0B
				; 0E 0C - Illegal
				; 0E 0D - Illegal
				; 0E 0D - Illegal
				; 0E 0F - Illegal


	.page
	cml			; 0E 10
	cml iac			; 0E 11
	cml bsw iac		; 0E 13
	cml rtl iac		; 0E 17
	cml rtr iac		; 0E 1B

	cma			; 0E 20
	cma iac			; 0E 21
	cma bsw iac		; 0E 23
	cma rtl iac		; 0E 27
	cma rtr iac		; 0E 2B
	cma cml			; 0E 30
	cma cml iac		; 0E 31
	cma cml bsw iac		; 0E 33
	cma cml rtl iac		; 0E 37
	cma cml rtr iac		; 0E 3B

	cll			; 0E 40
	cll iac			; 0E 41
	cll bsw iac		; 0E 43
	cll rtl iac		; 0E 47
	cll rtr iac		; 0E 4B
	cll cml			; 0E 50
	cll cml iac		; 0E 51
	cll cml bsw iac		; 0E 53
	cll cml rtl iac		; 0E 57
	cll cml rtr iac		; 0E 5B
	cll cma			; 0E 60
	cll cma iac		; 0E 61
	cll cma bsw iac		; 0E 63
	cll cma rtl iac		; 0E 67
	cll cma rtr iac		; 0E 6B
	cll cma cml		; 0E 70
	cll cma cml iac		; 0E 71
	cll cma cml bsw iac	; 0E 73
	cll cma cml rtl iac	; 0E 77
	cll cma cml rtr iac	; 0E 7B


	.page
	cla			; 0E 80
	cla iac			; 0E 81
	cla bsw iac		; 0E 83
	cla rtl iac		; 0E 87
	cla rtr iac		; 0E 8B
	cla cml			; 0E 90
	cla cml iac		; 0E 91
	cla cml bsw iac		; 0E 93
	cla cml rtl iac		; 0E 97
	cla cml rtr iac		; 0E 9B
	cla cma			; 0E A0
	cla cma iac		; 0E A1
	cla cma bsw iac		; 0E A3
	cla cma rtl iac		; 0E A7
	cla cma rtr iac		; 0E AB
	cla cma cml		; 0E B0
	cla cma cml iac		; 0E B1
	cla cma cml bsw iac	; 0E B3
	cla cma cml rtl iac	; 0E B7
	cla cma cml rtr iac	; 0E BB
	cla cll			; 0E C0
	cla cll iac		; 0E C1
	cla cll bsw iac		; 0E C3
	cla cll rtl iac		; 0E C7
	cla cll rtr iac		; 0E CB
	cla cll cml		; 0E D0
	cla cll cml iac		; 0E D1
	cla cll cml bsw iac	; 0E D3
	cla cll cml rtl iac	; 0E D7
	cla cll cml rtr iac	; 0E DB
	cla cll cma		; 0E E0
	cla cll cma iac		; 0E E1
	cla cll cma bsw iac	; 0E E3
	cla cll cma rtl iac	; 0E E7
	cla cll cma rtr iac	; 0E EB
	cla cll cma cml		; 0E F0
	cla cll cma cml iac	; 0E F1
	cla cll cma cml bsw iac	; 0E F3
	cla cll cma cml rtl iac	; 0E F7
	cla cll cma cml rtr iac	; 0E FB


	.page
	.sbttl	Group 2 Operate Instructions

	cla hlt			; 0F 82
	cla osr			; 0F 84
	cla osr hlt		; 0F 86

	cla snl			; 0F 90
	cla snl hlt		; 0F 92
	cla snl osr		; 0F 94
	cla snl osr hlt		; 0F 96
	cla szl			; 0F 98
	cla szl hlt		; 0F 9A
	cla szl osr		; 0F 9C
	cla szl osr hlt		; 0F 9E

	cla sza			; 0F A0
	cla sza hlt		; 0F A2
	cla sza osr		; 0F A4
	cla sza osr hlt		; 0F A6
	cla sna			; 0F A8
	cla sna hlt		; 0F AA
	cla sna osr		; 0F AC
	cla sna osr hlt		; 0F AE

	cla sza snl		; 0F B0
	cla sza snl hlt		; 0F B2
	cla sza snl osr		; 0F B4
	cla sza snl osr hlt	; 0F B6
	cla sna szl		; 0F B8
	cla sna szl hlt		; 0F BA
	cla sna szl osr		; 0F BC
	cla sna szl osr hlt	; 0F BE


	.page
	cla sma			; 0F C0
	cla sma hlt		; 0F C2
	cla sma osr		; 0F C4
	cla sma osr hlt		; 0F C6
	cla spa			; 0F C8
	cla spa hlt		; 0F CA
	cla spa osr		; 0F CC
	cla spa osr hlt		; 0F CE

	cla sma snl		; 0F D0
	cla sma snl hlt		; 0F D2
	cla sma snl osr		; 0F D4
	cla sma snl osr hlt	; 0F D6
	cla spa szl		; 0F D8
	cla spa szl hlt		; 0F DA
	cla spa szl osr		; 0F DC
	cla spa szl osr hlt	; 0F DE

	cla sma sza		; 0F E0
	cla sma sza hlt		; 0F E2
	cla sma sza osr		; 0F E4
	cla sma sza osr hlt	; 0F E6
	cla spa sna		; 0F E8
	cla spa sna hlt		; 0F EA
	cla spa sna osr		; 0F EC
	cla spa sna osr hlt	; 0F EE

	cla sma sza snl		; 0F F0
	cla sma sza snl hlt	; 0F F2
	cla sma sza snl osr	; 0F F4
	cla sma sza snl osr hlt	; 0F F6
	cla spa sna szl		; 0F F8
	cla spa sna szl hlt	; 0F FA
	cla spa sna szl osr	; 0F FC
	cla spa sna szl osr hlt	; 0F FE


	.page
	.sbttl	Group 3 Operate Instructions

	cla mql			; 0F 91
	cla mqa			; 0F C1
	cla mqa mql		; 0F D1


	.sbttl	Common Combined Group 1 Instructions

	cia			; 0E 21
	stl			; 0E 50
	glt			; 0E 84
    	sta			; 0E A0


	.sbttl	Common Combined Group 2 Instructions

	skp			; 0F 08
	las			; 0F 84


	.sbttl	Common Combined Group 3 Instructions

	acl			; 0F C1
	cam			; 0F 91
	swp			; 0F 51


	.page
	.sbttl	Replaced System Directives

	; Word Truncation to 12-Bits
	.word	0x1FFE		; 0F FE
	.word	0x3FFF		; 0F FF

	; Byte Truncation to 8-Bits
	.byte	0x01FE		; 00 FE
	.byte	0x03FF		; 00 FF

	.ascii	"AB"		; 00 41 00 42
	.asciz	"AB"		; 00 41 00 42 00 00
	.ascis	"AB"		; 00 41 00 C2

	.ascii	"ab"		; 00 61 00 62
	.asciz	"ab"		; 00 61 00 62 00 00
	.ascis	"ab"		; 00 61 00 E2

	.ascii	""		;
	.asciz	""		; 00 00
	.ascis	""		; 00 80

	.text	"abcd"		; 00 42 00 C4
	.text	"ABCD "		; 00 42 00 C4 08 00
	.text	"bob"		; 00 8F 00 80
	.text	"BOB "		; 00 8F 00 A0
	.textz	"a"		; 00 40
	.textz	"AB"		; 00 42 00 00
	.textz	"bob"		; 00 8F 00 80
	.textz	"BOB "		; 00 8F 00 A0 00 00


	.page
	.sbttl	Multiple Pages

	.setpg 1
	base1 == .

	pa1x00 == base1 + 0x0000
	pa1x7F == base1 + 0x007F

	and	*pa0x00		; 00 00
	;...
	and	*pa0x7F		; 00 7F
	and	pa1x00		; 00 80
	;...
	and	pa1x7F		; 00 FF
	and	*[pa0x00]	; 01 00
	;...
	and	*[pa0x7F]	; 01 7F
	and	[pa1x00]	; 01 80
	;...
	and	[pa1x7F]	; 01 FF

	.setpg 2
	base2 == .

	pa2x00 == base2 + 0x0000
	pa2x7F == base2 + 0x007F

	tad	*pa0x00		; 02 00
	;...
	tad	*pa0x7F		; 02 7F
	tad	pa2x00		; 02 80
	;...
	tad	pa2x7F		; 02 FF
	tad i	*pa0x00		; 03 00
	;...
	tad i	*pa0x7F		; 03 7F
	tad i	pa2x00		; 03 80
	;...
	tad i	pa2x7F		; 03 FF


	.page
	.setpg 4
	base4 == .

	pa4x00 == base4 + 0x0000
	pa4x7F == base4 + 0x007F

	isz	*pa0x00		; 04 00
	;...
	isz	*pa0x7F		; 04 7F
	isz	pa4x00		; 04 80
	;...
	isz	pa4x7F		; 04 FF
	isz	[*pa0x00]	; 05 00
	;...
	isz	[*pa0x7F]	; 05 7F
	isz	[pa4x00]	; 05 80
	;...
	isz	[pa4x7F]	; 05 FF

	.setpg 8
	base8 == .

	pa8x00 == base8 + 0x0000
	pa8x7F == base8 + 0x007F

	dca	*pa0x00		; 06 00
	;...
	dca	*pa0x7F		; 06 7F
	dca	pa8x00		; 06 80
	;...
	dca	pa8x7F		; 06 FF
	dca	*[pa0x00]	; 07 00
	;...
	dca	*[pa0x7F]	; 07 7F
	dca	[pa8x00]	; 07 80
	;...
	dca	[pa8x7F]	; 07 FF


	.page
	.setpg 16
	base16 == .

	pa16x00 == base16 + 0x0000
	pa16x7F == base16 + 0x007F

	jms	*pa0x00		; 08 00
	;...
	jms	*pa0x7F		; 08 7F
	jms	pa16x00		; 08 80
	;...
	jms	pa16x7F		; 08 FF
	jms	*[pa0x00]	; 09 00
	;...
	jms	*[pa0x7F]	; 09 7F
	jms	[pa16x00]	; 09 80
	;...
	jms	[pa16x7F]	; 09 FF

	.setpg 31
	base31 == .

	pa31x00 == base31 + 0x0000
	pa31x7F == base31 + 0x007F

	jmp	*pa0x00		; 0A 00
	;...
	jmp	*pa0x7F		; 0A 7F
	jmp	pa31x00		; 0A 80
	;...
	jmp	pa31x7F		; 0A FF
	jmp	*[pa0x00]	; 0B 00
	;...
	jmp	*[pa0x7F]	; 0B 7F
	jmp	[pa31x00]	; 0B 80
	;...
	jmp	[pa31x7F]	; 0B FF


	.page
	.sbttl	Multiple Page Tests

	.mempn	4
	.word	.		; 0F 88

	.mempa	0x280
	.word	.		; 0F 89


	.macro	test_setpg
	  ...a = 0
	  .rept	0d32
	    .setpg	...a
	    .word	1,2,3,4,5,.	; 00 01 00 02 00 03
	    ...a = ...a + 1
	  .endm
	.endm


	.list	(me,meb)

	test_setpg

	.word	.		; 0F 86


	.page
	.sbttl	Space and Data Directives

	; The 6100 has no concept of
	; a byte, only 12-Bit words.
	.byte	0xFFF0		; 00 F0
	.db	0xFEF1		; 00 F1
	.fcb	0xFDF2		; 00 F2

	.word	0xECF3		; 0C F3
	.dw	0xEBF4		; 0B F4
	.fdb	0xEAF5		; 0A F5

	.dubl	0xFEDCBA	; 0F ED 0C BA
	.4byte	0x987654	; 09 87 06 54
	.quad	0x123456	; 01 23 04 56

	.dubl	-3		; 0F FF 0F FD

	pc = .
	.blkb	1
	.word	.-pc		; 00 01
	.ds	2
	.word	.-pc		; 00 04
	.rs	3
	.word	.-pc		; 00 08
	.rmb	4
	.word	.-pc		; 00 0D

	pc = .
	.blkw	1
	.word	.-pc		; 00 01

	pc = .
	.blkd	1
	.word	.-pc		; 00 02
	.blk4	1
	.word	.-pc		; 00 05


	.page
	.sbttl	String and Text Directives

	.ascii	"AB"		; 00 41 00 42
	.asciz	"CD"		; 00 43 00 44 00 00
	.ascis	"EF"		; 00 45 00 C6
	.str	"GH"		; 00 47 00 48
	.strz	"IJ"		; 00 49 00 4A 00 00
	.strs	"KL"		; 00 4B 00 CC
	.fcc	"MNO"		; 00 4D 00 4E 00 4F

	.text	"a"		; 00 40
	.text	" a"		; 08 01
	.text	/!b"c/		; 08 42 08 83
	.text	" 0d1e"		; 08 30 01 31 01 40
	.text	"abcde"		; 00 42 00 C4 01 40

	.textz	"abcd"		; 00 42 00 C4 00 00

	.end

