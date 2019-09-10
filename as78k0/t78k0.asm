	.title	AS78K0 Sequential Opcode Test

	.xerr	2

	; Notes:
	;	Absolute addresses (CONSTANTS) will be checked as
	;	being in the 'saddr' range first and then as being
	;	in the 'sfr' range if no explicit @ or * is specified.
	;
	;	!  -  address is NOT PC Relative
	;	#  -  immediate value
	;	@  -  force 'saddr' address (0xFE20-0xFF1F)
	;	*  -  force   'sfr' address (0xFF00-0xFFCF, 0xFFE0-0xFFFF)
	;
	;	If the 'sfr' or 'saddr' address is external then the
	;	user is responsible to ensure the addresses are in the
	;	proper ranges.  NO ERRORS will be reported by the linker.

			; sfr addresses
	sfrFF00		=	0xFF00
	sfrFF21		=	0xFF21

			; saddr addresses
	saddrFE20	=	0xFE20
	saddrFF17	=	0xFF17

			; Byte values

	byt01		=	0x01
	byt23		=	0x23
	byt45		=	0x45
	byt67		=	0x67

			; addr11 addresses
	addr11		=	0x0865

			; addr16 addresses
	addr16		=	0xE016

			; bit addresses
	bit0		=	0
	bit1		=	1
	bit2		=	2
	bit3		=	3
	bit4		=	4
	bit5		=	5
	bit6		=	6
	bit7		=	7

			; Indirect addresses
	ind40		=	0x40
	ind50		=	0x50
	ind60		=	0x60
	ind70		=	0x70


	.page
	.sbttl	Derived Mnemonics

	ei					; 7A 1E
	di					; 7B 1E
	set1	psw.3				; 3A 1E
	clr1	psw.5				; 5B 1E
	bt	psw.1,.				; 9C 1E FD
	bf	psw.7,.				; 31 73 1E FC

	.page
	.sbttl	Alternate Register Designations

	mov	r1,r0				; 60
	; ------				; 61 - PG61 Extension
	mov	r1,r2				; 62
	mov	r1,r3				; 63
	mov	r1,r4				; 64
	mov	r1,r5				; 65
	mov	r1,r6				; 66
	mov	r1,r7				; 67

	mov	r0,r1				; 70
	; ------				; 71 - PG71 Extension
	mov	r2,r1				; 72
	mov	r3,r1				; 73
	mov	r4,r1				; 74
	mov	r5,r1				; 75
	mov	r6,r1				; 76
	mov	r7,r1				; 77

	.page
	.sbttl	Base Page Sequential

	nop					; 00
	not1	cy				; 01
	movw	ax,addr16			; 02 16 E0
	movw	addr16,ax			; 03 16 E0
	dbnz	saddrFF17,.			; 04 17 FD
	xch	a,[de]				; 05
	; ------				; 06
	xch	a,[hl]				; 07
	add	a,addr16			; 08 16 E0
	add	a,[hl+byt67]			; 09 67
	set1	saddrFF17.bit0			; 0A 17
	clr1	saddrFF17.bit0			; 0B 17
	callf	addr11+0x0000			; 0C 65
	add	a,#byt45			; 0D 45
	add	a,saddrFE20			; 0E 20
	add	a,[hl]				; 0F

	movw	ax,#0x1234			; 10 34 12
	mov	saddrFE20,#byt01		; 11 20 01
	mov	psw,#byt01			; 11 1E 01
	movw	bc,#0x6789			; 12 89 67
	mov	sfrFF21,#byt23			; 13 21 23
	movw	de,#0x2345			; 14 45 23
	; ------				; 15
	movw	hl,#0x0189			; 16 89 01
	; ------				; 17
	sub	a,addr16			; 18 16 E0
	sub	a,[hl+byt67]			; 19 67
	set1	saddrFF17.bit1			; 1A 17
	clr1	saddrFF17.bit1			; 1B 17
	callf	addr11+0x0100			; 1C 65
	sub	a,#byt45			; 1D 45
	sub	a,saddrFE20			; 1E 20
	sub	a,[hl]				; 1F

	set1	cy				; 20
	clr1	cy				; 21
	push	psw				; 22
	pop	psw				; 23
	ror	a,1				; 24
	rorc	a,1				; 25
	rol	a,1				; 26
	rolc	a,1				; 27
	addc	a,addr16			; 28 16 E0
	addc	a,[hl+byt67]			; 29 67
	set1	saddrFF17.bit2			; 2A 17
	clr1	saddrFF17.bit2			; 2B 17
	callf	addr11+0x0200			; 2C 65
	addc	a,#byt45			; 2D 45
	addc	a,saddrFE20			; 2E 20
	addc	a,[hl]				; 2F

	.page

	xch	a,x				; 30
	; ------				; 31 - PG31 Extension
	xch	a,c				; 32
	xch	a,b				; 33
	xch	a,e				; 34
	xch	a,d				; 35
	xch	a,l				; 36
	xch	a,h				; 37
	subc	a,addr16			; 38 16 E0
	subc	a,[hl+byt67]			; 39 67
	set1	saddrFF17.bit3			; 3A 17
	clr1	saddrFF17.bit3			; 3B 17
	callf	addr11+0x0300			; 3C 65
	subc	a,#byt45			; 3D 45
	subc	a,saddrFE20			; 3E 20
	subc	a,[hl]				; 3F

	inc	x				; 40
	inc	a				; 41
	inc	c				; 42
	inc	b				; 43
	inc	e				; 44
	inc	d				; 45
	inc	l				; 46
	inc	h				; 47
	cmp	a,addr16			; 48 16 E0
	cmp	a,[hl+byt23]			; 49 23
	set1	saddrFF17.bit4			; 4A 17
	clr1	saddrFF17.bit4			; 4B 17
	callf	addr11+0x0400			; 4C 65
	cmp	a,#byt23			; 4D 23
	cmp	a,saddrFE20			; 4E 20
	cmp	a,[hl]				; 4F

	dec	x				; 50
	dec	a				; 51
	dec	c				; 52
	dec	b				; 53
	dec	e				; 54
	dec	d				; 55
	dec	l				; 56
	dec	h				; 57
	and	a,addr16			; 58 16 E0
	and	a,[hl+byt67]			; 59 67
	set1	saddrFF17.bit5			; 5A 17
	clr1	saddrFF17.bit5			; 5B 17
	callf	addr11+0x0500			; 5C 65
	and	a,#byt45			; 5D 45
	and	a,saddrFE20			; 5E 20
	and	a,[hl]				; 5F

	.page

	mov	a,x				; 60
	; ------				; 61 - PG61 Extension
	mov	a,c				; 62
	mov	a,b				; 63
	mov	a,e				; 64
	mov	a,d				; 65
	mov	a,l				; 66
	mov	a,h				; 67
	or	a,addr16			; 68 16 E0
	or	a,[hl+byt67]			; 69 67
	set1	saddrFF17.bit6			; 6A 17
	clr1	saddrFF17.bit6			; 6B 17
	callf	addr11+0x0600			; 6C 65
	or	a,#byt45			; 6D 45
	or	a,saddrFE20			; 6E 20
	or	a,[hl]				; 6F

	mov	x,a				; 70
	; ------				; 71 - PG71 Extension
	mov	c,a				; 72
	mov	b,a				; 73
	mov	e,a				; 74
	mov	d,a				; 75
	mov	l,a				; 76
	mov	h,a				; 77
	xor	a,addr16			; 78 16 E0
	xor	a,[hl+byt23]			; 79 23
	set1	saddrFF17.bit7			; 7A 17
	clr1	saddrFF17.bit7			; 7B 17
	callf	addr11+0x0700			; 7C 65
	xor	a,#byt01			; 7D 01
	xor	a,saddrFF17			; 7E 17
	xor	a,[hl]				; 7F

	incw	ax				; 80
	inc	saddrFE20			; 81 20
	incw	bc				; 82
	xch	a,saddrFE20			; 83 20
	incw	de				; 84
	mov	a,[de]				; 85
	incw	hl				; 86
	mov	a,[hl]				; 87
	add	saddrFF17,#byt23		; 88 17 23
	movw	ax,saddrFF17			; 89 17
	movw	ax,sp				; 89 1C
	dbnz	c,.				; 8A FE
	dbnz	b,.				; 8B FE
	bt	saddrFE20.bit0,.		; 8C 20 FD
	bc	.				; 8D FE
	mov	a,addr16			; 8E 16 E0
	reti					; 8F

	.page

	decw	ax				; 90
	dec	saddrFE20			; 91 20
	decw	bc				; 92
	xch	a,sfrFF21			; 93 21
	decw	de				; 94
	mov	[de],a				; 95
	decw	hl				; 96
	mov	[hl],a				; 97
	sub	saddrFF17,#byt23		; 98 17 23
	movw	saddrFF17,ax			; 99 17
	movw	sp,ax				; 99 1C
	call	addr16				; 9A 16 E0
	br	!addr16				; 9B 16 E0
	bt	saddrFE20.bit1,.		; 9C 20 FD
	bnc	.				; 9D FE
	mov	addr16,a			; 9E 16 E0
	retb					; 9F

	mov	x,#0x89				; A0 89
	mov	a,#0x89				; A1 89
	mov	c,#0x89				; A2 89
	mov	b,#0x89				; A3 89
	mov	e,#0x89				; A4 89
	mov	d,#0x89				; A5 89
	mov	l,#0x89				; A6 89
	mov	h,#0x89				; A7 89
	addc	saddrFF17,#byt23		; A8 17 23
	movw	ax,sfrFF21			; A9 21
	mov	a,[hl+c]			; AA
	mov	a,[hl+b]			; AB
	bt	saddrFE20.bit2,.		; AC 20 FD
	bz	.				; AD FE
	mov	a,[hl+byt45]			; AE 45
	ret					; AF

	pop	ax				; B0
	push	ax				; B1
	pop	bc				; B2
	push	bc				; B3
	pop	de				; B4
	push	de				; B5
	pop	hl				; B6
	push	hl				; B7
	subc	saddrFF17,#byt23		; B8 17 23
	movw	sfrFF21,ax			; B9 21
	mov	[hl+c],a			; BA
	mov	[hl+b],a			; BB
	bt	saddrFE20.bit3,.		; BC 20 FD
	bnz	.				; BD FE
	mov	[hl+byt67],a			; BE 67
	brk					; BF

	.page

	; ------				; C0
	callt	[ind40]				; C1
	movw	ax,bc				; C2
	callt	[ind40+2]			; C3
	movw	ax,de				; C4
	callt	[ind40+4]			; C5
	movw	ax,hl				; C6
	callt	[ind40+6]			; C7
	cmp	saddrFF17,#byt01		; C8 17 01
	callt	[ind40+8]			; C9
	addw	ax,#0x1234			; CA 34 12
	callt	[ind40+10]			; CB
	bt	saddrFE20.bit4,.		; CC 20 FD
	callt	[ind40+12]			; CD
	xch	a,addr16			; CE 16 E0
	callt	[ind40+14]			; CF

	; ------				; D0
	callt	[ind50]				; D1
	movw	bc,ax				; D2
	callt	[ind50+2]			; D3
	movw	de,ax				; D4
	callt	[ind50+4]			; D5
	movw	hl,ax				; D6
	callt	[ind50+6]			; D7
	and	saddrFF17,#byt23		; D8 17 23
	callt	[ind50+8]			; D9
	subw	ax,#0x1234			; DA 34 12
	callt	[ind50+10]			; DB
	bt	saddrFE20.bit5,.		; DC 20 FD
	callt	[ind50+12]			; DD
	xch	a,[hl+byt01]			; DE 01
	callt	[ind50+14]			; DF

	.page

	; ------				; E0
	callt	[ind60]				; E1
	xchw	ax,bc				; E2
	callt	[ind60+2]			; E3
	xchw	ax,de				; E4
	callt	[ind60+4]			; E5
	xchw	ax,hl				; E6
	callt	[ind60+6]			; E7
	or	saddrFF17,#byt23		; E8 17 23
	callt	[ind60+8]			; E9
	cmpw	ax,#0x1234			; EA 34 12
	callt	[ind60+10]			; EB
	bt	saddrFE20.bit6,.		; EC 20 FD
	callt	[ind60+12]			; ED
	movw	saddrFF17,#0x7856		; EE 17 56 78
	movw	sp,#0x7856			; EE 1C 56 78
	callt	[ind60+14]			; EF

	mov	a,saddrFF17			; F0 17
	mov	a,psw				; F0 1E
	callt	[ind70]				; F1
	mov	saddrFE20,a			; F2 20
	mov	psw,a				; F2 1E
	callt	[ind70+2]			; F3
	mov	a,sfrFF21			; F4 21
	callt	[ind70+4]			; F5
	mov	sfrFF21,a			; F6 21
	callt	[ind70+6]			; F7
	xor	saddrFE20,#byt67		; F8 20 67
	callt	[ind70+8]			; F9
	br	.				; FA FE
	callt	[ind70+10]			; FB
	bt	saddrFE20.bit7,.		; FC 20 FD
	callt	[ind70+12]			; FD
	movw	sfrFF21,#0x3412			; FE 21 12 34
	callt	[ind70+14]			; FF


	.page
	.sbttl	Extension Page 31 Sequential

	; ------				; 31 00
	btclr	saddrFE20.bit0,.		; 31 01 20 FC
	; ------				; 31 02
	bf	saddrFE20.bit0,.		; 31 03 20 FC
	; ------				; 31 04
	btclr	sfrFF21.bit0,.			; 31 05 21 FC
	bt	sfrFF21.bit0,.			; 31 06 21 FC
	bf	sfrFF21.bit0,.			; 31 07 21 FC
	; ------				; 31 08
	; ------				; 31 09
	add	a,[hl+c]			; 31 0A
	add	a,[hl+b]			; 31 0B
	; ------				; 31 0C
	btclr	a.bit0,.			; 31 0D FD
	bt	a.bit0,.			; 31 0E FD
	bf	a.bit0,.			; 31 0F FD

	; ------				; 31 10
	btclr	saddrFE20.bit1,.		; 31 11 20 FC
	; ------				; 31 12
	bf	saddrFE20.bit1,.		; 31 13 20 FC
	; ------				; 31 14
	btclr	sfrFF21.bit1,.			; 31 15 21 FC
	bt	sfrFF21.bit1,.			; 31 16 21 FC
	bf	sfrFF21.bit1,.			; 31 17 21 FC
	; ------				; 31 18
	; ------				; 31 19
	sub	a,[hl+c]			; 31 1A
	sub	a,[hl+b]			; 31 1B
	; ------				; 31 1C
	btclr	a.bit1,.			; 31 1D FD
	bt	a.bit1,.			; 31 1E FD
	bf	a.bit1,.			; 31 1F FD

	; ------				; 31 20
	btclr	saddrFE20.bit2,.		; 31 21 20 FC
	; ------				; 31 22
	bf	saddrFE20.bit2,.		; 31 23 20 FC
	; ------				; 31 24
	btclr	sfrFF21.bit2,.			; 31 25 21 FC
	bt	sfrFF21.bit2,.			; 31 26 21 FC
	bf	sfrFF21.bit2,.			; 31 27 21 FC
	; ------				; 31 28
	; ------				; 31 29
	addc	a,[hl+c]			; 31 2A
	addc	a,[hl+b]			; 31 2B
	; ------				; 31 2C
	btclr	a.bit2,.			; 31 2D FD
	bt	a.bit2,.			; 31 2E FD
	bf	a.bit2,.			; 31 2F FD

	.page

	; ------				; 31 30
	btclr	saddrFE20.bit3,.		; 31 31 20 FC
	; ------				; 31 32
	bf	saddrFE20.bit3,.		; 31 33 20 FC
	; ------				; 31 34
	btclr	sfrFF21.bit3,.			; 31 35 21 FC
	bt	sfrFF21.bit3,.			; 31 36 21 FC
	bf	sfrFF21.bit3,.			; 31 37 21 FC
	; ------				; 31 38
	; ------				; 31 39
	subc	a,[hl+c]			; 31 3A
	subc	a,[hl+b]			; 31 3B
	; ------				; 31 3C
	btclr	a.bit3,.			; 31 3D FD
	bt	a.bit3,.			; 31 3E FD
	bf	a.bit3,.			; 31 3F FD

	; ------				; 31 40
	btclr	saddrFE20.bit4,.		; 31 41 20 FC
	; ------				; 31 42
	bf	saddrFE20.bit4,.		; 31 43 20 FC
	; ------				; 31 44
	btclr	sfrFF21.bit4,.			; 31 45 21 FC
	bt	sfrFF21.bit4,.			; 31 46 21 FC
	bf	sfrFF21.bit4,.			; 31 47 21 FC
	; ------				; 31 48
	; ------				; 31 49
	cmp	a,[hl+c]			; 31 4A
	cmp	a,[hl+b]			; 31 4B
	; ------				; 31 4C
	btclr	a.bit4,.			; 31 4D FD
	bt	a.bit4,.			; 31 4E FD
	bf	a.bit4,.			; 31 4F FD

	; ------				; 31 50
	btclr	saddrFE20.bit5,.		; 31 51 20 FC
	; ------				; 31 52
	bf	saddrFE20.bit5,.		; 31 53 20 FC
	; ------				; 31 54
	btclr	sfrFF21.bit5,.			; 31 55 21 FC
	bt	sfrFF21.bit5,.			; 31 56 21 FC
	bf	sfrFF21.bit5,.			; 31 57 21 FC
	; ------				; 31 58
	; ------				; 31 59
	and	a,[hl+c]			; 31 5A
	and	a,[hl+b]			; 31 5B
	; ------				; 31 5C
	btclr	a.bit5,.			; 31 5D FD
	bt	a.bit5,.			; 31 5E FD
	bf	a.bit5,.			; 31 5F FD

	.page

	; ------				; 31 60
	btclr	saddrFE20.bit6,.		; 31 61 20 FC
	; ------				; 31 62
	bf	saddrFE20.bit6,.		; 31 63 20 FC
	; ------				; 31 64
	btclr	sfrFF21.bit6,.			; 31 65 21 FC
	bt	sfrFF21.bit6,.			; 31 66 21 FC
	bf	sfrFF21.bit6,.			; 31 67 21 FC
	; ------				; 31 68
	; ------				; 31 69
	or	a,[hl+c]			; 31 6A
	or	a,[hl+b]			; 31 6B
	; ------				; 31 6C
	btclr	a.bit6,.			; 31 6D FD
	bt	a.bit6,.			; 31 6E FD
	bf	a.bit6,.			; 31 6F FD

	; ------				; 31 70
	btclr	saddrFE20.bit7,.		; 31 71 20 FC
	; ------				; 31 72
	bf	saddrFE20.bit7,.		; 31 73 20 FC
	; ------				; 31 74
	btclr	sfrFF21.bit7,.			; 31 75 21 FC
	bt	sfrFF21.bit7,.			; 31 76 21 FC
	bf	sfrFF21.bit7,.			; 31 77 21 FC
	; ------				; 31 78
	; ------				; 31 79
	xor	a,[hl+c]			; 31 7A
	xor	a,[hl+b]			; 31 7B
	; ------				; 31 7C
	btclr	a.bit7,.			; 31 7D FD
	bt	a.bit7,.			; 31 7E FD
	bf	a.bit7,.			; 31 7F FD

	rol4	[hl]				; 31 80
	; ------				; 31 81
	divuw	c				; 31 82
	; ------				; 31 83
	; ------				; 31 84
	btclr	[hl].bit0,.			; 31 85 FD
	bt	[hl].bit0,.			; 31 86 FD
	bf	[hl].bit0,.			; 31 87 FD
	mulu	x				; 31 88
	; ------				; 31 89
	xch	a,[hl+c]			; 31 8A
	xch	a,[hl+b]			; 31 8B
	; ------				; 31 8C
	; ------				; 31 8D FD
	; ------				; 31 8E FD
	; ------				; 31 8F FD

	.page

	ror4	[hl]				; 31 90
	; ------				; 31 91
	; ------				; 31 92
	; ------				; 31 93
	; ------				; 31 94
	btclr	[hl].bit1,.			; 31 95 FD
	bt	[hl].bit1,.			; 31 96 FD
	bf	[hl].bit1,.			; 31 97 FD
	br	ax				; 31 98
	; ------				; 31 99
	; ------				; 31 9A
	; ------				; 31 9B
	; ------				; 31 9C
	; ------				; 31 9D
	; ------				; 31 9E
	; ------				; 31 9F

	; ------				; 31 A0
	; ------				; 31 A1
	; ------				; 31 A2
	; ------				; 31 A3
	; ------				; 31 A4
	btclr	[hl].bit2,.			; 31 A5 FD
	bt	[hl].bit2,.			; 31 A6 FD
	bf	[hl].bit2,.			; 31 A7 FD
	; ------				; 31 A8
	; ------				; 31 A9
	; ------				; 31 AA
	; ------				; 31 AB
	; ------				; 31 AC
	; ------				; 31 AD
	; ------				; 31 AE
	; ------				; 31 AF

	; ------				; 31 B0
	; ------				; 31 B1
	; ------				; 31 B2
	; ------				; 31 B3
	; ------				; 31 B4
	btclr	[hl].bit3,.			; 31 B5 FD
	bt	[hl].bit3,.			; 31 B6 FD
	bf	[hl].bit3,.			; 31 B7 FD
	; ------				; 31 B8
	; ------				; 31 B9
	; ------				; 31 BA
	; ------				; 31 BB
	; ------				; 31 BC
	; ------				; 31 BD
	; ------				; 31 BE
	; ------				; 31 BF

	.page

	; ------				; 31 C0
	; ------				; 31 C1
	; ------				; 31 C2
	; ------				; 31 C3
	; ------				; 31 C4
	btclr	[hl].bit4,.			; 31 C5 FD
	bt	[hl].bit4,.			; 31 C6 FD
	bf	[hl].bit4,.			; 31 C7 FD
	; ------				; 31 C8
	; ------				; 31 C9
	; ------				; 31 CA
	; ------				; 31 CB
	; ------				; 31 CC
	; ------				; 31 CD
	; ------				; 31 CE
	; ------				; 31 CF

	; ------				; 31 D0
	; ------				; 31 D1
	; ------				; 31 D2
	; ------				; 31 D3
	; ------				; 31 D4
	btclr	[hl].bit5,.			; 31 D5 FD
	bt	[hl].bit5,.			; 31 D6 FD
	bf	[hl].bit5,.			; 31 D7 FD
	; ------				; 31 D8
	; ------				; 31 D9
	; ------				; 31 DA
	; ------				; 31 DB
	; ------				; 31 DC
	; ------				; 31 DD
	; ------				; 31 DE
	; ------				; 31 DF

	.page

	; ------				; 31 E0
	; ------				; 31 E1
	; ------				; 31 E2
	; ------				; 31 E3
	; ------				; 31 E4
	btclr	[hl].bit6,.			; 31 E5 FD
	bt	[hl].bit6,.			; 31 E6 FD
	bf	[hl].bit6,.			; 31 E7 FD
	; ------				; 31 E8
	; ------				; 31 E9
	; ------				; 31 EA
	; ------				; 31 EB
	; ------				; 31 EC
	; ------				; 31 ED
	; ------				; 31 EE
	; ------				; 31 EF

	; ------				; 31 F0
	; ------				; 31 F1
	; ------				; 31 F2
	; ------				; 31 F3
	; ------				; 31 F4
	btclr	[hl].bit7,.			; 31 F5 FD
	bt	[hl].bit7,.			; 31 F6 FD
	bf	[hl].bit7,.			; 31 F7 FD
	; ------				; 31 F8
	; ------				; 31 F9
	; ------				; 31 FA
	; ------				; 31 FB
	; ------				; 31 FC
	; ------				; 31 FD
	; ------				; 31 FE
	; ------				; 31 FF


	.page
	.sbttl	Extension Page 61 Sequential

	add	x,a				; 61 00
	add	a,a				; 61 01
	add	c,a				; 61 02
	add	b,a				; 61 03
	add	e,a				; 61 04
	add	d,a				; 61 05
	add	l,a				; 61 06
	add	h,a				; 61 07
	add	a,x				; 61 08
	; ------				; 61 09
	add	a,c				; 61 0A
	add	a,b				; 61 0B
	add	a,e				; 61 0C
	add	a,d				; 61 0D
	add	a,l				; 61 0E
	add	a,h				; 61 0F

	sub	x,a				; 61 10
	sub	a,a				; 61 11
	sub	c,a				; 61 12
	sub	b,a				; 61 13
	sub	e,a				; 61 14
	sub	d,a				; 61 15
	sub	l,a				; 61 16
	sub	h,a				; 61 17
	sub	a,x				; 61 18
	; ------				; 61 19
	sub	a,c				; 61 1A
	sub	a,b				; 61 1B
	sub	a,e				; 61 1C
	sub	a,d				; 61 1D
	sub	a,l				; 61 1E
	sub	a,h				; 61 1F

	addc	x,a				; 61 20
	addc	a,a				; 61 21
	addc	c,a				; 61 22
	addc	b,a				; 61 23
	addc	e,a				; 61 24
	addc	d,a				; 61 25
	addc	l,a				; 61 26
	addc	h,a				; 61 27
	addc	a,x				; 61 28
	; ------				; 61 29
	addc	a,c				; 61 2A
	addc	a,b				; 61 2B
	addc	a,e				; 61 2C
	addc	a,d				; 61 2D
	addc	a,l				; 61 2E
	addc	a,h				; 61 2F

	.page

	subc	x,a				; 61 30
	subc	a,a				; 61 31
	subc	c,a				; 61 32
	subc	b,a				; 61 33
	subc	e,a				; 61 34
	subc	d,a				; 61 35
	subc	l,a				; 61 36
	subc	h,a				; 61 37
	subc	a,x				; 61 38
	; ------				; 61 39
	subc	a,c				; 61 3A
	subc	a,b				; 61 3B
	subc	a,e				; 61 3C
	subc	a,d				; 61 3D
	subc	a,l				; 61 3E
	subc	a,h				; 61 3F

	cmp	x,a				; 61 40
	cmp	a,a				; 61 41
	cmp	c,a				; 61 42
	cmp	b,a				; 61 43
	cmp	e,a				; 61 44
	cmp	d,a				; 61 45
	cmp	l,a				; 61 46
	cmp	h,a				; 61 47
	cmp	a,x				; 61 48
	; ------				; 61 49
	cmp	a,c				; 61 4A
	cmp	a,b				; 61 4B
	cmp	a,e				; 61 4C
	cmp	a,d				; 61 4D
	cmp	a,l				; 61 4E
	cmp	a,h				; 61 4F

	and	x,a				; 61 50
	and	a,a				; 61 51
	and	c,a				; 61 52
	and	b,a				; 61 53
	and	e,a				; 61 54
	and	d,a				; 61 55
	and	l,a				; 61 56
	and	h,a				; 61 57
	and	a,x				; 61 58
	; ------				; 61 59
	and	a,c				; 61 5A
	and	a,b				; 61 5B
	and	a,e				; 61 5C
	and	a,d				; 61 5D
	and	a,l				; 61 5E
	and	a,h				; 61 5F

	.page

	or	x,a				; 61 60
	or	a,a				; 61 61
	or	c,a				; 61 62
	or	b,a				; 61 63
	or	e,a				; 61 64
	or	d,a				; 61 65
	or	l,a				; 61 66
	or	h,a				; 61 67
	or	a,x				; 61 68
	; ------				; 61 69
	or	a,c				; 61 6A
	or	a,b				; 61 6B
	or	a,e				; 61 6C
	or	a,d				; 61 6D
	or	a,l				; 61 6E
	or	a,h				; 61 6F

	xor	x,a				; 61 70
	xor	a,a				; 61 71
	xor	c,a				; 61 72
	xor	b,a				; 61 73
	xor	e,a				; 61 74
	xor	d,a				; 61 75
	xor	l,a				; 61 76
	xor	h,a				; 61 77
	xor	a,x				; 61 78
	; ------				; 61 79
	xor	a,c				; 61 7A
	xor	a,b				; 61 7B
	xor	a,e				; 61 7C
	xor	a,d				; 61 7D
	xor	a,l				; 61 7E
	xor	a,h				; 61 7F

	adjba					; 61 80
	; ------				; 61 81
	; ------				; 61 82
	; ------				; 61 83
	; ------				; 61 84
	; ------				; 61 85
	; ------				; 61 86
	; ------				; 61 87
	; ------				; 61 88
	mov1	a.0,cy				; 61 89
	set1	a.0				; 61 8A
	clr1	a.0				; 61 8B
	mov1	cy,a.0				; 61 8C
	and1	cy,a.0				; 61 8D
	or1	cy,a.0				; 61 8E
	xor1	cy,a.0				; 61 8F

	.page

	adjbs					; 61 90
	; ------				; 61 91
	; ------				; 61 92
	; ------				; 61 93
	; ------				; 61 94
	; ------				; 61 95
	; ------				; 61 96
	; ------				; 61 97
	; ------				; 61 98
	mov1	a.1,cy				; 61 99
	set1	a.1				; 61 9A
	clr1	a.1				; 61 9B
	mov1	cy,a.1				; 61 9C
	and1	cy,a.1				; 61 9D
	or1	cy,a.1				; 61 9E
	xor1	cy,a.1				; 61 9F

	; ------				; 61 A0
	; ------				; 61 A1
	; ------				; 61 A2
	; ------				; 61 A3
	; ------				; 61 A4
	; ------				; 61 A5
	; ------				; 61 A6
	; ------				; 61 A7
	; ------				; 61 A8
	mov1	a.2,cy				; 61 A9
	set1	a.2				; 61 AA
	clr1	a.2				; 61 AB
	mov1	cy,a.2				; 61 AC
	and1	cy,a.2				; 61 AD
	or1	cy,a.2				; 61 AE
	xor1	cy,a.2				; 61 AF

	; ------				; 61 B0
	; ------				; 61 B1
	; ------				; 61 B2
	; ------				; 61 B3
	; ------				; 61 B4
	; ------				; 61 B5
	; ------				; 61 B6
	; ------				; 61 B7
	; ------				; 61 B8
	mov1	a.3,cy				; 61 B9
	set1	a.3				; 61 BA
	clr1	a.3				; 61 BB
	mov1	cy,a.3				; 61 BC
	and1	cy,a.3				; 61 BD
	or1	cy,a.3				; 61 BE
	xor1	cy,a.3				; 61 BF

	.page

	; ------				; 61 C0
	; ------				; 61 C1
	; ------				; 61 C2
	; ------				; 61 C3
	; ------				; 61 C4
	; ------				; 61 C5
	; ------				; 61 C6
	; ------				; 61 C7
	; ------				; 61 C8
	mov1	a.4,cy				; 61 C9
	set1	a.4				; 61 CA
	clr1	a.4				; 61 CB
	mov1	cy,a.4				; 61 CC
	and1	cy,a.4				; 61 CD
	or1	cy,a.4				; 61 CE
	xor1	cy,a.4				; 61 CF

	sel	rb0				; 61 D0
	; ------				; 61 D1
	; ------				; 61 D2
	; ------				; 61 D3
	; ------				; 61 D4
	; ------				; 61 D5
	; ------				; 61 D6
	; ------				; 61 D7
	sel	rb1				; 61 D8
	mov1	a.5,cy				; 61 D9
	set1	a.5				; 61 DA
	clr1	a.5				; 61 DB
	mov1	cy,a.5				; 61 DC
	and1	cy,a.5				; 61 DD
	or1	cy,a.5				; 61 DE
	xor1	cy,a.5				; 61 DF

	.page

	; ------				; 61 E0
	; ------				; 61 E1
	; ------				; 61 E2
	; ------				; 61 E3
	; ------				; 61 E4
	; ------				; 61 E5
	; ------				; 61 E6
	; ------				; 61 E7
	; ------				; 61 E8
	mov1	a.6,cy				; 61 E9
	set1	a.6				; 61 EA
	clr1	a.6				; 61 EB
	mov1	cy,a.6				; 61 EC
	and1	cy,a.6				; 61 ED
	or1	cy,a.6				; 61 EE
	xor1	cy,a.6				; 61 EF

	sel	rb2				; 61 F0
	; ------				; 61 F1
	; ------				; 61 F2
	; ------				; 61 F3
	; ------				; 61 F4
	; ------				; 61 F5
	; ------				; 61 F6
	; ------				; 61 F7
	sel	rb3				; 61 F8
	mov1	a.7,cy				; 61 F9
	set1	a.7				; 61 FA
	clr1	a.7				; 61 FB
	mov1	cy,a.7				; 61 FC
	and1	cy,a.7				; 61 FD
	or1	cy,a.7				; 61 FE
	xor1	cy,a.7				; 61 FF


	.page
	.sbttl	Extension Page 71 Sequential

	stop					; 71 00
	mov1	saddrFE20.0,cy			; 71 01 20
	; ------				; 71 02
	; ------				; 71 03
	mov1	cy,saddrFE20.0			; 71 04 20
	and1	cy,saddrFE20.0			; 71 05 20
	or1	cy,saddrFE20.0			; 71 06 20
	xor1	cy,saddrFE20.0			; 71 07 20
	; ------				; 71 08
	mov1	sfrFF21.0,cy			; 71 09 21
	set1	sfrFF21.0			; 71 0A 21
	clr1	sfrFF21.0			; 71 0B 21
	mov1	cy,sfrFF21.0			; 71 0C 21
	and1	cy,sfrFF21.0			; 71 0D 21
	or1	cy,sfrFF21.0			; 71 0E 21
	xor1	cy,sfrFF21.0			; 71 0F 21

	halt					; 71 10
	mov1	saddrFE20.1,cy			; 71 11 20
	; ------				; 71 12
	; ------				; 71 13
	mov1	cy,saddrFE20.1			; 71 14 20
	and1	cy,saddrFE20.1			; 71 15 20
	or1	cy,saddrFE20.1			; 71 16 20
	xor1	cy,saddrFE20.1			; 71 17 20
	; ------				; 71 18
	mov1	sfrFF21.1,cy			; 71 19 21
	set1	sfrFF21.1			; 71 1A 21
	clr1	sfrFF21.1			; 71 1B 21
	mov1	cy,sfrFF21.1			; 71 1C 21
	and1	cy,sfrFF21.1			; 71 1D 21
	or1	cy,sfrFF21.1			; 71 1E 21
	xor1	cy,sfrFF21.1			; 71 1F 21

	; ------				; 71 20
	mov1	saddrFE20.2,cy			; 71 21 20
	; ------				; 71 22
	; ------				; 71 23
	mov1	cy,saddrFE20.2			; 71 24 20
	and1	cy,saddrFE20.2			; 71 25 20
	or1	cy,saddrFE20.2			; 71 26 20
	xor1	cy,saddrFE20.2			; 71 27 20
	; ------				; 71 28
	mov1	sfrFF21.2,cy			; 71 29 21
	set1	sfrFF21.2			; 71 2A 21
	clr1	sfrFF21.2			; 71 2B 21
	mov1	cy,sfrFF21.2			; 71 2C 21
	and1	cy,sfrFF21.2			; 71 2D 21
	or1	cy,sfrFF21.2			; 71 2E 21
	xor1	cy,sfrFF21.2			; 71 2F 21

	.page

	; ------				; 71 30
	mov1	saddrFE20.3,cy			; 71 31 20
	; ------				; 71 32
	; ------				; 71 33
	mov1	cy,saddrFE20.3			; 71 34 20
	and1	cy,saddrFE20.3			; 71 35 20
	or1	cy,saddrFE20.3			; 71 36 20
	xor1	cy,saddrFE20.3			; 71 37 20
	; ------				; 71 38
	mov1	sfrFF21.3,cy			; 71 39 21
	set1	sfrFF21.3			; 71 3A 21
	clr1	sfrFF21.3			; 71 3B 21
	mov1	cy,sfrFF21.3			; 71 3C 21
	and1	cy,sfrFF21.3			; 71 3D 21
	or1	cy,sfrFF21.3			; 71 3E 21
	xor1	cy,sfrFF21.3			; 71 3F 21

	; ------				; 71 40
	mov1	saddrFE20.4,cy			; 71 41 20
	; ------				; 71 42
	; ------				; 71 43
	mov1	cy,saddrFE20.4			; 71 44 20
	and1	cy,saddrFE20.4			; 71 45 20
	or1	cy,saddrFE20.4			; 71 46 20
	xor1	cy,saddrFE20.4			; 71 47 20
	; ------				; 71 48
	mov1	sfrFF21.4,cy			; 71 49 21
	set1	sfrFF21.4			; 71 4A 21
	clr1	sfrFF21.4			; 71 4B 21
	mov1	cy,sfrFF21.4			; 71 4C 21
	and1	cy,sfrFF21.4			; 71 4D 21
	or1	cy,sfrFF21.4			; 71 4E 21
	xor1	cy,sfrFF21.4			; 71 4F 21

	; ------				; 71 50
	mov1	saddrFE20.5,cy			; 71 51 20
	; ------				; 71 52
	; ------				; 71 53
	mov1	cy,saddrFE20.5			; 71 54 20
	and1	cy,saddrFE20.5			; 71 55 20
	or1	cy,saddrFE20.5			; 71 56 20
	xor1	cy,saddrFE20.5			; 71 57 20
	; ------				; 71 58
	mov1	sfrFF21.5,cy			; 71 59 21
	set1	sfrFF21.5			; 71 5A 21
	clr1	sfrFF21.5			; 71 5B 21
	mov1	cy,sfrFF21.5			; 71 5C 21
	and1	cy,sfrFF21.5			; 71 5D 21
	or1	cy,sfrFF21.5			; 71 5E 21
	xor1	cy,sfrFF21.5			; 71 5F 21

	.page

	; ------				; 71 60
	mov1	saddrFE20.6,cy			; 71 61 20
	; ------				; 71 62
	; ------				; 71 63
	mov1	cy,saddrFE20.6			; 71 64 20
	and1	cy,saddrFE20.6			; 71 65 20
	or1	cy,saddrFE20.6			; 71 66 20
	xor1	cy,saddrFE20.6			; 71 67 20
	; ------				; 71 68
	mov1	sfrFF21.6,cy			; 71 69 21
	set1	sfrFF21.6			; 71 6A 21
	clr1	sfrFF21.6			; 71 6B 21
	mov1	cy,sfrFF21.6			; 71 6C 21
	and1	cy,sfrFF21.6			; 71 6D 21
	or1	cy,sfrFF21.6			; 71 6E 21
	xor1	cy,sfrFF21.6			; 71 6F 21

	; ------				; 71 70
	mov1	saddrFE20.7,cy			; 71 71 20
	; ------				; 71 72
	; ------				; 71 73
	mov1	cy,saddrFE20.7			; 71 74 20
	and1	cy,saddrFE20.7			; 71 75 20
	or1	cy,saddrFE20.7			; 71 76 20
	xor1	cy,saddrFE20.7			; 71 77 20
	; ------				; 71 78
	mov1	sfrFF21.7,cy			; 71 79 21
	set1	sfrFF21.7			; 71 7A 21
	clr1	sfrFF21.7			; 71 7B 21
	mov1	cy,sfrFF21.7			; 71 7C 21
	and1	cy,sfrFF21.7			; 71 7D 21
	or1	cy,sfrFF21.7			; 71 7E 21
	xor1	cy,sfrFF21.7			; 71 7F 21

	; ------				; 71 80
	mov1	[hl].0,cy			; 71 81
	set1	[hl].0				; 71 82
	clr1	[hl].0				; 71 83
	mov1	cy,[hl].0			; 71 84
	and1	cy,[hl].0			; 71 85
	or1	cy,[hl].0			; 71 86
	xor1	cy,[hl].0			; 71 87
	; ------				; 71 88
	; ------				; 71 89
	; ------				; 71 8A
	; ------				; 71 8B
	; ------				; 71 8C
	; ------				; 71 8D
	; ------				; 71 8E
	; ------				; 71 8F

	.page

	; ------				; 71 90
	mov1	[hl].1,cy			; 71 91
	set1	[hl].1				; 71 92
	clr1	[hl].1				; 71 93
	mov1	cy,[hl].1			; 71 94
	and1	cy,[hl].1			; 71 95
	or1	cy,[hl].1			; 71 96
	xor1	cy,[hl].1			; 71 97
	; ------				; 71 98
	; ------				; 71 99
	; ------				; 71 9A
	; ------				; 71 9B
	; ------				; 71 9C
	; ------				; 71 9D
	; ------				; 71 9E
	; ------				; 71 9F

	; ------				; 71 A0
	mov1	[hl].2,cy			; 71 A1
	set1	[hl].2				; 71 A2
	clr1	[hl].2				; 71 A3
	mov1	cy,[hl].2			; 71 A4
	and1	cy,[hl].2			; 71 A5
	or1	cy,[hl].2			; 71 A6
	xor1	cy,[hl].2			; 71 A7
	; ------				; 71 A8
	; ------				; 71 A9
	; ------				; 71 AA
	; ------				; 71 AB
	; ------				; 71 AC
	; ------				; 71 AD
	; ------				; 71 AE
	; ------				; 71 AF

	; ------				; 71 B0
	mov1	[hl].3,cy			; 71 B1
	set1	[hl].3				; 71 B2
	clr1	[hl].3				; 71 B3
	mov1	cy,[hl].3			; 71 B4
	and1	cy,[hl].3			; 71 B5
	or1	cy,[hl].3			; 71 B6
	xor1	cy,[hl].3			; 71 B7
	; ------				; 71 B8
	; ------				; 71 B9
	; ------				; 71 BA
	; ------				; 71 BB
	; ------				; 71 BC
	; ------				; 71 BD
	; ------				; 71 BE
	; ------				; 71 BF

	.page

	; ------				; 71 C0
	mov1	[hl].4,cy			; 71 C1
	set1	[hl].4				; 71 C2
	clr1	[hl].4				; 71 C3
	mov1	cy,[hl].4			; 71 C4
	and1	cy,[hl].4			; 71 C5
	or1	cy,[hl].4			; 71 C6
	xor1	cy,[hl].4			; 71 C7
	; ------				; 71 C8
	; ------				; 71 C9
	; ------				; 71 CA
	; ------				; 71 CB
	; ------				; 71 CC
	; ------				; 71 CD
	; ------				; 71 CE
	; ------				; 71 CF

	; ------				; 71 D0
	mov1	[hl].5,cy			; 71 D1
	set1	[hl].5				; 71 D2
	clr1	[hl].5				; 71 D3
	mov1	cy,[hl].5			; 71 D4
	and1	cy,[hl].5			; 71 D5
	or1	cy,[hl].5			; 71 D6
	xor1	cy,[hl].5			; 71 D7
	; ------				; 71 D8
	; ------				; 71 D9
	; ------				; 71 DA
	; ------				; 71 DB
	; ------				; 71 DC
	; ------				; 71 DD
	; ------				; 71 DE
	; ------				; 71 DF

	.page

	; ------				; 71 E0
	mov1	[hl].6,cy			; 71 E1
	set1	[hl].6				; 71 E2
	clr1	[hl].6				; 71 E3
	mov1	cy,[hl].6			; 71 E4
	and1	cy,[hl].6			; 71 E5
	or1	cy,[hl].6			; 71 E6
	xor1	cy,[hl].6			; 71 E7
	; ------				; 71 E8
	; ------				; 71 E9
	; ------				; 71 EA
	; ------				; 71 EB
	; ------				; 71 EC
	; ------				; 71 ED
	; ------				; 71 EE
	; ------				; 71 EF

	; ------				; 71 F0
	mov1	[hl].7,cy			; 71 F1
	set1	[hl].7				; 71 F2
	clr1	[hl].7				; 71 F3
	mov1	cy,[hl].7			; 71 F4
	and1	cy,[hl].7			; 71 F5
	or1	cy,[hl].7			; 71 F6
	xor1	cy,[hl].7			; 71 F7
	; ------				; 71 F8
	; ------				; 71 F9
	; ------				; 71 FA
	; ------				; 71 FB
	; ------				; 71 FC
	; ------				; 71 FD
	; ------				; 71 FE
	; ------				; 71 FF


	.sbttl	AS78K0 Sequential Opcode Test With Externals

	; Notes:
	;	Absolute addresses (CONSTANTS) will be checked as
	;	being in the 'saddr' range first and then as being
	;	in the 'sfr' range if no explicit @ or * is specified.
	;
	;	!  -  address is NOT PC Relative
	;	#  -  immediate value
	;	@  -  force 'saddr' address (0xFE20-0xFF1F)
	;	*  -  force   'sfr' address (0xFF00-0xFFCF, 0xFFE0-0xFFFF)
	;
	;	If the 'sfr' or 'saddr' address is external then the
	;	user is responsible to ensure the addresses are in the
	;	proper ranges.  NO ERRORS will be reported by the linker.

			; sfr addresses
	.globl	xsfrFF		; =	0xFF00

			; saddr addresses
	.globl	xsaddrFE	; =	0xFE00
	.globl	xsaddrFF	; =	0xFF00

			; Byte values

	.globl	xbt		; =	0x00

 			; addr11 addresses
	.globl	xaddr11		; =	0x0000

			; addr16 addresses
	.globl	xaddr16		; =	0x0000

			; bit addresses
	.globl	xbt0		; =	0
	.globl	xbt1		; =	0
	.globl	xbt2		; =	0
	.globl	xbt3		; =	0
	.globl	xbt4		; =	0
	.globl	xbt5		; =	0
	.globl	xbt6		; =	0
	.globl	xbt7		; =	0

			; Indirect addresses
	.globl	xnd		; =	0x00



	.sbttl	Base Page Sequential

	nop					; 00
	not1	cy				; 01
	movw	ax,xaddr16+0xE016		; 02r16sE0
	movw	xaddr16+0xE016,ax		; 03r16sE0
	dbnz	@xsaddrFF+0x17,.		; 04r17 FD
	xch	a,[de]				; 05
	; ------				; 06
	xch	a,[hl]				; 07
	add	a,xaddr16+0xE016		; 08r16sE0
	add	a,[hl+xbt+0x67]			; 09r67
	set1	@xsaddrFF+0x17.xbt+0x00		;r0Ar17
	clr1	@xsaddrFF+0x17.xbt+0x00		;r0Br17
	callf	xaddr11+0x865			;r0Cs65
	add	a,#xbt+0x45			; 0Dr45
	add	a,@xsaddrFE+0x20		; 0Er20
	add	a,[hl]				; 0F

	movw	ax,#0x1234			; 10 34 12
	mov	@xsaddrFE+0x20,#xbt+0x01	; 11r20r01
	mov	psw,#xbt+0x01			; 11 1Er01
	movw	bc,#0x6789			; 12 89 67
	mov	*xsfrFF+0x21,#xbt+0x23		; 13*21r23
	movw	de,#0x2345			; 14 45 23
	; ------				; 15
	movw	hl,#0x0189			; 16 89 01
	; ------				; 17
	sub	a,xaddr16+0xE016		; 18r16sE0
	sub	a,[hl+xbt+0x67]			; 19r67
	set1	@xsaddrFF+0x17.xbt1+0x01	;r1Ar17
	clr1	@xsaddrFF+0x17.xbt1+0x01	;r1Br17
	callf	xaddr11+0x965			;r1Cs65
	sub	a,#xbt+0x45			; 1Dr45
	sub	a,@xsaddrFE+0x20		; 1Er20
	sub	a,[hl]				; 1F

	set1	cy				; 20
	clr1	cy				; 21
	push	psw				; 22
	pop	psw				; 23
	ror	a,1				; 24
	rorc	a,1				; 25
	rol	a,1				; 26
	rolc	a,1				; 27
	addc	a,xaddr16+0xE016		; 28r16sE0
	addc	a,[hl+xbt+0x67]			; 29r67
	set1	@xsaddrFF+0x17.xbt2+0x02	;r2Ar17
	clr1	@xsaddrFF+0x17.xbt2+0x02	;r2Br17
	callf	xaddr11+0xA65			;r2Cs65
	addc	a,#xbt+0x45			; 2Dr45
	addc	a,@xsaddrFE+0x20		; 2Er20
	addc	a,[hl]				; 2F


	xch	a,x				; 30
	; ------				; 31 - PG31 Extension
	xch	a,c				; 32
	xch	a,b				; 33
	xch	a,e				; 34
	xch	a,d				; 35
	xch	a,l				; 36
	xch	a,h				; 37
	subc	a,xaddr16+0xE016		; 38r16sE0
	subc	a,[hl+xbt+0x67]			; 39r67
	set1	@xsaddrFF+0x17.xbt3+0x03	;r3Ar17
	clr1	@xsaddrFF+0x17.xbt3+0x03	;r3Br17
	callf	xaddr11+0xB65			;r3Cs65
	subc	a,#xbt+0x45			; 3Dr45
	subc	a,@xsaddrFE+0x20		; 3Er20
	subc	a,[hl]				; 3F

	inc	x				; 40
	inc	a				; 41
	inc	c				; 42
	inc	b				; 43
	inc	e				; 44
	inc	d				; 45
	inc	l				; 46
	inc	h				; 47
	cmp	a,xaddr16+0xE016		; 48r16sE0
	cmp	a,[hl+xbt+0x23]			; 49r23
	set1	@xsaddrFF+0x17.xbt4+0x04	;r4Ar17
	clr1	@xsaddrFF+0x17.xbt4+0x04	;r4Br17
	callf	xaddr11+0xC65			;r4Cs65
	cmp	a,#xbt+0x23			; 4Dr23
	cmp	a,@xsaddrFE+0x20		; 4Er20
	cmp	a,[hl]				; 4F

	dec	x				; 50
	dec	a				; 51
	dec	c				; 52
	dec	b				; 53
	dec	e				; 54
	dec	d				; 55
	dec	l				; 56
	dec	h				; 57
	and	a,xaddr16+0xE016		; 58r16sE0
	and	a,[hl+xbt+0x67]			; 59r67
	set1	@xsaddrFF+0x17.xbt5+0x05	;r5Ar17
	clr1	@xsaddrFF+0x17.xbt5+0x05	;r5Br17
	callf	xaddr11+0xD65			;r5Cs65
	and	a,#xbt+0x45			; 5Dr45
	and	a,@xsaddrFE+0x20		; 5Er20
	and	a,[hl]				; 5F


	mov	a,x				; 60
	; ------				; 61 - PG61 Extension
	mov	a,c				; 62
	mov	a,b				; 63
	mov	a,e				; 64
	mov	a,d				; 65
	mov	a,l				; 66
	mov	a,h				; 67
	or	a,xaddr16+0xE016		; 68r16sE0
	or	a,[hl+xbt+0x67]			; 69r67
	set1	@xsaddrFF+0x17.xbt6+0x06	;r6Ar17
	clr1	@xsaddrFF+0x17.xbt6+0x06	;r6Br17
	callf	xaddr11+0xE65			;r6Cs65
	or	a,#xbt+0x45			; 6Dr45
	or	a,@xsaddrFE+0x20		; 6Er20
	or	a,[hl]				; 6F

	mov	x,a				; 70
	; ------				; 71 - PG71 Extension
	mov	c,a				; 72
	mov	b,a				; 73
	mov	e,a				; 74
	mov	d,a				; 75
	mov	l,a				; 76
	mov	h,a				; 77
	xor	a,xaddr16+0xE016		; 78r16sE0
	xor	a,[hl+xbt+0x23]			; 79r23
	set1	@xsaddrFF+0x17.xbt7+0x07	;r7Ar17
	clr1	@xsaddrFF+0x17.xbt7+0x07	;r7Br17
	callf	xaddr11+0xF65			;r7Cs65
	xor	a,#xbt+0x01			; 7Dr01
	xor	a,@xsaddrFF+0x17		; 7Er17
	xor	a,[hl]				; 7F

	incw	ax				; 80
	inc	@xsaddrFE+0x20			; 81r20
	incw	bc				; 82
	xch	a,@xsaddrFE+0x20		; 83r20
	incw	de				; 84
	mov	a,[de]				; 85
	incw	hl				; 86
	mov	a,[hl]				; 87
	add	@xsaddrFF+0x17,#xbt+0x23	; 88r17r23
	movw	ax,@xsaddrFF+0x17		; 89r17
	movw	ax,sp				; 89 1C
	dbnz	c,.				; 8A FE
	dbnz	b,.				; 8B FE
	bt	@xsaddrFE+0x20.xbt0+0x00,.	;r8Cr20 FD
	bc	.				; 8D FE
	mov	a,xaddr16+0xE016		; 8Er16sE0
	reti					; 8F


	decw	ax				; 90
	dec	@xsaddrFE+0x20			; 91r20
	decw	bc				; 92
	xch	a,*xsfrFF+0x21			; 93*21
	decw	de				; 94
	mov	[de],a				; 95
	decw	hl				; 96
	mov	[hl],a				; 97
	sub	@xsaddrFF+0x17,#xbt+0x23	; 98r17r23
	movw	@xsaddrFF+0x17,ax		; 99r17
	movw	sp,ax				; 99 1C
	call	xaddr16+0xE016			; 9Ar16sE0
	br	!xaddr16+0xE016			; 9Br16sE0
	bt	@xsaddrFE+0x20.xbt1+0x01,.	;r9Cr20 FD
	bnc	.				; 9D FE
	mov	xaddr16+0xE016,a		; 9Er16sE0
	retb					; 9F

	mov	x,#0x89				; A0 89
	mov	a,#0x89				; A1 89
	mov	c,#0x89				; A2 89
	mov	b,#0x89				; A3 89
	mov	e,#0x89				; A4 89
	mov	d,#0x89				; A5 89
	mov	l,#0x89				; A6 89
	mov	h,#0x89				; A7 89
	addc	@xsaddrFF+0x17,#xbt+0x23	; A8r17r23
	movw	ax,*xsfrFF+0x21			; A9*21
	mov	a,[hl+c]			; AA
	mov	a,[hl+b]			; AB
	bt	@xsaddrFE+0x20.xbt2+0x02,.	;rACr20 FD
	bz	.				; AD FE
	mov	a,[hl+xbt+0x45]			; AEr45
	ret					; AF

	pop	ax				; B0
	push	ax				; B1
	pop	bc				; B2
	push	bc				; B3
	pop	de				; B4
	push	de				; B5
	pop	hl				; B6
	push	hl				; B7
	subc	@xsaddrFF+0x17,#xbt+0x23	; B8r17r23
	movw	*xsfrFF+0x21,ax			; B9*21
	mov	[hl+c],a			; BA
	mov	[hl+b],a			; BB
	bt	@xsaddrFE+0x20.xbt3+0x03,.	;rBCr20 FD
	bnz	.				; BD FE
	mov	[hl+xbt+0x67],a			; BEr67
	brk					; BF


	; ------				; C0
	callt	[xnd+0x40]			;rC1
	movw	ax,bc				; C2
	callt	[xnd+0x40+2]			;rC3
	movw	ax,de				; C4
	callt	[xnd+0x40+4]			;rC5
	movw	ax,hl				; C6
	callt	[xnd+0x40+6]			;rC7
	cmp	@xsaddrFF+0x17,#xbt+0x01	; C8r17r01
	callt	[xnd+0x40+8]			;rC9
	addw	ax,#0x1234			; CA 34 12
	callt	[xnd+0x40+10]			;rCB
	bt	@xsaddrFE+0x20.xbt4+0x04,.	;rCCr20 FD
	callt	[xnd+0x40+12]			;rCD
	xch	a,xaddr16+0xE016		; CEr16sE0
	callt	[xnd+0x40+14]			;rCF

	; ------				; D0
	callt	[xnd+0x50]			;rD1
	movw	bc,ax				; D2
	callt	[xnd+0x50+2]			;rD3
	movw	de,ax				; D4
	callt	[xnd+0x50+4]			;rD5
	movw	hl,ax				; D6
	callt	[xnd+0x50+6]			;rD7
	and	@xsaddrFF+0x17,#xbt+0x23	; D8r17r23
	callt	[xnd+0x50+8]			;rD9
	subw	ax,#0x1234			; DA 34 12
	callt	[xnd+0x50+10]			;rDB
	bt	@xsaddrFE+0x20.xbt5+0x05,.	;rDCr20 FD
	callt	[xnd+0x50+12]			;rDD
	xch	a,[hl+xbt+0x01]			; DEr01
	callt	[xnd+0x50+14]			;rDF


	; ------				; E0
	callt	[xnd+0x60]			;rE1
	xchw	ax,bc				; E2
	callt	[xnd+0x60+2]			;rE3
	xchw	ax,de				; E4
	callt	[xnd+0x60+4]			;rE5
	xchw	ax,hl				; E6
	callt	[xnd+0x60+6]			;rE7
	or	@xsaddrFF+0x17,#xbt+0x23	; E8r17r23
	callt	[xnd+0x60+8]			;rE9
	cmpw	ax,#0x1234			; EA 34 12
	callt	[xnd+0x60+10]			;rEB
	bt	@xsaddrFE+0x20.xbt6+0x06,.	;rECr20 FD
	callt	[xnd+0x60+12]			;rED
	movw	@xsaddrFF+0x17,#0x7856		; EEr17 56 78
	movw	sp,#0x7856			; EE 1C 56 78
	callt	[xnd+0x60+14]			;rEF

	mov	a,@xsaddrFF+0x17		; F0r17
	mov	a,psw				; F0 1E
	callt	[xnd+0x70]			;rF1
	mov	@xsaddrFE+0x20,a		; F2r20
	mov	psw,a				; F2 1E
	callt	[xnd+0x70+2]			;rF3
	mov	a,*xsfrFF+0x21			; F4*21
	callt	[xnd+0x70+4]			;rF5
	mov	*xsfrFF+0x21,a			; F6*21
	callt	[xnd+0x70+6]			;rF7
	xor	@xsaddrFE+0x20,#xbt+0x67	; F8r20r67
	callt	[xnd+0x70+8]			;rF9
	br	.				; FA FE
	callt	[xnd+0x70+10]			;rFB
	bt	@xsaddrFE+0x20.xbt7+0x07,.	;rFCr20 FD
	callt	[xnd+0x70+12]			;rFD
	movw	*xsfrFF+0x21,#0x3412		; FE*21 12 34
	callt	[xnd+0x70+14]			;rFF


	.sbttl	Extension Page 31 Sequential

	; ------				; 31 00
	btclr	@xsaddrFE+0x20.xbt0+0x00,.	; 31r01r20 FC
	; ------				; 31 02
	bf	@xsaddrFE+0x20.xbt0+0x00,.	; 31r03r20 FC
	; ------				; 31 04
	btclr	*xsfrFF+0x21.xbt0+0x00,.	; 31r05*21 FC
	bt	*xsfrFF+0x21.xbt0+0x00,.	; 31r06*21 FC
	bf	*xsfrFF+0x21.xbt0+0x00,.	; 31r07*21 FC
	; ------				; 31 08
	; ------				; 31 09
	add	a,[hl+c]			; 31 0A
	add	a,[hl+b]			; 31 0B
	; ------				; 31 0C
	btclr	a.xbt0+0x00,.			; 31r0D FD
	bt	a.xbt0+0x00,.			; 31r0E FD
	bf	a.xbt0+0x00,.			; 31r0F FD

	; ------				; 31 10
	btclr	@xsaddrFE+0x20.xbt1+0x01,.	; 31r11r20 FC
	; ------				; 31 12
	bf	@xsaddrFE+0x20.xbt1+0x01,.	; 31r13r20 FC
	; ------				; 31 14
	btclr	*xsfrFF+0x21.xbt1+0x01,.	; 31r15*21 FC
	bt	*xsfrFF+0x21.xbt1+0x01,.	; 31r16*21 FC
	bf	*xsfrFF+0x21.xbt1+0x01,.	; 31r17*21 FC
	; ------				; 31 18
	; ------				; 31 19
	sub	a,[hl+c]			; 31 1A
	sub	a,[hl+b]			; 31 1B
	; ------				; 31 1C
	btclr	a.xbt1+0x01,.			; 31r1D FD
	bt	a.xbt1+0x01,.			; 31r1E FD
	bf	a.xbt1+0x01,.			; 31r1F FD

	; ------				; 31 20
	btclr	@xsaddrFE+0x20.xbt2+0x02,.	; 31r21r20 FC
	; ------				; 31 22
	bf	@xsaddrFE+0x20.xbt2+0x02,.	; 31r23r20 FC
	; ------				; 31 24
	btclr	*xsfrFF+0x21.xbt2+0x02,.	; 31r25*21 FC
	bt	*xsfrFF+0x21.xbt2+0x02,.	; 31r26*21 FC
	bf	*xsfrFF+0x21.xbt2+0x02,.	; 31r27*21 FC
	; ------				; 31 28
	; ------				; 31 29
	addc	a,[hl+c]			; 31 2A
	addc	a,[hl+b]			; 31 2B
	; ------				; 31 2C
	btclr	a.xbt2+0x02,.			; 31r2D FD
	bt	a.xbt2+0x02,.			; 31r2E FD
	bf	a.xbt2+0x02,.			; 31r2F FD


	; ------				; 31 30
	btclr	@xsaddrFE+0x20.xbt3+0x03,.	; 31r31r20 FC
	; ------				; 31 32
	bf	@xsaddrFE+0x20.xbt3+0x03,.	; 31r33r20 FC
	; ------				; 31 34
	btclr	*xsfrFF+0x21.xbt3+0x03,.	; 31r35*21 FC
	bt	*xsfrFF+0x21.xbt3+0x03,.	; 31r36*21 FC
	bf	*xsfrFF+0x21.xbt3+0x03,.	; 31r37*21 FC
	; ------				; 31 38
	; ------				; 31 39
	subc	a,[hl+c]			; 31 3A
	subc	a,[hl+b]			; 31 3B
	; ------				; 31 3C
	btclr	a.xbt3+0x03,.			; 31r3D FD
	bt	a.xbt3+0x03,.			; 31r3E FD
	bf	a.xbt3+0x03,.			; 31r3F FD

	; ------				; 31 40
	btclr	@xsaddrFE+0x20.xbt4+0x04,.	; 31r41r20 FC
	; ------				; 31 42
	bf	@xsaddrFE+0x20.xbt4+0x04,.	; 31r43r20 FC
	; ------				; 31 44
	btclr	*xsfrFF+0x21.xbt4+0x04,.	; 31r45*21 FC
	bt	*xsfrFF+0x21.xbt4+0x04,.	; 31r46*21 FC
	bf	*xsfrFF+0x21.xbt4+0x04,.	; 31r47*21 FC
	; ------				; 31 48
	; ------				; 31 49
	cmp	a,[hl+c]			; 31 4A
	cmp	a,[hl+b]			; 31 4B
	; ------				; 31 4C
	btclr	a.xbt4+0x04,.			; 31r4D FD
	bt	a.xbt4+0x04,.			; 31r4E FD
	bf	a.xbt4+0x04,.			; 31r4F FD

	; ------				; 31 50
	btclr	@xsaddrFE+0x20.xbt5+0x05,.	; 31r51r20 FC
	; ------				; 31 52
	bf	@xsaddrFE+0x20.xbt5+0x05,.	; 31r53r20 FC
	; ------				; 31 54
	btclr	*xsfrFF+0x21.xbt5+0x05,.	; 31r55*21 FC
	bt	*xsfrFF+0x21.xbt5+0x05,.	; 31r56*21 FC
	bf	*xsfrFF+0x21.xbt5+0x05,.	; 31r57*21 FC
	; ------				; 31 58
	; ------				; 31 59
	and	a,[hl+c]			; 31 5A
	and	a,[hl+b]			; 31 5B
	; ------				; 31 5C
	btclr	a.xbt5+0x05,.			; 31r5D FD
	bt	a.xbt5+0x05,.			; 31r5E FD
	bf	a.xbt5+0x05,.			; 31r5F FD


	; ------				; 31 60
	btclr	@xsaddrFE+0x20.xbt6+0x06,.	; 31r61r20 FC
	; ------				; 31 62
	bf	@xsaddrFE+0x20.xbt6+0x06,.	; 31r63r20 FC
	; ------				; 31 64
	btclr	*xsfrFF+0x21.xbt6+0x06,.	; 31r65*21 FC
	bt	*xsfrFF+0x21.xbt6+0x06,.	; 31r66*21 FC
	bf	*xsfrFF+0x21.xbt6+0x06,.	; 31r67*21 FC
	; ------				; 31 68
	; ------				; 31 69
	or	a,[hl+c]			; 31 6A
	or	a,[hl+b]			; 31 6B
	; ------				; 31 6C
	btclr	a.xbt6+0x06,.			; 31r6D FD
	bt	a.xbt6+0x06,.			; 31r6E FD
	bf	a.xbt6+0x06,.			; 31r6F FD

	; ------				; 31 70
	btclr	@xsaddrFE+0x20.xbt7+0x07,.	; 31r71r20 FC
	; ------				; 31 72
	bf	@xsaddrFE+0x20.xbt7+0x07,.	; 31r73r20 FC
	; ------				; 31 74
	btclr	*xsfrFF+0x21.xbt7+0x07,.	; 31r75*21 FC
	bt	*xsfrFF+0x21.xbt7+0x07,.	; 31r76*21 FC
	bf	*xsfrFF+0x21.xbt7+0x07,.	; 31r77*21 FC
	; ------				; 31 78
	; ------				; 31 79
	xor	a,[hl+c]			; 31 7A
	xor	a,[hl+b]			; 31 7B
	; ------				; 31 7C
	btclr	a.xbt7+0x07,.			; 31r7D FD
	bt	a.xbt7+0x07,.			; 31r7E FD
	bf	a.xbt7+0x07,.			; 31r7F FD

	rol4	[hl]				; 31 80
	; ------				; 31 81
	divuw	c				; 31 82
	; ------				; 31 83
	; ------				; 31 84
	btclr	[hl].xbt0+0x00,.		; 31r85 FD
	bt	[hl].xbt0+0x00,.		; 31r86 FD
	bf	[hl].xbt0+0x00,.		; 31r87 FD
	mulu	x				; 31 88
	; ------				; 31 89
	xch	a,[hl+c]			; 31 8A
	xch	a,[hl+b]			; 31 8B
	; ------				; 31 8C
	; ------				; 31 8D FD
	; ------				; 31 8E FD
	; ------				; 31 8F FD


	ror4	[hl]				; 31 90
	; ------				; 31 91
	; ------				; 31 92
	; ------				; 31 93
	; ------				; 31 94
	btclr	[hl].xbt1+0x01,.		; 31r95 FD
	bt	[hl].xbt1+0x01,.		; 31r96 FD
	bf	[hl].xbt1+0x01,.		; 31r97 FD
	br	ax				; 31 98
	; ------				; 31 99
	; ------				; 31 9A
	; ------				; 31 9B
	; ------				; 31 9C
	; ------				; 31 9D
	; ------				; 31 9E
	; ------				; 31 9F

	; ------				; 31 A0
	; ------				; 31 A1
	; ------				; 31 A2
	; ------				; 31 A3
	; ------				; 31 A4
	btclr	[hl].xbt2+0x02,.		; 31rA5 FD
	bt	[hl].xbt2+0x02,.		; 31rA6 FD
	bf	[hl].xbt2+0x02,.		; 31rA7 FD
	; ------				; 31 A8
	; ------				; 31 A9
	; ------				; 31 AA
	; ------				; 31 AB
	; ------				; 31 AC
	; ------				; 31 AD
	; ------				; 31 AE
	; ------				; 31 AF

	; ------				; 31 B0
	; ------				; 31 B1
	; ------				; 31 B2
	; ------				; 31 B3
	; ------				; 31 B4
	btclr	[hl].xbt3+0x03,.		; 31rB5 FD
	bt	[hl].xbt3+0x03,.		; 31rB6 FD
	bf	[hl].xbt3+0x03,.		; 31rB7 FD
	; ------				; 31 B8
	; ------				; 31 B9
	; ------				; 31 BA
	; ------				; 31 BB
	; ------				; 31 BC
	; ------				; 31 BD
	; ------				; 31 BE
	; ------				; 31 BF


	; ------				; 31 C0
	; ------				; 31 C1
	; ------				; 31 C2
	; ------				; 31 C3
	; ------				; 31 C4
	btclr	[hl].xbt4+0x04,.		; 31rC5 FD
	bt	[hl].xbt4+0x04,.		; 31rC6 FD
	bf	[hl].xbt4+0x04,.		; 31rC7 FD
	; ------				; 31 C8
	; ------				; 31 C9
	; ------				; 31 CA
	; ------				; 31 CB
	; ------				; 31 CC
	; ------				; 31 CD
	; ------				; 31 CE
	; ------				; 31 CF

	; ------				; 31 D0
	; ------				; 31 D1
	; ------				; 31 D2
	; ------				; 31 D3
	; ------				; 31 D4
	btclr	[hl].xbt5+0x05,.		; 31rD5 FD
	bt	[hl].xbt5+0x05,.		; 31rD6 FD
	bf	[hl].xbt5+0x05,.		; 31rD7 FD
	; ------				; 31 D8
	; ------				; 31 D9
	; ------				; 31 DA
	; ------				; 31 DB
	; ------				; 31 DC
	; ------				; 31 DD
	; ------				; 31 DE
	; ------				; 31 DF


	; ------				; 31 E0
	; ------				; 31 E1
	; ------				; 31 E2
	; ------				; 31 E3
	; ------				; 31 E4
	btclr	[hl].xbt6+0x06,.		; 31rE5 FD
	bt	[hl].xbt6+0x06,.		; 31rE6 FD
	bf	[hl].xbt6+0x06,.		; 31rE7 FD
	; ------				; 31 E8
	; ------				; 31 E9
	; ------				; 31 EA
	; ------				; 31 EB
	; ------				; 31 EC
	; ------				; 31 ED
	; ------				; 31 EE
	; ------				; 31 EF

	; ------				; 31 F0
	; ------				; 31 F1
	; ------				; 31 F2
	; ------				; 31 F3
	; ------				; 31 F4
	btclr	[hl].xbt7+0x07,.		; 31rF5 FD
	bt	[hl].xbt7+0x07,.		; 31rF6 FD
	bf	[hl].xbt7+0x07,.		; 31rF7 FD
	; ------				; 31 F8
	; ------				; 31 F9
	; ------				; 31 FA
	; ------				; 31 FB
	; ------				; 31 FC
	; ------				; 31 FD
	; ------				; 31 FE
	; ------				; 31 FF


	.sbttl	Extension Page 61 Sequential

	add	x,a				; 61 00
	add	a,a				; 61 01
	add	c,a				; 61 02
	add	b,a				; 61 03
	add	e,a				; 61 04
	add	d,a				; 61 05
	add	l,a				; 61 06
	add	h,a				; 61 07
	add	a,x				; 61 08
	; ------				; 61 09
	add	a,c				; 61 0A
	add	a,b				; 61 0B
	add	a,e				; 61 0C
	add	a,d				; 61 0D
	add	a,l				; 61 0E
	add	a,h				; 61 0F

	sub	x,a				; 61 10
	sub	a,a				; 61 11
	sub	c,a				; 61 12
	sub	b,a				; 61 13
	sub	e,a				; 61 14
	sub	d,a				; 61 15
	sub	l,a				; 61 16
	sub	h,a				; 61 17
	sub	a,x				; 61 18
	; ------				; 61 19
	sub	a,c				; 61 1A
	sub	a,b				; 61 1B
	sub	a,e				; 61 1C
	sub	a,d				; 61 1D
	sub	a,l				; 61 1E
	sub	a,h				; 61 1F

	addc	x,a				; 61 20
	addc	a,a				; 61 21
	addc	c,a				; 61 22
	addc	b,a				; 61 23
	addc	e,a				; 61 24
	addc	d,a				; 61 25
	addc	l,a				; 61 26
	addc	h,a				; 61 27
	addc	a,x				; 61 28
	; ------				; 61 29
	addc	a,c				; 61 2A
	addc	a,b				; 61 2B
	addc	a,e				; 61 2C
	addc	a,d				; 61 2D
	addc	a,l				; 61 2E
	addc	a,h				; 61 2F

	.page

	subc	x,a				; 61 30
	subc	a,a				; 61 31
	subc	c,a				; 61 32
	subc	b,a				; 61 33
	subc	e,a				; 61 34
	subc	d,a				; 61 35
	subc	l,a				; 61 36
	subc	h,a				; 61 37
	subc	a,x				; 61 38
	; ------				; 61 39
	subc	a,c				; 61 3A
	subc	a,b				; 61 3B
	subc	a,e				; 61 3C
	subc	a,d				; 61 3D
	subc	a,l				; 61 3E
	subc	a,h				; 61 3F

	cmp	x,a				; 61 40
	cmp	a,a				; 61 41
	cmp	c,a				; 61 42
	cmp	b,a				; 61 43
	cmp	e,a				; 61 44
	cmp	d,a				; 61 45
	cmp	l,a				; 61 46
	cmp	h,a				; 61 47
	cmp	a,x				; 61 48
	; ------				; 61 49
	cmp	a,c				; 61 4A
	cmp	a,b				; 61 4B
	cmp	a,e				; 61 4C
	cmp	a,d				; 61 4D
	cmp	a,l				; 61 4E
	cmp	a,h				; 61 4F

	and	x,a				; 61 50
	and	a,a				; 61 51
	and	c,a				; 61 52
	and	b,a				; 61 53
	and	e,a				; 61 54
	and	d,a				; 61 55
	and	l,a				; 61 56
	and	h,a				; 61 57
	and	a,x				; 61 58
	; ------				; 61 59
	and	a,c				; 61 5A
	and	a,b				; 61 5B
	and	a,e				; 61 5C
	and	a,d				; 61 5D
	and	a,l				; 61 5E
	and	a,h				; 61 5F

	.page

	or	x,a				; 61 60
	or	a,a				; 61 61
	or	c,a				; 61 62
	or	b,a				; 61 63
	or	e,a				; 61 64
	or	d,a				; 61 65
	or	l,a				; 61 66
	or	h,a				; 61 67
	or	a,x				; 61 68
	; ------				; 61 69
	or	a,c				; 61 6A
	or	a,b				; 61 6B
	or	a,e				; 61 6C
	or	a,d				; 61 6D
	or	a,l				; 61 6E
	or	a,h				; 61 6F

	xor	x,a				; 61 70
	xor	a,a				; 61 71
	xor	c,a				; 61 72
	xor	b,a				; 61 73
	xor	e,a				; 61 74
	xor	d,a				; 61 75
	xor	l,a				; 61 76
	xor	h,a				; 61 77
	xor	a,x				; 61 78
	; ------				; 61 79
	xor	a,c				; 61 7A
	xor	a,b				; 61 7B
	xor	a,e				; 61 7C
	xor	a,d				; 61 7D
	xor	a,l				; 61 7E
	xor	a,h				; 61 7F

	adjba					; 61 80
	; ------				; 61 81
	; ------				; 61 82
	; ------				; 61 83
	; ------				; 61 84
	; ------				; 61 85
	; ------				; 61 86
	; ------				; 61 87
	; ------				; 61 88
	mov1	a.0,cy				; 61 89
	set1	a.0				; 61 8A
	clr1	a.0				; 61 8B
	mov1	cy,a.0				; 61 8C
	and1	cy,a.0				; 61 8D
	or1	cy,a.0				; 61 8E
	xor1	cy,a.0				; 61 8F


	adjbs					; 61 90
	; ------				; 61 91
	; ------				; 61 92
	; ------				; 61 93
	; ------				; 61 94
	; ------				; 61 95
	; ------				; 61 96
	; ------				; 61 97
	; ------				; 61 98
	mov1	a.1,cy				; 61 99
	set1	a.1				; 61 9A
	clr1	a.1				; 61 9B
	mov1	cy,a.1				; 61 9C
	and1	cy,a.1				; 61 9D
	or1	cy,a.1				; 61 9E
	xor1	cy,a.1				; 61 9F

	; ------				; 61 A0
	; ------				; 61 A1
	; ------				; 61 A2
	; ------				; 61 A3
	; ------				; 61 A4
	; ------				; 61 A5
	; ------				; 61 A6
	; ------				; 61 A7
	; ------				; 61 A8
	mov1	a.2,cy				; 61 A9
	set1	a.2				; 61 AA
	clr1	a.2				; 61 AB
	mov1	cy,a.2				; 61 AC
	and1	cy,a.2				; 61 AD
	or1	cy,a.2				; 61 AE
	xor1	cy,a.2				; 61 AF

	; ------				; 61 B0
	; ------				; 61 B1
	; ------				; 61 B2
	; ------				; 61 B3
	; ------				; 61 B4
	; ------				; 61 B5
	; ------				; 61 B6
	; ------				; 61 B7
	; ------				; 61 B8
	mov1	a.3,cy				; 61 B9
	set1	a.3				; 61 BA
	clr1	a.3				; 61 BB
	mov1	cy,a.3				; 61 BC
	and1	cy,a.3				; 61 BD
	or1	cy,a.3				; 61 BE
	xor1	cy,a.3				; 61 BF


	; ------				; 61 C0
	; ------				; 61 C1
	; ------				; 61 C2
	; ------				; 61 C3
	; ------				; 61 C4
	; ------				; 61 C5
	; ------				; 61 C6
	; ------				; 61 C7
	; ------				; 61 C8
	mov1	a.4,cy				; 61 C9
	set1	a.4				; 61 CA
	clr1	a.4				; 61 CB
	mov1	cy,a.4				; 61 CC
	and1	cy,a.4				; 61 CD
	or1	cy,a.4				; 61 CE
	xor1	cy,a.4				; 61 CF

	sel	rb0				; 61 D0
	; ------				; 61 D1
	; ------				; 61 D2
	; ------				; 61 D3
	; ------				; 61 D4
	; ------				; 61 D5
	; ------				; 61 D6
	; ------				; 61 D7
	sel	rb1				; 61 D8
	mov1	a.5,cy				; 61 D9
	set1	a.5				; 61 DA
	clr1	a.5				; 61 DB
	mov1	cy,a.5				; 61 DC
	and1	cy,a.5				; 61 DD
	or1	cy,a.5				; 61 DE
	xor1	cy,a.5				; 61 DF


	; ------				; 61 E0
	; ------				; 61 E1
	; ------				; 61 E2
	; ------				; 61 E3
	; ------				; 61 E4
	; ------				; 61 E5
	; ------				; 61 E6
	; ------				; 61 E7
	; ------				; 61 E8
	mov1	a.6,cy				; 61 E9
	set1	a.6				; 61 EA
	clr1	a.6				; 61 EB
	mov1	cy,a.6				; 61 EC
	and1	cy,a.6				; 61 ED
	or1	cy,a.6				; 61 EE
	xor1	cy,a.6				; 61 EF

	sel	rb2				; 61 F0
	; ------				; 61 F1
	; ------				; 61 F2
	; ------				; 61 F3
	; ------				; 61 F4
	; ------				; 61 F5
	; ------				; 61 F6
	; ------				; 61 F7
	sel	rb3				; 61 F8
	mov1	a.7,cy				; 61 F9
	set1	a.7				; 61 FA
	clr1	a.7				; 61 FB
	mov1	cy,a.7				; 61 FC
	and1	cy,a.7				; 61 FD
	or1	cy,a.7				; 61 FE
	xor1	cy,a.7				; 61 FF


	.sbttl	Extension Page 71 Sequential

	stop					; 71 00
	mov1	@xsaddrFE+0x20.0,cy		; 71 01r20
	; ------				; 71 02
	; ------				; 71 03
	mov1	cy,@xsaddrFE+0x20.0		; 71 04r20
	and1	cy,@xsaddrFE+0x20.0		; 71 05r20
	or1	cy,@xsaddrFE+0x20.0		; 71 06r20
	xor1	cy,@xsaddrFE+0x20.0		; 71 07r20
	; ------				; 71 08
	mov1	*xsfrFF+0x21.0,cy		; 71 09*21
	set1	*xsfrFF+0x21.0			; 71 0A*21
	clr1	*xsfrFF+0x21.0			; 71 0B*21
	mov1	cy,*xsfrFF+0x21.0		; 71 0C*21
	and1	cy,*xsfrFF+0x21.0		; 71 0D*21
	or1	cy,*xsfrFF+0x21.0		; 71 0E*21
	xor1	cy,*xsfrFF+0x21.0		; 71 0F*21

	halt					; 71 10
	mov1	@xsaddrFE+0x20.1,cy		; 71 11r20
	; ------				; 71 12
	; ------				; 71 13
	mov1	cy,@xsaddrFE+0x20.1		; 71 14r20
	and1	cy,@xsaddrFE+0x20.1		; 71 15r20
	or1	cy,@xsaddrFE+0x20.1		; 71 16r20
	xor1	cy,@xsaddrFE+0x20.1		; 71 17r20
	; ------				; 71 18
	mov1	*xsfrFF+0x21.1,cy		; 71 19*21
	set1	*xsfrFF+0x21.1			; 71 1A*21
	clr1	*xsfrFF+0x21.1			; 71 1B*21
	mov1	cy,*xsfrFF+0x21.1		; 71 1C*21
	and1	cy,*xsfrFF+0x21.1		; 71 1D*21
	or1	cy,*xsfrFF+0x21.1		; 71 1E*21
	xor1	cy,*xsfrFF+0x21.1		; 71 1F*21

	; ------				; 71 20
	mov1	@xsaddrFE+0x20.2,cy		; 71 21r20
	; ------				; 71 22
	; ------				; 71 23
	mov1	cy,@xsaddrFE+0x20.2		; 71 24r20
	and1	cy,@xsaddrFE+0x20.2		; 71 25r20
	or1	cy,@xsaddrFE+0x20.2		; 71 26r20
	xor1	cy,@xsaddrFE+0x20.2		; 71 27r20
	; ------				; 71 28
	mov1	*xsfrFF+0x21.2,cy		; 71 29*21
	set1	*xsfrFF+0x21.2			; 71 2A*21
	clr1	*xsfrFF+0x21.2			; 71 2B*21
	mov1	cy,*xsfrFF+0x21.2		; 71 2C*21
	and1	cy,*xsfrFF+0x21.2		; 71 2D*21
	or1	cy,*xsfrFF+0x21.2		; 71 2E*21
	xor1	cy,*xsfrFF+0x21.2		; 71 2F*21


	; ------				; 71 30
	mov1	@xsaddrFE+0x20.3,cy		; 71 31r20
	; ------				; 71 32
	; ------				; 71 33
	mov1	cy,@xsaddrFE+0x20.3		; 71 34r20
	and1	cy,@xsaddrFE+0x20.3		; 71 35r20
	or1	cy,@xsaddrFE+0x20.3		; 71 36r20
	xor1	cy,@xsaddrFE+0x20.3		; 71 37r20
	; ------				; 71 38
	mov1	*xsfrFF+0x21.3,cy		; 71 39*21
	set1	*xsfrFF+0x21.3			; 71 3A*21
	clr1	*xsfrFF+0x21.3			; 71 3B*21
	mov1	cy,*xsfrFF+0x21.3		; 71 3C*21
	and1	cy,*xsfrFF+0x21.3		; 71 3D*21
	or1	cy,*xsfrFF+0x21.3		; 71 3E*21
	xor1	cy,*xsfrFF+0x21.3		; 71 3F*21

	; ------				; 71 40
	mov1	@xsaddrFE+0x20.4,cy		; 71 41r20
	; ------				; 71 42
	; ------				; 71 43
	mov1	cy,@xsaddrFE+0x20.4		; 71 44r20
	and1	cy,@xsaddrFE+0x20.4		; 71 45r20
	or1	cy,@xsaddrFE+0x20.4		; 71 46r20
	xor1	cy,@xsaddrFE+0x20.4		; 71 47r20
	; ------				; 71 48
	mov1	*xsfrFF+0x21.4,cy		; 71 49*21
	set1	*xsfrFF+0x21.4			; 71 4A*21
	clr1	*xsfrFF+0x21.4			; 71 4B*21
	mov1	cy,*xsfrFF+0x21.4		; 71 4C*21
	and1	cy,*xsfrFF+0x21.4		; 71 4D*21
	or1	cy,*xsfrFF+0x21.4		; 71 4E*21
	xor1	cy,*xsfrFF+0x21.4		; 71 4F*21

	; ------				; 71 50
	mov1	@xsaddrFE+0x20.5,cy		; 71 51r20
	; ------				; 71 52
	; ------				; 71 53
	mov1	cy,@xsaddrFE+0x20.5		; 71 54r20
	and1	cy,@xsaddrFE+0x20.5		; 71 55r20
	or1	cy,@xsaddrFE+0x20.5		; 71 56r20
	xor1	cy,@xsaddrFE+0x20.5		; 71 57r20
	; ------				; 71 58
	mov1	*xsfrFF+0x21.5,cy		; 71 59*21
	set1	*xsfrFF+0x21.5			; 71 5A*21
	clr1	*xsfrFF+0x21.5			; 71 5B*21
	mov1	cy,*xsfrFF+0x21.5		; 71 5C*21
	and1	cy,*xsfrFF+0x21.5		; 71 5D*21
	or1	cy,*xsfrFF+0x21.5		; 71 5E*21
	xor1	cy,*xsfrFF+0x21.5		; 71 5F*21


	; ------				; 71 60
	mov1	@xsaddrFE+0x20.6,cy		; 71 61r20
	; ------				; 71 62
	; ------				; 71 63
	mov1	cy,@xsaddrFE+0x20.6		; 71 64r20
	and1	cy,@xsaddrFE+0x20.6		; 71 65r20
	or1	cy,@xsaddrFE+0x20.6		; 71 66r20
	xor1	cy,@xsaddrFE+0x20.6		; 71 67r20
	; ------				; 71 68
	mov1	*xsfrFF+0x21.6,cy		; 71 69*21
	set1	*xsfrFF+0x21.6			; 71 6A*21
	clr1	*xsfrFF+0x21.6			; 71 6B*21
	mov1	cy,*xsfrFF+0x21.6		; 71 6C*21
	and1	cy,*xsfrFF+0x21.6		; 71 6D*21
	or1	cy,*xsfrFF+0x21.6		; 71 6E*21
	xor1	cy,*xsfrFF+0x21.6		; 71 6F*21

	; ------				; 71 70
	mov1	@xsaddrFE+0x20.7,cy		; 71 71r20
	; ------				; 71 72
	; ------				; 71 73
	mov1	cy,@xsaddrFE+0x20.7		; 71 74r20
	and1	cy,@xsaddrFE+0x20.7		; 71 75r20
	or1	cy,@xsaddrFE+0x20.7		; 71 76r20
	xor1	cy,@xsaddrFE+0x20.7		; 71 77r20
	; ------				; 71 78
	mov1	*xsfrFF+0x21.7,cy		; 71 79*21
	set1	*xsfrFF+0x21.7			; 71 7A*21
	clr1	*xsfrFF+0x21.7			; 71 7B*21
	mov1	cy,*xsfrFF+0x21.7		; 71 7C*21
	and1	cy,*xsfrFF+0x21.7		; 71 7D*21
	or1	cy,*xsfrFF+0x21.7		; 71 7E*21
	xor1	cy,*xsfrFF+0x21.7		; 71 7F*21

	; ------				; 71 80
	mov1	[hl].0,cy			; 71 81
	set1	[hl].0				; 71 82
	clr1	[hl].0				; 71 83
	mov1	cy,[hl].0			; 71 84
	and1	cy,[hl].0			; 71 85
	or1	cy,[hl].0			; 71 86
	xor1	cy,[hl].0			; 71 87
	; ------				; 71 88
	; ------				; 71 89
	; ------				; 71 8A
	; ------				; 71 8B
	; ------				; 71 8C
	; ------				; 71 8D
	; ------				; 71 8E
	; ------				; 71 8F


	; ------				; 71 90
	mov1	[hl].1,cy			; 71 91
	set1	[hl].1				; 71 92
	clr1	[hl].1				; 71 93
	mov1	cy,[hl].1			; 71 94
	and1	cy,[hl].1			; 71 95
	or1	cy,[hl].1			; 71 96
	xor1	cy,[hl].1			; 71 97
	; ------				; 71 98
	; ------				; 71 99
	; ------				; 71 9A
	; ------				; 71 9B
	; ------				; 71 9C
	; ------				; 71 9D
	; ------				; 71 9E
	; ------				; 71 9F

	; ------				; 71 A0
	mov1	[hl].2,cy			; 71 A1
	set1	[hl].2				; 71 A2
	clr1	[hl].2				; 71 A3
	mov1	cy,[hl].2			; 71 A4
	and1	cy,[hl].2			; 71 A5
	or1	cy,[hl].2			; 71 A6
	xor1	cy,[hl].2			; 71 A7
	; ------				; 71 A8
	; ------				; 71 A9
	; ------				; 71 AA
	; ------				; 71 AB
	; ------				; 71 AC
	; ------				; 71 AD
	; ------				; 71 AE
	; ------				; 71 AF

	; ------				; 71 B0
	mov1	[hl].3,cy			; 71 B1
	set1	[hl].3				; 71 B2
	clr1	[hl].3				; 71 B3
	mov1	cy,[hl].3			; 71 B4
	and1	cy,[hl].3			; 71 B5
	or1	cy,[hl].3			; 71 B6
	xor1	cy,[hl].3			; 71 B7
	; ------				; 71 B8
	; ------				; 71 B9
	; ------				; 71 BA
	; ------				; 71 BB
	; ------				; 71 BC
	; ------				; 71 BD
	; ------				; 71 BE
	; ------				; 71 BF


	; ------				; 71 C0
	mov1	[hl].4,cy			; 71 C1
	set1	[hl].4				; 71 C2
	clr1	[hl].4				; 71 C3
	mov1	cy,[hl].4			; 71 C4
	and1	cy,[hl].4			; 71 C5
	or1	cy,[hl].4			; 71 C6
	xor1	cy,[hl].4			; 71 C7
	; ------				; 71 C8
	; ------				; 71 C9
	; ------				; 71 CA
	; ------				; 71 CB
	; ------				; 71 CC
	; ------				; 71 CD
	; ------				; 71 CE
	; ------				; 71 CF

	; ------				; 71 D0
	mov1	[hl].5,cy			; 71 D1
	set1	[hl].5				; 71 D2
	clr1	[hl].5				; 71 D3
	mov1	cy,[hl].5			; 71 D4
	and1	cy,[hl].5			; 71 D5
	or1	cy,[hl].5			; 71 D6
	xor1	cy,[hl].5			; 71 D7
	; ------				; 71 D8
	; ------				; 71 D9
	; ------				; 71 DA
	; ------				; 71 DB
	; ------				; 71 DC
	; ------				; 71 DD
	; ------				; 71 DE
	; ------				; 71 DF


	; ------				; 71 E0
	mov1	[hl].6,cy			; 71 E1
	set1	[hl].6				; 71 E2
	clr1	[hl].6				; 71 E3
	mov1	cy,[hl].6			; 71 E4
	and1	cy,[hl].6			; 71 E5
	or1	cy,[hl].6			; 71 E6
	xor1	cy,[hl].6			; 71 E7
	; ------				; 71 E8
	; ------				; 71 E9
	; ------				; 71 EA
	; ------				; 71 EB
	; ------				; 71 EC
	; ------				; 71 ED
	; ------				; 71 EE
	; ------				; 71 EF

	; ------				; 71 F0
	mov1	[hl].7,cy			; 71 F1
	set1	[hl].7				; 71 F2
	clr1	[hl].7				; 71 F3
	mov1	cy,[hl].7			; 71 F4
	and1	cy,[hl].7			; 71 F5
	or1	cy,[hl].7			; 71 F6
	xor1	cy,[hl].7			; 71 F7
	; ------				; 71 F8
	; ------				; 71 F9
	; ------				; 71 FA
	; ------				; 71 FB
	; ------				; 71 FC
	; ------				; 71 FD
	; ------				; 71 FE
	; ------				; 71 FF


	.end




