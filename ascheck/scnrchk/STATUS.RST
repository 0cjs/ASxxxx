ASxxxx Assembler V05.06+  (Motorola 6809)                               Page 1
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Status Screens

                              2 	.sbttl	Status Screens
                              3 
                              4 	.module	status
                              5 
ASxxxx Assembler V05.06+  (Motorola 6809)                               Page 2
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Status Screens

                              6 	.include	/area.def/
                              1 	.sbttl	Area / Bank Definitions and Linking Order
                              2 
                              3 	; CODE, DATA, and OPTION banks
                              4 
                              5 	.bank	CODE		;(FSFX=_CD)
                              6 	.bank	DATA		;(FSFX=_DT)
                              7 	.bank	OPTN		(FSFX=_OP)
                              8 
                              9 	; indexed label definitions
                             10 
                             11 	.area	PORTDATA	(ABS,OVR,DSEG,BANK=DATA)
                             12 	.area	ACQBUFR		(ABS,OVR,DSEG,BANK=DATA)
                             13 	.area	ACQVARBL	(ABS,OVR,DSEG,BANK=DATA)
                             14 
                             15 	; data areas
                             16 
                             17 	.area	WORKPG		(REL,CON,DSEG,BANK=DATA)
                             18 	.area	BUFSAV		(REL,CON,DSEG,BANK=DATA)
                             19 	.area	ACQDATA		(REL,CON,DSEG,BANK=DATA)
                             20 
                             21 	; program areas
                             22 
                             23 	.area	PGMSAV		(REL,CON,CSEG,BANK=CODE)
                             24 	.area	ACIA		(REL,CON,CSEG,BANK=CODE)
                             25 	.area	ACQ		(REL,CON,CSEG,BANK=CODE)
                             26 	.area	HVCTRL		(REL,CON,CSEG,BANK=CODE)
                             27 	.area	TERMIO		(REL,CON,CSEG,BANK=CODE)
                             28 	.area	SELECT		(REL,CON,CSEG,BANK=CODE)
                             29 	.area	SCREEN		(REL,CON,CSEG,BANK=CODE)
                             30 	.area	SCRNUPDT	(REL,CON,CSEG,BANK=CODE)
                             31 	.area	AICONV		(REL,CON,CSEG,BANK=CODE)
                             32 	.area	MONDEB		(REL,CON,CSEG,BANK=CODE)
                             33 	.area	IRQVEC		(REL,CON,CSEG,BANK=CODE)
                             34 
                             35 	.area	OPTFUN		(ABS,OVR,CSEG,BANK=OPTN)
                             36 
                             37 
                             38 	.sbttl	Default Direct Page
                             39 
                             40 	.setdp	0,PORTDATA
                             41 
ASxxxx Assembler V05.06+  (Motorola 6809)                               Page 3
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Default Direct Page

                              7 	.include	/define.def/
                              1 	.title	PHS Constant definitions
                              2 
                              3 
                              4 	.sbttl	VT1xx screen definitions
                              5 
                              6 	.radix	d
                              7 
                              8 ;
                              9 ;	VT1xx screen definitions
                             10 ;
                             11 
                     0050    12 	SCRNW	==	80		; screen width
                             13 
                     0000    14 	SCRNTP	==	 0		; ypos for top    line of edit area
                     0017    15 	SCRNBT	==	23		; ypos for bottom line of edit area
                     0000    16 	STATUS	==	 0		; ypos for status/command-input line
                             17 
                     0018    18 	SCRNL	==	24		; screen length
                             19 
                             20 
                             21 ; ----------------------------------------------------------
                             22 ; Definitions for various parameters
                             23 
                     FFFF    24 	ERR	==	(-1)
                     FFFE    25 	END	==	(-2)
                             26 
                     0000    27 	EOS	==	0
                     0001    28 	OK	==	1
                             29 
                     0000    30 	NO	==	0
                     0001    31 	YES	==	1
                             32 
                             33 ; ----------------------------------------------------------
                             34 ; Definitions for the Keypad
                             35 
                             36 			; zero not allowed
                     FFFF    37 	SELECT	==	 (-1)
                     FFFE    38 	CUT	==	 (-2)
                     FFFD    39 	APPEND	==	 (-3)
                     FFFC    40 	FNDNXT	==	 (-4)
                     FFFB    41 	GOLD	==	 (-5)
                     FFFA    42 	HELP	==	 (-6)
                     FFF9    43 	ENTER	==	 (-7)
                     0008    44 	SCRLL	==	   8	; backspace = 8
                     0009    45 	TAB	==	   9	; horizontal tab = 9
                     000A    46 	LF	==	  10	; linefeed = 10
                     000B    47 	SCRLU	==	  11	; vertical tab = 11
                     000C    48 	FF	==	  12	; formfeed = 12
                     000D    49 	CR	==	  13	; carriage return = 13
                     FFF2    50 	CHAR	==	(-14)
                     FFF1    51 	WORD	==	(-15)
                     FFF0    52 	LINE	==	(-16)
                     FFEF    53 	DELC	==	(-17)
                     FFEE    54 	DELW	==	(-18)
ASxxxx Assembler V05.06+  (Motorola 6809)                               Page 4
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
VT1xx screen definitions

                     FFED    55 	DELL	==	(-19)
                     FFEC    56 	EOL	==	(-20)
                     0015    57 	CTRLU	==	  21	; ^U
                     FFEA    58 	ADVANCE	==	(-22)
                     0017    59 	CTRLW	==	  23	; ^W
                     FFE8    60 	SECTION	==	(-24)
                     FFE7    61 	PAGE	==	(-25)
                     001A    62 	CTRLZ	==	  26	; ^Z
                     001B    63 	ESCAPE	==	  27	; esc character
                     FFE4    64 	SCRLD	==	(-28)
                     FFE3    65 	SCRLR	==	(-29)
                     FFE2    66 	BACKUP	==	(-30)
                     FFE1    67 	ERROR	==	(-31)
                             68 				; characters 32-126 are valid
                     007F    69 	DELETE	==	 127	; delete to left of cursor
                     007F    70 	CRLF	==	0x7F	; internal line termination
                     0080    71 	REVERSE	==	0x80	; internal reverse video bit
                     0000    72 	NORMAL	==	0x00	; internal normal  video
                             73 
                             74 ; ----------------------------------------------------------
                             75 
                             76 	; VT1xx keypad definitions
                             77 	;
                             78 	;	(ESC O l)	--> (DELC)
                             79 	;	(ESC O m)	--> (DELW)
                             80 	;	(ESC O n)	--> (SELECT)
                             81 	;	(ESC O p)	--> (LINE)
                             82 	;	(ESC O q)	--> (WORD)
                             83 	;	(ESC O r)	--> (EOL)
                             84 	;	(ESC O s)	--> (CHAR)
                             85 	;	(ESC O t)	--> (ADVANCE)
                             86 	;	(ESC O u)	--> (BACKUP)
                             87 	;	(ESC O v)	--> (CUT)
                             88 	;	(ESC O w)	--> (PAGE)
                             89 	;	(ESC O x)	--> (SECTION)
                             90 	;	(ESC O y)	--> (APPEND)
                             91 	;	(ESC O M)	--> (ENTER)
                             92 	;	(ESC O P)	--> (GOLD)
                             93 	;	(ESC O Q)	--> (HELP)
                             94 	;	(ESC O R)	--> (FNDNXT)
                             95 	;	(ESC O S)	--> (DELL)
                             96 	;	(ESC O other)	--> (ERROR)
                             97 	;
                             98 	;	(GOLD)(DELC)	--> (UNDEL C)
                             99 	;	(GOLD)(DELW)	--> (UNDEL W)
                            100 	;	(GOLD)(SELECT)	--> (RESET)
                            101 	;	(GOLD)(LINE)	--> (OPENLINE)
                            102 	;	(GOLD)(WORD)	--> (CHNGCASE)
                            103 	;	(GOLD)(EOL)	--> (DEL EOL)
                            104 	;	(GOLD)(CHAR)	--> (BOTTOM)
                            105 	;	(GOLD)(BACKUP)	--> (TOP)
                            106 	;	(GOLD)(CUT)	--> (PASTE)
                            107 	;	(GOLD)(PAGE)	--> (COMMAND)
                            108 	;	(GOLD)(SECTION)	--> (MOVE CURSOR)
                            109 	;	(GOLD)(APPEND)	--> (REPLACE)
