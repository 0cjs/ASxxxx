	.title	AS8x300 Assembler Test
	.sbttl	Absolute Value Assembly

	.radix	D

	; Define Areas and Banks

	.bank	s8x_c		(size=0x2000, fsfx=_cod)
	.area	s8x_code	(rel,con,cseg,bank=s8x_c)
	.area	s8x_call	(rel,con,cseg,bank=s8x_c)

	.bank	s8x_x		(size=0x2000, fsfx=_ext)
	.area	s8x_code_x	(rel,con,cseg,bank=s8x_x)
	.area	s8x_call_x	(rel,con,cseg,bank=s8x_x)

	.area	s8x_code	; The Code Area
	.xtnd	s8x_code_x	; The Extended Code Area

	.nlist
	.include	/s8xmcros.asm/
	.list

;	.fdef	4(7),3,2(3),7(127)

	.PAGE
	.SBTTL	MCCAP DEMONSTRATION PROGRAM
	;***********************************
	;* Demonstration Of All Statements *
	;***********************************

	PROC	SAMPLE

	;***********************************
	;*  Data And Address Declarations  *
	;***********************************

	FINAL	=	1
	PRELIM	=	0
	INC	=	1
	DEC	=	-1
	SINMSK	=	0B10000000
	OEMASK	=	0B1
	LSMASK	=	0Q7
	SSMASK	=	LSMASK << 3
	MSMASK	=	(LSMASK >> 1) << 6
	ROT	=	3
	LEN	=	4
	VAL1	=	0
	VAL2	=	1
	VAL3	=	2
	VAL4	=	3
	.LIV	DISC0	0Q10,7,8
	.LIV	DISC1	0Q11,7,8
	.LIV	DSTAT	DISC1,0
	.LIV	DSCLOK	DISC1,5
	.LIV	DRDWR	DISC1,6
	.LIV	DRDAT	DISC1
	.LIV	DISP1	0Q20,7,8
	.LIV	DISP2	DISP1+1,7,8
	.RIV	DATA1	0Q100,7,8
	.RIV	D1SIGN	DATA1,0
	.RIV	D1ODIV	DATA1
	.RIV	DATA2	DATA1+1,7,8
	.RIV	D2SIGN	DATA2,0
	.RIV	D2ODEV	DATA2
	.RIV	TEMP1	0Q200,7,8
	.RIV	TEMP2	TEMP1+1,7,8

	.PAGE
	;***********************************
	;*    CONDITIONALS AND SPECIAL     *
	;*           DIRECTIVES            *
	;***********************************

	.IFNE	PRELIM
	.ENDIF

	.IF	FINAL
	.ENDIF

	;***********************************
	;*       MACRO DEFINITIONS         *
	;***********************************

	.MACRO	LOOK	REPL1,RX
	  .LIST	(!,ME,ERR,LOC,BIN,CYC,SRC)
	  ORG	4,256
	  SEL	DISC1
	  MOVE	REPL1,RX
	  NZT	RX,.-2
	.ENDM

	.MACRO	LOOPCT	RX
	  .LIST	(!,ME,ERR,LOC,BIN,CYC,SRC)
	  XMIT	-1,AUX
	  ADD	RX,RX
	.ENDM

	.PAGE
	.SBTTL	MAIN PROGRAM
	;***********************************
	;*          MAIN PROGRAM           *
	;***********************************

	ORG	0

START:	NOP			; 00 00
	XMIT	0,R1		; C1 00
	XMIT	0,R2		; C2 00
	LOOK	DSTAT,R1
STC:	CALL	ARITH	^/  / ^/; C9 00/ ^/;sE0r12/
	CALL	MOVMNT	^/  / ^/; C9 01/ ^/;sE1r1F/
	CALL	TRNSMT	^/  / ^/; C9 02/ ^/;sE1r23/
	CALL	EXECT	^/  / ^/; C9 03/ ^/;sE1r2F/
	LOOPCT	R6
	NZT	OVF,START+3	;sA8r03
LAST:	HALT			;sE0r11

	.PAGE
	.SBTTL	ARITH
	;***********************************
	;*        ARITH PROCEEDURE         *
	;***********************************

	PROC	ARITH

	ORG	256,256
STAR:	SEL	TEMP1		; CF 80
	MOVE	R11,TEMP1	; 09 1F
CANT:	CALL	NONZXF	^/  / ^/; C9 04/ ^/;sE1r61/
	SEL	TEMP1		; CF 80
	MOVE	TEMP1,R11	; 1F 09
	XMIT	0Q40,AUX	; C0 20
STAD:	ADD	R1,R1		; 21 01
	ADD	2,2		; 22 02
	ADD	R3(ROT),R3	; 23 63
	SEL	DATA1		; CF 40
	XMIT	LSMASK,AUX	; C0 07
