	.title	AS78K0S Sequential Opcode Test

	; Notes:
	;	Absolute addresses (CONSTANTS) will be checked as
	;	being in the 'saddr' range first and then as being
	;	in the 'sfr' range if no explicit @ or * is specified.
	;
	;	!  -  address is NOT PC Relative
	;	#  -  immediate value
	;	@  -  force 'saddr' address (0xFE20-0xFF1F)
	;	*  -  force   'sfr' address (0xFFE0-0xFCF, 0xFFE0-0xFFFF)
	;
	;	If the 'sfr' or 'saddr' address is external then the
	;	user is responsible to ensure the addresses are in the
	;	proper ranges.  NO ERRORS will be reported by the linker.

			; sfr addresses
	sfrFF00		=	0xFF00
	sfrFF21		=	0xFF21

	.globl	exsfr				; external

			; saddr addresses
	saddrFE20	=	0xFE20
	saddrFF17	=	0xFF17

	.globl	exsaddr				; external

			; Byte values

	byt01		=	0x01
	byt23		=	0x23
	byt45		=	0x45
	byt67		=	0x67

	.globl	exbyt				; external

			; addr16 addresses
	addr16		=	0xE016

	.globl	exaddr16			; external
	.globl	ext				; external

			; bit addresses
	bit0		=	0
	bit1		=	1
	bit2		=	2
	bit3		=	3
	bit4		=	4
	bit5		=	5
	bit6		=	6
	bit7		=	7

	.globl	exbit				; external

			; Indirect addresses
	ind40		=	0x40
	ind50		=	0x50
	ind60		=	0x60
	ind70		=	0x70

	.globl	exind				; external


	.sbttl	Derived Mnemonics

	ei					; 0A 7A 1E
	di					; 0A FA 1E
	set1	psw.3				; 0A 3A 1E
	clr1	psw.5				; 0A DA 1E
	bt	psw.1,.				; 0A 98 1E FC
	bf	psw.7,.				; 0A 78 1E FC


	.sbttl	Base Page Sequential

	ror	a,1				; 00
						; 01
	rorc	a,1				; 02
						; 03
	clr1	cy				; 04
	xch	a,saddrFE20			; 05 20
	not1	cy				; 06
	xch	a,sfrFF21			; 07 21
	nop					; 08
						; 09
						; 0A - Page 0A
	xch	a,[de]				; 0B
	halt					; 0C
	xch	a,[hl+byt01]			; 0D 01
	stop					; 0E
	xch	a,[hl]				; 0F

	rol	a,1				; 10
	cmp	saddrFF17,#byt01		; 11 17 01
	rolc	a,1				; 12
	cmp	a,#byt23			; 13 23
	set1	cy				; 14
	cmp	a,saddrFE20			; 15 20
						; 16
						; 17
						; 18
	cmp	a,addr16			; 19 16 E0
						; 1A
						; 1B
						; 1C
	cmp	a,[hl+byt23]			; 1D 23
						; 1E
	cmp	a,[hl]				; 1F

	ret					; 20
						; 21
	call	addr16				; 22 16 E0
						; 23
	reti					; 24
	mov	a,saddrFF17			; 25 17
						; 26
	mov	a,sfrFF21			; 27 21
						; 28
	mov	a,addr16			; 29 16 E0
						; 2A
						; 2B
	pop	psw				; 2C
	mov	a,[hl+byt45]			; 2D 45
	push	psw				; 2E
	mov	a,[hl]				; 2F

	br	.				; 30 FE
						; 31
	dbnz	saddrFF17,.			; 32 17 FD
						; 33
	dbnz	c,.				; 34 FE
						; 35
	dbnz	b,.				; 36 FE
						; 37
	bc	.				; 38 FE
						; 39
	bnc	.				; 3A FE
						; 3B
	bz	.				; 3C FE
						; 3D
	bnz	.				; 3E FE
						; 3F

	callt	[ind40]				; 40
	xor	saddrFE20,#byt67		; 41 20 67
	callt	[ind40+2]			; 42
	xor	a,#byt01			; 43 01
	callt	[ind40+4]			; 44
	xor	a,saddrFF17			; 45 17
	callt	[ind40+6]			; 46
						; 47
	callt	[ind40+8]			; 48
	xor	a,addr16			; 49 16 E0
	callt	[ind40+10]			; 4A
	mov	a,[de]				; 4B
	callt	[ind40+12]			; 4C
	xor	a,[hl+byt23]			; 4D 23
	callt	[ind40+14]			; 4E
	xor	a,[hl]				; 4F

	callt	[ind50]				; 50
						; 51
	callt	[ind50+2]			; 52
						; 53
	callt	[ind50+4]			; 54
						; 55
	callt	[ind50+6]			; 56
						; 57
	callt	[ind50+8]			; 58
						; 59
	callt	[ind50+10]			; 5A
						; 5B
	callt	[ind50+12]			; 5C
						; 5D
	callt	[ind50+14]			; 5E
						; 5F

	callt	[ind60]				; 60
	and	saddrFF17,#byt23		; 61 17 23
	callt	[ind60+2]			; 62
	and	a,#byt45			; 63 45
	callt	[ind60+4]			; 64
	and	a,saddrFE20			; 65 20
	callt	[ind60+6]			; 66
						; 67
	callt	[ind60+8]			; 68
	and	a,addr16			; 69 16 E0
	callt	[ind60+10]			; 6A
						; 6B
	callt	[ind60+12]			; 6C
	and	a,[hl+byt67]			; 6D 67
	callt	[ind60+14]			; 6E
	and	a,[hl]				; 6F

	callt	[ind70]				; 70
	or	saddrFF17,#byt23		; 71 17 23
	callt	[ind70+2]			; 72
	or	a,#byt45			; 73 45
	callt	[ind70+4]			; 74
	or	a,saddrFE20			; 75 20
	callt	[ind70+6]			; 76
						; 77
	callt	[ind70+8]			; 78
	or	a,addr16			; 79 16 E0
	callt	[ind70+10]			; 7A
						; 7B
	callt	[ind70+12]			; 7C
	or	a,[hl+byt67]			; 7D 67
	callt	[ind70+14]			; 7E
	or	a,[hl]				; 7F

	incw	ax				; 80
	add	saddrFF17,#byt23		; 81 17 23
						; 82
	add	a,#byt45			; 83 45
	incw	bc				; 84
	add	a,saddrFE20			; 85 20
						; 86
						; 87
	incw	de				; 88
	add	a,addr16			; 89 16 E0
						; 8A
						; 8B
	incw	hl				; 8C
	add	a,[hl+byt67]			; 8D 67
						; 8E
	add	a,[hl]				; 8F

	decw	ax				; 90
	sub	saddrFF17,#byt23		; 91 17 23
						; 92
	sub	a,#byt45			; 93 45
	decw	bc				; 94
	sub	a,saddrFE20			; 95 20
						; 96
						; 97
	decw	de				; 98
	sub	a,addr16			; 99 16 E0
						; 9A
						; 9B
	decw	hl				; 9C
	sub	a,[hl+byt67]			; 9D 67
						; 9E
	sub	a,[hl]				; 9F

	pop	ax				; A0
	addc	saddrFF17,#byt23		; A1 17 23
	push	ax				; A2
	addc	a,#byt45			; A3 45
	pop	bc				; A4
	addc	a,saddrFE20			; A5 20
	push	bc				; A6
						; A7
	pop	de				; A8
	addc	a,addr16			; A9 16 E0
	push	de				; AA
						; AB
	pop	hl				; AC
	addc	a,[hl+byt67]			; AD 67
	push	hl				; AE
	addc	a,[hl]				; AF

	br	ax				; B0
	subc	saddrFF17,#byt23		; B1 17 23
	br	!addr16				; B2 16 E0
	subc	a,#byt45			; B3 45
						; B4
	subc	a,saddrFE20			; B5 20
						; B6
						; B7
						; B8
	subc	a,addr16			; B9 16 E0
						; BA
						; BB
						; BC
	subc	a,[hl+byt67]			; BD 67
						; BE
	subc	a,[hl]				; BF

	xch	a,x				; C0
						; C1
	subw	ax,#0x1234			; C2 34 12
						; C3
	xchw	ax,bc				; C4
	inc	saddrFE20			; C5 20
						; C6
						; C7
	xchw	ax,de				; C8
						; C9
						; CA
						; CB
	xchw	ax,hl				; CC
						; CD
						; CE
						; CF

						; D0
						; D1
	addw	ax,#0x1234			; D2 34 12
						; D3
	movw	ax,bc				; D4
	dec	saddrFE20			; D5 20
	movw	ax,saddrFF17			; D6 17
						; D7
	movw	ax,de				; D8
						; D9
						; DA
						; DB
	movw	ax,hl				; DC
						; DD
						; DE
						; DF

						; E0
						; E1
	cmpw	ax,#0x1234			; E2 34 12
						; E3
	movw	bc,ax				; E4
	mov	saddrFE20,a			; E5 20
	movw	saddrFF17,ax			; E6 17
	mov	sfrFF21,a			; E7 21
	movw	de,ax				; E8
	mov	addr16,a			; E9 16 E0
						; EA
	mov	[de],a				; EB
	movw	hl,ax				; EC
	mov	[hl+byt67],a			; ED 67
						; EE
	mov	[hl],a				; EF

	movw	ax,#0x1234			; F0 34 12
						; F1
						; F2
						; F3
	movw	bc,#0x6789			; F4 89 67
	mov	saddrFE20,#byt01		; F5 20 01
						; F6
	mov	sfrFF21,#byt23			; F7 21 23
	movw	de,#0x2345			; F8 45 23
						; F9
						; FA
						; FB
	movw	hl,#0x0189			; FC 89 01
						; FD
						; FE
						; FF

	.sbttl	Base Page Sequential (Alternate Register Forms)

	ror	a,1				; 00
						; 01
	rorc	a,1				; 02
						; 03
	clr1	cy				; 04
	xch	a,saddrFE20			; 05 20
	not1	cy				; 06
	xch	a,sfrFF21			; 07 21
	nop					; 08
						; 09
						; 0A - Page 0A
	xch	a,[de]				; 0B
	halt					; 0C
	xch	a,[hl+byt01]			; 0D 01
	stop					; 0E
	xch	a,[hl]				; 0F

	rol	a,1				; 10
	cmp	saddrFF17,#byt01		; 11 17 01
	rolc	a,1				; 12
	cmp	a,#byt23			; 13 23
	set1	cy				; 14
	cmp	a,saddrFE20			; 15 20
						; 16
						; 17
						; 18
	cmp	a,addr16			; 19 16 E0
						; 1A
						; 1B
						; 1C
	cmp	a,[hl+byt23]			; 1D 23
						; 1E
	cmp	a,[hl]				; 1F

	ret					; 20
						; 21
	call	addr16				; 22 16 E0
						; 23
	reti					; 24
	mov	a,saddrFF17			; 25 17
						; 26
	mov	a,sfrFF21			; 27 21
						; 28
	mov	a,addr16			; 29 16 E0
						; 2A
						; 2B
	pop	psw				; 2C
	mov	a,[hl+byt45]			; 2D 45
	push	psw				; 2E
	mov	a,[hl]				; 2F

	br	.				; 30 FE
						; 31
	dbnz	saddrFF17,.			; 32 17 FD
						; 33
	dbnz	c,.				; 34 FE
						; 35
	dbnz	b,.				; 36 FE
						; 37
	bc	.				; 38 FE
						; 39
	bnc	.				; 3A FE
						; 3B
	bz	.				; 3C FE
						; 3D
	bnz	.				; 3E FE
						; 3F

	callt	[ind40]				; 40
	xor	saddrFE20,#byt67		; 41 20 67
	callt	[ind40+2]			; 42
	xor	a,#byt01			; 43 01
	callt	[ind40+4]			; 44
	xor	a,saddrFF17			; 45 17
	callt	[ind40+6]			; 46
						; 47
	callt	[ind40+8]			; 48
	xor	a,addr16			; 49 16 E0
	callt	[ind40+10]			; 4A
	mov	a,[de]				; 4B
	callt	[ind40+12]			; 4C
	xor	a,[hl+byt23]			; 4D 23
	callt	[ind40+14]			; 4E
	xor	a,[hl]				; 4F

	callt	[ind50]				; 50
						; 51
	callt	[ind50+2]			; 52
						; 53
	callt	[ind50+4]			; 54
						; 55
	callt	[ind50+6]			; 56
						; 57
	callt	[ind50+8]			; 58
						; 59
	callt	[ind50+10]			; 5A
						; 5B
	callt	[ind50+12]			; 5C
						; 5D
	callt	[ind50+14]			; 5E
						; 5F

	callt	[ind60]				; 60
	and	saddrFF17,#byt23		; 61 17 23
	callt	[ind60+2]			; 62
	and	a,#byt45			; 63 45
	callt	[ind60+4]			; 64
	and	a,saddrFE20			; 65 20
	callt	[ind60+6]			; 66
						; 67
	callt	[ind60+8]			; 68
	and	a,addr16			; 69 16 E0
	callt	[ind60+10]			; 6A
						; 6B
	callt	[ind60+12]			; 6C
	and	a,[hl+byt67]			; 6D 67
	callt	[ind60+14]			; 6E
	and	a,[hl]				; 6F

	callt	[ind70]				; 70
	or	saddrFF17,#byt23		; 71 17 23
	callt	[ind70+2]			; 72
	or	a,#byt45			; 73 45
	callt	[ind70+4]			; 74
	or	a,saddrFE20			; 75 20
	callt	[ind70+6]			; 76
						; 77
	callt	[ind70+8]			; 78
	or	a,addr16			; 79 16 E0
	callt	[ind70+10]			; 7A
						; 7B
	callt	[ind70+12]			; 7C
	or	a,[hl+byt67]			; 7D 67
	callt	[ind70+14]			; 7E
	or	a,[hl]				; 7F

	incw	rp0				; 80
	add	saddrFF17,#byt23		; 81 17 23
						; 82
	add	a,#byt45			; 83 45
	incw	rp1				; 84
	add	a,saddrFE20			; 85 20
						; 86
						; 87
	incw	rp2				; 88
	add	a,addr16			; 89 16 E0
						; 8A
						; 8B
	incw	rp3				; 8C
	add	a,[hl+byt67]			; 8D 67
						; 8E
	add	a,[hl]				; 8F

	decw	rp0				; 90
	sub	saddrFF17,#byt23		; 91 17 23
						; 92
	sub	a,#byt45			; 93 45
	decw	rp1				; 94
	sub	a,saddrFE20			; 95 20
						; 96
						; 97
	decw	rp2				; 98
	sub	a,addr16			; 99 16 E0
						; 9A
						; 9B
	decw	rp3				; 9C
	sub	a,[hl+byt67]			; 9D 67
						; 9E
	sub	a,[hl]				; 9F

	pop	rp0				; A0
	addc	saddrFF17,#byt23		; A1 17 23
	push	rp0				; A2
	addc	a,#byt45			; A3 45
	pop	rp1				; A4
	addc	a,saddrFE20			; A5 20
	push	rp1				; A6
						; A7
	pop	rp2				; A8
	addc	a,addr16			; A9 16 E0
	push	rp2				; AA
						; AB
	pop	rp3				; AC
	addc	a,[hl+byt67]			; AD 67
	push	rp3				; AE
	addc	a,[hl]				; AF

	br	ax				; B0
	subc	saddrFF17,#byt23		; B1 17 23
	br	!addr16				; B2 16 E0
	subc	a,#byt45			; B3 45
						; B4
	subc	a,saddrFE20			; B5 20
						; B6
						; B7
						; B8
	subc	a,addr16			; B9 16 E0
						; BA
						; BB
						; BC
	subc	a,[hl+byt67]			; BD 67
						; BE
	subc	a,[hl]				; BF

	xch	a,x				; C0
						; C1
	subw	ax,#0x1234			; C2 34 12
						; C3
	xchw	ax,rp1				; C4
	inc	saddrFE20			; C5 20
						; C6
						; C7
	xchw	ax,rp2				; C8
						; C9
						; CA
						; CB
	xchw	ax,rp3				; CC
						; CD
						; CE
						; CF

						; D0
						; D1
	addw	ax,#0x1234			; D2 34 12
						; D3
	movw	ax,rp1				; D4
	dec	saddrFE20			; D5 20
	movw	ax,saddrFF17			; D6 17
						; D7
	movw	ax,rp2				; D8
						; D9
						; DA
						; DB
	movw	ax,rp3				; DC
						; DD
						; DE
						; DF

						; E0
						; E1
	cmpw	ax,#0x1234			; E2 34 12
						; E3
	movw	rp1,ax				; E4
	mov	saddrFE20,a			; E5 20
	movw	saddrFF17,ax			; E6 17
	mov	sfrFF21,a			; E7 21
	movw	rp2,ax				; E8
	mov	addr16,a			; E9 16 E0
						; EA
	mov	[de],a				; EB
	movw	rp3,ax				; EC
	mov	[hl+byt67],a			; ED 67
						; EE
	mov	[hl],a				; EF

	movw	rp0,#0x1234			; F0 34 12
						; F1
						; F2
						; F3
	movw	rp1,#0x6789			; F4 89 67
	mov	saddrFE20,#byt01		; F5 20 01
						; F6
	mov	sfrFF21,#byt23			; F7 21 23
	movw	rp2,#0x2345			; F8 45 23
						; F9
						; FA
						; FB
	movw	rp3,#0x0189			; FC 89 01
						; FD
						; FE
						; FF


	.sbttl	Base Page Sequential (External Symbols)

	ror	a,1				; 00
						; 01
	rorc	a,1				; 02
						; 03
	clr1	cy				; 04
	xch	a,@exsaddr+0xFE20		; 05r20
	not1	cy				; 06
	xch	a,*exsfr+0xFF21			; 07r21
	nop					; 08
						; 09
						; 0A - Page 0A
	xch	a,[de]				; 0B
	halt					; 0C
	xch	a,[hl+exbyt+0x01]		; 0Dr01
	stop					; 0E
	xch	a,[hl]				; 0F

	rol	a,1				; 10
	cmp	@exsaddr+0xFF17,#exbyt+0x01	; 11r17r01
	rolc	a,1				; 12
	cmp	a,#exbyt+0x23			; 13r23
	set1	cy				; 14
	cmp	a,@exsaddr+0xFE20		; 15r20
						; 16
						; 17
						; 18
	cmp	a,exaddr16+0xE016		; 19r16sE0
						; 1A
						; 1B
						; 1C
	cmp	a,[hl+exbyt+0x23]		; 1Dr23
						; 1E
	cmp	a,[hl]				; 1F

	ret					; 20
						; 21
	call	exaddr16+0xE016			; 22r16sE0
						; 23
	reti					; 24
	mov	a,@exsaddr+0xFF17		; 25r17
						; 26
	mov	a,*exsfr+0xFF21			; 27r21
						; 28
	mov	a,addr16			; 29 16 E0
						; 2A
						; 2B
	pop	psw				; 2C
	mov	a,[hl+exbyt+0x45]		; 2Dr45
	push	psw				; 2E
	mov	a,[hl]				; 2F

	br	.				; 30 FE
						; 31
	dbnz	@exsaddr+0xFF17,.		; 32r17 FD
						; 33
	dbnz	c,.				; 34 FE
						; 35
	dbnz	b,.				; 36 FE
						; 37
	bc	.				; 38 FE
						; 39
	bnc	.				; 3A FE
						; 3B
	bz	.				; 3C FE
						; 3D
	bnz	.				; 3E FE
						; 3F

	callt	[exind+0x40]			;r40
	xor	@exsaddr+0xFE20,#exbyt+0x67	; 41r20r67
	callt	[exind+0x40+2]			;r42
	xor	a,#exbyt+0x01			; 43r01
	callt	[exind+0x40+4]			;r44
	xor	a,@exsaddr+0xFF17		; 45r17
	callt	[exind+0x40+6]			;r46
						; 47
	callt	[exind+0x40+8]			;r48
	xor	a,exaddr16+0xE016		; 49r16sE0
	callt	[exind+0x40+10]			;r4A
	mov	a,[de]				; 4B
	callt	[exind+0x40+12]			;r4C
	xor	a,[hl+exbyt+0x23]		; 4Dr23
	callt	[exind+0x40+14]			;r4E
	xor	a,[hl]				; 4F

	callt	[exind+0x50]			;r50
						; 51
	callt	[exind+0x50+2]			;r52
						; 53
	callt	[exind+0x50+4]			;r54
						; 55
	callt	[exind+0x50+6]			;r56
						; 57
	callt	[exind+0x50+8]			;r58
						; 59
	callt	[exind+0x50+10]			;r5A
						; 5B
	callt	[exind+0x50+12]			;r5C
						; 5D
	callt	[exind+0x50+14]			;r5E
						; 5F

	callt	[exind+0x60]			;r60
	and	@exsaddr+0xFF17,#exbyt+0x23	; 61r17r23
	callt	[exind+0x60+2]			;r62
	and	a,#exbyt+0x45			; 63r45
	callt	[exind+0x60+4]			;r64
	and	a,@exsaddr+0xFE20		; 65r20
	callt	[exind+0x60+6]			;r66
						; 67
	callt	[exind+0x60+8]			;r68
	and	a,exaddr16+0xE016		; 69r16sE0
	callt	[exind+0x60+10]			;r6A
						; 6B
	callt	[exind+0x60+12]			;r6C
	and	a,[hl+exbyt+0x67]		; 6Dr67
	callt	[exind+0x60+14]			;r6E
	and	a,[hl]				; 6F

	callt	[exind+0x70]			;r70
	or	@exsaddr+0xFF17,#exbyt+0x23	; 71r17r23
	callt	[exind+0x70+2]			;r72
	or	a,#exbyt+0x45			; 73r45
	callt	[exind+0x70+4]			;r74
	or	a,@exsaddr+0xFE20		; 75r20
	callt	[exind+0x70+6]			;r76
						; 77
	callt	[exind+0x70+8]			;r78
	or	a,exaddr16+0xE016		; 79r16sE0
	callt	[exind+0x70+10]			;r7A
						; 7B
	callt	[exind+0x70+12]			;r7C
	or	a,[hl+exbyt+0x67]		; 7Dr67
	callt	[exind+0x70+14]			;r7E
	or	a,[hl]				; 7F

	incw	rp0				; 80
	add	@exsaddr+0xFF17,#exbyt+0x23	; 81r17r23
						; 82
	add	a,#exbyt+0x45			; 83r45
	incw	rp1				; 84
	add	a,@exsaddr+0xFE20		; 85r20
						; 86
						; 87
	incw	rp2				; 88
	add	a,exaddr16+0xE016		; 89r16sE0
						; 8A
						; 8B
	incw	rp3				; 8C
	add	a,[hl+exbyt+0x67]		; 8Dr67
						; 8E
	add	a,[hl]				; 8F

	decw	rp0				; 90
	sub	@exsaddr+0xFF17,#exbyt+0x23	; 91r17r23
						; 92
	sub	a,#exbyt+0x45			; 93r45
	decw	rp1				; 94
	sub	a,@exsaddr+0xFE20		; 95r20
						; 96
						; 97
	decw	rp2				; 98
	sub	a,exaddr16+0xE016		; 99r16sE0
						; 9A
						; 9B
	decw	rp3				; 9C
	sub	a,[hl+exbyt+0x67]		; 9Dr67
						; 9E
	sub	a,[hl]				; 9F

	pop	rp0				; A0
	addc	@exsaddr+0xFF17,#exbyt+0x23	; A1r17r23
	push	rp0				; A2
	addc	a,#exbyt+0x45			; A3r45
	pop	rp1				; A4
	addc	a,@exsaddr+0xFE20		; A5r20
	push	rp1				; A6
						; A7
	pop	rp2				; A8
	addc	a,exaddr16+0xE016		; A9r16sE0
	push	rp2				; AA
						; AB
	pop	rp3				; AC
	addc	a,[hl+exbyt+0x67]		; ADr67
	push	rp3				; AE
	addc	a,[hl]				; AF

	br	ax				; B0
	subc	@exsaddr+0xFF17,#exbyt+0x23	; B1r17r23
	br	!exaddr16+0xE016		; B2r16sE0
	subc	a,#exbyt+0x45			; B3r45
						; B4
	subc	a,@exsaddr+0xFE20		; B5r20
						; B6
						; B7
						; B8
	subc	a,exaddr16+0xE016		; B9r16sE0
						; BA
						; BB
						; BC
	subc	a,[hl+exbyt+0x67]		; BDr67
						; BE
	subc	a,[hl]				; BF

	xch	a,x				; C0
						; C1
	subw	ax,#ext+0x1234			; C2r34s12
						; C3
	xchw	ax,rp1				; C4
	inc	@exsaddr+0xFE20			; C5r20
						; C6
						; C7
	xchw	ax,rp2				; C8
						; C9
						; CA
						; CB
	xchw	ax,rp3				; CC
						; CD
						; CE
						; CF

						; D0
						; D1
	addw	ax,#ext+0x1234			; D2r34s12
						; D3
	movw	ax,rp1				; D4
	dec	@exsaddr+0xFE20			; D5r20
	movw	ax,@exsaddr+0xFF17		; D6r17
						; D7
	movw	ax,rp2				; D8
						; D9
						; DA
						; DB
	movw	ax,rp3				; DC
						; DD
						; DE
						; DF

						; E0
						; E1
	cmpw	ax,#ext+0x1234			; E2r34s12
						; E3
	movw	rp1,ax				; E4
	mov	@exsaddr+0xFE20,a		; E5r20
	movw	@exsaddr+0xFF17,ax		; E6r17
	mov	*exsfr+0xFF21,a			; E7r21
	movw	rp2,ax				; E8
	mov	exaddr16+0xE016,a		; E9r16sE0
						; EA
	mov	[de],a				; EB
	movw	rp3,ax				; EC
	mov	[hl+exbyt+0x67],a		; EDr67
						; EE
	mov	[hl],a				; EF

	movw	rp0,#ext+0x1234			; F0r34s12
						; F1
						; F2
						; F3
	movw	rp1,#ext+0x6789			; F4r89s67
	mov	@exsaddr+0xFE20,#exbyt+0x01	; F5r20r01
						; F6
	mov	*exsfr+0xFF21,#exbyt+0x23	; F7r21r23
	movw	rp2,#ext+0x2345			; F8r45s23
						; F9
						; FA
						; FB
	movw	rp3,#ext+0x0189			; FCr89s01
						; FD
						; FE
						; FF


	.sbttl	Expansion Page '0A' Sequential

	bf	a.bit0,.			; 0A 00 FD
						; 0A 01
	set1	a.bit0				; 0A 02
						; 0A 03
	bf	sfrFF21.bit0,.			; 0A 04 21 FC
	xch	a,c				; 0A 05
	set1	sfrFF21.bit0			; 0A 06 21
	xch	a,b				; 0A 07
	bf	saddrFF17.bit0,.		; 0A 08 17 FC
	xch	a,e				; 0A 09
	set1	saddrFF17.bit0			; 0A 0A 17
	xch	a,d				; 0A 0B
						; 0A 0C
	xch	a,h				; 0A 0D
	set1	[hl].bit0			; 0A 0E
	xch	a,l				; 0A 0F

	bf	a.bit1,.			; 0A 10 FD
	cmp	a,r0				; 0A 11
	set1	a.bit1				; 0A 12
	cmp	a,r1				; 0A 13
	bf	sfrFF21.bit1,.			; 0A 14 21 FC
	cmp	a,c				; 0A 15
	set1	sfrFF21.bit1			; 0A 16 21
	cmp	a,b				; 0A 17
	bf	saddrFF17.bit1,.		; 0A 18 17 FC
	cmp	a,e				; 0A 19
	set1	saddrFF17.bit1			; 0A 1A 17
	cmp	a,d				; 0A 1B
						; 0A 1C
	cmp	a,h				; 0A 1D
	set1	[hl].bit1			; 0A 1E
	cmp	a,l				; 0A 1F

	bf	a.bit2,.			; 0A 20 FD
	mov	a,r0				; 0A 21
	set1	a.bit2				; 0A 22
						; 0A 23
	bf	sfrFF21.bit2,.			; 0A 24 21 FC
	mov	a,c				; 0A 25
	set1	sfrFF21.bit2			; 0A 26 21
	mov	a,b				; 0A 27
	bf	saddrFF17.bit2,.		; 0A 28 17 FC
	mov	a,e				; 0A 29
	set1	saddrFF17.bit2			; 0A 2A 17
	mov	a,d				; 0A 2B
						; 0A 2C
	mov	a,h				; 0A 2D
	set1	[hl].bit2			; 0A 2E
	mov	a,l				; 0A 2F

	bf	a.bit3,.			; 0A 30 FD
						; 0A 31
	set1	a.bit3				; 0A 32
						; 0A 33
	bf	sfrFF21.bit3,.			; 0A 34 21 FC
						; 0A 35
	set1	sfrFF21.bit3			; 0A 36 21
						; 0A 37
	bf	saddrFF17.bit3,.		; 0A 38 17 FC
						; 0A 39
	set1	saddrFF17.bit3			; 0A 3A 17
						; 0A 3B
						; 0A 3C
						; 0A 3D
	set1	[hl].bit3			; 0A 3E
						; 0A 3F

	bf	a.bit4,.			; 0A 40 FD
	xor	a,r0				; 0A 41
	set1	a.bit4				; 0A 42
	xor	a,r1				; 0A 43
	bf	sfrFF21.bit4,.			; 0A 44 21 FC
	xor	a,c				; 0A 45
	set1	sfrFF21.bit4			; 0A 46 21
	xor	a,b				; 0A 47
	bf	saddrFF17.bit4,.		; 0A 48 17 FC
	xor	a,e				; 0A 49
	set1	saddrFF17.bit4			; 0A 4A 17
	xor	a,d				; 0A 4B
						; 0A 4C
	xor	a,h				; 0A 4D
	set1	[hl].bit4			; 0A 4E
	xor	a,l				; 0A 4F

	bf	a.bit5,.			; 0A 50 FD
						; 0A 51
	set1	a.bit5				; 0A 52
						; 0A 53
	bf	sfrFF21.bit5,.			; 0A 54 21 FC
						; 0A 55
	set1	sfrFF21.bit5			; 0A 56 21
						; 0A 57
	bf	saddrFF17.bit5,.		; 0A 58 17 FC
						; 0A 59
	set1	saddrFF17.bit5			; 0A 5A 17
						; 0A 5B
						; 0A 5C
						; 0A 5D
	set1	[hl].bit5			; 0A 5E
						; 0A 5F

	bf	a.bit6,.			; 0A 60 FD
	and	a,r0				; 0A 61
	set1	a.bit6				; 0A 62
	and	a,r1				; 0A 63
	bf	sfrFF21.bit6,.			; 0A 64 21 FC
	and	a,c				; 0A 65
	set1	sfrFF21.bit6			; 0A 66 21
	and	a,b				; 0A 67
	bf	saddrFF17.bit6,.		; 0A 68 17 FC
	and	a,e				; 0A 69
	set1	saddrFF17.bit6			; 0A 6A 17
	and	a,d				; 0A 6B
						; 0A 6C
	and	a,h				; 0A 6D
	set1	[hl].bit6			; 0A 6E
	and	a,l				; 0A 6F

	bf	a.bit7,.			; 0A 70 FD
	or	a,r0				; 0A 71
	set1	a.bit7				; 0A 72
	or	a,r1				; 0A 73
	bf	sfrFF21.bit7,.			; 0A 74 21 FC
	or	a,c				; 0A 75
	set1	sfrFF21.bit7			; 0A 76 21
	or	a,b				; 0A 77
	bf	saddrFF17.bit7,.		; 0A 78 17 FC
	or	a,e				; 0A 79
	set1	saddrFF17.bit7			; 0A 7A 17
	or	a,d				; 0A 7B
						; 0A 7C
	or	a,h				; 0A 7D
	set1	[hl].bit7			; 0A 7E
	or	a,l				; 0A 7F

	bt	a.bit0,.			; 0A 80 FD
	add	a,r0				; 0A 81
	clr1	a.bit0				; 0A 82
	add	a,r1				; 0A 83
	bt	sfrFF21.bit0,.			; 0A 84 21 FC
	add	a,c				; 0A 85
	clr1	sfrFF21.bit0			; 0A 86 21
	add	a,b				; 0A 87
	bt	saddrFF17.bit0,.		; 0A 88 17 FC
	add	a,e				; 0A 89
	clr1	saddrFF17.bit0			; 0A 8A 17
	add	a,d				; 0A 8B
						; 0A 8C
	add	a,h				; 0A 8D
	clr1	[hl].bit0			; 0A 8E
	add	a,l				; 0A 8F

	bt	a.bit1,.			; 0A 90 FD
	sub	a,r0				; 0A 91
	clr1	a.bit1				; 0A 92
	sub	a,r1				; 0A 93
	bt	sfrFF21.bit1,.			; 0A 94 21 FC
	sub	a,c				; 0A 95
	clr1	sfrFF21.bit1			; 0A 96 21
	sub	a,b				; 0A 97
	bt	saddrFF17.bit1,.		; 0A 98 17 FC
	sub	a,e				; 0A 99
	clr1	saddrFF17.bit1			; 0A 9A 17
	sub	a,d				; 0A 9B
						; 0A 9C
	sub	a,h				; 0A 9D
	clr1	[hl].bit1			; 0A 9E
	sub	a,l				; 0A 9F

	bt	a.bit2,.			; 0A A0 FD
	addc	a,r0				; 0A A1
	clr1	a.bit2				; 0A A2
	addc	a,r1				; 0A A3
	bt	sfrFF21.bit2,.			; 0A A4 21 FC
	addc	a,c				; 0A A5
	clr1	sfrFF21.bit2			; 0A A6 21
	addc	a,b				; 0A A7
	bt	saddrFF17.bit2,.		; 0A A8 17 FC
	addc	a,e				; 0A A9
	clr1	saddrFF17.bit2			; 0A AA 17
	addc	a,d				; 0A AB
						; 0A AC
	addc	a,h				; 0A AD
	clr1	[hl].bit2			; 0A AE
	addc	a,l				; 0A AF

	bt	a.bit3,.			; 0A B0 FD
	subc	a,r0				; 0A B1
	clr1	a.bit3				; 0A B2
	subc	a,r1				; 0A B3
	bt	sfrFF21.bit3,.			; 0A B4 21 FC
	subc	a,c				; 0A B5
	clr1	sfrFF21.bit3			; 0A B6 21
	subc	a,b				; 0A B7
	bt	saddrFF17.bit3,.		; 0A B8 17 FC
	subc	a,e				; 0A B9
	clr1	saddrFF17.bit3			; 0A BA 17
	subc	a,d				; 0A BB
						; 0A BC
	subc	a,h				; 0A BD
	clr1	[hl].bit3			; 0A BE
	subc	a,l				; 0A BF

	bt	a.bit4,.			; 0A C0 FD
	inc	r0				; 0A C1
	clr1	a.bit4				; 0A C2
	inc	r1				; 0A C3
	bt	sfrFF21.bit4,.			; 0A C4 21 FC
	inc	c				; 0A C5
	clr1	sfrFF21.bit4			; 0A C6 21
	inc	b				; 0A C7
	bt	saddrFF17.bit4,.		; 0A C8 17 FC
	inc	e				; 0A C9
	clr1	saddrFF17.bit4			; 0A CA 17
	inc	d				; 0A CB
						; 0A CC
	inc	h				; 0A CD
	clr1	[hl].bit4			; 0A CE
	inc	l				; 0A CF

	bt	a.bit5,.			; 0A D0 FD
	dec	r0				; 0A D1
	clr1	a.bit5				; 0A D2
	dec	r1				; 0A D3
	bt	sfrFF21.bit5,.			; 0A D4 21 FC
	dec	c				; 0A D5
	clr1	sfrFF21.bit5			; 0A D6 21
	dec	b				; 0A D7
	bt	saddrFF17.bit5,.		; 0A D8 17 FC
	dec	e				; 0A D9
	clr1	saddrFF17.bit5			; 0A DA 17
	dec	d				; 0A DB
						; 0A DC
	dec	h				; 0A DD
	clr1	[hl].bit5			; 0A DE
	dec	l				; 0A DF

	bt	a.bit6,.			; 0A E0 FD
	mov	r0,a				; 0A E1
	clr1	a.bit6				; 0A E2
						; 0A E3
	bt	sfrFF21.bit6,.			; 0A E4 21 FC
	mov	c,a				; 0A E5
	clr1	sfrFF21.bit6			; 0A E6 21
	mov	b,a				; 0A E7
	bt	saddrFF17.bit6,.		; 0A E8 17 FC
	mov	e,a				; 0A E9
	clr1	saddrFF17.bit6			; 0A EA 17
	mov	d,a				; 0A EB
						; 0A EC
	mov	h,a				; 0A ED
	clr1	[hl].bit6			; 0A EE
	mov	l,a				; 0A EF

	bt	a.bit7,.			; 0A F0 FD
	mov	r0,#byt01			; 0A F1 01
	clr1	a.bit7				; 0A F2
	mov	r1,#byt23			; 0A F3 23
	bt	sfrFF21.bit7,.			; 0A F4 21 FC
	mov	c,#byt45			; 0A F5 45
	clr1	sfrFF21.bit7			; 0A F6 21
	mov	b,#byt67			; 0A F7 67
	bt	saddrFF17.bit7,.		; 0A F8 17 FC
	mov	e,#byt01			; 0A F9 01
	clr1	saddrFF17.bit7			; 0A FA 17
	mov	d,#byt23			; 0A FB 23
						; 0A FC
	mov	h,#byt45			; 0A FD 45
	clr1	[hl].bit7			; 0A FE
	mov	l,#byt67			; 0A FF 67


	.sbttl	Expansion Page '0A' Sequential (Alternate Register Forms)

	bf	a.bit0,.			; 0A 00 FD
						; 0A 01
	set1	a.bit0				; 0A 02
						; 0A 03
	bf	sfrFF21.bit0,.			; 0A 04 21 FC
	xch	a,r2				; 0A 05
	set1	sfrFF21.bit0			; 0A 06 21
	xch	a,r3				; 0A 07
	bf	saddrFF17.bit0,.		; 0A 08 17 FC
	xch	a,r4				; 0A 09
	set1	saddrFF17.bit0			; 0A 0A 17
	xch	a,r5				; 0A 0B
						; 0A 0C
	xch	a,r6				; 0A 0D
	set1	[hl].bit0			; 0A 0E
	xch	a,r7				; 0A 0F

	bf	a.bit1,.			; 0A 10 FD
	cmp	a,r0				; 0A 11
	set1	a.bit1				; 0A 12
	cmp	a,r1				; 0A 13
	bf	sfrFF21.bit1,.			; 0A 14 21 FC
	cmp	a,r2				; 0A 15
	set1	sfrFF21.bit1			; 0A 16 21
	cmp	a,r3				; 0A 17
	bf	saddrFF17.bit1,.		; 0A 18 17 FC
	cmp	a,r4				; 0A 19
	set1	saddrFF17.bit1			; 0A 1A 17
	cmp	a,r5				; 0A 1B
						; 0A 1C
	cmp	a,r6				; 0A 1D
	set1	[hl].bit1			; 0A 1E
	cmp	a,r7				; 0A 1F

	bf	a.bit2,.			; 0A 20 FD
	mov	a,r0				; 0A 21
	set1	a.bit2				; 0A 22
						; 0A 23
	bf	sfrFF21.bit2,.			; 0A 24 21 FC
	mov	a,r2				; 0A 25
	set1	sfrFF21.bit2			; 0A 26 21
	mov	a,r3				; 0A 27
	bf	saddrFF17.bit2,.		; 0A 28 17 FC
	mov	a,r4				; 0A 29
	set1	saddrFF17.bit2			; 0A 2A 17
	mov	a,r5				; 0A 2B
						; 0A 2C
	mov	a,r6				; 0A 2D
	set1	[hl].bit2			; 0A 2E
	mov	a,r7				; 0A 2F

	bf	a.bit3,.			; 0A 30 FD
						; 0A 31
	set1	a.bit3				; 0A 32
						; 0A 33
	bf	sfrFF21.bit3,.			; 0A 34 21 FC
						; 0A 35
	set1	sfrFF21.bit3			; 0A 36 21
						; 0A 37
	bf	saddrFF17.bit3,.		; 0A 38 17 FC
						; 0A 39
	set1	saddrFF17.bit3			; 0A 3A 17
						; 0A 3B
						; 0A 3C
						; 0A 3D
	set1	[hl].bit3			; 0A 3E
						; 0A 3F

	bf	a.bit4,.			; 0A 40 FD
	xor	a,r0				; 0A 41
	set1	a.bit4				; 0A 42
	xor	a,r1				; 0A 43
	bf	sfrFF21.bit4,.			; 0A 44 21 FC
	xor	a,r2				; 0A 45
	set1	sfrFF21.bit4			; 0A 46 21
	xor	a,r3				; 0A 47
	bf	saddrFF17.bit4,.		; 0A 48 17 FC
	xor	a,r4				; 0A 49
	set1	saddrFF17.bit4			; 0A 4A 17
	xor	a,r5				; 0A 4B
						; 0A 4C
	xor	a,r6				; 0A 4D
	set1	[hl].bit4			; 0A 4E
	xor	a,r7				; 0A 4F

	bf	a.bit5,.			; 0A 50 FD
						; 0A 51
	set1	a.bit5				; 0A 52
						; 0A 53
	bf	sfrFF21.bit5,.			; 0A 54 21 FC
						; 0A 55
	set1	sfrFF21.bit5			; 0A 56 21
						; 0A 57
	bf	saddrFF17.bit5,.		; 0A 58 17 FC
						; 0A 59
	set1	saddrFF17.bit5			; 0A 5A 17
						; 0A 5B
						; 0A 5C
						; 0A 5D
	set1	[hl].bit5			; 0A 5E
						; 0A 5F

	bf	a.bit6,.			; 0A 60 FD
	and	a,r0				; 0A 61
	set1	a.bit6				; 0A 62
	and	a,r1				; 0A 63
	bf	sfrFF21.bit6,.			; 0A 64 21 FC
	and	a,r2				; 0A 65
	set1	sfrFF21.bit6			; 0A 66 21
	and	a,r3				; 0A 67
	bf	saddrFF17.bit6,.		; 0A 68 17 FC
	and	a,r4				; 0A 69
	set1	saddrFF17.bit6			; 0A 6A 17
	and	a,r5				; 0A 6B
						; 0A 6C
	and	a,r6				; 0A 6D
	set1	[hl].bit6			; 0A 6E
	and	a,r7				; 0A 6F

	bf	a.bit7,.			; 0A 70 FD
	or	a,r0				; 0A 71
	set1	a.bit7				; 0A 72
	or	a,r1				; 0A 73
	bf	sfrFF21.bit7,.			; 0A 74 21 FC
	or	a,r2				; 0A 75
	set1	sfrFF21.bit7			; 0A 76 21
	or	a,r3				; 0A 77
	bf	saddrFF17.bit7,.		; 0A 78 17 FC
	or	a,r4				; 0A 79
	set1	saddrFF17.bit7			; 0A 7A 17
	or	a,r5				; 0A 7B
						; 0A 7C
	or	a,r6				; 0A 7D
	set1	[hl].bit7			; 0A 7E
	or	a,r7				; 0A 7F

	bt	a.bit0,.			; 0A 80 FD
	add	a,r0				; 0A 81
	clr1	a.bit0				; 0A 82
	add	a,r1				; 0A 83
	bt	sfrFF21.bit0,.			; 0A 84 21 FC
	add	a,r2				; 0A 85
	clr1	sfrFF21.bit0			; 0A 86 21
	add	a,r3				; 0A 87
	bt	saddrFF17.bit0,.		; 0A 88 17 FC
	add	a,r4				; 0A 89
	clr1	saddrFF17.bit0			; 0A 8A 17
	add	a,r5				; 0A 8B
						; 0A 8C
	add	a,r6				; 0A 8D
	clr1	[hl].bit0			; 0A 8E
	add	a,r7				; 0A 8F

	bt	a.bit1,.			; 0A 90 FD
	sub	a,r0				; 0A 91
	clr1	a.bit1				; 0A 92
	sub	a,r1				; 0A 93
	bt	sfrFF21.bit1,.			; 0A 94 21 FC
	sub	a,r2				; 0A 95
	clr1	sfrFF21.bit1			; 0A 96 21
	sub	a,r3				; 0A 97
	bt	saddrFF17.bit1,.		; 0A 98 17 FC
	sub	a,r4				; 0A 99
	clr1	saddrFF17.bit1			; 0A 9A 17
	sub	a,r5				; 0A 9B
						; 0A 9C
	sub	a,r6				; 0A 9D
	clr1	[hl].bit1			; 0A 9E
	sub	a,r7				; 0A 9F

	bt	a.bit2,.			; 0A A0 FD
	addc	a,r0				; 0A A1
	clr1	a.bit2				; 0A A2
	addc	a,r1				; 0A A3
	bt	sfrFF21.bit2,.			; 0A A4 21 FC
	addc	a,r2				; 0A A5
	clr1	sfrFF21.bit2			; 0A A6 21
	addc	a,r3				; 0A A7
	bt	saddrFF17.bit2,.		; 0A A8 17 FC
	addc	a,r4				; 0A A9
	clr1	saddrFF17.bit2			; 0A AA 17
	addc	a,r5				; 0A AB
						; 0A AC
	addc	a,r6				; 0A AD
	clr1	[hl].bit2			; 0A AE
	addc	a,r7				; 0A AF

	bt	a.bit3,.			; 0A B0 FD
	subc	a,r0				; 0A B1
	clr1	a.bit3				; 0A B2
	subc	a,r1				; 0A B3
	bt	sfrFF21.bit3,.			; 0A B4 21 FC
	subc	a,r2				; 0A B5
	clr1	sfrFF21.bit3			; 0A B6 21
	subc	a,r3				; 0A B7
	bt	saddrFF17.bit3,.		; 0A B8 17 FC
	subc	a,r4				; 0A B9
	clr1	saddrFF17.bit3			; 0A BA 17
	subc	a,r5				; 0A BB
						; 0A BC
	subc	a,r6				; 0A BD
	clr1	[hl].bit3			; 0A BE
	subc	a,r7				; 0A BF

	bt	a.bit4,.			; 0A C0 FD
	inc	r0				; 0A C1
	clr1	a.bit4				; 0A C2
	inc	r1				; 0A C3
	bt	sfrFF21.bit4,.			; 0A C4 21 FC
	inc	r2				; 0A C5
	clr1	sfrFF21.bit4			; 0A C6 21
	inc	r3				; 0A C7
	bt	saddrFF17.bit4,.		; 0A C8 17 FC
	inc	r4				; 0A C9
	clr1	saddrFF17.bit4			; 0A CA 17
	inc	r5				; 0A CB
						; 0A CC
	inc	r6				; 0A CD
	clr1	[hl].bit4			; 0A CE
	inc	r7				; 0A CF

	bt	a.bit5,.			; 0A D0 FD
	dec	r0				; 0A D1
	clr1	a.bit5				; 0A D2
	dec	r1				; 0A D3
	bt	sfrFF21.bit5,.			; 0A D4 21 FC
	dec	r2				; 0A D5
	clr1	sfrFF21.bit5			; 0A D6 21
	dec	r3				; 0A D7
	bt	saddrFF17.bit5,.		; 0A D8 17 FC
	dec	r4				; 0A D9
	clr1	saddrFF17.bit5			; 0A DA 17
	dec	r5				; 0A DB
						; 0A DC
	dec	r6				; 0A DD
	clr1	[hl].bit5			; 0A DE
	dec	r7				; 0A DF

	bt	a.bit6,.			; 0A E0 FD
	mov	r0,a				; 0A E1
	clr1	a.bit6				; 0A E2
						; 0A E3
	bt	sfrFF21.bit6,.			; 0A E4 21 FC
	mov	r2,a				; 0A E5
	clr1	sfrFF21.bit6			; 0A E6 21
	mov	r3,a				; 0A E7
	bt	saddrFF17.bit6,.		; 0A E8 17 FC
	mov	r4,a				; 0A E9
	clr1	saddrFF17.bit6			; 0A EA 17
	mov	r5,a				; 0A EB
						; 0A EC
	mov	r6,a				; 0A ED
	clr1	[hl].bit6			; 0A EE
	mov	r7,a				; 0A EF

	bt	a.bit7,.			; 0A F0 FD
	mov	r0,#byt01			; 0A F1 01
	clr1	a.bit7				; 0A F2
	mov	r1,#byt23			; 0A F3 23
	bt	sfrFF21.bit7,.			; 0A F4 21 FC
	mov	r2,#byt45			; 0A F5 45
	clr1	sfrFF21.bit7			; 0A F6 21
	mov	r3,#byt67			; 0A F7 67
	bt	saddrFF17.bit7,.		; 0A F8 17 FC
	mov	r4,#byt01			; 0A F9 01
	clr1	saddrFF17.bit7			; 0A FA 17
	mov	r5,#byt23			; 0A FB 23
						; 0A FC
	mov	r6,#byt45			; 0A FD 45
	clr1	[hl].bit7			; 0A FE
	mov	r7,#byt67			; 0A FF 67


	.sbttl	Expansion Page '0A' Sequential (Alternate Bit Form N.bit -->> N,#bit)

	bf	a,#bit0,.			; 0A 00 FD
						; 0A 01
	set1	a,#bit0				; 0A 02
						; 0A 03
	bf	sfrFF21,#bit0,.			; 0A 04 21 FC
	xch	a,r2				; 0A 05
	set1	sfrFF21,#bit0			; 0A 06 21
	xch	a,r3				; 0A 07
	bf	saddrFF17,#bit0,.		; 0A 08 17 FC
	xch	a,r4				; 0A 09
	set1	saddrFF17,#bit0			; 0A 0A 17
	xch	a,r5				; 0A 0B
						; 0A 0C
	xch	a,r6				; 0A 0D
	set1	[hl],#bit0			; 0A 0E
	xch	a,r7				; 0A 0F

	bf	a,#bit1,.			; 0A 10 FD
	cmp	a,r0				; 0A 11
	set1	a,#bit1				; 0A 12
	cmp	a,r1				; 0A 13
	bf	sfrFF21,#bit1,.			; 0A 14 21 FC
	cmp	a,r2				; 0A 15
	set1	sfrFF21,#bit1			; 0A 16 21
	cmp	a,r3				; 0A 17
	bf	saddrFF17,#bit1,.		; 0A 18 17 FC
	cmp	a,r4				; 0A 19
	set1	saddrFF17,#bit1			; 0A 1A 17
	cmp	a,r5				; 0A 1B
						; 0A 1C
	cmp	a,r6				; 0A 1D
	set1	[hl],#bit1			; 0A 1E
	cmp	a,r7				; 0A 1F

	bf	a,#bit2,.			; 0A 20 FD
	mov	a,r0				; 0A 21
	set1	a,#bit2				; 0A 22
						; 0A 23
	bf	sfrFF21,#bit2,.			; 0A 24 21 FC
	mov	a,r2				; 0A 25
	set1	sfrFF21,#bit2			; 0A 26 21
	mov	a,r3				; 0A 27
	bf	saddrFF17,#bit2,.		; 0A 28 17 FC
	mov	a,r4				; 0A 29
	set1	saddrFF17,#bit2			; 0A 2A 17
	mov	a,r5				; 0A 2B
						; 0A 2C
	mov	a,r6				; 0A 2D
	set1	[hl],#bit2			; 0A 2E
	mov	a,r7				; 0A 2F

	bf	a,#bit3,.			; 0A 30 FD
						; 0A 31
	set1	a,#bit3				; 0A 32
						; 0A 33
	bf	sfrFF21,#bit3,.			; 0A 34 21 FC
						; 0A 35
	set1	sfrFF21,#bit3			; 0A 36 21
						; 0A 37
	bf	saddrFF17,#bit3,.		; 0A 38 17 FC
						; 0A 39
	set1	saddrFF17,#bit3			; 0A 3A 17
						; 0A 3B
						; 0A 3C
						; 0A 3D
	set1	[hl],#bit3			; 0A 3E
						; 0A 3F

	bf	a,#bit4,.			; 0A 40 FD
	xor	a,r0				; 0A 41
	set1	a,#bit4				; 0A 42
	xor	a,r1				; 0A 43
	bf	sfrFF21,#bit4,.			; 0A 44 21 FC
	xor	a,r2				; 0A 45
	set1	sfrFF21,#bit4			; 0A 46 21
	xor	a,r3				; 0A 47
	bf	saddrFF17,#bit4,.		; 0A 48 17 FC
	xor	a,r4				; 0A 49
	set1	saddrFF17,#bit4			; 0A 4A 17
	xor	a,r5				; 0A 4B
						; 0A 4C
	xor	a,r6				; 0A 4D
	set1	[hl],#bit4			; 0A 4E
	xor	a,r7				; 0A 4F

	bf	a,#bit5,.			; 0A 50 FD
						; 0A 51
	set1	a,#bit5				; 0A 52
						; 0A 53
	bf	sfrFF21,#bit5,.			; 0A 54 21 FC
						; 0A 55
	set1	sfrFF21,#bit5			; 0A 56 21
						; 0A 57
	bf	saddrFF17,#bit5,.		; 0A 58 17 FC
						; 0A 59
	set1	saddrFF17,#bit5			; 0A 5A 17
						; 0A 5B
						; 0A 5C
						; 0A 5D
	set1	[hl],#bit5			; 0A 5E
						; 0A 5F

	bf	a,#bit6,.			; 0A 60 FD
	and	a,r0				; 0A 61
	set1	a,#bit6				; 0A 62
	and	a,r1				; 0A 63
	bf	sfrFF21,#bit6,.			; 0A 64 21 FC
	and	a,r2				; 0A 65
	set1	sfrFF21,#bit6			; 0A 66 21
	and	a,r3				; 0A 67
	bf	saddrFF17,#bit6,.		; 0A 68 17 FC
	and	a,r4				; 0A 69
	set1	saddrFF17,#bit6			; 0A 6A 17
	and	a,r5				; 0A 6B
						; 0A 6C
	and	a,r6				; 0A 6D
	set1	[hl],#bit6			; 0A 6E
	and	a,r7				; 0A 6F

	bf	a,#bit7,.			; 0A 70 FD
	or	a,r0				; 0A 71
	set1	a,#bit7				; 0A 72
	or	a,r1				; 0A 73
	bf	sfrFF21,#bit7,.			; 0A 74 21 FC
	or	a,r2				; 0A 75
	set1	sfrFF21,#bit7			; 0A 76 21
	or	a,r3				; 0A 77
	bf	saddrFF17,#bit7,.		; 0A 78 17 FC
	or	a,r4				; 0A 79
	set1	saddrFF17,#bit7			; 0A 7A 17
	or	a,r5				; 0A 7B
						; 0A 7C
	or	a,r6				; 0A 7D
	set1	[hl],#bit7			; 0A 7E
	or	a,r7				; 0A 7F

	bt	a,#bit0,.			; 0A 80 FD
	add	a,r0				; 0A 81
	clr1	a,#bit0				; 0A 82
	add	a,r1				; 0A 83
	bt	sfrFF21,#bit0,.			; 0A 84 21 FC
	add	a,r2				; 0A 85
	clr1	sfrFF21,#bit0			; 0A 86 21
	add	a,r3				; 0A 87
	bt	saddrFF17,#bit0,.		; 0A 88 17 FC
	add	a,r4				; 0A 89
	clr1	saddrFF17,#bit0			; 0A 8A 17
	add	a,r5				; 0A 8B
						; 0A 8C
	add	a,r6				; 0A 8D
	clr1	[hl],#bit0			; 0A 8E
	add	a,r7				; 0A 8F

	bt	a,#bit1,.			; 0A 90 FD
	sub	a,r0				; 0A 91
	clr1	a,#bit1				; 0A 92
	sub	a,r1				; 0A 93
	bt	sfrFF21,#bit1,.			; 0A 94 21 FC
	sub	a,r2				; 0A 95
	clr1	sfrFF21,#bit1			; 0A 96 21
	sub	a,r3				; 0A 97
	bt	saddrFF17,#bit1,.		; 0A 98 17 FC
	sub	a,r4				; 0A 99
	clr1	saddrFF17,#bit1			; 0A 9A 17
	sub	a,r5				; 0A 9B
						; 0A 9C
	sub	a,r6				; 0A 9D
	clr1	[hl],#bit1			; 0A 9E
	sub	a,r7				; 0A 9F

	bt	a,#bit2,.			; 0A A0 FD
	addc	a,r0				; 0A A1
	clr1	a,#bit2				; 0A A2
	addc	a,r1				; 0A A3
	bt	sfrFF21,#bit2,.			; 0A A4 21 FC
	addc	a,r2				; 0A A5
	clr1	sfrFF21,#bit2			; 0A A6 21
	addc	a,r3				; 0A A7
	bt	saddrFF17,#bit2,.		; 0A A8 17 FC
	addc	a,r4				; 0A A9
	clr1	saddrFF17,#bit2			; 0A AA 17
	addc	a,r5				; 0A AB
						; 0A AC
	addc	a,r6				; 0A AD
	clr1	[hl],#bit2			; 0A AE
	addc	a,r7				; 0A AF

	bt	a,#bit3,.			; 0A B0 FD
	subc	a,r0				; 0A B1
	clr1	a,#bit3				; 0A B2
	subc	a,r1				; 0A B3
	bt	sfrFF21,#bit3,.			; 0A B4 21 FC
	subc	a,r2				; 0A B5
	clr1	sfrFF21,#bit3			; 0A B6 21
	subc	a,r3				; 0A B7
	bt	saddrFF17,#bit3,.		; 0A B8 17 FC
	subc	a,r4				; 0A B9
	clr1	saddrFF17,#bit3			; 0A BA 17
	subc	a,r5				; 0A BB
						; 0A BC
	subc	a,r6				; 0A BD
	clr1	[hl],#bit3			; 0A BE
	subc	a,r7				; 0A BF

	bt	a,#bit4,.			; 0A C0 FD
	inc	r0				; 0A C1
	clr1	a,#bit4				; 0A C2
	inc	r1				; 0A C3
	bt	sfrFF21,#bit4,.			; 0A C4 21 FC
	inc	r2				; 0A C5
	clr1	sfrFF21,#bit4			; 0A C6 21
	inc	r3				; 0A C7
	bt	saddrFF17,#bit4,.		; 0A C8 17 FC
	inc	r4				; 0A C9
	clr1	saddrFF17,#bit4			; 0A CA 17
	inc	r5				; 0A CB
						; 0A CC
	inc	r6				; 0A CD
	clr1	[hl],#bit4			; 0A CE
	inc	r7				; 0A CF

	bt	a,#bit5,.			; 0A D0 FD
	dec	r0				; 0A D1
	clr1	a,#bit5				; 0A D2
	dec	r1				; 0A D3
	bt	sfrFF21,#bit5,.			; 0A D4 21 FC
	dec	r2				; 0A D5
	clr1	sfrFF21,#bit5			; 0A D6 21
	dec	r3				; 0A D7
	bt	saddrFF17,#bit5,.		; 0A D8 17 FC
	dec	r4				; 0A D9
	clr1	saddrFF17,#bit5			; 0A DA 17
	dec	r5				; 0A DB
						; 0A DC
	dec	r6				; 0A DD
	clr1	[hl],#bit5			; 0A DE
	dec	r7				; 0A DF

	bt	a,#bit6,.			; 0A E0 FD
	mov	r0,a				; 0A E1
	clr1	a,#bit6				; 0A E2
						; 0A E3
	bt	sfrFF21,#bit6,.			; 0A E4 21 FC
	mov	r2,a				; 0A E5
	clr1	sfrFF21,#bit6			; 0A E6 21
	mov	r3,a				; 0A E7
	bt	saddrFF17,#bit6,.		; 0A E8 17 FC
	mov	r4,a				; 0A E9
	clr1	saddrFF17,#bit6			; 0A EA 17
	mov	r5,a				; 0A EB
						; 0A EC
	mov	r6,a				; 0A ED
	clr1	[hl],#bit6			; 0A EE
	mov	r7,a				; 0A EF

	bt	a,#bit7,.			; 0A F0 FD
	mov	r0,#byt01			; 0A F1 01
	clr1	a,#bit7				; 0A F2
	mov	r1,#byt23			; 0A F3 23
	bt	sfrFF21,#bit7,.			; 0A F4 21 FC
	mov	r2,#byt45			; 0A F5 45
	clr1	sfrFF21,#bit7			; 0A F6 21
	mov	r3,#byt67			; 0A F7 67
	bt	saddrFF17,#bit7,.		; 0A F8 17 FC
	mov	r4,#byt01			; 0A F9 01
	clr1	saddrFF17,#bit7			; 0A FA 17
	mov	r5,#byt23			; 0A FB 23
						; 0A FC
	mov	r6,#byt45			; 0A FD 45
	clr1	[hl],#bit7			; 0A FE
	mov	r7,#byt67			; 0A FF 67


	.sbttl	Expansion Page '0A' Sequential (External Symbols)

	bf	a,#exbit+0,.			; 0Ar00 FD
						; 0A 01
	set1	a,#exbit+0			; 0Ar02
						; 0A 03
	bf	*exsfr+0xFF21,#exbit+0,.	; 0Ar04r21 FC
	xch	a,r2				; 0A 05
	set1	*exsfr+0xFF21,#exbit+0		; 0Ar06r21
	xch	a,r3				; 0A 07
	bf	@exsaddr+0xFF17,#exbit+0,.	; 0Ar08r17 FC
	xch	a,r4				; 0A 09
	set1	@exsaddr+0xFF17,#exbit+0	; 0Ar0Ar17
	xch	a,r5				; 0A 0B
						; 0A 0C
	xch	a,r6				; 0A 0D
	set1	[hl],#exbit+0			; 0Ar0E
	xch	a,r7				; 0A 0F

	bf	a,#exbit+1,.			; 0Ar10 FD
	cmp	a,r0				; 0A 11
	set1	a,#exbit+1			; 0Ar12
	cmp	a,r1				; 0A 13
	bf	*exsfr+0xFF21,#exbit+1,.	; 0Ar14r21 FC
	cmp	a,r2				; 0A 15
	set1	*exsfr+0xFF21,#exbit+1		; 0Ar16r21
	cmp	a,r3				; 0A 17
	bf	@exsaddr+0xFF17,#exbit+1,.	; 0Ar18r17 FC
	cmp	a,r4				; 0A 19
	set1	@exsaddr+0xFF17,#exbit+1	; 0Ar1Ar17
	cmp	a,r5				; 0A 1B
						; 0A 1C
	cmp	a,r6				; 0A 1D
	set1	[hl],#exbit+1			; 0Ar1E
	cmp	a,r7				; 0A 1F

	bf	a,#exbit+2,.			; 0Ar20 FD
	mov	a,r0				; 0A 21
	set1	a,#exbit+2			; 0Ar22
						; 0A 23
	bf	*exsfr+0xFF21,#exbit+2,.	; 0Ar24r21 FC
	mov	a,r2				; 0A 25
	set1	*exsfr+0xFF21,#exbit+2		; 0Ar26r21
	mov	a,r3				; 0A 27
	bf	@exsaddr+0xFF17,#exbit+2,.	; 0Ar28r17 FC
	mov	a,r4				; 0A 29
	set1	@exsaddr+0xFF17,#exbit+2	; 0Ar2Ar17
	mov	a,r5				; 0A 2B
						; 0A 2C
	mov	a,r6				; 0A 2D
	set1	[hl],#exbit+2			; 0Ar2E
	mov	a,r7				; 0A 2F

	bf	a,#exbit+3,.			; 0Ar30 FD
						; 0A 31
	set1	a,#exbit+3			; 0Ar32
						; 0A 33
	bf	*exsfr+0xFF21,#exbit+3,.	; 0Ar34r21 FC
						; 0A 35
	set1	*exsfr+0xFF21,#exbit+3		; 0Ar36r21
						; 0A 37
	bf	@exsaddr+0xFF17,#exbit+3,.	; 0Ar38r17 FC
						; 0A 39
	set1	@exsaddr+0xFF17,#exbit+3	; 0Ar3Ar17
						; 0A 3B
						; 0A 3C
						; 0A 3D
	set1	[hl],#exbit+3			; 0Ar3E
						; 0A 3F

	bf	a,#exbit+4,.			; 0Ar40 FD
	xor	a,r0				; 0A 41
	set1	a,#exbit+4			; 0Ar42
	xor	a,r1				; 0A 43
	bf	*exsfr+0xFF21,#exbit+4,.	; 0Ar44r21 FC
	xor	a,r2				; 0A 45
	set1	*exsfr+0xFF21,#exbit+4		; 0Ar46r21
	xor	a,r3				; 0A 47
	bf	@exsaddr+0xFF17,#exbit+4,.	; 0Ar48r17 FC
	xor	a,r4				; 0A 49
	set1	@exsaddr+0xFF17,#exbit+4	; 0Ar4Ar17
	xor	a,r5				; 0A 4B
						; 0A 4C
	xor	a,r6				; 0A 4D
	set1	[hl],#exbit+4			; 0Ar4E
	xor	a,r7				; 0A 4F

	bf	a,#exbit+5,.			; 0Ar50 FD
						; 0A 51
	set1	a,#exbit+5			; 0Ar52
						; 0A 53
	bf	*exsfr+0xFF21,#exbit+5,.	; 0Ar54r21 FC
						; 0A 55
	set1	*exsfr+0xFF21,#exbit+5		; 0Ar56r21
						; 0A 57
	bf	@exsaddr+0xFF17,#exbit+5,.	; 0Ar58r17 FC
						; 0A 59
	set1	@exsaddr+0xFF17,#exbit+5	; 0Ar5Ar17
						; 0A 5B
						; 0A 5C
						; 0A 5D
	set1	[hl],#exbit+5			; 0Ar5E
						; 0A 5F

	bf	a,#exbit+6,.			; 0Ar60 FD
	and	a,r0				; 0A 61
	set1	a,#exbit+6			; 0Ar62
	and	a,r1				; 0A 63
	bf	*exsfr+0xFF21,#exbit+6,.	; 0Ar64r21 FC
	and	a,r2				; 0A 65
	set1	*exsfr+0xFF21,#exbit+6		; 0Ar66r21
	and	a,r3				; 0A 67
	bf	@exsaddr+0xFF17,#exbit+6,.	; 0Ar68r17 FC
	and	a,r4				; 0A 69
	set1	@exsaddr+0xFF17,#exbit+6	; 0Ar6Ar17
	and	a,r5				; 0A 6B
						; 0A 6C
	and	a,r6				; 0A 6D
	set1	[hl],#exbit+6			; 0Ar6E
	and	a,r7				; 0A 6F

	bf	a,#exbit+7,.			; 0Ar70 FD
	or	a,r0				; 0A 71
	set1	a,#exbit+7			; 0Ar72
	or	a,r1				; 0A 73
	bf	*exsfr+0xFF21,#exbit+7,.	; 0Ar74r21 FC
	or	a,r2				; 0A 75
	set1	*exsfr+0xFF21,#exbit+7		; 0Ar76r21
	or	a,r3				; 0A 77
	bf	@exsaddr+0xFF17,#exbit+7,.	; 0Ar78r17 FC
	or	a,r4				; 0A 79
	set1	@exsaddr+0xFF17,#exbit+7	; 0Ar7Ar17
	or	a,r5				; 0A 7B
						; 0A 7C
	or	a,r6				; 0A 7D
	set1	[hl],#exbit+7			; 0Ar7E
	or	a,r7				; 0A 7F

	bt	a,#exbit+0,.			; 0Ar80 FD
	add	a,r0				; 0A 81
	clr1	a,#exbit+0			; 0Ar82
	add	a,r1				; 0A 83
	bt	*exsfr+0xFF21,#exbit+0,.	; 0Ar84r21 FC
	add	a,r2				; 0A 85
	clr1	*exsfr+0xFF21,#exbit+0		; 0Ar86r21
	add	a,r3				; 0A 87
	bt	@exsaddr+0xFF17,#exbit+0,.	; 0Ar88r17 FC
	add	a,r4				; 0A 89
	clr1	@exsaddr+0xFF17,#exbit+0	; 0Ar8Ar17
	add	a,r5				; 0A 8B
						; 0A 8C
	add	a,r6				; 0A 8D
	clr1	[hl],#exbit+0			; 0Ar8E
	add	a,r7				; 0A 8F

	bt	a,#exbit+1,.			; 0Ar90 FD
	sub	a,r0				; 0A 91
	clr1	a,#exbit+1			; 0Ar92
	sub	a,r1				; 0A 93
	bt	*exsfr+0xFF21,#exbit+1,.	; 0Ar94r21 FC
	sub	a,r2				; 0A 95
	clr1	*exsfr+0xFF21,#exbit+1		; 0Ar96r21
	sub	a,r3				; 0A 97
	bt	@exsaddr+0xFF17,#exbit+1,.	; 0Ar98r17 FC
	sub	a,r4				; 0A 99
	clr1	@exsaddr+0xFF17,#exbit+1	; 0Ar9Ar17
	sub	a,r5				; 0A 9B
						; 0A 9C
	sub	a,r6				; 0A 9D
	clr1	[hl],#exbit+1			; 0Ar9E
	sub	a,r7				; 0A 9F

	bt	a,#exbit+2,.			; 0ArA0 FD
	addc	a,r0				; 0A A1
	clr1	a,#exbit+2			; 0ArA2
	addc	a,r1				; 0A A3
	bt	*exsfr+0xFF21,#exbit+2,.	; 0ArA4r21 FC
	addc	a,r2				; 0A A5
	clr1	*exsfr+0xFF21,#exbit+2		; 0ArA6r21
	addc	a,r3				; 0A A7
	bt	@exsaddr+0xFF17,#exbit+2,.	; 0ArA8r17 FC
	addc	a,r4				; 0A A9
	clr1	@exsaddr+0xFF17,#exbit+2	; 0ArAAr17
	addc	a,r5				; 0A AB
						; 0A AC
	addc	a,r6				; 0A AD
	clr1	[hl],#exbit+2			; 0ArAE
	addc	a,r7				; 0A AF

	bt	a,#exbit+3,.			; 0ArB0 FD
	subc	a,r0				; 0A B1
	clr1	a,#exbit+3			; 0ArB2
	subc	a,r1				; 0A B3
	bt	*exsfr+0xFF21,#exbit+3,.	; 0ArB4r21 FC
	subc	a,r2				; 0A B5
	clr1	*exsfr+0xFF21,#exbit+3		; 0ArB6r21
	subc	a,r3				; 0A B7
	bt	@exsaddr+0xFF17,#exbit+3,.	; 0ArB8r17 FC
	subc	a,r4				; 0A B9
	clr1	@exsaddr+0xFF17,#exbit+3	; 0ArBAr17
	subc	a,r5				; 0A BB
						; 0A BC
	subc	a,r6				; 0A BD
	clr1	[hl],#exbit+3			; 0ArBE
	subc	a,r7				; 0A BF

	bt	a,#exbit+4,.			; 0ArC0 FD
	inc	r0				; 0A C1
	clr1	a,#exbit+4			; 0ArC2
	inc	r1				; 0A C3
	bt	*exsfr+0xFF21,#exbit+4,.	; 0ArC4r21 FC
	inc	r2				; 0A C5
	clr1	*exsfr+0xFF21,#exbit+4		; 0ArC6r21
	inc	r3				; 0A C7
	bt	@exsaddr+0xFF17,#exbit+4,.	; 0ArC8r17 FC
	inc	r4				; 0A C9
	clr1	@exsaddr+0xFF17,#exbit+4	; 0ArCAr17
	inc	r5				; 0A CB
						; 0A CC
	inc	r6				; 0A CD
	clr1	[hl],#exbit+4			; 0ArCE
	inc	r7				; 0A CF

	bt	a,#exbit+5,.			; 0ArD0 FD
	dec	r0				; 0A D1
	clr1	a,#exbit+5			; 0ArD2
	dec	r1				; 0A D3
	bt	*exsfr+0xFF21,#exbit+5,.	; 0ArD4r21 FC
	dec	r2				; 0A D5
	clr1	*exsfr+0xFF21,#exbit+5		; 0ArD6r21
	dec	r3				; 0A D7
	bt	@exsaddr+0xFF17,#exbit+5,.	; 0ArD8r17 FC
	dec	r4				; 0A D9
	clr1	@exsaddr+0xFF17,#exbit+5	; 0ArDAr17
	dec	r5				; 0A DB
						; 0A DC
	dec	r6				; 0A DD
	clr1	[hl],#exbit+5			; 0ArDE
	dec	r7				; 0A DF

	bt	a,#exbit+6,.			; 0ArE0 FD
	mov	r0,a				; 0A E1
	clr1	a,#exbit+6			; 0ArE2
						; 0A E3
	bt	*exsfr+0xFF21,#exbit+6,.	; 0ArE4r21 FC
	mov	r2,a				; 0A E5
	clr1	*exsfr+0xFF21,#exbit+6		; 0ArE6r21
	mov	r3,a				; 0A E7
	bt	@exsaddr+0xFF17,#exbit+6,.	; 0ArE8r17 FC
	mov	r4,a				; 0A E9
	clr1	@exsaddr+0xFF17,#exbit+6	; 0ArEAr17
	mov	r5,a				; 0A EB
						; 0A EC
	mov	r6,a				; 0A ED
	clr1	[hl],#exbit+6			; 0ArEE
	mov	r7,a				; 0A EF

	bt	a,#exbit+7,.			; 0ArF0 FD
	mov	r0,#exbyt+0x01			; 0A F1r01
	clr1	a,#exbit+7			; 0ArF2
	mov	r1,#exbyt+0x23			; 0A F3r23
	bt	*exsfr+0xFF21,#exbit+7,.	; 0ArF4r21 FC
	mov	r2,#exbyt+0x45			; 0A F5r45
	clr1	*exsfr+0xFF21,#exbit+7		; 0ArF6r21
	mov	r3,#exbyt+0x67			; 0A F7r67
	bt	@exsaddr+0xFF17,#exbit+7,.	; 0ArF8r17 FC
	mov	r4,#exbyt+0x01			; 0A F9r01
	clr1	@exsaddr+0xFF17,#exbit+7	; 0ArFAr17
	mov	r5,#exbyt+0x23			; 0A FBr23
						; 0A FC
	mov	r6,#exbyt+0x45			; 0A FDr45
	clr1	[hl],#exbit+7			; 0ArFE
	mov	r7,#exbyt+0x67			; 0A FFr67


	.sbttl	Relocatable Branching Tests

	.area	AA(rel,con)

1$:	br	2$
			; .lst			; 30p00
			; .rst			; 30 01
	.blkb	1

	.area	AB(rel,con)

2$:	bc	1$
			; .lst			; 38p00
			; .rst			; 38 FB
	.blkb	1
3$:	bnc	4$
			; .lst			; 3Ap00
			; .rst			; 3A 01
	.blkb	1

	.area	AC(rel,con)

4$:	dbnz	b,3$
			; .lst			; 36p03
			; .rst			; 36 FB
	.blkb	1
5$:	dbnz	c,6$
			; .lst			; 34p00
			; .rst			; 34 01
	.blkb	1

	.area	AD(rel,con)

6$:	br	!5$
			; .lst			; B2p03q00
			; .rst			; B2 0C 00
	.blkb	1

	.area	AE(rel,con)

	call	6$
			; .lst			; 22r00s00
			; .rst			; 22 0F 00