ASxxxx Assembler V05.06+  (Motorola 6809)                               Page 5
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
VT1xx screen definitions

                            110 	;	(GOLD)(ENTER)	--> (SUBS)
                            111 	;	(GOLD)(GOLD)	--> (GOLD)
                            112 	;	(GOLD)(HELP)	--> (HELP)
                            113 	;	(GOLD)(FNDNXT)	--> (FIND)
                            114 	;	(GOLD)(DELL)	--> (UNDEL L)
                            115 	;
                            116 	;	(ESC [ A)	--> (SCRLU)
                            117 	;	(ESC [ B)	--> (SCRLD)
                            118 	;	(ESC [ C)	--> (SCRLL)
                            119 	;	(ESC [ D)	--> (SCRLR)
                            120 	;	(ESC [ other)	--> (ERROR)
                            121 
                            122 
                            123 	.sbttl	Acquisition Definitions
                            124 
                     0000   125 	$STOP	==	0b00000000	; acq$sts bits
                     0001   126 	$SCAN	==	0b00000001
                     0002   127 	$FAILED	==	0b00000010
                     0004   128 	$HOLD	==	0b00000100
                     0008   129 	$ACTIVE	==	0b00001000
                            130 
                     0003   131 	$OFF	==	0b00000011	; LED control bits
                     0000   132 	$YELLOW	==	0b00000000
                     0003   133 	$YFLASH	==	0b00000011
                     0001   134 	$RED	==	0b00000001
                     0002   135 	$RFLASH	==	0b00000010
                     0002   136 	$GREEN	==	0b00000010
                     0001   137 	$GFLASH	==	0b00000001
                            138 
                            139 	.sbttl	HV-Status
                            140 
                     0000   141 	$HVQMRK	==	0		; unknown state
                     0001   142 	$HVOFF	==	1
                     0002   143 	$HVON	==	2
                     0003   144 	$HVZERO	==	3
                     0004   145 	$HVFAIL	==	4
                            146 
                            147 	.sbttl	HV-Queue Functions
                            148 
                     0001   149 	M16F	==	1		; HV-Off
                     0002   150 	M16N	==	2		; HV-On
                     0003   151 	M16S	==	3		; HV-Status
                     0004   152 	M16D	==	4		; Demand Voltages
                     0005   153 	M16V	==	5		; Voltage Readings
                     0006   154 	M16CxxG	==	6		; Get Channel Voltage
                     0007   155 	M16CxxS	==	7		; Set Channel Voltage
                     0008   156 	M16CxxZ	==	8		; Zero Channel
                     0009   157 	M16CxxR	==	9		; Restore Channel
                     000A   158 	M16UPDT	==	10		; Update Sequence
                     000B   159 	M16WAIT	==	11		; 5 Second Wait
                            160 
                            161 
ASxxxx Assembler V05.06+  (Motorola 6809)                               Page 6
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
HV-Queue Functions

                              8 
                              9 	.area	SCREEN
                             10 
                             11 	.sbttl	P.H.S. Status Screen
                             12 
   A526                      13 sph$scrn::
   A526 34 36         [ 9]   14 	pshs	d,x,y
                             15 
   A528 D6 47         [ 4]   16 1$:	ldb	*s$state	; check state
   A52A 27 14         [ 3]   17 	beq	3$
   A52C 96 2F         [ 4]   18 	lda	*char
   A52E 81 17         [ 2]   19 	cmpa	#CTRLW		; redraw screen ?
   A530 26 06         [ 3]   20 	bne	2$
   A532 6F E4         [ 6]   21 	clr	,s		; CTRLW seen
   A534 C6 01         [ 2]   22 	ldb	#1
   A536 D7 47         [ 4]   23 	stb	*s$state	; new state
   A538 58            [ 2]   24 2$:	aslb
   A539 C1 08         [ 2]   25 	cmpb	#5$-4$		; check for valid state
   A53B 25 03         [ 3]   26 	blo	3$
   A53D 5F            [ 2]   27 	clrb
   A53E D7 47         [ 4]   28 	stb	*s$state
   A540 8E A5 45      [ 3]   29 3$:	ldx	#4$
   A543 6E 95         [ 7]   30 	jmp	[b,x]
                             31 
   A545 A5 4D A5 57 A5 7F    32 4$:	.word	5$,6$,9$,10$
        A5 89
                             33 
   A54D FC A6 F2      [ 6]   34 5$:	ldd	r$sph1		; default option position
   A550 BD A3 DD      [ 8]   35 	jsr	init$opt
   A553 DD 45         [ 5]   36 	std	*scrn$pos
   A555 0C 47         [ 6]   37 	inc	*s$state	; next state
                             38 
   A557 BD A3 AF      [ 8]   39 6$:	jsr	clr$scrn	; clear the screen
   A55A BD A5 B1      [ 8]   40 	jsr	sph$page	; draw the axis
                             41 
   A55D 0D 48         [ 6]   42 	tst	*o$state	; active options sequence ?
   A55F 27 1C         [ 3]   43 	beq	8$		; no - skip
   A561 86 F9         [ 2]   44 	lda	#ENTER		; redo question
   A563 BD A7 09      [ 8]   45 	jsr	sph$ques
   A566 0D 59         [ 6]   46 	tst	*s$strlen	; answer ?
   A568 27 13         [ 3]   47 	beq	8$		; no - skip
   A56A DC 45         [ 5]   48 	ldd	*scrn$pos	; cursor position
   A56C BD 9D 5E      [ 8]   49 	jsr	fmtindex
   A56F 30 C9 00 49   [ 8]   50 	leax	s$string,u	; answer string
   A573 A6 80         [ 6]   51 7$:	lda	,x+		; copy string
   A575 2F 06         [ 3]   52 	ble	8$
   A577 A7 A0         [ 6]   53 	sta	,y+
   A579 0C 46         [ 6]   54 	inc	*scrn$pos+1	; update cursor position
   A57B 20 F6         [ 3]   55 	bra	7$
                             56 
   A57D 0C 47         [ 6]   57 8$:	inc	*s$state	; next state
                             58 
   A57F BD A6 B4      [ 8]   59 9$:	jsr	sph$lgnd	; load up legends
   A582 DC 45         [ 5]   60 	ldd	*scrn$pos	; reload cursor position
   A584 BD A3 CA      [ 8]   61 	jsr	pos$scrn
ASxxxx Assembler V05.06+  (Motorola 6809)                               Page 7
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
P.H.S. Status Screen

   A587 0C 47         [ 6]   62 	inc	*s$state	; next state
                             63 
   A589 0D 48         [ 6]   64 10$:	tst	*o$state	; processing an option ?
   A58B 27 13         [ 3]   65 	beq	11$		; no  - skip
                             66 
   A58D 96 2F         [ 4]   67 	lda	*char		; get the character
   A58F BD A7 74      [ 8]   68 	jsr	sph$optn	; yes - service the option
   A592 97 2F         [ 4]   69 	sta	*char		; character used
                             70 
   A594 0D 47         [ 6]   71 	tst	*s$state	; exit screen ?
   A596 27 16         [ 3]   72 	beq	12$		; yes - doit
                             73 
   A598 0D 48         [ 6]   74 	tst	*o$state	; processing finished ?
   A59A 10 27 FF 8A   [ 6]   75 	lbeq	1$		; yes - rescan new settup
   A59E 20 0E         [ 3]   76 	bra	12$
                             77 
   A5A0 96 2F         [ 4]   78 11$:	lda	*char
   A5A2 BD A4 81      [ 8]   79 	jsr	scn$scrl	; try scrolling to a new option
   A5A5 97 2F         [ 4]   80 	sta	*char
   A5A7 27 05         [ 3]   81 	beq	12$
   A5A9 BD A7 09      [ 8]   82 	jsr	sph$ques	; try selecting an option
   A5AC 97 2F         [ 4]   83 	sta	*char
                             84 
   A5AE 35 36         [ 9]   85 12$:	puls	d,x,y
   A5B0 39            [ 5]   86 	rts
                             87 
                             88 
                             89 	; sph$scrn  Page Outline
                             90 
   A5B1                      91 sph$page::
   A5B1 10 8E A5 E1   [ 4]   92 	ldy	#5$
   A5B5 EC A1         [ 8]   93 1$:	ldd	,y++
   A5B7 AE A1         [ 8]   94 	ldx	,y++
   A5B9 27 05         [ 3]   95 	beq	2$
   A5BB BD 9D 9A      [ 8]   96 	jsr	fmthtxt
   A5BE 20 F5         [ 3]   97 	bra	1$
                             98 
                             99 	; fill in unit number
                            100 
   A5C0 DC 74         [ 5]  101 2$:	ldd	*fmtrow		; last entry
   A5C2 BD A5 0A      [ 8]  102 	jsr	scn$unit
                            103 
                            104 	; fill in channel numbers
                            105 
   A5C5 86 07         [ 2]  106 	lda	#SCRNTP+0d7
   A5C7 C6 00         [ 2]  107 	ldb	#$CHNL
   A5C9 8E 00 00      [ 3]  108 	ldx	#0d0		; first channel
                            109 
   A5CC BD 9E 50      [ 8]  110 3$:	jsr	fmt4rjint	; load channel
   A5CF 4C            [ 2]  111 	inca			; next row
   A5D0 30 01         [ 5]  112 	leax	1,x		; next channel
   A5D2 8C 00 10      [ 4]  113 	cmpx	#0d16
   A5D5 26 04         [ 3]  114 	bne	4$
   A5D7 86 07         [ 2]  115 	lda	#SCRNTP+0d7
   A5D9 C6 28         [ 2]  116 	ldb	#$CHNL+0d40
ASxxxx Assembler V05.06+  (Motorola 6809)                               Page 8
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
P.H.S. Status Screen

   A5DB 8C 00 20      [ 4]  117 4$:	cmpx	#0d32
   A5DE 26 EC         [ 3]  118 	bne	3$
                            119 
   A5E0 39            [ 5]  120 	rts
                            121 
                            122 
   A5E1 04 00               123 5$:	.byte	SCRNTP+4,	0
   A5E3 A6 05               124 	.word	6$
   A5E5 05 00               125 	.byte	SCRNTP+5,	0
   A5E7 A6 2E               126 	.word	7$
   A5E9 06 00               127 	.byte	SCRNTP+6,	0
   A5EB A6 57               128 	.word	8$
   A5ED 04 28               129 	.byte	SCRNTP+4,	0d40
   A5EF A6 05               130 	.word	6$
   A5F1 05 28               131 	.byte	SCRNTP+5,	0d40
   A5F3 A6 2E               132 	.word	7$
   A5F5 06 28               133 	.byte	SCRNTP+6,	0d40
   A5F7 A6 57               134 	.word	8$
                     00D3   135 n$spht	= .
   A5F9 02 29               136 	.byte	SCRNTP+2,	0d41
   A5FB A6 A1               137 	.word	10$
   A5FD 00 29               138 	.byte	SCRNTP+0,	0d41		; must be last
   A5FF A6 80               139 	.word	9$
   A601 00 00               140 	.byte	0,		0		; end of list
   A603 00 00               141 	.word	0
                            142 
                            143 	;	 0123456789012345678901234567890123456789"
   A605 20 20 20 20 20 20   144 6$:	.asciz	"              UPDATING  CALIBRATION     "
        20 20 20 20 20 20
        20 20 55 50 44 41
        54 49 4E 47 20 20
        43 41 4C 49 42 52
        41 54 49 4F 4E 20
        20 20 20 20 00
   A62E 20 43 48 4E 4C 20   145 7$:	.asciz	" CHNL PHS-STS PEAK LDRV PEAK LDRV TEMP  "
        50 48 53 2D 53 54
        53 20 50 45 41 4B
        20 4C 44 52 56 20
        50 45 41 4B 20 4C
        44 52 56 20 54 45
        4D 50 20 20 00
   A657 20 2D 2D 2D 2D 20   146 8$:	.asciz	" ---- ------- ---- ---- ---- ---- ----  "
        2D 2D 2D 2D 2D 2D
        2D 20 2D 2D 2D 2D
        20 2D 2D 2D 2D 20
        2D 2D 2D 2D 20 2D
        2D 2D 2D 20 2D 2D
        2D 2D 20 20 00
                            147 
   A680 50 2E 48 2E 53 2E   148 9$:	.asciz	"P.H.S. System Status     Unit # "
        20 53 79 73 74 65
        6D 20 53 74 61 74
        75 73 20 20 20 20
        20 55 6E 69 74 20
        23 20 00
ASxxxx Assembler V05.06+  (Motorola 6809)                               Page 9
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
P.H.S. Status Screen

   A6A1 54 65 6D 70 65 72   149 10$:	.asciz	"Temperature ADC = "
        61 74 75 72 65 20
        41 44 43 20 3D 20
        00
                            150 
                     0000   151 	$CHNL		=	0d0
                     0007   152 	$PHSSTS		=	0d7
                     000E   153 	$UPDTPEAK	=	0d14
                     0013   154 	$UPDTLDRV	=	0d19
                     0018   155 	$CALPEAK	=	0d24
                     001D   156 	$CALLDRV	=	0d29
                     0022   157 	$CALTEMP	=	0d34
                     0012   158 	$TMPPOS		=	0d18
                            159 
                            160 
                            161 	;
                            162 	; sph$scrn Legends
                            163 	;
                            164 
   A6B4                     165 sph$lgnd::
   A6B4 34 36         [ 9]  166 	pshs	d,x,y
   A6B6 32 7D         [ 5]  167 	leas	-3,s
                            168 
   A6B8 8E A6 EE      [ 3]  169 	ldx	#6$
                            170 
   A6BB AF 61         [ 6]  171 1$:	stx	1,s
   A6BD AE 84         [ 5]  172 	ldx	,x		; next entry
   A6BF 27 28         [ 3]  173 	beq	5$		; finished
   A6C1 EC 81         [ 8]  174 	ldd	,x++		; row/column
   A6C3 BD 9D 5E      [ 8]  175 	jsr	fmtindex
   A6C6 E6 80         [ 6]  176 	ldb	,x+		; video mode
   A6C8 E7 E4         [ 4]  177 	stb	,s
   A6CA E6 80         [ 6]  178 	ldb	,x+		; option
   A6CC AE 81         [ 8]  179 	ldx	,x++		; get string address
                            180 
   A6CE A6 80         [ 6]  181 2$:	lda	,x+		; get string character
   A6D0 27 06         [ 3]  182 	beq	3$
   A6D2 AA E4         [ 4]  183 	ora	,s		; set NORMAL/REVERSE video
   A6D4 A7 A0         [ 6]  184 	sta	,y+		; place in buffer
   A6D6 20 F6         [ 3]  185 	bra	2$
                            186 
   A6D8 10 9F 76            187 3$:	sty	*findex		; save position
   A6DB 31 C9 00 5A   [ 8]  188 	leay	optarray,u	; save option number
   A6DF 96 74         [ 4]  189 	lda	*fmtrow
   A6E1 E7 A6         [ 5]  190 	stb	a,y
   A6E3 AE 61         [ 6]  191 4$:	ldx	1,s
   A6E5 30 02         [ 5]  192 	leax	2,x		; next entry
   A6E7 20 D2         [ 3]  193 	bra	1$
                            194 
   A6E9 32 63         [ 5]  195 5$:	leas	3,s
   A6EB 35 36         [ 9]  196 	puls	d,x,y
   A6ED 39            [ 5]  197 	rts
                            198 
                            199 
   A6EE A6 F2 00 00         200 6$:	.word	r$sph1,	0
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 10
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
P.H.S. Status Screen

                            201 
                            202 	;	row		column		video		option
                            203 	;-------------------------------------------------------------
   A6F2 00 03 80 01         204 r$sph1:	.byte	SCRNTP+0d0,	3,		REVERSE,	1
   A6F6 A6 F8               205 	.word	1$		; "Exit"
                            206 
                            207 
   A6F8 20 20 45 78 69 74   208 1$:	.asciz	"  Exit Screen   "		; 1
        20 53 63 72 65 65
        6E 20 20 20 00
                            209 
                            210 
                            211 
                            212 	;
                            213 	; sph$scrn Questions
                            214 	;
                            215 
   A709                     216 sph$ques::
   A709 81 F9         [ 2]  217 	cmpa	#ENTER		; selecting ?
   A70B 26 37         [ 3]  218 	bne	5$		; no - exit
                            219 
   A70D 34 34         [ 8]  220 	pshs	b,x,y
                            221 
   A70F 86 17         [ 2]  222 	lda	#SCRNBT		; common question position
   A711 C6 00         [ 2]  223 	ldb	#0
   A713 BD 9D 5E      [ 8]  224 	jsr	fmtindex
                            225 
   A716 30 C9 00 5A   [ 8]  226 	leax	optarray,u	; get option
   A71A D6 72         [ 4]  227 	ldb	*opt$posn
   A71C E6 85         [ 5]  228 	ldb	b,x
                            229 
   A71E C1 01         [ 2]  230 	cmpb	#1		; exiting this screen ?
   A720 26 02         [ 3]  231 	bne	1$		; no - skip
   A722 0F 47         [ 6]  232 	clr	*s$state	; yes
                            233 
   A724 58            [ 2]  234 1$:	aslb
   A725 C1 04         [ 2]  235 	cmpb	#7$-6$		; valid option ?
   A727 24 18         [ 3]  236 	bhis	4$		; no - exit
   A729 8E A7 45      [ 3]  237 	ldx	#6$
   A72C 30 95         [ 8]  238 	leax	[b,x]
   A72E A6 80         [ 6]  239 2$:	lda	,x+
   A730 27 06         [ 3]  240 	beq	3$
   A732 A7 A0         [ 6]  241 	sta	,y+
   A734 0C 75         [ 6]  242 	inc	*fmtcol		; next column
   A736 20 F6         [ 3]  243 	bra	2$
                            244 
   A738 DC 74         [ 5]  245 3$:	ldd	*fmtrow		; load new cursor position
   A73A BD A3 CA      [ 8]  246 	jsr	pos$scrn
   A73D 86 01         [ 2]  247 	lda	#1		; option processing
   A73F 97 48         [ 4]  248 	sta	*o$state
   A741 4F            [ 2]  249 4$:	clra			; dump character
   A742 35 34         [ 8]  250 	puls	b,x,y
   A744 39            [ 5]  251 5$:	rts
                            252 
                            253 
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 11
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
P.H.S. Status Screen

   A745 A7 49 A7 58         254 6$:	.word	7$,8$
                            255 
   A749 49 6E 76 61 6C 69   256 7$:	.asciz	"Invalid Option"
        64 20 4F 70 74 69
        6F 6E 00
   A758 2E 2E 2E 20 45 78   257 8$:	.asciz	"... Exiting this Screen ..."			; 1
        69 74 69 6E 67 20
        74 68 69 73 20 53
        63 72 65 65 6E 20
        2E 2E 2E 00
                            258 
                            259 	;
                            260 	; sph$scrn Options
                            261 	;
                            262 
   A774                     263 sph$optn::
   A774 BD A4 0E      [ 8]  264 	jsr	scn$gets	; build a response string
   A777 27 33         [ 3]  265 	beq	3$		; not finished
   A779 0D 49         [ 6]  266 	tst	*s$string	; NULL string ?
   A77B 2F 21         [ 3]  267 	ble	2$		; yes - terminate option
                            268 
   A77D BD A3 F8      [ 8]  269 	jsr	option		; get the option number
   A780 58            [ 2]  270 	aslb
   A781 C1 04         [ 2]  271 	cmpb	#5$-4$		; valid option ?
   A783 24 19         [ 3]  272 	bhis	2$		; no - terminate request
                            273 
   A785 10 8E A7 9E   [ 4]  274 	ldy	#2$		; options return address
   A789 34 20         [ 6]  275 	pshs	y
                            276 
   A78B 10 8E A7 AE   [ 4]  277 	ldy	#4$		; jump table
   A78F 31 B5         [ 8]  278 	leay	[b,y]		; get address of option routine
   A791 34 20         [ 6]  279 	pshs	y		; push as a return address
                            280 
   A793 30 C9 00 49   [ 8]  281 	leax	s$string,u	; string pointer
                            282 
   A797 10 8E 8C 16   [ 4]  283 	ldy	#acqvtbl	; variables address for this channel
   A79B 31 B6         [ 8]  284 	leay	[a,y]
                            285 
   A79D 39            [ 5]  286 1$:	rts			; do option
                            287 
   A79E 0F 48         [ 6]  288 2$:	clr	*o$state	; option completed
   A7A0 86 17         [ 2]  289 	lda	#SCRNBT
   A7A2 C6 00         [ 2]  290 	ldb	#0
   A7A4 BD 9D 75      [ 8]  291 	jsr	fmtdeol		; clear option question and answer
                            292 
   A7A7 DC 72         [ 5]  293 	ldd	*opt$posn	; option position
   A7A9 BD A3 CA      [ 8]  294 	jsr	pos$scrn	; restore cursor
                            295 
   A7AC 4F            [ 2]  296 3$:	clra			; input character always used
   A7AD 39            [ 5]  297 	rts
                            298 
   A7AE A7 9D               299 4$:	.word	1$		; invalid option
   A7B0 A7 B2               300 	.word	5$		; exit screen
                            301 
                            302 	; Exit Screen
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 12
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
P.H.S. Status Screen

                            303 
   A7B2 BD A4 05      [ 8]  304 5$:	jsr	ans$yes
   A7B5 26 02         [ 3]  305 	bne	6$
   A7B7 0F 47         [ 6]  306 	clr	*s$state	; just exit
   A7B9 39            [ 5]  307 6$:	rts
                            308 
                            309 
                            310 	; sph$scrn  Update Routine
                            311 
                            312 	.area	SCRNUPDT
                            313 
   D6B9                     314 sph$updt::
                            315 
                            316 	; Temperature ADC Data
                            317 
   D6B9 10 8E 7D C1   [ 4]  318 	ldy	#tmpvar
                            319 
   D6BD FC A5 F9      [ 6]  320 	ldd	n$spht		; get entry
   D6C0 CB 12         [ 2]  321 	addb	#$TMPPOS	; position
                            322 
   D6C2 6D A9 00 11   [10]  323 	tst	tmp$flag,y
   D6C6 27 09         [ 3]  324 	beq	1$
                            325 
   D6C8 AE A9 00 04   [ 9]  326 	ldx	phs$avrg,y	; get last scan
   D6CC BD 9E 50      [ 8]  327 	jsr	fmt4rjint
   D6CF 20 06         [ 3]  328 	bra	2$
                            329 
   D6D1 8E D8 71      [ 3]  330 1$:	ldx	#27$		; inactive
   D6D4 BD 9D 9A      [ 8]  331 	jsr	fmthtxt
                            332 
                            333 	; fill in acquisition status
                            334 
   D6D7 10 8E 77 41   [ 4]  335 2$:	ldy	#acqvar		; acquisition variables
   D6DB 86 07         [ 2]  336 	lda	#SCRNTP+0d7	; screen position
   D6DD C6 07         [ 2]  337 	ldb	#$PHSSTS
                            338 
   D6DF 34 06         [ 7]  339 3$:	pshs	d
   D6E1 A6 A9 00 03   [ 8]  340 	lda	acq$sts,y
   D6E5 84 0F         [ 2]  341 	anda	#0x0F		; just acq status
   D6E7 48            [ 2]  342 	asla
   D6E8 8E D8 51      [ 3]  343 	ldx	#26$
   D6EB 30 96         [ 8]  344 	leax	[a,x]
   D6ED EC E4         [ 5]  345 	ldd	,s
   D6EF BD 9D 9A      [ 8]  346 	jsr	fmthtxt
   D6F2 35 06         [ 7]  347 	puls	d
                            348 
   D6F4 31 A9 00 2C   [ 8]  349 	leay	ACQVARSZ,y	; next channel
   D6F8 4C            [ 2]  350 	inca			; next row
   D6F9 81 17         [ 2]  351 	cmpa	#SCRNTP+0d7+0d16
   D6FB 26 E2         [ 3]  352 	bne	3$
   D6FD 86 07         [ 2]  353 	lda	#SCRNTP+0d7
   D6FF C1 2F         [ 2]  354 	cmpb	#$PHSSTS+0d40
   D701 27 04         [ 3]  355 	beq	4$
   D703 C6 2F         [ 2]  356 	ldb	#$PHSSTS+0d40
   D705 20 D8         [ 3]  357 	bra	3$
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 13
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
P.H.S. Status Screen

                            358 
                            359 	; fill in current PHS value
                            360 
   D707 10 8E 77 41   [ 4]  361 4$:	ldy	#acqvar		; acquisition variables
   D70B 86 07         [ 2]  362 	lda	#SCRNTP+0d7	; screen position
   D70D C6 0E         [ 2]  363 	ldb	#$UPDTPEAK
                            364 
   D70F 34 06         [ 7]  365 5$:	pshs	d
   D711 A6 A9 00 03   [ 8]  366 	lda	acq$sts,y
   D715 84 0F         [ 2]  367 	anda	#0x0F
   D717 27 0B         [ 3]  368 	beq	6$
                            369 
   D719 AE A9 00 04   [ 9]  370 	ldx	phs$avrg,y	; last PHS scan
   D71D EC E4         [ 5]  371 	ldd	,s
   D71F BD 9E 50      [ 8]  372 	jsr	fmt4rjint
   D722 20 08         [ 3]  373 	bra	7$
                            374 
   D724 8E D8 71      [ 3]  375 6$:	ldx	#27$		; inactive
   D727 EC E4         [ 5]  376 	ldd	,s
   D729 BD 9D 9A      [ 8]  377 	jsr	fmthtxt
   D72C 35 06         [ 7]  378 7$:	puls	d
                            379 
   D72E 30 89 02 00   [ 8]  380 	leax	ACQBUFSZ,x	; next channel
   D732 31 A9 00 2C   [ 8]  381 	leay	ACQVARSZ,y
   D736 4C            [ 2]  382 	inca			; next row
   D737 81 17         [ 2]  383 	cmpa	#SCRNTP+0d7+0d16
   D739 26 D4         [ 3]  384 	bne	5$
   D73B 86 07         [ 2]  385 	lda	#SCRNTP+0d7
   D73D C1 36         [ 2]  386 	cmpb	#$UPDTPEAK+0d40
   D73F 27 04         [ 3]  387 	beq	8$
   D741 C6 36         [ 2]  388 	ldb	#$UPDTPEAK+0d40
   D743 20 CA         [ 3]  389 	bra	5$
                            390 
                            391 	; fill in current LED drive
                            392 
   D745 10 8E 77 41   [ 4]  393 8$:	ldy	#acqvar		; acquisition variables
   D749 86 07         [ 2]  394 	lda	#SCRNTP+0d7	; screen position
   D74B C6 13         [ 2]  395 	ldb	#$UPDTLDRV
                            396 
   D74D 34 06         [ 7]  397 9$:	pshs	d
   D74F A6 A9 00 03   [ 8]  398 	lda	acq$sts,y
   D753 84 0F         [ 2]  399 	anda	#0x0F
   D755 27 0B         [ 3]  400 	beq	10$
                            401 
   D757 AE A9 00 2A   [ 9]  402 	ldx	cor$lpht,y	; current
   D75B EC E4         [ 5]  403 	ldd	,s
   D75D BD 9E 50      [ 8]  404 	jsr	fmt4rjint
   D760 20 08         [ 3]  405 	bra	11$
                            406 
   D762 8E D8 71      [ 3]  407 10$:	ldx	#27$		; inactive
   D765 EC E4         [ 5]  408 	ldd	,s
   D767 BD 9D 9A      [ 8]  409 	jsr	fmthtxt
   D76A 35 06         [ 7]  410 11$:	puls	d
                            411 
   D76C 30 89 02 00   [ 8]  412 	leax	ACQBUFSZ,x	; next channel
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 14
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
P.H.S. Status Screen

   D770 31 A9 00 2C   [ 8]  413 	leay	ACQVARSZ,y
   D774 4C            [ 2]  414 	inca			; next row
   D775 81 17         [ 2]  415 	cmpa	#SCRNTP+0d7+0d16
   D777 26 D4         [ 3]  416 	bne	9$
   D779 86 07         [ 2]  417 	lda	#SCRNTP+0d7
   D77B C1 3B         [ 2]  418 	cmpb	#$UPDTLDRV+0d40
   D77D 27 04         [ 3]  419 	beq	12$
   D77F C6 3B         [ 2]  420 	ldb	#$UPDTLDRV+0d40
   D781 20 CA         [ 3]  421 	bra	9$
                            422 
                            423 	; fill in PHS Calibration
                            424 
   D783 10 8E 77 41   [ 4]  425 12$:	ldy	#acqvar		; acquisition variables
   D787 86 07         [ 2]  426 	lda	#SCRNTP+0d7	; screen position
   D789 C6 18         [ 2]  427 	ldb	#$CALPEAK
                            428 
   D78B 34 06         [ 7]  429 13$:	pshs	d
   D78D A6 A9 00 03   [ 8]  430 	lda	acq$sts,y
   D791 84 0F         [ 2]  431 	anda	#0x0F
   D793 27 1C         [ 3]  432 	beq	15$
   D795 AE A9 00 24   [ 9]  433 	ldx	phs$lpht,y	; calibration ready ?
   D799 26 0F         [ 3]  434 	bne	14$		; yes - use it
                            435 				; else use updating value
                            436 
                            437 	; divide acq$sum by 64
                            438 
   D79B EC A9 00 00   [ 9]  439 	ldd	acq$sum,y	; get sum
   D79F 59            [ 2]  440 	rolb			; divide by 64
   D7A0 49            [ 2]  441 	rola
   D7A1 59            [ 2]  442 	rolb
   D7A2 49            [ 2]  443 	rola
   D7A3 59            [ 2]  444 	rolb
   D7A4 1E 89         [ 8]  445 	exg	a,b
   D7A6 84 03         [ 2]  446 	anda	#0x03
   D7A8 1F 01         [ 6]  447 	tfr	d,x
   D7AA EC E4         [ 5]  448 14$:	ldd	,s
   D7AC BD 9E 50      [ 8]  449 	jsr	fmt4rjint
   D7AF 20 08         [ 3]  450 	bra	16$
                            451 
   D7B1 8E D8 71      [ 3]  452 15$:	ldx	#27$		; inactive
   D7B4 EC E4         [ 5]  453 	ldd	,s
   D7B6 BD 9D 9A      [ 8]  454 	jsr	fmthtxt
   D7B9 35 06         [ 7]  455 16$:	puls	d
                            456 
   D7BB 31 A9 00 2C   [ 8]  457 	leay	ACQVARSZ,y	; next channel
   D7BF 4C            [ 2]  458 	inca			; next row
   D7C0 81 17         [ 2]  459 	cmpa	#SCRNTP+0d7+0d16
   D7C2 26 C7         [ 3]  460 	bne	13$
   D7C4 86 07         [ 2]  461 	lda	#SCRNTP+0d7
   D7C6 C1 40         [ 2]  462 	cmpb	#$CALPEAK+0d40
   D7C8 27 04         [ 3]  463 	beq	17$
   D7CA C6 40         [ 2]  464 	ldb	#$CALPEAK+0d40
   D7CC 20 BD         [ 3]  465 	bra	13$
                            466 
                            467 	; fill in LED calibration
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 15
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
P.H.S. Status Screen

                            468 
   D7CE 10 8E 77 41   [ 4]  469 17$:	ldy	#acqvar		; acquisition variables
   D7D2 86 07         [ 2]  470 	lda	#SCRNTP+0d7	; screen position
   D7D4 C6 1D         [ 2]  471 	ldb	#$CALLDRV
                            472 
   D7D6 34 06         [ 7]  473 18$:	pshs	d
   D7D8 A6 A9 00 03   [ 8]  474 	lda	acq$sts,y
   D7DC 84 0F         [ 2]  475 	anda	#0x0F
   D7DE 27 0B         [ 3]  476 	beq	19$
                            477 
   D7E0 AE A9 00 26   [ 9]  478 	ldx	cal$lpht,y	; LED calibration
   D7E4 EC E4         [ 5]  479 	ldd	,s
   D7E6 BD 9E 50      [ 8]  480 	jsr	fmt4rjint
   D7E9 20 08         [ 3]  481 	bra	20$
                            482 
   D7EB 8E D8 71      [ 3]  483 19$:	ldx	#27$		; inactive
   D7EE EC E4         [ 5]  484 	ldd	,s
   D7F0 BD 9D 9A      [ 8]  485 	jsr	fmthtxt
   D7F3 35 06         [ 7]  486 20$:	puls	d
                            487 
   D7F5 30 89 02 00   [ 8]  488 	leax	ACQBUFSZ,x	; next channel
   D7F9 31 A9 00 2C   [ 8]  489 	leay	ACQVARSZ,y
   D7FD 4C            [ 2]  490 	inca			; next row
   D7FE 81 17         [ 2]  491 	cmpa	#SCRNTP+0d7+0d16
   D800 26 D4         [ 3]  492 	bne	18$
   D802 86 07         [ 2]  493 	lda	#SCRNTP+0d7
   D804 C1 45         [ 2]  494 	cmpb	#$CALLDRV+0d40
   D806 27 04         [ 3]  495 	beq	21$
   D808 C6 45         [ 2]  496 	ldb	#$CALLDRV+0d40
   D80A 20 CA         [ 3]  497 	bra	18$
                            498 
                            499 	; fill in calibration temperature
                            500 
   D80C 10 8E 77 41   [ 4]  501 21$:	ldy	#acqvar		; acquisition variables
   D810 86 07         [ 2]  502 	lda	#SCRNTP+0d7	; screen position
   D812 C6 22         [ 2]  503 	ldb	#$CALTEMP
                            504 
   D814 34 06         [ 7]  505 22$:	pshs	d
   D816 A6 A9 00 03   [ 8]  506 	lda	acq$sts,y
   D81A 84 0F         [ 2]  507 	anda	#0x0F
   D81C 27 11         [ 3]  508 	beq	23$
                            509 
   D81E 6D A9 00 11   [10]  510 	tst	tmp$flag,y
   D822 27 0B         [ 3]  511 	beq	23$
                            512 
   D824 AE A9 00 28   [ 9]  513 	ldx	tmp$lpht,y	; Temperature calibration
   D828 EC E4         [ 5]  514 	ldd	,s
   D82A BD 9E 50      [ 8]  515 	jsr	fmt4rjint
   D82D 20 08         [ 3]  516 	bra	24$
                            517 
   D82F 8E D8 71      [ 3]  518 23$:	ldx	#27$		; inactive
   D832 EC E4         [ 5]  519 	ldd	,s
   D834 BD 9D 9A      [ 8]  520 	jsr	fmthtxt
   D837 35 06         [ 7]  521 24$:	puls	d
                            522 
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 16
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
P.H.S. Status Screen

   D839 30 89 02 00   [ 8]  523 	leax	ACQBUFSZ,x	; next channel
   D83D 31 A9 00 2C   [ 8]  524 	leay	ACQVARSZ,y
   D841 4C            [ 2]  525 	inca			; next row
   D842 81 17         [ 2]  526 	cmpa	#SCRNTP+0d7+0d16
   D844 26 CE         [ 3]  527 	bne	22$
   D846 86 07         [ 2]  528 	lda	#SCRNTP+0d7
   D848 C1 4A         [ 2]  529 	cmpb	#$CALTEMP+0d40
   D84A 27 04         [ 3]  530 	beq	25$
   D84C C6 4A         [ 2]  531 	ldb	#$CALTEMP+0d40
   D84E 20 C4         [ 3]  532 	bra	22$
                            533 
   D850 39            [ 5]  534 25$:	rts
                            535 
                            536 
                            537 	; Acquisition Status Table
                            538 
                            539 				; 0bxxxxxxxx
                            540 				;	|||`---- $SCAN
                            541 				;	||`----- $FAILED
                            542 				;	|`------ $HOLD
                            543 				;	`------- $ACTIVE
   D851 D8 76               544 26$:	.word	28$		;       0000	inactive
   D853 D8 7D               545 	.word	29$		;	0001	cal
   D855 D8 84               546 	.word	30$		;	0010	failed
   D857 D8 84               547 	.word	30$		;	0011	failed
   D859 D8 8B               548 	.word	31$		;	0100	hold
   D85B D8 8B               549 	.word	31$		;	0101	hold
   D85D D8 84               550 	.word	30$		;	0110	failed
   D85F D8 84               551 	.word	30$		;	0111	failed
   D861 D8 92               552 	.word	32$		;	1000	active
   D863 D8 92               553 	.word	32$		;	1001	active
   D865 D8 84               554 	.word	30$		;	1010	failed
   D867 D8 84               555 	.word	30$		;	1011	failed
   D869 D8 8B               556 	.word	31$		;	1100	hold
   D86B D8 8B               557 	.word	31$		;	1101	hold
   D86D D8 84               558 	.word	30$		;	1110	failed
   D86F D8 84               559 	.word	30$		;	1111	failed
                            560 
                            561 
   D871 20 20 20 20 00      562 27$:	.asciz	"    "		; inactive (data)
   D876 20 20 20 20 20 20   563 28$:	.asciz	"      "	; inactive (ascii)
        00
   D87D 20 20 20 43 61 6C   564 29$:	.asciz	"   Cal"
        00
   D884 20 20 46 61 69 6C   565 30$:	.asciz	"  Fail"
        00
   D88B 20 20 48 6F 6C 64   566 31$:	.asciz	"  Hold"
        00
   D892 41 63 74 69 76 65   567 32$:	.asciz	"Active"
        00
                            568 
                            569 
                            570 	.area	SCREEN
                            571 
                            572 	.sbttl	HV4032A Status Screen
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 17
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
HV4032A Status Screen

                            573 
   A7BA                     574 shv$scrn::
   A7BA 34 36         [ 9]  575 	pshs	d,x,y
                            576 
   A7BC D6 47         [ 4]  577 1$:	ldb	*s$state	; check state
   A7BE 27 14         [ 3]  578 	beq	3$
   A7C0 96 2F         [ 4]  579 	lda	*char
   A7C2 81 17         [ 2]  580 	cmpa	#CTRLW		; redraw screen ?
   A7C4 26 06         [ 3]  581 	bne	2$
   A7C6 6F E4         [ 6]  582 	clr	,s		; CTRLW seen
   A7C8 C6 01         [ 2]  583 	ldb	#1
   A7CA D7 47         [ 4]  584 	stb	*s$state	; new state
   A7CC 58            [ 2]  585 2$:	aslb
   A7CD C1 08         [ 2]  586 	cmpb	#5$-4$		; check for valid state
   A7CF 25 03         [ 3]  587 	blo	3$
   A7D1 5F            [ 2]  588 	clrb
   A7D2 D7 47         [ 4]  589 	stb	*s$state
   A7D4 8E A7 D9      [ 3]  590 3$:	ldx	#4$
   A7D7 6E 95         [ 7]  591 	jmp	[b,x]
                            592 
   A7D9 A7 E1 A7 F2 A8 1A   593 4$:	.word	5$,6$,9$,10$
        A8 24
                            594 
   A7E1 C6 20         [ 2]  595 5$:	ldb	#0d32		; always check HV status
   A7E3 86 03         [ 2]  596 	lda	#M16S
   A7E5 BD 92 FF      [ 8]  597 	jsr	en$que
   A7E8 FC A9 4C      [ 6]  598 	ldd	r$shv1		; default option position
   A7EB BD A3 DD      [ 8]  599 	jsr	init$opt
   A7EE DD 45         [ 5]  600 	std	*scrn$pos
   A7F0 0C 47         [ 6]  601 	inc	*s$state	; next state
                            602 
   A7F2 BD A3 AF      [ 8]  603 6$:	jsr	clr$scrn	; clear the screen
   A7F5 BD A8 4C      [ 8]  604 	jsr	shv$page	; draw the axis
                            605 
   A7F8 0D 48         [ 6]  606 	tst	*o$state	; active options sequence ?
   A7FA 27 1C         [ 3]  607 	beq	8$		; no - skip
   A7FC 86 F9         [ 2]  608 	lda	#ENTER		; redo question
   A7FE BD A9 A8      [ 8]  609 	jsr	shv$ques
   A801 0D 59         [ 6]  610 	tst	*s$strlen	; answer ?
   A803 27 13         [ 3]  611 	beq	8$		; no - skip
   A805 DC 45         [ 5]  612 	ldd	*scrn$pos	; cursor position
   A807 BD 9D 5E      [ 8]  613 	jsr	fmtindex
   A80A 30 C9 00 49   [ 8]  614 	leax	s$string,u	; answer string
   A80E A6 80         [ 6]  615 7$:	lda	,x+		; copy string
   A810 2F 06         [ 3]  616 	ble	8$
   A812 A7 A0         [ 6]  617 	sta	,y+
   A814 0C 46         [ 6]  618 	inc	*scrn$pos+1	; update cursor position
   A816 20 F6         [ 3]  619 	bra	7$
                            620 
   A818 0C 47         [ 6]  621 8$:	inc	*s$state	; next state
                            622 
   A81A BD A9 08      [ 8]  623 9$:	jsr	shv$lgnd	; load up legends
   A81D DC 45         [ 5]  624 	ldd	*scrn$pos	; reload cursor position
   A81F BD A3 CA      [ 8]  625 	jsr	pos$scrn
   A822 0C 47         [ 6]  626 	inc	*s$state	; next state
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 18
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
HV4032A Status Screen

                            627 
   A824 0D 48         [ 6]  628 10$:	tst	*o$state	; processing an option ?
   A826 27 13         [ 3]  629 	beq	11$		; no  - skip
                            630 
   A828 96 2F         [ 4]  631 	lda	*char		; get the character
   A82A BD AA 91      [ 8]  632 	jsr	shv$optn	; yes - service the option
   A82D 97 2F         [ 4]  633 	sta	*char		; character used
                            634 
   A82F 0D 47         [ 6]  635 	tst	*s$state	; exit screen ?
   A831 27 16         [ 3]  636 	beq	12$		; yes - doit
                            637 
   A833 0D 48         [ 6]  638 	tst	*o$state	; processing finished ?
   A835 10 27 FF 83   [ 6]  639 	lbeq	1$		; yes - rescan new settup
   A839 20 0E         [ 3]  640 	bra	12$
                            641 
   A83B 96 2F         [ 4]  642 11$:	lda	*char
   A83D BD A4 81      [ 8]  643 	jsr	scn$scrl	; try scrolling to a new option
   A840 97 2F         [ 4]  644 	sta	*char
   A842 27 05         [ 3]  645 	beq	12$
   A844 BD A9 A8      [ 8]  646 	jsr	shv$ques	; try selecting an option
   A847 97 2F         [ 4]  647 	sta	*char
                            648 
   A849 35 36         [ 9]  649 12$:	puls	d,x,y
   A84B 39            [ 5]  650 	rts
                            651 
                            652 
                            653 	; shv$scrn  Page Outline
                            654 
   A84C                     655 shv$page::
   A84C 10 8E A8 7C   [ 4]  656 	ldy	#5$
   A850 EC A1         [ 8]  657 1$:	ldd	,y++
   A852 AE A1         [ 8]  658 	ldx	,y++
   A854 27 05         [ 3]  659 	beq	2$
   A856 BD 9D 9A      [ 8]  660 	jsr	fmthtxt
   A859 20 F5         [ 3]  661 	bra	1$
                            662 
                            663 	; fill in unit number
                            664 
   A85B DC 74         [ 5]  665 2$:	ldd	*fmtrow		; last entry
   A85D BD A5 0A      [ 8]  666 	jsr	scn$unit
                            667 
                            668 	; fill in channel numbers
                            669 
   A860 86 06         [ 2]  670 	lda	#SCRNTP+6
   A862 C6 00         [ 2]  671 	ldb	#$CHNL
   A864 8E 00 00      [ 3]  672 	ldx	#0d0		; first channel
                            673 
   A867 BD 9E 9F      [ 8]  674 3$:	jsr	fmt6rjint	; load channel
   A86A 4C            [ 2]  675 	inca			; next row
   A86B 30 01         [ 5]  676 	leax	1,x		; next channel
   A86D 8C 00 10      [ 4]  677 	cmpx	#0d16
   A870 26 04         [ 3]  678 	bne	4$
   A872 86 06         [ 2]  679 	lda	#SCRNTP+6
   A874 C6 28         [ 2]  680 	ldb	#$CHNL+0d40
   A876 8C 00 20      [ 4]  681 4$:	cmpx	#0d32
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 19
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
HV4032A Status Screen

   A879 26 EC         [ 3]  682 	bne	3$
                            683 
   A87B 39            [ 5]  684 	rts
                            685 
                            686 
   A87C 04 00               687 5$:	.byte	SCRNTP+4,	0d0
   A87E A8 94               688 	.word	6$
   A880 05 00               689 	.byte	SCRNTP+5,	0d0
   A882 A8 BD               690 	.word	7$
   A884 04 28               691 	.byte	SCRNTP+4,	0d40
   A886 A8 94               692 	.word	6$
   A888 05 28               693 	.byte	SCRNTP+5,	0d40
   A88A A8 BD               694 	.word	7$
                     0366   695 n$shv = .
   A88C 00 2B               696 	.byte	SCRNTP+0,	0d43		; must be last
   A88E A8 E6               697 	.word	8$
   A890 00 00               698 	.byte	0,		0
   A892 00 00               699 	.word	0
                            700 
                            701 	;	 0123456789012345678901234567890123456789"
   A894 20 20 20 43 48 4E   702 6$:	.asciz	"   CHNL  HV-STS  VOLTAGE DEMAND HV-SET  "
        4C 20 20 48 56 2D
        53 54 53 20 20 56
        4F 4C 54 41 47 45
        20 44 45 4D 41 4E
        44 20 48 56 2D 53
        45 54 20 20 00
   A8BD 20 20 20 2D 2D 2D   703 7$:	.asciz	"   ----  ------  ------- ------ ------  "
        2D 20 20 2D 2D 2D
        2D 2D 2D 20 20 2D
        2D 2D 2D 2D 2D 2D
        20 2D 2D 2D 2D 2D
        2D 20 2D 2D 2D 2D
        2D 2D 20 20 00
                            704 
   A8E6 48 56 34 30 33 32   705 8$:	.asciz	"HV4032A System Status     Unit # "
        41 20 53 79 73 74
        65 6D 20 53 74 61
        74 75 73 20 20 20
        20 20 55 6E 69 74
        20 23 20 00
                            706 
                            707 
                     0000   708 	$CHNL		=	0d0
                     0009   709 	$HVSTS		=	0d9
                     0011   710 	$VOLTAGE	=	0d17
                     0018   711 	$DEMAND		=	0d24
                     001F   712 	$HVSET		=	0d31
                            713 
                            714 
                            715 	;
                            716 	; shv$scrn Legends
                            717 	;
                            718 
   A908                     719 shv$lgnd::
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 20
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
HV4032A Status Screen

   A908 34 36         [ 9]  720 	pshs	d,x,y
   A90A 32 7D         [ 5]  721 	leas	-3,s
                            722 
   A90C 8E A9 42      [ 3]  723 	ldx	#6$
                            724 
   A90F AF 61         [ 6]  725 1$:	stx	1,s
   A911 AE 84         [ 5]  726 	ldx	,x		; next entry
   A913 27 28         [ 3]  727 	beq	5$		; finished
   A915 EC 81         [ 8]  728 	ldd	,x++		; row/column
   A917 BD 9D 5E      [ 8]  729 	jsr	fmtindex
   A91A E6 80         [ 6]  730 	ldb	,x+		; video mode
   A91C E7 E4         [ 4]  731 	stb	,s
   A91E E6 80         [ 6]  732 	ldb	,x+		; option
   A920 AE 81         [ 8]  733 	ldx	,x++		; get string address
                            734 
   A922 A6 80         [ 6]  735 2$:	lda	,x+		; get string character
   A924 27 06         [ 3]  736 	beq	3$
   A926 AA E4         [ 4]  737 	ora	,s		; set NORMAL/REVERSE video
   A928 A7 A0         [ 6]  738 	sta	,y+		; place in buffer
   A92A 20 F6         [ 3]  739 	bra	2$
                            740 
   A92C 10 9F 76            741 3$:	sty	*findex		; save position
   A92F 31 C9 00 5A   [ 8]  742 	leay	optarray,u	; save option number
   A933 96 74         [ 4]  743 	lda	*fmtrow
   A935 E7 A6         [ 5]  744 	stb	a,y
   A937 AE 61         [ 6]  745 4$:	ldx	1,s
   A939 30 02         [ 5]  746 	leax	2,x		; next entry
   A93B 20 D2         [ 3]  747 	bra	1$
                            748 
   A93D 32 63         [ 5]  749 5$:	leas	3,s
   A93F 35 36         [ 9]  750 	puls	d,x,y
   A941 39            [ 5]  751 	rts
                            752 
                            753 
   A942 A9 4C A9 52 A9 58   754 6$:	.word	r$shv1,	r$shv2,	r$shv3,	r$shv4,	0
        A9 5E 00 00
                            755 
                            756 	;	row		column		video		option
                            757 	;-------------------------------------------------------------
   A94C                     758 r$shv1:
   A94C 00 03 80 01         759 	.byte	SCRNTP+0d0,	3,		REVERSE,	1
   A950 A9 64               760 	.word	1$		; "Exit"
                     042C   761 r$shv2	= .
   A952 01 03 80 02         762 	.byte	SCRNTP+0d1,	3,		REVERSE,	2
   A956 A9 75               763 	.word	2$		; "Turn Power Off"
                     0432   764 r$shv3	= .
   A958 02 03 80 03         765 	.byte	SCRNTP+0d2,	3,		REVERSE,	3
   A95C A9 86               766 	.word	3$		; "Turn Power On"
                     0438   767 r$shv4	= .
   A95E 03 03 80 04         768 	.byte	SCRNTP+0d3,	3,		REVERSE,	4
   A962 A9 97               769 	.word	4$		; "Read HV4032A"
                            770 
                            771 
   A964 20 20 45 78 69 74   772 1$:	.asciz	"  Exit Screen   "		; 1
        20 53 63 72 65 65
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 21
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
HV4032A Status Screen

        6E 20 20 20 00
   A975 20 54 75 72 6E 20   773 2$:	.asciz	" Turn Power OFF "		; 2
        50 6F 77 65 72 20
        4F 46 46 20 00
   A986 20 54 75 72 6E 20   774 3$:	.asciz	" Turn Power ON  "		; 3
        50 6F 77 65 72 20
        4F 4E 20 20 00
   A997 20 20 52 65 61 64   775 4$:	.asciz	"  Read HV4032A  "		; 4
        20 48 56 34 30 33
        32 41 20 20 00
                            776 
                            777 
                            778 	;
                            779 	; shv$scrn Questions
                            780 	;
                            781 
   A9A8                     782 shv$ques::
   A9A8 81 F9         [ 2]  783 	cmpa	#ENTER		; selecting ?
   A9AA 26 37         [ 3]  784 	bne	5$		; no - exit
                            785 
   A9AC 34 34         [ 8]  786 	pshs	b,x,y
                            787 
   A9AE 86 17         [ 2]  788 	lda	#SCRNBT		; common question position
   A9B0 C6 00         [ 2]  789 	ldb	#0
   A9B2 BD 9D 5E      [ 8]  790 	jsr	fmtindex
                            791 
   A9B5 30 C9 00 5A   [ 8]  792 	leax	optarray,u	; get option
   A9B9 D6 72         [ 4]  793 	ldb	*opt$posn
   A9BB E6 85         [ 5]  794 	ldb	b,x
                            795 
   A9BD C1 01         [ 2]  796 	cmpb	#1		; exiting this screen ?
   A9BF 26 02         [ 3]  797 	bne	1$		; no - skip
   A9C1 0F 47         [ 6]  798 	clr	*s$state	; yes
                            799 
   A9C3 58            [ 2]  800 1$:	aslb
   A9C4 C1 0A         [ 2]  801 	cmpb	#7$-6$		; valid option ?
   A9C6 24 18         [ 3]  802 	bhis	4$		; no - exit
   A9C8 8E A9 E4      [ 3]  803 	ldx	#6$
   A9CB 30 95         [ 8]  804 	leax	[b,x]
   A9CD A6 80         [ 6]  805 2$:	lda	,x+
   A9CF 27 06         [ 3]  806 	beq	3$
   A9D1 A7 A0         [ 6]  807 	sta	,y+
   A9D3 0C 75         [ 6]  808 	inc	*fmtcol		; next column
   A9D5 20 F6         [ 3]  809 	bra	2$
                            810 
   A9D7 DC 74         [ 5]  811 3$:	ldd	*fmtrow		; load new cursor position
   A9D9 BD A3 CA      [ 8]  812 	jsr	pos$scrn
   A9DC 86 01         [ 2]  813 	lda	#1		; option processing
   A9DE 97 48         [ 4]  814 	sta	*o$state
   A9E0 4F            [ 2]  815 4$:	clra			; dump character
   A9E1 35 34         [ 8]  816 	puls	b,x,y
   A9E3 39            [ 5]  817 5$:	rts
                            818 
                            819 
   A9E4 A9 EE A9 FD AA 19   820 6$:	.word	7$,8$,9$,10$,11$
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 22
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
HV4032A Status Screen

        AA 40 AA 66
                            821 
   A9EE 49 6E 76 61 6C 69   822 7$:	.asciz	"Invalid Option"
        64 20 4F 70 74 69
        6F 6E 00
   A9FD 2E 2E 2E 20 45 78   823 8$:	.asciz	"... Exiting this Screen ..."			; 1
        69 74 69 6E 67 20
        74 68 69 73 20 53
        63 72 65 65 6E 20
        2E 2E 2E 00
   AA19 54 75 72 6E 20 48   824 9$:	.asciz	"Turn HV4032A High Voltage OFF (Y/N) ? "	; 2
        56 34 30 33 32 41
        20 48 69 67 68 20
        56 6F 6C 74 61 67
        65 20 4F 46 46 20
        28 59 2F 4E 29 20
        3F 20 00
   AA40 54 75 72 6E 20 48   825 10$:	.asciz	"Turn HV4032A High Voltage ON (Y/N) ? "		; 3
        56 34 30 33 32 41
        20 48 69 67 68 20
        56 6F 6C 74 61 67
        65 20 4F 4E 20 28
        59 2F 4E 29 20 3F
        20 00
   AA66 52 65 61 64 20 41   826 11$:	.asciz	"Read All HV4032A Voltages/Demands (Y/N) ? "	; 4
        6C 6C 20 48 56 34
        30 33 32 41 20 56
        6F 6C 74 61 67 65
        73 2F 44 65 6D 61
        6E 64 73 20 28 59
        2F 4E 29 20 3F 20
        00
                            827 
                            828 	;
                            829 	; shv$scrn Options
                            830 	;
                            831 
   AA91                     832 shv$optn::
   AA91 BD A4 0E      [ 8]  833 	jsr	scn$gets	; build a response string
   AA94 27 33         [ 3]  834 	beq	3$		; not finished
   AA96 0D 49         [ 6]  835 	tst	*s$string	; NULL string ?
   AA98 2F 21         [ 3]  836 	ble	2$		; yes - terminate option
                            837 
   AA9A BD A3 F8      [ 8]  838 	jsr	option		; get the option number
   AA9D 58            [ 2]  839 	aslb
   AA9E C1 0A         [ 2]  840 	cmpb	#5$-4$		; valid option ?
   AAA0 24 19         [ 3]  841 	bhis	2$		; no - terminate request
                            842 
   AAA2 10 8E AA BB   [ 4]  843 	ldy	#2$		; options return address
   AAA6 34 20         [ 6]  844 	pshs	y
                            845 
   AAA8 10 8E AA CB   [ 4]  846 	ldy	#4$		; jump table
   AAAC 31 B5         [ 8]  847 	leay	[b,y]		; get address of option routine
   AAAE 34 20         [ 6]  848 	pshs	y		; push as a return address
                            849 
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 23
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
HV4032A Status Screen

   AAB0 30 C9 00 49   [ 8]  850 	leax	s$string,u	; string pointer
                            851 
   AAB4 10 8E 8C 16   [ 4]  852 	ldy	#acqvtbl	; variables address for this channel
   AAB8 31 B6         [ 8]  853 	leay	[a,y]
                            854 
   AABA 39            [ 5]  855 1$:	rts			; do option
                            856 
   AABB 0F 48         [ 6]  857 2$:	clr	*o$state	; option completed
   AABD 86 17         [ 2]  858 	lda	#SCRNBT
   AABF C6 00         [ 2]  859 	ldb	#0
   AAC1 BD 9D 75      [ 8]  860 	jsr	fmtdeol		; clear option question and answer
                            861 
   AAC4 DC 72         [ 5]  862 	ldd	*opt$posn	; option position
   AAC6 BD A3 CA      [ 8]  863 	jsr	pos$scrn	; restore cursor
                            864 
   AAC9 4F            [ 2]  865 3$:	clra			; input character always used
   AACA 39            [ 5]  866 	rts
                            867 
   AACB AA BA               868 4$:	.word	1$		; invalid option
   AACD AA D5               869 	.word	5$		; exit screen
   AACF AA DD               870 	.word	7$		; turn voltage off
   AAD1 AA E6               871 	.word	8$		; turn voltage on
   AAD3 AB 0D               872 	.word	11$		; read out HV4032A
                            873 
                            874 	; Exit Screen
                            875 
   AAD5 BD A4 05      [ 8]  876 5$:	jsr	ans$yes
   AAD8 26 02         [ 3]  877 	bne	6$
   AADA 0F 47         [ 6]  878 	clr	*s$state	; just exit
   AADC 39            [ 5]  879 6$:	rts
                            880 
                            881 	; Turn Voltage Off
                            882 
   AADD BD A4 05      [ 8]  883 7$:	jsr	ans$yes
   AAE0 26 2A         [ 3]  884 	bne	10$
   AAE2 86 01         [ 2]  885 	lda	#M16F
   AAE4 20 07         [ 3]  886 	bra	9$
                            887 
                            888 	; Turn Voltage On
                            889 
   AAE6 BD A4 05      [ 8]  890 8$:	jsr	ans$yes
   AAE9 26 21         [ 3]  891 	bne	10$
   AAEB 86 02         [ 2]  892 	lda	#M16N
                            893 
   AAED 34 01         [ 6]  894 9$:	pshs	cc
   AAEF 1A 50         [ 3]  895 	orcc	#0q120
   AAF1 C6 20         [ 2]  896 	ldb	#0d32
   AAF3 BD 92 FF      [ 8]  897 	jsr	en$que
   AAF6 86 0B         [ 2]  898 	lda	#M16WAIT
   AAF8 BD 92 FF      [ 8]  899 	jsr	en$que
   AAFB 86 05         [ 2]  900 	lda	#M16V
   AAFD BD 92 FF      [ 8]  901 	jsr	en$que
   AB00 86 04         [ 2]  902 	lda	#M16D
   AB02 BD 92 FF      [ 8]  903 	jsr	en$que
   AB05 86 03         [ 2]  904 	lda	#M16S
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 24
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
HV4032A Status Screen

   AB07 BD 92 FF      [ 8]  905 	jsr	en$que
   AB0A 35 01         [ 6]  906 	puls	cc
   AB0C 39            [ 5]  907 10$:	rts
                            908 
                            909 	; Read Out HV4032A
                            910 
   AB0D BD A4 05      [ 8]  911 11$:	jsr	ans$yes
   AB10 26 12         [ 3]  912 	bne	12$
   AB12 34 01         [ 6]  913 	pshs	cc
   AB14 1A 50         [ 3]  914 	orcc	#0q120
   AB16 C6 20         [ 2]  915 	ldb	#0d32
   AB18 86 05         [ 2]  916 	lda	#M16V
   AB1A BD 92 FF      [ 8]  917 	jsr	en$que
   AB1D 86 04         [ 2]  918 	lda	#M16D
   AB1F BD 92 FF      [ 8]  919 	jsr	en$que
   AB22 35 01         [ 6]  920 	puls	cc
   AB24 39            [ 5]  921 12$:	rts
                            922 
                            923 
                            924 	; shv$scrn  Update Routine
                            925 
                            926 	.area	SCRNUPDT
                            927 
   D899                     928 shv$updt::
                            929 
                            930 	; fill in HV Updating status / failure mode
                            931 
   D899 8E 7D C1      [ 3]  932 	ldx	#tmpvar
   D89C A6 89 00 13   [ 8]  933 	lda	hvc$sts,x	; current status
   D8A0 48            [ 2]  934 	asla
   D8A1 8E 9A 40      [ 3]  935 	ldx	#hvc$optn	; table of pointers
   D8A4 30 96         [ 8]  936 	leax	[a,x]
   D8A6 86 16         [ 2]  937 	lda	#SCRNTP+0d22	; position
   D8A8 5F            [ 2]  938 	clrb
   D8A9 BD 9D 9A      [ 8]  939 	jsr	fmthtxt		; load current status
                            940 
                            941 	; fill in high voltage supply status
                            942 
   D8AC 8E 7D C1      [ 3]  943 	ldx	#tmpvar
   D8AF A6 89 00 12   [ 8]  944 	lda	hv$sts,x	; current status
   D8B3 48            [ 2]  945 	asla
   D8B4 8E D9 9D      [ 3]  946 	ldx	#16$		; table of pointers
   D8B7 30 96         [ 8]  947 	leax	[a,x]
   D8B9 FC A8 8C      [ 6]  948 	ldd	n$shv		; position
   D8BC 8B 02         [ 2]  949 	adda	#0d2
   D8BE BD 9D 9A      [ 8]  950 	jsr	fmthtxt		; load current status
                            951 
                            952 	; fill in high voltage status
                            953 
   D8C1 10 8E 77 41   [ 4]  954 1$:	ldy	#acqvar		; acquisition variables
   D8C5 86 06         [ 2]  955 	lda	#SCRNTP+0d6	; screen position
   D8C7 C6 09         [ 2]  956 	ldb	#$HVSTS
                            957 
   D8C9 34 06         [ 7]  958 2$:	pshs	d
   D8CB A6 A9 00 12   [ 8]  959 	lda	hv$sts,y
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 25
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
HV4032A Status Screen

   D8CF 48            [ 2]  960 	asla
   D8D0 8E D9 70      [ 3]  961 	ldx	#10$
   D8D3 30 96         [ 8]  962 	leax	[a,x]
   D8D5 EC E4         [ 5]  963 	ldd	,s
   D8D7 BD 9D 9A      [ 8]  964 	jsr	fmthtxt
   D8DA 35 06         [ 7]  965 	puls	d
                            966 
   D8DC 31 A9 00 2C   [ 8]  967 	leay	ACQVARSZ,y	; next channel
   D8E0 4C            [ 2]  968 	inca			; next row
   D8E1 81 16         [ 2]  969 	cmpa	#SCRNTP+0d6+0d16
   D8E3 26 E4         [ 3]  970 	bne	2$
   D8E5 86 06         [ 2]  971 	lda	#SCRNTP+0d6
   D8E7 C1 31         [ 2]  972 	cmpb	#$HVSTS+0d40
   D8E9 27 04         [ 3]  973 	beq	3$
   D8EB C6 31         [ 2]  974 	ldb	#$HVSTS+0d40
   D8ED 20 DA         [ 3]  975 	bra	2$
                            976 
                            977 	; fill in high voltage
                            978 
   D8EF 10 8E 77 41   [ 4]  979 3$:	ldy	#acqvar		; acquisition variables
   D8F3 86 06         [ 2]  980 	lda	#SCRNTP+0d6	; screen position
   D8F5 C6 11         [ 2]  981 	ldb	#$VOLTAGE
                            982 
   D8F7 34 06         [ 7]  983 4$:	pshs	d
   D8F9 AE A9 00 1A   [ 9]  984 	ldx	hv$volt,y	; voltage
   D8FD EC E4         [ 5]  985 	ldd	,s
   D8FF BD 9E 9F      [ 8]  986 	jsr	fmt6rjint
   D902 35 06         [ 7]  987 	puls	d
                            988 
   D904 31 A9 00 2C   [ 8]  989 	leay	ACQVARSZ,y	; next channel
   D908 4C            [ 2]  990 	inca			; next row
   D909 81 16         [ 2]  991 	cmpa	#SCRNTP+0d6+0d16
   D90B 26 EA         [ 3]  992 	bne	4$
   D90D 86 06         [ 2]  993 	lda	#SCRNTP+0d6
   D90F C1 39         [ 2]  994 	cmpb	#$VOLTAGE+0d40
   D911 27 04         [ 3]  995 	beq	5$
   D913 C6 39         [ 2]  996 	ldb	#$VOLTAGE+0d40
   D915 20 E0         [ 3]  997 	bra	4$
                            998 
                            999 	; fill in high voltage demand
                           1000 
   D917 10 8E 77 41   [ 4] 1001 5$:	ldy	#acqvar		; acquisition variables
   D91B 86 06         [ 2] 1002 	lda	#SCRNTP+0d6	; screen position
   D91D C6 18         [ 2] 1003 	ldb	#$DEMAND
                           1004 
   D91F 34 06         [ 7] 1005 6$:	pshs	d
   D921 AE A9 00 18   [ 9] 1006 	ldx	hv$dmnd,y	; voltage
   D925 EC E4         [ 5] 1007 	ldd	,s
   D927 BD 9E 9F      [ 8] 1008 	jsr	fmt6rjint
   D92A 35 06         [ 7] 1009 	puls	d
                           1010 
   D92C 30 89 02 00   [ 8] 1011 	leax	ACQBUFSZ,x	; next channel
   D930 31 A9 00 2C   [ 8] 1012 	leay	ACQVARSZ,y
   D934 4C            [ 2] 1013 	inca			; next row
   D935 81 16         [ 2] 1014 	cmpa	#SCRNTP+0d6+0d16
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 26
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
HV4032A Status Screen

   D937 26 E6         [ 3] 1015 	bne	6$
   D939 86 06         [ 2] 1016 	lda	#SCRNTP+0d6
   D93B C1 40         [ 2] 1017 	cmpb	#$DEMAND+0d40
   D93D 27 04         [ 3] 1018 	beq	7$
   D93F C6 40         [ 2] 1019 	ldb	#$DEMAND+0d40
   D941 20 DC         [ 3] 1020 	bra	6$
                           1021 
                           1022 	; fill in high voltage set
                           1023 
   D943 10 8E 77 41   [ 4] 1024 7$:	ldy	#acqvar		; acquisition variables
   D947 86 06         [ 2] 1025 	lda	#SCRNTP+0d6	; screen position
   D949 C6 1F         [ 2] 1026 	ldb	#$HVSET
                           1027 
   D94B 34 06         [ 7] 1028 8$:	pshs	d
   D94D AE A9 00 1C   [ 9] 1029 	ldx	hv$setv,y	; voltage
   D951 EC E4         [ 5] 1030 	ldd	,s
   D953 BD 9E 9F      [ 8] 1031 	jsr	fmt6rjint
   D956 35 06         [ 7] 1032 	puls	d
                           1033 
   D958 30 89 02 00   [ 8] 1034 	leax	ACQBUFSZ,x	; next channel
   D95C 31 A9 00 2C   [ 8] 1035 	leay	ACQVARSZ,y
   D960 4C            [ 2] 1036 	inca			; next row
   D961 81 16         [ 2] 1037 	cmpa	#SCRNTP+0d6+0d16
   D963 26 E6         [ 3] 1038 	bne	8$
   D965 86 06         [ 2] 1039 	lda	#SCRNTP+0d6
   D967 C1 47         [ 2] 1040 	cmpb	#$HVSET+0d40
   D969 27 04         [ 3] 1041 	beq	9$
   D96B C6 47         [ 2] 1042 	ldb	#$HVSET+0d40
   D96D 20 DC         [ 3] 1043 	bra	8$
                           1044 
   D96F 39            [ 5] 1045 9$:	rts
                           1046 
                           1047 
                           1048 	; High-Voltage Channel Status Table
                           1049 
   D970 D9 96              1050 10$:	.word	15$		; 0	?
   D972 D9 7A              1051 	.word	11$		; 1	off
   D974 D9 81              1052 	.word	12$		; 2	on
   D976 D9 88              1053 	.word	13$		; 3	zero
   D978 D9 8F              1054 	.word	14$		; 4	fail
                           1055 
   D97A 20 20 4F 66 66 20  1056 11$:	.asciz	"  Off "
        00
   D981 20 20 20 4F 6E 20  1057 12$:	.asciz	"   On "
        00
   D988 20 5A 65 72 6F 20  1058 13$:	.asciz	" Zero "
        00
   D98F 20 46 61 69 6C 20  1059 14$:	.asciz	" Fail "
        00
   D996 20 20 20 20 3F 20  1060 15$:	.asciz	"    ? "
        00
                           1061 
                           1062 	; High-Voltage Supply Status Table
                           1063 
   D99D D9 A7              1064 16$:	.word	17$		; 0	?
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 27
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
HV4032A Status Screen

   D99F D9 B8              1065 	.word	18$		; 1	off
   D9A1 D9 C9              1066 	.word	19$		; 2	on
   D9A3 D9 A7              1067 	.word	17$		; 3 	----
   D9A5 D9 A7              1068 	.word	17$		; 4	----
                           1069 
   D9A7 20 20 20 20 20 20  1070 17$:	.asciz	"                "
        20 20 20 20 20 20
        20 20 20 20 00
   D9B8 48 69 67 68 2D 56  1071 18$:	.asciz	"High-Voltage OFF"
        6F 6C 74 61 67 65
        20 4F 46 46 00
   D9C9 48 69 67 68 2D 56  1072 19$:	.asciz	"High-Voltage ON "
        6F 6C 74 61 67 65
        20 4F 4E 20 00
                           1073 
                           1074 
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 28
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

                           1076 	.sbttl	Channel Status Screen
                           1077 
                           1078 	.area	SCREEN
                           1079 
   AB25                    1080 chn$scrn::
   AB25 34 36         [ 9] 1081 	pshs	d,x,y
                           1082 
   AB27 D6 47         [ 4] 1083 1$:	ldb	*s$state	; check state
   AB29 27 14         [ 3] 1084 	beq	3$
   AB2B 96 2F         [ 4] 1085 	lda	*char
   AB2D 81 17         [ 2] 1086 	cmpa	#CTRLW		; redraw screen ?
   AB2F 26 06         [ 3] 1087 	bne	2$
   AB31 6F E4         [ 6] 1088 	clr	,s		; CTRLW seen
   AB33 C6 01         [ 2] 1089 	ldb	#1
   AB35 D7 47         [ 4] 1090 	stb	*s$state	; new state
   AB37 58            [ 2] 1091 2$:	aslb
   AB38 C1 08         [ 2] 1092 	cmpb	#5$-4$		; check for valid state
   AB3A 25 03         [ 3] 1093 	blo	3$
   AB3C 5F            [ 2] 1094 	clrb
   AB3D D7 47         [ 4] 1095 	stb	*s$state
   AB3F 8E AB 44      [ 3] 1096 3$:	ldx	#4$
   AB42 6E 95         [ 7] 1097 	jmp	[b,x]
                           1098 
   AB44 AB 4C AB 56 AB 7E  1099 4$:	.word	5$,6$,9$,10$
        AB 88
                           1100 
   AB4C FC AD 72      [ 6] 1101 5$:	ldd	r$chn3		; default option position
   AB4F BD A3 DD      [ 8] 1102 	jsr	init$opt
   AB52 DD 45         [ 5] 1103 	std	*scrn$pos
   AB54 0C 47         [ 6] 1104 	inc	*s$state	; next state
                           1105 
   AB56 BD A3 AF      [ 8] 1106 6$:	jsr	clr$scrn	; clear the screen
   AB59 BD AB B0      [ 8] 1107 	jsr	chn$page	; draw the page
                           1108 
   AB5C 0D 48         [ 6] 1109 	tst	*o$state	; active options sequence ?
   AB5E 27 1C         [ 3] 1110 	beq	8$		; no - skip
   AB60 86 F9         [ 2] 1111 	lda	#ENTER		; redo question
   AB62 BD AE 72      [ 8] 1112 	jsr	chn$ques
   AB65 0D 59         [ 6] 1113 	tst	*s$strlen	; answer ?
   AB67 27 13         [ 3] 1114 	beq	8$		; no - skip
   AB69 DC 45         [ 5] 1115 	ldd	*scrn$pos	; cursor position
   AB6B BD 9D 5E      [ 8] 1116 	jsr	fmtindex
   AB6E 30 C9 00 49   [ 8] 1117 	leax	s$string,u	; answer string
   AB72 A6 80         [ 6] 1118 7$:	lda	,x+		; copy string
   AB74 2F 06         [ 3] 1119 	ble	8$
   AB76 A7 A0         [ 6] 1120 	sta	,y+
   AB78 0C 46         [ 6] 1121 	inc	*scrn$pos+1	; update cursor position
   AB7A 20 F6         [ 3] 1122 	bra	7$
                           1123 
   AB7C 0C 47         [ 6] 1124 8$:	inc	*s$state	; next state
                           1125 
   AB7E BD AC C8      [ 8] 1126 9$:	jsr	chn$lgnd	; load up legends
   AB81 DC 45         [ 5] 1127 	ldd	*scrn$pos	; reload cursor position
   AB83 BD A3 CA      [ 8] 1128 	jsr	pos$scrn
   AB86 0C 47         [ 6] 1129 	inc	*s$state	; next state
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 29
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

                           1130 
   AB88 0D 48         [ 6] 1131 10$:	tst	*o$state	; processing an option ?
   AB8A 27 13         [ 3] 1132 	beq	11$		; no  - skip
                           1133 
   AB8C 96 2F         [ 4] 1134 	lda	*char		; get the character
   AB8E BD B0 05      [ 8] 1135 	jsr	chn$optn	; yes - service the option
   AB91 97 2F         [ 4] 1136 	sta	*char		; character used
                           1137 
   AB93 0D 47         [ 6] 1138 	tst	*s$state	; exit screen ?
   AB95 27 16         [ 3] 1139 	beq	12$		; yes - doit
                           1140 
   AB97 0D 48         [ 6] 1141 	tst	*o$state	; processing finished ?
   AB99 10 27 FF 8A   [ 6] 1142 	lbeq	1$		; yes - rescan new settup
   AB9D 20 0E         [ 3] 1143 	bra	12$
                           1144 
   AB9F 96 2F         [ 4] 1145 11$:	lda	*char
   ABA1 BD A4 81      [ 8] 1146 	jsr	scn$scrl	; try scrolling to a new option
   ABA4 97 2F         [ 4] 1147 	sta	*char
   ABA6 27 05         [ 3] 1148 	beq	12$
   ABA8 BD AE 72      [ 8] 1149 	jsr	chn$ques	; try selecting an option
   ABAB 97 2F         [ 4] 1150 	sta	*char
                           1151 
   ABAD 35 36         [ 9] 1152 12$:	puls	d,x,y
   ABAF 39            [ 5] 1153 	rts
                           1154 
                           1155 
                           1156 	; chn$scrn  Page Outline
                           1157 
   ABB0                    1158 chn$page::
   ABB0 10 8E AB C0   [ 4] 1159 	ldy	#3$
   ABB4 EC A1         [ 8] 1160 1$:	ldd	,y++
   ABB6 AE A1         [ 8] 1161 	ldx	,y++
   ABB8 27 05         [ 3] 1162 	beq	2$
   ABBA BD 9D 9A      [ 8] 1163 	jsr	fmthtxt
   ABBD 20 F5         [ 3] 1164 	bra	1$
                           1165 
   ABBF 39            [ 5] 1166 2$:	rts
                           1167 
                           1168 
   ABC0 00 23              1169 3$:	.byte	SCRNTP+0d0,	0d35
   ABC2 AB F8              1170 	.word	4$
   ABC4 04 23              1171 	.byte	SCRNTP+0d4,	0d35
   ABC6 AC 24              1172 	.word	6$
   ABC8 0A 23              1173 	.byte	SCRNTP+0d10,	0d35
   ABCA AC 3E              1174 	.word	7$
                           1175 
                     06A6  1176 chn$ntry = .
                           1177 
   ABCC 02 23              1178 	.byte	SCRNTP+0d2,	0d35
   ABCE AC 11              1179 	.word	5$
   ABD0 06 23              1180 	.byte	SCRNTP+0d6,	0d35
   ABD2 AC 56              1181 	.word	8$
   ABD4 07 23              1182 	.byte	SCRNTP+0d7,	0d35
   ABD6 AC 69              1183 	.word	9$
   ABD8 08 23              1184 	.byte	SCRNTP+0d8,	0d35
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 30
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

   ABDA AC 7C              1185 	.word	10$
   ABDC 0C 23              1186 	.byte	SCRNTP+0d12,	0d35
   ABDE AC 56              1187 	.word	8$
   ABE0 0D 23              1188 	.byte	SCRNTP+0d13,	0d35
   ABE2 AC 69              1189 	.word	9$
   ABE4 0E 23              1190 	.byte	SCRNTP+0d14,	0d35
   ABE6 AC 7C              1191 	.word	10$
   ABE8 11 23              1192 	.byte	SCRNTP+0d17,	0d35
   ABEA AC 8F              1193 	.word	11$
   ABEC 13 23              1194 	.byte	SCRNTP+0d19,	0d35
   ABEE AC A2              1195 	.word	12$
   ABF0 14 23              1196 	.byte	SCRNTP+0d20,	0d35
   ABF2 AC B5              1197 	.word	13$
   ABF4 00 00 00 00        1198 	.word	0,0
                           1199 
                           1200 
                     0013  1201 	STS$POS	=	0d19		; offset position for update
                           1202 
                           1203 		;012345678901234567890123456789
   ABF8 20 20 20 20 20 20  1204 4$:	.asciz	"          Channel Status"
        20 20 20 20 43 68
        61 6E 6E 65 6C 20
        53 74 61 74 75 73
        00
                           1205 
   AC11 20 20 20 20 20 20  1206 5$:	.asciz	"      PHS Status ="
        50 48 53 20 53 74
        61 74 75 73 20 3D
        00
                           1207 
   AC24 20 20 20 20 20 20  1208 6$:	.asciz	"         Calibration Data"
        20 20 20 43 61 6C
        69 62 72 61 74 69
        6F 6E 20 44 61 74
        61 00
   AC3E 20 20 20 20 20 20  1209 7$:	.asciz	"          Updating Data"
        20 20 20 20 55 70
        64 61 74 69 6E 67
        20 44 61 74 61 00
                           1210 
   AC56 50 75 6C 73 65 20  1211 8$:	.asciz	"Pulse Height ADC ="
        48 65 69 67 68 74
        20 41 44 43 20 3D
        00
   AC69 20 54 65 6D 70 65  1212 9$:	.asciz	" Temperature ADC ="
        72 61 74 75 72 65
        20 41 44 43 20 3D
        00
   AC7C 20 20 20 4C 45 44  1213 10$:	.asciz	"   LED Drive DAC ="
        20 44 72 69 76 65
        20 44 41 43 20 3D
        00
                           1214 
   AC8F 20 20 20 20 20 20  1215 11$:	.asciz	"       HV Status ="
        20 48 56 20 53 74
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 31
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

        61 74 75 73 20 3D
        00
                           1216 
   ACA2 20 20 20 20 20 20  1217 12$:	.asciz	"         Voltage ="
        20 20 20 56 6F 6C
        74 61 67 65 20 3D
        00
   ACB5 20 20 20 20 20 20  1218 13$:	.asciz	"          HV-Set ="
        20 20 20 20 48 56
        2D 53 65 74 20 3D
        00
                           1219 
                           1220 
                           1221 	;
                           1222 	; chn$scrn Legends
                           1223 	;
                           1224 
   ACC8                    1225 chn$lgnd::
   ACC8 34 16         [ 8] 1226 	pshs	d,x
                           1227 
   ACCA 96 42         [ 4] 1228 	lda	*scrn$sts+1	; channel number
   ACCC 81 1F         [ 2] 1229 	cmpa	#0d31		; valid LED channel ?
   ACCE 23 07         [ 3] 1230 	blos	1$		; yes - skip
   ACD0 81 20         [ 2] 1231 	cmpa	#0d32		; valid channel ?
   ACD2 22 21         [ 3] 1232 	bhi	2$		; no - exit
   ACD4 4F            [ 2] 1233 	clra			; set to channel 0		
   ACD5 97 42         [ 4] 1234 	sta	*scrn$sts+1
   ACD7 48            [ 2] 1235 1$:	asla
                           1236 
                           1237 	; Conditional Acquisition Legends
                           1238 
   ACD8 8E 8C 16      [ 3] 1239 	ldx	#acqvtbl
   ACDB 30 96         [ 8] 1240 	leax	[a,x]		; this channels variables
   ACDD A6 89 00 03   [ 8] 1241 	lda	acq$sts,x	; get acquisition status
   ACE1 84 0F         [ 2] 1242 	anda	#0x0F
   ACE3 48            [ 2] 1243 	asla
   ACE4 8E AD 0A      [ 3] 1244 	ldx	#4$
   ACE7 30 96         [ 8] 1245 	leax	[a,x]		; get legend list
   ACE9 BD A4 B4      [ 8] 1246 	jsr	scn$lgnd	; do legends
                           1247 
                           1248 	; UnCondition Legends
                           1249 
   ACEC 8E AC F8      [ 3] 1250 	ldx	#3$
   ACEF BD A4 B4      [ 8] 1251 	jsr	scn$lgnd	; do legends
   ACF2 BD A4 EB      [ 8] 1252 	jsr	scn$chnl	; and channel
                           1253 
   ACF5 35 16         [ 8] 1254 2$:	puls	d,x
   ACF7 39            [ 5] 1255 	rts
                           1256 
                           1257 	; Channel Control
                           1258 
   ACF8 AD BA AD C0 AD C6  1259 3$:	.word	n$chn10,r$chn11,r$chn12,r$chn13
        AD CC
   AD00 AD 66 AD 72 AD 78  1260 	.word	n$chn1c,r$chn3,	n$chn4,	r$chn2,	0
        AD 6C 00 00
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 32
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

                           1261 
                           1262 	; PHS Control
                           1263 
                           1264 	; Acquisition Status Table
                           1265 
                           1266 				; 0bxxxxxxxx
                           1267 				;	|||`---- $SCAN
                           1268 				;	||`----- $FAILED
                           1269 				;	|`------ $HOLD
                           1270 				;	`------- $ACTIVE
   AD0A AD 2A              1271 4$:	.word	5$		;       0000	inactive
   AD0C AD 36              1272 	.word	6$		;	0001	cal
   AD0E AD 42              1273 	.word	7$		;	0010	failed
   AD10 AD 42              1274 	.word	7$		;	0011	failed
   AD12 AD 4E              1275 	.word	8$		;	0100	hold
   AD14 AD 4E              1276 	.word	8$		;	0101	hold
   AD16 AD 42              1277 	.word	7$		;	0110	failed
   AD18 AD 42              1278 	.word	7$		;	0111	failed
   AD1A AD 5A              1279 	.word	9$		;	1000	active
   AD1C AD 5A              1280 	.word	9$		;	1001	active
   AD1E AD 42              1281 	.word	7$		;	1010	failed
   AD20 AD 42              1282 	.word	7$		;	1011	failed
   AD22 AD 4E              1283 	.word	8$		;	1100	hold
   AD24 AD 4E              1284 	.word	8$		;	1101	hold
   AD26 AD 42              1285 	.word	7$		;	1110	failed
   AD28 AD 42              1286 	.word	7$		;	1111	failed
                           1287 
                           1288 
   AD2A AD 7E AD 8A AD 9C  1289 5$:	.word	n$chn5,	n$chn6, r$chn7,	r$chn8,	r$chn9,	0	; inactive
        AD A8 AD B4 00 00
   AD36 AD 7E AD 8A AD 96  1290 6$:	.word	n$chn5,	n$chn6,	n$chn7,	n$chn8,	n$chn9,	0	; cal
        AD A2 AD AE 00 00
   AD42 AD 7E AD 8A AD 9C  1291 7$:	.word	n$chn5,	n$chn6,	r$chn7,	r$chn8,	r$chn9,	0	; failed
        AD A8 AD B4 00 00
   AD4E AD 84 AD 8A AD 9C  1292 8$:	.word	r$chn5,	n$chn6,	r$chn7,	r$chn8,	r$chn9,	0	; hold
        AD A8 AD B4 00 00
   AD5A AD 7E AD 90 AD 9C  1293 9$:	.word	n$chn5,	r$chn6,	r$chn7,	r$chn8,	r$chn9,	0	; active
        AD A8 AD B4 00 00
                           1294 
                           1295 
                           1296 	;	row		column		video		option
                           1297 	;-------------------------------------------------------------
   AD66                    1298 n$chn1c:
   AD66 00 01 00 00        1299 	.byte	SCRNTP+0d0,	1,		NORMAL,		0
   AD6A AD D2              1300 	.word	1$		; "Channel Control"
                     0846  1301 r$chn2	= .
   AD6C 02 03 80 01        1302 	.byte	SCRNTP+0d2,	3,		REVERSE,	1
   AD70 AD E2              1303 	.word	2$		; "Channel #"
                     084C  1304 r$chn3	= .
   AD72 04 03 80 02        1305 	.byte	SCRNTP+0d4,	3,		REVERSE,	2
   AD76 AD EE              1306 	.word	3$		; "Exit"
                     0852  1307 n$chn4	= .
   AD78 07 03 00 00        1308 	.byte	SCRNTP+0d7,	3,		NORMAL,		0
   AD7C AD FA              1309 	.word	4$		; "PHS Control"
                     0858  1310 n$chn5	= .
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 33
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

   AD7E 09 03 00 00        1311 	.byte	SCRNTP+0d9,	3,		NORMAL,		0
   AD82 AE 06              1312 	.word	5$		; "Active"
                     085E  1313 r$chn5	= .
   AD84 09 03 80 03        1314 	.byte	SCRNTP+0d9,	3,		REVERSE,	3
   AD88 AE 06              1315 	.word	5$		; "Active"
                     0864  1316 n$chn6	= .
   AD8A 0A 03 00 00        1317 	.byte	SCRNTP+0d10,	3,		NORMAL,		0
   AD8E AE 12              1318 	.word	6$		; "Hold"
                     086A  1319 r$chn6	= .
   AD90 0A 03 80 04        1320 	.byte	SCRNTP+0d10,	3,		REVERSE,	4
   AD94 AE 12              1321 	.word	6$		; "Hold"
                     0870  1322 n$chn7	= .
   AD96 0B 03 00 00        1323 	.byte	SCRNTP+0d11,	3,		NORMAL,		0
   AD9A AE 1E              1324 	.word	7$		; "Cal"
                     0876  1325 r$chn7	= .
   AD9C 0B 03 80 05        1326 	.byte	SCRNTP+0d11,	3,		REVERSE,	5
   ADA0 AE 1E              1327 	.word	7$		; "Cal"
                     087C  1328 n$chn8	= .
   ADA2 0C 03 00 00        1329 	.byte	SCRNTP+0d12,	3,		NORMAL,		0
   ADA6 AE 2A              1330 	.word	8$		; "Set"
                     0882  1331 r$chn8	= .
   ADA8 0C 03 80 06        1332 	.byte	SCRNTP+0d12,	3,		REVERSE,	6
   ADAC AE 2A              1333 	.word	8$		; "Set"
                     0888  1334 n$chn9	= .
   ADAE 0D 03 00 00        1335 	.byte	SCRNTP+0d13,	3,		NORMAL,		0
   ADB2 AE 36              1336 	.word	9$		; "Clear"
                     088E  1337 r$chn9	= .
   ADB4 0D 03 80 07        1338 	.byte	SCRNTP+0d13,	3,		REVERSE,	7
   ADB8 AE 36              1339 	.word	9$		; "Clear"
                     0894  1340 n$chn10	= .
   ADBA 10 03 00 00        1341 	.byte	SCRNTP+0d16,	3,		NORMAL,		0
   ADBE AE 42              1342 	.word	10$		; "HV Control"
                     089A  1343 r$chn11	= .
   ADC0 12 03 80 08        1344 	.byte	SCRNTP+0d18,	3,		REVERSE,	8
   ADC4 AE 4E              1345 	.word	11$		; "Zero"
                     08A0  1346 r$chn12	= .
   ADC6 13 03 80 09        1347 	.byte	SCRNTP+0d19,	3,		REVERSE,	9
   ADCA AE 5A              1348 	.word	12$		; "Restore"
                     08A6  1349 r$chn13	= .
   ADCC 14 03 80 0A        1350 	.byte	SCRNTP+0d20,	3,		REVERSE,	10
   ADD0 AE 66              1351 	.word	13$		; "HV-Set"
                           1352 
   ADD2 43 68 61 6E 6E 65  1353 1$:	.asciz	"Channel Control"
        6C 20 43 6F 6E 74
        72 6F 6C 00
   ADE2 43 68 61 6E 6E 65  1354 2$:	.asciz	"Channel #  "		; 1
        6C 20 23 20 20 00
   ADEE 45 78 69 74 20 53  1355 3$:	.asciz	"Exit Screen"		; 2
        63 72 65 65 6E 00
   ADFA 50 48 53 20 43 6F  1356 4$:	.asciz	"PHS Control"
        6E 74 72 6F 6C 00
   AE06 20 20 41 63 74 69  1357 5$:	.asciz	"  Active   "		; 3
        76 65 20 20 20 00
   AE12 20 20 20 48 6F 6C  1358 6$:	.asciz	"   Hold    "		; 4
        64 20 20 20 20 00
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 34
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

   AE1E 20 20 20 43 61 6C  1359 7$:	.asciz	"   Cal     "		; 5
        20 20 20 20 20 00
   AE2A 20 20 20 53 65 74  1360 8$:	.asciz	"   Set     "		; 6
        20 20 20 20 20 00
   AE36 20 20 20 43 6C 65  1361 9$:	.asciz	"   Clear   "		; 7
        61 72 20 20 20 00
   AE42 48 56 20 20 43 6F  1362 10$:	.asciz	"HV  Control"
        6E 74 72 6F 6C 00
   AE4E 20 20 20 5A 65 72  1363 11$:	.asciz	"   Zero    "		; 8
        6F 20 20 20 20 00
   AE5A 20 20 52 65 73 74  1364 12$:	.asciz	"  Restore  "		; 9
        6F 72 65 20 20 00
   AE66 20 20 48 56 2D 53  1365 13$:	.asciz	"  HV-Set   "		; 10
        65 74 20 20 20 00
                           1366 
                           1367 	;
                           1368 	; chn$scrn Questions
                           1369 	;
                           1370 
   AE72                    1371 chn$ques::
   AE72 81 F9         [ 2] 1372 	cmpa	#ENTER		; selecting ?
   AE74 26 37         [ 3] 1373 	bne	5$		; no - exit
                           1374 
   AE76 34 34         [ 8] 1375 	pshs	b,x,y
                           1376 
   AE78 86 17         [ 2] 1377 	lda	#SCRNBT		; common question position
   AE7A C6 00         [ 2] 1378 	ldb	#0
   AE7C BD 9D 5E      [ 8] 1379 	jsr	fmtindex
                           1380 
   AE7F 30 C9 00 5A   [ 8] 1381 	leax	optarray,u	; get option
   AE83 D6 72         [ 4] 1382 	ldb	*opt$posn
   AE85 E6 85         [ 5] 1383 	ldb	b,x
                           1384 
   AE87 C1 02         [ 2] 1385 	cmpb	#2		; exiting this screen
   AE89 26 02         [ 3] 1386 	bne	1$		; no - skip
   AE8B 0F 47         [ 6] 1387 	clr	*s$state	; yes
                           1388 
   AE8D 58            [ 2] 1389 1$:	aslb
   AE8E C1 16         [ 2] 1390 	cmpb	#7$-6$		; valid option ?
   AE90 24 18         [ 3] 1391 	bhis	4$		; no - exit
   AE92 8E AE AE      [ 3] 1392 	ldx	#6$
   AE95 30 95         [ 8] 1393 	leax	[b,x]
   AE97 A6 80         [ 6] 1394 2$:	lda	,x+
   AE99 27 06         [ 3] 1395 	beq	3$
   AE9B A7 A0         [ 6] 1396 	sta	,y+
   AE9D 0C 75         [ 6] 1397 	inc	*fmtcol		; next column
   AE9F 20 F6         [ 3] 1398 	bra	2$
                           1399 
   AEA1 DC 74         [ 5] 1400 3$:	ldd	*fmtrow		; load new cursor position
   AEA3 BD A3 CA      [ 8] 1401 	jsr	pos$scrn
   AEA6 86 01         [ 2] 1402 	lda	#1		; option processing
   AEA8 97 48         [ 4] 1403 	sta	*o$state
   AEAA 4F            [ 2] 1404 4$:	clra			; dump character
   AEAB 35 34         [ 8] 1405 	puls	b,x,y
   AEAD 39            [ 5] 1406 5$:	rts
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 35
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

                           1407 
                           1408 
   AEAE AE C4 AE D3 AE EA  1409 6$:	.word	7$,8$,9$,10$,11$,12$,13$,14$,15$,16$,17$
        AF 06 AF 23 AF 45
        AF 63 AF 8C AF A6
        AF C4 AF E5
                           1410 
   AEC4 49 6E 76 61 6C 69  1411 7$:	.asciz	"Invalid Option"
        64 20 4F 70 74 69
        6F 6E 00
   AED3 53 65 6C 65 63 74  1412 8$:	.asciz	"Select New Channel -> "				; 1
        20 4E 65 77 20 43
        68 61 6E 6E 65 6C
        20 2D 3E 20 00
   AEEA 2E 2E 2E 20 45 78  1413 9$:	.asciz	"... Exiting this Screen ..."				; 2
        69 74 69 6E 67 20
        74 68 69 73 20 53
        63 72 65 65 6E 20
        2E 2E 2E 00
   AF06 41 63 74 69 76 61  1414 10$:	.asciz	"Activate Channel (Y,N) ? -> "				; 3
        74 65 20 43 68 61
        6E 6E 65 6C 20 28
        59 2C 4E 29 20 3F
        20 2D 3E 20 00
   AF23 50 6C 61 63 65 20  1415 11$:	.asciz	"Place Channel on Hold (Y,N) ? -> "			; 4
        43 68 61 6E 6E 65
        6C 20 6F 6E 20 48
        6F 6C 64 20 28 59
        2C 4E 29 20 3F 20
        2D 3E 20 00
   AF45 43 61 6C 69 62 72  1416 12$:	.asciz	"Calibrate Channel (Y,N) ? -> "				; 5
        61 74 65 20 43 68
        61 6E 6E 65 6C 20
        28 59 2C 4E 29 20
        3F 20 2D 3E 20 00
   AF63 45 6E 74 65 72 20  1417 13$:	.asciz	"Enter Set Value for LED DAC (0-4095) -> "		; 6
        53 65 74 20 56 61
        6C 75 65 20 66 6F
        72 20 4C 45 44 20
        44 41 43 20 28 30
        2D 34 30 39 35 29
        20 2D 3E 20 00
   AF8C 43 6C 65 61 72 20  1418 14$:	.asciz	"Clear Channel (Y,N) ? -> "				; 7
        43 68 61 6E 6E 65
        6C 20 28 59 2C 4E
        29 20 3F 20 2D 3E
        20 00
   AFA6 5A 65 72 6F 20 48  1419 15$:	.asciz	"Zero High-Voltage (Y,N) ? -> "				; 8
        69 67 68 2D 56 6F
        6C 74 61 67 65 20
        28 59 2C 4E 29 20
        3F 20 2D 3E 20 00
   AFC4 52 65 73 74 6F 72  1420 16$:	.asciz	"Restore High-Voltage (Y,N) ? -> "			; 9
        65 20 48 69 67 68
        2D 56 6F 6C 74 61
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 36
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

        67 65 20 28 59 2C
        4E 29 20 3F 20 2D
        3E 20 00
   AFE5 53 65 74 20 48 69  1421 17$:	.asciz	"Set High-Voltage (100-3000) -> "			; 10
        67 68 2D 56 6F 6C
        74 61 67 65 20 28
        31 30 30 2D 33 30
        30 30 29 20 2D 3E
        20 00
                           1422 
                           1423 	;
                           1424 	; chn$scrn Options
                           1425 	;
                           1426 
   B005                    1427 chn$optn::
   B005 BD A4 0E      [ 8] 1428 	jsr	scn$gets	; build a response string
   B008 27 42         [ 3] 1429 	beq	3$		; not finished
   B00A 0D 49         [ 6] 1430 	tst	*s$string	; NULL string ?
   B00C 2F 28         [ 3] 1431 	ble	2$		; yes - terminate option
                           1432 
   B00E BD A3 F8      [ 8] 1433 	jsr	option		; get the option number
   B011 58            [ 2] 1434 	aslb
   B012 C1 16         [ 2] 1435 	cmpb	#5$-4$		; valid option ?
   B014 24 20         [ 3] 1436 	bhis	2$		; no - terminate request
                           1437 
   B016 96 42         [ 4] 1438 	lda	*scrn$sts+1	; get channel number
   B018 81 1F         [ 2] 1439 	cmpa	#0d31		; valid channel ?
   B01A 22 1A         [ 3] 1440 	bhi	2$		; no - terminate option
   B01C 48            [ 2] 1441 	asla
                           1442 
   B01D 10 8E B0 36   [ 4] 1443 	ldy	#2$		; options return address
   B021 34 20         [ 6] 1444 	pshs	y
                           1445 
   B023 10 8E B0 4E   [ 4] 1446 	ldy	#4$		; jump table
   B027 31 B5         [ 8] 1447 	leay	[b,y]		; get address of option routine
   B029 34 20         [ 6] 1448 	pshs	y		; push as a return address
                           1449 
   B02B 30 C9 00 49   [ 8] 1450 	leax	s$string,u	; string pointer
                           1451 
   B02F 10 8E 8C 16   [ 4] 1452 	ldy	#acqvtbl	; variables address for this channel
   B033 31 B6         [ 8] 1453 	leay	[a,y]
                           1454 
   B035 39            [ 5] 1455 1$:	rts			; do option
                           1456 
   B036 0F 48         [ 6] 1457 2$:	clr	*o$state	; option completed
   B038 86 17         [ 2] 1458 	lda	#SCRNBT
   B03A C6 00         [ 2] 1459 	ldb	#0
   B03C BD 9D 75      [ 8] 1460 	jsr	fmtdeol		; clear option question and answer
                           1461 
   B03F DC 72         [ 5] 1462 	ldd	*opt$posn	; option position
   B041 BD A3 CA      [ 8] 1463 	jsr	pos$scrn	; restore cursor
                           1464 
   B044 0D 47         [ 6] 1465 	tst	*s$state	; new screen
   B046 27 04         [ 3] 1466 	beq	3$		; no - skip
   B048 86 02         [ 2] 1467 	lda	#2		; redraw legends always
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 37
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

   B04A 97 47         [ 4] 1468 	sta	*s$state	
                           1469 
   B04C 4F            [ 2] 1470 3$:	clra			; input character always used
   B04D 39            [ 5] 1471 	rts
                           1472 
   B04E B0 35              1473 4$:	.word	1$		; invalid option
   B050 B0 64              1474 	.word	5$		; new channel
   B052 B0 6E              1475 	.word	7$		; exit screen
   B054 B0 76              1476 	.word	9$		; activate
   B056 B0 8A              1477 	.word	11$		; hold
   B058 B0 9E              1478 	.word	13$		; cal
   B05A B0 D2              1479 	.word	16$		; set
   B05C B0 E3              1480 	.word	18$		; clear
   B05E B0 F7              1481 	.word	20$		; zero
   B060 B1 24              1482 	.word	23$		; restore
   B062 B1 51              1483 	.word	26$		; set hv
                           1484 
                           1485 	; New Channel Number
                           1486 
   B064 BD E3 34      [ 8] 1487 5$:	jsr	a$d$i		; convert to an integer
   B067 C1 1F         [ 2] 1488 	cmpb	#0d31		; valid ?
   B069 22 02         [ 3] 1489 	bhi	6$		; no - skip
   B06B D7 42         [ 4] 1490 	stb	*scrn$sts+1	; save new channel #
   B06D 39            [ 5] 1491 6$:	rts
                           1492 
                           1493 	; Exit Screen
                           1494 
   B06E BD A4 05      [ 8] 1495 7$:	jsr	ans$yes
   B071 26 02         [ 3] 1496 	bne	8$
   B073 0F 47         [ 6] 1497 	clr	*s$state	; just exit
   B075 39            [ 5] 1498 8$:	rts
                           1499 
                           1500 	; Activate
                           1501 
   B076 BD A4 05      [ 8] 1502 9$:	jsr	ans$yes
   B079 26 0E         [ 3] 1503 	bne	10$
   B07B 96 42         [ 4] 1504 	lda	*scrn$sts+1	; channel number
   B07D E6 A9 00 03   [ 8] 1505 	ldb	acq$sts,y
   B081 C4 FB         [ 2] 1506 	andb	#~$HOLD		; clear the hold status
   B083 BD 8C 58      [ 8] 1507 	jsr	chng$sts	; change the status
   B086 BD 8C 73      [ 8] 1508 	jsr	wait$sts	; wait for change
   B089 39            [ 5] 1509 10$:	rts
                           1510 
                           1511 	; Hold
                           1512 
   B08A BD A4 05      [ 8] 1513 11$:	jsr	ans$yes
   B08D 26 0E         [ 3] 1514 	bne	12$
   B08F 96 42         [ 4] 1515 	lda	*scrn$sts+1	; channel number
   B091 E6 A9 00 03   [ 8] 1516 	ldb	acq$sts,y
   B095 CA 04         [ 2] 1517 	orb	#$HOLD		; set the hold status
   B097 BD 8C 58      [ 8] 1518 	jsr	chng$sts	; change the status
   B09A BD 8C 73      [ 8] 1519 	jsr	wait$sts	; wait for change
   B09D 39            [ 5] 1520 12$:	rts
                           1521 
                           1522 	; Calibrate
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 38
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

                           1523 
   B09E BD A4 05      [ 8] 1524 13$:	jsr	ans$yes
   B0A1 26 12         [ 3] 1525 	bne	14$
                           1526 
   B0A3 86 17         [ 2] 1527 	lda	#SCRNBT
   B0A5 C6 00         [ 2] 1528 	ldb	#0
   B0A7 BD 9D 75      [ 8] 1529 	jsr	fmtdeol		; clear option question and answer
   B0AA 8E B0 B6      [ 3] 1530 	ldx	#15$
   B0AD BD 9D 9A      [ 8] 1531 	jsr	fmthtxt		; note calibration
                           1532 
   B0B0 96 42         [ 4] 1533 	lda	*scrn$sts+1	; channel number
   B0B2 BD 8C BD      [ 8] 1534 	jsr	phs$cal		; calibrate
   B0B5 39            [ 5] 1535 14$:	rts
                           1536 
   B0B6 2E 2E 2E 20 43 61  1537 15$:	.asciz	"... Calibrating Channel ..."
        6C 69 62 72 61 74
        69 6E 67 20 43 68
        61 6E 6E 65 6C 20
        2E 2E 2E 00
                           1538 
                           1539 	; Set
                           1540 
   B0D2 BD E3 34      [ 8] 1541 16$:	jsr	a$d$i		; convert to an integer
   B0D5 10 83 0F FF   [ 5] 1542 	cmpd	#0d4095		; valid ?
   B0D9 22 07         [ 3] 1543 	bhi	17$		; no - skip
   B0DB 1F 01         [ 6] 1544 	tfr	d,x		; set value
   B0DD 96 42         [ 4] 1545 	lda	*scrn$sts+1	; channel number
   B0DF BD 8C 93      [ 8] 1546 	jsr	phs$set		; set calibration
   B0E2 39            [ 5] 1547 17$:	rts
                           1548 
                           1549 	; Clear
                           1550 
   B0E3 BD A4 05      [ 8] 1551 18$:	jsr	ans$yes
   B0E6 26 0E         [ 3] 1552 	bne	19$
   B0E8 96 42         [ 4] 1553 	lda	*scrn$sts+1	; channel number
   B0EA E6 A9 00 03   [ 8] 1554 	ldb	acq$sts,y
   B0EE C4 F0         [ 2] 1555 	andb	#~0x0F		; clear all acquisition flags
   B0F0 BD 8C 58      [ 8] 1556 	jsr	chng$sts	; change the status
   B0F3 BD 8C 73      [ 8] 1557 	jsr	wait$sts	; wait for change
   B0F6 39            [ 5] 1558 19$:	rts
                           1559 
                           1560 	; Zero
                           1561 
   B0F7 BD A4 05      [ 8] 1562 20$:	jsr	ans$yes
   B0FA 26 27         [ 3] 1563 	bne	22$
   B0FC 96 42         [ 4] 1564 	lda	*scrn$sts+1	; channel number
   B0FE E6 A9 00 03   [ 8] 1565 	ldb	acq$sts,y
   B102 27 08         [ 3] 1566 	beq	21$
   B104 CA 04         [ 2] 1567 	orb	#$HOLD		; set the hold status
   B106 BD 8C 58      [ 8] 1568 	jsr	chng$sts	; change the status
   B109 BD 8C 73      [ 8] 1569 	jsr	wait$sts	; wait for change
   B10C 34 01         [ 6] 1570 21$:	pshs	cc
   B10E 1A 50         [ 3] 1571 	orcc	#0q120
   B110 D6 42         [ 4] 1572 	ldb	*scrn$sts+1	; channel number
   B112 86 08         [ 2] 1573 	lda	#M16CxxZ	; function
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 39
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

   B114 BD 92 FF      [ 8] 1574 	jsr	en$que
   B117 86 0B         [ 2] 1575 	lda	#M16WAIT	; function
   B119 BD 92 FF      [ 8] 1576 	jsr	en$que
   B11C 86 06         [ 2] 1577 	lda	#M16CxxG	; function
   B11E BD 92 FF      [ 8] 1578 	jsr	en$que
   B121 35 01         [ 6] 1579 	puls	cc
   B123 39            [ 5] 1580 22$:	rts
                           1581 
                           1582 	; Restore
                           1583 
   B124 BD A4 05      [ 8] 1584 23$:	jsr	ans$yes
   B127 26 27         [ 3] 1585 	bne	25$
   B129 96 42         [ 4] 1586 	lda	*scrn$sts+1	; channel number
   B12B E6 A9 00 03   [ 8] 1587 	ldb	acq$sts,y
   B12F 27 08         [ 3] 1588 	beq	24$
   B131 CA 04         [ 2] 1589 	orb	#$HOLD		; set the hold status
   B133 BD 8C 58      [ 8] 1590 	jsr	chng$sts	; change the status
   B136 BD 8C 73      [ 8] 1591 	jsr	wait$sts	; wait for change
   B139 34 01         [ 6] 1592 24$:	pshs	cc
   B13B 1A 50         [ 3] 1593 	orcc	#0q120
   B13D D6 42         [ 4] 1594 	ldb	*scrn$sts+1	; channel number
   B13F 86 09         [ 2] 1595 	lda	#M16CxxR	; function
   B141 BD 92 FF      [ 8] 1596 	jsr	en$que
   B144 86 0B         [ 2] 1597 	lda	#M16WAIT	; function
   B146 BD 92 FF      [ 8] 1598 	jsr	en$que
   B149 86 06         [ 2] 1599 	lda	#M16CxxG	; function
   B14B BD 92 FF      [ 8] 1600 	jsr	en$que
   B14E 35 01         [ 6] 1601 	puls	cc
   B150 39            [ 5] 1602 25$:	rts
                           1603 
                           1604 	; HV-Set
                           1605 
   B151 BD E3 34      [ 8] 1606 26$:	jsr	a$d$i		; convert to an integer
   B154 10 83 0B B8   [ 5] 1607 	cmpd	#0d3000		; maximum voltage allowed
   B158 22 2B         [ 3] 1608 	bhi	28$
   B15A ED A9 00 1C   [ 9] 1609 	std	hv$setv,y
   B15E 96 42         [ 4] 1610 	lda	*scrn$sts+1	; channel number
   B160 E6 A9 00 03   [ 8] 1611 	ldb	acq$sts,y
   B164 27 08         [ 3] 1612 	beq	27$
   B166 CA 04         [ 2] 1613 	orb	#$HOLD		; set the hold status
   B168 BD 8C 58      [ 8] 1614 	jsr	chng$sts	; change the status
   B16B BD 8C 73      [ 8] 1615 	jsr	wait$sts	; wait for change
   B16E 34 01         [ 6] 1616 27$:	pshs	cc
   B170 1A 50         [ 3] 1617 	orcc	#0q120
   B172 D6 42         [ 4] 1618 	ldb	*scrn$sts+1	; channel number
   B174 86 07         [ 2] 1619 	lda	#M16CxxS	; function
   B176 BD 92 FF      [ 8] 1620 	jsr	en$que
   B179 86 0B         [ 2] 1621 	lda	#M16WAIT	; function
   B17B BD 92 FF      [ 8] 1622 	jsr	en$que
   B17E 86 06         [ 2] 1623 	lda	#M16CxxG	; function
   B180 BD 92 FF      [ 8] 1624 	jsr	en$que
   B183 35 01         [ 6] 1625 	puls	cc
   B185 39            [ 5] 1626 28$:	rts
                           1627 
                           1628 
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 40
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

                           1629 	; chn$scrn  Update Routine
                           1630 	;
                           1631 	; The ordering of the updates is determined by
                           1632 	; the list chn$ntry
                           1633 
                           1634 	.area	SCRNUPDT
                           1635 
   D9DA                    1636 chn$updt::
   D9DA 96 42         [ 4] 1637 	lda	*scrn$sts+1	; get channel #
   D9DC 81 1F         [ 2] 1638 	cmpa	#0d31
   D9DE 10 22 01 C3   [ 6] 1639 	lbhi	16$
   D9E2 48            [ 2] 1640 	asla
   D9E3 10 8E 8C 16   [ 4] 1641 	ldy	#acqvtbl	; acquisition variable table
   D9E7 31 B6         [ 8] 1642 	leay	[a,y]		; this channels variables
                           1643 
                           1644 	; fill in HV Updating status / failure mode
                           1645 
   D9E9 A6 A9 00 13   [ 8] 1646 	lda	hvc$sts,y	; current status
   D9ED 48            [ 2] 1647 	asla
   D9EE 8E 9A 40      [ 3] 1648 	ldx	#hvc$optn	; table of pointers
   D9F1 30 96         [ 8] 1649 	leax	[a,x]
   D9F3 86 16         [ 2] 1650 	lda	#SCRNTP+0d22	; position
   D9F5 5F            [ 2] 1651 	clrb
   D9F6 BD 9D 9A      [ 8] 1652 	jsr	fmthtxt		; load current status
                           1653 
                           1654 	; Acquisition Status
                           1655 
   D9F9 8E AB CC      [ 3] 1656 	ldx	#chn$ntry	; sequence of entries
                           1657 
   D9FC EC 84         [ 5] 1658 	ldd	,x		; get entry
   D9FE CB 13         [ 2] 1659 	addb	#STS$POS	; position
   DA00 30 04         [ 5] 1660 	leax	4,x
   DA02 34 16         [ 8] 1661 	pshs	d,x
                           1662 
   DA04 A6 A9 00 03   [ 8] 1663 	lda	acq$sts,y
   DA08 84 0F         [ 2] 1664 	anda	#0x0F		; just acq status
   DA0A 48            [ 2] 1665 	asla
   DA0B 8E DB A6      [ 3] 1666 	ldx	#17$
   DA0E 30 96         [ 8] 1667 	leax	[a,x]
   DA10 35 06         [ 7] 1668 	puls	d
   DA12 BD 9D 9A      [ 8] 1669 	jsr	fmthtxt
   DA15 35 10         [ 6] 1670 	puls	x
                           1671 
                           1672 	; Pulse Height ADC Calibration Data
                           1673 
   DA17 EC 84         [ 5] 1674 	ldd	,x		; get entry
   DA19 CB 13         [ 2] 1675 	addb	#STS$POS	; position
   DA1B 30 04         [ 5] 1676 	leax	4,x
   DA1D 34 16         [ 8] 1677 	pshs	d,x
                           1678 
   DA1F A6 A9 00 03   [ 8] 1679 	lda	acq$sts,y
   DA23 84 0F         [ 2] 1680 	anda	#0x0F
   DA25 27 28         [ 3] 1681 	beq	2$
                           1682 
   DA27 AE A9 00 24   [ 9] 1683 	ldx	phs$lpht,y	; calibration ready ?
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 41
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

   DA2B 26 0F         [ 3] 1684 	bne	1$		; yes - use it
                           1685 				; else use updating value
                           1686 
                           1687 	; divide acq$sum by 64
                           1688 
   DA2D EC A9 00 00   [ 9] 1689 	ldd	acq$sum,y	; get sum
   DA31 59            [ 2] 1690 	rolb			; divide by 64
   DA32 49            [ 2] 1691 	rola
   DA33 59            [ 2] 1692 	rolb
   DA34 49            [ 2] 1693 	rola
   DA35 59            [ 2] 1694 	rolb
   DA36 1E 89         [ 8] 1695 	exg	a,b
   DA38 84 03         [ 2] 1696 	anda	#0x03
   DA3A 1F 01         [ 6] 1697 	tfr	d,x
                           1698 
   DA3C EC E4         [ 5] 1699 1$:	ldd	,s
   DA3E 34 10         [ 6] 1700 	pshs	x
   DA40 8E DC 21      [ 3] 1701 	ldx	#28$
   DA43 BD 9D 9A      [ 8] 1702 	jsr	fmthtxt		; clear old status
   DA46 35 10         [ 6] 1703 	puls	x
   DA48 35 06         [ 7] 1704 	puls	d
   DA4A BD 9E 9F      [ 8] 1705 	jsr	fmt6rjint
   DA4D 20 08         [ 3] 1706 	bra	3$
                           1707 
   DA4F 8E DC 21      [ 3] 1708 2$:	ldx	#28$		; inactive
   DA52 35 06         [ 7] 1709 	puls	d
   DA54 BD 9D 9A      [ 8] 1710 	jsr	fmthtxt
   DA57 35 10         [ 6] 1711 3$:	puls	x
                           1712 
                           1713 	; Temperature ADC Calibration Data
                           1714 
   DA59 EC 84         [ 5] 1715 	ldd	,x		; get entry
   DA5B CB 13         [ 2] 1716 	addb	#STS$POS	; position
   DA5D 30 04         [ 5] 1717 	leax	4,x
   DA5F 34 16         [ 8] 1718 	pshs	d,x
                           1719 
   DA61 A6 A9 00 03   [ 8] 1720 	lda	acq$sts,y
   DA65 84 0F         [ 2] 1721 	anda	#0x0F
   DA67 27 19         [ 3] 1722 	beq	4$
                           1723 
   DA69 A6 A9 00 11   [ 8] 1724 	lda	tmp$flag,y
   DA6D 27 13         [ 3] 1725 	beq	4$
                           1726 
   DA6F EC E4         [ 5] 1727 	ldd	,s
   DA71 8E DC 21      [ 3] 1728 	ldx	#28$
   DA74 BD 9D 9A      [ 8] 1729 	jsr	fmthtxt		; clear old status
   DA77 AE A9 00 28   [ 9] 1730 	ldx	tmp$lpht,y	; temperature
   DA7B 35 06         [ 7] 1731 	puls	d
   DA7D BD 9E 9F      [ 8] 1732 	jsr	fmt6rjint
   DA80 20 08         [ 3] 1733 	bra	5$
                           1734 
   DA82 8E DC 21      [ 3] 1735 4$:	ldx	#28$		; inactive
   DA85 35 06         [ 7] 1736 	puls	d
   DA87 BD 9D 9A      [ 8] 1737 	jsr	fmthtxt
   DA8A 35 10         [ 6] 1738 5$:	puls	x
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 42
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

                           1739 
                           1740 	; LED Drive ADC Data
                           1741 
   DA8C EC 84         [ 5] 1742 	ldd	,x		; get entry
   DA8E CB 13         [ 2] 1743 	addb	#STS$POS	; position
   DA90 30 04         [ 5] 1744 	leax	4,x
   DA92 34 16         [ 8] 1745 	pshs	d,x
                           1746 
   DA94 A6 A9 00 03   [ 8] 1747 	lda	acq$sts,y
   DA98 84 0F         [ 2] 1748 	anda	#0x0F
   DA9A 27 13         [ 3] 1749 	beq	6$
                           1750 
   DA9C EC E4         [ 5] 1751 	ldd	,s
   DA9E 8E DC 21      [ 3] 1752 	ldx	#28$
   DAA1 BD 9D 9A      [ 8] 1753 	jsr	fmthtxt		; clear old status
   DAA4 AE A9 00 26   [ 9] 1754 	ldx	cal$lpht,y	; LED Drive
   DAA8 35 06         [ 7] 1755 	puls	d
   DAAA BD 9E 9F      [ 8] 1756 	jsr	fmt6rjint
   DAAD 20 08         [ 3] 1757 	bra	7$
                           1758 
   DAAF 8E DC 21      [ 3] 1759 6$:	ldx	#28$		; inactive
   DAB2 35 06         [ 7] 1760 	puls	d
   DAB4 BD 9D 9A      [ 8] 1761 	jsr	fmthtxt
   DAB7 35 10         [ 6] 1762 7$:	puls	x
                           1763 
                           1764 	; Updating Pulse Height ADC Data
                           1765 
   DAB9 EC 84         [ 5] 1766 	ldd	,x		; get entry
   DABB CB 13         [ 2] 1767 	addb	#STS$POS	; position
   DABD 30 04         [ 5] 1768 	leax	4,x
   DABF 34 16         [ 8] 1769 	pshs	d,x
                           1770 
   DAC1 A6 A9 00 03   [ 8] 1771 	lda	acq$sts,y
   DAC5 84 0F         [ 2] 1772 	anda	#0x0F
   DAC7 27 13         [ 3] 1773 	beq	8$
                           1774 
   DAC9 EC E4         [ 5] 1775 	ldd	,s
   DACB 8E DC 21      [ 3] 1776 	ldx	#28$
   DACE BD 9D 9A      [ 8] 1777 	jsr	fmthtxt		; clear old status
   DAD1 35 06         [ 7] 1778 	puls	d
   DAD3 AE A9 00 04   [ 9] 1779 	ldx	phs$avrg,y	; get average of last scan
   DAD7 BD 9E 9F      [ 8] 1780 	jsr	fmt6rjint
   DADA 20 08         [ 3] 1781 	bra	9$
                           1782 
   DADC 8E DC 21      [ 3] 1783 8$:	ldx	#28$		; inactive
   DADF 35 06         [ 7] 1784 	puls	d
   DAE1 BD 9D 9A      [ 8] 1785 	jsr	fmthtxt
   DAE4 35 10         [ 6] 1786 9$:	puls	x
                           1787 
                           1788 	; Updating Temperature ADC Data
                           1789 
   DAE6 EC 84         [ 5] 1790 	ldd	,x		; get entry
   DAE8 CB 13         [ 2] 1791 	addb	#STS$POS	; position
   DAEA 30 04         [ 5] 1792 	leax	4,x
   DAEC 34 36         [ 9] 1793 	pshs	d,x,y
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 43
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

                           1794 
   DAEE A6 A9 00 03   [ 8] 1795 	lda	acq$sts,y
   DAF2 84 0F         [ 2] 1796 	anda	#0x0F
   DAF4 27 23         [ 3] 1797 	beq	10$
                           1798 
   DAF6 A6 A9 00 11   [ 8] 1799 	lda	tmp$flag,y
   DAFA 27 1D         [ 3] 1800 	beq	10$
                           1801 
   DAFC 10 8E 7D C1   [ 4] 1802 	ldy	#tmpvar
                           1803 
   DB00 A6 A9 00 11   [ 8] 1804 	lda	tmp$flag,y
   DB04 27 13         [ 3] 1805 	beq	10$
                           1806 
   DB06 EC E4         [ 5] 1807 	ldd	,s
   DB08 8E DC 21      [ 3] 1808 	ldx	#28$
   DB0B BD 9D 9A      [ 8] 1809 	jsr	fmthtxt		; clear old status
                           1810 
   DB0E 35 06         [ 7] 1811 	puls	d
   DB10 AE A9 00 04   [ 9] 1812 	ldx	phs$avrg,y	; get last scan
   DB14 BD 9E 9F      [ 8] 1813 	jsr	fmt6rjint
   DB17 20 08         [ 3] 1814 	bra	11$
                           1815 
   DB19 8E DC 21      [ 3] 1816 10$:	ldx	#28$		; inactive
   DB1C 35 06         [ 7] 1817 	puls	d
   DB1E BD 9D 9A      [ 8] 1818 	jsr	fmthtxt
   DB21 35 30         [ 7] 1819 11$:	puls	x,y
                           1820 
                           1821 	; Updating LED Drive ADC Data
                           1822 
   DB23 EC 84         [ 5] 1823 	ldd	,x		; get entry
   DB25 CB 13         [ 2] 1824 	addb	#STS$POS	; position
   DB27 30 04         [ 5] 1825 	leax	4,x
   DB29 34 16         [ 8] 1826 	pshs	d,x
                           1827 
   DB2B A6 A9 00 03   [ 8] 1828 	lda	acq$sts,y
   DB2F 84 0F         [ 2] 1829 	anda	#0x0F
   DB31 27 13         [ 3] 1830 	beq	12$
                           1831 
   DB33 EC E4         [ 5] 1832 	ldd	,s
   DB35 8E DC 21      [ 3] 1833 	ldx	#28$
   DB38 BD 9D 9A      [ 8] 1834 	jsr	fmthtxt		; clear old status
   DB3B AE A9 00 2A   [ 9] 1835 	ldx	cor$lpht,y	; LED Drive
   DB3F 35 06         [ 7] 1836 	puls	d
   DB41 BD 9E 9F      [ 8] 1837 	jsr	fmt6rjint
   DB44 20 08         [ 3] 1838 	bra	13$
                           1839 
   DB46 8E DC 21      [ 3] 1840 12$:	ldx	#28$		; inactive
   DB49 35 06         [ 7] 1841 	puls	d
   DB4B BD 9D 9A      [ 8] 1842 	jsr	fmthtxt
   DB4E 35 10         [ 6] 1843 13$:	puls	x
                           1844 
                           1845 	; fill in high voltage status
                           1846 
   DB50 EC 84         [ 5] 1847 	ldd	,x		; get entry
   DB52 CB 13         [ 2] 1848 	addb	#STS$POS	; position
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 44
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

   DB54 30 04         [ 5] 1849 	leax	4,x
   DB56 34 16         [ 8] 1850 	pshs	d,x
                           1851 
   DB58 A6 A9 00 12   [ 8] 1852 	lda	hv$sts,y
   DB5C 48            [ 2] 1853 	asla
   DB5D 8E DB C6      [ 3] 1854 	ldx	#18$
   DB60 30 96         [ 8] 1855 	leax	[a,x]
   DB62 35 06         [ 7] 1856 	puls	d
   DB64 BD 9D 9A      [ 8] 1857 	jsr	fmthtxt
   DB67 35 10         [ 6] 1858 	puls	x
                           1859 
                           1860 	; fill in high voltage read from HV4032A
                           1861 
   DB69 EC 84         [ 5] 1862 	ldd	,x		; get entry
   DB6B CB 13         [ 2] 1863 	addb	#STS$POS	; position
   DB6D 30 04         [ 5] 1864 	leax	4,x
   DB6F 34 16         [ 8] 1865 	pshs	d,x
                           1866 
   DB71 A6 A9 00 12   [ 8] 1867 	lda	hv$sts,y
   DB75 27 13         [ 3] 1868 	beq	14$		; ?
                           1869 
   DB77 EC E4         [ 5] 1870 	ldd	,s
   DB79 8E DC 21      [ 3] 1871 	ldx	#28$
   DB7C BD 9D 9A      [ 8] 1872 	jsr	fmthtxt		; clear old status
   DB7F AE A9 00 1A   [ 9] 1873 	ldx	hv$volt,y	; voltage
   DB83 35 06         [ 7] 1874 	puls	d
   DB85 BD 9E 9F      [ 8] 1875 	jsr	fmt6rjint
   DB88 20 08         [ 3] 1876 	bra	15$
                           1877 
   DB8A 8E DC 18      [ 3] 1878 14$:	ldx	#27$		; ?
   DB8D 35 06         [ 7] 1879 	puls	d
   DB8F BD 9D 9A      [ 8] 1880 	jsr	fmthtxt
   DB92 35 10         [ 6] 1881 15$:	puls	x
                           1882 
                           1883 	; fill in last high voltage set point
                           1884 
   DB94 EC 84         [ 5] 1885 	ldd	,x		; get entry
   DB96 CB 13         [ 2] 1886 	addb	#STS$POS	; position
   DB98 30 04         [ 5] 1887 	leax	4,x
   DB9A 34 10         [ 6] 1888 	pshs	x
                           1889 
   DB9C AE A9 00 1C   [ 9] 1890 	ldx	hv$setv,y	; voltage
   DBA0 BD 9E 9F      [ 8] 1891 	jsr	fmt6rjint
   DBA3 35 10         [ 6] 1892 	puls	x
                           1893 
   DBA5 39            [ 5] 1894 16$:	rts
                           1895 
                           1896 
                           1897 	; Acquisition Status Table
                           1898 
                           1899 				; 0bxxxxxxxx
                           1900 				;	|||`---- $SCAN
                           1901 				;	||`----- $FAILED
                           1902 				;	|`------ $HOLD
                           1903 				;	`------- $ACTIVE
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 45
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Channel Status Screen

   DBA6 DB D0              1904 17$:	.word	19$		;       0000	inactive
   DBA8 DB D9              1905 	.word	20$		;	0001	cal
   DBAA DB E2              1906 	.word	21$		;	0010	failed
   DBAC DB E2              1907 	.word	21$		;	0011	failed
   DBAE DB EB              1908 	.word	22$		;	0100	hold
   DBB0 DB EB              1909 	.word	22$		;	0101	hold
   DBB2 DB E2              1910 	.word	21$		;	0110	failed
   DBB4 DB E2              1911 	.word	21$		;	0111	failed
   DBB6 DB F4              1912 	.word	23$		;	1000	active
   DBB8 DB F4              1913 	.word	23$		;	1001	active
   DBBA DB E2              1914 	.word	21$		;	1010	failed
   DBBC DB E2              1915 	.word	21$		;	1011	failed
   DBBE DB EB              1916 	.word	22$		;	1100	hold
   DBC0 DB EB              1917 	.word	22$		;	1101	hold
   DBC2 DB E2              1918 	.word	21$		;	1110	failed
   DBC4 DB E2              1919 	.word	21$		;	1111	failed
                           1920 
                           1921 
                           1922 	; High-Voltage Status Table
                           1923 
   DBC6 DC 18              1924 18$:	.word	27$		; 0	?
   DBC8 DB FD              1925 	.word	24$		; 1	off
   DBCA DC 06              1926 	.word	25$		; 2	on
   DBCC DC 0F              1927 	.word	26$		; 3	zero
   DBCE DB E2              1928 	.word	21$		; 4	fail
                           1929 
                           1930 
   DBD0 49 6E 61 63 74 69  1931 19$:	.asciz	"Inactive"	; inactive
        76 65 00
   DBD9 20 20 20 43 61 6C  1932 20$:	.asciz	"   Cal  "
        20 20 00
   DBE2 20 20 46 61 69 6C  1933 21$:	.asciz	"  Fail  "
        20 20 00
   DBEB 20 20 48 6F 6C 64  1934 22$:	.asciz	"  Hold  "
        20 20 00
   DBF4 41 63 74 69 76 65  1935 23$:	.asciz	"Active  "
        20 20 00
   DBFD 20 20 20 4F 66 66  1936 24$:	.asciz	"   Off  "
        20 20 00
   DC06 20 20 20 20 4F 6E  1937 25$:	.asciz	"    On  "
        20 20 00
   DC0F 20 20 5A 65 72 6F  1938 26$:	.asciz	"  Zero  "
        20 20 00
   DC18 20 20 20 20 20 3F  1939 27$:	.asciz	"     ?  "
        20 20 00
   DC21 20 20 20 20 20 20  1940 28$:	.asciz	"        "
        20 20 00
                           1941 
                           1942 
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 46
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
High Voltage Update Screen

                           1944 	.sbttl	High Voltage Update Screen
                           1945 
                           1946 	.area	SCREEN
                           1947 
   B186                    1948 hvu$scrn::
   B186 34 36         [ 9] 1949 	pshs	d,x,y
                           1950 
   B188 D6 47         [ 4] 1951 1$:	ldb	*s$state	; check state
   B18A 27 14         [ 3] 1952 	beq	3$
   B18C 96 2F         [ 4] 1953 	lda	*char
   B18E 81 17         [ 2] 1954 	cmpa	#CTRLW		; redraw screen ?
   B190 26 06         [ 3] 1955 	bne	2$
   B192 6F E4         [ 6] 1956 	clr	,s		; CTRLW seen
   B194 C6 01         [ 2] 1957 	ldb	#1
   B196 D7 47         [ 4] 1958 	stb	*s$state	; new state
   B198 58            [ 2] 1959 2$:	aslb
   B199 C1 08         [ 2] 1960 	cmpb	#5$-4$		; check for valid state
   B19B 25 03         [ 3] 1961 	blo	3$
   B19D 5F            [ 2] 1962 	clrb
   B19E D7 47         [ 4] 1963 	stb	*s$state
   B1A0 8E B1 A5      [ 3] 1964 3$:	ldx	#4$
   B1A3 6E 95         [ 7] 1965 	jmp	[b,x]
                           1966 
   B1A5 B1 AD B1 B7 B1 DF  1967 4$:	.word	5$,6$,9$,10$
        B1 E9
                           1968 
   B1AD FC B2 9A      [ 6] 1969 5$:	ldd	r$hvu2		; default option position
   B1B0 BD A3 DD      [ 8] 1970 	jsr	init$opt
   B1B3 DD 45         [ 5] 1971 	std	*scrn$pos
   B1B5 0C 47         [ 6] 1972 	inc	*s$state	; next state
                           1973 
   B1B7 BD A3 AF      [ 8] 1974 6$:	jsr	clr$scrn	; clear the screen
   B1BA BD B2 11      [ 8] 1975 	jsr	hvu$page	; draw the page
                           1976 
   B1BD 0D 48         [ 6] 1977 	tst	*o$state	; active options sequence ?
   B1BF 27 1C         [ 3] 1978 	beq	8$		; no - skip
   B1C1 86 F9         [ 2] 1979 	lda	#ENTER		; redo question
   B1C3 BD B2 ED      [ 8] 1980 	jsr	hvu$ques
   B1C6 0D 59         [ 6] 1981 	tst	*s$strlen	; answer ?
   B1C8 27 13         [ 3] 1982 	beq	8$		; no - skip
   B1CA DC 45         [ 5] 1983 	ldd	*scrn$pos	; cursor position
   B1CC BD 9D 5E      [ 8] 1984 	jsr	fmtindex
   B1CF 30 C9 00 49   [ 8] 1985 	leax	s$string,u	; answer string
   B1D3 A6 80         [ 6] 1986 7$:	lda	,x+		; copy string
   B1D5 2F 06         [ 3] 1987 	ble	8$
   B1D7 A7 A0         [ 6] 1988 	sta	,y+
   B1D9 0C 46         [ 6] 1989 	inc	*scrn$pos+1	; update cursor position
   B1DB 20 F6         [ 3] 1990 	bra	7$
                           1991 
   B1DD 0C 47         [ 6] 1992 8$:	inc	*s$state	; next state
                           1993 
   B1DF BD B2 6F      [ 8] 1994 9$:	jsr	hvu$lgnd	; load up legends
   B1E2 DC 45         [ 5] 1995 	ldd	*scrn$pos	; reload cursor position
   B1E4 BD A3 CA      [ 8] 1996 	jsr	pos$scrn
   B1E7 0C 47         [ 6] 1997 	inc	*s$state	; next state
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 47
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
High Voltage Update Screen

                           1998 
   B1E9 0D 48         [ 6] 1999 10$:	tst	*o$state	; processing an option ?
   B1EB 27 13         [ 3] 2000 	beq	11$		; no  - skip
                           2001 
   B1ED 96 2F         [ 4] 2002 	lda	*char		; get the character
   B1EF BD B3 71      [ 8] 2003 	jsr	hvu$optn	; yes - service the option
   B1F2 97 2F         [ 4] 2004 	sta	*char		; character used
                           2005 
   B1F4 0D 47         [ 6] 2006 	tst	*s$state	; exit screen ?
   B1F6 27 16         [ 3] 2007 	beq	12$		; yes - doit
                           2008 
   B1F8 0D 48         [ 6] 2009 	tst	*o$state	; processing finished ?
   B1FA 10 27 FF 8A   [ 6] 2010 	lbeq	1$		; yes - rescan new settup
   B1FE 20 0E         [ 3] 2011 	bra	12$
                           2012 
   B200 96 2F         [ 4] 2013 11$:	lda	*char
   B202 BD A4 81      [ 8] 2014 	jsr	scn$scrl	; try scrolling to a new option
   B205 97 2F         [ 4] 2015 	sta	*char
   B207 27 05         [ 3] 2016 	beq	12$
   B209 BD B2 ED      [ 8] 2017 	jsr	hvu$ques	; try selecting an option
   B20C 97 2F         [ 4] 2018 	sta	*char
                           2019 
   B20E 35 36         [ 9] 2020 12$:	puls	d,x,y
   B210 39            [ 5] 2021 	rts
                           2022 
                           2023 
                           2024 	; hvu$scrn  Page Outline
                           2025 
   B211                    2026 hvu$page::
   B211 10 8E B2 21   [ 4] 2027 	ldy	#3$
   B215 EC A1         [ 8] 2028 1$:	ldd	,y++
   B217 AE A1         [ 8] 2029 	ldx	,y++
   B219 27 05         [ 3] 2030 	beq	2$
   B21B BD 9D 9A      [ 8] 2031 	jsr	fmthtxt
   B21E 20 F5         [ 3] 2032 	bra	1$
                           2033 
   B220 39            [ 5] 2034 2$:	rts
                           2035 
                           2036 
   B221 04 00              2037 3$:	.byte	SCRNTP+4,	0
   B223 B2 45              2038 	.word	4$
   B225 05 00              2039 	.byte	SCRNTP+5,	0
   B227 B2 5A              2040 	.word	5$
   B229 04 14              2041 	.byte	SCRNTP+4,	20
   B22B B2 45              2042 	.word	4$
   B22D 05 14              2043 	.byte	SCRNTP+5,	20
   B22F B2 5A              2044 	.word	5$
   B231 04 28              2045 	.byte	SCRNTP+4,	40
   B233 B2 45              2046 	.word	4$
   B235 05 28              2047 	.byte	SCRNTP+5,	40
   B237 B2 5A              2048 	.word	5$
   B239 04 3C              2049 	.byte	SCRNTP+4,	60
   B23B B2 45              2050 	.word	4$
   B23D 05 3C              2051 	.byte	SCRNTP+5,	60
   B23F B2 5A              2052 	.word	5$
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 48
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
High Voltage Update Screen

   B241 00 00 00 00        2053 	.word	0,0
                           2054 
                           2055 	;	 0123456789012345678901234567890123456789"
   B245 20 20 20 56 4C 54  2056 4$:	.asciz	"   VLTG  DAY/TIME   "
        47 20 20 44 41 59
        2F 54 49 4D 45 20
        20 20 00
   B25A 20 20 20 2D 2D 2D  2057 5$:	.asciz	"   ----  --------   "
        2D 20 20 2D 2D 2D
        2D 2D 2D 2D 2D 20
        20 20 00
                           2058 
                     0001  2059 	$VLTG		=	0d1
                     0009  2060 	$DAYTIME	=	0d9
                           2061 
                           2062 
                           2063 	;
                           2064 	; hvu$scrn Legends
                           2065 	;
                           2066 
   B26F                    2067 hvu$lgnd::
   B26F 34 16         [ 8] 2068 	pshs	d,x
                           2069 
   B271 96 42         [ 4] 2070 	lda	*scrn$sts+1	; channel number
   B273 81 1F         [ 2] 2071 	cmpa	#0d31		; valid LED channel ?
   B275 23 07         [ 3] 2072 	blos	1$		; yes - skip
   B277 81 20         [ 2] 2073 	cmpa	#0d32		; valid channel ?
   B279 22 0C         [ 3] 2074 	bhi	2$		; no - exit
   B27B 4F            [ 2] 2075 	clra			; set to channel 0		
   B27C 97 42         [ 4] 2076 	sta	*scrn$sts+1
   B27E 8E B2 8A      [ 3] 2077 1$:	ldx	#3$
   B281 BD A4 B4      [ 8] 2078 	jsr	scn$lgnd	; do legends
   B284 BD A4 EB      [ 8] 2079 	jsr	scn$chnl	; and channel
                           2080 
   B287 35 16         [ 8] 2081 2$:	puls	d,x
   B289 39            [ 5] 2082 	rts
                           2083 
                           2084 
   B28A B2 A6 B2 A0 B2 9A  2085 3$:	.word	n$hvu4,	n$hvu3,	r$hvu2,	r$hvu1,	0
        B2 94 00 00
                           2086 
                           2087 	;	row		column		video		option
                           2088 	;-------------------------------------------------------------
   B294                    2089 r$hvu1:
   B294 00 03 80 01        2090 	.byte	SCRNTP+0d0,	3,		REVERSE,	1
   B298 B2 AC              2091 	.word	1$		; "Channel #"
                     0D74  2092 r$hvu2	= .
   B29A 02 03 80 02        2093 	.byte	SCRNTP+0d2,	3,		REVERSE,	2
   B29E B2 B8              2094 	.word	2$		; "Exit"
                     0D7A  2095 n$hvu3	= .
   B2A0 00 1F 00 00        2096 	.byte	SCRNTP+0d0,	0d31,		NORMAL,		0
   B2A4 B2 C4              2097 	.word	3$		; "High Voltage Updates"
                     0D80  2098 n$hvu4	= .
   B2A6 02 1F 00 00        2099 	.byte	SCRNTP+0d2,	0d31,		NORMAL,		0
   B2AA B2 D9              2100 	.word	4$		; " Current DAY/TIME ="
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 49
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
High Voltage Update Screen

                           2101 
   B2AC 43 68 61 6E 6E 65  2102 1$:	.asciz	"Channel #  "		; 1
        6C 20 23 20 20 00
   B2B8 45 78 69 74 20 53  2103 2$:	.asciz	"Exit Screen"		; 2
        63 72 65 65 6E 00
   B2C4 48 69 67 68 20 56  2104 3$:	.asciz	"High Voltage Updates"
        6F 6C 74 61 67 65
        20 55 70 64 61 74
        65 73 00
   B2D9 43 75 72 72 65 6E  2105 4$:	.asciz	"Current DAY/TIME = "
        74 20 44 41 59 2F
        54 49 4D 45 20 3D
        20 00
                           2106 
                     0013  2107 	$CDAYTIM  =  0d19		; offset
                           2108 
                           2109 
                           2110 	;
                           2111 	; hvu$scrn Questions
                           2112 	;
                           2113 
   B2ED                    2114 hvu$ques::
   B2ED 81 F9         [ 2] 2115 	cmpa	#ENTER		; selecting ?
   B2EF 26 37         [ 3] 2116 	bne	5$		; no - exit
                           2117 
   B2F1 34 34         [ 8] 2118 	pshs	b,x,y
                           2119 
   B2F3 86 17         [ 2] 2120 	lda	#SCRNBT		; common question position
   B2F5 C6 00         [ 2] 2121 	ldb	#0
   B2F7 BD 9D 5E      [ 8] 2122 	jsr	fmtindex
                           2123 
   B2FA 30 C9 00 5A   [ 8] 2124 	leax	optarray,u	; get option
   B2FE D6 72         [ 4] 2125 	ldb	*opt$posn
   B300 E6 85         [ 5] 2126 	ldb	b,x
                           2127 
   B302 C1 02         [ 2] 2128 	cmpb	#2		; exiting this screen ?
   B304 26 02         [ 3] 2129 	bne	1$		; no - skip
   B306 0F 47         [ 6] 2130 	clr	*s$state	; yes
                           2131 
   B308 58            [ 2] 2132 1$:	aslb
   B309 C1 06         [ 2] 2133 	cmpb	#7$-6$		; valid option ?
   B30B 24 18         [ 3] 2134 	bhis	4$		; no - exit
   B30D 8E B3 29      [ 3] 2135 	ldx	#6$
   B310 30 95         [ 8] 2136 	leax	[b,x]
   B312 A6 80         [ 6] 2137 2$:	lda	,x+
   B314 27 06         [ 3] 2138 	beq	3$
   B316 A7 A0         [ 6] 2139 	sta	,y+
   B318 0C 75         [ 6] 2140 	inc	*fmtcol		; next column
   B31A 20 F6         [ 3] 2141 	bra	2$
                           2142 
   B31C DC 74         [ 5] 2143 3$:	ldd	*fmtrow		; load new cursor position
   B31E BD A3 CA      [ 8] 2144 	jsr	pos$scrn
   B321 86 01         [ 2] 2145 	lda	#1		; option processing
   B323 97 48         [ 4] 2146 	sta	*o$state
   B325 4F            [ 2] 2147 4$:	clra			; dump character
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 50
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
High Voltage Update Screen

   B326 35 34         [ 8] 2148 	puls	b,x,y
   B328 39            [ 5] 2149 5$:	rts
                           2150 
                           2151 
   B329 B3 2F B3 3E B3 55  2152 6$:	.word	7$,8$,9$
                           2153 
   B32F 49 6E 76 61 6C 69  2154 7$:	.asciz	"Invalid Option"
        64 20 4F 70 74 69
        6F 6E 00
   B33E 53 65 6C 65 63 74  2155 8$:	.asciz	"Select New Channel -> "			; 1
        20 4E 65 77 20 43
        68 61 6E 6E 65 6C
        20 2D 3E 20 00
   B355 2E 2E 2E 20 45 78  2156 9$:	.asciz	"... Exiting this Screen ..."			; 2
        69 74 69 6E 67 20
        74 68 69 73 20 53
        63 72 65 65 6E 20
        2E 2E 2E 00
                           2157 
                           2158 
                           2159 	;
                           2160 	; hvu$scrn Options
                           2161 	;
                           2162 
   B371                    2163 hvu$optn::
   B371 BD A4 0E      [ 8] 2164 	jsr	scn$gets	; build a response string
   B374 27 33         [ 3] 2165 	beq	3$		; not finished
   B376 0D 49         [ 6] 2166 	tst	*s$string	; NULL string ?
   B378 2F 21         [ 3] 2167 	ble	2$		; yes - terminate option
                           2168 
   B37A BD A3 F8      [ 8] 2169 	jsr	option		; get the option number
   B37D 58            [ 2] 2170 	aslb
   B37E C1 06         [ 2] 2171 	cmpb	#5$-4$		; valid option ?
   B380 24 19         [ 3] 2172 	bhis	2$		; no - terminate request
                           2173 
   B382 10 8E B3 9B   [ 4] 2174 	ldy	#2$		; options return address
   B386 34 20         [ 6] 2175 	pshs	y
                           2176 
   B388 10 8E B3 AB   [ 4] 2177 	ldy	#4$		; jump table
   B38C 31 B5         [ 8] 2178 	leay	[b,y]		; get address of option routine
   B38E 34 20         [ 6] 2179 	pshs	y		; push as a return address
                           2180 
   B390 30 C9 00 49   [ 8] 2181 	leax	s$string,u	; string pointer
                           2182 
   B394 10 8E 8C 16   [ 4] 2183 	ldy	#acqvtbl	; variables address for this channel
   B398 31 B6         [ 8] 2184 	leay	[a,y]
                           2185 
   B39A 39            [ 5] 2186 1$:	rts			; do option
                           2187 
   B39B 0F 48         [ 6] 2188 2$:	clr	*o$state	; option completed
   B39D 86 17         [ 2] 2189 	lda	#SCRNBT
   B39F C6 00         [ 2] 2190 	ldb	#0
   B3A1 BD 9D 75      [ 8] 2191 	jsr	fmtdeol		; clear option question and answer
                           2192 
   B3A4 DC 72         [ 5] 2193 	ldd	*opt$posn	; option position
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 51
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
High Voltage Update Screen

   B3A6 BD A3 CA      [ 8] 2194 	jsr	pos$scrn	; restore cursor
                           2195 
   B3A9 4F            [ 2] 2196 3$:	clra			; input character always used
   B3AA 39            [ 5] 2197 	rts
                           2198 
   B3AB B3 9A              2199 4$:	.word	1$		; invalid option
   B3AD B3 B1              2200 	.word	5$		; channel #
   B3AF B3 BF              2201 	.word	7$		; exit screen
                           2202 
                           2203 	; New Channel Number
                           2204 
   B3B1 BD E3 34      [ 8] 2205 5$:	jsr	a$d$i		; convert to an integer
   B3B4 C1 1F         [ 2] 2206 	cmpb	#0d31		; valid ?
   B3B6 22 06         [ 3] 2207 	bhi	6$		; no - skip
   B3B8 D7 42         [ 4] 2208 	stb	*scrn$sts+1	; save new channel #
   B3BA 86 02         [ 2] 2209 	lda	#2		; redraw legends
   B3BC 97 47         [ 4] 2210 	sta	*s$state	
   B3BE 39            [ 5] 2211 6$:	rts
                           2212 
                           2213 	; Exit Screen
                           2214 
   B3BF BD A4 05      [ 8] 2215 7$:	jsr	ans$yes
   B3C2 26 02         [ 3] 2216 	bne	8$
   B3C4 0F 47         [ 6] 2217 	clr	*s$state	; just exit
   B3C6 39            [ 5] 2218 8$:	rts
                           2219 
                           2220 
                           2221 	; hvu$scrn  Update Routine
                           2222 
                           2223 	.area	SCRNUPDT
                           2224 
   DC2A                    2225 hvu$updt::
   DC2A 34 36         [ 9] 2226 	pshs	d,x,y
                           2227 
   DC2C 96 42         [ 4] 2228 	lda	*scrn$sts+1	; channel #
   DC2E 81 1F         [ 2] 2229 	cmpa	#0d31		; only LED channels allowed
   DC30 10 22 00 9F   [ 6] 2230 	lbhi	5$
   DC34 48            [ 2] 2231 	asla
   DC35 8E 8B D4      [ 3] 2232 	ldx	#acqbtbl	; acquisition buffers
   DC38 30 96         [ 8] 2233 	leax	[a,x]
   DC3A 10 8E 8C 16   [ 4] 2234 	ldy	#acqvtbl	; acquisition variables
   DC3E 31 B6         [ 8] 2235 	leay	[a,y]
                           2236 
                           2237 	; show current DAY/TIME
                           2238 
   DC40 B6 37 22      [ 5] 2239 	lda	days		; compute time
   DC43 C6 05         [ 2] 2240 	ldb	#0d5		; 1440. * days
   DC45 3D            [11] 2241 	mul			; days <= 44.
   DC46 1E 89         [ 8] 2242 	exg	a,b
   DC48 ED E3         [ 8] 2243 	std	,--s
   DC4A B6 37 22      [ 5] 2244 	lda	days
   DC4D C6 A0         [ 2] 2245 	ldb	#0d160
   DC4F 3D            [11] 2246 	mul
   DC50 E3 E4         [ 6] 2247 	addd	,s
   DC52 ED E4         [ 5] 2248 	std	,s
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 52
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
High Voltage Update Screen

   DC54 B6 37 21      [ 5] 2249 	lda	hours
   DC57 C6 3C         [ 2] 2250 	ldb	#0d60		; 60. * hours
   DC59 3D            [11] 2251 	mul
   DC5A E3 E1         [ 9] 2252 	addd	,s++
   DC5C FB 37 20      [ 5] 2253 	addb	minutes
   DC5F 89 00         [ 2] 2254 	adca	#0
                           2255 
   DC61 34 10         [ 6] 2256 	pshs	x
   DC63 32 76         [ 5] 2257 	leas	-0d10,s		; buffer
   DC65 1F 41         [ 6] 2258 	tfr	s,x
   DC67 BD DC D6      [ 8] 2259 	jsr	i$tw$dt
                           2260 
   DC6A FC B2 A6      [ 6] 2261 	ldd	n$hvu4		; get position
   DC6D CB 13         [ 2] 2262 	addb	#$CDAYTIM
   DC6F 1F 41         [ 6] 2263 	tfr	s,x
   DC71 BD 9D 9A      [ 8] 2264 	jsr	fmthtxt
   DC74 32 6A         [ 5] 2265 	leas	0d10,s
   DC76 35 10         [ 6] 2266 	puls	x
                           2267 
                           2268 	; list all updates
                           2269 
   DC78 A6 A9 00 14   [ 8] 2270 	lda	hv$index,y	; next update index
   DC7C 4A            [ 2] 2271 	deca
   DC7D 2A 02         [ 3] 2272 	bpl	1$	
   DC7F 86 3F         [ 2] 2273 	lda	#0d63
   DC81 A7 A9 00 10   [ 8] 2274 1$:	sta	run$index,y	; last voltage update
                           2275 
   DC85 86 06         [ 2] 2276 	lda	#SCRNTP+0d6	; screen position
   DC87 C6 00         [ 2] 2277 	ldb	#0
                           2278 
   DC89 34 16         [ 8] 2279 2$:	pshs	d,x
                           2280 
   DC8B CB 01         [ 2] 2281 	addb	#$VLTG
   DC8D AE 89 01 00   [ 9] 2282 	ldx	acq$vltg,x	; voltage
   DC91 BD 9E 9F      [ 8] 2283 	jsr	fmt6rjint
                           2284 
   DC94 AE 62         [ 6] 2285 	ldx	2,s
                           2286 
   DC96 EC 89 01 80   [ 9] 2287 	ldd	acq$time,x
   DC9A 32 76         [ 5] 2288 	leas	-0d10,s		; buffer
   DC9C 1F 41         [ 6] 2289 	tfr	s,x
   DC9E BD DC D6      [ 8] 2290 	jsr	i$tw$dt
                           2291 
   DCA1 6D A9 00 10   [10] 2292 	tst	run$index,y
   DCA5 26 0C         [ 3] 2293 	bne	4$
                           2294 
   DCA7 1F 41         [ 6] 2295 	tfr	s,x
   DCA9 A6 84         [ 4] 2296 3$:	lda	,x
   DCAB 2F 06         [ 3] 2297 	ble	4$
   DCAD 8A 80         [ 2] 2298 	ora	#REVERSE	; REVERSE Video
   DCAF A7 80         [ 6] 2299 	sta	,x+
   DCB1 20 F6         [ 3] 2300 	bra	3$
                           2301 
   DCB3 EC 6A         [ 6] 2302 4$:	ldd	0d10,s		; get position
   DCB5 CB 09         [ 2] 2303 	addb	#$DAYTIME
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 53
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
High Voltage Update Screen

   DCB7 1F 41         [ 6] 2304 	tfr	s,x
   DCB9 BD 9D 9A      [ 8] 2305 	jsr	fmthtxt
   DCBC 32 6A         [ 5] 2306 	leas	0d10,s
                           2307 
   DCBE 35 16         [ 8] 2308 	puls	d,x
                           2309 
   DCC0 30 02         [ 5] 2310 	leax	2,x		; next element
   DCC2 6A A9 00 10   [10] 2311 	dec	run$index,y
   DCC6 4C            [ 2] 2312 	inca			; next row
   DCC7 81 16         [ 2] 2313 	cmpa	#SCRNTP+0d6+0d16
   DCC9 26 BE         [ 3] 2314 	bne	2$
   DCCB 86 06         [ 2] 2315 	lda	#SCRNTP+0d6
   DCCD CB 14         [ 2] 2316 	addb	#0d20		; next column
   DCCF C1 50         [ 2] 2317 	cmpb	#0d80
   DCD1 26 B6         [ 3] 2318 	bne	2$
                           2319 
   DCD3 35 36         [ 9] 2320 5$:	puls	d,x,y
   DCD5 39            [ 5] 2321 	rts
                           2322 
                           2323 
                           2324 	.sbttl	Time Word to Date and Time Conversion
                           2325 
                           2326 	; Integer is converted to 00/00:00 format
                           2327 	;			  DA/HR:MN
                           2328 
   DCD6                    2329 i$tw$dt::
   DCD6 34 26         [ 8] 2330 	pshs	d,y
   DCD8 DD 3F         [ 5] 2331 	std	*i$data		; save date
   DCDA C6 07         [ 2] 2332 	ldb	#8-1		; 8 characters for conversion
   DCDC D7 3C         [ 4] 2333 	stb	*i$ndgt
   DCDE 10 8E DD 12   [ 4] 2334 	ldy	#6$
                           2335 
   DCE2 DC 3F         [ 5] 2336 1$:	ldd	*i$data		; get data
   DCE4 0F 3D         [ 6] 2337 	clr	*i$dcnt		; initialize counter
                           2338 
   DCE6 10 A3 A1      [10] 2339 2$:	cmpd	,y++		; trial
   DCE9 25 06         [ 3] 2340 	blo	3$		; ok - skip
   DCEB A3 A3         [ 9] 2341 	subd	,--y
   DCED 0C 3D         [ 6] 2342 	inc	*i$dcnt		; one more count
   DCEF 20 F5         [ 3] 2343 	bra	2$
                           2344 
   DCF1 DD 3F         [ 5] 2345 3$:	std	*i$data
   DCF3 6D 3E         [ 7] 2346 	tst	-2,y		; special option in table ?
   DCF5 2A 04         [ 3] 2347 	bpl	4$		; no - skip
   DCF7 E6 3F         [ 5] 2348 	ldb	-1,y		; get character
   DCF9 20 04         [ 3] 2349 	bra	5$
                           2350 
   DCFB D6 3D         [ 4] 2351 4$:	ldb	*i$dcnt		; convert count to ascii character
   DCFD CB 30         [ 2] 2352 	addb	#'0
   DCFF E7 80         [ 6] 2353 5$:	stb	,x+		; place character
   DD01 0A 3C         [ 6] 2354 	dec	*i$ndgt		; any more ?
   DD03 2E DD         [ 3] 2355 	bgt	1$		; yes - loop
   DD05 D6 40         [ 4] 2356 	ldb	*i$data+1	; last digit
   DD07 CB 30         [ 2] 2357 	addb	#'0
   DD09 E7 80         [ 6] 2358 	stb	,x+
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 54
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Time Word to Date and Time Conversion

   DD0B C6 80         [ 2] 2359 	ldb	#0q200
   DD0D E7 84         [ 4] 2360 	stb	,x		; terminator
                           2361 
   DD0F 35 26         [ 8] 2362 	puls	d,y
   DD11 39            [ 5] 2363 	rts
                           2364 
                           2365 	; conversion table
                           2366 
   DD12 38 40              2367 6$:	.word	0d14400		; 10 days
   DD14 05 A0              2368 	.word	0d1440		;  1 day
   DD16 FF 2F              2369 	.word	0xFF00 + '/	;  /
   DD18 02 58              2370 	.word	0d600		; 10 hours
   DD1A 00 3C              2371 	.word	0d60		;  1 hour
   DD1C FF 3A              2372 	.word	0xFF00 + ':	;  :
   DD1E 00 0A              2373 	.word	0d10		; 10 minutes
                           2374 
                           2375 
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 55
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Stabilization Parameters Screen

                           2377 	.sbttl	Stabilization Parameters Screen
                           2378 
                           2379 	.area	SCREEN
                           2380 
   B3C7                    2381 prm$scrn::
   B3C7 34 36         [ 9] 2382 	pshs	d,x,y
                           2383 
   B3C9 D6 47         [ 4] 2384 1$:	ldb	*s$state	; check state
   B3CB 27 14         [ 3] 2385 	beq	3$
   B3CD 96 2F         [ 4] 2386 	lda	*char
   B3CF 81 17         [ 2] 2387 	cmpa	#CTRLW		; redraw screen ?
   B3D1 26 06         [ 3] 2388 	bne	2$
   B3D3 6F E4         [ 6] 2389 	clr	,s		; CTRLW seen
   B3D5 C6 01         [ 2] 2390 	ldb	#1
   B3D7 D7 47         [ 4] 2391 	stb	*s$state	; new state
   B3D9 58            [ 2] 2392 2$:	aslb
   B3DA C1 08         [ 2] 2393 	cmpb	#5$-4$		; check for valid state
   B3DC 25 03         [ 3] 2394 	blo	3$
   B3DE 5F            [ 2] 2395 	clrb
   B3DF D7 47         [ 4] 2396 	stb	*s$state
   B3E1 8E B3 E6      [ 3] 2397 3$:	ldx	#4$
   B3E4 6E 95         [ 7] 2398 	jmp	[b,x]
                           2399 
   B3E6 B3 EE B3 F8 B4 20  2400 4$:	.word	5$,6$,9$,10$
        B4 2A
                           2401 
   B3EE FC B6 8E      [ 6] 2402 5$:	ldd	r$prm3		; default option position
   B3F1 BD A3 DD      [ 8] 2403 	jsr	init$opt
   B3F4 DD 45         [ 5] 2404 	std	*scrn$pos
   B3F6 0C 47         [ 6] 2405 	inc	*s$state	; next state
                           2406 
   B3F8 BD A3 AF      [ 8] 2407 6$:	jsr	clr$scrn	; clear the screen
   B3FB BD B4 52      [ 8] 2408 	jsr	prm$page	; draw the page
                           2409 
   B3FE 0D 48         [ 6] 2410 	tst	*o$state	; active options sequence ?
   B400 27 1C         [ 3] 2411 	beq	8$		; no - skip
   B402 86 F9         [ 2] 2412 	lda	#ENTER		; redo question
   B404 BD B7 4B      [ 8] 2413 	jsr	prm$ques
   B407 0D 59         [ 6] 2414 	tst	*s$strlen	; answer ?
   B409 27 13         [ 3] 2415 	beq	8$		; no - skip
   B40B DC 45         [ 5] 2416 	ldd	*scrn$pos	; cursor position
   B40D BD 9D 5E      [ 8] 2417 	jsr	fmtindex
   B410 30 C9 00 49   [ 8] 2418 	leax	s$string,u	; answer string
   B414 A6 80         [ 6] 2419 7$:	lda	,x+		; copy string
   B416 2F 06         [ 3] 2420 	ble	8$
   B418 A7 A0         [ 6] 2421 	sta	,y+
   B41A 0C 46         [ 6] 2422 	inc	*scrn$pos+1	; update cursor position
   B41C 20 F6         [ 3] 2423 	bra	7$
                           2424 
   B41E 0C 47         [ 6] 2425 8$:	inc	*s$state	; next state
                           2426 
   B420 BD B6 66      [ 8] 2427 9$:	jsr	prm$lgnd	; load up legends
   B423 DC 45         [ 5] 2428 	ldd	*scrn$pos	; reload cursor position
   B425 BD A3 CA      [ 8] 2429 	jsr	pos$scrn
   B428 0C 47         [ 6] 2430 	inc	*s$state	; next state
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 56
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Stabilization Parameters Screen

                           2431 
   B42A 0D 48         [ 6] 2432 10$:	tst	*o$state	; processing an option ?
   B42C 27 13         [ 3] 2433 	beq	11$		; no  - skip
                           2434 
   B42E 96 2F         [ 4] 2435 	lda	*char		; get the character
   B430 BD B8 68      [ 8] 2436 	jsr	prm$optn	; yes - service the option
   B433 97 2F         [ 4] 2437 	sta	*char		; character used
                           2438 
   B435 0D 47         [ 6] 2439 	tst	*s$state	; exit screen ?
   B437 27 16         [ 3] 2440 	beq	12$		; yes - doit
                           2441 
   B439 0D 48         [ 6] 2442 	tst	*o$state	; processing finished ?
   B43B 10 27 FF 8A   [ 6] 2443 	lbeq	1$		; yes - rescan new settup
   B43F 20 0E         [ 3] 2444 	bra	12$
                           2445 
   B441 96 2F         [ 4] 2446 11$:	lda	*char
   B443 BD A4 81      [ 8] 2447 	jsr	scn$scrl	; try scrolling to a new option
   B446 97 2F         [ 4] 2448 	sta	*char
   B448 27 05         [ 3] 2449 	beq	12$
   B44A BD B7 4B      [ 8] 2450 	jsr	prm$ques	; try selecting an option
   B44D 97 2F         [ 4] 2451 	sta	*char
                           2452 
   B44F 35 36         [ 9] 2453 12$:	puls	d,x,y
   B451 39            [ 5] 2454 	rts
                           2455 
                           2456 
                           2457 	; prm$scrn  Page Outline
                           2458 
   B452                    2459 prm$page::
   B452 34 36         [ 9] 2460 	pshs	d,x,y
                           2461 
   B454 8E B4 6E      [ 3] 2462 	ldx	#3$
   B457 86 05         [ 2] 2463 	lda	#SCRNTP+0d6-0d1	; top of screen
   B459 C6 08         [ 2] 2464 	ldb	#0d8
                           2465 
   B45B 4C            [ 2] 2466 1$:	inca
   B45C 34 06         [ 7] 2467 	pshs	d
   B45E BD 9D 9A      [ 8] 2468 	jsr	fmthtxt
   B461 35 06         [ 7] 2469 	puls	d
   B463 6D 80         [ 8] 2470 2$:	tst	,x+		; skip to end of line
   B465 2E FC         [ 3] 2471 	bgt	2$
   B467 6D 84         [ 6] 2472 	tst	,x		; end of text ?
   B469 2A F0         [ 3] 2473 	bpl	1$
                           2474 
   B46B 35 36         [ 9] 2475 	puls	d,x,y
   B46D 39            [ 5] 2476 	rts
                           2477 
   B46E 20 20 54 68 72 65  2478 3$:	.asciz	"  Three parameters are required by the P.H.S. system to"
        65 20 70 61 72 61
        6D 65 74 65 72 73
        20 61 72 65 20 72
        65 71 75 69 72 65
        64 20 62 79 20 74
        68 65 20 50 2E 48
        2E 53 2E 20 73 79
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 57
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Stabilization Parameters Screen

        73 74 65 6D 20 74
        6F 00
   B4A6 70 65 72 66 6F 72  2479 	.asciz	"perform the stabilization function:"
        6D 20 74 68 65 20
        73 74 61 62 69 6C
        69 7A 61 74 69 6F
        6E 20 66 75 6E 63
        74 69 6F 6E 3A 00
   B4CA 00                 2480 .asciz	""
   B4CB 20 20 28 31 29 20  2481 .asciz	"  (1)  A value specifying the change in high-voltage required"
        20 41 20 76 61 6C
        75 65 20 73 70 65
        63 69 66 79 69 6E
        67 20 74 68 65 20
        63 68 61 6E 67 65
        20 69 6E 20 68 69
        67 68 2D 76 6F 6C
        74 61 67 65 20 72
        65 71 75 69 72 65
        64 00
   B509 20 20 20 20 20 20  2482 .asciz	"       to produce a 10% change in the detector response"
        20 74 6F 20 70 72
        6F 64 75 63 65 20
        61 20 31 30 25 20
        63 68 61 6E 67 65
        20 69 6E 20 74 68
        65 20 64 65 74 65
        63 74 6F 72 20 72
        65 73 70 6F 6E 73
        65 00
   B541 20 20 20 20 20 20  2483 .asciz	"       (the default is 25 volts / 10%)."
        20 28 74 68 65 20
        64 65 66 61 75 6C
        74 20 69 73 20 32
        35 20 76 6F 6C 74
        73 20 2F 20 31 30
        25 29 2E 00
   B569 00                 2484 .asciz	""
   B56A 20 20 28 32 29 20  2485 .asciz	"  (2)  A value specifying the minimum voltage change required before"
        20 41 20 76 61 6C
        75 65 20 73 70 65
        63 69 66 79 69 6E
        67 20 74 68 65 20
        6D 69 6E 69 6D 75
        6D 20 76 6F 6C 74
        61 67 65 20 63 68
        61 6E 67 65 20 72
        65 71 75 69 72 65
        64 20 62 65 66 6F
        72 65 00
   B5AF 20 20 20 20 20 20  2486 .asciz	"       an update will be performed (the default is 5 volts)."
        20 61 6E 20 75 70
        64 61 74 65 20 77
        69 6C 6C 20 62 65
        20 70 65 72 66 6F
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 58
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Stabilization Parameters Screen

        72 6D 65 64 20 28
        74 68 65 20 64 65
        66 61 75 6C 74 20
        69 73 20 35 20 76
        6F 6C 74 73 29 2E
        00
   B5EC 00                 2487 .asciz	""
   B5ED 20 20 28 33 29 20  2488 .asciz	"  (3)  A value specifying the single step voltage change"
        20 41 20 76 61 6C
        75 65 20 73 70 65
        63 69 66 79 69 6E
        67 20 74 68 65 20
        73 69 6E 67 6C 65
        20 73 74 65 70 20
        76 6F 6C 74 61 67
        65 20 63 68 61 6E
        67 65 00
   B626 20 20 20 20 20 20  2489 .asciz	"       indicating a channel failure (the default is 64 volts)."
        20 69 6E 64 69 63
        61 74 69 6E 67 20
        61 20 63 68 61 6E
        6E 65 6C 20 66 61
        69 6C 75 72 65 20
        28 74 68 65 20 64
        65 66 61 75 6C 74
        20 69 73 20 36 34
        20 76 6F 6C 74 73
        29 2E 00
   B665 80                 2490 .byte	0q200
                           2491 
                           2492 	;
                           2493 	; prm$scrn Legends
                           2494 	;
                           2495 
   B666                    2496 prm$lgnd::
   B666 34 16         [ 8] 2497 	pshs	d,x
                           2498 
   B668 8E B6 74      [ 3] 2499 	ldx	#1$
   B66B BD A4 B4      [ 8] 2500 	jsr	scn$lgnd	; do legends
   B66E BD A4 EB      [ 8] 2501 	jsr	scn$chnl	; and channel
                           2502 
   B671 35 16         [ 8] 2503 	puls	d,x
   B673 39            [ 5] 2504 	rts
                           2505 
                           2506 	; Parameter Setup
                           2507 
   B674 B6 82 B6 8E B6 94  2508 1$:	.word	n$prm1,	r$prm3,	r$prm4,	r$prm5,	r$prm6,	r$prm2,	0
        B6 9A B6 A0 B6 88
        00 00
                           2509 
                           2510 
                           2511 	;	row		column		video		option
                           2512 	;-------------------------------------------------------------
   B682                    2513 n$prm1:
   B682 00 01 00 00        2514 	.byte	SCRNTP+0d0,	1,		NORMAL,		0
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 59
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Stabilization Parameters Screen

   B686 B6 A6              2515 	.word	1$		; "Stabilization Parameters"
                     1162  2516 r$prm2	= .
   B688 02 03 80 01        2517 	.byte	SCRNTP+0d2,	3,		REVERSE,	1
   B68C B6 C4              2518 	.word	2$		; "Channel #"
                     1168  2519 r$prm3	= .
   B68E 04 03 80 02        2520 	.byte	SCRNTP+0d4,	3,		REVERSE,	2
   B692 B6 D0              2521 	.word	3$		; "Exit"
                     116E  2522 r$prm4	= .
   B694 13 03 80 03        2523 	.byte	SCRNTP+0d19,	3,		REVERSE,	3
   B698 B6 DC              2524 	.word	4$		; "10% of Response Voltage Change"
                     1174  2525 r$prm5	= .
   B69A 14 03 80 04        2526 	.byte	SCRNTP+0d20,	3,		REVERSE,	4
   B69E B7 01              2527 	.word	5$		; "Update Change Threshold Voltage"
                     117A  2528 r$prm6	= .
   B6A0 15 03 80 05        2529 	.byte	SCRNTP+0d21,	3,		REVERSE,	5
   B6A4 B7 26              2530 	.word	6$		; "Maximum Single Step Voltage Change"
                           2531 
                           2532 	;     0123456789012345678901234567890123456789012345
   B6A6 53 74 61 62 69 6C  2533 1$:	.asciz	"Stabilization Parameter Setup"
        69 7A 61 74 69 6F
        6E 20 50 61 72 61
        6D 65 74 65 72 20
        53 65 74 75 70 00
   B6C4 43 68 61 6E 6E 65  2534 2$:	.asciz	"Channel #  "				; 1
        6C 20 23 20 20 00
   B6D0 45 78 69 74 20 53  2535 3$:	.asciz	"Exit Screen"				; 2
        63 72 65 65 6E 00
   B6DC 20 20 20 20 31 30  2536 4$:	.asciz	"    10% Response Voltage Change     "	; 3
        25 20 52 65 73 70
        6F 6E 73 65 20 56
        6F 6C 74 61 67 65
        20 43 68 61 6E 67
        65 20 20 20 20 20
        00
   B701 20 20 55 70 64 61  2537 5$:	.asciz	"  Update Change Threshold Voltage   "	; 4
        74 65 20 43 68 61
        6E 67 65 20 54 68
        72 65 73 68 6F 6C
        64 20 56 6F 6C 74
        61 67 65 20 20 20
        00
   B726 20 4D 61 78 69 6D  2538 6$:	.asciz	" Maximum Single Step Voltage Change "	; 5
        75 6D 20 53 69 6E
        67 6C 65 20 53 74
        65 70 20 56 6F 6C
        74 61 67 65 20 43
        68 61 6E 67 65 20
        00
                           2539 
                     0028  2540 	$PRMPOS  =  0d40
                           2541 
                           2542 	;
                           2543 	; prm$scrn Questions
                           2544 	;
                           2545 
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 60
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Stabilization Parameters Screen

   B74B                    2546 prm$ques::
   B74B 81 F9         [ 2] 2547 	cmpa	#ENTER		; selecting ?
   B74D 26 37         [ 3] 2548 	bne	5$		; no - exit
                           2549 
   B74F 34 34         [ 8] 2550 	pshs	b,x,y
                           2551 
   B751 86 17         [ 2] 2552 	lda	#SCRNBT		; common question position
   B753 C6 00         [ 2] 2553 	ldb	#0
   B755 BD 9D 5E      [ 8] 2554 	jsr	fmtindex
                           2555 
   B758 30 C9 00 5A   [ 8] 2556 	leax	optarray,u	; get option
   B75C D6 72         [ 4] 2557 	ldb	*opt$posn
   B75E E6 85         [ 5] 2558 	ldb	b,x
                           2559 
   B760 C1 02         [ 2] 2560 	cmpb	#2		; exiting this screen
   B762 26 02         [ 3] 2561 	bne	1$		; no - skip
   B764 0F 47         [ 6] 2562 	clr	*s$state	; yes
                           2563 
   B766 58            [ 2] 2564 1$:	aslb
   B767 C1 0C         [ 2] 2565 	cmpb	#7$-6$		; valid option ?
   B769 24 18         [ 3] 2566 	bhis	4$		; no - exit
   B76B 8E B7 87      [ 3] 2567 	ldx	#6$
   B76E 30 95         [ 8] 2568 	leax	[b,x]
   B770 A6 80         [ 6] 2569 2$:	lda	,x+
   B772 27 06         [ 3] 2570 	beq	3$
   B774 A7 A0         [ 6] 2571 	sta	,y+
   B776 0C 75         [ 6] 2572 	inc	*fmtcol		; next column
   B778 20 F6         [ 3] 2573 	bra	2$
                           2574 
   B77A DC 74         [ 5] 2575 3$:	ldd	*fmtrow		; load new cursor position
   B77C BD A3 CA      [ 8] 2576 	jsr	pos$scrn
   B77F 86 01         [ 2] 2577 	lda	#1		; option processing
   B781 97 48         [ 4] 2578 	sta	*o$state
   B783 4F            [ 2] 2579 4$:	clra			; dump character
   B784 35 34         [ 8] 2580 	puls	b,x,y
   B786 39            [ 5] 2581 5$:	rts
                           2582 
                           2583 
   B787 B7 93 B7 A2 B7 B9  2584 6$:	.word	7$,8$,9$,10$,11$,12$
        B7 D5 B8 00 B8 32
                           2585 
   B793 49 6E 76 61 6C 69  2586 7$:	.asciz	"Invalid Option"
        64 20 4F 70 74 69
        6F 6E 00
   B7A2 53 65 6C 65 63 74  2587 8$:	.asciz	"Select New Channel -> "				; 1
        20 4E 65 77 20 43
        68 61 6E 6E 65 6C
        20 2D 3E 20 00
   B7B9 2E 2E 2E 20 45 78  2588 9$:	.asciz	"... Exiting this Screen ..."				; 2
        69 74 69 6E 67 20
        74 68 69 73 20 53
        63 72 65 65 6E 20
        2E 2E 2E 00
   B7D5 45 6E 74 65 72 20  2589 10$:	.asciz	"Enter the 10% Response in Volts (0-50) -> "		; 3
        74 68 65 20 31 30
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 61
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Stabilization Parameters Screen

        25 20 52 65 73 70
        6F 6E 73 65 20 69
        6E 20 56 6F 6C 74
        73 20 28 30 2D 35
        30 29 20 2D 3E 20
        00
   B800 45 6E 74 65 72 20  2590 11$:	.asciz	"Enter Update Threshold Change Voltage (0-255) -> "	; 4
        55 70 64 61 74 65
        20 54 68 72 65 73
        68 6F 6C 64 20 43
        68 61 6E 67 65 20
        56 6F 6C 74 61 67
        65 20 28 30 2D 32
        35 35 29 20 2D 3E
        20 00
   B832 45 6E 74 65 72 20  2591 12$:	.asciz	"Enter Maximum Single Step Change in Volts (0-255) -> "	; 5
        4D 61 78 69 6D 75
        6D 20 53 69 6E 67
        6C 65 20 53 74 65
        70 20 43 68 61 6E
        67 65 20 69 6E 20
        56 6F 6C 74 73 20
        28 30 2D 32 35 35
        29 20 2D 3E 20 00
                           2592 
                           2593 	;
                           2594 	; prm$scrn Options
                           2595 	;
                           2596 
   B868                    2597 prm$optn::
   B868 BD A4 0E      [ 8] 2598 	jsr	scn$gets	; build a response string
   B86B 27 42         [ 3] 2599 	beq	3$		; not finished
   B86D 0D 49         [ 6] 2600 	tst	*s$string	; NULL string ?
   B86F 2F 28         [ 3] 2601 	ble	2$		; yes - terminate option
                           2602 
   B871 BD A3 F8      [ 8] 2603 	jsr	option		; get the option number
   B874 58            [ 2] 2604 	aslb
   B875 C1 0C         [ 2] 2605 	cmpb	#5$-4$		; valid option ?
   B877 24 20         [ 3] 2606 	bhis	2$		; no - terminate request
                           2607 
   B879 96 42         [ 4] 2608 	lda	*scrn$sts+1	; get channel number
   B87B 81 1F         [ 2] 2609 	cmpa	#0d31		; valid channel ?
   B87D 22 1A         [ 3] 2610 	bhi	2$		; no - terminate option
   B87F 48            [ 2] 2611 	asla
                           2612 
   B880 10 8E B8 99   [ 4] 2613 	ldy	#2$		; options return address
   B884 34 20         [ 6] 2614 	pshs	y
                           2615 
   B886 10 8E B8 B1   [ 4] 2616 	ldy	#4$		; jump table
   B88A 31 B5         [ 8] 2617 	leay	[b,y]		; get address of option routine
   B88C 34 20         [ 6] 2618 	pshs	y		; push as a return address
                           2619 
   B88E 30 C9 00 49   [ 8] 2620 	leax	s$string,u	; string pointer
                           2621 
   B892 10 8E 8C 16   [ 4] 2622 	ldy	#acqvtbl	; variables address for this channel
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 62
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Stabilization Parameters Screen

   B896 31 B6         [ 8] 2623 	leay	[a,y]
                           2624 
   B898 39            [ 5] 2625 1$:	rts			; do option
                           2626 
   B899 0F 48         [ 6] 2627 2$:	clr	*o$state	; option completed
   B89B 86 17         [ 2] 2628 	lda	#SCRNBT
   B89D C6 00         [ 2] 2629 	ldb	#0
   B89F BD 9D 75      [ 8] 2630 	jsr	fmtdeol		; clear option question and answer
                           2631 
   B8A2 DC 72         [ 5] 2632 	ldd	*opt$posn	; option position
   B8A4 BD A3 CA      [ 8] 2633 	jsr	pos$scrn	; restore cursor
                           2634 
   B8A7 0D 47         [ 6] 2635 	tst	*s$state	; new screen
   B8A9 27 04         [ 3] 2636 	beq	3$		; no - skip
   B8AB 86 02         [ 2] 2637 	lda	#2		; redraw legends always
   B8AD 97 47         [ 4] 2638 	sta	*s$state	
                           2639 
   B8AF 4F            [ 2] 2640 3$:	clra			; input character always used
   B8B0 39            [ 5] 2641 	rts
                           2642 
   B8B1 B8 98              2643 4$:	.word	1$		; invalid option
   B8B3 B8 BD              2644 	.word	5$		; new channel
   B8B5 B8 C7              2645 	.word	7$		; exit screen
   B8B7 B8 CF              2646 	.word	9$		; correction
   B8B9 B8 ED              2647 	.word	11$		; threshold
   B8BB B8 FB              2648 	.word	13$		; single step limit
                           2649 
                           2650 	; New Channel Number
                           2651 
   B8BD BD E3 34      [ 8] 2652 5$:	jsr	a$d$i		; convert to an integer
   B8C0 C1 1F         [ 2] 2653 	cmpb	#0d31		; valid ?
   B8C2 22 02         [ 3] 2654 	bhi	6$		; no - skip
   B8C4 D7 42         [ 4] 2655 	stb	*scrn$sts+1	; save new channel #
   B8C6 39            [ 5] 2656 6$:	rts
                           2657 
                           2658 	; Exit Screen
                           2659 
   B8C7 BD A4 05      [ 8] 2660 7$:	jsr	ans$yes
   B8CA 26 02         [ 3] 2661 	bne	8$
   B8CC 0F 47         [ 6] 2662 	clr	*s$state	; just exit
   B8CE 39            [ 5] 2663 8$:	rts
                           2664 
                           2665 	; Correction Size
                           2666 
   B8CF BD E3 34      [ 8] 2667 9$:	jsr	a$d$i		; convert to an integer
   B8D2 10 83 00 32   [ 5] 2668 	cmpd	#0d50		; valid ?
   B8D6 22 EE         [ 3] 2669 	bhi	6$		; no - skip
   B8D8 1F 01         [ 6] 2670 	tfr	d,x		; save
   B8DA 86 1E         [ 2] 2671 	lda	#<(0d65535/0d50)
   B8DC 3D            [11] 2672 	mul
   B8DD ED E3         [ 8] 2673 	std	,--s
   B8DF 1F 10         [ 6] 2674 	tfr	x,d
   B8E1 86 05         [ 2] 2675 	lda	#>(0d65535/0d50)
   B8E3 3D            [11] 2676 	mul
   B8E4 1E 89         [ 8] 2677 	exg	a,b
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 63
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Stabilization Parameters Screen

   B8E6 E3 E1         [ 9] 2678 	addd	,s++
   B8E8 A7 A9 00 20   [ 8] 2679 	sta	dlta$vlt,y
   B8EC 39            [ 5] 2680 10$:	rts
                           2681 
                           2682 	; Threshold
                           2683 
   B8ED BD E3 34      [ 8] 2684 11$:	jsr	a$d$i		; convert to an integer
   B8F0 10 83 00 FF   [ 5] 2685 	cmpd	#0d255		; valid ?
   B8F4 22 D0         [ 3] 2686 	bhi	6$		; no - skip
   B8F6 E7 A9 00 1E   [ 8] 2687 	stb	dlta$min,y
   B8FA 39            [ 5] 2688 12$:	rts
                           2689 
                           2690 	; Single Step Limit
                           2691 
   B8FB BD E3 34      [ 8] 2692 13$:	jsr	a$d$i		; convert to an integer
   B8FE 10 83 00 FF   [ 5] 2693 	cmpd	#0d255		; valid ?
   B902 22 C2         [ 3] 2694 	bhi	6$		; no - skip
   B904 E7 A9 00 1F   [ 8] 2695 	stb	dlta$err,y
   B908 39            [ 5] 2696 14$:	rts
                           2697 
                           2698 
                           2699 	; prm$scrn  Update Routine
                           2700 
                           2701 	.area	SCRNUPDT
                           2702 
   DD20                    2703 prm$updt::
   DD20 34 36         [ 9] 2704 	pshs	d,x,y
                           2705 
   DD22 96 42         [ 4] 2706 	lda	*scrn$sts+1	; get channel #
   DD24 81 1F         [ 2] 2707 	cmpa	#0d31
   DD26 22 54         [ 3] 2708 	bhi	1$
   DD28 48            [ 2] 2709 	asla
   DD29 10 8E 8C 16   [ 4] 2710 	ldy	#acqvtbl	; acquisition variable table
   DD2D 31 B6         [ 8] 2711 	leay	[a,y]		; this channels variables
                           2712 
                           2713 	; fill in 10% response
                           2714 
   DD2F 86 32         [ 2] 2715 	lda	#0d50		; 50 * fraction
   DD31 E6 A9 00 20   [ 8] 2716 	ldb	dlta$vlt,y
   DD35 3D            [11] 2717 	mul
   DD36 C3 00 80      [ 4] 2718 	addd	#0d128		; carry
   DD39 1F 89         [ 6] 2719 	tfr	a,b
   DD3B 4F            [ 2] 2720 	clra
   DD3C ED E3         [ 8] 2721 	std	,--s
   DD3E FC B6 94      [ 6] 2722 	ldd	r$prm4
   DD41 C6 28         [ 2] 2723 	ldb	#$PRMPOS
   DD43 8E DD 7F      [ 3] 2724 	ldx	#2$
   DD46 BD 9D 9A      [ 8] 2725 	jsr	fmthtxt		; load ' = '
   DD49 AE E1         [ 8] 2726 	ldx	,s++
   DD4B BD 9E 50      [ 8] 2727 	jsr	fmt4rjint
                           2728 
                           2729 	; fill in minimum change
                           2730 
   DD4E 4F            [ 2] 2731 	clra
   DD4F E6 A9 00 1E   [ 8] 2732 	ldb	dlta$min,y
ASxxxx Assembler V05.06+  (Motorola 6809)                              Page 64
Hexadecimal [16-Bits]                                 Sat Aug  9 20:11:50 2014
PHS Constant definitions
Stabilization Parameters Screen

   DD53 ED E3         [ 8] 2733 	std	,--s
   DD55 FC B6 9A      [ 6] 2734 	ldd	r$prm5
   DD58 C6 28         [ 2] 2735 	ldb	#$PRMPOS
   DD5A 8E DD 7F      [ 3] 2736 	ldx	#2$
   DD5D BD 9D 9A      [ 8] 2737 	jsr	fmthtxt		; load ' = '
   DD60 AE E1         [ 8] 2738 	ldx	,s++
   DD62 BD 9E 50      [ 8] 2739 	jsr	fmt4rjint
                           2740 
                           2741 	; fill in single step maximum
                           2742 
   DD65 4F            [ 2] 2743 	clra
   DD66 E6 A9 00 1F   [ 8] 2744 	ldb	dlta$err,y
   DD6A ED E3         [ 8] 2745 	std	,--s
   DD6C FC B6 A0      [ 6] 2746 	ldd	r$prm6
   DD6F C6 28         [ 2] 2747 	ldb	#$PRMPOS
   DD71 8E DD 7F      [ 3] 2748 	ldx	#2$
   DD74 BD 9D 9A      [ 8] 2749 	jsr	fmthtxt		; load ' = '
   DD77 AE E1         [ 8] 2750 	ldx	,s++
   DD79 BD 9E 50      [ 8] 2751 	jsr	fmt4rjint
                           2752 
   DD7C 35 36         [ 9] 2753 1$:	puls	d,x,y
   DD7E 39            [ 5] 2754 	rts
                           2755 
                           2756 
   DD7F 20 3D 20 00        2757 2$:	.asciz	" = "
                           2758 