STAND:	AND	R1,DATA1	; 41 1F
	SEL	DATA2		; CF 41
	XMIT	SSMASK,AUX	; C0 38
	AND	R2,LEN,DATA2	; 42 9F
	XMIT	DATA2+1,IVR	; CF 42
	XMIT	MSMASK,AUX	; C0 C0
	AND	R3,LEN,DATA2	; 43 9F
	XMIT	DATA2+2,0Q17	; CF 43
	XMIT	0Q263,AUX	; C0 B3
	AND	4(4),AUX	; 44 80
	SEL	DATA1		; CF 40
	XMIT	-1,AUX		; C0 FF
STOR:	XOR	DATA1,DATA1	; 7F 1F
	SEL	DATA2		; CF 41
	XOR	DATA2,3,DATA2	; 7F 7F
	XMIT	DATA2+1,IVR	; CF 42
	XOR	0Q37,LEN,0Q37	; 7F 9F
	XMIT	DATA2+2,0Q17	; CF 43
	XOR	0Q33,LEN,0Q37	; 7B 9F

	ENTRY	MOVMNT

	SEL	DISC1		; C7 09
STMV:	MOVE	DSTAT,R1	; 10 21
	MOVE	0Q24,LEN,R2	; 14 82
	MOVE	DRDAT,LEN,R3	; 17 83

	.PAGE
	.SBTTL	ARITH
	;***********************************
	;*    ARITH PROCEEDURE (CONT'D)    *
	;***********************************

	ENTRY	TRNSMT

	SEL	DISP1		; C7 10
STXT:	XMIT	'G,R5		; C5 47
	MOVE	R5,DISP1	; 05 17
	SEL DISP2		; C7 11
	XMIT	'O,R5		; C5 4F
	MOVE	R5,DISP2	; 05 17
	SEL	DISP1		; C7 10
	XMIT	'!,R5		; C5 21
	MOVE	R5,DISP1	; 05 17
	XMIT	VAL1,DISP1,LEN	; D7 80
	XMIT	VAL2,0Q23,4	; D3 81
EAR:	RTN
	;END	ARITH

	.PAGE
	;***********************************
	;*        EXECT PROCEEDURE         *
	;***********************************

	PROC	EXECT

	.RIV	TABPTRS	0Q240,7,8
	.RIV	T2PTR	TABPTRS
	.RIV	T3PTR	TABPTRS,5
	.RIV	T4PTR	TABPTRS,3
	.RIV	T5PTR	TABPTRS,1
	ORG	7,256
STXC:	XEC	.+1(R6),5	;s86r30
	JMP	TAB1		;sE1r35
	JMP	TAB2		;sE1r3A
	JMP	TAB3		;sE1r3E
	JMP	TAB4		;sE1r45
	JMP	TAB5		;sE1r49
	ORG	6,256
TAB1:	XEC	.+1(R1)		;s81r36
	JMP	DONE		;sE1r60
	JMP	DONE		;sE1r60
	JMP	DONE		;sE1r60
	JMP	DONE		;sE1r60
TAB2:	SEL	TABPTRS		; CF A0
	ORG	5,32
	XEC	.+1(T2PTR)	;s9Fr3C
	JMP	DONE		;sE1r60
	JMP	DONE		;sE1r60
TAB3:	SEL	TABPTRS		; CF A0
	ORG	7,32
	XEC	.+1(T3PTR,2)	;s9Dr41
	JMP	DONE		;sE1r60
	JMP	DONE		;sE1r60
	JMP	DONE		;sE1r60
	JMP	DONE		;sE1r60
TAB4:	SEL	TABPTRS		; CF A0
	ORG	5,32
	XEC	.+1(T4PTR),2	;s9Br27
	JMP	DONE		;sE1r60
	JMP	DONE		;sE1r60
TAB5:	SEL	TABPTRS		; CF A0
	ORG	7,32
	XEC	.+1(T5PTR,2),4	;s99r4B
	JMP	DONE		;sE1r60
	JMP	DONE		;sE1r60
	JMP	DONE		;sE1r60
	JMP	DONE		;sE1r60
	ORG	32,32
DONE:	RTN
	;END	EXECT

	.PAGE
	;***********************************
	;*        NONZXF PROCEEDURE        *
	;***********************************

	PROC	NONZXF

	VAL1 = VAL1 + 5
	VAL2 = VAL2 + 5
	VAL3 = VAL3 + 5
	VAL4 = VAL4 + 5
	ORG	16,256

	XMIT	VAL1,R5		; C5 05
STNT:	NZT	R5,.+8		;sA5r6A
	SEL	DISP1		; C7 10
	XMIT	VAL2,DISP1	; D7 06
	NZT	DISP1,.+7	;sB7r0C
	SEL	DISP2		; C7 11
	XMIT	VAL3,DISP2	; D7 07
	NZT	0Q23,4,.+6	;sB3r8E
	RTN
	LOOPCT	R5
	SEL	DISP1		; C7 10
	LOOPCT	DISP1
	SEL	DISP2		; C7 11
	LOOPCT	DISP2
ENT:	RTN
	;END	NOZXF
	;END	SAMPLE


	;.area	s8x_call
	;.xtnd	s8x_call_x
	Call_Table	s8x_call,s8x_call_x

	.end

