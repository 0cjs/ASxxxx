	.title	AS8008 Assembler Test
	.sbttl	Absolute Value Assembly

	.radix	D

	; Absolute Symbol Assembly
	.define		ival	"0"
	.define		rval	"0"
	.define		port	"0"
	.define		jcval	"0"

	hlt			; 00
	; --------------------- ; 01
	rlc			; 02
	rnc			; 03
	adi	ival+0x00	; 04 00
	rst	rval+0		; 05
	mvi	a,ival+0x01	; 06 01
	ret			; 07
	inr	b		; 08
	dcr	b		; 09
	rrc			; 0A
	rnz			; 0B
	aci	ival+0x02	; 0C 02
	rst	rval+1		; 0D
	mvi	b,ival+0x03	; 0E 03
	; --------------------- ; 0F

	inr	c		; 10
	dcr	c		; 11
	ral			; 12
	rp			; 13
	sui	ival+0x04	; 14 04
	rst	rval+2		; 15
	mvi	c,ival+0x05	; 16 05
	; --------------------- ; 17
	inr	d		; 18
	dcr	d		; 19
	rar			; 1A
	rpo			; 1B
	sbi	ival+0x06	; 1C 06
	rst	rval+3		; 1D
	mvi	d,ival+0x07	; 1E 07
	; --------------------- ; 1F

	.page

	inr	e		; 20
	dcr	e		; 21
	; --------------------- ; 22
	rc			; 23
	ani	ival+0x08	; 24 08
	rst	rval+4		; 25
	mvi	e,ival+0x09	; 26 09
	; --------------------- ; 27
	inr	h		; 28
	dcr	h		; 29
	; --------------------- ; 2A
	rz			; 2B
	xri	ival+0x0A	; 2C 0A
	rst	rval+5		; 2D
	mvi	h,ival+0x0B	; 2E 0B
	; --------------------- ; 2F

	inr	l		; 30
	dcr	l		; 31
	; --------------------- ; 32
	rm			; 33
	ori	ival+0x0C	; 34 0C
	rst	rval+6		; 35
	mvi	l,ival+0x0D	; 36 0D
	; --------------------- ; 37
	; --------------------- ; 38
	; --------------------- ; 39
	; --------------------- ; 3A
	rpe			; 3B
	cpi	ival+0x0E	; 3C 0E
	rst	rval+7		; 3D
	mvi	m,ival+0x0F	; 3E 0F
	; --------------------- ; 3F

	.page

	jnc	jcval+0x0001	; 40 01 00
	in	port+0		; 41
	cnc	jcval+0x0102	; 42 02 01
	in	port+1		; 43
	jmp	jcval+0x0203	; 44 03 02
	in	port+2		; 45
	call	jcval+0x0304	; 46 04 03
	in	port+3		; 47
	jnz	jcval+0x0405	; 48 05 04
	in	port+4		; 49
	cnz	jcval+0x0506	; 4A 06 05
	in	port+5		; 4B
	; --------------------- ; 4C
	in	port+6		; 4D
	; --------------------- ; 4E
	in	port+7		; 4F

	jp	jcval+0x0607	; 50 07 06
	out	port+8		; 51
	cp	jcval+0x0708	; 52 08 07
	out	port+9		; 53
	; --------------------- ; 54
	out	port+10		; 55
	; --------------------- ; 56
	out	port+11		; 57
	jpo	jcval+0x0809	; 58 09 08
	out	port+12		; 59
	cpo	jcval+0x090A	; 5A 0A 09
	out	port+13		; 5B
	; --------------------- ; 5C
	out	port+14		; 5D
	; --------------------- ; 5E
	out	port+15		; 5F

	.page

	jc	jcval+0x0A0B	; 60 0B 0A
	out	port+16		; 61
	cc	jcval+0x0B0C	; 62 0C 0B
	out	port+17		; 63
	; --------------------- ; 64
	out	port+18		; 65
	; --------------------- ; 66
	out	port+19		; 67
	jz	jcval+0x0C0D	; 68 0D 0C
	out	port+20		; 69
	cz	jcval+0x0D0E	; 6A 0E 0D
	out	port+21		; 6B
	; --------------------- ; 6C
	out	port+22		; 6D
	; --------------------- ; 6E
	out	port+23		; 6F

	jm	jcval+0x0E0F	; 70 0F 0E
	out	port+24		; 71
	cm	jcval+0x0F10	; 72 10 0F
	out	port+25		; 73
	; --------------------- ; 74
	out	port+26		; 75
	; --------------------- ; 76
	out	port+27		; 77
	jpe	jcval+0x1011	; 78 11 10
	out	port+28		; 79
	cpe	jcval+0x1112	; 7A 12 11
	out	port+29		; 7B
	; --------------------- ; 7C
	out	port+30		; 7D
	; --------------------- ; 7E
	out	port+31		; 7F

	.page

	add	a		; 80
	add	b		; 81
	add	c		; 82
	add	d		; 83
	add	e		; 84
	add	h		; 85
	add	l		; 86
	add	m		; 87
	adc	a		; 88
	adc	b		; 89
	adc	c		; 8A
	adc	d		; 8B
	adc	e		; 8C
	adc	h		; 8D
	adc	l		; 8E
	adc	m		; 8F

	sub	a		; 90
	sub	b		; 91
	sub	c		; 92
	sub	d		; 93
	sub	e		; 94
	sub	h		; 95
	sub	l		; 96
	sub	m		; 97
	sbb	a		; 98
	sbb	b		; 99
	sbb	c		; 9A
	sbb	d		; 9B
	sbb	e		; 9C
	sbb	h		; 9D
	sbb	l		; 9E
	sbb	m		; 9F

	.page

	ana	a		; A0
	ana	b		; A1
	ana	c		; A2
	ana	d		; A3
	ana	e		; A4
	ana	h		; A5
	ana	l		; A6
	ana	m		; A7
	xra	a		; A8
	xra	b		; A9
	xra	c		; AA
	xra	d		; AB
	xra	e		; AC
	xra	h		; AD
	xra	l		; AE
	xra	m		; AF

	ora	a		; B0
	ora	b		; B1
	ora	c		; B2
	ora	d		; B3
	ora	e		; B4
	ora	h		; B5
	ora	l		; B6
	ora	m		; B7
	cmp	a		; B8
	cmp	b		; B9
	cmp	c		; BA
	cmp	d		; BB
	cmp	e		; BC
	cmp	h		; BD
	cmp	l		; BE
	cmp	m		; BF

	.page

	nop			; C0
	mov	a,b		; C1
	mov	a,c		; C2
	mov	a,d		; C3
	mov	a,e		; C4
	mov	a,h		; C5
	mov	a,l		; C6
	mov	a,m		; C7
	mov	b,a		; C8
	mov	b,b		; C9
	mov	b,c		; CA
	mov	b,d		; CB
	mov	b,e		; CC
	mov	b,h		; CD
	mov	b,l		; CE
	mov	b,m		; CF

	mov	c,a		; D0
	mov	c,b		; D1
	mov	c,c		; D2
	mov	c,d		; D3
	mov	c,e		; D4
	mov	c,h		; D5
	mov	c,l		; D6
	mov	c,m		; D7
	mov	d,a		; D8
	mov	d,b		; D9
	mov	d,c		; DA
	mov	d,d		; DB
	mov	d,e		; DC
	mov	d,h		; DD
	mov	d,l		; DE
	mov	d,m		; DF

	.page

	mov	e,a		; E0
	mov	e,b		; E1
	mov	e,c		; E2
	mov	e,d		; E3
	mov	e,e		; E4
	mov	e,h		; E5
	mov	e,l		; E6
	mov	e,m		; E7
	mov	h,a		; E8
	mov	h,b		; E9
	mov	h,c		; EA
	mov	h,d		; EB
	mov	h,e		; EC
	mov	h,h		; ED
	mov	h,l		; EE
	mov	h,m		; EF

	mov	l,a		; F0
	mov	l,b		; F1
	mov	l,c		; F2
	mov	l,d		; F3
	mov	l,e		; F4
	mov	l,h		; F5
	mov	l,l		; F6
	mov	l,m		; F7
	mov	m,a		; F8
	mov	m,b		; F9
	mov	m,c		; FA
	mov	m,d		; FB
	mov	m,e		; FC
	mov	m,h		; FD
	mov	m,l		; FE
	; --------------------- ; FF

	.page
	; Immediate Instruction Alternates

	add	#ival+0x20	; 04 20
	adc	#ival+0x21	; 0C 21
	sub	#ival+0x22	; 14 22
	sbb	#ival+0x23	; 1C 23
	ana	#ival+0x24	; 24 24
	xra	#ival+0x25	; 2C 25
	ora	#ival+0x26	; 34 26
	cmp	#ival+0x27	; 3C 27

	mov	a,#ival+0x28	; 06 28
	mov	b,#ival+0x29	; 0E 29
	mov	c,#ival+0x2A	; 16 2A
	mov	d,#ival+0x2B	; 1E 2B
	mov	e,#ival+0x2C	; 26 2C
	mov	h,#ival+0x2D	; 2E 2D
	mov	l,#ival+0x2E	; 36 2E
	mov	m,#ival+0x2F	; 3E 2F


	.page
	.sbttl	External Symbol Assembly

	.undefine	ival	; must undefine string
	.undefine	rval	; substitution before
	.undefine	port	; globalizing variables
	.undefine	jcval	;

	.globl		ival
	.globl		rval
	.globl		port
	.globl		jcval

	hlt			; 00
	; --------------------- ; 01
	rlc			; 02
	rnc			; 03
	adi	ival+0x00	; 04r00
	rst	rval+0		;r05
	mvi	a,ival+0x01	; 06r01
	ret			; 07
	inr	b		; 08
	dcr	b		; 09
	rrc			; 0A
	rnz			; 0B
	aci	ival+0x02	; 0Cr02
	rst	rval+1		;r0D
	mvi	b,ival+0x03	; 0Er03
	; --------------------- ; 0F

	inr	c		; 10
	dcr	c		; 11
	ral			; 12
	rp			; 13
	sui	ival+0x04	; 14r04
	rst	rval+2		;r15
	mvi	c,ival+0x05	; 16r05
	; --------------------- ; 17
	inr	d		; 18
	dcr	d		; 19
	rar			; 1A
	rpo			; 1B
	sbi	ival+0x06	; 1Cr06
	rst	rval+3		;r1D
	mvi	d,ival+0x07	; 1Er07
	; --------------------- ; 1F

	.page

	inr	e		; 20
	dcr	e		; 21
	; --------------------- ; 22
	rc			; 23
	ani	ival+0x08	; 24r08
	rst	rval+4		;r25
	mvi	e,ival+0x09	; 26r09
	; --------------------- ; 27
	inr	h		; 28
	dcr	h		; 29
	; --------------------- ; 2A
	rz			; 2B
	xri	ival+0x0A	; 2Cr0A
	rst	rval+5		;r2D
	mvi	h,ival+0x0B	; 2Er0B
	; --------------------- ; 2F

	inr	l		; 30
	dcr	l		; 31
	; --------------------- ; 32
	rm			; 33
	ori	ival+0x0C	; 34r0C
	rst	rval+6		;r35
	mvi	l,ival+0x0D	; 36r0D
	; --------------------- ; 37
	; --------------------- ; 38
	; --------------------- ; 39
	; --------------------- ; 3A
	rpe			; 3B
	cpi	ival+0x0E	; 3Cr0E
	rst	rval+7		;r3D
	mvi	m,ival+0x0F	; 3Er0F
	; --------------------- ; 3F

	.page

	jnc	jcval+0x0001	; 40r01s00
	in	port+0		;r41
	cnc	jcval+0x0102	; 42r02s01
	in	port+1		;r43
	jmp	jcval+0x0203	; 44r03s02
	in	port+2		;r45
	call	jcval+0x0304	; 46r04s03
	in	port+3		;r47
	jnz	jcval+0x0405	; 48r05s04
	in	port+4		;r49
	cnz	jcval+0x0506	; 4Ar06s05
	in	port+5		;r4B
	; --------------------- ; 4C
	in	port+6		;r4D
	; --------------------- ; 4E
	in	port+7		;r4F

	jp	jcval+0x0607	; 50r07s06
	out	port+8		;r51
	cp	jcval+0x0708	; 52r08s07
	out	port+9		;r53
	; --------------------- ; 54
	out	port+10		;r55
	; --------------------- ; 56
	out	port+11		;r57
	jpo	jcval+0x0809	; 58r09s08
	out	port+12		;r59
	cpo	jcval+0x090A	; 5Ar0As09
	out	port+13		;r5B
	; --------------------- ; 5C
	out	port+14		;r5D
	; --------------------- ; 5E
	out	port+15		;r5F

	.page

	jc	jcval+0x0A0B	; 60r0Bs0A
	out	port+16		;r61
	cc	jcval+0x0B0C	; 62r0Cs0B
	out	port+17		;r63
	; --------------------- ; 64
	out	port+18		;r65
	; --------------------- ; 66
	out	port+19		;r67
	jz	jcval+0x0C0D	; 68r0Ds0C
	out	port+20		;r69
	cz	jcval+0x0D0E	; 6Ar0Es0D
	out	port+21		;r6B
	; --------------------- ; 6C
	out	port+22		;r6D
	; --------------------- ; 6E
	out	port+23		;r6F

	jm	jcval+0x0E0F	; 70r0Fs0E
	out	port+24		;r71
	cm	jcval+0x0F10	; 72r10s0F
	out	port+25		;r73
	; --------------------- ; 74
	out	port+26		;r75
	; --------------------- ; 76
	out	port+27		;r77
	jpe	jcval+0x1011	; 78r11s10
	out	port+28		;r79
	cpe	jcval+0x1112	; 7Ar12s11
	out	port+29		;r7B
	; --------------------- ; 7C
	out	port+30		;r7D
	; --------------------- ; 7E
	out	port+31		;r7F

	.page

	add	a		; 80
	add	b		; 81
	add	c		; 82
	add	d		; 83
	add	e		; 84
	add	h		; 85
	add	l		; 86
	add	m		; 87
	adc	a		; 88
	adc	b		; 89
	adc	c		; 8A
	adc	d		; 8B
	adc	e		; 8C
	adc	h		; 8D
	adc	l		; 8E
	adc	m		; 8F

	sub	a		; 90
	sub	b		; 91
	sub	c		; 92
	sub	d		; 93
	sub	e		; 94
	sub	h		; 95
	sub	l		; 96
	sub	m		; 97
	sbb	a		; 98
	sbb	b		; 99
	sbb	c		; 9A
	sbb	d		; 9B
	sbb	e		; 9C
	sbb	h		; 9D
	sbb	l		; 9E
	sbb	m		; 9F

	.page

	ana	a		; A0
	ana	b		; A1
	ana	c		; A2
	ana	d		; A3
	ana	e		; A4
	ana	h		; A5
	ana	l		; A6
	ana	m		; A7
	xra	a		; A8
	xra	b		; A9
	xra	c		; AA
	xra	d		; AB
	xra	e		; AC
	xra	h		; AD
	xra	l		; AE
	xra	m		; AF

	ora	a		; B0
	ora	b		; B1
	ora	c		; B2
	ora	d		; B3
	ora	e		; B4
	ora	h		; B5
	ora	l		; B6
	ora	m		; B7
	cmp	a		; B8
	cmp	b		; B9
	cmp	c		; BA
	cmp	d		; BB
	cmp	e		; BC
	cmp	h		; BD
	cmp	l		; BE
	cmp	m		; BF

	.page

	nop			; C0
	mov	a,b		; C1
	mov	a,c		; C2
	mov	a,d		; C3
	mov	a,e		; C4
	mov	a,h		; C5
	mov	a,l		; C6
	mov	a,m		; C7
	mov	b,a		; C8
	mov	b,b		; C9
	mov	b,c		; CA
	mov	b,d		; CB
	mov	b,e		; CC
	mov	b,h		; CD
	mov	b,l		; CE
	mov	b,m		; CF

	mov	c,a		; D0
	mov	c,b		; D1
	mov	c,c		; D2
	mov	c,d		; D3
	mov	c,e		; D4
	mov	c,h		; D5
	mov	c,l		; D6
	mov	c,m		; D7
	mov	d,a		; D8
	mov	d,b		; D9
	mov	d,c		; DA
	mov	d,d		; DB
	mov	d,e		; DC
	mov	d,h		; DD
	mov	d,l		; DE
	mov	d,m		; DF

	.page

	mov	e,a		; E0
	mov	e,b		; E1
	mov	e,c		; E2
	mov	e,d		; E3
	mov	e,e		; E4
	mov	e,h		; E5
	mov	e,l		; E6
	mov	e,m		; E7
	mov	h,a		; E8
	mov	h,b		; E9
	mov	h,c		; EA
	mov	h,d		; EB
	mov	h,e		; EC
	mov	h,h		; ED
	mov	h,l		; EE
	mov	h,m		; EF

	mov	l,a		; F0
	mov	l,b		; F1
	mov	l,c		; F2
	mov	l,d		; F3
	mov	l,e		; F4
	mov	l,h		; F5
	mov	l,l		; F6
	mov	l,m		; F7
	mov	m,a		; F8
	mov	m,b		; F9
	mov	m,c		; FA
	mov	m,d		; FB
	mov	m,e		; FC
	mov	m,h		; FD
	mov	m,l		; FE
	; --------------------- ; FF

	.page
	; Immediate Instruction Alternates

	add	#ival+0x20	; 04r20
	adc	#ival+0x21	; 0Cr21
	sub	#ival+0x22	; 14r22
	sbb	#ival+0x23	; 1Cr23
	ana	#ival+0x24	; 24r24
	xra	#ival+0x25	; 2Cr25
	ora	#ival+0x26	; 34r26
	cmp	#ival+0x27	; 3Cr27

	mov	a,#ival+0x28	; 06r28
	mov	b,#ival+0x29	; 0Er29
	mov	c,#ival+0x2A	; 16r2A
	mov	d,#ival+0x2B	; 1Er2B
	mov	e,#ival+0x2C	; 26r2C
	mov	h,#ival+0x2D	; 2Er2D
	mov	l,#ival+0x2E	; 36r2E
	mov	m,#ival+0x2F	; 3Er2F


	.end
