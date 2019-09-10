	.title	AS8008S Assembler Test
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
	rfc			; 03
	adi	ival+0x00	; 04 00
	rst	rval+0		; 05
	lia	ival+0x01	; 06 01
	ret			; 07

	inb			; 08
	dcb			; 09
	rrc			; 0A
	rfz			; 0B
	aci	ival+0x02	; 0C 02
	rst	rval+1		; 0D
	lib	ival+0x03	; 0E 03
	;ret			; 0F

	inc			; 10
	dcc			; 11
	ral			; 12
	rfs			; 13
	sui	ival+0x04	; 14 04
	rst	rval+2		; 15
	lic	ival+0x05	; 16 05
	;ret			; 17

	ind			; 18
	dcd			; 19
	rar			; 1A
	rfp			; 1B
	sbi	ival+0x06	; 1C 06
	rst	rval+3		; 1D
	lid	ival+0x07	; 1E 07
	;ret			; 1F

	.page

	ine			; 20
	dce			; 21
	; --------------------- ; 22
	rtc			; 23
	ndi	ival+0x08	; 24 08
	rst	rval+4		; 25
	lie	ival+0x09	; 26 09
	; --------------------- ; 27

	inh			; 28
	dch			; 29
	; --------------------- ; 2A
	rtz			; 2B
	xri	ival+0x0A	; 2C 0A
	rst	rval+5		; 2D
	lih	ival+0x0B	; 2E 0B
	; --------------------- ; 2F

	inl			; 30
	dcl			; 31
	; --------------------- ; 32
	rts			; 33
	ori	ival+0x0C	; 34 0c
	rst	rval+6		; 35
	lil	ival+0x0D	; 36 0D
	;ret			; 37

	; --------------------- ; 38
	; --------------------- ; 39
	; --------------------- ; 3A
	rtp			; 3B
	cpi	ival+0x0E	; 3C 0E
	rst	rval+7		; 3D
	lim	ival+0x0F	; 3E 0F
	;ret			; 3F

	.page

	jfc	jcval+0x0001	; 40 01 00
	inp	port+0		; 41
	cfc	jcval+0x0102	; 42 02 01
	inp	port+1		; 43
	jmp	jcval+0x0203	; 44 03 02
	inp	port+2		; 45
	cal	jcval+0x0304	; 46 04 03
	inp	port+3		; 47

	jfz	jcval+0x0405	; 48 05 04
	inp	port+4		; 49
	cnz	jcval+0x0506	; 4A 06 05
	inp	port+5		; 4B
	; --------------------- ; 4C
	inp	port+6		; 4D
	; --------------------- ; 4E
	inp	port+7		; 4F

	jfs	jcval+0x0607	; 50 07 06
	out	port+8		; 51
	cfs	jcval+0x0708	; 52 08 07
	out	port+9		; 53
	; --------------------- ; 54
	out	port+10		; 55
	; --------------------- ; 56
	out	port+11		; 57

	jfp	jcval+0x0809	; 58 09 08
	out	port+12		; 59
	cfp	jcval+0x090A	; 5A 0A 09
	out	port+13		; 5B
	; --------------------- ; 5C
	out	port+14		; 5D
	; --------------------- ; 5E
	out	port+15		; 5F

	.page

	jtc	jcval+0x0A0B	; 60 0B 0A
	out	port+16		; 61
	ctc	jcval+0x0B0C	; 62 0C 0B
	out	port+17		; 63
	; --------------------- ; 64
	out	port+18		; 65
	; --------------------- ; 66
	out	port+19		; 67

	jtz	jcval+0x0C0D	; 68 0D 0C
	out	port+20		; 69
	ctz	jcval+0x0D0E	; 6A 0E 0D
	out	port+21		; 6B
	; --------------------- ; 6C
	out	port+22		; 6D
	; --------------------- ; 6E
	out	port+23		; 6F

	jtm	jcval+0x0E0F	; 70 0F 0E
	out	port+24		; 71
	ctm	jcval+0x0F10	; 72 10 0F
	out	port+25		; 73
	; --------------------- ; 74
	out	port+26		; 75
	; --------------------- ; 76
	out	port+27		; 77

	jtp	jcval+0x1011	; 78 11 10
	out	port+28		; 79
	ctp	jcval+0x1112	; 7A 12 11
	out	port+29		; 7B
	; --------------------- ; 7C
	out	port+30		; 7D
	; --------------------- ; 7E
	out	port+31		; 7F

	.page

	ada			; 80
	adb			; 81
	adc			; 82
	add			; 83
	ade			; 84
	adh			; 85
	adl			; 86
	adm			; 87

	aca			; 88
	acb			; 89
	acc			; 8A
	acd			; 8B
	ace			; 8C
	ach			; 8D
	acl			; 8E
	acm			; 8F

	sua			; 90
	sub			; 91
	suc			; 92
	sud			; 93
	sue			; 94
	suh			; 95
	sul			; 96
	sum			; 97

	sba			; 98
	sbb			; 99
	sbc			; 9A
	sbd			; 9B
	sbe			; 9C
	sbh			; 9D
	sbl			; 9E
	sbm			; 9F

	.page

	nda			; A0
	ndb			; A1
	ndc			; A2
	ndd			; A3
	nde			; A4
	ndh			; A5
	ndl			; A6
	ndm			; A7

	xra			; A8
	xrb			; A9
	xrc			; AA
	xrd			; AB
	xre			; AC
	xrh			; AD
	xrl			; AE
	xrm			; AF

	ora			; B0
	orb			; B1
	orc			; B2
	ord			; B3
	ore			; B4
	orh			; B5
	orl			; B6
	orm			; B7

	cpa			; B8
	cpb			; B9
	cpc			; BA
	cpd			; BB
	cpe			; BC
	cph			; BD
	cpl			; BE
	cpm			; BF

	.page

	nop			; C0
	lab			; C1
	lac			; C2
	lad			; C3
	lae			; C4
	lah			; C5
	lal			; C6
	lam			; C7

	lba			; C8
	lbb			; C9
	lbc			; CA
	lbd			; CB
	lbe			; CC
	lbh			; CD
	lbl			; CE
	lbm			; CF

	lca			; D0
	lcb			; D1
	lcc			; D2
	lcd			; D3
	lce			; D4
	lch			; D5
	lcl			; D6
	lcm			; D7

	lda			; D8
	ldb			; D9
	ldc			; DA
	ldd			; DB
	lde			; DC
	ldh			; DD
	ldl			; DE
	ldm			; DF

	.page

	lea			; E0
	leb			; E1
	lec			; E2
	led			; E3
	lee			; E4
	leh			; E5
	lel			; E6
	lem			; E7

	lha			; E8
	lhb			; E9
	lhc			; EA
	lhd			; EB
	lhe			; EC
	lhh			; ED
	lhl			; EE
	lhm			; EF

	lla			; F0
	llb			; F1
	llc			; F2
	lld			; F3
	lle			; F4
	llh			; F5
	lll			; F6
	llm			; F7

	lma			; F8
	lmb			; F9
	lmc			; FA
	lmd			; FB
	lme			; FC
	lmh			; FD
	lml			; FE
	; --------------------- ; FF


	shl	ival+0x2301	; 2E 23 36 01


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
	rfc			; 03
	adi	ival+0x00	; 04r00
	rst	rval+0		;r05
	lia	ival+0x01	; 06r01
	ret			; 07

	inb			; 08
	dcb			; 09
	rrc			; 0A
	rfz			; 0B
	aci	ival+0x02	; 0Cr02
	rst	rval+1		;r0D
	lib	ival+0x03	; 0Er03
	;ret			; 0F

	inc			; 10
	dcc			; 11
	ral			; 12
	rfs			; 13
	sui	ival+0x04	; 14r04
	rst	rval+2		;r15
	lic	ival+0x05	; 16r05
	;ret			; 17

	ind			; 18
	dcd			; 19
	rar			; 1A
	rfp			; 1B
	sbi	ival+0x06	; 1Cr06
	rst	rval+3		;r1D
	lid	ival+0x07	; 1Er07
	;ret			; 1F

	.page

	ine			; 20
	dce			; 21
	; --------------------- ; 22
	rtc			; 23
	ndi	ival+0x08	; 24r08
	rst	rval+4		;r25
	lie	ival+0x09	; 26r09
	; --------------------- ; 27

	inh			; 28
	dch			; 29
	; --------------------- ; 2A
	rtz			; 2B
	xri	ival+0x0A	; 2Cr0A
	rst	rval+5		;r2D
	lih	ival+0x0B	; 2Er0B
	; --------------------- ; 2F

	inl			; 30
	dcl			; 31
	; --------------------- ; 32
	rts			; 33
	ori	ival+0x0C	; 34r0c
	rst	rval+6		;r35
	lil	ival+0x0D	; 36r0D
	;ret			; 37

	; --------------------- ; 38
	; --------------------- ; 39
	; --------------------- ; 3A
	rtp			; 3B
	cpi	ival+0x0E	; 3Cr0E
	rst	rval+7		;r3D
	lim	ival+0x0F	; 3Er0F
	;ret			; 3F

	.page

	jfc	jcval+0x0001	; 40r01s00
	inp	port+0		;r41
	cfc	jcval+0x0102	; 42r02s01
	inp	port+1		;r43
	jmp	jcval+0x0203	; 44r03s02
	inp	port+2		;r45
	cal	jcval+0x0304	; 46r04s03
	inp	port+3		;r47

	jfz	jcval+0x0405	; 48r05s04
	inp	port+4		;r49
	cnz	jcval+0x0506	; 4Ar06s05
	inp	port+5		;r4B
	; --------------------- ; 4C
	inp	port+6		;r4D
	; --------------------- ; 4E
	inp	port+7		;r4F

	jfs	jcval+0x0607	; 50r07s06
	out	port+8		;r51
	cfs	jcval+0x0708	; 52r08s07
	out	port+9		;r53
	; --------------------- ; 54
	out	port+10		;r55
	; --------------------- ; 56
	out	port+11		;r57

	jfp	jcval+0x0809	; 58r09s08
	out	port+12		;r59
	cfp	jcval+0x090A	; 5Ar0As09
	out	port+13		;r5B
	; --------------------- ; 5C
	out	port+14		;r5D
	; --------------------- ; 5E
	out	port+15		;r5F

	.page

	jtc	jcval+0x0A0B	; 60r0Bs0A
	out	port+16		;r61
	ctc	jcval+0x0B0C	; 62r0Cs0B
	out	port+17		;r63
	; --------------------- ; 64
	out	port+18		;r65
	; --------------------- ; 66
	out	port+19		;r67

	jtz	jcval+0x0C0D	; 68r0Ds0C
	out	port+20		;r69
	ctz	jcval+0x0D0E	; 6Ar0Es0D
	out	port+21		;r6B
	; --------------------- ; 6C
	out	port+22		;r6D
	; --------------------- ; 6E
	out	port+23		;r6F

	jtm	jcval+0x0E0F	; 70r0Fs0E
	out	port+24		;r71
	ctm	jcval+0x0F10	; 72r10s0F
	out	port+25		;r73
	; --------------------- ; 74
	out	port+26		;r75
	; --------------------- ; 76
	out	port+27		;r77

	jtp	jcval+0x1011	; 78r11s10
	out	port+28		;r79
	ctp	jcval+0x1112	; 7Ar12s11
	out	port+29		;r7B
	; --------------------- ; 7C
	out	port+30		;r7D
	; --------------------- ; 7E
	out	port+31		;r7F

	.page

	ada			; 80
	adb			; 81
	adc			; 82
	add			; 83
	ade			; 84
	adh			; 85
	adl			; 86
	adm			; 87

	aca			; 88
	acb			; 89
	acc			; 8A
	acd			; 8B
	ace			; 8C
	ach			; 8D
	acl			; 8E
	acm			; 8F

	sua			; 90
	sub			; 91
	suc			; 92
	sud			; 93
	sue			; 94
	suh			; 95
	sul			; 96
	sum			; 97

	sba			; 98
	sbb			; 99
	sbc			; 9A
	sbd			; 9B
	sbe			; 9C
	sbh			; 9D
	sbl			; 9E
	sbm			; 9F

	.page

	nda			; A0
	ndb			; A1
	ndc			; A2
	ndd			; A3
	nde			; A4
	ndh			; A5
	ndl			; A6
	ndm			; A7

	xra			; A8
	xrb			; A9
	xrc			; AA
	xrd			; AB
	xre			; AC
	xrh			; AD
	xrl			; AE
	xrm			; AF

	ora			; B0
	orb			; B1
	orc			; B2
	ord			; B3
	ore			; B4
	orh			; B5
	orl			; B6
	orm			; B7

	cpa			; B8
	cpb			; B9
	cpc			; BA
	cpd			; BB
	cpe			; BC
	cph			; BD
	cpl			; BE
	cpm			; BF

	.page

	nop			; C0
	lab			; C1
	lac			; C2
	lad			; C3
	lae			; C4
	lah			; C5
	lal			; C6
	lam			; C7

	lba			; C8
	lbb			; C9
	lbc			; CA
	lbd			; CB
	lbe			; CC
	lbh			; CD
	lbl			; CE
	lbm			; CF

	lca			; D0
	lcb			; D1
	lcc			; D2
	lcd			; D3
	lce			; D4
	lch			; D5
	lcl			; D6
	lcm			; D7

	lda			; D8
	ldb			; D9
	ldc			; DA
	ldd			; DB
	lde			; DC
	ldh			; DD
	ldl			; DE
	ldm			; DF

	.page

	lea			; E0
	leb			; E1
	lec			; E2
	led			; E3
	lee			; E4
	leh			; E5
	lel			; E6
	lem			; E7

	lha			; E8
	lhb			; E9
	lhc			; EA
	lhd			; EB
	lhe			; EC
	lhh			; ED
	lhl			; EE
	lhm			; EF

	lla			; F0
	llb			; F1
	llc			; F2
	lld			; F3
	lle			; F4
	llh			; F5
	lll			; F6
	llm			; F7

	lma			; F8
	lmb			; F9
	lmc			; FA
	lmd			; FB
	lme			; FC
	lmh			; FD
	lml			; FE
	; --------------------- ; FF


	shl	ival+0x2301	; 2Es23 36r01


	.end
