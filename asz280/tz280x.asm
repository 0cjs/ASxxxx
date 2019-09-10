	.title	Test of Z280 assembler
	.module	tz280x.asm

	; To test asz280 with .con and .lst defined:
    	; Constants / Internal symbols mode.
	; Verifies assembler output.
	;
	;	asz280 -lbcoxff -p tz280x_CL asz280_CL tz280x 
	;	asxscn tz280x_CL.lst
	;
	;
	; To test asz280 with .con and .rst defined:
    	; Constants / Internal symbols mode.
	; Verifies linked code.
	;
	;	asz280 -lbcoxff -p tz280x_CR asz280_CR tz280x 
	;	aslink -nf tz280x_CR
	;	asxscn tz280x_CR.rst
	;
	;
	; To test asz280 with .ext and .lst defined:
    	; Constants with External symbols mode.
	; Verifies assembler output.
	;
	;	asz280 -lbcoxff -p tz280x_XL asz280_XL tz280x 
	;	asxscn tz280x_XL.lst
	;
	;
	; To test asz280 with .ext and .rst defined:
    	; Constants with External symbols mode.
	; Verifies linked code.
	;
	;	asz280 -lbcoxff -p tz280x_XR asz280_XR tz280x 
	;	aslink -nf tz280x_XR
	;	asxscn tz280x_XR.rst
	;
	; To test asz280 with .ext and .lst defined:
	; Full external symbol mode. (.EXLR defined)
	; Verifies assembler output.
	;
	;	asz280 -lbcoxff -p tz280x_EXL asz280_EXL tz280x 
	;	asxscn tz280x_EXL.lst
	;
	;
	; To test asz280 with .ext and .rst defined:
	; Full external symbol mode. (.EXLR defined)
	; Verifies linked code.
	;
	;	asz280 -lbcoxff -p tz280x_EXR asz280_EXR tz280x 
	;	aslink -nf tz280x_EXR
	;	asxscn tz280x_EXR.rst
	;

.nlist  ; -->bgn
  ; Assemble with "asz280_CL.asm"	;.define .con / .lst	constants / .lst
  ; Assemble with "asz280_CR.asm"	;.define .con / .rst	constants / .rst
  ; Assemble with "asz280_XL.asm"	;.define .ext / .lst	constants + externals / .lst
  ; Assemble with "asz280_XR.asm"	;.define .ext / .rst	constants + externals / .rst
  ; Assemble with "asz280_EXL.asm"	;.define .ext / .lst / .EXLR	externals / .lst
  ; Assemble with "asz280_EXR.asm"	;.define .ext / .rst / .EXLR	externals / .rst

  ; Creating the CXLR value and validating the selections.
  ; Default will be CXLR = 0x05 (.con/.lst) if assembled without one of the above files.

	CXLR = 0	; Initialize
  .iifdef .con	CXLR = CXLR | 0x08
  .iifdef .ext	CXLR = CXLR | 0x04
  .iifdef .lst	CXLR = CXLR | 0x02
  .iifdef .rst	CXLR = CXLR | 0x01
  .ifeq 0x0C - (CXLR & 0x0C)
    .error 1	; constant and external simultaneously defined
	CXLR = CXLR & 0x0B	; Constant
  .endif
  .ifeq 0x03 - (CXLR & 0x03)
	    .error 1	; .lst and .rst simultaneously defined
	CXLR = CXLR & 0xE	; .lst
  .endif
  .ifeq CXLR & 0x0C
	CXLR = CXLR | 0x08	; Constant
  .endif
  .ifeq CXLR & 0x03
	CXLR = CXLR | 0x02	; .lst
  .endif
.list   ; end<--
	CXLR = CXLR	; .con / .ext / .lst / .rst

.nlist  ; -->bgn
  .ifne CXLR & 0x08
    .list
	; Assembled with .con option.
    .nlist
  .endif
  .ifne CXLR & 0x04
    .list
	; Assembled with .ext option.
    .nlist
  .endif
  .ifne CXLR & 0x02
    .list
	; Assembled with .lst option.
    .nlist
  .endif
  .ifne CXLR & 0x01
    .list
	; Assembled with .rst option.
    .nlist
  .endif
  .ifdef .EXLR
    .list
	; Full External Symbol Mode. (.EXLR defined)
    .nlist
  .else
    .list
    	; Constants + External Symbols Mode. (.EXLR not defined)
    .nlist
  .endif
.list   ; end<--

	C_LR = 0x08 - (CXLR & 0x08)	; = 0  if .con with either .lst/.rst
	_XLR = 0x04 - (CXLR & 0x04)	; = 0  if .ext with either .lst/.rst
	CXL_ = 0x02 - (CXLR & 0x02)	; = 0  if .lst with either .con/.ext
	CX_R = 0x01 - (CXLR & 0x01)	; = 0  if .rst with either .con/.ext
	C_L_ = 0x0A - CXLR		; = 0  if .con and .lst
	C__R = 0x09 - CXLR		; = 0  if .con and .rst
	_XL_ = 0x06 - CXLR		; = 0  if .ext and .lst
	_X_R = 0x05 - CXLR		; = 0  if .ext and .rst

.nlist  ; -->bgn
	; Required Fixes
.list   ; end<--

;*******************************************************************	
;*******************************************************************

	offset	=	0x55		;arbitrary constants
	n	=	0x20
	nn	=	0x0584

	sxoff	=	0x55		; SX offset (-128..127)
	lxoff	=	0x1122		;  X offset
	raoff	=	0x1234		; RA address/offset
	daddr	=	0x3344		; DA address

	offsetc	==	offset		;arbitrary constants
	nc	==	n
	nnc	==	nn

	sxofc	==	sxoff		; SX offset (-128..127)
	lxofc	==	lxoff		;  X offset
	raofc	==	raoff		; RA address/offset
	daddc	==	daddr		; DA address

.nlist  ; -->bgn
  .ifdef .ext
    .list
;*******************************************************************	
;*******************************************************************
;	Test of External References By Substitution
;*******************************************************************	
;*******************************************************************

    .nlist
    .ifdef .EXLR
		.globl	x		; External symbol given a
					; default value of 0 by
					; assembler. Value defined
					; at link time from another
					; object file or by the
					; linker -g x=value option.

      .list
	.define		offset		"offsetx"
	.define		n		"nx"
	.define		nn		"nnx"
	.define		sxoff		"sxofx"
	.define		lxoff		"lxofx"
	.define		raoff		"raofx"
	.define		daddr		"daddx"

		.globl  offsetx		; External symbols given a
		.globl	nx		; default value of 0 by
		.globl	nnx		; assembler. Value defined
		.globl	sxofx		; at link time from another
		.globl	lxofx		; object file or by the
		.globl	raofx		; linker -g ...x=value option.
		.globl	daddx
      .nlist
    .else
      .list
		.globl	x		; External symbol given a
					; default value of 0 by
					; assembler. Value defined
					; at link time from another
					; object file or by the
					; linker -g x=value option.

	.define		offset		"offsetc+x"
	.define		n		"nc+x"
	.define		nn		"nnc+x"
	.define		sxoff		"sxofc+x"
	.define		lxoff		"lxofc+x"
	.define		raoff		"raofc+x"
	.define		daddr		"daddc+x"
      .nlist

		.globl  offsetx		; External symbols given a
		.globl	nx		; default value of 0 by
		.globl	nnx		; assembler. Value defined
		.globl	sxofx		; at link time from another
		.globl	lxofx		; object file or by the
		.globl	raofx		; linker -g ...x=value option.
		.globl	daddx
    .endif
    .list

	.macro	.pcr_lclx A,B
	  .globl A
	  .ifb B
	    x'A == . + 4
	  .else
	    x'A == . + B
	  .endif
	.endm

	.macro	.pcr_xtrn A,B,C
	  .globl A
	  .ifb C
	    x'A == B + . + 4
	  .else
	    x'A == B + . + C
	  .endif
	.endm

;*******************************************************************	
;*******************************************************************	
;*******************************************************************
    .nlist
  .else
		.globl	x		; External symbol given a
					; default value of 0 by
					; assembler. Value defined
					; at link time from another
					; object file or by the
					; linker -g x=value option.

  .endif
.list   ; end<--

	.macro	.pcr_ofst A,B
          .nval	_dot_, .
	  .ifb B
 	    pcr_ofst = A + _dot_ + 4
	  .else
 	    pcr_ofst = A + _dot_ + B
	  .endif
	.endm


ODDBALL_SHIFT_ROTATE	=	0	; prefer this set to 0

	.area	_code
	
	.z80
	.byte	.__.CPU.	; 83
	.z80u
	.byte	.__.CPU.	; 87
	.z180
	.byte	.__.CPU.	; 8B
	.hd64
	.byte	.__.CPU.	; 8B
	.z280
	.byte	.__.CPU.	; 33
	.z280n
	.byte	.__.CPU.	; 11
	.z280p
	.byte	.__.CPU.	; F3

	. = . - 7

;*******************************************************************	
;*******************************************************************
;	Start test of addressing syntax	
;*******************************************************************	
;*******************************************************************	
	;***********************************************************
	; add with carry
	.z280
	adc	a,(hl)			;8E
	adc	a,(hl+ix)		;DD 89
	adc	a,(hl+iy)		;DD 8A
.nlist  ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	adc	a,(hl+lxoff)		;FD 8Br00s00
	adc	a,(hl+sxoff)		;FD 8Br00s00
	adc	a,lxoff(hl)		;FD 8Br00s00
	adc	a,sxoff(hl)		;FD 8Br00s00
      .nlist
    .else
      .list
	adc	a,(hl+lxoff)		;FD 8Br22s11
	adc	a,(hl+sxoff)		;FD 8Br55s00
	adc	a,lxoff(hl)		;FD 8Br22s11
	adc	a,sxoff(hl)		;FD 8Br55s00
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	adc	a,(hl+lxoff)		;FD 8B 22 11
	adc	a,(hl+sxoff)		;FD 8B 55 00
	adc	a,lxoff(hl)		;FD 8B 22 11
	adc	a,sxoff(hl)		;FD 8B 55 00
    .nlist
  .endif
.list  ; end<--
	adc	a,(ix+iy)		;DD 8B
	adc	a,(ix)			;DD 8E 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	adc	a,(ix+lxoff)		;FD 89r00s00
	adc	a,lxoff(ix)		;FD 89r00s00
	adc	a,(ix-lxofc+x)		;FD 89rDEsEE
	adc	a,-lxofc+x(ix)		;FD 89rDEsEE
      .nlist
    .else
      .list
	adc	a,(ix+lxoff)		;FD 89r22s11
	adc	a,lxoff(ix)		;FD 89r22s11
	adc	a,(ix-lxoff)		;FD 89rDEsEE
	adc	a,-lxoff(ix)		;FD 89rDEsEE
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .list
	adc	a,(ix+lxoff)		;FD 89 22 11
	adc	a,lxoff(ix)		;FD 89 22 11
    .nlist
    .ifdef .EXLR
      .list
	adc	a,(ix-lxofc+x)		;FD 89 DE EE
	adc	a,-lxofc+x(ix)		;FD 89 DE EE
      .nlist
    .else
      .list
	adc	a,(ix-lxoff)		;FD 89 DE EE
	adc	a,-lxoff(ix)		;FD 89 DE EE
      .nlist
    .endif
  .endif
  .ifeq C_LR				; or (.con/.lst) or (.con/.rst)
    .list
	adc	a,(ix+lxoff)		;FD 89 22 11
	adc	a,lxoff(ix)		;FD 89 22 11
	adc	a,(ix-lxoff)		;FD 89 DE EE
	adc	a,-lxoff(ix)		;FD 89 DE EE
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				 ; (.ext/.lst)
    .list
    .nlist
    .ifdef .EXLR
      .list
	adc	a,(ix+sxoff)		;FD 89r00s00
	adc	a,sxoff(ix)		;FD 89r00s00
	adc	a,(ix-sxofc+x)		;FD 89rABsFF
	adc	a,-sxofc+x(ix)		;FD 89rABsFF
      .nlist
    .else
      .list
	adc	a,(ix+sxoff)		;FD 89r55s00
	adc	a,sxoff(ix)		;FD 89r55s00
	adc	a,(ix-sxoff)		;FD 89rABsFF
	adc	a,-sxoff(ix)		;FD 89rABsFF
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .list
	adc	a,(ix+sxoff)		;FD 89 55 00
	adc	a,sxoff(ix)		;FD 89 55 00
    .nlist
    .ifdef .EXLR
      .list
	adc	a,(ix-sxofc+x)		;FD 89 AB FF
	adc	a,-sxofc+x(ix)		;FD 89 AB FF
      .nlist
    .else
      .list
 	adc	a,(ix-sxoff)		;FD 89 AB FF
	adc	a,-sxoff(ix)		;FD 89 AB FF
     .nlist
    .endif
  .endif
  .ifeq C_LR				; (.con/.lst) or (.con/.rst)
    .list
	adc	a,(ix+sxoff)		;DD 8E 55
	adc	a,sxoff(ix)		;DD 8E 55
	adc	a,(ix-sxoff)		;DD 8E AB
	adc	a,-sxoff(ix)		;DD 8E AB
    .nlist
  .endif
.list  ; end<--
	adc	a,(iy)			;FD 8E 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	adc	a,(iy+lxoff)		;FD 8Ar00s00
	adc	a,lxoff(iy)		;FD 8Ar00s00
	adc	a,(iy-lxofc+x)		;FD 8ArDEsEE
	adc	a,-lxofc+x(iy)		;FD 8ArDEsEE
      .nlist
    .else
      .list
	adc	a,(iy+lxoff)		;FD 8Ar22s11
	adc	a,lxoff(iy)		;FD 8Ar22s11
	adc	a,(iy-lxoff)		;FD 8ArDEsEE
	adc	a,-lxoff(iy)		;FD 8ArDEsEE
      .nlist
    .endif
  .endif
  .ifeq _X_R	; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	adc	a,(iy+lxoff)		;FD 8A 22 11
	adc	a,lxoff(iy)		;FD 8A 22 11
    .nlist
    .ifdef .EXLR
      .list
	adc	a,(iy-lxofc+x)		;FD 8A DE EE
	adc	a,-lxofc+x(iy)		;FD 8A DE EE
      .nlist
    .else
      .list
	adc	a,(iy-lxoff)		;FD 8A DE EE
	adc	a,-lxoff(iy)		;FD 8A DE EE
      .nlist
    .endif
  .endif
  .ifeq C_LR				; (.con/.lst) or (.con/.rst)
    .list
	adc	a,(iy+lxoff)		;FD 8A 22 11
	adc	a,lxoff(iy)		;FD 8A 22 11
	adc	a,(iy-lxoff)		;FD 8A DE EE
	adc	a,-lxoff(iy)		;FD 8A DE EE
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	adc	a,(iy+sxoff)		;FD 8Ar00s00
	adc	a,sxoff(iy)		;FD 8Ar00s00
	adc	a,(iy-sxofc+x)		;FD 8ArABsFF
	adc	a,-sxofc+x(iy)		;FD 8ArABsFF
      .nlist
    .else
      .list
	adc	a,(iy+sxoff)		;FD 8Ar55s00
	adc	a,sxoff(iy)		;FD 8Ar55s00
	adc	a,(iy-sxoff)		;FD 8ArABsFF
	adc	a,-sxoff(iy)		;FD 8ArABsFF
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .list
	adc	a,(iy+sxoff)		;FD 8A 55 00
	adc	a,sxoff(iy)		;FD 8A 55 00
    .nlist
    .ifdef .EXLR
      .list
	adc	a,(iy-sxofc+x)		;FD 8A AB FF
	adc	a,-sxofc+x(iy)		;FD 8A AB FF
      .nlist
    .else
      .list
	adc	a,(iy-sxoff)		;FD 8A AB FF
	adc	a,-sxoff(iy)		;FD 8A AB FF
      .nlist
    .endif
  .endif
  .ifeq C_LR				; (.con/.lst) or (.con/.rst)
    .list
	adc	a,(iy+sxoff)		;FD 8E 55
	adc	a,sxoff(iy)		;FD 8E 55
	adc	a,(iy-sxoff)		;FD 8E AB
	adc	a,-sxoff(iy)		;FD 8E AB
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_                            ; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn adc01,lxofc
      .list
	adc	a,adc01(pc)		;FD 88p00q00
      .nlist
      .pcr_xtrn adc02,lxofc
      .list
	adc	a,(pc+adc02)		;FD 88p00q00
      .nlist
      .pcr_xtrn adc03,lxofc
      .list
	adc	a,[adc03]		;FD 88p00q00
      .nlist
      .pcr_xtrn adc04,sxofc
      .list
	adc	a,adc04(pc)		;FD 88p00q00
      .nlist
      .pcr_xtrn adc05,sxofc
      .list
	adc	a,(pc+adc05)		;FD 88p00q00
      .nlist
      .pcr_xtrn adc06,sxofc
      .list
	adc	a,[adc06]		;FD 88p00q00
      .nlist
      .pcr_xtrn adc07,raofc
      .list
	adc	a,adc07(pc)		;FD 88p00q00
      .nlist
      .pcr_xtrn adc08,raofc
      .list
	adc	a,(pc+adc08)		;FD 88p00q00
      .nlist
      .pcr_xtrn adc09,raofc
      .list
	adc	a,[adc09]		;FD 88p00q00
      .nlist
    .else
      .pcr_lclx adc01
      .list
	adc	a,lxofc+adc01(pc)	;FD 88p22q11
      .nlist
      .pcr_lclx adc02
      .list
	adc	a,(pc+lxofc+adc02)	;FD 88p22q11
      .nlist
      .pcr_lclx adc03
      .list
	adc	a,[lxofc+adc03]		;FD 88p22q11
      .nlist
      .pcr_lclx adc04
      .list
	adc	a,sxofc+adc04(pc)	;FD 88p55q00
      .nlist
      .pcr_lclx adc05
      .list
	adc	a,(pc+sxofc+adc05)	;FD 88p55q00
      .nlist
      .pcr_lclx adc06
      .list
	adc	a,[sxofc+adc06]		;FD 88p55q00
      .nlist
      .pcr_lclx adc07
      .list
	adc	a,raofc+adc07(pc)	;FD 88p34q12
      .nlist
      .pcr_lclx adc08
      .list
	adc	a,(pc+raofc+adc08)	;FD 88p34q12
      .nlist
      .pcr_lclx adc09
      .list
	adc	a,[raofc+adc09]		;FD 88p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn adc01,lxofc
      .list
	adc	a,adc01(pc)		;FD 88 22 11
      .nlist
      .pcr_xtrn adc02,lxofc
      .list
	adc	a,(pc+adc02)		;FD 88 22 11
      .nlist
      .pcr_xtrn adc03,lxofc
      .list
	adc	a,[adc03]		;FD 88 22 11
      .nlist
      .pcr_xtrn adc04,sxofc
      .list
	adc	a,adc04(pc)		;FD 88 55 00
      .nlist
      .pcr_xtrn adc05,sxofc
      .list
	adc	a,(pc+adc05)		;FD 88 55 00
      .nlist
      .pcr_xtrn adc06,sxofc
      .list
	adc	a,[adc06]		;FD 88 55 00
      .nlist
      .pcr_xtrn adc07,raofc
      .list
	adc	a,adc07(pc)		;FD 88 34 12
      .nlist
      .pcr_xtrn adc08,raofc
      .list
	adc	a,(pc+adc08)		;FD 88 34 12
      .nlist
      .pcr_xtrn adc09,raofc
      .list
	adc	a,[adc09]		;FD 88 34 12
      .nlist
    .else
      .pcr_lclx adc01
      .list
	adc	a,lxofc+adc01(pc)	;FD 88 22 11
      .nlist
      .pcr_lclx adc02
      .list
	adc	a,(pc+lxofc+adc02)	;FD 88 22 11
      .nlist
      .pcr_lclx adc03
      .list
	adc	a,[lxofc+adc03]		;FD 88 22 11
      .nlist
      .pcr_lclx adc04
      .list
	adc	a,sxofc+adc04(pc)	;FD 88 55 00
      .nlist
      .pcr_lclx adc05
      .list
	adc	a,(pc+sxofc+adc05)	;FD 88 55 00
      .nlist
      .pcr_lclx adc06
      .list
	adc	a,[sxofc+adc06]		;FD 88 55 00
      .nlist
      .pcr_lclx adc07
      .list
	adc	a,raofc+adc07(pc)	;FD 88 34 12
      .nlist
      .pcr_lclx adc08
      .list
	adc	a,(pc+raofc+adc08)	;FD 88 34 12
      .nlist
      .pcr_lclx adc09
      .list
	adc	a,[raofc+adc09]		;FD 88 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	adc	a,lxoff(pc)		;FD 88p22q11
	adc	a,(pc+lxoff)		;FD 88p22q11
	adc	a,[lxoff]		;FD 88p22q11
	adc	a,sxoff(pc)		;FD 88p55q00
	adc	a,(pc+sxoff)		;FD 88p55q00
	adc	a,[sxoff]		;FD 88p55q00
	adc	a,raoff(pc)		;FD 88p34q12
	adc	a,(pc+raoff)		;FD 88p34q12
	adc	a,[raoff]		;FD 88p34q12
    .nlist
  .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
      	.pcr_ofst lxofc
      .list
	adc	a,pcr_ofst(pc)		;FD 88 22 11
      .nlist
      	.pcr_ofst lxofc
      .list
	adc	a,(pc+pcr_ofst)		;FD 88 22 11
      .nlist
      	.pcr_ofst lxofc
      .list
	adc	a,[pcr_ofst]		;FD 88 22 11
      .nlist
      	.pcr_ofst sxofc
      .list
	adc	a,pcr_ofst(pc)		;FD 88 55 00
      .nlist
      	.pcr_ofst sxofc
      .list
	adc	a,(pc+pcr_ofst)		;FD 88 55 00
      .nlist
      	.pcr_ofst sxofc
      .list
	adc	a,[pcr_ofst]		;FD 88 55 00
      .nlist
      	.pcr_ofst raofc
      .list
	adc	a,pcr_ofst(pc)		;FD 88 34 12
      .nlist
      	.pcr_ofst raofc
      .list
	adc	a,(pc+pcr_ofst)		;FD 88 34 12
      .nlist
      	.pcr_ofst raofc
      .list
	adc	a,[pcr_ofst]		;FD 88 34 12
    .nlist
  .endif
.list  ; end<--
	adc	a,[.]			;FD 88 FC FF
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	adc	a,(sp+lxoff)		;DD 88r00s00
	adc	a,lxoff(sp)		;DD 88r00s00
	adc	a,(daddr)		;DD 8Fr00s00
      .nlist
    .else
      .list
	adc	a,(sp+lxoff)		;DD 88r22s11
	adc	a,lxoff(sp)		;DD 88r22s11
	adc	a,(daddr)		;DD 8Fr44s33
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	adc	a,(sp+lxoff)		;DD 88 22 11
	adc	a,lxoff(sp)		;DD 88 22 11
	adc	a,(daddr)		;DD 8F 44 33
    .nlist
  .endif
.list  ; end<--
	adc	a,b			;88
	adc	a,c			;89
	adc	a,d			;8A
	adc	a,e			;8B
	adc	a,h			;8C
	adc	a,l			;8D
	adc	a,(hl)			;8E
	adc	a,a			;8F
	adc	a,ixh			;DD 8C
	adc	a,ixl			;DD 8D
	adc	a,iyh			;FD 8C
	adc	a,iyl			;FD 8D
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	adc	a,#n			;CEr00
	adc	a, n			;CEr00
	adc	a,lxoff			;CEr00
      .nlist
    .else
      .list
	adc	a,#n			;CEr20
	adc	a, n			;CEr20
	adc	a,lxoff			;CEr22
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	adc	a,#n			;CE 20
	adc	a, n			;CE 20
	adc	a,lxoff			;CE 22
    .nlist
  .endif
.list  ; end<--
	adc	hl,bc			;ED 4A
	adc	hl,de			;ED 5A
	adc	hl,hl			;ED 6A
	adc	hl,sp			;ED 7A
	adc	ix,bc			;DD ED 4A
	adc	ix,de			;DD ED 5A
	adc	ix,ix			;DD ED 6A
	adc	ix,sp			;DD ED 7A
	adc	iy,bc			;FD ED 4A
	adc	iy,de			;FD ED 5A
	adc	iy,iy			;FD ED 6A
	adc	iy,sp			;FD ED 7A
	
	
;*******************************************************************
;*******************************************************************
;	End test of addressing syntax	
;*******************************************************************
;*******************************************************************
;*******************************************************************


;*******************************************************************
;	ADC	
;		Leading 'a' operand is optional.
;		If offset is ommitted 0 is assumed.
;*******************************************************************
	;***********************************************************
	; add with carry to 'a'
	.z80
	adc	a,(hl)			;8E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	adc	a,offset(ix)		;DD 8Er00
	adc	a,offset(iy)		;FD 8Er00
	adc	a,(ix+offset)		;DD 8Er00
	adc	a,(iy+offset)		;FD 8Er00
      .nlist
    .else
      .list
	adc	a,offset(ix)		;DD 8Er55
	adc	a,offset(iy)		;FD 8Er55
	adc	a,(ix+offset)		;DD 8Er55
	adc	a,(iy+offset)		;FD 8Er55
      .nlist
    .endif
  .else				; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	adc	a,offset(ix)		;DD 8E 55
	adc	a,offset(iy)		;FD 8E 55
	adc	a,(ix+offset)		;DD 8E 55
	adc	a,(iy+offset)		;FD 8E 55
    .nlist
  .endif
.list  ; end<--
	adc	a,(ix)			;DD 8E 00
	adc	a,(iy)			;FD 8E 00
	adc	a,a			;8F
	adc	a,b			;88
	adc	a,c			;89
	adc	a,d			;8A
	adc	a,e			;8B
	adc	a,h			;8C
	adc	a,l			;8D
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	adc	a,#n			;CEr00
	adc	a, n			;CEr00
      .nlist
    .else
      .list
	adc	a,#n			;CEr20
	adc	a, n			;CEr20
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	adc	a,#n			;CE 20
	adc	a, n			;CE 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	adc	(hl)			;8E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	adc	offset(ix)		;DD 8Er00
	adc	offset(iy)		;FD 8Er00
	adc	(ix+offset)		;DD 8Er00
	adc	(iy+offset)		;FD 8Er00
      .nlist
    .else
      .list
	adc	offset(ix)		;DD 8Er55
	adc	offset(iy)		;FD 8Er55
	adc	(ix+offset)		;DD 8Er55
	adc	(iy+offset)		;FD 8Er55
      .nlist
    .endif
  .else				; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	adc	offset(ix)		;DD 8E 55
	adc	offset(iy)		;FD 8E 55
	adc	(ix+offset)		;DD 8E 55
	adc	(iy+offset)		;FD 8E 55
    .nlist
  .endif
.list  ; end<--
	adc	(ix)			;DD 8E 00
	adc	(iy)			;FD 8E 00
	adc	a			;8F
	adc	b			;88
	adc	c			;89
	adc	d			;8A
	adc	e			;8B
	adc	h			;8C
	adc	l			;8D
.nlist  ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	adc	#n			;CEr00
	adc	 n			;CEr00
      .nlist
    .else
      .list
	adc	#n			;CEr20
	adc	 n			;CEr20
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	adc	#n			;CE 20
	adc	 n			;CE 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	; add with carry register pair to 'hl'
	adc	hl,bc			;ED 4A
	adc	hl,de			;ED 5A
	adc	hl,hl			;ED 6A
	adc	hl,sp			;ED 7A
	;***********************************************************
	; add with carry to accumulator with 'a'
	.z280
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	adc	a,(nn+6)		;DD 8Fr06s00
	adc	a,(ix+nn)		;FD 89r00s00
	adc	a,(iy+nn)		;FD 8Ar00s00
	adc	a,(hl+nn)		;FD 8Br00s00
	adc	a,(sp+nn)		;DD 88r00s00
	adc	a,sxoff(ix)		;FD 89r00s00
	adc	a,(ix+sxoff)		;FD 89r00s00
	adc	a,sxoff(iy)		;FD 8Ar00s00
	adc	a,(iy+sxoff)		;FD 8Ar00s00
	adc	a,sxoff(hl)		;FD 8Br00s00
	adc	a,(hl+sxoff)		;FD 8Br00s00
	adc	a,sxoff(sp)		;DD 88r00s00
	adc	a,(sp+sxoff)		;DD 88r00s00
	adc	a,lxoff(ix)		;FD 89r00s00
	adc	a,(ix+lxoff)		;FD 89r00s00
	adc	a,lxoff(iy)		;FD 8Ar00s00
	adc	a,(iy+lxoff)		;FD 8Ar00s00
	adc	a,lxoff(hl)		;FD 8Br00s00
	adc	a,(hl+lxoff)		;FD 8Br00s00
	adc	a,lxoff(sp)		;DD 88r00s00
	adc	a,(sp+lxoff)		;DD 88r00s00
      .nlist
    .else
      .list
	adc	a,(nn+6)		;DD 8Fr8As05
	adc	a,(ix+nn)		;FD 89r84s05
	adc	a,(iy+nn)		;FD 8Ar84s05
	adc	a,(hl+nn)		;FD 8Br84s05
	adc	a,(sp+nn)		;DD 88r84s05
	adc	a,sxoff(ix)		;FD 89r55s00
	adc	a,(ix+sxoff)		;FD 89r55s00
	adc	a,sxoff(iy)		;FD 8Ar55s00
	adc	a,(iy+sxoff)		;FD 8Ar55s00
	adc	a,sxoff(hl)		;FD 8Br55s00
	adc	a,(hl+sxoff)		;FD 8Br55s00
	adc	a,sxoff(sp)		;DD 88r55s00
	adc	a,(sp+sxoff)		;DD 88r55s00
	adc	a,lxoff(ix)		;FD 89r22s11
	adc	a,(ix+lxoff)		;FD 89r22s11
	adc	a,lxoff(iy)		;FD 8Ar22s11
	adc	a,(iy+lxoff)		;FD 8Ar22s11
	adc	a,lxoff(hl)		;FD 8Br22s11
	adc	a,(hl+lxoff)		;FD 8Br22s11
	adc	a,lxoff(sp)		;DD 88r22s11
	adc	a,(sp+lxoff)		;DD 88r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	adc	a,(nn+6)		;DD 8F 8A 05
	adc	a,(ix+nn)		;FD 89 84 05
	adc	a,(iy+nn)		;FD 8A 84 05
	adc	a,(sp+nn)		;DD 88 84 05
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	adc	a,sxoff(ix)		;FD 89 55 00
	adc	a,(ix+sxoff)		;FD 89 55 00
	adc	a,sxoff(iy)		;FD 8A 55 00
	adc	a,(iy+sxoff)		;FD 8A 55 00
      .nlist
    .else				; (.con/.lst) or (.con/.rst)
      .list
	adc	a,sxoff(ix)		;DD 8E 55
	adc	a,(ix+sxoff)		;DD 8E 55
	adc	a,sxoff(iy)		;FD 8E 55
	adc	a,(iy+sxoff)		;FD 8E 55
      .nlist
    .endif
    .list
	adc	a,sxoff(hl)		;FD 8B 55 00
	adc	a,(hl+sxoff)		;FD 8B 55 00
	adc	a,sxoff(sp)		;DD 88 55 00
	adc	a,(sp+sxoff)		;DD 88 55 00
	adc	a,lxoff(ix)		;FD 89 22 11
	adc	a,(ix+lxoff)		;FD 89 22 11
	adc	a,lxoff(iy)		;FD 8A 22 11
	adc	a,(iy+lxoff)		;FD 8A 22 11
	adc	a,lxoff(hl)		;FD 8B 22 11
	adc	a,(hl+lxoff)		;FD 8B 22 11
	adc	a,lxoff(sp)		;DD 88 22 11
	adc	a,(sp+lxoff)		;DD 88 22 11
    .nlist
  .endif
.list  ; end<--
	adc	a,(ix)			;DD 8E 00
	adc	a,(iy)			;FD 8E 00
	adc	a,(hl)			;8E
	adc	a,(sp)			;DD 88 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn adc11,raofc
      .list
	adc	a,adc11(pc)		;FD 88p00q00
      .nlist
      .pcr_xtrn adc12,raofc
      .list
	adc	a,(pc+adc12)		;FD 88p00q00
      .nlist
      .pcr_xtrn adc13,raofc
      .list
	adc	a,[adc13]		;FD 88p00q00
      .nlist
    .else
      .pcr_lclx adc11
      .list
	adc	a,raofc+adc11(pc)	;FD 88p34q12
      .nlist
      .pcr_lclx adc12
      .list
	adc	a,(pc+raofc+adc12)	;FD 88p34q12
      .nlist
      .pcr_lclx adc13
      .list
	adc	a,[raofc+adc13]		;FD 88p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn adc11,raofc
      .list
	adc	a,adc11(pc)		;FD 88 34 12
      .nlist
      .pcr_xtrn adc12,raofc
      .list
	adc	a,(pc+adc12)		;FD 88 34 12
      .nlist
      .pcr_xtrn adc13,raofc
      .list
	adc	a,[adc13]		;FD 88 34 12
      .nlist
    .else
      .pcr_lclx adc11
      .list
	adc	a,raofc+adc11(pc)	;FD 88 34 12
      .nlist
      .pcr_lclx adc12
      .list
	adc	a,(pc+raofc+adc12)	;FD 88 34 12
      .nlist
      .pcr_lclx adc13
      .list
	adc	a,[raofc+adc13]		;FD 88 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	adc	a,raoff(pc)		;FD 88p34q12
	adc	a,(pc+raoff)		;FD 88p34q12
	adc	a,[raoff]		;FD 88p34q12
    .nlist
  .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	adc	a,pcr_ofst(pc)		;FD 88 34 12
      .nlist
	.pcr_ofst raofc
      .list
	adc	a,(pc+pcr_ofst)		;FD 88 34 12
      .nlist
	.pcr_ofst raofc
      .list
	adc	a,[pcr_ofst]		;FD 88 34 12
    .nlist
  .endif
.list  ; end<--
	adc	a,[.+32]		;FD 88 1C 00
	adc	a,(hl+ix)		;DD 89
	adc	a,(hl+iy)		;DD 8A
	adc	a,(ix+iy)		;DD 8B
	;***********************************************************
	; add with carry to accumulator without 'a'
	.z280
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	adc	(nn+6)			;DD 8Fr06s00
	adc	(ix+nn)			;FD 89r00s00
	adc	(iy+nn)			;FD 8Ar00s00
	adc	(hl+nn)			;FD 8Br00s00
	adc	(sp+nn)			;DD 88r00s00
	adc	sxoff(ix)		;FD 89r00s00
	adc	(ix+sxoff)		;FD 89r00s00
	adc	sxoff(iy)		;FD 8Ar00s00
	adc	(iy+sxoff)		;FD 8Ar00s00
	adc	sxoff(hl)		;FD 8Br00s00
	adc	(hl+sxoff)		;FD 8Br00s00
	adc	sxoff(sp)		;DD 88r00s00
	adc	(sp+sxoff)		;DD 88r00s00
	adc	lxoff(ix)		;FD 89r00s00
	adc	(ix+lxoff)		;FD 89r00s00
	adc	lxoff(iy)		;FD 8Ar00s00
	adc	(iy+lxoff)		;FD 8Ar00s00
	adc	lxoff(hl)		;FD 8Br00s00
	adc	(hl+lxoff)		;FD 8Br00s00
	adc	lxoff(sp)		;DD 88r00s00
	adc	(sp+lxoff)		;DD 88r00s00
      .nlist
    .else
      .list
	adc	(nn+6)			;DD 8Fr8As05
	adc	(ix+nn)			;FD 89r84s05
	adc	(iy+nn)			;FD 8Ar84s05
	adc	(hl+nn)			;FD 8Br84s05
	adc	(sp+nn)			;DD 88r84s05
	adc	sxoff(ix)		;FD 89r55s00
	adc	(ix+sxoff)		;FD 89r55s00
	adc	sxoff(iy)		;FD 8Ar55s00
	adc	(iy+sxoff)		;FD 8Ar55s00
	adc	sxoff(hl)		;FD 8Br55s00
	adc	(hl+sxoff)		;FD 8Br55s00
	adc	sxoff(sp)		;DD 88r55s00
	adc	(sp+sxoff)		;DD 88r55s00
	adc	lxoff(ix)		;FD 89r22s11
	adc	(ix+lxoff)		;FD 89r22s11
	adc	lxoff(iy)		;FD 8Ar22s11
	adc	(iy+lxoff)		;FD 8Ar22s11
	adc	lxoff(hl)		;FD 8Br22s11
	adc	(hl+lxoff)		;FD 8Br22s11
	adc	lxoff(sp)		;DD 88r22s11
	adc	(sp+lxoff)		;DD 88r22s11
      .nlist
    .endif
    .list
    .nlist
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	adc	(nn+6)			;DD 8F 8A 05
	adc	(ix+nn)			;FD 89 84 05
	adc	(iy+nn)			;FD 8A 84 05
	adc	(sp+nn)			;DD 88 84 05
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	adc	sxoff(ix)		;FD 89 55 00
	adc	(ix+sxoff)		;FD 89 55 00
	adc	sxoff(iy)		;FD 8A 55 00
	adc	(iy+sxoff)		;FD 8A 55 00
      .nlist
    .else				; (.con/.lst) or (.con/.rst)
      .list
	adc	sxoff(ix)		;DD 8E 55
	adc	(ix+sxoff)		;DD 8E 55
	adc	sxoff(iy)		;FD 8E 55
	adc	(iy+sxoff)		;FD 8E 55
      .nlist
    .endif
    .list
	adc	sxoff(hl)		;FD 8B 55 00
	adc	(hl+sxoff)		;FD 8B 55 00
	adc	sxoff(sp)		;DD 88 55 00
	adc	(sp+sxoff)		;DD 88 55 00
	adc	lxoff(ix)		;FD 89 22 11
	adc	(ix+lxoff)		;FD 89 22 11
	adc	lxoff(iy)		;FD 8A 22 11
	adc	(iy+lxoff)		;FD 8A 22 11
	adc	lxoff(hl)		;FD 8B 22 11
	adc	(hl+lxoff)		;FD 8B 22 11
	adc	lxoff(sp)		;DD 88 22 11
	adc	(sp+lxoff)		;DD 88 22 11
    .nlist
  .endif
.list  ; end<--
	adc	(ix)			;DD 8E 00
	adc	(iy)			;FD 8E 00
	adc	(hl)			;8E
	adc	(sp)			;DD 88 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn adc14,raofc
      .list
	adc	adc14(pc)		;FD 88p00q00
      .nlist
      .pcr_xtrn adc15,raofc
      .list
	adc	(pc+adc15)		;FD 88p00q00
      .nlist
      .pcr_xtrn adc16,raofc
      .list
	adc	[adc16]			;FD 88p00q00
      .nlist
    .else
      .pcr_lclx adc14
      .list
	adc	raofc+adc14(pc)		;FD 88p34q12
      .nlist
      .pcr_lclx adc15
      .list
	adc	(pc+raofc+adc15)	;FD 88p34q12
      .nlist
      .pcr_lclx adc16
      .list
	adc	[raofc+adc16]		;FD 88p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn adc14,raofc
      .list
	adc	adc14(pc)		;FD 88 34 12
      .nlist
      .pcr_xtrn adc15,raofc
      .list
	adc	(pc+adc15)		;FD 88 34 12
      .nlist
      .pcr_xtrn adc16,raofc
      .list
	adc	[adc16]			;FD 88 34 12
      .nlist
    .else
      .pcr_lclx adc14
      .list
	adc	raofc+adc14(pc)		;FD 88 34 12
      .nlist
      .pcr_lclx adc15
      .list
	adc	(pc+raofc+adc15)	;FD 88 34 12
      .nlist
      .pcr_lclx adc16
      .list
	adc	[raofc+adc16]		;FD 88 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	adc	raoff(pc)		;FD 88p34q12
	adc	(pc+raoff)		;FD 88p34q12
	adc	[raoff]			;FD 88p34q12
    .nlist
  .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	adc	pcr_ofst(pc)		;FD 88 34 12
      .nlist
	.pcr_ofst raofc
      .list
	adc	(pc+pcr_ofst)		;FD 88 34 12
      .nlist
	.pcr_ofst raofc
      .list
	adc	[pcr_ofst]		;FD 88 34 12
    .nlist
  .endif
.list  ; end<--
	adc	[.+32]			;FD 88 1C 00
	adc	(hl+ix)			;DD 89
	adc	(hl+iy)			;DD 8A
	adc	(ix+iy)			;DD 8B
	;***********************************************************
	; add with carry to register IX, IY
	adc	ix,bc			;DD ED 4A
	adc	ix,de			;DD ED 5A
	adc	ix,ix			;DD ED 6A
	adc	ix,sp			;DD ED 7A
	adc	iy,bc			;FD ED 4A
	adc	iy,de			;FD ED 5A
	adc	iy,iy			;FD ED 6A
	adc	iy,sp			;FD ED 7A
		
;*******************************************************************
;	ADD	
;		Leading 'a' operand is optional.
;		If offset is ommitted 0 is assumed.
;*******************************************************************
	;***********************************************************
	; add operand to 'a' with 'a'
	.z80
	add	a,(hl)			;86
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	add	a,offset(ix)		;DD 86r00
	add	a,offset(iy)		;FD 86r00
	add	a,(ix+offset)		;DD 86r00
	add	a,(iy+offset)		;FD 86r00
      .nlist
    .else
      .list
	add	a,offset(ix)		;DD 86r55
	add	a,offset(iy)		;FD 86r55
	add	a,(ix+offset)		;DD 86r55
	add	a,(iy+offset)		;FD 86r55
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	add	a,offset(ix)		;DD 86 55
	add	a,offset(iy)		;FD 86 55
	add	a,(ix+offset)		;DD 86 55
	add	a,(iy+offset)		;FD 86 55
    .nlist
  .endif
.list  ; end<--
	add	a,a			;87
	add	a,b			;80
	add	a,c			;81
	add	a,d			;82
	add	a,e			;83
	add	a,h			;84
	add	a,l			;85
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	add	a,#n			;C6r00
	add	a, n			;C6r00
      .nlist
    .else
      .list
	add	a,#n			;C6r20
	add	a, n			;C6r20
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	add	a,#n			;C6 20
	add	a, n			;C6 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	; add operand to 'a' without 'a'
	add	(hl)			;86	
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	add	offset(ix)		;DD 86r00
	add	offset(iy)		;FD 86r00
	add	(ix+offset)		;DD 86r00
	add	(iy+offset)		;FD 86r00
      .nlist
    .else
      .list
	add	offset(ix)		;DD 86r55
	add	offset(iy)		;FD 86r55
	add	(ix+offset)		;DD 86r55
	add	(iy+offset)		;FD 86r55
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	add	offset(ix)		;DD 86 55
	add	offset(iy)		;FD 86 55
	add	(ix+offset)		;DD 86 55
	add	(iy+offset)		;FD 86 55
    .nlist
  .endif
.list  ; end<--
	add	a			;87
	add	b			;80
	add	c			;81
	add	d			;82
	add	e			;83
	add	h			;84
	add	l			;85
.nlist ; bgn-->
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	add	#n			;C6r00
	add	 n			;C6r00
      .nlist
    .else
      .list
	add	#n			;C6r20
	add	 n			;C6r20
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	add	#n			;C6 20
	add	 n			;C6 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	; add register pair to 'hl'
	add	hl,bc			;09
	add	hl,de			;19
	add	hl,hl			;29
	add	hl,sp			;39
	;***********************************************************
	; add register pair to 'ix'
	add	ix,bc			;DD 09
	add	ix,de			;DD 19
	add	ix,ix			;DD 29
	add	ix,sp			;DD 39
	;***********************************************************
	; add register pair to 'iy'
	add	iy,bc			;FD 09
	add	iy,de			;FD 19
	add	iy,iy			;FD 29
	add	iy,sp			;FD 39
	;***********************************************************
	; add operand to 'a' with 'a'
	;  p. 5-16
	.z280
	add	a,ixh			;DD 84
	add	a,ixl			;DD 85
	add	a,iyh			;FD 84
	add	a,iyl			;FD 85
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	add	a,(nn+6)		;DD 87r06s00
	add	a,(ix+nn)		;FD 81r00s00
	add	a,(iy+nn)		;FD 82r00s00
	add	a,(hl+nn)		;FD 83r00s00
	add	a,(sp+nn)		;DD 80r00s00
	add	a,sxoff(ix)		;FD 81r00s00
	add	a,(ix+sxoff)		;FD 81r00s00
	add	a,sxoff(iy)		;FD 82r00s00
	add	a,(iy+sxoff)		;FD 82r00s00
	add	a,sxoff(hl)		;FD 83r00s00
	add	a,(hl+sxoff)		;FD 83r00s00
	add	a,sxoff(sp)		;DD 80r00s00
	add	a,(sp+sxoff)		;DD 80r00s00
	add	a,lxoff(ix)		;FD 81r00s00
	add	a,(ix+lxoff)		;FD 81r00s00
	add	a,lxoff(iy)		;FD 82r00s00
	add	a,(iy+lxoff)		;FD 82r00s00
	add	a,lxoff(hl)		;FD 83r00s00
	add	a,(hl+lxoff)		;FD 83r00s00
	add	a,lxoff(sp)		;DD 80r00s00
	add	a,(sp+lxoff)		;DD 80r00s00
      .nlist
    .else
      .list
	add	a,(nn+6)		;DD 87r8As05
	add	a,(ix+nn)		;FD 81r84s05
	add	a,(iy+nn)		;FD 82r84s05
	add	a,(hl+nn)		;FD 83r84s05
	add	a,(sp+nn)		;DD 80r84s05
	add	a,sxoff(ix)		;FD 81r55s00
	add	a,(ix+sxoff)		;FD 81r55s00
	add	a,sxoff(iy)		;FD 82r55s00
	add	a,(iy+sxoff)		;FD 82r55s00
	add	a,sxoff(hl)		;FD 83r55s00
	add	a,(hl+sxoff)		;FD 83r55s00
	add	a,sxoff(sp)		;DD 80r55s00
	add	a,(sp+sxoff)		;DD 80r55s00
	add	a,lxoff(ix)		;FD 81r22s11
	add	a,(ix+lxoff)		;FD 81r22s11
	add	a,lxoff(iy)		;FD 82r22s11
	add	a,(iy+lxoff)		;FD 82r22s11
	add	a,lxoff(hl)		;FD 83r22s11
	add	a,(hl+lxoff)		;FD 83r22s11
	add	a,lxoff(sp)		;DD 80r22s11
	add	a,(sp+lxoff)		;DD 80r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	add	a,(nn+6)		;DD 87 8A 05
	add	a,(ix+nn)		;FD 81 84 05
	add	a,(iy+nn)		;FD 82 84 05
	add	a,(hl+nn)		;FD 83 84 05
	add	a,(sp+nn)		;DD 80 84 05
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	add	a,sxoff(ix)		;FD 81 55 00
	add	a,(ix+sxoff)		;FD 81 55 00
	add	a,sxoff(iy)		;FD 82 55 00
	add	a,(iy+sxoff)		;FD 82 55 00
      .nlist
    .else				; (.con/.lst) or (.con/.rst)
      .list
	add	a,sxoff(ix)		;DD 86 55
	add	a,(ix+sxoff)		;DD 86 55
	add	a,sxoff(iy)		;FD 86 55
	add	a,(iy+sxoff)		;FD 86 55
      .nlist
    .endif
    .list
	add	a,sxoff(hl)		;FD 83 55 00
	add	a,(hl+sxoff)		;FD 83 55 00
	add	a,sxoff(sp)		;DD 80 55 00
	add	a,(sp+sxoff)		;DD 80 55 00
	add	a,lxoff(ix)		;FD 81 22 11
	add	a,(ix+lxoff)		;FD 81 22 11
	add	a,lxoff(iy)		;FD 82 22 11
	add	a,(iy+lxoff)		;FD 82 22 11
	add	a,lxoff(hl)		;FD 83 22 11
	add	a,(hl+lxoff)		;FD 83 22 11
	add	a,lxoff(sp)		;DD 80 22 11
	add	a,(sp+lxoff)		;DD 80 22 11
    .nlist
  .endif
.list  ; end<--
	add	a,(ix)			;DD 86 00
	add	a,(iy)			;FD 86 00
	add	a,(hl)			;86
	add	a,(sp)			;DD 80 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn add01,raofc
      .list
	add	a,add01(pc)		;FD 80p00q00
      .nlist
      .pcr_xtrn add02,raofc
      .list
	add	a,(pc+add02)		;FD 80p00q00
      .nlist
      .pcr_xtrn add03,raofc
      .list
	add	a,[add03]		;FD 80p00q00
      .nlist
    .else
      .pcr_lclx add01
      .list
	add	a,raofc+add01(pc)	;FD 80p34q12
      .nlist
      .pcr_lclx add02
      .list
	add	a,(pc+raofc+add02)	;FD 80p34q12
      .nlist
      .pcr_lclx add03
      .list
	add	a,[raofc+add03]		;FD 80p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn add01,raofc
      .list
	add	a,add01(pc)		;FD 80 34 12
      .nlist
      .pcr_xtrn add02,raofc
      .list
	add	a,(pc+add02)		;FD 80 34 12
      .nlist
      .pcr_xtrn add03,raofc
      .list
	add	a,[add03]		;FD 80 34 12
      .nlist
    .else
      .pcr_lclx add01
      .list
	add	a,raofc+add01(pc)	;FD 80 34 12
      .nlist
      .pcr_lclx add02
      .list
	add	a,(pc+raofc+add02)	;FD 80 34 12
      .nlist
      .pcr_lclx add03
      .list
	add	a,[raofc+add03]		;FD 80 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	add	a,raoff(pc)		;FD 80p34q12
	add	a,(pc+raoff)		;FD 80p34q12
	add	a,[raoff]		;FD 80p34q12
    .nlist
  .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	add	a,pcr_ofst(pc)		;FD 80 34 12
      .nlist
	.pcr_ofst raofc
      .list
	add	a,(pc+pcr_ofst)		;FD 80 34 12
      .nlist
	.pcr_ofst raofc
      .list
	add	a,[pcr_ofst]		;FD 80 34 12
    .nlist
  .endif
.list  ; end<--
	add	a,[.+raofc]		;FD 80 30 12
	add	a,(hl+ix)		;DD 81
	add	a,(hl+iy)		;DD 82
	add	a,(ix+iy)		;DD 83
	;***********************************************************
	; add operand to 'a' without 'a'
	.z280
	add	ixh			;DD 84
	add	ixl			;DD 85
	add	iyh			;FD 84
	add	iyl			;FD 85
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	add	(nn+6)			;DD 87r06s00
	add	(ix+nn)			;FD 81r00s00
	add	(iy+nn)			;FD 82r00s00
	add	(hl+nn)			;FD 83r00s00
	add	(sp+nn)			;DD 80r00s00
	add	sxoff(ix)		;FD 81r00s00
	add	(ix+sxoff)		;FD 81r00s00
	add	sxoff(iy)		;FD 82r00s00
	add	(iy+sxoff)		;FD 82r00s00
	add	sxoff(hl)		;FD 83r00s00
	add	(hl+sxoff)		;FD 83r00s00
	add	sxoff(sp)		;DD 80r00s00
	add	(sp+sxoff)		;DD 80r00s00
	add	lxoff(ix)		;FD 81r00s00
	add	(ix+lxoff)		;FD 81r00s00
	add	lxoff(iy)		;FD 82r00s00
	add	(iy+lxoff)		;FD 82r00s00
	add	lxoff(hl)		;FD 83r00s00
	add	(hl+lxoff)		;FD 83r00s00
	add	lxoff(sp)		;DD 80r00s00
	add	(sp+lxoff)		;DD 80r00s00
      .nlist
    .else
      .list
	add	(nn+6)			;DD 87r8As05
	add	(ix+nn)			;FD 81r84s05
	add	(iy+nn)			;FD 82r84s05
	add	(hl+nn)			;FD 83r84s05
	add	(sp+nn)			;DD 80r84s05
	add	sxoff(ix)		;FD 81r55s00
	add	(ix+sxoff)		;FD 81r55s00
	add	sxoff(iy)		;FD 82r55s00
	add	(iy+sxoff)		;FD 82r55s00
	add	sxoff(hl)		;FD 83r55s00
	add	(hl+sxoff)		;FD 83r55s00
	add	sxoff(sp)		;DD 80r55s00
	add	(sp+sxoff)		;DD 80r55s00
	add	lxoff(ix)		;FD 81r22s11
	add	(ix+lxoff)		;FD 81r22s11
	add	lxoff(iy)		;FD 82r22s11
	add	(iy+lxoff)		;FD 82r22s11
	add	lxoff(hl)		;FD 83r22s11
	add	(hl+lxoff)		;FD 83r22s11
	add	lxoff(sp)		;DD 80r22s11
	add	(sp+lxoff)		;DD 80r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	add	(nn+6)			;DD 87 8A 05
	add	(ix+nn)			;FD 81 84 05
	add	(iy+nn)			;FD 82 84 05
	add	(hl+nn)			;FD 83 84 05
	add	(sp+nn)			;DD 80 84 05
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	add	sxoff(ix)		;FD 81 55 00
	add	(ix+sxoff)		;FD 81 55 00
	add	sxoff(iy)		;FD 82 55 00
	add	(iy+sxoff)		;FD 82 55 00
      .nlist
    .else				; (.con/.lst) or (.con/.rst)
      .list
	add	sxoff(ix)		;DD 86 55
	add	(ix+sxoff)		;DD 86 55
	add	sxoff(iy)		;FD 86 55
	add	(iy+sxoff)		;FD 86 55
      .nlist
    .endif
    .list
	add	sxoff(hl)		;FD 83 55 00
	add	(hl+sxoff)		;FD 83 55 00
	add	sxoff(sp)		;DD 80 55 00
	add	(sp+sxoff)		;DD 80 55 00
	add	lxoff(ix)		;FD 81 22 11
	add	(ix+lxoff)		;FD 81 22 11
	add	lxoff(iy)		;FD 82 22 11
	add	(iy+lxoff)		;FD 82 22 11
	add	lxoff(hl)		;FD 83 22 11
	add	(hl+lxoff)		;FD 83 22 11
	add	lxoff(sp)		;DD 80 22 11
	add	(sp+lxoff)		;DD 80 22 11
    .nlist
  .endif
.list  ; end<--
	add	(ix)			;DD 86 00
	add	(iy)			;FD 86 00
	add	(hl)			;86
	add	(sp)			;DD 80 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn add04,raofc
      .list
	add	add04(pc)		;FD 80p00q00
      .nlist
      .pcr_xtrn add05,raofc
      .list
	add	(pc+add05)		;FD 80p00q00
      .nlist
      .pcr_xtrn add06,raofc
      .list
	add	[add06]			;FD 80p00q00
      .nlist
    .else
      .pcr_lclx add04
      .list
	add	raofc+add04(pc)		;FD 80p34q12
      .nlist
      .pcr_lclx add05
      .list
	add	(pc+raofc+add05)	;FD 80p34q12
      .nlist
      .pcr_lclx add06
      .list
	add	[raofc+add06]		;FD 80p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn add04,raofc
      .list
	add	add04(pc)		;FD 80 34 12
      .nlist
      .pcr_xtrn add05,raofc
      .list
	add	(pc+add05)		;FD 80 34 12
      .nlist
      .pcr_xtrn add06,raofc
      .list
	add	[add06]			;FD 80 34 12
      .nlist
    .else
      .pcr_lclx add04
      .list
	add	raofc+add04(pc)		;FD 80 34 12
      .nlist
      .pcr_lclx add05
      .list
	add	(pc+raofc+add05)	;FD 80 34 12
      .nlist
      .pcr_lclx add06
      .list
	add	[raofc+add06]		;FD 80 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	add	raoff(pc)		;FD 80p34q12
	add	(pc+raoff)		;FD 80p34q12
	add	[raoff]			;FD 80p34q12
    .nlist
  .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raoff
      .list
	add	pcr_ofst(pc)		;FD 80 34 12
      .nlist
	.pcr_ofst raoff
      .list
	add	(pc+pcr_ofst)		;FD 80 34 12
      .nlist
	.pcr_ofst raoff
      .list
	add	[pcr_ofst]		;FD 80 34 12
    .nlist
  .endif
.list  ; end<--
	add	[.+raofc]		;FD 80 30 12
	add	(hl+ix)			;DD 81
	add	(hl+iy)			;DD 82
	add	(ix+iy)			;DD 83
	;***********************************************************
	add	hl,a			;ED 6D
	add	ix,a			;DD ED 6D
	add	iy,a			;FD ED 6D

;*******************************************************************
;	ADDW	
;*******************************************************************
	;***********************************************************
	.z280
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	addw	hl,#n			;FD ED F6r00s00
	addw	hl,#daddr		;FD ED F6r00s00
	addw	hl,(daddr)		;DD ED D6r00s00
	addw	hl,sxoff(ix)		;FD ED C6r00s00
	addw	hl,(ix+sxoff)		;FD ED C6r00s00
	addw	hl,lxoff(ix)		;FD ED C6r00s00
	addw	hl,(ix+lxoff)		;FD ED C6r00s00
	addw	hl,sxoff(iy)		;FD ED D6r00s00
	addw	hl,(iy+sxoff)		;FD ED D6r00s00
	addw	hl,lxoff(iy)		;FD ED D6r00s00
	addw	hl,(iy+lxoff)		;FD ED D6r00s00
      .nlist
    .else
      .list
	addw	hl,#n			;FD ED F6r20s00
	addw	hl,#daddr		;FD ED F6r44s33
	addw	hl,(daddr)		;DD ED D6r44s33
	addw	hl,sxoff(ix)		;FD ED C6r55s00
	addw	hl,(ix+sxoff)		;FD ED C6r55s00
	addw	hl,lxoff(ix)		;FD ED C6r22s11
	addw	hl,(ix+lxoff)		;FD ED C6r22s11
	addw	hl,sxoff(iy)		;FD ED D6r55s00
	addw	hl,(iy+sxoff)		;FD ED D6r55s00
	addw	hl,lxoff(iy)		;FD ED D6r22s11
	addw	hl,(iy+lxoff)		;FD ED D6r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	addw	hl,#n			;FD ED F6 20 00
	addw	hl,#daddr		;FD ED F6 44 33
	addw	hl,(daddr)		;DD ED D6 44 33
	addw	hl,sxoff(ix)		;FD ED C6 55 00
	addw	hl,(ix+sxoff)		;FD ED C6 55 00
	addw	hl,lxoff(ix)		;FD ED C6 22 11
	addw	hl,(ix+lxoff)		;FD ED C6 22 11
	addw	hl,sxoff(iy)		;FD ED D6 55 00
	addw	hl,(iy+sxoff)		;FD ED D6 55 00
	addw	hl,lxoff(iy)		;FD ED D6 22 11
	addw	hl,(iy+lxoff)		;FD ED D6 22 11
    .nlist
  .endif
.list 	; end<--
	addw	hl,(hl)			;DD ED C6
	;***********************************************************
	; add register pair to 'hl'
	addw	hl,bc			;09
	addw	hl,de			;19
	addw	hl,hl			;29
	addw	hl,sp			;39
	;***********************************************************
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn addw01,raofc,5
      .list
	addw	hl,addw01(pc)		;DD ED F6p00q00
      .nlist
      .pcr_xtrn addw02,raofc,5
      .list
	addw	hl,(pc+addw02)		;DD ED F6p00q00
      .nlist
      .pcr_xtrn addw03,raofc,5
      .list
	addw	hl,[addw03]		;DD ED F6p00q00
      .nlist
    .else
      .pcr_lclx addw01,5
      .list
	addw	hl,raofc+addw01(pc)	;DD ED F6p34q12
      .nlist
      .pcr_lclx addw02,5
      .list
	addw	hl,(pc+raofc+addw02)	;DD ED F6p34q12
      .nlist
      .pcr_lclx addw03,5
      .list
	addw	hl,[raofc+addw03]	;DD ED F6p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn addw01,raofc,5
      .list
	addw	hl,addw01(pc)		;DD ED F6 34 12
      .nlist
      .pcr_xtrn addw02,raofc,5
      .list
	addw	hl,(pc+addw02)		;DD ED F6 34 12
      .nlist
      .pcr_xtrn addw03,raofc,5
      .list
	addw	hl,[addw03]		;DD ED F6 34 12
      .nlist
    .else
      .pcr_lclx addw01,5
      .list
	addw	hl,raofc+addw01(pc)	;DD ED F6 34 12
      .nlist
      .pcr_lclx addw02,5
      .list
	addw	hl,(pc+raofc+addw02)	;DD ED F6 34 12
      .nlist
      .pcr_lclx addw03,5
      .list
	addw	hl,[raofc+addw03]	;DD ED F6 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	addw	hl,raoff(pc)		;DD ED F6p34q12
	addw	hl,(pc+raoff)		;DD ED F6p34q12
	addw	hl,[raoff]		;DD ED F6p34q12
    .nlist
  .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc,5
      .list
	addw	hl,pcr_ofst(pc)		;DD ED F6 34 12
      .nlist
	.pcr_ofst raofc,5
      .list
	addw	hl,(pc+pcr_ofst)	;DD ED F6 34 12
      .nlist
	.pcr_ofst raofc,5
      .list
	addw	hl,[pcr_ofst]		;DD ED F6 34 12
    .nlist
  .endif
.list  ; end<--
	addw	hl,[.+nc]		;DD ED F6 1B 00

	;***********************************************************
	; Equivalent to addw
	;  p. 5-18
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	add	hl,#n			;FD ED F6r00s00
	add	hl,#daddr		;FD ED F6r00s00
	add	hl,(daddr)		;DD ED D6r00s00
	add	hl,sxoff(ix)		;FD ED C6r00s00
	add	hl,(ix+sxoff)		;FD ED C6r00s00
	add	hl,lxoff(ix)		;FD ED C6r00s00
	add	hl,(ix+lxoff)		;FD ED C6r00s00
	add	hl,sxoff(iy)		;FD ED D6r00s00
	add	hl,(iy+sxoff)		;FD ED D6r00s00
	add	hl,lxoff(iy)		;FD ED D6r00s00
	add	hl,(iy+lxoff)		;FD ED D6r00s00
      .nlist
    .else
      .list
	add	hl,#n			;FD ED F6r20s00
	add	hl,#daddr		;FD ED F6r44s33
	add	hl,(daddr)		;DD ED D6r44s33
	add	hl,sxoff(ix)		;FD ED C6r55s00
	add	hl,(ix+sxoff)		;FD ED C6r55s00
	add	hl,lxoff(ix)		;FD ED C6r22s11
	add	hl,(ix+lxoff)		;FD ED C6r22s11
	add	hl,sxoff(iy)		;FD ED D6r55s00
	add	hl,(iy+sxoff)		;FD ED D6r55s00
	add	hl,lxoff(iy)		;FD ED D6r22s11
	add	hl,(iy+lxoff)		;FD ED D6r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	add	hl,#n			;FD ED F6 20 00
	add	hl,#daddr		;FD ED F6 44 33
	add	hl,(daddr)		;DD ED D6 44 33
	add	hl,sxoff(ix)		;FD ED C6 55 00
	add	hl,(ix+sxoff)		;FD ED C6 55 00
	add	hl,lxoff(ix)		;FD ED C6 22 11
	add	hl,(ix+lxoff)		;FD ED C6 22 11
	add	hl,sxoff(iy)		;FD ED D6 55 00
	add	hl,(iy+sxoff)		;FD ED D6 55 00
	add	hl,lxoff(iy)		;FD ED D6 22 11
	add	hl,(iy+lxoff)		;FD ED D6 22 11
    .nlist
  .endif
.list 	; end<--

;*******************************************************************
;	AND	
;		Leading 'a' operand is optional.
;		If offset is ommitted 0 is assumed.
;*******************************************************************
	;***********************************************************
	; logical 'and' operand with 'a'
	.z80
	and	a,(hl)			;A6
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	and	a,offset(ix)		;DD A6r00
	and	a,offset(iy)		;FD A6r00
	and	a,(ix+offset)		;DD A6r00
	and	a,(iy+offset)		;FD A6r00
      .nlist
    .else
      .list
	and	a,offset(ix)		;DD A6r55
	and	a,offset(iy)		;FD A6r55
	and	a,(ix+offset)		;DD A6r55
	and	a,(iy+offset)		;FD A6r55
      .nlist
    .endif
  .else					; (.con/.lst) or (.con/.rst)
    .list
	and	a,offset(ix)		;DD A6 55
	and	a,offset(iy)		;FD A6 55
	and	a,(ix+offset)		;DD A6 55
	and	a,(iy+offset)		;FD A6 55
    .nlist
  .endif
.list  ; end<--
	and	a,a			;A7
	and	a,b			;A0
	and	a,c			;A1
	and	a,d			;A2
	and	a,e			;A3
	and	a,h			;A4
	and	a,l			;A5
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	and	a,#n			;E6r00
	and	a, n			;E6r00
      .nlist
    .else
      .list
	and	a,#n			;E6r20
	and	a, n			;E6r20
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	and	a,#n			;E6 20
	and	a, n			;E6 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	; logical 'and' operand without 'a'
	.z80
	and	(hl)			;A6
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	and	offset(ix)		;DD A6r00
	and	offset(iy)		;FD A6r00
	and	(ix+offset)		;DD A6r00
	and	(iy+offset)		;FD A6r00
      .nlist
    .else
      .list
	and	offset(ix)		;DD A6r55
	and	offset(iy)		;FD A6r55
	and	(ix+offset)		;DD A6r55
	and	(iy+offset)		;FD A6r55
      .nlist
    .endif
  .else					; (.con/.lst) or (.con/.rst)
    .list
	and	offset(ix)		;DD A6 55
	and	offset(iy)		;FD A6 55
	and	(ix+offset)		;DD A6 55
	and	(iy+offset)		;FD A6 55
    .nlist
  .endif
.list  ; end<--
	and	a			;A7
	and	b			;A0
	and	c			;A1
	and	d			;A2
	and	e			;A3
	and	h			;A4
	and	l			;A5
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	and	#n			;E6r00
	and	 n			;E6r00
      .nlist
    .else
      .list
	and	#n			;E6r20
	and	 n			;E6r20
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	and	#n			;E6 20
	and	 n			;E6 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	; logical 'and' operand with 'a'
	;  p. 5--19
	.z280
	and	a,ixh			;DD A4
	and	a,ixl			;DD A5
	and	a,iyh			;FD A4
	and	a,iyl			;FD A5
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	and	a,(n+6)			;DD A7r06s00
	and	a,(ix+nn)		;FD A1r00s00
	and	a,(iy+nn)		;FD A2r00s00
	and	a,(hl+nn)		;FD A3r00s00
	and	a,(sp+nn)		;DD A0r00s00
	and	a,sxoff(ix)		;FD A1r00s00
	and	a,(ix+sxoff)		;FD A1r00s00
	and	a,sxoff(iy)		;FD A2r00s00
	and	a,(iy+sxoff)		;FD A2r00s00
	and	a,sxoff(hl)		;FD A3r00s00
	and	a,(hl+sxoff)		;FD A3r00s00
	and	a,sxoff(sp)		;DD A0r00s00
	and	a,(sp+sxoff)		;DD A0r00s00
	and	a,lxoff(ix)		;FD A1r00s00
	and	a,(ix+lxoff)		;FD A1r00s00
	and	a,lxoff(iy)		;FD A2r00s00
	and	a,(iy+lxoff)		;FD A2r00s00
	and	a,lxoff(hl)		;FD A3r00s00
	and	a,(hl+lxoff)		;FD A3r00s00
	and	a,lxoff(sp)		;DD A0r00s00
	and	a,(sp+lxoff)		;DD A0r00s00
      .nlist
    .else
      .list
	and	a,(n+6)			;DD A7r26s00
	and	a,(ix+nn)		;FD A1r84s05
	and	a,(iy+nn)		;FD A2r84s05
	and	a,(hl+nn)		;FD A3r84s05
	and	a,(sp+nn)		;DD A0r84s05
	and	a,sxoff(ix)		;FD A1r55s00
	and	a,(ix+sxoff)		;FD A1r55s00
	and	a,sxoff(iy)		;FD A2r55s00
	and	a,(iy+sxoff)		;FD A2r55s00
	and	a,sxoff(hl)		;FD A3r55s00
	and	a,(hl+sxoff)		;FD A3r55s00
	and	a,sxoff(sp)		;DD A0r55s00
	and	a,(sp+sxoff)		;DD A0r55s00
	and	a,lxoff(ix)		;FD A1r22s11
	and	a,(ix+lxoff)		;FD A1r22s11
	and	a,lxoff(iy)		;FD A2r22s11
	and	a,(iy+lxoff)		;FD A2r22s11
	and	a,lxoff(hl)		;FD A3r22s11
	and	a,(hl+lxoff)		;FD A3r22s11
	and	a,lxoff(sp)		;DD A0r22s11
	and	a,(sp+lxoff)		;DD A0r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	and	a,(n+6)			;DD A7 26 00
	and	a,(ix+nn)		;FD A1 84 05
	and	a,(iy+nn)		;FD A2 84 05
	and	a,(hl+nn)		;FD A3 84 05
	and	a,(sp+nn)		;DD A0 84 05
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	and	a,sxoff(ix)		;FD A1 55 00
	and	a,(ix+sxoff)		;FD A1 55 00
	and	a,sxoff(iy)		;FD A2 55 00
	and	a,(iy+sxoff)		;FD A2 55 00
      .nlist
    .else				; (.con/.lst) or (.con/.rst)
      .list
	and	a,sxoff(ix)		;DD A6 55
	and	a,(ix+sxoff)		;DD A6 55
	and	a,sxoff(iy)		;FD A6 55
	and	a,(iy+sxoff)		;FD A6 55
      .nlist
    .endif
    .list
	and	a,sxoff(hl)		;FD A3 55 00
	and	a,(hl+sxoff)		;FD A3 55 00
	and	a,sxoff(sp)		;DD A0 55 00
	and	a,(sp+sxoff)		;DD A0 55 00
	and	a,lxoff(ix)		;FD A1 22 11
	and	a,(ix+lxoff)		;FD A1 22 11
	and	a,lxoff(iy)		;FD A2 22 11
	and	a,(iy+lxoff)		;FD A2 22 11
	and	a,lxoff(hl)		;FD A3 22 11
	and	a,(hl+lxoff)		;FD A3 22 11
	and	a,lxoff(sp)		;DD A0 22 11
	and	a,(sp+lxoff)		;DD A0 22 11
    .nlist
  .endif
.list  ; end<--
	and	a,(ix)			;DD A6 00
	and	a,(iy)			;FD A6 00
	and	a,(hl)			;A6
	and	a,(sp)			;DD A0 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn and01,raofc
      .list
	and	a,and01(pc)		;FD A0p00q00
      .nlist
      .pcr_xtrn and02,raofc
      .list
	and	a,(pc+and02)		;FD A0p00q00
      .nlist
      .pcr_xtrn and03,raofc
      .list
	and	a,[and03]		;FD A0p00q00
      .nlist
    .else
      .pcr_lclx and01
      .list
	and	a,raofc+and01(pc)	;FD A0p34q12
      .nlist
      .pcr_lclx and02
      .list
	and	a,(pc+raofc+and02)	;FD A0p34q12
      .nlist
      .pcr_lclx and03
      .list
	and	a,[raofc+and03]		;FD A0p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn and01,raofc
      .list
	and	a,and01(pc)		;FD A0 34 12
      .nlist
      .pcr_xtrn and02,raofc
      .list
	and	a,(pc+and02)		;FD A0 34 12
      .nlist
      .pcr_xtrn and03,raofc
      .list
	and	a,[and03]		;FD A0 34 12
      .nlist
    .else
      .pcr_lclx and01
      .list
	and	a,raofc+and01(pc)	;FD A0 34 12
      .nlist
      .pcr_lclx and02
      .list
	and	a,(pc+raofc+and02)	;FD A0 34 12
      .nlist
      .pcr_lclx and03
      .list
	and	a,[raofc+and03]		;FD A0 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	and	a,raoff(pc)		;FD A0p34q12
	and	a,(pc+raoff)		;FD A0p34q12
	and	a,[raoff]		;FD A0p34q12
    .nlist
  .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	and	a,pcr_ofst(pc)		;FD A0 34 12
      .nlist
	.pcr_ofst raofc
      .list
	and	a,(pc+pcr_ofst)	;FD A0 34 12
      .nlist
	.pcr_ofst raofc
      .list
	and	a,[pcr_ofst]		;FD A0 34 12
    .nlist
  .endif
.list  ; end<--
	and	a,[.+32]		;FD A0 1C 00
	and	a,(pc+(.+raofc))	;FD A0 30 12
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	and	a,-nc+x(sp)		;DD A0rE0sFF
      .nlist
    .else
      .list
	and	a,-n(sp)		;DD A0rE0sFF
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .list
	and	a,-nc+x(sp)		;DD A0 E0 FF
      .nlist
    .else
      .list
	and	a,-n(sp)		;DD A0 E0 FF
      .nlist
    .endif
  .endif
  .ifeq C_LR				; (.con/.lst) or (.con/.rst)
    .list
	and	a,-n(sp)		;DD A0 E0 FF
    .nlist
  .endif
.list  ; end<--
	and	a,(hl+ix)		;DD A1
	and	a,(hl+iy)		;DD A2
	and	a,(ix+iy)		;DD A3
	;***********************************************************
	; logical 'and' operand without 'a'
	;  p. 5--19
	.z280
	and	ixh			;DD A4
	and	ixl			;DD A5
	and	iyh			;FD A4
	and	iyl			;FD A5
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	and	(daddr)			;DD A7r00s00
	and	lxoff(ix)		;FD A1r00s00
	and	(iy+lxoff)		;FD A2r00s00
	and	lxoff(hl)		;FD A3r00s00
      .nlist
    .else
      .list
	and	(daddr)			;DD A7r44s33
	and	lxoff(ix)		;FD A1r22s11
	and	(iy+lxoff)		;FD A2r22s11
	and	lxoff(hl)		;FD A3r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	and	(daddr)			;DD A7 44 33
	and	lxoff(ix)		;FD A1 22 11
	and	(iy+lxoff)		;FD A2 22 11
	and	lxoff(hl)		;FD A3 22 11
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn and04,raofc
      .list
	and	and04(pc)		;FD A0p00q00
      .nlist
      .pcr_xtrn and05,raofc
      .list
	and	(pc+and05)		;FD A0p00q00
      .nlist
      .pcr_xtrn and06,raofc
      .list
	and	[and06]			;FD A0p00q00
      .nlist
    .else
      .pcr_lclx and04
      .list
	and	raofc+and04(pc)		;FD A0p34q12
      .nlist
      .pcr_lclx and05
      .list
	and	(pc+raofc+and05)	;FD A0p34q12
      .nlist
      .pcr_lclx and06
      .list
	and	[raofc+and06]		;FD A0p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn and04,raofc
      .list
	and	and04(pc)		;FD A0 34 12
      .nlist
      .pcr_xtrn and05,raofc
      .list
	and	(pc+and05)		;FD A0 34 12
      .nlist
      .pcr_xtrn and06,raofc
      .list
	and	[and06]			;FD A0 34 12
      .nlist
    .else
      .pcr_lclx and04
      .list
	and	raofc+and04(pc)		;FD A0 34 12
      .nlist
      .pcr_lclx and05
      .list
	and	(pc+raofc+and05)	;FD A0 34 12
      .nlist
      .pcr_lclx and06
      .list
	and	[raofc+and06]		;FD A0 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	and	raoff(pc)		;FD A0p34q12
	and	(pc+raoff)		;FD A0p34q12
	and	[raoff]			;FD A0p34q12
    .nlist
  .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	and	pcr_ofst(pc)		;FD A0 34 12
      .nlist
	.pcr_ofst raofc
      .list
	and	(pc+pcr_ofst)		;FD A0 34 12
      .nlist
	.pcr_ofst raofc
      .list
	and	[pcr_ofst]		;FD A0 34 12
    .nlist
  .endif
.list  ; end<--
	and	[.+32]			;FD A0 1C 00
	and	(pc+(.+raofc))		;FD A0 30 12
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	and	-nc+x(sp)		;DD A0rE0sFF
      .nlist
    .else
      .list
	and	-n(sp)			;DD A0rE0sFF
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .list
	and	-nc+x(sp)		;DD A0 E0 FF
      .nlist
    .else
      .list
	and	-n(sp)			;DD A0 E0 FF
      .nlist
    .endif
  .endif
  .ifeq C_LR				; (.con/.lst) or (.con/.rst)
    .list
	and	-n(sp)			;DD A0 E0 FF
    .nlist
  .endif
.list  ; end<--
	and	(hl+ix)			;DD A1
	and	(hl+iy)			;DD A2
	and	(ix+iy)			;DD A3

;*******************************************************************
;	BIT	
;*******************************************************************
	;***********************************************************
	; test bit of location or register
	.z80
	bit	0,(hl)			;CB 46
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	bit	0,offset(ix)		;DD CBr00 46
	bit	0,offset(iy)		;FD CBr00 46
	bit	0,(ix+offset)		;DD CBr00 46
	bit	0,(iy+offset)		;FD CBr00 46
      .nlist
    .else
      .list
	bit	0,offset(ix)		;DD CBr55 46
	bit	0,offset(iy)		;FD CBr55 46
	bit	0,(ix+offset)		;DD CBr55 46
	bit	0,(iy+offset)		;FD CBr55 46
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	bit	0,offset(ix)		;DD CB 55 46
	bit	0,offset(iy)		;FD CB 55 46
	bit	0,(ix+offset)		;DD CB 55 46
	bit	0,(iy+offset)		;FD CB 55 46
    .nlist
  .endif
.list  ; end<--
	bit	0,a			;CB 47
	bit	0,b			;CB 40
	bit	0,c			;CB 41
	bit	0,d			;CB 42
	bit	0,e			;CB 43
	bit	0,h			;CB 44
	bit	0,l			;CB 45
	bit	1,(hl)			;CB 4E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	bit	1,offset(ix)		;DD CBr00 4E
	bit	1,offset(iy)		;FD CBr00 4E
	bit	1,(ix+offset)		;DD CBr00 4E
	bit	1,(iy+offset)		;FD CBr00 4E
      .nlist
    .else
      .list
	bit	1,offset(ix)		;DD CBr55 4E
	bit	1,offset(iy)		;FD CBr55 4E
	bit	1,(ix+offset)		;DD CBr55 4E
	bit	1,(iy+offset)		;FD CBr55 4E
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	bit	1,offset(ix)		;DD CB 55 4E
	bit	1,offset(iy)		;FD CB 55 4E
	bit	1,(ix+offset)		;DD CB 55 4E
	bit	1,(iy+offset)		;FD CB 55 4E
    .nlist
  .endif
.list  ; end<--
	bit	1,a			;CB 4F
	bit	1,b			;CB 48
	bit	1,c			;CB 49
	bit	1,d			;CB 4A
	bit	1,e			;CB 4B
	bit	1,h			;CB 4C
	bit	1,l			;CB 4D
	bit	2,(hl)			;CB 56
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	bit	2,offset(ix)		;DD CBr00 56
	bit	2,offset(iy)		;FD CBr00 56
	bit	2,(ix+offset)		;DD CBr00 56
	bit	2,(iy+offset)		;FD CBr00 56
      .nlist
    .else
      .list
	bit	2,offset(ix)		;DD CBr55 56
	bit	2,offset(iy)		;FD CBr55 56
	bit	2,(ix+offset)		;DD CBr55 56
	bit	2,(iy+offset)		;FD CBr55 56
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	bit	2,offset(ix)		;DD CB 55 56
	bit	2,offset(iy)		;FD CB 55 56
	bit	2,(ix+offset)		;DD CB 55 56
	bit	2,(iy+offset)		;FD CB 55 56
    .nlist
  .endif
.list  ; end<--
	bit	2,a			;CB 57
	bit	2,b			;CB 50
	bit	2,c			;CB 51
	bit	2,d			;CB 52
	bit	2,e			;CB 53
	bit	2,h			;CB 54
	bit	2,l			;CB 55
	bit	3,(hl)			;CB 5E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	bit	3,offset(ix)		;DD CBr00 5E
	bit	3,offset(iy)		;FD CBr00 5E
	bit	3,(ix+offset)		;DD CBr00 5E
	bit	3,(iy+offset)		;FD CBr00 5E
      .nlist
    .else
      .list
	bit	3,offset(ix)		;DD CBr55 5E
	bit	3,offset(iy)		;FD CBr55 5E
	bit	3,(ix+offset)		;DD CBr55 5E
	bit	3,(iy+offset)		;FD CBr55 5E
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	bit	3,offset(ix)		;DD CB 55 5E
	bit	3,offset(iy)		;FD CB 55 5E
	bit	3,(ix+offset)		;DD CB 55 5E
	bit	3,(iy+offset)		;FD CB 55 5E
    .nlist
  .endif
.list  ; end<--
	bit	3,a			;CB 5F
	bit	3,b			;CB 58
	bit	3,c			;CB 59
	bit	3,d			;CB 5A
	bit	3,e			;CB 5B
	bit	3,h			;CB 5C
	bit	3,l			;CB 5D
	bit	4,(hl)			;CB 66
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
     .ifdef .EXLR
      .list
	bit	4,offset(ix)		;DD CBr00 66
	bit	4,offset(iy)		;FD CBr00 66
	bit	4,(ix+offset)		;DD CBr00 66
	bit	4,(iy+offset)		;FD CBr00 66
      .nlist
    .else
      .list
	bit	4,offset(ix)		;DD CBr55 66
	bit	4,offset(iy)		;FD CBr55 66
	bit	4,(ix+offset)		;DD CBr55 66
	bit	4,(iy+offset)		;FD CBr55 66
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	bit	4,offset(ix)		;DD CB 55 66
	bit	4,offset(iy)		;FD CB 55 66
	bit	4,(ix+offset)		;DD CB 55 66
	bit	4,(iy+offset)		;FD CB 55 66
    .nlist
  .endif
.list  ; end<--
	bit	4,a			;CB 67
	bit	4,b			;CB 60
	bit	4,c			;CB 61
	bit	4,d			;CB 62
	bit	4,e			;CB 63
	bit	4,h			;CB 64
	bit	4,l			;CB 65
	bit	5,(hl)			;CB 6E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	bit	5,offset(ix)		;DD CBr00 6E
	bit	5,offset(iy)		;FD CBr00 6E
	bit	5,(ix+offset)		;DD CBr00 6E
	bit	5,(iy+offset)		;FD CBr00 6E
      .nlist
    .else
      .list
	bit	5,offset(ix)		;DD CBr55 6E
	bit	5,offset(iy)		;FD CBr55 6E
	bit	5,(ix+offset)		;DD CBr55 6E
	bit	5,(iy+offset)		;FD CBr55 6E
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	bit	5,offset(ix)		;DD CB 55 6E
	bit	5,offset(iy)		;FD CB 55 6E
	bit	5,(ix+offset)		;DD CB 55 6E
	bit	5,(iy+offset)		;FD CB 55 6E
    .nlist
  .endif
.list  ; end<--
	bit	5,a			;CB 6F
	bit	5,b			;CB 68
	bit	5,c			;CB 69
	bit	5,d			;CB 6A
	bit	5,e			;CB 6B
	bit	5,h			;CB 6C
	bit	5,l			;CB 6D
	bit	6,(hl)			;CB 76
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	bit	6,offset(ix)		;DD CBr00 76
	bit	6,offset(iy)		;FD CBr00 76
	bit	6,(ix+offset)		;DD CBr00 76
	bit	6,(iy+offset)		;FD CBr00 76
      .nlist
    .else
      .list
	bit	6,offset(ix)		;DD CBr55 76
	bit	6,offset(iy)		;FD CBr55 76
	bit	6,(ix+offset)		;DD CBr55 76
	bit	6,(iy+offset)		;FD CBr55 76
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	bit	6,offset(ix)		;DD CB 55 76
	bit	6,offset(iy)		;FD CB 55 76
	bit	6,(ix+offset)		;DD CB 55 76
	bit	6,(iy+offset)		;FD CB 55 76
    .nlist
  .endif
.list  ; end<--
	bit	6,a			;CB 77
	bit	6,b			;CB 70
	bit	6,c			;CB 71
	bit	6,d			;CB 72
	bit	6,e			;CB 73
	bit	6,h			;CB 74
	bit	6,l			;CB 75
	bit	7,(hl)			;CB 7E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
 	bit	7,offset(ix)		;DD CBr00 7E
	bit	7,offset(iy)		;FD CBr00 7E
	bit	7,(ix+offset)		;DD CBr00 7E
	bit	7,(iy+offset)		;FD CBr00 7E
     .nlist
    .else
      .list
	bit	7,offset(ix)		;DD CBr55 7E
	bit	7,offset(iy)		;FD CBr55 7E
	bit	7,(ix+offset)		;DD CBr55 7E
	bit	7,(iy+offset)		;FD CBr55 7E
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	bit	7,offset(ix)		;DD CB 55 7E
	bit	7,offset(iy)		;FD CB 55 7E
	bit	7,(ix+offset)		;DD CB 55 7E
	bit	7,(iy+offset)		;FD CB 55 7E
    .nlist
  .endif
.list  ; end<--
	bit	7,a			;CB 7F
	bit	7,b			;CB 78
	bit	7,c			;CB 79
	bit	7,d			;CB 7A
	bit	7,e			;CB 7B
	bit	7,h			;CB 7C
	bit	7,l			;CB 7D

;*******************************************************************
;	CALL	
;*******************************************************************
	;***********************************************************
	; call subroutine at nn if condition is true
	.z80
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	call	C,nn			;DCr00s00
	call	M,nn			;FCr00s00
	call	s,nn			;FCr00s00
	call	NC,nn			;D4r00s00
	call	NZ,nn			;C4r00s00
	call	P,nn			;F4r00s00
	CALL	NS,nn			;F4r00s00
	call	PE,nn			;ECr00s00
	call	V,nn			;ECr00s00
	call	PO,nn			;E4r00s00
	call	nv,nn			;E4r00s00
	call	Z,nn			;CCr00s00
      .nlist
    .else
      .list
	call	C,nn			;DCr84s05
	call	M,nn			;FCr84s05
	call	s,nn			;FCr84s05
	call	NC,nn			;D4r84s05
	call	NZ,nn			;C4r84s05
	call	P,nn			;F4r84s05
	CALL	NS,nn			;F4r84s05
	call	PE,nn			;ECr84s05
	call	V,nn			;ECr84s05
	call	PO,nn			;E4r84s05
	call	nv,nn			;E4r84s05
	call	Z,nn			;CCr84s05
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	call	C,nn			;DC 84 05
	call	M,nn			;FC 84 05
	call	s,nn			;FC 84 05
	call	NC,nn			;D4 84 05
	call	NZ,nn			;C4 84 05
	call	P,nn			;F4 84 05
	CALL	NS,nn			;F4 84 05
	call	PE,nn			;EC 84 05
	call	V,nn			;EC 84 05
	call	PO,nn			;E4 84 05
	call	nv,nn			;E4 84 05
	call	Z,nn			;CC 84 05
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	; unconditional call to subroutine at nn
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	call	nn			;CDr00s00
	call	(nn)			;CDr00s00
	call	#nn			;CDr00s00
      .nlist
    .else
      .list
	call	nn			;CDr84s05
	call	(nn)			;CDr84s05
	call	#nn			;CDr84s05
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	call	nn			;CD 84 05
	call	(nn)			;CD 84 05
	call	#nn			;CD 84 05
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	;  p. 5-21
	.z280
	call	(hl)			;DD CD
	call	z,(hl)			;DD CC
	call	NV,(hl)			;DD E4
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn call01,raofc
      .list
	call	call01(pc)		;FD CDp00q00
      .nlist
      .pcr_xtrn call02,raofc
      .list
	call	(pc+call02)		;FD CDp00q00
      .nlist
      .pcr_xtrn call03,raofc
      .list
	call	[call03]		;FD CDp00q00
      .nlist
    .else
      .pcr_lclx call01
      .list
	call	raofc+call01(pc)	;FD CDp34q12
      .nlist
      .pcr_lclx call02
      .list
	call	(pc+raofc+call02)	;FD CDp34q12
      .nlist
      .pcr_lclx call03
      .list
	call	[raofc+call03]		;FD CDp34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn call01,raofc
      .list
	call	call01(pc)		;FD CD 34 12
      .nlist
      .pcr_xtrn call02,raofc
      .list
	call	(pc+call02)		;FD CD 34 12
      .nlist
      .pcr_xtrn call03,raofc
      .list
	call	[call03]		;FD CD 34 12
      .nlist
    .else
      .pcr_lclx call01
      .list
	call	raofc+call01(pc)	;FD CD 34 12
      .nlist
      .pcr_lclx call02
      .list
	call	(pc+raofc+call02)	;FD CD 34 12
      .nlist
      .pcr_lclx call03
      .list
	call	[raofc+call03]		;FD CD 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	call	raoff(pc)		;FD CDp34q12
	call	(pc+raoff)		;FD CDp34q12
	call	[raoff]			;FD CDp34q12
    .nlist
  .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	call	pcr_ofst(pc)		;FD CD 34 12
      .nlist
	.pcr_ofst raofc
      .list
	call	(pc+pcr_ofst)		;FD CD 34 12
      .nlist
	.pcr_ofst raofc
      .list
	call	[pcr_ofst]		;FD CD 34 12
    .nlist
  .endif
.list  ; end<--
	call	[.+0x108]		;FD CD 04 01
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
    .else
    .endif
    .pcr_lclx call04
    .list
	call	c,raofc+call04(pc)	;FD DCp34q12
    .nlist
    .pcr_lclx call05
    .list
	call	c,(pc+raofc+call05)	;FD DCp34q12
    .nlist
    .pcr_lclx call06
    .list
	call	c,[raofc+call06]	;FD DCp34q12
    .nlist
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
    .else
    .endif
    .pcr_lclx call04
    .list
	call	c,raofc+call04(pc)	;FD DC 34 12
    .nlist
    .pcr_lclx call05
    .list
	call	c,(pc+raofc+call05)	;FD DC 34 12
    .nlist
    .pcr_lclx call06
    .list
	call	c,[raofc+call06]	;FD DC 34 12
    .nlist
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	call	c,raoff(pc)		;FD DCp34q12
	call	c,(pc+raoff)		;FD DCp34q12
	call	c,[raoff]		;FD DCp34q12
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	call	c,pcr_ofst(pc)		;FD DC 34 12
      .nlist
	.pcr_ofst raofc
      .list
	call	c,(pc+pcr_ofst)		;FD DC 34 12
      .nlist
	.pcr_ofst raofc
      .list
	call	c,[pcr_ofst]		;FD DC 34 12
    .nlist
  .endif
.list  ; end<--
	call	c,.+0x108(pc)		;FD DC 04 01
;*******************************************************************
;	CCF	
;*******************************************************************
	;***********************************************************
	; complement carry flag
	.z80
	ccf				;3F

;*******************************************************************
;	CP	
;		Leading 'a' operand is optional.
;		If offset is ommitted 0 is assumed.
;*******************************************************************
	;***********************************************************
	; compare operand with 'a'
	.z80
	cp	a,(hl)			;BE
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	cp	a,offset(ix)		;DD BEr00
	cp	a,offset(iy)		;FD BEr00
	cp	a,(ix+offset)		;DD BEr00
	cp	a,(iy+offset)		;FD BEr00
      .nlist
    .else
      .list
	cp	a,offset(ix)		;DD BEr55
	cp	a,offset(iy)		;FD BEr55
	cp	a,(ix+offset)		;DD BEr55
	cp	a,(iy+offset)		;FD BEr55
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	cp	a,offset(ix)		;DD BE 55
	cp	a,offset(iy)		;FD BE 55
	cp	a,(ix+offset)		;DD BE 55
	cp	a,(iy+offset)		;FD BE 55
    .nlist
  .endif
.list  ; end<--
	cp	a,a			;BF
	cp	a,b			;B8
	cp	a,c			;B9
	cp	a,d			;BA
	cp	a,e			;BB
	cp	a,h			;BC
	cp	a,l			;BD
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	cp	a,#n			;FEr00
	cp	a, n			;FEr00
      .nlist
    .else
      .list
	cp	a,#n			;FEr20
	cp	a, n			;FEr20
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	cp	a,#n			;FE 20
	cp	a, n			;FE 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	; compare operand without 'a'
	.z80
	cp	a,(hl)			;BE
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	cp	offset(ix)		;DD BEr00
	cp	offset(iy)		;FD BEr00
	cp	(ix+offset)		;DD BEr00
	cp	(iy+offset)		;FD BEr00
      .nlist
    .else
      .list
	cp	offset(ix)		;DD BEr55
	cp	offset(iy)		;FD BEr55
	cp	(ix+offset)		;DD BEr55
	cp	(iy+offset)		;FD BEr55
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	cp	offset(ix)		;DD BE 55
	cp	offset(iy)		;FD BE 55
	cp	(ix+offset)		;DD BE 55
	cp	(iy+offset)		;FD BE 55
    .nlist
  .endif
.list  ; end<--
	cp	a			;BF
	cp	b			;B8
	cp	c			;B9
	cp	d			;BA
	cp	e			;BB
	cp	h			;BC
	cp	l			;BD
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	cp	#n			;FEr00
	cp	 n			;FEr00
      .nlist
    .else
      .list
	cp	#n			;FEr20
	cp	 n			;FEr20
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	cp	#n			;FE 20
	cp	 n			;FE 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	; compare operand with 'a'
	;  p. 5-23
	.z280
	cp	a,ixh			;DD BC
	cp	a,ixl			;DD BD
	cp	a,iyh			;FD BC
	cp	a,iyl			;FD BD
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	cp	a,#n			;FEr00
	cp	a,(daddr)		;DD BFr00s00
	cp	a,sxoff(ix)		;FD B9r00s00
	cp	a,(ix+sxoff)		;FD B9r00s00
	cp	a,sxoff(iy)		;FD BAr00s00
	cp	a,(iy+sxoff)		;FD BAr00s00
	cp	a,sxoff(hl)		;FD BBr00s00
	cp	a,(hl+sxoff)		;FD BBr00s00
	cp	a,sxoff(sp)		;DD B8r00s00
	cp	a,(sp+sxoff)		;DD B8r00s00
	cp	a,lxoff(ix)		;FD B9r00s00
	cp	a,(ix+lxoff)		;FD B9r00s00
	cp	a,lxoff(iy)		;FD BAr00s00
	cp	a,(iy+lxoff)		;FD BAr00s00
	cp	a,lxoff(hl)		;FD BBr00s00
	cp	a,(hl+lxoff)		;FD BBr00s00
	cp	a,lxoff(sp)		;DD B8r00s00
	cp	a,(sp+lxoff)		;DD B8r00s00
      .nlist
    .else
      .list
	cp	a,#n			;FEr20
	cp	a,(daddr)		;DD BFr44s33
	cp	a,sxoff(ix)		;FD B9r55s00
	cp	a,(ix+sxoff)		;FD B9r55s00
	cp	a,sxoff(iy)		;FD BAr55s00
	cp	a,(iy+sxoff)		;FD BAr55s00
	cp	a,sxoff(hl)		;FD BBr55s00
	cp	a,(hl+sxoff)		;FD BBr55s00
	cp	a,sxoff(sp)		;DD B8r55s00
	cp	a,(sp+sxoff)		;DD B8r55s00
	cp	a,lxoff(ix)		;FD B9r22s11
	cp	a,(ix+lxoff)		;FD B9r22s11
	cp	a,lxoff(iy)		;FD BAr22s11
	cp	a,(iy+lxoff)		;FD BAr22s11
	cp	a,lxoff(hl)		;FD BBr22s11
	cp	a,(hl+lxoff)		;FD BBr22s11
	cp	a,lxoff(sp)		;DD B8r22s11
	cp	a,(sp+lxoff)		;DD B8r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	cp	a,#n			;FE 20
	cp	a,(daddr)		;DD BF 44 33
    .nlist
    .ifeq _X_R
      .list
	cp	a,sxoff(ix)		;FD B9 55 00
	cp	a,(ix+sxoff)		;FD B9 55 00
	cp	a,sxoff(iy)		;FD BA 55 00
	cp	a,(iy+sxoff)		;FD BA 55 00
      .nlist
    .else
      .list
	cp	a,sxoff(ix)		;DD BE 55
	cp	a,(ix+sxoff)		;DD BE 55
	cp	a,sxoff(iy)		;FD BE 55
	cp	a,(iy+sxoff)		;FD BE 55
      .nlist
    .endif
    .list
	cp	a,sxoff(hl)		;FD BB 55 00
	cp	a,(hl+sxoff)		;FD BB 55 00
	cp	a,sxoff(sp)		;DD B8 55 00
	cp	a,(sp+sxoff)		;DD B8 55 00
	cp	a,lxoff(ix)		;FD B9 22 11
	cp	a,(ix+lxoff)		;FD B9 22 11
	cp	a,lxoff(iy)		;FD BA 22 11
	cp	a,(iy+lxoff)		;FD BA 22 11
	cp	a,lxoff(hl)		;FD BB 22 11
	cp	a,(hl+lxoff)		;FD BB 22 11
	cp	a,lxoff(sp)		;DD B8 22 11
	cp	a,(sp+lxoff)		;DD B8 22 11
    .nlist
  .endif
.list  ; end<--
	cp	a,(ix)			;DD BE 00
	cp	a,(iy)			;FD BE 00
	cp	a,(hl)			;BE
	cp	a,(sp)			;DD B8 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn cp01,raofc
      .list
	cp	a,cp01(pc)		;FD B8p00q00
      .nlist
      .pcr_xtrn cp02,raofc
      .list
	cp	a,(pc+cp02)		;FD B8p00q00
      .nlist
      .pcr_xtrn cp03,raofc
      .list
	cp	a,[cp03]		;FD B8p00q00
      .nlist
    .else
      .pcr_lclx cp01
      .list
	cp	a,raofc+cp01(pc)	;FD B8p34q12
      .nlist
      .pcr_lclx cp02
      .list
	cp	a,(pc+raofc+cp02)	;FD B8p34q12
      .nlist
      .pcr_lclx cp03
      .list
	cp	a,[raofc+cp03]		;FD B8p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn cp01,raofc
      .list
	cp	a,cp01(pc)		;FD B8 34 12
      .nlist
      .pcr_xtrn cp02,raofc
      .list
	cp	a,(pc+cp02)		;FD B8 34 12
      .nlist
      .pcr_xtrn cp03,raofc
      .list
	cp	a,[cp03]		;FD B8 34 12
      .nlist
    .else
      .pcr_lclx cp01
      .list
	cp	a,raofc+cp01(pc)	;FD B8 34 12
      .nlist
      .pcr_lclx cp02
      .list
	cp	a,(pc+raofc+cp02)	;FD B8 34 12
      .nlist
      .pcr_lclx cp03
      .list
	cp	a,[raofc+cp03]		;FD B8 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	cp	a,raoff(pc)		;FD B8p34q12
	cp	a,(pc+raoff)		;FD B8p34q12
	cp	a,[raoff]		;FD B8p34q12
    .nlist
  .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	cp	a,pcr_ofst(pc)		;FD B8 34 12
      .nlist
	.pcr_ofst raofc
      .list
	cp	a,(pc+pcr_ofst)		;FD B8 34 12
      .nlist
	.pcr_ofst raofc
      .list
	cp	a,[pcr_ofst]		;FD B8 34 12
    .nlist
  .endif
.list  ; end<--
	cp	a,[.+offsetc]		;FD B8 51 00
	cp	a,(hl+ix)		;DD B9
	cp	a,(hl+iy)		;DD BA
	cp	a,(ix+iy)		;DD BB
	;***********************************************************
	; compare operand without 'a'
	;  p. 5-23
	.z280
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	cp	#n			;FEr00
	cp	(daddr)			;DD BFr00s00
	cp	sxoff(ix)		;FD B9r00s00
	cp	(ix+sxoff)		;FD B9r00s00
	cp	sxoff(iy)		;FD BAr00s00
	cp	(iy+sxoff)		;FD BAr00s00
	cp	sxoff(hl)		;FD BBr00s00
	cp	(hl+sxoff)		;FD BBr00s00
	cp	sxoff(sp)		;DD B8r00s00
	cp	(sp+sxoff)		;DD B8r00s00
	cp	lxoff(ix)		;FD B9r00s00
	cp	(ix+lxoff)		;FD B9r00s00
	cp	lxoff(iy)		;FD BAr00s00
	cp	(iy+lxoff)		;FD BAr00s00
	cp	lxoff(hl)		;FD BBr00s00
	cp	(hl+lxoff)		;FD BBr00s00
	cp	lxoff(sp)		;DD B8r00s00
	cp	(sp+lxoff)		;DD B8r00s00
      .nlist
    .else
      .list
	cp	#n			;FEr20
	cp	(daddr)			;DD BFr44s33
	cp	sxoff(ix)		;FD B9r55s00
	cp	(ix+sxoff)		;FD B9r55s00
	cp	sxoff(iy)		;FD BAr55s00
	cp	(iy+sxoff)		;FD BAr55s00
	cp	sxoff(hl)		;FD BBr55s00
	cp	(hl+sxoff)		;FD BBr55s00
	cp	sxoff(sp)		;DD B8r55s00
	cp	(sp+sxoff)		;DD B8r55s00
	cp	lxoff(ix)		;FD B9r22s11
	cp	(ix+lxoff)		;FD B9r22s11
	cp	lxoff(iy)		;FD BAr22s11
	cp	(iy+lxoff)		;FD BAr22s11
	cp	lxoff(hl)		;FD BBr22s11
	cp	(hl+lxoff)		;FD BBr22s11
	cp	lxoff(sp)		;DD B8r22s11
	cp	(sp+lxoff)		;DD B8r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	cp	#n			;FE 20
	cp	(daddr)			;DD BF 44 33
    .nlist
    .ifeq _X_R
      .list
	cp	sxoff(ix)		;FD B9 55 00
	cp	(ix+sxoff)		;FD B9 55 00
	cp	sxoff(iy)		;FD BA 55 00
	cp	(iy+sxoff)		;FD BA 55 00
      .nlist
    .else
      .list
	cp	sxoff(ix)		;DD BE 55
	cp	(ix+sxoff)		;DD BE 55
	cp	sxoff(iy)		;FD BE 55
	cp	(iy+sxoff)		;FD BE 55
      .nlist
    .endif
    .list
	cp	sxoff(hl)		;FD BB 55 00
	cp	(hl+sxoff)		;FD BB 55 00
	cp	sxoff(sp)		;DD B8 55 00
	cp	(sp+sxoff)		;DD B8 55 00
	cp	lxoff(ix)		;FD B9 22 11
	cp	(ix+lxoff)		;FD B9 22 11
	cp	lxoff(iy)		;FD BA 22 11
	cp	(iy+lxoff)		;FD BA 22 11
	cp	lxoff(hl)		;FD BB 22 11
	cp	(hl+lxoff)		;FD BB 22 11
	cp	lxoff(sp)		;DD B8 22 11
	cp	(sp+lxoff)		;DD B8 22 11
    .nlist
  .endif
.list  ; end<--
	cp	(ix)			;DD BE 00
	cp	(iy)			;FD BE 00
	cp	(hl)			;BE
	cp	(sp)			;DD B8 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn cp04,raofc
      .list
	cp	cp04(pc)		;FD B8p00q00
      .nlist
      .pcr_xtrn cp05,raofc
      .list
	cp	(pc+cp05)		;FD B8p00q00
      .nlist
      .pcr_xtrn cp06,raofc
      .list
	cp	[cp06]			;FD B8p00q00
      .nlist
    .else
      .pcr_lclx cp04
      .list
	cp	raofc+cp04(pc)		;FD B8p34q12
      .nlist
      .pcr_lclx cp05
      .list
	cp	(pc+raofc+cp05)		;FD B8p34q12
      .nlist
      .pcr_lclx cp06
      .list
	cp	[raofc+cp06]		;FD B8p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn cp04,raofc
      .list
	cp	cp04(pc)		;FD B8 34 12
      .nlist
      .pcr_xtrn cp05,raofc
      .list
	cp	(pc+cp05)		;FD B8 34 12
      .nlist
      .pcr_xtrn cp06,raofc
      .list
	cp	[cp06]			;FD B8 34 12
      .nlist
    .else
      .pcr_lclx cp04
      .list
	cp	raofc+cp04(pc)		;FD B8 34 12
      .nlist
      .pcr_lclx cp05
      .list
	cp	(pc+raofc+cp05)		;FD B8 34 12
      .nlist
      .pcr_lclx cp06
      .list
	cp	[raofc+cp06]		;FD B8 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	cp	raoff(pc)		;FD B8p34q12
	cp	(pc+raoff)		;FD B8p34q12
	cp	[raoff]			;FD B8p34q12
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	cp	pcr_ofst(pc)		;FD B8 34 12
      .nlist
	.pcr_ofst raofc
      .list
	cp	(pc+pcr_ofst)		;FD B8 34 12
      .nlist
	.pcr_ofst raofc
      .list
	cp	[pcr_ofst]		;FD B8 34 12
    .nlist
  .endif
.list  ; end<--
	cp	[.+offsetc]		;FD B8 51 00
	cp	(hl+ix)			;DD B9
	cp	(hl+iy)			;DD BA
	cp	(ix+iy)			;DD BB
;*******************************************************************
;	CPW	
;*******************************************************************
	;***********************************************************
	; compare word operand with 'hl'
	;  p. 5-29
	.z280
	cpw	hl,bc			;ED C7
	cpw	hl,de			;ED D7
	cpw	hl,hl			;ED E7
	cpw	hl,sp			;ED F7
	cpw	hl,ix			;DD ED E7
	cpw	hl,iy			;FD ED E7
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	cpw	hl,#nn			;FD ED F7r00s00
	cpw	hl,(daddr)		;DD ED D7r00s00
	cpw	hl,sxoff(ix)		;FD ED C7r00s00
	cpw	hl,(ix+sxoff)		;FD ED C7r00s00
	cpw	hl,lxoff(ix)		;FD ED C7r00s00
	cpw	hl,(ix+lxoff)		;FD ED C7r00s00
	cpw	hl,sxoff(iy)		;FD ED D7r00s00
	cpw	hl,(iy+sxoff)		;FD ED D7r00s00
	cpw	hl,lxoff(iy)		;FD ED D7r00s00
	cpw	hl,(iy+lxoff)		;FD ED D7r00s00
      .nlist
    .else
      .list
	cpw	hl,#nn			;FD ED F7r84s05
	cpw	hl,(daddr)		;DD ED D7r44s33
	cpw	hl,sxoff(ix)		;FD ED C7r55s00
	cpw	hl,(ix+sxoff)		;FD ED C7r55s00
	cpw	hl,lxoff(ix)		;FD ED C7r22s11
	cpw	hl,(ix+lxoff)		;FD ED C7r22s11
	cpw	hl,sxoff(iy)		;FD ED D7r55s00
	cpw	hl,(iy+sxoff)		;FD ED D7r55s00
	cpw	hl,lxoff(iy)		;FD ED D7r22s11
	cpw	hl,(iy+lxoff)		;FD ED D7r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	cpw	hl,#nn			;FD ED F7 84 05
	cpw	hl,(daddr)		;DD ED D7 44 33
	cpw	hl,sxoff(ix)		;FD ED C7 55 00
	cpw	hl,(ix+sxoff)		;FD ED C7 55 00
	cpw	hl,lxoff(ix)		;FD ED C7 22 11
	cpw	hl,(ix+lxoff)		;FD ED C7 22 11
	cpw	hl,sxoff(iy)		;FD ED D7 55 00
	cpw	hl,(iy+sxoff)		;FD ED D7 55 00
	cpw	hl,lxoff(iy)		;FD ED D7 22 11
	cpw	hl,(iy+lxoff)		;FD ED D7 22 11
    .nlist
  .endif
.list  ; end<--
	cpw	hl,(hl)			;DD ED C7
	cpw	hl,(ix)			;FD ED C7 00 00
	cpw	hl,(iy)			;FD ED D7 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
       .pcr_xtrn cpw01,raofc,5
      .list
	cpw	hl,cpw01(pc)		;DD ED F7p00q00
      .nlist
      .pcr_xtrn cpw02,raofc,5
      .list
	cpw	hl,(pc+cpw02)		;DD ED F7p00q00
      .nlist
      .pcr_xtrn cpw03,raofc,5
      .list
	cpw	hl,[cpw03]		;DD ED F7p00q00
      .nlist
   .else
      .pcr_lclx cpw01,5
      .list
	cpw	hl,raofc+cpw01(pc)	;DD ED F7p34q12
      .nlist
      .pcr_lclx cpw02,5
      .list
	cpw	hl,(pc+raofc+cpw02)	;DD ED F7p34q12
      .nlist
      .pcr_lclx cpw03,5
      .list
	cpw	hl,[raofc+cpw03]	;DD ED F7p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
       .pcr_xtrn cpw01,raofc,5
      .list
	cpw	hl,cpw01(pc)		;DD ED F7 34 12
      .nlist
      .pcr_xtrn cpw02,raofc,5
      .list
	cpw	hl,(pc+cpw02)		;DD ED F7 34 12
      .nlist
      .pcr_xtrn cpw03,raofc,5
      .list
	cpw	hl,[cpw03]		;DD ED F7 34 12
      .nlist
    .else
      .pcr_lclx cpw01,5
      .list
	cpw	hl,raofc+cpw01(pc)	;DD ED F7 34 12
      .nlist
      .pcr_lclx cpw02,5
      .list
	cpw	hl,(pc+raofc+cpw02)	;DD ED F7 34 12
      .nlist
      .pcr_lclx cpw03,5
      .list
	cpw	hl,[raofc+cpw03]	;DD ED F7 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	cpw	hl,raoff(pc)		;DD ED F7p34q12
	cpw	hl,(pc+raoff)		;DD ED F7p34q12
	cpw	hl,[raoff]		;DD ED F7p34q12
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc,5
      .list
	cpw	hl,pcr_ofst(pc)		;DD ED F7 34 12
      .nlist
	.pcr_ofst raofc,5
      .list
	cpw	hl,(pc+pcr_ofst)	;DD ED F7 34 12
      .nlist
	.pcr_ofst raofc,5
      .list
	cpw	hl,[pcr_ofst]		;DD ED F7 34 12
    .nlist
  .endif
.list  ; end<--
	cpw	hl,[.+20]		;DD ED F7 0F 00

	;***********************************************************
	; compare word operand without 'hl'
	cpw	bc			;ED C7
	cpw	de			;ED D7
	cpw	hl			;ED E7
	cpw	sp			;ED F7
	cpw	ix			;DD ED E7
	cpw	iy			;FD ED E7
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	cpw	#nn			;FD ED F7r00s00
	cpw	(daddr)			;DD ED D7r00s00
	cpw	sxoff(ix)		;FD ED C7r00s00
	cpw	(ix+sxoff)		;FD ED C7r00s00
	cpw	lxoff(ix)		;FD ED C7r00s00
	cpw	(ix+lxoff)		;FD ED C7r00s00
	cpw	sxoff(iy)		;FD ED D7r00s00
	cpw	(iy+sxoff)		;FD ED D7r00s00
	cpw	lxoff(iy)		;FD ED D7r00s00
	cpw	(iy+lxoff)		;FD ED D7r00s00
      .nlist
    .else
      .list
	cpw	#nn			;FD ED F7r84s05
	cpw	(daddr)			;DD ED D7r44s33
	cpw	sxoff(ix)		;FD ED C7r55s00
	cpw	(ix+sxoff)		;FD ED C7r55s00
	cpw	lxoff(ix)		;FD ED C7r22s11
	cpw	(ix+lxoff)		;FD ED C7r22s11
	cpw	sxoff(iy)		;FD ED D7r55s00
	cpw	(iy+sxoff)		;FD ED D7r55s00
	cpw	lxoff(iy)		;FD ED D7r22s11
	cpw	(iy+lxoff)		;FD ED D7r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	cpw	#nn			;FD ED F7 84 05
	cpw	(daddr)			;DD ED D7 44 33
	cpw	sxoff(ix)		;FD ED C7 55 00
	cpw	(ix+sxoff)		;FD ED C7 55 00
	cpw	lxoff(ix)		;FD ED C7 22 11
	cpw	(ix+lxoff)		;FD ED C7 22 11
	cpw	sxoff(iy)		;FD ED D7 55 00
	cpw	(iy+sxoff)		;FD ED D7 55 00
	cpw	lxoff(iy)		;FD ED D7 22 11
	cpw	(iy+lxoff)		;FD ED D7 22 11
    .nlist
  .endif
.list  ; end<--
	cpw	(hl)			;DD ED C7
	cpw	(ix)			;FD ED C7 00 00
	cpw	(iy)			;FD ED D7 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn cpw04,raofc,5
      .list
	cpw	cpw04(pc)		;DD ED F7p00q00
      .nlist
      .pcr_xtrn cpw05,raofc,5
      .list
	cpw	(pc+cpw05)		;DD ED F7p00q00
      .nlist
      .pcr_xtrn cpw06,raofc,5
      .list
	cpw	[cpw06]			;DD ED F7p00q00
      .nlist
    .else
      .pcr_lclx cpw04,5
      .list
	cpw	raofc+cpw04(pc)		;DD ED F7p34q12
      .nlist
      .pcr_lclx cpw05,5
      .list
	cpw	(pc+raofc+cpw05)	;DD ED F7p34q12
      .nlist
      .pcr_lclx cpw06,5
      .list
	cpw	[raofc+cpw06]		;DD ED F7p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn cpw04,raofc,5
      .list
	cpw	cpw04(pc)		;DD ED F7 34 12
      .nlist
      .pcr_xtrn cpw05,raofc,5
      .list
	cpw	(pc+cpw05)		;DD ED F7 34 12
      .nlist
      .pcr_xtrn cpw06,raofc,5
      .list
	cpw	[cpw06]			;DD ED F7 34 12
      .nlist
    .else
      .pcr_lclx cpw04,5
      .list
	cpw	raofc+cpw04(pc)		;DD ED F7 34 12
      .nlist
      .pcr_lclx cpw05,5
      .list
	cpw	(pc+raofc+cpw05)	;DD ED F7 34 12
      .nlist
      .pcr_lclx cpw06,5
      .list
	cpw	[raofc+cpw06]		;DD ED F7 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	cpw	raoff(pc)		;DD ED F7p34q12
	cpw	(pc+raoff)		;DD ED F7p34q12
	cpw	[raoff]			;DD ED F7p34q12
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc,5
      .list
	cpw	pcr_ofst(pc)		;DD ED F7 34 12
      .nlist
	.pcr_ofst raofc,5
      .list
	cpw	(pc+pcr_ofst)		;DD ED F7 34 12
      .nlist
	.pcr_ofst raofc,5
      .list
	cpw	[pcr_ofst]		;DD ED F7 34 12
    .nlist
  .endif
.list  ; end<--
	cpw	[.+20]			;DD ED F7 0F 00

	;***********************************************************
	; Alternative to cpw hl,...
	;  p. 5-29
	.z280
	cp	hl,bc			;ED C7
	cp	hl,de			;ED D7
	cp	hl,hl			;ED E7
	cp	hl,sp			;ED F7
	cp	hl,ix			;DD ED E7
	cp	hl,iy			;FD ED E7
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	cp	hl,#nn			;FD ED F7r00s00
	cp	hl,(daddr)		;DD ED D7r00s00
	cp	hl,sxoff(ix)		;FD ED C7r00s00
	cp	hl,(ix+sxoff)		;FD ED C7r00s00
	cp	hl,lxoff(ix)		;FD ED C7r00s00
	cp	hl,(ix+lxoff)		;FD ED C7r00s00
	cp	hl,sxoff(iy)		;FD ED D7r00s00
	cp	hl,(iy+sxoff)		;FD ED D7r00s00
	cp	hl,lxoff(iy)		;FD ED D7r00s00
	cp	hl,(iy+lxoff)		;FD ED D7r00s00
      .nlist
    .else
      .list
	cp	hl,#nn			;FD ED F7r84s05
	cp	hl,(daddr)		;DD ED D7r44s33
	cp	hl,sxoff(ix)		;FD ED C7r55s00
	cp	hl,(ix+sxoff)		;FD ED C7r55s00
	cp	hl,lxoff(ix)		;FD ED C7r22s11
	cp	hl,(ix+lxoff)		;FD ED C7r22s11
	cp	hl,sxoff(iy)		;FD ED D7r55s00
	cp	hl,(iy+sxoff)		;FD ED D7r55s00
	cp	hl,lxoff(iy)		;FD ED D7r22s11
	cp	hl,(iy+lxoff)		;FD ED D7r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	cp	hl,#nn			;FD ED F7 84 05
	cp	hl,(daddr)		;DD ED D7 44 33
	cp	hl,sxoff(ix)		;FD ED C7 55 00
	cp	hl,(ix+sxoff)		;FD ED C7 55 00
	cp	hl,lxoff(ix)		;FD ED C7 22 11
	cp	hl,(ix+lxoff)		;FD ED C7 22 11
	cp	hl,sxoff(iy)		;FD ED D7 55 00
	cp	hl,(iy+sxoff)		;FD ED D7 55 00
	cp	hl,lxoff(iy)		;FD ED D7 22 11
	cp	hl,(iy+lxoff)		;FD ED D7 22 11
    .nlist
  .endif
.list  ; end<--
	cp	hl,(hl)			;DD ED C7
	cp	hl,(ix)			;FD ED C7 00 00
	cp	hl,(iy)			;FD ED D7 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn cp07,raofc,5
      .list
	cp	hl,cp07(pc)		;DD ED F7p00q00
      .nlist
      .pcr_xtrn cp08,raofc,5
      .list
	cp	hl,(pc+cp08)		;DD ED F7p00q00
      .nlist
      .pcr_xtrn cp09,raofc,5
      .list
	cp	hl,[cp09]		;DD ED F7p00q00
      .nlist
    .else
      .pcr_lclx cp07,5
      .list
	cp	hl,raofc+cp07(pc)	;DD ED F7p34q12
      .nlist
      .pcr_lclx cp08,5
      .list
	cp	hl,(pc+raofc+cp08)	;DD ED F7p34q12
      .nlist
      .pcr_lclx cp09,5
      .list
	cp	hl,[raofc+cp09]		;DD ED F7p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn cp07,raofc,5
      .list
	cp	hl,cp07(pc)		;DD ED F7 34 12
      .nlist
      .pcr_xtrn cp08,raofc,5
      .list
	cp	hl,(pc+cp08)		;DD ED F7 34 12
      .nlist
      .pcr_xtrn cp09,raofc,5
      .list
	cp	hl,[cp09]		;DD ED F7 34 12
      .nlist
    .else
      .pcr_lclx cp07,5
      .list
	cp	hl,raofc+cp07(pc)	;DD ED F7 34 12
      .nlist
      .pcr_lclx cp08,5
      .list
	cp	hl,(pc+raofc+cp08)	;DD ED F7 34 12
      .nlist
      .pcr_lclx cp09,5
      .list
	cp	hl,[raofc+cp09]		;DD ED F7 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	cp	hl,raoff(pc)		;DD ED F7p34q12
	cp	hl,(pc+raoff)		;DD ED F7p34q12
	cp	hl,[raoff]		;DD ED F7p34q12
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc,5
      .list
	cp	hl,pcr_ofst(pc)		;DD ED F7 34 12
      .nlist
	.pcr_ofst raofc,5
      .list
	cp	hl,(pc+pcr_ofst)	;DD ED F7 34 12
      .nlist
	.pcr_ofst raofc,5
      .list
	cp	hl,[pcr_ofst]		;DD ED F7 34 12
    .nlist
  .endif
.list  ; end<--
	cp	hl,[.+20]		;DD ED F7 0F 00

;*******************************************************************
;	CPD	
;*******************************************************************
	;***********************************************************
	; compare location (hl) and 'a'
	; decrement 'hl' and 'bc'
	.z80
	cpd				;ED A9

;*******************************************************************
;	CPDR	
;*******************************************************************
	;***********************************************************
	; compare location (hl) and 'a'
	; decrement 'hl' and 'bc'
	; repeat until 'bc' = 0
	.z80
	cpdr				;ED B9

;*******************************************************************
;	CPI	
;*******************************************************************
	;***********************************************************
	; compare location (hl) and 'a'
	; increment 'hl' and decrement 'bc'
	.z80
	cpi				;ED A1

;*******************************************************************
;	CPIR	
;*******************************************************************
	;***********************************************************
	; compare location (hl) and 'a'
	; increment 'hl' and decrement 'bc'
	; repeat until 'bc' = 0
	.z80
	cpir				;ED B1

;*******************************************************************
;	CPL	
;*******************************************************************
	;***********************************************************
	; 1's complement of 'a'
	.z80
	cpl				;2F

;*******************************************************************
;	DAA	
;*******************************************************************
	;***********************************************************
	; decimal adjust 'a'
	.z80
	daa				;27

;*******************************************************************
;	DEC	
;*******************************************************************
	;***********************************************************
	; decrement operand
	.z80
	dec	(hl)			;35
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	dec	offset(ix)		;DD 35r00
	dec	offset(iy)		;FD 35r00
	dec	(ix+offset)		;DD 35r00
	dec	(iy+offset)		;FD 35r00
      .nlist
    .else
      .list
	dec	offset(ix)		;DD 35r55
	dec	offset(iy)		;FD 35r55
	dec	(ix+offset)		;DD 35r55
	dec	(iy+offset)		;FD 35r55
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	dec	offset(ix)		;DD 35 55
	dec	offset(iy)		;FD 35 55
	dec	(ix+offset)		;DD 35 55
	dec	(iy+offset)		;FD 35 55
    .nlist
  .endif
.list  ; end<--
	dec	a			;3D
	dec	b			;05
	dec	bc			;0B
	dec	c			;0D
	dec	d			;15
	dec	de			;1B
	dec	e			;1D
	dec	h			;25
	dec	hl			;2B
	dec	ix			;DD 2B
	dec	iy			;FD 2B
	dec	l			;2D
	dec	sp			;3B
	;***********************************************************
	;  p. 5-32
	.z280
	dec	ixh			;DD 25
	dec	ixl			;DD 2D
	dec	iyh			;FD 25
	dec	iyl			;FD 2D
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	dec	(daddr)			;DD 3Dr00s00
	dec	sxoff(ix)		;FD 0Dr00s00
	dec	(ix+sxoff)		;FD 0Dr00s00
	dec	sxoff(iy)		;FD 15r00s00
	dec	(iy+sxoff)		;FD 15r00s00
	dec	sxoff(hl)		;FD 1Dr00s00
	dec	(hl+sxoff)		;FD 1Dr00s00
	dec	sxoff(sp)		;DD 05r00s00
	dec	(sp+sxoff)		;DD 05r00s00
	dec	lxoff(ix)		;FD 0Dr00s00
	dec	(ix+lxoff)		;FD 0Dr00s00
	dec	lxoff(iy)		;FD 15r00s00
	dec	(iy+lxoff)		;FD 15r00s00
	dec	lxoff(hl)		;FD 1Dr00s00
	dec	(hl+lxoff)		;FD 1Dr00s00
	dec	lxoff(sp)		;DD 05r00s00
	dec	(sp+lxoff)		;DD 05r00s00
      .nlist
    .else
      .list
	dec	(daddr)			;DD 3Dr44s33
	dec	sxoff(ix)		;FD 0Dr55s00
	dec	(ix+sxoff)		;FD 0Dr55s00
	dec	sxoff(iy)		;FD 15r55s00
	dec	(iy+sxoff)		;FD 15r55s00
	dec	sxoff(hl)		;FD 1Dr55s00
	dec	(hl+sxoff)		;FD 1Dr55s00
	dec	sxoff(sp)		;DD 05r55s00
	dec	(sp+sxoff)		;DD 05r55s00
	dec	lxoff(ix)		;FD 0Dr22s11
	dec	(ix+lxoff)		;FD 0Dr22s11
	dec	lxoff(iy)		;FD 15r22s11
	dec	(iy+lxoff)		;FD 15r22s11
	dec	lxoff(hl)		;FD 1Dr22s11
	dec	(hl+lxoff)		;FD 1Dr22s11
	dec	lxoff(sp)		;DD 05r22s11
	dec	(sp+lxoff)		;DD 05r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	dec	(daddr)			;DD 3D 44 33
    .nlist
    .ifeq _X_R
      .list
	dec	sxoff(ix)		;FD 0D 55 00
	dec	(ix+sxoff)		;FD 0D 55 00
	dec	sxoff(iy)		;FD 15 55 00
	dec	(iy+sxoff)		;FD 15 55 00
      .nlist
    .else
      .list
	dec	sxoff(ix)		;DD 35 55
	dec	(ix+sxoff)		;DD 35 55
	dec	sxoff(iy)		;FD 35 55
	dec	(iy+sxoff)		;FD 35 55
      .nlist
    .endif
    .list
	dec	sxoff(hl)		;FD 1D 55 00
	dec	(hl+sxoff)		;FD 1D 55 00
	dec	sxoff(sp)		;DD 05 55 00
	dec	(sp+sxoff)		;DD 05 55 00
	dec	lxoff(ix)		;FD 0D 22 11
	dec	(ix+lxoff)		;FD 0D 22 11
	dec	lxoff(iy)		;FD 15 22 11
	dec	(iy+lxoff)		;FD 15 22 11
	dec	lxoff(hl)		;FD 1D 22 11
	dec	(hl+lxoff)		;FD 1D 22 11
	dec	lxoff(sp)		;DD 05 22 11
	dec	(sp+lxoff)		;DD 05 22 11
    .nlist
  .endif
.list  ; end<--
	dec	(ix)			;DD 35 00
	dec	(iy)			;FD 35 00
	dec	(hl)			;35
	dec	(sp)			;DD 05 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
     .ifdef .EXLR
      .pcr_xtrn dec01,raofc
      .list
	dec	dec01(pc)		;FD 05p00q00
      .nlist
      .pcr_xtrn dec02,raofc
      .list
	dec	(pc+dec02)		;FD 05p00q00
      .nlist
      .pcr_xtrn dec03,raofc
      .list
	dec	[dec03]			;FD 05p00q00
      .nlist
    .else
      .pcr_lclx dec01
      .list
	dec	raofc+dec01(pc)		;FD 05p34q12
      .nlist
      .pcr_lclx dec02
      .list
	dec	(pc+raofc+dec02)	;FD 05p34q12
      .nlist
      .pcr_lclx dec03
      .list
	dec	[raofc+dec03]		;FD 05p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn dec01,raofc
      .list
	dec	dec01(pc)		;FD 05 34 12
      .nlist
      .pcr_xtrn dec02,raofc
      .list
	dec	(pc+dec02)		;FD 05 34 12
      .nlist
      .pcr_xtrn dec03,raofc
      .list
	dec	[dec03]			;FD 05 34 12
      .nlist
    .else
      .pcr_lclx dec01
      .list
	dec	raofc+dec01(pc)		;FD 05 34 12
      .nlist
      .pcr_lclx dec02
      .list
	dec	(pc+raofc+dec02)	;FD 05 34 12
      .nlist
      .pcr_lclx dec03
      .list
	dec	[raofc+dec03]		;FD 05 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	dec	raoff(pc)		;FD 05p34q12
	dec	(pc+raoff)		;FD 05p34q12
	dec	[raoff]			;FD 05p34q12
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	dec	pcr_ofst(pc)		;FD 05 34 12
      .nlist
	.pcr_ofst raofc
      .list
	dec	(pc+pcr_ofst)		;FD 05 34 12
      .nlist
	.pcr_ofst raofc
      .list
	dec	[pcr_ofst]		;FD 05 34 12
    .nlist
  .endif
.list  ; end<--
	dec	[.+offsetc]		;FD 05 51 00
	dec	(hl+ix)			;DD 0D
	dec	(hl+iy)			;DD 15
	dec	(ix+iy)			;DD 1D

;*******************************************************************
;	DECB	
;*******************************************************************
	;***********************************************************
	; decrement byte operand
	;  p. 5-32
	.z80
	decb	(hl)			;35
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	decb	offset(ix)		;DD 35r00
	decb	offset(iy)		;FD 35r00
	decb	(ix+offset)		;DD 35r00
	decb	(iy+offset)		;FD 35r00
      .nlist
    .else
      .list
	decb	offset(ix)		;DD 35r55
	decb	offset(iy)		;FD 35r55
	decb	(ix+offset)		;DD 35r55
	decb	(iy+offset)		;FD 35r55
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	decb	offset(ix)		;DD 35 55
	decb	offset(iy)		;FD 35 55
	decb	(ix+offset)		;DD 35 55
	decb	(iy+offset)		;FD 35 55
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	.z280
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	decb	(daddr)			;DD 3Dr00s00
	decb	sxoff(ix)		;FD 0Dr00s00
	decb	(ix+sxoff)		;FD 0Dr00s00
	decb	sxoff(iy)		;FD 15r00s00
	decb	(iy+sxoff)		;FD 15r00s00
	decb	sxoff(hl)		;FD 1Dr00s00
	decb	(hl+sxoff)		;FD 1Dr00s00
	decb	sxoff(sp)		;DD 05r00s00
	decb	(sp+sxoff)		;DD 05r00s00
	decb	lxoff(ix)		;FD 0Dr00s00
	decb	(ix+lxoff)		;FD 0Dr00s00
	decb	lxoff(iy)		;FD 15r00s00
	decb	(iy+lxoff)		;FD 15r00s00
	decb	lxoff(hl)		;FD 1Dr00s00
	decb	(hl+lxoff)		;FD 1Dr00s00
	decb	lxoff(sp)		;DD 05r00s00
	decb	(sp+lxoff)		;DD 05r00s00
      .nlist
    .else
      .list
	decb	(daddr)			;DD 3Dr44s33
	decb	sxoff(ix)		;FD 0Dr55s00
	decb	(ix+sxoff)		;FD 0Dr55s00
	decb	sxoff(iy)		;FD 15r55s00
	decb	(iy+sxoff)		;FD 15r55s00
	decb	sxoff(hl)		;FD 1Dr55s00
	decb	(hl+sxoff)		;FD 1Dr55s00
	decb	sxoff(sp)		;DD 05r55s00
	decb	(sp+sxoff)		;DD 05r55s00
	decb	lxoff(ix)		;FD 0Dr22s11
	decb	(ix+lxoff)		;FD 0Dr22s11
	decb	lxoff(iy)		;FD 15r22s11
	decb	(iy+lxoff)		;FD 15r22s11
	decb	lxoff(hl)		;FD 1Dr22s11
	decb	(hl+lxoff)		;FD 1Dr22s11
	decb	lxoff(sp)		;DD 05r22s11
	decb	(sp+lxoff)		;DD 05r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	decb	(daddr)			;DD 3D 44 33
    .nlist
    .ifeq _X_R
      .list
	decb	sxoff(ix)		;FD 0D 55 00
	decb	(ix+sxoff)		;FD 0D 55 00
	decb	sxoff(iy)		;FD 15 55 00
	decb	(iy+sxoff)		;FD 15 55 00
      .nlist
    .else
      .list
	decb	sxoff(ix)		;DD 35 55
	decb	(ix+sxoff)		;DD 35 55
	decb	sxoff(iy)		;FD 35 55
	decb	(iy+sxoff)		;FD 35 55
      .nlist
    .endif
    .list
	decb	sxoff(hl)		;FD 1D 55 00
	decb	(hl+sxoff)		;FD 1D 55 00
	decb	sxoff(sp)		;DD 05 55 00
	decb	(sp+sxoff)		;DD 05 55 00
	decb	lxoff(ix)		;FD 0D 22 11
	decb	(ix+lxoff)		;FD 0D 22 11
	decb	lxoff(iy)		;FD 15 22 11
	decb	(iy+lxoff)		;FD 15 22 11
	decb	lxoff(hl)		;FD 1D 22 11
	decb	(hl+lxoff)		;FD 1D 22 11
	decb	lxoff(sp)		;DD 05 22 11
	decb	(sp+lxoff)		;DD 05 22 11
    .nlist
  .endif
.list  ; end<--
	decb	(ix)			;DD 35 00
	decb	(iy)			;FD 35 00
	decb	(hl)			;35
	decb	(sp)			;DD 05 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn decb01,raofc
      .list
	decb	decb01(pc)		;FD 05p00q00
      .nlist
      .pcr_xtrn decb02,raofc
      .list
	decb	(pc+decb02)		;FD 05p00q00
      .nlist
      .pcr_xtrn decb03,raofc
      .list
	decb	[decb03]		;FD 05p00q00
      .nlist
    .else
      .pcr_lclx decb01
      .list
	decb	raofc+decb01(pc)	;FD 05p34q12
      .nlist
      .pcr_lclx decb02
      .list
	decb	(pc+raofc+decb02)	;FD 05p34q12
      .nlist
      .pcr_lclx decb03
      .list
	decb	[raofc+decb03]		;FD 05p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn decb01,raofc
      .list
	decb	decb01(pc)		;FD 05 34 12
      .nlist
      .pcr_xtrn decb02,raofc
      .list
	decb	(pc+decb02)		;FD 05 34 12
      .nlist
      .pcr_xtrn decb03,raofc
      .list
	decb	[decb03]		;FD 05 34 12
      .nlist
    .else
      .pcr_lclx decb01
      .list
	decb	raofc+decb01(pc)	;FD 05 34 12
      .nlist
      .pcr_lclx decb02
      .list
	decb	(pc+raofc+decb02)	;FD 05 34 12
      .nlist
      .pcr_lclx decb03
      .list
	decb	[raofc+decb03]		;FD 05 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	decb	raoff(pc)		;FD 05p34q12
	decb	(pc+raoff)		;FD 05p34q12
	decb	[raoff]			;FD 05p34q12
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	decb	pcr_ofst(pc)		;FD 05 34 12
      .nlist
	.pcr_ofst raofc
      .list
	decb	(pc+pcr_ofst)		;FD 05 34 12
      .nlist
	.pcr_ofst raofc
      .list
	decb	[pcr_ofst]		;FD 05 34 12
    .nlist
  .endif
.list  ; end<--
	decb	[.+offsetc]		;FD 05 51 00
	decb	(hl+ix)			;DD 0D
	decb	(hl+iy)			;DD 15
	decb	(ix+iy)			;DD 1D

;*******************************************************************
;	DECW	
;*******************************************************************
	;***********************************************************
	;  p. 5-32
	.z80
	decw	bc			;0B
	decw	de			;1B
	decw	hl			;2B
	decw	sp			;3B
	decw	ix			;DD 2B
	decw	iy			;FD 2B
	;***********************************************************
	;  p. 5-33
	.z280
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	decw	(daddr)			;DD 1Br00s00
	decw	sxoff(ix)		;FD 0Br00s00
	decw	(ix+sxoff)		;FD 0Br00s00
	decw	sxoff(iy)		;FD 1Br00s00
	decw	(iy+sxoff)		;FD 1Br00s00
	decw	lxoff(ix)		;FD 0Br00s00
	decw	(ix+lxoff)		;FD 0Br00s00
	decw	lxoff(iy)		;FD 1Br00s00
	decw	(iy+lxoff)		;FD 1Br00s00
      .nlist
    .else
      .list
	decw	(daddr)			;DD 1Br44s33
	decw	sxoff(ix)		;FD 0Br55s00
	decw	(ix+sxoff)		;FD 0Br55s00
	decw	sxoff(iy)		;FD 1Br55s00
	decw	(iy+sxoff)		;FD 1Br55s00
	decw	lxoff(ix)		;FD 0Br22s11
	decw	(ix+lxoff)		;FD 0Br22s11
	decw	lxoff(iy)		;FD 1Br22s11
	decw	(iy+lxoff)		;FD 1Br22s11
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	decw	(daddr)			;DD 1B 44 33
	decw	sxoff(ix)		;FD 0B 55 00
	decw	(ix+sxoff)		;FD 0B 55 00
	decw	sxoff(iy)		;FD 1B 55 00
	decw	(iy+sxoff)		;FD 1B 55 00
	decw	lxoff(ix)		;FD 0B 22 11
	decw	(ix+lxoff)		;FD 0B 22 11
	decw	lxoff(iy)		;FD 1B 22 11
	decw	(iy+lxoff)		;FD 1B 22 11
    .nlist
  .endif
.list  ; end<--
	decw	(ix)			;FD 0B 00 00
	decw	(iy)			;FD 1B 00 00
	decw	(hl)			;DD 0B
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn decw01,raofc
      .list
	decw	decw01(pc)		;DD 3Bp00q00
      .nlist
      .pcr_xtrn decw02,raofc
      .list
	decw	(pc+decw02)		;DD 3Bp00q00
      .nlist
      .pcr_xtrn decw03,raofc
      .list
	decw	[decw03]		;DD 3Bp00q00
      .nlist
    .else
      .pcr_lclx decw01
      .list
	decw	raofc+decw01(pc)	;DD 3Bp34q12
      .nlist
      .pcr_lclx decw02
      .list
	decw	(pc+raofc+decw02)	;DD 3Bp34q12
      .nlist
      .pcr_lclx decw03
      .list
	decw	[raofc+decw03]		;DD 3Bp34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn decw01,raofc
      .list
	decw	decw01(pc)		;DD 3B 34 12
      .nlist
      .pcr_xtrn decw02,raofc
      .list
	decw	(pc+decw02)		;DD 3B 34 12
      .nlist
      .pcr_xtrn decw03,raofc
      .list
	decw	[decw03]		;DD 3B 34 12
      .nlist
    .else
      .pcr_lclx decw01
      .list
	decw	raofc+decw01(pc)	;DD 3B 34 12
      .nlist
      .pcr_lclx decw02
      .list
	decw	(pc+raofc+decw02)	;DD 3B 34 12
      .nlist
      .pcr_lclx decw03
      .list
	decw	[raofc+decw03]		;DD 3B 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	decw	raoff(pc)		;DD 3Bp34q12
	decw	(pc+raoff)		;DD 3Bp34q12
	decw	[raoff]			;DD 3Bp34q12
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	decw	pcr_ofst(pc)		;DD 3B 34 12
      .nlist
	.pcr_ofst raofc
      .list
	decw	(pc+pcr_ofst)		;DD 3B 34 12
      .nlist
	.pcr_ofst raofc
      .list
	decw	[pcr_ofst]		;DD 3B 34 12
    .nlist
  .endif
.list  ; end<--
	decw	[.+offsetc]		;DD 3B 51 00

;*******************************************************************
;	DI	
;*******************************************************************
	;***********************************************************
	; disable interrupts
	.z80
	di				;F3
;	di	#3			;	q
	.z180
	di				;F3
;	di	#3			;	q
	;***********************************************************
	;  p. 5-34
	.z280
;	di				;	q
;	di	#3			;	q
	.z280p
	di				;F3
	di	#3			;ED 77 03
	di	 3			;ED 77 03

;*******************************************************************
;	DIV	
;*******************************************************************
	;***********************************************************
	;  p. 5-35	DIV(byte)
	.z280
	div	hl,a			;ED FC
	div	hl,b			;ED C4
	div	hl,c			;ED CC
	div	hl,d			;ED D4
	div	hl,e			;ED DC
	div	hl,h			;ED E4
	div	hl,l			;ED EC
	div	hl,ixh			;DD ED E4
	div	hl,ixl			;DD ED EC
	div	hl,iyh			;FD ED E4
	div	hl,iyl			;FD ED EC
	div	hl,#10			;FD ED FC 0A
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	div	hl,(daddr)		;DD ED FCr00s00
	div	hl,offset(ix)		;FD ED CCr00s00
	div	hl,(ix+offset)		;FD ED CCr00s00
	div	hl,offset(iy)		;FD ED D4r00s00
	div	hl,(iy+offset)		;FD ED D4r00s00
	div	hl,offset(hl)		;FD ED DCr00s00
	div	hl,(hl+offset)		;FD ED DCr00s00
	div	hl,offset(sp)		;DD ED C4r00s00
	div	hl,(sp+offset)		;DD ED C4r00s00
	div	hl,lxoff(ix)		;FD ED CCr00s00
	div	hl,(ix+lxoff)		;FD ED CCr00s00
	div	hl,lxoff(iy)		;FD ED D4r00s00
	div	hl,(iy+lxoff)		;FD ED D4r00s00
	div	hl,lxoff(hl)		;FD ED DCr00s00
	div	hl,(hl+lxoff)		;FD ED DCr00s00
	div	hl,lxoff(sp)		;DD ED C4r00s00
	div	hl,(sp+lxoff)		;DD ED C4r00s00
      .nlist
    .else
      .list
	div	hl,(daddr)		;DD ED FCr44s33
	div	hl,offset(ix)		;FD ED CCr55s00
	div	hl,(ix+offset)		;FD ED CCr55s00
	div	hl,offset(iy)		;FD ED D4r55s00
	div	hl,(iy+offset)		;FD ED D4r55s00
	div	hl,offset(hl)		;FD ED DCr55s00
	div	hl,(hl+offset)		;FD ED DCr55s00
	div	hl,offset(sp)		;DD ED C4r55s00
	div	hl,(sp+offset)		;DD ED C4r55s00
	div	hl,lxoff(ix)		;FD ED CCr22s11
	div	hl,(ix+lxoff)		;FD ED CCr22s11
	div	hl,lxoff(iy)		;FD ED D4r22s11
	div	hl,(iy+lxoff)		;FD ED D4r22s11
	div	hl,lxoff(hl)		;FD ED DCr22s11
	div	hl,(hl+lxoff)		;FD ED DCr22s11
	div	hl,lxoff(sp)		;DD ED C4r22s11
	div	hl,(sp+lxoff)		;DD ED C4r22s11
      .nlist
    .endif
  .else
    .list
	div	hl,(daddr)		;DD ED FC 44 33
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	div	hl,offset(ix)		;FD ED CC 55 00
	div	hl,(ix+offset)		;FD ED CC 55 00
	div	hl,offset(iy)		;FD ED D4 55 00
	div	hl,(iy+offset)		;FD ED D4 55 00
      .nlist
    .else
      .list
	div	hl,offset(ix)		;DD ED F4 55
	div	hl,(ix+offset)		;DD ED F4 55
	div	hl,offset(iy)		;FD ED F4 55
	div	hl,(iy+offset)		;FD ED F4 55
      .nlist
    .endif
    .list
	div	hl,offset(hl)		;FD ED DC 55 00
	div	hl,(hl+offset)		;FD ED DC 55 00
	div	hl,offset(sp)		;DD ED C4 55 00
	div	hl,(sp+offset)		;DD ED C4 55 00
	div	hl,lxoff(ix)		;FD ED CC 22 11
	div	hl,(ix+lxoff)		;FD ED CC 22 11
	div	hl,lxoff(iy)		;FD ED D4 22 11
	div	hl,(iy+lxoff)		;FD ED D4 22 11
	div	hl,lxoff(hl)		;FD ED DC 22 11
	div	hl,(hl+lxoff)		;FD ED DC 22 11
	div	hl,lxoff(sp)		;DD ED C4 22 11
	div	hl,(sp+lxoff)		;DD ED C4 22 11
    .nlist
  .endif
.list  ; end<--
	div	hl,(ix)			;DD ED F4 00
	div	hl,(iy)			;FD ED F4 00
; misprint in the manual on p. 5-35 says the following should assemble as ED E4
;  Appendix C.  corrects this to ED F4
	div	hl,(hl)			;ED F4
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn div01,offsetc,5
      .list
	div	hl,div01(pc)		;FD ED C4p00q00
      .nlist
      .pcr_xtrn div02,offsetc,5
      .list
	div	hl,(pc+div02)		;FD ED C4p00q00
      .nlist
      .pcr_xtrn div03,offsetc,5
      .list
	div	hl,[div03]		;FD ED C4p00q00
      .nlist
    .else
      .pcr_lclx div01,5
      .list
	div	hl,offsetc+div01(pc)	;FD ED C4p55q00
      .nlist
      .pcr_lclx div02,5
      .list
	div	hl,(pc+offsetc+div02)	;FD ED C4p55q00
      .nlist
      .pcr_lclx div03,5
      .list
	div	hl,[offsetc+div03]	;FD ED C4p55q00
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn div01,offsetc,5
      .list
	div	hl,div01(pc)		;FD ED C4 55 00
      .nlist
      .pcr_xtrn div02,offsetc,5
      .list
	div	hl,(pc+div02)		;FD ED C4 55 00
      .nlist
      .pcr_xtrn div03,offsetc,5
      .list
	div	hl,[div03]		;FD ED C4 55 00
      .nlist
    .else
      .pcr_lclx div01,5
      .list
	div	hl,offsetc+div01(pc)	;FD ED C4 55 00
      .nlist
      .pcr_lclx div02,5
      .list
	div	hl,(pc+offsetc+div02)	;FD ED C4 55 00
      .nlist
      .pcr_lclx div03,5
      .list
	div	hl,[offsetc+div03]	;FD ED C4 55 00
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	div	hl,offset(pc)		;FD ED C4p55q00
	div	hl,(pc+offset)		;FD ED C4p55q00
	div	hl,[offset]		;FD ED C4p55q00
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst offsetc,5
      .list
	div	hl,pcr_ofst(pc)		;FD ED C4 55 00
      .nlist
	.pcr_ofst  offsetc,5
      .list
	div	hl,(pc+pcr_ofst)	;FD ED C4 55 00
      .nlist
	.pcr_ofst  offsetc,5
      .list
	div	hl,[pcr_ofst]		;FD ED C4 55 00
    .nlist
  .endif
.list  ; end<--
	div	hl,[.+offsetc]		;FD ED C4 50 00
	div	hl,(hl+ix)		;DD ED CC
	div	hl,(hl+iy)		;DD ED D4
	div	hl,(ix+iy)		;DD ED DC

;*******************************************************************
;	DIVU
;*******************************************************************
	;***********************************************************
	;  p. 5-37	DIVU(byte)
	.z280
	divu	hl,a			;ED FD
	divu	hl,b			;ED C5
	divu	hl,c			;ED CD
	divu	hl,d			;ED D5
	divu	hl,e			;ED DD
	divu	hl,h			;ED E5
	divu	hl,l			;ED ED
	divu	hl,ixh			;DD ED E5
	divu	hl,ixl			;DD ED ED
	divu	hl,iyh			;FD ED E5
	divu	hl,iyl			;FD ED ED
	divu	hl,#10			;FD ED FD 0A
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	divu	hl,(daddr)		;DD ED FDr00s00
	divu	hl,offset(ix)		;FD ED CDr00s00
	divu	hl,(ix+offset)		;FD ED CDr00s00
	divu	hl,offset(iy)		;FD ED D5r00s00
	divu	hl,(iy+offset)		;FD ED D5r00s00
	divu	hl,offset(hl)		;FD ED DDr00s00
	divu	hl,(hl+offset)		;FD ED DDr00s00
	divu	hl,offset(sp)		;DD ED C5r00s00
	divu	hl,(sp+offset)		;DD ED C5r00s00
	divu	hl,lxoff(ix)		;FD ED CDr00s00
	divu	hl,(ix+lxoff)		;FD ED CDr00s00
	divu	hl,lxoff(iy)		;FD ED D5r00s00
	divu	hl,(iy+lxoff)		;FD ED D5r00s00
	divu	hl,lxoff(hl)		;FD ED DDr00s00
	divu	hl,(hl+lxoff)		;FD ED DDr00s00
	divu	hl,lxoff(sp)		;DD ED C5r00s00
	divu	hl,(sp+lxoff)		;DD ED C5r00s00
      .nlist
    .else
      .list
	divu	hl,(daddr)		;DD ED FDr44s33
	divu	hl,offset(ix)		;FD ED CDr55s00
	divu	hl,(ix+offset)		;FD ED CDr55s00
	divu	hl,offset(iy)		;FD ED D5r55s00
	divu	hl,(iy+offset)		;FD ED D5r55s00
	divu	hl,offset(hl)		;FD ED DDr55s00
	divu	hl,(hl+offset)		;FD ED DDr55s00
	divu	hl,offset(sp)		;DD ED C5r55s00
	divu	hl,(sp+offset)		;DD ED C5r55s00
	divu	hl,lxoff(ix)		;FD ED CDr22s11
	divu	hl,(ix+lxoff)		;FD ED CDr22s11
	divu	hl,lxoff(iy)		;FD ED D5r22s11
	divu	hl,(iy+lxoff)		;FD ED D5r22s11
	divu	hl,lxoff(hl)		;FD ED DDr22s11
	divu	hl,(hl+lxoff)		;FD ED DDr22s11
	divu	hl,lxoff(sp)		;DD ED C5r22s11
	divu	hl,(sp+lxoff)		;DD ED C5r22s11
      .nlist
    .endif
  .else
    .list
	divu	hl,(daddr)		;DD ED FD 44 33
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	divu	hl,offset(ix)		;FD ED CD 55 00
	divu	hl,(ix+offset)		;FD ED CD 55 00
	divu	hl,offset(iy)		;FD ED D5 55 00
	divu	hl,(iy+offset)		;FD ED D5 55 00
      .nlist
    .else
      .list
	divu	hl,offset(ix)		;DD ED F5 55
	divu	hl,(ix+offset)		;DD ED F5 55
	divu	hl,offset(iy)		;FD ED F5 55
	divu	hl,(iy+offset)		;FD ED F5 55
      .nlist
    .endif
    .list
	divu	hl,offset(hl)		;FD ED DD 55 00
	divu	hl,(hl+offset)		;FD ED DD 55 00
	divu	hl,offset(sp)		;DD ED C5 55 00
	divu	hl,(sp+offset)		;DD ED C5 55 00
	divu	hl,lxoff(ix)		;FD ED CD 22 11
	divu	hl,(ix+lxoff)		;FD ED CD 22 11
	divu	hl,lxoff(iy)		;FD ED D5 22 11
	divu	hl,(iy+lxoff)		;FD ED D5 22 11
	divu	hl,lxoff(hl)		;FD ED DD 22 11
	divu	hl,(hl+lxoff)		;FD ED DD 22 11
	divu	hl,lxoff(sp)		;DD ED C5 22 11
	divu	hl,(sp+lxoff)		;DD ED C5 22 11
    .nlist
  .endif
.list  ; end<--
	divu	hl,(iy)			;FD ED F5 00
	divu	hl,(ix)			;DD ED F5 00
	divu	hl,(hl)			;ED F5
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn divu01,offsetc,5
      .list
	divu	hl,divu01(pc)		;FD ED C5p00q00
      .nlist
      .pcr_xtrn divu02,offsetc,5
      .list
	divu	hl,(pc+divu02)		;FD ED C5p00q00
      .nlist
      .pcr_xtrn divu03,offsetc,5
      .list
	divu	hl,[divu03]		;FD ED C5p00q00
      .nlist
    .else
      .pcr_lclx divu01,5
      .list
	divu	hl,offsetc+divu01(pc)	;FD ED C5p55q00
      .nlist
      .pcr_lclx divu02,5
      .list
	divu	hl,(pc+offsetc+divu02)	;FD ED C5p55q00
      .nlist
      .pcr_lclx divu03,5
      .list
	divu	hl,[offsetc+divu03]	;FD ED C5p55q00
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn divu01,offsetc,5
      .list
	divu	hl,divu01(pc)		;FD ED C5 55 00
      .nlist
      .pcr_xtrn divu02,offsetc,5
      .list
	divu	hl,(pc+divu02)		;FD ED C5 55 00
      .nlist
      .pcr_xtrn divu03,offsetc,5
      .list
	divu	hl,[divu03]		;FD ED C5 55 00
      .nlist
    .else
      .pcr_lclx divu01,5
      .list
	divu	hl,offsetc+divu01(pc)	;FD ED C5 55 00
      .nlist
      .pcr_lclx divu02,5
      .list
	divu	hl,(pc+offsetc+divu02)	;FD ED C5 55 00
      .nlist
      .pcr_lclx divu03,5
      .list
	divu	hl,[offsetc+divu03]	;FD ED C5 55 00
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	divu	hl,offset(pc)		;FD ED C5p55q00
	divu	hl,(pc+offset)		;FD ED C5p55q00
	divu	hl,[offset]		;FD ED C5p55q00
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst offsetc,5
      .list
	divu	hl,pcr_ofst(pc)		;FD ED C5 55 00
      .nlist
	.pcr_ofst offsetc,5
      .list
	divu	hl,(pc+pcr_ofst)	;FD ED C5 55 00
      .nlist
	.pcr_ofst offsetc,5
      .list
	divu	hl,[pcr_ofst]		;FD ED C5 55 00
    .nlist
  .endif
.list  ; end<--
	divu	hl,[.+offsetc]		;FD ED C5 50 00
	divu	hl,(hl+ix)		;DD ED CD
	divu	hl,(hl+iy)		;DD ED D5
	divu	hl,(ix+iy)		;DD ED DD

;*******************************************************************
;	DIVUW	
;*******************************************************************
	;***********************************************************
	;  p. 5-39	DIVUW(word)
	.z280
	divuw	dehl,bc			;ED CB
	divuw	dehl,de			;ED DB
	divuw	dehl,hl			;ED EB
	divuw	dehl,sp			;ED FB
	divuw	dehl,ix			;DD ED EB
	divuw	dehl,iy			;FD ED EB
	divuw	dehl,(hl)		;DD ED CB
	divuw	dehl,(ix)		;FD ED CB 00 00
	divuw	dehl,(iy)		;FD ED DB 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
    	divuw	dehl,#n			;FD ED FBr00s00
	divuw	dehl,#nn		;FD ED FBr00s00
	divuw	dehl,(daddr)		;DD ED DBr00s00
	divuw	dehl,(ix+offset)	;FD ED CBr00s00
	divuw	dehl,offset(ix)		;FD ED CBr00s00
	divuw	dehl,(iy+offset)	;FD ED DBr00s00
	divuw	dehl,offset(iy)		;FD ED DBr00s00
	divuw	dehl,(ix+lxoff)		;FD ED CBr00s00
	divuw	dehl,lxoff(ix)		;FD ED CBr00s00
	divuw	dehl,(iy+lxoff)		;FD ED DBr00s00
	divuw	dehl,lxoff(iy)		;FD ED DBr00s00
      .nlist
    .else
      .list
    	divuw	dehl,#n			;FD ED FBr20s00
	divuw	dehl,#nn		;FD ED FBr84s05
	divuw	dehl,(daddr)		;DD ED DBr44s33
	divuw	dehl,(ix+offset)	;FD ED CBr55s00
	divuw	dehl,offset(ix)		;FD ED CBr55s00
	divuw	dehl,(iy+offset)	;FD ED DBr55s00
	divuw	dehl,offset(iy)		;FD ED DBr55s00
	divuw	dehl,(ix+lxoff)		;FD ED CBr22s11
	divuw	dehl,lxoff(ix)		;FD ED CBr22s11
	divuw	dehl,(iy+lxoff)		;FD ED DBr22s11
	divuw	dehl,lxoff(iy)		;FD ED DBr22s11
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
    	divuw	dehl,#n			;FD ED FB 20 00
	divuw	dehl,#nn		;FD ED FB 84 05
	divuw	dehl,(daddr)		;DD ED DB 44 33
	divuw	dehl,(ix+offset)	;FD ED CB 55 00
	divuw	dehl,offset(ix)		;FD ED CB 55 00
	divuw	dehl,(iy+offset)	;FD ED DB 55 00
	divuw	dehl,offset(iy)		;FD ED DB 55 00
	divuw	dehl,(ix+lxoff)		;FD ED CB 22 11
	divuw	dehl,lxoff(ix)		;FD ED CB 22 11
	divuw	dehl,(iy+lxoff)		;FD ED DB 22 11
	divuw	dehl,lxoff(iy)		;FD ED DB 22 11
    .nlist
  .endif
.list  ; end<--
	divuw	dehl,(ix)		;FD ED CB 00 00
	divuw	dehl,(iy)		;FD ED DB 00 00
	divuw	dehl,(hl)		;DD ED CB
.nlist ; -->bgn
  .ifeq _XL_					; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn divuw01,offsetc,5
      .list
	divuw	dehl,divuw01(pc)		;DD ED FBp00q00
      .nlist
      .pcr_xtrn divuw02,offsetc,5
      .list
	divuw	dehl,(pc+divuw02)		;DD ED FBp00q00
      .nlist
      .pcr_xtrn divuw03,offsetc,5
      .list
	divuw	dehl,[divuw03]			;DD ED FBp00q00
      .nlist
    .else
      .pcr_lclx divuw01,5
      .list
	divuw	dehl,offsetc+divuw01(pc)	;DD ED FBp55q00
      .nlist
      .pcr_lclx divuw02,5
      .list
	divuw	dehl,(pc+offsetc+divuw02)	;DD ED FBp55q00
      .nlist
      .pcr_lclx divuw03,5
      .list
	divuw	dehl,[offsetc+divuw03]		;DD ED FBp55q00
      .nlist
    .endif
  .endif
  .ifeq _X_R					; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn divuw01,offsetc,5
      .list
	divuw	dehl,divuw01(pc)		;DD ED FB 55 00
      .nlist
      .pcr_xtrn divuw02,offsetc,5
      .list
	divuw	dehl,(pc+divuw02)		;DD ED FB 55 00
      .nlist
      .pcr_xtrn divuw03,offsetc,5
      .list
	divuw	dehl,[divuw03]			;DD ED FB 55 00
      .nlist
    .else
      .pcr_lclx divuw01,5
      .list
	divuw	dehl,offsetc+divuw01(pc)	;DD ED FB 55 00
      .nlist
      .pcr_lclx divuw02,5
      .list
	divuw	dehl,(pc+offsetc+divuw02)	;DD ED FB 55 00
      .nlist
      .pcr_lclx divuw03,5
      .list
	divuw	dehl,[offsetc+divuw03]		;DD ED FB 55 00
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	divuw	dehl,offset(pc)		;DD ED FBp55q00
	divuw	dehl,(pc+offset)	;DD ED FBp55q00
	divuw	dehl,[offset]		;DD ED FBp55q00
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst offsetc,5
      .list
	divuw	dehl,pcr_ofst(pc)	;DD ED FB 55 00
      .nlist
	.pcr_ofst offsetc,5
      .list
	divuw	dehl,(pc+pcr_ofst)	;DD ED FB 55 00
      .nlist
	.pcr_ofst offsetc,5
      .list
	divuw	dehl,[pcr_ofst]		;DD ED FB 55 00
    .nlist
  .endif
.list  ; end<--
	divuw	dehl,[.+offsetc]	;DD ED FB 50 00

;*******************************************************************
;	DIVW	
;*******************************************************************
	;***********************************************************
	;  p. 5-41	DIVW(word)
	.z280
	divw	dehl,bc			;ED CA
	divw	dehl,de			;ED DA
	divw	dehl,hl			;ED EA
	divw	dehl,sp			;ED FA
	divw	dehl,ix			;DD ED EA
	divw	dehl,iy			;FD ED EA
	divw	dehl,(hl)		;DD ED CA
	divw	dehl,(ix)		;FD ED CA 00 00
	divw	dehl,(iy)		;FD ED DA 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	divw	dehl,#n			;FD ED FAr00s00
	divw	dehl,#nn		;FD ED FAr00s00
	divw	dehl,(daddr)		;DD ED DAr00s00
	divw	dehl,(ix+offset)	;FD ED CAr00s00
	divw	dehl,offset(ix)		;FD ED CAr00s00
	divw	dehl,(iy+offset)	;FD ED DAr00s00
	divw	dehl,offset(iy)		;FD ED DAr00s00
	divw	dehl,(ix+lxoff)		;FD ED CAr00s00
	divw	dehl,lxoff(ix)		;FD ED CAr00s00
	divw	dehl,(iy+lxoff)		;FD ED DAr00s00
	divw	dehl,lxoff(iy)		;FD ED DAr00s00
      .nlist
    .else
      .list
	divw	dehl,#n			;FD ED FAr20s00
	divw	dehl,#nn		;FD ED FAr84s05
	divw	dehl,(daddr)		;DD ED DAr44s33
	divw	dehl,(ix+offset)	;FD ED CAr55s00
	divw	dehl,offset(ix)		;FD ED CAr55s00
	divw	dehl,(iy+offset)	;FD ED DAr55s00
	divw	dehl,offset(iy)		;FD ED DAr55s00
	divw	dehl,(ix+lxoff)		;FD ED CAr22s11
	divw	dehl,lxoff(ix)		;FD ED CAr22s11
	divw	dehl,(iy+lxoff)		;FD ED DAr22s11
	divw	dehl,lxoff(iy)		;FD ED DAr22s11
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	divw	dehl,#n			;FD ED FA 20 00
	divw	dehl,#nn		;FD ED FA 84 05
	divw	dehl,(daddr)		;DD ED DA 44 33
	divw	dehl,(ix+offset)	;FD ED CA 55 00
	divw	dehl,offset(ix)		;FD ED CA 55 00
	divw	dehl,(iy+offset)	;FD ED DA 55 00
	divw	dehl,offset(iy)		;FD ED DA 55 00
	divw	dehl,(ix+lxoff)		;FD ED CA 22 11
	divw	dehl,lxoff(ix)		;FD ED CA 22 11
	divw	dehl,(iy+lxoff)		;FD ED DA 22 11
	divw	dehl,lxoff(iy)		;FD ED DA 22 11
    .nlist
  .endif
.list  ; end<--
	divw	dehl,(ix)		;FD ED CA 00 00
	divw	dehl,(iy)		;FD ED DA 00 00
	divw	dehl,(hl)		;DD ED CA
.nlist ; -->bgn
  .ifeq _XL_					; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn divw01,offsetc,5
      .list
	divw	dehl,divw01(pc)			;DD ED FAp00q00
      .nlist
      .pcr_xtrn divw02,offsetc,5
      .list
	divw	dehl,(pc+divw02)		;DD ED FAp00q00
      .nlist
      .pcr_xtrn divw03,offsetc,5
      .list
	divw	dehl,[divw03]			;DD ED FAp00q00
      .nlist
    .else
      .pcr_lclx divw01,5
      .list
	divw	dehl,offsetc+divw01(pc)		;DD ED FAp55q00
      .nlist
      .pcr_lclx divw02,5
      .list
	divw	dehl,(pc+offsetc+divw02)	;DD ED FAp55q00
      .nlist
      .pcr_lclx divw03,5
      .list
	divw	dehl,[offsetc+divw03]		;DD ED FAp55q00
      .nlist
    .endif
  .endif
  .ifeq _X_R					; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn divw01,offsetc,5
      .list
	divw	dehl,divw01(pc)			;DD ED FA 55 00
      .nlist
      .pcr_xtrn divw02,offsetc,5
      .list
	divw	dehl,(pc+divw02)		;DD ED FA 55 00
      .nlist
      .pcr_xtrn divw03,offsetc,5
      .list
	divw	dehl,[divw03]			;DD ED FA 55 00
      .nlist
    .else
      .pcr_lclx divw01,5
      .list
	divw	dehl,offsetc+divw01(pc)		;DD ED FA 55 00
      .nlist
      .pcr_lclx divw02,5
      .list
	divw	dehl,(pc+offsetc+divw02)	;DD ED FA 55 00
      .nlist
      .pcr_lclx divw03,5
      .list
	divw	dehl,[offsetc+divw03]		;DD ED FA 55 00
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	divw	dehl,offset(pc)		;DD ED FAp55q00
	divw	dehl,(pc+offset)	;DD ED FAp55q00
	divw	dehl,[offset]		;DD ED FAp55q00
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst offsetc,5
      .list
	divw	dehl,pcr_ofst(pc)	;DD ED FA 55 00
      .nlist
	.pcr_ofst offsetc,5
      .list
	divw	dehl,(pc+pcr_ofst)	;DD ED FA 55 00
      .nlist
	.pcr_ofst offsetc,5
      .list
	divw	dehl,[pcr_ofst]		;DD ED FA 55 00
    .nlist
  .endif
.list  ; end<--
	divw	dehl,[.+offsetc]	;DD ED FA 50 00

;*******************************************************************
;	DJNZ	
;*******************************************************************
	.z80
	;***********************************************************
	; decrement b and jump relative if b # 0
	djnz	.+0x12			;10 10

;*******************************************************************
;	EI	
;*******************************************************************
	;***********************************************************
	; enable interrupts
	.z80
	ei				;FB
	.z180
	ei				;FB
	;***********************************************************
	;  p. 5-44
	.z280p
	ei				;FB
	ei	#0x37			;ED 7F 37

;*******************************************************************
;	EX	
;		If offset is ommitted 0 is assumed.
;*******************************************************************
	;***********************************************************
	; exchange location and (sp)
	.z80
	ex	(sp),hl			;E3
	ex	(sp),ix			;DD E3
	ex	(sp),iy			;FD E3
	;***********************************************************
	; exchange af and af'
	ex	af,af'			;08
	;***********************************************************
	; exchange de and hl
	ex	de,hl			;EB
	;***********************************************************
	;  p. 5-47
	.z280
	ex	h,l			;ED EF
	;  p. 5-48
	ex	ix,hl			;DD EB
	ex	iy,hl			;FD EB
	ex	hl,iy			;FD EB
	ex	hl,ix			;DD EB
	; p. 5-49
	ex	a,a			;ED 3F
	ex	a,b			;ED 07
	ex	a,c			;ED 0F
	ex	a,d			;ED 17
	ex	a,e			;ED 1F
	ex	a,h			;ED 27
	ex	a,l			;ED 2F
	ex	a,ixh			;DD ED 27
	ex	a,ixl			;DD ED 2F
	ex	a,iyh			;FD ED 27
	ex	a,iyl			;FD ED 2F
	ex	a,(hl)			;ED 37
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ex	a,(daddr)		;DD ED 3Fr00s00
	ex	a,offset(ix)		;FD ED 0Fr00s00
	ex	a,(ix+offset)		;FD ED 0Fr00s00
	ex	a,offset(iy)		;FD ED 17r00s00
	ex	a,(iy+offset)		;FD ED 17r00s00
	ex	a,offset(hl)		;FD ED 1Fr00s00
	ex	a,(hl+offset)		;FD ED 1Fr00s00
	ex	a,offset(sp)		;DD ED 07r00s00
	ex	a,(sp+offset)		;DD ED 07r00s00
	ex	a,lxoff(ix)		;FD ED 0Fr00s00
	ex	a,(ix+lxoff)		;FD ED 0Fr00s00
	ex	a,lxoff(iy)		;FD ED 17r00s00
	ex	a,(iy+lxoff)		;FD ED 17r00s00
	ex	a,lxoff(hl)		;FD ED 1Fr00s00
	ex	a,(hl+lxoff)		;FD ED 1Fr00s00
	ex	a,lxoff(sp)		;DD ED 07r00s00
	ex	a,(sp+lxoff)		;DD ED 07r00s00
      .nlist
    .else
      .list
	ex	a,(daddr)		;DD ED 3Fr44s33
	ex	a,offset(ix)		;FD ED 0Fr55s00
	ex	a,(ix+offset)		;FD ED 0Fr55s00
	ex	a,offset(iy)		;FD ED 17r55s00
	ex	a,(iy+offset)		;FD ED 17r55s00
	ex	a,offset(hl)		;FD ED 1Fr55s00
	ex	a,(hl+offset)		;FD ED 1Fr55s00
	ex	a,offset(sp)		;DD ED 07r55s00
	ex	a,(sp+offset)		;DD ED 07r55s00
	ex	a,lxoff(ix)		;FD ED 0Fr22s11
	ex	a,(ix+lxoff)		;FD ED 0Fr22s11
	ex	a,lxoff(iy)		;FD ED 17r22s11
	ex	a,(iy+lxoff)		;FD ED 17r22s11
	ex	a,lxoff(hl)		;FD ED 1Fr22s11
	ex	a,(hl+lxoff)		;FD ED 1Fr22s11
	ex	a,lxoff(sp)		;DD ED 07r22s11
	ex	a,(sp+lxoff)		;DD ED 07r22s11
      .nlist
    .endif
  .else
    .list
	ex	a,(daddr)		;DD ED 3F 44 33
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	ex	a,offset(ix)		;FD ED 0F 55 00
	ex	a,(ix+offset)		;FD ED 0F 55 00
	ex	a,offset(iy)		;FD ED 17 55 00
	ex	a,(iy+offset)		;FD ED 17 55 00
      .nlist
    .else
      .list
	ex	a,offset(ix)		;DD ED 37 55
	ex	a,(ix+offset)		;DD ED 37 55
	ex	a,offset(iy)		;FD ED 37 55
	ex	a,(iy+offset)		;FD ED 37 55
      .nlist
    .endif
    .list
	ex	a,offset(hl)		;FD ED 1F 55 00
	ex	a,(hl+offset)		;FD ED 1F 55 00
	ex	a,offset(sp)		;DD ED 07 55 00
	ex	a,(sp+offset)		;DD ED 07 55 00
	ex	a,lxoff(ix)		;FD ED 0F 22 11
	ex	a,(ix+lxoff)		;FD ED 0F 22 11
	ex	a,lxoff(iy)		;FD ED 17 22 11
	ex	a,(iy+lxoff)		;FD ED 17 22 11
	ex	a,lxoff(hl)		;FD ED 1F 22 11
	ex	a,(hl+lxoff)		;FD ED 1F 22 11
	ex	a,lxoff(sp)		;DD ED 07 22 11
	ex	a,(sp+lxoff)		;DD ED 07 22 11
    .nlist
  .endif
.list  ; end<--
	ex	a,(ix)			;DD ED 37 00
	ex	a,(iy)			;FD ED 37 00
;	ex	a,(hl)			;FD ED 1F 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn ex01,offsetc,5
      .list
	ex	a,ex01(pc)		;FD ED 07p00q00
      .nlist
      .pcr_xtrn ex02,offsetc,5
      .list
	ex	a,(pc+ex02)		;FD ED 07p00q00
      .nlist
      .pcr_xtrn ex03,offsetc,5
      .list
	ex	a,[ex03]		;FD ED 07p00q00
      .nlist
    .else
      .pcr_lclx ex01,5
      .list
	ex	a,offsetc+ex01(pc)	;FD ED 07p55q00
      .nlist
      .pcr_lclx ex02,5
      .list
	ex	a,(pc+offsetc+ex02)	;FD ED 07p55q00
      .nlist
      .pcr_lclx ex03,5
      .list
	ex	a,[offsetc+ex03]	;FD ED 07p55q00
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn ex01,offsetc,5
      .list
	ex	a,ex01(pc)		;FD ED 07 55 00
      .nlist
      .pcr_xtrn ex02,offsetc,5
      .list
	ex	a,(pc+ex02)		;FD ED 07 55 00
      .nlist
      .pcr_xtrn ex03,offsetc,5
      .list
	ex	a,[ex03]		;FD ED 07 55 00
      .nlist
    .else
      .pcr_lclx ex01,5
      .list
	ex	a,offsetc+ex01(pc)	;FD ED 07 55 00
      .nlist
      .pcr_lclx ex02,5
      .list
	ex	a,(pc+offsetc+ex02)	;FD ED 07 55 00
      .nlist
      .pcr_lclx ex03,5
      .list
	ex	a,[offsetc+ex03]	;FD ED 07 55 00
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	ex	a,offset(pc)		;FD ED 07p55q00
	ex	a,(pc+offset)		;FD ED 07p55q00
	ex	a,[offset]		;FD ED 07p55q00
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst offsetc,5
      .list
	ex	a,pcr_ofst(pc)		;FD ED 07 55 00
      .nlist
	.pcr_ofst offsetc,5
      .list
	ex	a,(pc+pcr_ofst)		;FD ED 07 55 00
      .nlist
	.pcr_ofst offsetc,5
      .list
	ex	a,[pcr_ofst]		;FD ED 07 55 00
    .nlist
  .endif
.list  ; end<--
	ex	a,[.-lxofc]		;FD ED 07 D9 EE
	ex	a,(hl+ix)		;DD ED 0F
	ex	a,(hl+iy)		;DD ED 17
	ex	a,(ix+iy)		;DD ED 1F

;*******************************************************************
;	EXTS	
;*******************************************************************
	;***********************************************************
	;  extend sign  a->hl,   hl->dehl
	;  pp. 5-50, 5-51
	exts				;ED 64
	exts	a			;ED 64
	exts	hl			;ED 6C

;*******************************************************************
;	EXX	
;*******************************************************************
	;***********************************************************
	; exchange:
	;	bc <-> bc'
	;	de <-> de'
	;	hl <-> hl'
	.z80
	exx				;D9

;*******************************************************************
;	HALT	
;*******************************************************************
	;***********************************************************
	; halt (wait for interrupt or reset)
	.z80
	halt				;76

;*******************************************************************
;	IM	
;*******************************************************************
	;***********************************************************
	; set interrupt mode
	.z80
	im	0			;ED 46
	im	1			;ED 56
	im	2			;ED 5E
	.z280p
	im	3			;ED 4E

;*******************************************************************
;	IN and INW	
;*******************************************************************
	;***********************************************************
	; load 'a' with input from device n
	.z80
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	in	a,(n)			;DBr00
      .nlist
    .else
      .list
	in	a,(n)			;DBr20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	in	a,(n)			;DB 20
    .nlist
  .endif
.list  ; end<--
	in	a,0x33			;DB 33
	;***********************************************************
	; load register with input from (c)
	in	a,(c)			;ED 78
	in	b,(c)			;ED 40
	in	c,(c)			;ED 48
	in	d,(c)			;ED 50
	in	e,(c)			;ED 58
	in	h,(c)			;ED 60
	in	l,(c)			;ED 68
	;***********************************************************
	;  p. 5-55
	.z280
	in	ixh,(c)			;DD ED 60
	in	ixl,(c)			;DD ED 68
	in	iyh,(c)			;FD ED 60
	in	iyl,(c)			;FD ED 68
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	in	(daddr),(c)		;DD ED 78r00s00
	in	offset(ix),(c)		;FD ED 48r00s00
	in	(ix+offset),(c)		;FD ED 48r00s00
	in	offset(iy),(c)		;FD ED 50r00s00
	in	(iy+offset),(c)		;FD ED 50r00s00
	in	offset(hl),(c)		;FD ED 58r00s00
	in	(hl+offset),(c)		;FD ED 58r00s00
	in	offset(sp),(c)		;DD ED 40r00s00
	in	(sp+offset),(c)		;DD ED 40r00s00
	in	lxoff(ix),(c)		;FD ED 48r00s00
	in	(ix+lxoff),(c)		;FD ED 48r00s00
	in	lxoff(iy),(c)		;FD ED 50r00s00
	in	(iy+lxoff),(c)		;FD ED 50r00s00
	in	lxoff(hl),(c)		;FD ED 58r00s00
	in	(hl+lxoff),(c)		;FD ED 58r00s00
	in	lxoff(sp),(c)		;DD ED 40r00s00
	in	(sp+lxoff),(c)		;DD ED 40r00s00
      .nlist
    .else
      .list
	in	(daddr),(c)		;DD ED 78r44s33
	in	offset(ix),(c)		;FD ED 48r55s00
	in	(ix+offset),(c)		;FD ED 48r55s00
	in	offset(iy),(c)		;FD ED 50r55s00
	in	(iy+offset),(c)		;FD ED 50r55s00
	in	offset(hl),(c)		;FD ED 58r55s00
	in	(hl+offset),(c)		;FD ED 58r55s00
	in	offset(sp),(c)		;DD ED 40r55s00
	in	(sp+offset),(c)		;DD ED 40r55s00
	in	lxoff(ix),(c)		;FD ED 48r22s11
	in	(ix+lxoff),(c)		;FD ED 48r22s11
	in	lxoff(iy),(c)		;FD ED 50r22s11
	in	(iy+lxoff),(c)		;FD ED 50r22s11
	in	lxoff(hl),(c)		;FD ED 58r22s11
	in	(hl+lxoff),(c)		;FD ED 58r22s11
	in	lxoff(sp),(c)		;DD ED 40r22s11
	in	(sp+lxoff),(c)		;DD ED 40r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	in	(daddr),(c)		;DD ED 78 44 33
	in	offset(ix),(c)		;FD ED 48 55 00
	in	(ix+offset),(c)		;FD ED 48 55 00
	in	offset(iy),(c)		;FD ED 50 55 00
	in	(iy+offset),(c)		;FD ED 50 55 00
	in	offset(hl),(c)		;FD ED 58 55 00
	in	(hl+offset),(c)		;FD ED 58 55 00
	in	offset(sp),(c)		;DD ED 40 55 00
	in	(sp+offset),(c)		;DD ED 40 55 00
	in	lxoff(ix),(c)		;FD ED 48 22 11
	in	(ix+lxoff),(c)		;FD ED 48 22 11
	in	lxoff(iy),(c)		;FD ED 50 22 11
	in	(iy+lxoff),(c)		;FD ED 50 22 11
	in	lxoff(hl),(c)		;FD ED 58 22 11
	in	(hl+lxoff),(c)		;FD ED 58 22 11
	in	lxoff(sp),(c)		;DD ED 40 22 11
	in	(sp+lxoff),(c)		;DD ED 40 22 11
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn in01,offsetc,5
      .list
	in	in01(pc),(c)		;FD ED 40p00q00
      .nlist
      .pcr_xtrn in02,offsetc,5
      .list
	in	(pc+in02),(c)		;FD ED 40p00q00
      .nlist
      .pcr_xtrn in03,offsetc,5
      .list
	in	[in03],(c)		;FD ED 40p00q00
      .nlist
    .else
      .pcr_lclx in01,5
      .list
	in	offsetc+in01(pc),(c)	;FD ED 40p55q00
      .nlist
      .pcr_lclx in02,5
      .list
	in	(pc+offsetc+in02),(c)	;FD ED 40p55q00
      .nlist
      .pcr_lclx in03,5
      .list
	in	[offsetc+in03],(c)	;FD ED 40p55q00
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn in01,offsetc,5
      .list
	in	in01(pc),(c)		;FD ED 40 55 00
      .nlist
      .pcr_xtrn in02,offsetc,5
      .list
	in	(pc+in02),(c)		;FD ED 40 55 00
      .nlist
      .pcr_xtrn in03,offsetc,5
      .list
	in	[in03],(c)		;FD ED 40 55 00
      .nlist
    .else
      .pcr_lclx in01,5
      .list
	in	offsetc+in01(pc),(c)	;FD ED 40 55 00
      .nlist
      .pcr_lclx in02,5
      .list
	in	(pc+offsetc+in02),(c)	;FD ED 40 55 00
      .nlist
      .pcr_lclx in03,5
      .list
	in	[offsetc+in03],(c)	;FD ED 40 55 00
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	in	offset(pc),(c)		;FD ED 40p55q00
	in	(pc+offset),(c)		;FD ED 40p55q00
	in	[offset],(c)		;FD ED 40p55q00
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst offsetc,5
      .list
	in	pcr_ofst(pc),(c)	;FD ED 40 55 00
      .nlist
	.pcr_ofst offsetc,5
      .list
	in	(pc+pcr_ofst),(c)	;FD ED 40 55 00
      .nlist
	.pcr_ofst offsetc,5
      .list
	in	[pcr_ofst],(c)		;FD ED 40 55 00
    .nlist
  .endif
.list  ; end<--
	in	[.+offsetc],(c)		;FD ED 40 50 00
	in	(ix+hl),(c)		;DD ED 48
	in	(hl+iy),(c)		;DD ED 50
	in	(iy+ix),(c)		;DD ED 58
	;***********************************************************
	;  p. 5-65
	in	hl,(c)			;ED B7
	inw	hl,(c)			;ED B7

;*******************************************************************
;	INC	
;		If offset is ommitted 0 is assumed.
;*******************************************************************
	;***********************************************************
	; increment operand
	.z80
	inc	(hl)			;34
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	inc	offset(ix)		;DD 34r00
	inc	(ix+offset)		;DD 34r00
	inc	offset(iy)		;FD 34r00
	inc	(iy+offset)		;FD 34r00
      .nlist
    .else
      .list
	inc	offset(ix)		;DD 34r55
	inc	(ix+offset)		;DD 34r55
	inc	offset(iy)		;FD 34r55
	inc	(iy+offset)		;FD 34r55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	inc	offset(ix)		;DD 34 55
	inc	(ix+offset)		;DD 34 55
	inc	offset(iy)		;FD 34 55
	inc	(iy+offset)		;FD 34 55
    .nlist
  .endif
.list  ; end<--
	inc	a			;3C
	inc	b			;04
	inc	bc			;03
	inc	c			;0C
	inc	d			;14
	inc	de			;13
	inc	e			;1C
	inc	h			;24
	inc	hl			;23
	inc	ix			;DD 23
	inc	iy			;FD 23
	inc	l			;2C
	inc	sp			;33

	incw	bc			;03
	incw	de			;13
	incw	hl			;23
	incw	sp			;33

	;***********************************************************
	; increment operand
	;  p. 5-57
	.z280
	inc	ixh			;DD 24
	inc	ixl			;DD 2C
	inc	iyh			;FD 24
	inc 	iyl			;FD 2C
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	inc	(daddr)			;DD 3Cr00s00
	inc	offset(ix)		;FD 0Cr00s00
	inc	(ix+offset)		;FD 0Cr00s00
	inc	offset(iy)		;FD 14r00s00
	inc	(iy+offset)		;FD 14r00s00
	inc	offset(hl)		;FD 1Cr00s00
	inc	(hl+offset)		;FD 1Cr00s00
	inc	offset(sp)		;DD 04r00s00
	inc	(sp+offset)		;DD 04r00s00
	inc	lxoff(ix)		;FD 0Cr00s00
	inc	(ix+lxoff)		;FD 0Cr00s00
	inc	lxoff(iy)		;FD 14r00s00
	inc	(iy+lxoff)		;FD 14r00s00
	inc	lxoff(hl)		;FD 1Cr00s00
	inc	(hl+lxoff)		;FD 1Cr00s00
	inc	lxoff(sp)		;DD 04r00s00
	inc	(sp+lxoff)		;DD 04r00s00
      .nlist
    .else
      .list
	inc	(daddr)			;DD 3Cr44s33
	inc	offset(ix)		;FD 0Cr55s00
	inc	(ix+offset)		;FD 0Cr55s00
	inc	offset(iy)		;FD 14r55s00
	inc	(iy+offset)		;FD 14r55s00
	inc	offset(hl)		;FD 1Cr55s00
	inc	(hl+offset)		;FD 1Cr55s00
	inc	offset(sp)		;DD 04r55s00
	inc	(sp+offset)		;DD 04r55s00
	inc	lxoff(ix)		;FD 0Cr22s11
	inc	(ix+lxoff)		;FD 0Cr22s11
	inc	lxoff(iy)		;FD 14r22s11
	inc	(iy+lxoff)		;FD 14r22s11
	inc	lxoff(hl)		;FD 1Cr22s11
	inc	(hl+lxoff)		;FD 1Cr22s11
	inc	lxoff(sp)		;DD 04r22s11
	inc	(sp+lxoff)		;DD 04r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	inc	(daddr)			;DD 3C 44 33
    .nlist
    .ifeq _X_R
      .list
	inc	offset(ix)		;FD 0C 55 00
	inc	(ix+offset)		;FD 0C 55 00
	inc	offset(iy)		;FD 14 55 00
	inc	(iy+offset)		;FD 14 55 00
      .nlist
    .else
      .list
	inc	offset(ix)		;DD 34 55
	inc	(ix+offset)		;DD 34 55
	inc	offset(iy)		;FD 34 55
	inc	(iy+offset)		;FD 34 55
      .nlist
    .endif
    .list
	inc	offset(hl)		;FD 1C 55 00
	inc	(hl+offset)		;FD 1C 55 00
	inc	offset(sp)		;DD 04 55 00
	inc	(sp+offset)		;DD 04 55 00
	inc	lxoff(ix)		;FD 0C 22 11
	inc	(ix+lxoff)		;FD 0C 22 11
	inc	lxoff(iy)		;FD 14 22 11
	inc	(iy+lxoff)		;FD 14 22 11
	inc	lxoff(hl)		;FD 1C 22 11
	inc	(hl+lxoff)		;FD 1C 22 11
	inc	lxoff(sp)		;DD 04 22 11
	inc	(sp+lxoff)		;DD 04 22 11
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn inc01,offsetc
      .list
	inc	inc01(pc)		;FD 04p00q00
      .nlist
      .pcr_xtrn inc02,offsetc
      .list
	inc	(pc+inc02)		;FD 04p00q00
      .nlist
      .pcr_xtrn inc03,offsetc
      .list
	inc	[inc03]			;FD 04p00q00
      .nlist
    .else
      .pcr_lclx inc01
      .list
	inc	offsetc+inc01(pc)	;FD 04p55q00
      .nlist
      .pcr_lclx inc02
      .list
	inc	(pc+offsetc+inc02)	;FD 04p55q00
      .nlist
      .pcr_lclx inc03
      .list
	inc	[offsetc+inc03]		;FD 04p55q00
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn inc01,offsetc
      .list
	inc	inc01(pc)		;FD 04 55 00
      .nlist
      .pcr_xtrn inc02,offsetc
      .list
	inc	(pc+inc02)		;FD 04 55 00
      .nlist
      .pcr_xtrn inc03,offsetc
      .list
	inc	[inc03]			;FD 04 55 00
      .nlist
    .else
      .pcr_lclx inc01
      .list
	inc	offsetc+inc01(pc)	;FD 04 55 00
      .nlist
      .pcr_lclx inc02
      .list
	inc	(pc+offsetc+inc02)	;FD 04 55 00
      .nlist
      .pcr_lclx inc03
      .list
	inc	[offsetc+inc03]		;FD 04 55 00
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	inc	offset(pc)		;FD 04p55q00
	inc	(pc+offset)		;FD 04p55q00
	inc	[offset]		;FD 04p55q00
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst offsetc
      .list
	inc	pcr_ofst(pc)		;FD 04 55 00
      .nlist
	.pcr_ofst offsetc
      .list
	inc	(pc+pcr_ofst)		;FD 04 55 00
      .nlist
	.pcr_ofst offsetc
      .list
	inc	[pcr_ofst]		;FD 04 55 00
    .nlist
  .endif
.list  ; end<--
	inc	[.+offsetc]		;FD 04 51 00
	inc	(hl+ix)			;DD 0C
	inc	(hl+iy)			;DD 14
	inc	(ix+iy)			;DD 1C

;*******************************************************************
;	INCW	
;		If offset is ommitted 0 is assumed.
;*******************************************************************
	;***********************************************************
	; increment word operand
	incw	bc			;03
	incw	de			;13
	incw	hl			;23
	incw	sp			;33
	incw	ix			;DD 23
	incw	iy			;FD 23

	incw	(hl)			;DD 03
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	incw	(daddr)			;DD 13r00s00
	incw	offset(ix)		;FD 03r00s00
	incw	(ix+offset)		;FD 03r00s00
	incw	lxoff(iy)		;FD 13r00s00
	incw	(iy+lxoff)		;FD 13r00s00
      .nlist
    .else
      .list
	incw	(daddr)			;DD 13r44s33
	incw	offset(ix)		;FD 03r55s00
	incw	(ix+offset)		;FD 03r55s00
	incw	lxoff(iy)		;FD 13r22s11
	incw	(iy+lxoff)		;FD 13r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	incw	(daddr)			;DD 13 44 33
	incw	offset(ix)		;FD 03 55 00
	incw	(ix+offset)		;FD 03 55 00
	incw	lxoff(iy)		;FD 13 22 11
	incw	(iy+lxoff)		;FD 13 22 11
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn incw01,raofc
      .list
	incw	incw01(pc)		;DD 33p00q00
      .nlist
      .pcr_xtrn incw02,raofc
      .list
	incw	(pc+incw02)		;DD 33p00q00
      .nlist
      .pcr_xtrn incw03,raofc
      .list
	incw	[incw03]		;DD 33p00q00
      .nlist
    .else
      .pcr_lclx incw01
      .list
	incw	raofc+incw01(pc)	;DD 33p34q12
      .nlist
      .pcr_lclx incw02
      .list
	incw	(pc+raofc+incw02)	;DD 33p34q12
      .nlist
      .pcr_lclx incw03
      .list
	incw	[raofc+incw03]		;DD 33p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn incw01,raofc
      .list
	incw	incw01(pc)		;DD 33 34 12
      .nlist
      .pcr_xtrn incw02,raofc
      .list
	incw	(pc+incw02)		;DD 33 34 12
      .nlist
      .pcr_xtrn incw03,raofc
      .list
	incw	[incw03]		;DD 33 34 12
      .nlist
    .else
      .pcr_lclx incw01
      .list
	incw	raofc+incw01(pc)	;DD 33 34 12
      .nlist
      .pcr_lclx incw02
      .list
	incw	(pc+raofc+incw02)	;DD 33 34 12
      .nlist
      .pcr_lclx incw03
      .list
	incw	[raofc+incw03]		;DD 33 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	incw	raoff(pc)		;DD 33p34q12
	incw	(pc+raoff)		;DD 33p34q12
	incw	[raoff]			;DD 33p34q12
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	incw	pcr_ofst(pc)		;DD 33 34 12
      .nlist
	.pcr_ofst raofc
      .list
	incw	(pc+pcr_ofst)		;DD 33 34 12
      .nlist
	.pcr_ofst raofc
      .list
	incw	[pcr_ofst]		;DD 33 34 12
    .nlist
  .endif
.list  ; end<--
	incw	[.+raofc]		;DD 33 30 12

;*******************************************************************
;	IND	
;*******************************************************************
	;***********************************************************
	; load location (hl) with input
	; from port (c)
	; decrement 'hl' and 'b'
	.z80
	ind				;ED AA

;*******************************************************************
;	INDR	
;*******************************************************************
	;***********************************************************
	; load location (hl) with input
	; from port (c)
	; decrement 'hl' and 'b'
	; repeat until 'b' = 0
	.z80
	indr				;ED BA

;*******************************************************************
;	INI	
;*******************************************************************
	;***********************************************************
	; load location (hl) with input
	; from port (c)
	; increment 'hl' and decrement 'b'
	.z80
	ini				;ED A2

;*******************************************************************
;	INIR	
;*******************************************************************
	;***********************************************************
	; load location (hl) with input
	; from port (c)
	; increment 'hl' and decrement 'b'
	; repeat until 'b' = 0
	.z80
	inir				;ED B2

;*******************************************************************
;	INDW, INDR, INIW, and INIRW	
;*******************************************************************
	;***********************************************************
	.z280
jmp1:	indw				;ED 8A
	indrw				;ED 9A
	iniw				;ED 82
	inirw				;ED 92

;*******************************************************************
;	JAF	
;*******************************************************************
	;***********************************************************
 	; jump on auxiliary accumulator/flag (AF)
	;  p. 5-66
	jaf	jmp1			;DD 28 F5

;*******************************************************************
;	JAR	
;*******************************************************************
	;***********************************************************
	; jump on auxiliary register set
	;  p. 5-67
	.z280
	jar	jmp1			;DD 20 F2

;*******************************************************************
;	JP	
;*******************************************************************
	;***********************************************************
	; unconditional jump to location nn
	.z80
	jp	(hl)			;E9
	jp	(ix)			;DD E9
	jp	(iy)			;FD E9
	;***********************************************************
	; jump to location if condition is true
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	jp	nn			;C3r00s00
	jp	C,nn			;DAr00s00
	jp	M,nn			;FAr00s00
	jp	NC,nn			;D2r00s00
	jp	NZ,nn			;C2r00s00
	jp	P,nn			;F2r00s00
	jp	PE,nn			;EAr00s00
	jp	PO,nn			;E2r00s00
	jp	Z,nn			;CAr00s00
      .nlist
    .else
      .list
	jp	nn			;C3r84s05
	jp	C,nn			;DAr84s05
	jp	M,nn			;FAr84s05
	jp	NC,nn			;D2r84s05
	jp	NZ,nn			;C2r84s05
	jp	P,nn			;F2r84s05
	jp	PE,nn			;EAr84s05
	jp	PO,nn			;E2r84s05
	jp	Z,nn			;CAr84s05
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	jp	nn			;C3 84 05
	jp	C,nn			;DA 84 05
	jp	M,nn			;FA 84 05
	jp	NC,nn			;D2 84 05
	jp	NZ,nn			;C2 84 05
	jp	P,nn			;F2 84 05
	jp	PE,nn			;EA 84 05
	jp	PO,nn			;E2 84 05
	jp	Z,nn			;CA 84 05
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	;  p. 5-68
	.z280
	jp	nz,(hl)			;DD C2
	jp	z,(hl)			;DD CA
	jp	nc,(hl)			;DD D2
	jp	c,(hl)			;DD DA
	jp	nv,(hl)			;DD E2
	jp	v,(hl)			;DD EA
	jp	ns,(hl)			;DD F2
	jp	s,(hl)			;DD FA
	jp	po,(hl)			;DD E2
	jp	pe,(hl)			;DD EA
	jp	p,(hl)			;DD F2
	jp	m,(hl)			;DD FA
	; long relative jumps
	jp	[jmp1]			;FD C3 B6 FF
	jp	nz,[jmp1]		;FD C2 B2 FF
	jp	z,[jmp1]		;FD CA AE FF
	jp	p,[jmp1]		;FD F2 AA FF
	jp	m,[jmp1]		;FD FA A6 FF
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn jp01,offsetc
      .list
	jp	jp01(pc)		;FD C3p00q00
      .nlist
      .pcr_xtrn jp02,offsetc
      .list
	jp	(pc+jp02)		;FD C3p00q00
      .nlist
      .pcr_xtrn jp03,offsetc
      .list
	jp	[jp03]			;FD C3p00q00
      .nlist
    .else
      .pcr_lclx jp01
      .list
	jp	offsetc+jp01(pc)	;FD C3p55q00
      .nlist
      .pcr_lclx jp02
      .list
	jp	(pc+offsetc+jp02)	;FD C3p55q00
      .nlist
      .pcr_lclx jp03
      .list
	jp	[offsetc+jp03]		;FD C3p55q00
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn jp01,offsetc
      .list
	jp	jp01(pc)		;FD C3 55 00
      .nlist
      .pcr_xtrn jp02,offsetc
      .list
	jp	(pc+jp02)		;FD C3 55 00
      .nlist
      .pcr_xtrn jp03,offsetc
      .list
	jp	[jp03]			;FD C3 55 00
      .nlist
    .else
      .pcr_lclx jp01
      .list
	jp	offsetc+jp01(pc)	;FD C3 55 00
      .nlist
      .pcr_lclx jp02
      .list
	jp	(pc+offsetc+jp02)	;FD C3 55 00
      .nlist
      .pcr_lclx jp03
      .list
	jp	[offsetc+jp03]		;FD C3 55 00
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	jp	offset(pc)		;FD C3p55q00
	jp	(pc+offset)		;FD C3p55q00
	jp	[offset]		;FD C3p55q00
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst offsetc
      .list
	jp	pcr_ofst(pc)		;FD C3 55 00
      .nlist
	.pcr_ofst offsetc
      .list
	jp	(pc+pcr_ofst)		;FD C3 55 00
      .nlist
	.pcr_ofst offsetc
      .list
	jp	[pcr_ofst]		;FD C3 55 00
    .nlist
  .endif
.list  ; end<--
	jp	[.+offsetc]		;FD C3 51 00

;*******************************************************************
;	JR	
;*******************************************************************
	;***********************************************************
	; unconditional jump relative to PC+e
	jr	ljr1+0x10		;18 10
	.z80
	;***********************************************************
	; jump relative to PC+e if condition is true
ljr1:	jr	C,1$+0x10		;38 10
1$:	jr	NC,2$+0x10		;30 10
2$:	jr	NZ,3$+0x10		;20 10
3$:	jr	Z,4$+0x10		;28 10
4$:	
ljr2:	jr	ljr1			;18 F6

.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .globl jr_1
    .globl jr_2
    .globl jr_3
    .globl jr_4
    .list
xjr_1::	jr	C, jr_1			;38p00
xjr_2::	jr	NC,jr_2			;30p00
xjr_3::	jr	NZ,jr_3			;20p00
xjr_4::	jr	Z, jr_4			;28p00
    .nlist
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .globl jr_1
    .globl jr_2
    .globl jr_3
    .globl jr_4
    .list
xjr_1::	jr	C, jr_1			;38 FE
xjr_2::	jr	NC,jr_2			;30 FE
xjr_3::	jr	NZ,jr_3			;20 FE
xjr_4::	jr	Z, jr_4			;28 FE
    .nlist
  .endif
  .ifeq C_LR				; (.con/.lst) or (.con/.rst)
    .list
jr1:	jr	C, jr1			;38 FE
jr2:	jr	NC,jr2			;30 FE
jr3:	jr	NZ,jr3			;20 FE
jr4:	jr	Z, jr4			;28 FE
    .nlist
  .endif
.list  ; end<--

;*******************************************************************
;	LD	
;		Leading 'a' operand is optional.
;		If offset is ommitted 0 is assumed.
;*******************************************************************
	;***********************************************************
	; load source to destination
	.z80
	ld	a,(hl)			;7E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	a,offset(ix)		;DD 7Er00
	ld	a,(ix+offset)		;DD 7Er00
	ld	a,offset(iy)		;FD 7Er00
	ld	a,(iy+offset)		;FD 7Er00
      .nlist
    .else
      .list
	ld	a,offset(ix)		;DD 7Er55
	ld	a,(ix+offset)		;DD 7Er55
	ld	a,offset(iy)		;FD 7Er55
	ld	a,(iy+offset)		;FD 7Er55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	a,offset(ix)		;DD 7E 55
	ld	a,(ix+offset)		;DD 7E 55
	ld	a,offset(iy)		;FD 7E 55
	ld	a,(iy+offset)		;FD 7E 55
    .nlist
  .endif
.list  ; end<--
	ld	a,a			;7F
	ld	a,b			;78
	ld	a,c			;79
	ld	a,d			;7A
	ld	a,e			;7B
	ld	a,h			;7C
	ld	a,l			;7D
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	a,#n			;3Er00
	ld	a, n			;3Er00
      .nlist
    .else
      .list
	ld	a,#n			;3Er20
	ld	a, n			;3Er20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	a,#n			;3E 20
	ld	a, n			;3E 20
    .nlist
  .endif
.list  ; end<--
	ld	b,(hl)			;46
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	b,offset(ix)		;DD 46r00
	ld	b,(ix+offset)		;DD 46r00
	ld	b,offset(iy)		;FD 46r00
	ld	b,(iy+offset)		;FD 46r00
      .nlist
    .else
      .list
	ld	b,offset(ix)		;DD 46r55
	ld	b,(ix+offset)		;DD 46r55
	ld	b,offset(iy)		;FD 46r55
	ld	b,(iy+offset)		;FD 46r55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	b,offset(ix)		;DD 46 55
	ld	b,(ix+offset)		;DD 46 55
	ld	b,offset(iy)		;FD 46 55
	ld	b,(iy+offset)		;FD 46 55
    .nlist
  .endif
.list  ; end<--
	ld	b,a			;47
	ld	b,b			;40
	ld	b,c			;41
	ld	b,d			;42
	ld	b,e			;43
	ld	b,h			;44
	ld	b,l			;45
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	b,#n			;06r00
	ld	b, n			;06r00
      .nlist
    .else
      .list
	ld	b,#n			;06r20
	ld	b, n			;06r20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	b,#n			;06 20
	ld	b, n			;06 20
    .nlist
  .endif
.list  ; end<--
	ld	c,(hl)			;4E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	c,offset(ix)		;DD 4Er00
	ld	c,(ix+offset)		;DD 4Er00
	ld	c,offset(iy)		;FD 4Er00
	ld	c,(iy+offset)		;FD 4Er00
      .nlist
    .else
      .list
	ld	c,offset(ix)		;DD 4Er55
	ld	c,(ix+offset)		;DD 4Er55
	ld	c,offset(iy)		;FD 4Er55
	ld	c,(iy+offset)		;FD 4Er55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	c,offset(ix)		;DD 4E 55
	ld	c,(ix+offset)		;DD 4E 55
	ld	c,offset(iy)		;FD 4E 55
	ld	c,(iy+offset)		;FD 4E 55
    .nlist
  .endif
.list  ; end<--
	ld	c,a			;4F
	ld	c,b			;48
	ld	c,c			;49
	ld	c,d			;4A
	ld	c,e			;4B
	ld	c,h			;4C
	ld	c,l			;4D
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	c,#n			;0Er00
	ld	c, n			;0Er00
      .nlist
    .else
      .list
	ld	c,#n			;0Er20
	ld	c, n			;0Er20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	c,#n			;0E 20
	ld	c, n			;0E 20
    .nlist
  .endif
.list  ; end<--
	ld	d,(hl)			;56
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	d,offset(ix)		;DD 56r00
	ld	d,(ix+offset)		;DD 56r00
	ld	d,offset(iy)		;FD 56r00
	ld	d,(iy+offset)		;FD 56r00
      .nlist
    .else
      .list
	ld	d,offset(ix)		;DD 56r55
	ld	d,(ix+offset)		;DD 56r55
	ld	d,offset(iy)		;FD 56r55
	ld	d,(iy+offset)		;FD 56r55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	d,offset(ix)		;DD 56 55
	ld	d,(ix+offset)		;DD 56 55
	ld	d,offset(iy)		;FD 56 55
	ld	d,(iy+offset)		;FD 56 55
    .nlist
  .endif
.list  ; end<--
	ld	d,a			;57
	ld	d,b			;50
	ld	d,c			;51
	ld	d,d			;52
	ld	d,e			;53
	ld	d,h			;54
	ld	d,l			;55
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	d,#n			;16r00
	ld	d, n			;16r00
      .nlist
    .else
      .list
	ld	d,#n			;16r20
	ld	d, n			;16r20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	d,#n			;16 20
	ld	d, n			;16 20
    .nlist
  .endif
.list  ; end<--
	ld	e,(hl)			;5E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	e,offset(ix)		;DD 5Er00
	ld	e,(ix+offset)		;DD 5Er00
	ld	e,offset(iy)		;FD 5Er00
	ld	e,(iy+offset)		;FD 5Er00
      .nlist
    .else
      .list
	ld	e,offset(ix)		;DD 5Er55
	ld	e,(ix+offset)		;DD 5Er55
	ld	e,offset(iy)		;FD 5Er55
	ld	e,(iy+offset)		;FD 5Er55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	e,offset(ix)		;DD 5E 55
	ld	e,(ix+offset)		;DD 5E 55
	ld	e,offset(iy)		;FD 5E 55
	ld	e,(iy+offset)		;FD 5E 55
    .nlist
  .endif
.list  ; end<--
	ld	e,a			;5F
	ld	e,b			;58
	ld	e,c			;59
	ld	e,d			;5A
	ld	e,e			;5B
	ld	e,h			;5C
	ld	e,l			;5D
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	e,#n			;1Er00
	ld	e, n			;1Er00
      .nlist
    .else
      .list
	ld	e,#n			;1Er20
	ld	e, n			;1Er20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	e,#n			;1E 20
	ld	e, n			;1E 20
    .nlist
  .endif
.list  ; end<--
	ld	h,(hl)			;66
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	h,offset(ix)		;DD 66r00
	ld	h,(ix+offset)		;DD 66r00
	ld	h,offset(iy)		;FD 66r00
	ld	h,(iy+offset)		;FD 66r00
      .nlist
    .else
      .list
	ld	h,offset(ix)		;DD 66r55
	ld	h,(ix+offset)		;DD 66r55
	ld	h,offset(iy)		;FD 66r55
	ld	h,(iy+offset)		;FD 66r55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	h,offset(ix)		;DD 66 55
	ld	h,(ix+offset)		;DD 66 55
	ld	h,offset(iy)		;FD 66 55
	ld	h,(iy+offset)		;FD 66 55
    .nlist
  .endif
.list  ; end<--
	ld	h,a			;67
	ld	h,b			;60
	ld	h,c			;61
	ld	h,d			;62
	ld	h,e			;63
	ld	h,h			;64
	ld	h,l			;65
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	h,#n			;26r00
	ld	h, n			;26r00
      .nlist
    .else
      .list
	ld	h,#n			;26r20
	ld	h, n			;26r20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	h,#n			;26 20
	ld	h, n			;26 20
    .nlist
  .endif
.list  ; end<--
	ld	l,(hl)			;6E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	l,offset(ix)		;DD 6Er00
	ld	l,(ix+offset)		;DD 6Er00
	ld	l,offset(iy)		;FD 6Er00
	ld	l,(iy+offset)		;FD 6Er00
      .nlist
    .else
      .list
	ld	l,offset(ix)		;DD 6Er55
	ld	l,(ix+offset)		;DD 6Er55
	ld	l,offset(iy)		;FD 6Er55
	ld	l,(iy+offset)		;FD 6Er55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	l,offset(ix)		;DD 6E 55
	ld	l,(ix+offset)		;DD 6E 55
	ld	l,offset(iy)		;FD 6E 55
	ld	l,(iy+offset)		;FD 6E 55
    .nlist
  .endif
.list  ; end<--
	ld	l,a			;6F
	ld	l,b			;68
	ld	l,c			;69
	ld	l,d			;6A
	ld	l,e			;6B
	ld	l,h			;6C
	ld	l,l			;6D
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	l,#n			;2Er00
	ld	l, n			;2Er00
      .nlist
    .else
      .list
	ld	l,#n			;2Er20
	ld	l, n			;2Er20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	l,#n			;2E 20
	ld	l, n			;2E 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	ld	i,a			;ED 47
	ld	r,a			;ED 4F
	ld	a,i			;ED 57
	ld	a,r			;ED 5F
	;***********************************************************
	ld	(bc),a			;02
	ld	(de),a			;12
	ld	a,(bc)			;0A
	ld	a,(de)			;1A
	;***********************************************************
	ld	(hl),a			;77
	ld	(hl),b			;70
	ld	(hl),c			;71
	ld	(hl),d			;72
	ld	(hl),e			;73
	ld	(hl),h			;74
	ld	(hl),l			;75
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	(hl),#n			;36r00
	ld	(hl), n			;36r00
      .nlist
    .else
      .list
	ld	(hl),#n			;36r20
	ld	(hl), n			;36r20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	(hl),#n			;36 20
	ld	(hl), n			;36 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	offset(ix),a		;DD 77r00
	ld	offset(ix),b		;DD 70r00
	ld	offset(ix),c		;DD 71r00
	ld	offset(ix),d		;DD 72r00
	ld	offset(ix),e		;DD 73r00
	ld	offset(ix),h		;DD 74r00
	ld	offset(ix),l		;DD 75r00
	ld	offset(ix),#n		;DD 36r00r00
	ld	offset(ix), n		;DD 36r00r00
	;***********************************************************
	ld	(ix+offset),a		;DD 77r00
	ld	(ix+offset),b		;DD 70r00
	ld	(ix+offset),c		;DD 71r00
	ld	(ix+offset),d		;DD 72r00
	ld	(ix+offset),e		;DD 73r00
	ld	(ix+offset),h		;DD 74r00
	ld	(ix+offset),l		;DD 75r00
	ld	(ix+offset),#n		;DD 36r00r00
	ld	(ix+offset), n		;DD 36r00r00
	;***********************************************************
	ld	offset(iy),a		;FD 77r00
	ld	offset(iy),b		;FD 70r00
	ld	offset(iy),c		;FD 71r00
	ld	offset(iy),d		;FD 72r00
	ld	offset(iy),e		;FD 73r00
	ld	offset(iy),h		;FD 74r00
	ld	offset(iy),l		;FD 75r00
	ld	offset(iy),#n		;FD 36r00r00
	ld	offset(iy), n		;FD 36r00r00
	;***********************************************************
	ld	(iy+offset),a		;FD 77r00
	ld	(iy+offset),b		;FD 70r00
	ld	(iy+offset),c		;FD 71r00
	ld	(iy+offset),d		;FD 72r00
	ld	(iy+offset),e		;FD 73r00
	ld	(iy+offset),h		;FD 74r00
	ld	(iy+offset),l		;FD 75r00
	ld	(iy+offset),#n		;FD 36r00r00
	ld	(iy+offset), n		;FD 36r00r00
	;***********************************************************
	ld	(nn),a			;32r00s00
	ld	(nn),bc			;ED 43r00s00
	ld	(nn),de			;ED 53r00s00
	ld	(nn),hl			;22r00s00
	ld	(nn),sp			;ED 73r00s00
	ld	(nn),ix			;DD 22r00s00
	ld	(nn),iy			;FD 22r00s00
	;***********************************************************
	ld	a,(nn)			;3Ar00s00
	ld	bc,(nn)			;ED 4Br00s00
	ld	de,(nn)			;ED 5Br00s00
	ld	hl,(nn)			;2Ar00s00
	ld	sp,(nn)			;ED 7Br00s00
	ld	ix,(nn)			;DD 2Ar00s00
	ld	iy,(nn)			;FD 2Ar00s00
	;***********************************************************
	ld	bc,#n			;01r00s00
	ld	bc, n			;01r00s00
	ld	de,#n			;11r00s00
	ld	de, n			;11r00s00
	ld	hl,#n			;21r00s00
	ld	hl, n			;21r00s00
	ld	sp,#n			;31r00s00
	ld	sp, n			;31r00s00
	ld	ix,#n			;DD 21r00s00
	ld	ix, n			;DD 21r00s00
	ld	iy,#n			;FD 21r00s00
	ld	iy, n			;FD 21r00s00
	;***********************************************************
	ld	bc,#nn			;01r00s00
	ld	bc, nn			;01r00s00
	ld	de,#nn			;11r00s00
	ld	de, nn			;11r00s00
	ld	hl,#nn			;21r00s00
	ld	hl, nn			;21r00s00
	ld	sp,#nn			;31r00s00
	ld	sp, nn			;31r00s00
	ld	ix,#nn			;DD 21r00s00
	ld	ix, nn			;DD 21r00s00
	ld	iy,#nn			;FD 21r00s00
	ld	iy, nn			;FD 21r00s00
      .nlist
    .else
      .list
	ld	offset(ix),a		;DD 77r55
	ld	offset(ix),b		;DD 70r55
	ld	offset(ix),c		;DD 71r55
	ld	offset(ix),d		;DD 72r55
	ld	offset(ix),e		;DD 73r55
	ld	offset(ix),h		;DD 74r55
	ld	offset(ix),l		;DD 75r55
	ld	offset(ix),#n		;DD 36r55r20
	ld	offset(ix), n		;DD 36r55r20
	;***********************************************************
	ld	(ix+offset),a		;DD 77r55
	ld	(ix+offset),b		;DD 70r55
	ld	(ix+offset),c		;DD 71r55
	ld	(ix+offset),d		;DD 72r55
	ld	(ix+offset),e		;DD 73r55
	ld	(ix+offset),h		;DD 74r55
	ld	(ix+offset),l		;DD 75r55
	ld	(ix+offset),#n		;DD 36r55r20
	ld	(ix+offset), n		;DD 36r55r20
	;***********************************************************
	ld	offset(iy),a		;FD 77r55
	ld	offset(iy),b		;FD 70r55
	ld	offset(iy),c		;FD 71r55
	ld	offset(iy),d		;FD 72r55
	ld	offset(iy),e		;FD 73r55
	ld	offset(iy),h		;FD 74r55
	ld	offset(iy),l		;FD 75r55
	ld	offset(iy),#n		;FD 36r55r20
	ld	offset(iy), n		;FD 36r55r20
	;***********************************************************
	ld	(iy+offset),a		;FD 77r55
	ld	(iy+offset),b		;FD 70r55
	ld	(iy+offset),c		;FD 71r55
	ld	(iy+offset),d		;FD 72r55
	ld	(iy+offset),e		;FD 73r55
	ld	(iy+offset),h		;FD 74r55
	ld	(iy+offset),l		;FD 75r55
	ld	(iy+offset),#n		;FD 36r55r20
	ld	(iy+offset), n		;FD 36r55r20
	;***********************************************************
	ld	(nn),a			;32r84s05
	ld	(nn),bc			;ED 43r84s05
	ld	(nn),de			;ED 53r84s05
	ld	(nn),hl			;22r84s05
	ld	(nn),sp			;ED 73r84s05
	ld	(nn),ix			;DD 22r84s05
	ld	(nn),iy			;FD 22r84s05
	;***********************************************************
	ld	a,(nn)			;3Ar84s05
	ld	bc,(nn)			;ED 4Br84s05
	ld	de,(nn)			;ED 5Br84s05
	ld	hl,(nn)			;2Ar84s05
	ld	sp,(nn)			;ED 7Br84s05
	ld	ix,(nn)			;DD 2Ar84s05
	ld	iy,(nn)			;FD 2Ar84s05
	;***********************************************************
	ld	bc,#n			;01r20s00
	ld	bc, n			;01r20s00
	ld	de,#n			;11r20s00
	ld	de, n			;11r20s00
	ld	hl,#n			;21r20s00
	ld	hl, n			;21r20s00
	ld	sp,#n			;31r20s00
	ld	sp, n			;31r20s00
	ld	ix,#n			;DD 21r20s00
	ld	ix, n			;DD 21r20s00
	ld	iy,#n			;FD 21r20s00
	ld	iy, n			;FD 21r20s00
	;***********************************************************
	ld	bc,#nn			;01r84s05
	ld	bc, nn			;01r84s05
	ld	de,#nn			;11r84s05
	ld	de, nn			;11r84s05
	ld	hl,#nn			;21r84s05
	ld	hl, nn			;21r84s05
	ld	sp,#nn			;31r84s05
	ld	sp, nn			;31r84s05
	ld	ix,#nn			;DD 21r84s05
	ld	ix, nn			;DD 21r84s05
	ld	iy,#nn			;FD 21r84s05
	ld	iy, nn			;FD 21r84s05
      .nlist
    .endif
  .else					; (.ext/.rst) or (.con/.lst) or (.con/.rst)
    .list
	ld	offset(ix),a		;DD 77 55
	ld	offset(ix),b		;DD 70 55
	ld	offset(ix),c		;DD 71 55
	ld	offset(ix),d		;DD 72 55
	ld	offset(ix),e		;DD 73 55
	ld	offset(ix),h		;DD 74 55
	ld	offset(ix),l		;DD 75 55
	ld	offset(ix),#n		;DD 36 55 20
	ld	offset(ix), n		;DD 36 55 20
	;***********************************************************
	ld	(ix+offset),a		;DD 77 55
	ld	(ix+offset),b		;DD 70 55
	ld	(ix+offset),c		;DD 71 55
	ld	(ix+offset),d		;DD 72 55
	ld	(ix+offset),e		;DD 73 55
	ld	(ix+offset),h		;DD 74 55
	ld	(ix+offset),l		;DD 75 55
	ld	(ix+offset),#n		;DD 36 55 20
	ld	(ix+offset), n		;DD 36 55 20
	;***********************************************************
	ld	offset(iy),a		;FD 77 55
	ld	offset(iy),b		;FD 70 55
	ld	offset(iy),c		;FD 71 55
	ld	offset(iy),d		;FD 72 55
	ld	offset(iy),e		;FD 73 55
	ld	offset(iy),h		;FD 74 55
	ld	offset(iy),l		;FD 75 55
	ld	offset(iy),#n		;FD 36 55 20
	ld	offset(iy), n		;FD 36 55 20
	;***********************************************************
	ld	(iy+offset),a		;FD 77 55
	ld	(iy+offset),b		;FD 70 55
	ld	(iy+offset),c		;FD 71 55
	ld	(iy+offset),d		;FD 72 55
	ld	(iy+offset),e		;FD 73 55
	ld	(iy+offset),h		;FD 74 55
	ld	(iy+offset),l		;FD 75 55
	ld	(iy+offset),#n		;FD 36 55 20
	ld	(iy+offset), n		;FD 36 55 20
	;***********************************************************
	ld	(nn),a			;32 84 05
	ld	(nn),bc			;ED 43 84 05
	ld	(nn),de			;ED 53 84 05
	ld	(nn),hl			;22 84 05
	ld	(nn),sp			;ED 73 84 05
	ld	(nn),ix			;DD 22 84 05
	ld	(nn),iy			;FD 22 84 05
	;***********************************************************
	ld	a,(nn)			;3A 84 05
	ld	bc,(nn)			;ED 4B 84 05
	ld	de,(nn)			;ED 5B 84 05
	ld	hl,(nn)			;2A 84 05
	ld	sp,(nn)			;ED 7B 84 05
	ld	ix,(nn)			;DD 2A 84 05
	ld	iy,(nn)			;FD 2A 84 05
	;***********************************************************
	ld	bc,#n			;01 20 00
	ld	bc, n			;01 20 00
	ld	de,#n			;11 20 00
	ld	de, n			;11 20 00
	ld	hl,#n			;21 20 00
	ld	hl, n			;21 20 00
	ld	sp,#n			;31 20 00
	ld	sp, n			;31 20 00
	ld	ix,#n			;DD 21 20 00
	ld	ix, n			;DD 21 20 00
	ld	iy,#n			;FD 21 20 00
	ld	iy, n			;FD 21 20 00
	;***********************************************************
	ld	bc,#nn			;01 84 05
	ld	bc, nn			;01 84 05
	ld	de,#nn			;11 84 05
	ld	de, nn			;11 84 05
	ld	hl,#nn			;21 84 05
	ld	hl, nn			;21 84 05
	ld	sp,#nn			;31 84 05
	ld	sp, nn			;31 84 05
	ld	ix,#nn			;DD 21 84 05
	ld	ix, nn			;DD 21 84 05
	ld	iy,#nn			;FD 21 84 05
	ld	iy, nn			;FD 21 84 05
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	ld	sp,hl			;F9
	ld	sp,ix			;DD F9
	ld	sp,iy			;FD F9

	;***********************************************************
	; p. 5-70
	.z280
	ld	a,ixh			;DD 7C
	ld	a,ixl			;DD 7D
	ld	a,iyh			;FD 7C
	ld	a,iyl			;FD 7D
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
    	ld	a,#n			;3Er00
	ld	a,(daddr)		;3Ar00s00
	ld	a,offset(ix)		;FD 79r00s00
	ld	a,(ix+offset)		;FD 79r00s00
	ld	a,offset(iy)		;FD 7Ar00s00
	ld	a,(iy+offset)		;FD 7Ar00s00
	ld	a,offset(hl)		;FD 7Br00s00
	ld	a,(hl+offset)		;FD 7Br00s00
	ld	a,offset(sp)		;DD 78r00s00
	ld	a,(sp+offset)		;DD 78r00s00
	ld	a,lxoff(ix)		;FD 79r00s00
	ld	a,(ix+lxoff)		;FD 79r00s00
	ld	a,lxoff(iy)		;FD 7Ar00s00
	ld	a,(iy+lxoff)		;FD 7Ar00s00
	ld	a,lxoff(hl)		;FD 7Br00s00
	ld	a,(hl+lxoff)		;FD 7Br00s00
	ld	a,lxoff(sp)		;DD 78r00s00
	ld	a,(sp+lxoff)		;DD 78r00s00
      .nlist
    .else
      .list
    	ld	a,#n			;3Er20
	ld	a,(daddr)		;3Ar44s33
	ld	a,offset(ix)		;FD 79r55s00
	ld	a,(ix+offset)		;FD 79r55s00
	ld	a,offset(iy)		;FD 7Ar55s00
	ld	a,(iy+offset)		;FD 7Ar55s00
	ld	a,offset(hl)		;FD 7Br55s00
	ld	a,(hl+offset)		;FD 7Br55s00
	ld	a,offset(sp)		;DD 78r55s00
	ld	a,(sp+offset)		;DD 78r55s00
	ld	a,lxoff(ix)		;FD 79r22s11
	ld	a,(ix+lxoff)		;FD 79r22s11
	ld	a,lxoff(iy)		;FD 7Ar22s11
	ld	a,(iy+lxoff)		;FD 7Ar22s11
	ld	a,lxoff(hl)		;FD 7Br22s11
	ld	a,(hl+lxoff)		;FD 7Br22s11
	ld	a,lxoff(sp)		;DD 78r22s11
	ld	a,(sp+lxoff)		;DD 78r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
    	ld	a,#n			;3E 20
	ld	a,(daddr)		;3A 44 33
    .nlist
    .ifeq _X_R
      .list
	ld	a,offset(ix)		;FD 79 55 00
	ld	a,(ix+offset)		;FD 79 55 00
	ld	a,offset(iy)		;FD 7A 55 00
	ld	a,(iy+offset)		;FD 7A 55 00
      .nlist
    .else
      .list
	ld	a,offset(ix)		;DD 7E 55
	ld	a,(ix+offset)		;DD 7E 55
	ld	a,offset(iy)		;FD 7E 55
	ld	a,(iy+offset)		;FD 7E 55
      .nlist
    .endif
    .list
	ld	a,offset(hl)		;FD 7B 55 00
	ld	a,(hl+offset)		;FD 7B 55 00
	ld	a,offset(sp)		;DD 78 55 00
	ld	a,(sp+offset)		;DD 78 55 00
	ld	a,lxoff(ix)		;FD 79 22 11
	ld	a,(ix+lxoff)		;FD 79 22 11
	ld	a,lxoff(iy)		;FD 7A 22 11
	ld	a,(iy+lxoff)		;FD 7A 22 11
	ld	a,lxoff(hl)		;FD 7B 22 11
	ld	a,(hl+lxoff)		;FD 7B 22 11
	ld	a,lxoff(sp)		;DD 78 22 11
	ld	a,(sp+lxoff)		;DD 78 22 11
    .nlist
  .endif
.list  ; end<--
	ld	a,(ix)			;DD 7E 00
	ld	a,(iy)			;FD 7E 00
	ld	a,(hl)			;7E
;	ld	a,(hl)			;FD 7B 00 00
	ld	a,(sp)			;DD 78 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn ld01,lxofc
      .list
	ld	a,ld01(pc)		;FD 78p00q00
      .nlist
      .pcr_xtrn ld02,lxofc
      .list
	ld	a,(pc+ld02)		;FD 78p00q00
      .nlist
      .pcr_xtrn ld03,lxofc
      .list
	ld	a,[ld03]		;FD 78p00q00
      .nlist
    .else
      .pcr_lclx ld01
      .list
	ld	a,lxofc+ld01(pc)	;FD 78p22q11
      .nlist
      .pcr_lclx ld02
      .list
	ld	a,(pc+lxofc+ld02)	;FD 78p22q11
      .nlist
      .pcr_lclx ld03
      .list
	ld	a,[lxofc+ld03]		;FD 78p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn ld01,lxofc
      .list
	ld	a,ld01(pc)		;FD 78 22 11
      .nlist
      .pcr_xtrn ld02,lxofc
      .list
	ld	a,(pc+ld02)		;FD 78 22 11
      .nlist
      .pcr_xtrn ld03,lxofc
      .list
	ld	a,[ld03]		;FD 78 22 11
      .nlist
    .else
      .pcr_lclx ld01
      .list
	ld	a,lxofc+ld01(pc)	;FD 78 22 11
      .nlist
      .pcr_lclx ld02
      .list
	ld	a,(pc+lxofc+ld02)	;FD 78 22 11
      .nlist
      .pcr_lclx ld03
      .list
	ld	a,[lxofc+ld03]		;FD 78 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	ld	a,lxoff(pc)		;FD 78p22q11
	ld	a,(pc+lxoff)		;FD 78p22q11
	ld	a,[lxoff]		;FD 78p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc
      .list
	ld	a,pcr_ofst(pc)		;FD 78 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	ld	a,(pc+pcr_ofst)		;FD 78 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	ld	a,[pcr_ofst]		;FD 78 22 11
    .nlist
  .endif
.list  ; end<--
	ld	a,[.+lxofc]		;FD 78 1E 11
	ld	a,(hl+ix)		;DD 79
	ld	a,(hl+iy)		;DD 7A
	ld	a,(ix+iy)		;DD 7B
	;***********************************************************
	; p. 5-71
	.z280
	ld	ixh,a			;DD 67
	ld	ixl,a			;DD 6F
	ld	iyh,a			;FD 67
	ld	iyl,a			;FD 6F
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
    	ld	(daddr),a		;32r00s00
	ld	offset(ix),a		;ED 2Br00s00
	ld	(ix+offset),a		;ED 2Br00s00
	ld	offset(iy),a		;ED 33r00s00
	ld	(iy+offset),a		;ED 33r00s00
	ld	offset(hl),a		;ED 3Br00s00
	ld	(hl+offset),a		;ED 3Br00s00
	ld	offset(sp),a		;ED 03r00s00
	ld	(sp+offset),a		;ED 03r00s00
	ld	lxoff(ix),a		;ED 2Br00s00
	ld	(ix+lxoff),a		;ED 2Br00s00
	ld	lxoff(iy),a		;ED 33r00s00
	ld	(iy+lxoff),a		;ED 33r00s00
	ld	lxoff(hl),a		;ED 3Br00s00
	ld	(hl+lxoff),a		;ED 3Br00s00
	ld	lxoff(sp),a		;ED 03r00s00
	ld	(sp+lxoff),a		;ED 03r00s00
      .nlist
    .else
      .list
    	ld	(daddr),a		;32r44s33
	ld	offset(ix),a		;ED 2Br55s00
	ld	(ix+offset),a		;ED 2Br55s00
	ld	offset(iy),a		;ED 33r55s00
	ld	(iy+offset),a		;ED 33r55s00
	ld	offset(hl),a		;ED 3Br55s00
	ld	(hl+offset),a		;ED 3Br55s00
	ld	offset(sp),a		;ED 03r55s00
	ld	(sp+offset),a		;ED 03r55s00
	ld	lxoff(ix),a		;ED 2Br22s11
	ld	(ix+lxoff),a		;ED 2Br22s11
	ld	lxoff(iy),a		;ED 33r22s11
	ld	(iy+lxoff),a		;ED 33r22s11
	ld	lxoff(hl),a		;ED 3Br22s11
	ld	(hl+lxoff),a		;ED 3Br22s11
	ld	lxoff(sp),a		;ED 03r22s11
	ld	(sp+lxoff),a		;ED 03r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
    	ld	(daddr),a		;32 44 33
    .nlist
    .ifeq _X_R
      .list
	ld	offset(ix),a		;ED 2B 55 00
	ld	(ix+offset),a		;ED 2B 55 00
	ld	offset(iy),a		;ED 33 55 00
	ld	(iy+offset),a		;ED 33 55 00
      .nlist
    .else
      .list
	ld	offset(ix),a		;DD 77 55
	ld	(ix+offset),a		;DD 77 55
	ld	offset(iy),a		;FD 77 55
	ld	(iy+offset),a		;FD 77 55
      .nlist
    .endif
    .list
	ld	offset(hl),a		;ED 3B 55 00
	ld	(hl+offset),a		;ED 3B 55 00
	ld	offset(sp),a		;ED 03 55 00
	ld	(sp+offset),a		;ED 03 55 00
	ld	lxoff(ix),a		;ED 2B 22 11
	ld	(ix+lxoff),a		;ED 2B 22 11
	ld	lxoff(iy),a		;ED 33 22 11
	ld	(iy+lxoff),a		;ED 33 22 11
	ld	lxoff(hl),a		;ED 3B 22 11
	ld	(hl+lxoff),a		;ED 3B 22 11
	ld	lxoff(sp),a		;ED 03 22 11
	ld	(sp+lxoff),a		;ED 03 22 11
    .nlist
  .endif
.list  ; end<--
	ld	(ix),a			;DD 77 00
	ld	(iy),a			;FD 77 00
	ld	(hl),a			;77
;	ld	(hl),a			;ED 3B 00 00
	ld	(sp),a			;ED 03 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn ld04,lxofc
      .list
	ld	ld04(pc),a		;ED 23p00q00
      .nlist
      .pcr_xtrn ld05,lxofc
      .list
	ld	(pc+ld05),a		;ED 23p00q00
      .nlist
      .pcr_xtrn ld06,lxofc
      .list
	ld	[ld06],a		;ED 23p00q00
      .nlist
    .else
      .pcr_lclx ld04
      .list
	ld	lxofc+ld04(pc),a	;ED 23p22q11
      .nlist
      .pcr_lclx ld05
      .list
	ld	(pc+lxofc+ld05),a	;ED 23p22q11
      .nlist
      .pcr_lclx ld06
      .list
	ld	[lxofc+ld06],a		;ED 23p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn ld04,lxofc
      .list
	ld	ld04(pc),a		;ED 23 22 11
      .nlist
      .pcr_xtrn ld05,lxofc
      .list
	ld	(pc+ld05),a		;ED 23 22 11
      .nlist
      .pcr_xtrn ld06,lxofc
      .list
	ld	[ld06],a		;ED 23 22 11
      .nlist
    .else
      .pcr_lclx ld04
      .list
	ld	lxofc+ld04(pc),a	;ED 23 22 11
      .nlist
      .pcr_lclx ld05
      .list
	ld	(pc+lxofc+ld05),a	;ED 23 22 11
      .nlist
      .pcr_lclx ld06
      .list
	ld	[lxofc+ld06],a		;ED 23 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	ld	lxoff(pc),a		;ED 23p22q11
	ld	(pc+lxoff),a		;ED 23p22q11
	ld	[lxoff],a		;ED 23p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc
      .list
	ld	pcr_ofst(pc),a		;ED 23 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	ld	(pc+pcr_ofst),a		;ED 23 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	ld	[pcr_ofst],a		;ED 23 22 11
    .nlist
  .endif
.list  ; end<--
	ld	[.-32],a		;ED 23 DC FF
	ld	(hl+ix),a		;ED 0B
	ld	(hl+iy),a		;ED 13
	ld	(iy+ix),a		;ED 1B
	;***********************************************************
	; p. 5-73
	.z280
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	ixh,#n			;DD 26r00
	ld	ixl,#n			;DD 2Er00
	ld	iyh,#n			;FD 26r00
	ld	iyl,#n			;FD 2Er00
	ld	(daddr),#n		;DD 3Er00s00r00
	ld	offset(ix),#n		;FD 0Er00s00r00
	ld	(ix+offset),#n		;FD 0Er00s00r00
	ld	offset(iy),#n		;FD 16r00s00r00
	ld	(iy+offset),#n		;FD 16r00s00r00
	ld	offset(hl),#n		;FD 1Er00s00r00
	ld	(hl+offset),#n		;FD 1Er00s00r00
	ld	offset(sp),#n		;DD 06r00s00r00
	ld	(sp+offset),#n		;DD 06r00s00r00
	ld	lxoff(ix),#n		;FD 0Er00s00r00
	ld	(ix+lxoff),#n		;FD 0Er00s00r00
	ld	lxoff(iy),#n		;FD 16r00s00r00
	ld	(iy+lxoff),#n		;FD 16r00s00r00
	ld	lxoff(hl),#n		;FD 1Er00s00r00
	ld	(hl+lxoff),#n		;FD 1Er00s00r00
	ld	lxoff(sp),#n		;DD 06r00s00r00
	ld	(sp+lxoff),#n		;DD 06r00s00r00
	ld	(hl+ix),#n		;DD 0Er00
	ld	(hl+iy),#n		;DD 16r00
	ld	(ix+iy),#n		;DD 1Er00
      .nlist
    .else
      .list
	ld	ixh,#n			;DD 26r20
	ld	ixl,#n			;DD 2Er20
	ld	iyh,#n			;FD 26r20
	ld	iyl,#n			;FD 2Er20
	ld	(daddr),#n		;DD 3Er44s33r20
	ld	offset(ix),#n		;FD 0Er55s00r20
	ld	(ix+offset),#n		;FD 0Er55s00r20
	ld	offset(iy),#n		;FD 16r55s00r20
	ld	(iy+offset),#n		;FD 16r55s00r20
	ld	offset(hl),#n		;FD 1Er55s00r20
	ld	(hl+offset),#n		;FD 1Er55s00r20
	ld	offset(sp),#n		;DD 06r55s00r20
	ld	(sp+offset),#n		;DD 06r55s00r20
	ld	lxoff(ix),#n		;FD 0Er22s11r20
	ld	(ix+lxoff),#n		;FD 0Er22s11r20
	ld	lxoff(iy),#n		;FD 16r22s11r20
	ld	(iy+lxoff),#n		;FD 16r22s11r20
	ld	lxoff(hl),#n		;FD 1Er22s11r20
	ld	(hl+lxoff),#n		;FD 1Er22s11r20
	ld	lxoff(sp),#n		;DD 06r22s11r20
	ld	(sp+lxoff),#n		;DD 06r22s11r20
	ld	(hl+ix),#n		;DD 0Er20
	ld	(hl+iy),#n		;DD 16r20
	ld	(ix+iy),#n		;DD 1Er20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	ixh,#n			;DD 26 20
	ld	ixl,#n			;DD 2E 20
	ld	iyh,#n			;FD 26 20
	ld	iyl,#n			;FD 2E 20
	ld	(daddr),#n		;DD 3E 44 33 20
    .nlist
    .ifeq _X_R
      .list
 	ld	offset(ix),#n		;FD 0E 55 00 20
	ld	(ix+offset),#n		;FD 0E 55 00 20
	ld	offset(iy),#n		;FD 16 55 00 20
	ld	(iy+offset),#n		;FD 16 55 00 20
     .nlist
    .else
      .list
	ld	offset(ix),#n		;DD 36 55 20
	ld	(ix+offset),#n		;DD 36 55 20
	ld	offset(iy),#n		;FD 36 55 20
	ld	(iy+offset),#n		;FD 36 55 20
      .nlist
    .endif
    .list
	ld	offset(hl),#n		;FD 1E 55 00 20
	ld	(hl+offset),#n		;FD 1E 55 00 20
	ld	offset(sp),#n		;DD 06 55 00 20
	ld	(sp+offset),#n		;DD 06 55 00 20
	ld	lxoff(ix),#n		;FD 0E 22 11 20
	ld	(ix+lxoff),#n		;FD 0E 22 11 20
	ld	lxoff(iy),#n		;FD 16 22 11 20
	ld	(iy+lxoff),#n		;FD 16 22 11 20
	ld	lxoff(hl),#n		;FD 1E 22 11 20
	ld	(hl+lxoff),#n		;FD 1E 22 11 20
	ld	lxoff(sp),#n		;DD 06 22 11 20
	ld	(sp+lxoff),#n		;DD 06 22 11 20
	ld	(hl+ix),#n		;DD 0E 20
	ld	(hl+iy),#n		;DD 16 20
	ld	(ix+iy),#n		;DD 1E 20
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn ld07,lxofc,5
      .list
	ld	ld07(pc),#n		;FD 06pFFqFFr00
      .nlist
      .pcr_xtrn ld08,lxofc,5
      .list
	ld	(pc+ld08),#n		;FD 06pFFqFFr00
      .nlist
      .pcr_xtrn ld09,lxofc,5
      .list
	ld	[ld09],#n		;FD 06pFFqFFr00
      .nlist
    .else
      .pcr_lclx ld07,5
      .list
	ld	lxofc+ld07(pc),#n	;FD 06p21q11r20
      .nlist
      .pcr_lclx ld08,5
      .list
	ld	(pc+lxofc+ld08),#n	;FD 06p21q11r20
      .nlist
      .pcr_lclx ld09,5
      .list
	ld	[lxofc+ld09],#n		;FD 06p21q11r20
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn ld07,lxofc,5
      .list
	ld	ld07(pc),#n		;FD 06 22 11 20
      .nlist
      .pcr_xtrn ld08,lxofc,5
      .list
	ld	(pc+ld08),#n		;FD 06 22 11 20
      .nlist
      .pcr_xtrn ld09,lxofc,5
      .list
	ld	[ld09],#n		;FD 06 22 11 20
      .nlist
    .else
      .pcr_lclx ld07,5
      .list
	ld	lxofc+ld07(pc),#n	;FD 06 22 11 20
      .nlist
      .pcr_lclx ld08,5
      .list
	ld	(pc+lxofc+ld08),#n	;FD 06 22 11 20
      .nlist
      .pcr_lclx ld09,5
      .list
	ld	[lxofc+ld09],#n		;FD 06 22 11 20
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	ld	lxoff(pc),#n		;FD 06p21q11 20
	ld	(pc+lxoff),#n		;FD 06p21q11 20
	ld	[lxoff],#n		;FD 06p21q11 20
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc,5
      .list
	ld	pcr_ofst(pc),#n		;FD 06 22 11 20
      .nlist
	.pcr_ofst lxofc,5
      .list
	ld	(pc+pcr_ofst),#n	;FD 06 22 11 20
      .nlist
	.pcr_ofst lxofc,5
      .list
	ld	[pcr_ofst],#n		;FD 06 22 11 20
    .nlist
  .endif
.list  ; end<--
	ld	[.+32],#nc		;FD 06 1B 00 20

	;***********************************************************
	; p. 5-74
	.z280
	ld	a,ixh			;DD 7C
	ld	a,iyl			;FD 7D
	ld	b,ixh			;DD 44
	ld	b,ixl			;DD 45
	ld	c,ixh			;DD 4C
	ld	c,ixl			;DD 4D
	ld	d,iyh			;FD 54
	ld	d,iyl			;FD 55
	ld	e,iyh			;FD 5C
	ld	e,iyl			;FD 5D
	ld	ixh,ixh			;DD 64
	ld	ixh,ixl			;DD 65
	ld	ixl,ixh			;DD 6C
	ld	ixl,ixl			;DD 6D
	ld	iyh,iyh			;FD 64
	ld	iyh,iyl			;FD 65
	ld	iyl,iyh			;FD 6C
	ld	iyl,iyl			;FD 6D
	ld	h,d			;62
	ld	l,e			;6B
	ld	ixh,a			;DD 67
	ld	ixl,a			;DD 6F
	ld	iyh,a			;FD 67
	ld	iyl,a			;FD 6F
	ld	ixh,b			;DD 60
	ld	ixl,c			;DD 69
	ld	iyh,d			;FD 62
	ld	iyl,e			;FD 6B

;*******************************************************************
;	LDB	
;*******************************************************************
	;***********************************************************
	; p. 5-74
	.z280
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ldb	(daddr),#n		;DD 3Er00s00r00
	ldb	offset(ix),#n		;FD 0Er00s00r00
	ldb	(ix+offset),#n		;FD 0Er00s00r00
	ldb	offset(iy),#n		;FD 16r00s00r00
	ldb	(iy+offset),#n		;FD 16r00s00r00
	ldb	offset(hl),#n		;FD 1Er00s00r00
	ldb	(hl+offset),#n		;FD 1Er00s00r00
	ldb	offset(sp),#n		;DD 06r00s00r00
	ldb	(sp+offset),#n		;DD 06r00s00r00
	ldb	lxoff(ix),#n		;FD 0Er00s00r00
	ldb	(ix+lxoff),#n		;FD 0Er00s00r00
	ldb	lxoff(iy),#n		;FD 16r00s00r00
	ldb	(iy+lxoff),#n		;FD 16r00s00r00
	ldb	lxoff(hl),#n		;FD 1Er00s00r00
	ldb	(hl+lxoff),#n		;FD 1Er00s00r00
	ldb	lxoff(sp),#n		;DD 06r00s00r00
	ldb	(sp+lxoff),#n		;DD 06r00s00r00
	ldb	(hl+ix),#n		;DD 0Er00
	ldb	(hl+iy),#n		;DD 16r00
	ldb	(ix+iy),#n		;DD 1Er00
      .nlist
    .else
      .list
	ldb	(daddr),#n		;DD 3Er44s33r20
	ldb	offset(ix),#n		;FD 0Er55s00r20
	ldb	(ix+offset),#n		;FD 0Er55s00r20
	ldb	offset(iy),#n		;FD 16r55s00r20
	ldb	(iy+offset),#n		;FD 16r55s00r20
	ldb	offset(hl),#n		;FD 1Er55s00r20
	ldb	(hl+offset),#n		;FD 1Er55s00r20
	ldb	offset(sp),#n		;DD 06r55s00r20
	ldb	(sp+offset),#n		;DD 06r55s00r20
	ldb	lxoff(ix),#n		;FD 0Er22s11r20
	ldb	(ix+lxoff),#n		;FD 0Er22s11r20
	ldb	lxoff(iy),#n		;FD 16r22s11r20
	ldb	(iy+lxoff),#n		;FD 16r22s11r20
	ldb	lxoff(hl),#n		;FD 1Er22s11r20
	ldb	(hl+lxoff),#n		;FD 1Er22s11r20
	ldb	lxoff(sp),#n		;DD 06r22s11r20
	ldb	(sp+lxoff),#n		;DD 06r22s11r20
	ldb	(hl+ix),#n		;DD 0Er20
	ldb	(hl+iy),#n		;DD 16r20
	ldb	(ix+iy),#n		;DD 1Er20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ldb	(daddr),#n		;DD 3E 44 33 20
    .nlist
    .ifeq _X_R
      .list
 	ldb	offset(ix),#n		;FD 0E 55 00 20
	ldb	(ix+offset),#n		;FD 0E 55 00 20
	ldb	offset(iy),#n		;FD 16 55 00 20
	ldb	(iy+offset),#n		;FD 16 55 00 20
     .nlist
    .else
      .list
	ldb	offset(ix),#n		;DD 36 55 20
	ldb	(ix+offset),#n		;DD 36 55 20
	ldb	offset(iy),#n		;FD 36 55 20
	ldb	(iy+offset),#n		;FD 36 55 20
      .nlist
    .endif
    .list
	ldb	offset(hl),#n		;FD 1E 55 00 20
	ldb	(hl+offset),#n		;FD 1E 55 00 20
	ldb	offset(sp),#n		;DD 06 55 00 20
	ldb	(sp+offset),#n		;DD 06 55 00 20
	ldb	lxoff(ix),#n		;FD 0E 22 11 20
	ldb	(ix+lxoff),#n		;FD 0E 22 11 20
	ldb	lxoff(iy),#n		;FD 16 22 11 20
	ldb	(iy+lxoff),#n		;FD 16 22 11 20
	ldb	lxoff(hl),#n		;FD 1E 22 11 20
	ldb	(hl+lxoff),#n		;FD 1E 22 11 20
	ldb	lxoff(sp),#n		;DD 06 22 11 20
	ldb	(sp+lxoff),#n		;DD 06 22 11 20
	ldb	(hl+ix),#n		;DD 0E 20
	ldb	(hl+iy),#n		;DD 16 20
	ldb	(ix+iy),#n		;DD 1E 20
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn ldb01,lxofc,5
      .list
	ldb	ldb01(pc),#n		;FD 06pFFqFFr00
      .nlist
      .pcr_xtrn ldb02,lxofc,5
      .list
	ldb	(pc+ldb02),#n		;FD 06pFFqFFr00
      .nlist
      .pcr_xtrn ldb03,lxofc,5
      .list
	ldb	[ldb03],#n		;FD 06pFFqFFr00
      .nlist
    .else
      .pcr_lclx ldb01,5
      .list
	ldb	lxofc+ldb01(pc),#n	;FD 06p21q11r20
      .nlist
      .pcr_lclx ldb02,5
      .list
	ldb	(pc+lxofc+ldb02),#n	;FD 06p21q11r20
      .nlist
      .pcr_lclx ldb03,5
      .list
	ldb	[lxofc+ldb03],#n	;FD 06p21q11r20
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn ldb01,lxofc,5
      .list
	ldb	ldb01(pc),#n		;FD 06 22 11 20
      .nlist
      .pcr_xtrn ldb02,lxofc,5
      .list
	ldb	(pc+ldb02),#n		;FD 06 22 11 20
      .nlist
      .pcr_xtrn ldb03,lxofc,5
      .list
	ldb	[ldb03],#n		;FD 06 22 11 20
      .nlist
    .else
      .pcr_lclx ldb01,5
      .list
	ldb	lxofc+ldb01(pc),#n	;FD 06 22 11 20
      .nlist
      .pcr_lclx ldb02,5
      .list
	ldb	(pc+lxofc+ldb02),#n	;FD 06 22 11 20
      .nlist
      .pcr_lclx ldb03,5
      .list
	ldb	[lxofc+ldb03],#n	;FD 06 22 11 20
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	ldb	lxoff(pc),#n		;FD 06p21q11 20
	ldb	(pc+lxoff),#n		;FD 06p21q11 20
	ldb	[lxoff],#n		;FD 06p21q11 20
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc,5
      .list
	ldb	pcr_ofst(pc),#n		;FD 06 22 11 20
      .nlist
	.pcr_ofst lxofc,5
      .list
	ldb	(pc+pcr_ofst),#n	;FD 06 22 11 20
      .nlist
	.pcr_ofst lxofc,5
      .list
	ldb	[pcr_ofst],#n		;FD 06 22 11 20
    .nlist
  .endif
.list  ; end<--
	ldb	[.+32],#nc		;FD 06 1B 00 20

;*******************************************************************
;	LDA
;*******************************************************************
	;***********************************************************
	; p. 5-76
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	lda	hl,(daddr)		;21r00s00
	lda	ix,(daddr)		;DD 21r00s00
	lda	iy,(daddr)		;FD 21r00s00
      .nlist
    .else
      .list
	lda	hl,(daddr)		;21r44s33
	lda	ix,(daddr)		;DD 21r44s33
	lda	iy,(daddr)		;FD 21r44s33
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	lda	hl,(daddr)		;21 44 33
	lda	ix,(daddr)		;DD 21 44 33
	lda	iy,(daddr)		;FD 21 44 33
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	lda	hl,(ix+sxoff)		;ED 2Ar00s00
	lda	hl,(ix+lxoff)		;ED 2Ar00s00
	lda	hl,(iy+sxoff)		;ED 32r00s00
	lda	hl,(iy+lxoff)		;ED 32r00s00
	lda	hl,(hl+sxoff)		;ED 3Ar00s00
	lda	hl,(hl+lxoff)		;ED 3Ar00s00
	lda	hl,(sp+sxoff)		;ED 02r00s00
	lda	hl,(sp+lxoff)		;ED 02r00s00
	lda	ix,(ix+sxoff)		;DD ED 2Ar00s00
	lda	ix,(ix+lxoff)		;DD ED 2Ar00s00
	lda	ix,(iy+sxoff)		;DD ED 32r00s00
	lda	ix,(iy+lxoff)		;DD ED 32r00s00
	lda	ix,(hl+sxoff)		;DD ED 3Ar00s00
	lda	ix,(hl+lxoff)		;DD ED 3Ar00s00
	lda	ix,(sp+sxoff)		;DD ED 02r00s00
	lda	ix,(sp+lxoff)		;DD ED 02r00s00
	lda	iy,(ix+sxoff)		;FD ED 2Ar00s00
	lda	iy,(ix+lxoff)		;FD ED 2Ar00s00
	lda	iy,(iy+sxoff)		;FD ED 32r00s00
	lda	iy,(iy+lxoff)		;FD ED 32r00s00
	lda	iy,(hl+sxoff)		;FD ED 3Ar00s00
	lda	iy,(hl+lxoff)		;FD ED 3Ar00s00
	lda	iy,(sp+sxoff)		;FD ED 02r00s00
	lda	iy,(sp+lxoff)		;FD ED 02r00s00
	lda	hl,sxoff(ix)		;ED 2Ar00s00
	lda	hl,lxoff(ix)		;ED 2Ar00s00
	lda	hl,sxoff(iy)		;ED 32r00s00
	lda	hl,lxoff(iy)		;ED 32r00s00
	lda	hl,sxoff(hl)		;ED 3Ar00s00
	lda	hl,lxoff(hl)		;ED 3Ar00s00
	lda	hl,sxoff(sp)		;ED 02r00s00
	lda	hl,lxoff(sp)		;ED 02r00s00
	lda	ix,sxoff(ix)		;DD ED 2Ar00s00
	lda	ix,lxoff(ix)		;DD ED 2Ar00s00
	lda	ix,sxoff(iy)		;DD ED 32r00s00
	lda	ix,lxoff(iy)		;DD ED 32r00s00
	lda	ix,sxoff(hl)		;DD ED 3Ar00s00
	lda	ix,lxoff(hl)		;DD ED 3Ar00s00
	lda	ix,sxoff(sp)		;DD ED 02r00s00
	lda	ix,lxoff(sp)		;DD ED 02r00s00
	lda	iy,sxoff(ix)		;FD ED 2Ar00s00
	lda	iy,lxoff(ix)		;FD ED 2Ar00s00
	lda	iy,sxoff(iy)		;FD ED 32r00s00
	lda	iy,lxoff(iy)		;FD ED 32r00s00
	lda	iy,sxoff(hl)		;FD ED 3Ar00s00
	lda	iy,lxoff(hl)		;FD ED 3Ar00s00
	lda	iy,sxoff(sp)		;FD ED 02r00s00
	lda	iy,lxoff(sp)		;FD ED 02r00s00
      .nlist
    .else
      .list
	lda	hl,(ix+sxoff)		;ED 2Ar55s00
	lda	hl,(ix+lxoff)		;ED 2Ar22s11
	lda	hl,(iy+sxoff)		;ED 32r55s00
	lda	hl,(iy+lxoff)		;ED 32r22s11
	lda	hl,(hl+sxoff)		;ED 3Ar55s00
	lda	hl,(hl+lxoff)		;ED 3Ar22s11
	lda	hl,(sp+sxoff)		;ED 02r55s00
	lda	hl,(sp+lxoff)		;ED 02r22s11
	lda	ix,(ix+sxoff)		;DD ED 2Ar55s00
	lda	ix,(ix+lxoff)		;DD ED 2Ar22s11
	lda	ix,(iy+sxoff)		;DD ED 32r55s00
	lda	ix,(iy+lxoff)		;DD ED 32r22s11
	lda	ix,(hl+sxoff)		;DD ED 3Ar55s00
	lda	ix,(hl+lxoff)		;DD ED 3Ar22s11
	lda	ix,(sp+sxoff)		;DD ED 02r55s00
	lda	ix,(sp+lxoff)		;DD ED 02r22s11
	lda	iy,(ix+sxoff)		;FD ED 2Ar55s00
	lda	iy,(ix+lxoff)		;FD ED 2Ar22s11
	lda	iy,(iy+sxoff)		;FD ED 32r55s00
	lda	iy,(iy+lxoff)		;FD ED 32r22s11
	lda	iy,(hl+sxoff)		;FD ED 3Ar55s00
	lda	iy,(hl+lxoff)		;FD ED 3Ar22s11
	lda	iy,(sp+sxoff)		;FD ED 02r55s00
	lda	iy,(sp+lxoff)		;FD ED 02r22s11
	lda	hl,sxoff(ix)		;ED 2Ar55s00
	lda	hl,lxoff(ix)		;ED 2Ar22s11
	lda	hl,sxoff(iy)		;ED 32r55s00
	lda	hl,lxoff(iy)		;ED 32r22s11
	lda	hl,sxoff(hl)		;ED 3Ar55s00
	lda	hl,lxoff(hl)		;ED 3Ar22s11
	lda	hl,sxoff(sp)		;ED 02r55s00
	lda	hl,lxoff(sp)		;ED 02r22s11
	lda	ix,sxoff(ix)		;DD ED 2Ar55s00
	lda	ix,lxoff(ix)		;DD ED 2Ar22s11
	lda	ix,sxoff(iy)		;DD ED 32r55s00
	lda	ix,lxoff(iy)		;DD ED 32r22s11
	lda	ix,sxoff(hl)		;DD ED 3Ar55s00
	lda	ix,lxoff(hl)		;DD ED 3Ar22s11
	lda	ix,sxoff(sp)		;DD ED 02r55s00
	lda	ix,lxoff(sp)		;DD ED 02r22s11
	lda	iy,sxoff(ix)		;FD ED 2Ar55s00
	lda	iy,lxoff(ix)		;FD ED 2Ar22s11
	lda	iy,sxoff(iy)		;FD ED 32r55s00
	lda	iy,lxoff(iy)		;FD ED 32r22s11
	lda	iy,sxoff(hl)		;FD ED 3Ar55s00
	lda	iy,lxoff(hl)		;FD ED 3Ar22s11
	lda	iy,sxoff(sp)		;FD ED 02r55s00
	lda	iy,lxoff(sp)		;FD ED 02r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	lda	hl,(ix+sxoff)		;ED 2A 55 00
	lda	hl,(ix+lxoff)		;ED 2A 22 11
	lda	hl,(iy+sxoff)		;ED 32 55 00
	lda	hl,(iy+lxoff)		;ED 32 22 11
	lda	hl,(hl+sxoff)		;ED 3A 55 00
	lda	hl,(hl+lxoff)		;ED 3A 22 11
	lda	hl,(sp+sxoff)		;ED 02 55 00
	lda	hl,(sp+lxoff)		;ED 02 22 11
	lda	ix,(ix+sxoff)		;DD ED 2A 55 00
	lda	ix,(ix+lxoff)		;DD ED 2A 22 11
	lda	ix,(iy+sxoff)		;DD ED 32 55 00
	lda	ix,(iy+lxoff)		;DD ED 32 22 11
	lda	ix,(hl+sxoff)		;DD ED 3A 55 00
	lda	ix,(hl+lxoff)		;DD ED 3A 22 11
	lda	ix,(sp+sxoff)		;DD ED 02 55 00
	lda	ix,(sp+lxoff)		;DD ED 02 22 11
	lda	iy,(ix+sxoff)		;FD ED 2A 55 00
	lda	iy,(ix+lxoff)		;FD ED 2A 22 11
	lda	iy,(iy+sxoff)		;FD ED 32 55 00
	lda	iy,(iy+lxoff)		;FD ED 32 22 11
	lda	iy,(hl+sxoff)		;FD ED 3A 55 00
	lda	iy,(hl+lxoff)		;FD ED 3A 22 11
	lda	iy,(sp+sxoff)		;FD ED 02 55 00
	lda	iy,(sp+lxoff)		;FD ED 02 22 11
	lda	hl,sxoff(ix)		;ED 2A 55 00
	lda	hl,lxoff(ix)		;ED 2A 22 11
	lda	hl,sxoff(iy)		;ED 32 55 00
	lda	hl,lxoff(iy)		;ED 32 22 11
	lda	hl,sxoff(hl)		;ED 3A 55 00
	lda	hl,lxoff(hl)		;ED 3A 22 11
	lda	hl,sxoff(sp)		;ED 02 55 00
	lda	hl,lxoff(sp)		;ED 02 22 11
	lda	ix,sxoff(ix)		;DD ED 2A 55 00
	lda	ix,lxoff(ix)		;DD ED 2A 22 11
	lda	ix,sxoff(iy)		;DD ED 32 55 00
	lda	ix,lxoff(iy)		;DD ED 32 22 11
	lda	ix,sxoff(hl)		;DD ED 3A 55 00
	lda	ix,lxoff(hl)		;DD ED 3A 22 11
	lda	ix,sxoff(sp)		;DD ED 02 55 00
	lda	ix,lxoff(sp)		;DD ED 02 22 11
	lda	iy,sxoff(ix)		;FD ED 2A 55 00
	lda	iy,lxoff(ix)		;FD ED 2A 22 11
	lda	iy,sxoff(iy)		;FD ED 32 55 00
	lda	iy,lxoff(iy)		;FD ED 32 22 11
	lda	iy,sxoff(hl)		;FD ED 3A 55 00
	lda	iy,lxoff(hl)		;FD ED 3A 22 11
	lda	iy,sxoff(sp)		;FD ED 02 55 00
	lda	iy,lxoff(sp)		;FD ED 02 22 11
    .nlist
  .endif
.list  ; end<--
	lda	hl,(ix)			;ED 2A 00 00
	lda	hl,(iy)			;ED 32 00 00
	lda	hl,(hl)			;ED 3A 00 00
	lda	hl,(sp)			;ED 02 00 00
	lda	ix,(ix)			;DD ED 2A 00 00
	lda	ix,(iy)			;DD ED 32 00 00
	lda	ix,(hl)			;DD ED 3A 00 00
	lda	ix,(sp)			;DD ED 02 00 00
	lda	iy,(ix)			;FD ED 2A 00 00
	lda	iy,(iy)			;FD ED 32 00 00
	lda	iy,(hl)			;FD ED 3A 00 00
	lda	iy,(sp)			;FD ED 02 00 00
	lda	hl,(ix+hl)		;ED 0A
	lda	hl,(hl+iy)		;ED 12
	lda	hl,(ix+iy)		;ED 1A
	lda	ix,(hl+ix)		;DD ED 0A
	lda	ix,(hl+iy)		;DD ED 12
	lda	ix,(ix+iy)		;DD ED 1A
	lda	iy,(hl+ix)		;FD ED 0A
	lda	iy,(hl+iy)		;FD ED 12
	lda	iy,(ix+iy)		;FD ED 1A
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn lda01,lxofc,5
      .list
	lda	ix,lda01(pc)		;DD ED 22p00q00
      .nlist
      .pcr_xtrn lda02,lxofc,5
      .list
	lda	ix,(pc+lda02)		;DD ED 22p00q00
      .nlist
      .pcr_xtrn lda03,lxofc,5
      .list
	lda	ix,[lda03]		;DD ED 22p00q00
      .nlist
    .else
      .pcr_lclx lda01,5
      .list
	lda	ix,lxofc+lda01(pc)	;DD ED 22p22q11
      .nlist
      .pcr_lclx lda02,5
      .list
	lda	ix,(pc+lxofc+lda02)	;DD ED 22p22q11
      .nlist
      .pcr_lclx lda03,5
      .list
	lda	ix,[lxofc+lda03]	;DD ED 22p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn lda01,lxofc,5
      .list
	lda	ix,lda01(pc)		;DD ED 22 22 11
      .nlist
      .pcr_xtrn lda02,lxofc,5
      .list
	lda	ix,(pc+lda02)		;DD ED 22 22 11
      .nlist
      .pcr_xtrn lda03,lxofc,5
      .list
	lda	ix,[lda03]		;DD ED 22 22 11
      .nlist
    .else
      .pcr_lclx lda01,5
      .list
	lda	ix,lxofc+lda01(pc)	;DD ED 22 22 11
      .nlist
      .pcr_lclx lda02,5
      .list
	lda	ix,(pc+lxofc+lda02)	;DD ED 22 22 11
      .nlist
      .pcr_lclx lda03,5
      .list
	lda	ix,[lxofc+lda03]	;DD ED 22 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	lda	ix,lxoff(pc)		;DD ED 22p22q11
	lda	ix,(pc+lxoff)		;DD ED 22p22q11
	lda	ix,[lxoff]		;DD ED 22p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc,5
      .list
	lda	ix,pcr_ofst(pc)		;DD ED 22 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	lda	ix,(pc+pcr_ofst)	;DD ED 22 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	lda	ix,[pcr_ofst]		;DD ED 22 22 11
    .nlist
  .endif
.list  ; end<--
	lda	ix,[.]			;DD ED 22 FB FF
	lda	ix,[.+nc]		;DD ED 22 1B 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn lda04,lxofc,5
      .list
	lda	iy,lda04(pc)		;FD ED 22p00q00
      .nlist
      .pcr_xtrn lda05,lxofc,5
      .list
	lda	iy,(pc+lda05)		;FD ED 22p00q00
      .nlist
      .pcr_xtrn lda06,lxofc,5
      .list
	lda	iy,[lda06]		;FD ED 22p00q00
      .nlist
    .else
      .pcr_lclx lda04,5
      .list
	lda	iy,lxofc+lda04(pc)	;FD ED 22p22q11
      .nlist
      .pcr_lclx lda05,5
      .list
	lda	iy,(pc+lxofc+lda05)	;FD ED 22p22q11
      .nlist
      .pcr_lclx lda06,5
      .list
	lda	iy,[lxofc+lda06]	;FD ED 22p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn lda04,lxofc,5
      .list
	lda	iy,lda04(pc)		;FD ED 22 22 11
      .nlist
      .pcr_xtrn lda05,lxofc,5
      .list
	lda	iy,(pc+lda05)		;FD ED 22 22 11
      .nlist
      .pcr_xtrn lda06,lxofc,5
      .list
	lda	iy,[lda06]		;FD ED 22 22 11
      .nlist
    .else
      .pcr_lclx lda04,5
      .list
	lda	iy,lxofc+lda04(pc)	;FD ED 22 22 11
      .nlist
      .pcr_lclx lda05,5
      .list
	lda	iy,(pc+lxofc+lda05)	;FD ED 22 22 11
      .nlist
      .pcr_lclx lda06,5
      .list
	lda	iy,[lxofc+lda06]	;FD ED 22 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	lda	iy,lxoff(pc)		;FD ED 22p22q11
	lda	iy,(pc+lxoff)		;FD ED 22p22q11
	lda	iy,[lxoff]		;FD ED 22p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc,5
      .list
	lda	iy,pcr_ofst(pc)		;FD ED 22 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	lda	iy,(pc+pcr_ofst)	;FD ED 22 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	lda	iy,[pcr_ofst]		;FD ED 22 22 11
    .nlist
  .endif
.list  ; end<--
	lda	iy,[.]			;FD ED 22 FB FF
	lda	iy,[.+nc]		;FD ED 22 1B 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn lda07,lxofc
      .list
	lda	hl,lda07(pc)		;ED 22p00q00
      .nlist
      .pcr_xtrn lda08,lxofc
      .list
	lda	hl,(pc+lda08)		;ED 22p00q00
      .nlist
      .pcr_xtrn lda09,lxofc
      .list
	lda	hl,[lda09]		;ED 22p00q00
      .nlist
    .else
      .pcr_lclx lda07
      .list
	lda	hl,lxofc+lda07(pc)	;ED 22p22q11
      .nlist
      .pcr_lclx lda08
      .list
	lda	hl,(pc+lxofc+lda08)	;ED 22p22q11
      .nlist
      .pcr_lclx lda09
      .list
	lda	hl,[lxofc+lda09]	;ED 22p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn lda07,lxofc
      .list
	lda	hl,lda07(pc)		;ED 22 22 11
      .nlist
      .pcr_xtrn lda08,lxofc
      .list
	lda	hl,(pc+lda08)		;ED 22 22 11
      .nlist
      .pcr_xtrn lda09,lxofc
      .list
	lda	hl,[lda09]		;ED 22 22 11
      .nlist
    .else
      .pcr_lclx lda07
      .list
	lda	hl,lxofc+lda07(pc)	;ED 22 22 11
      .nlist
      .pcr_lclx lda08
      .list
	lda	hl,(pc+lxofc+lda08)	;ED 22 22 11
      .nlist
      .pcr_lclx lda09
      .list
	lda	hl,[lxofc+lda09]	;ED 22 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	lda	hl,lxoff(pc)		;ED 22p22q11
	lda	hl,(pc+lxoff)		;ED 22p22q11
	lda	hl,[lxoff]		;ED 22p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc
      .list
	lda	hl,pcr_ofst(pc)		;ED 22 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	lda	hl,(pc+pcr_ofst)	;ED 22 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	lda	hl,[pcr_ofst]		;ED 22 22 11
    .nlist
  .endif
.list  ; end<--
	lda	hl,[.]			;ED 22 FC FF
	lda	hl,[.+nc]		;ED 22 1C 00

;*******************************************************************
;	LDCTL	
;*******************************************************************
	;***********************************************************
	;  p. 5-77
	.z280p
	ldctl	hl,(c)			;ED 66
	ldctl	ix,(c)			;DD ED 66
	ldctl	iy,(c)			;FD ED 66
	ldctl	(c),hl			;ED 6E
	ldctl	(c),ix			;DD ED 6E
	ldctl	(c),iy			;FD ED 6E
	ldctl	hl,usp			;ED 87
	ldctl	ix,usp			;DD ED 87
	ldctl	iy,usp			;FD ED 87
	ldctl	usp,hl			;ED 8F
	ldctl	usp,ix			;DD ED 8F
	ldctl	usp,iy			;FD ED 8F

;*******************************************************************
;	LDUD	
;		Leading 'a' operand is optional.
;		If offset is ommitted 0 is assumed.
;*******************************************************************
	;***********************************************************
	;  p. 5-84
	.z280p
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ldud	a,(hl)			;ED 86
	ldud	a,sxoff(ix)		;DD ED 86r00
	ldud	a,(ix+sxoff)		;DD ED 86r00
	ldud	a,(ix)			;DD ED 86 00
	ldud	a,sxoff(iy)		;FD ED 86r00
	ldud	a,(iy+sxoff)		;FD ED 86r00
	ldud	a,(iy)			;FD ED 86 00

	ldud	(hl),a			;ED 8E
	ldud	sxoff(ix),a		;DD ED 8Er00
	ldud	(ix+sxoff),a		;DD ED 8Er00
	ldud	(ix),a			;DD ED 8E 00
	ldud	sxoff(iy),a		;FD ED 8Er00
	ldud	(iy+sxoff),a		;FD ED 8Er00
	ldud	(iy),a			;FD ED 8E 00
      .nlist
    .else
      .list
	ldud	a,(hl)			;ED 86
	ldud	a,sxoff(ix)		;DD ED 86r55
	ldud	a,(ix+sxoff)		;DD ED 86r55
	ldud	a,(ix)			;DD ED 86 00
	ldud	a,sxoff(iy)		;FD ED 86r55
	ldud	a,(iy+sxoff)		;FD ED 86r55
	ldud	a,(iy)			;FD ED 86 00

	ldud	(hl),a			;ED 8E
	ldud	sxoff(ix),a		;DD ED 8Er55
	ldud	(ix+sxoff),a		;DD ED 8Er55
	ldud	(ix),a			;DD ED 8E 00
	ldud	sxoff(iy),a		;FD ED 8Er55
	ldud	(iy+sxoff),a		;FD ED 8Er55
	ldud	(iy),a			;FD ED 8E 00
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ldud	a,(hl)			;ED 86
	ldud	a,sxoff(ix)		;DD ED 86 55
	ldud	a,(ix+sxoff)		;DD ED 86 55
	ldud	a,(ix)			;DD ED 86 00
	ldud	a,sxoff(iy)		;FD ED 86 55
	ldud	a,(iy+sxoff)		;FD ED 86 55
	ldud	a,(iy)			;FD ED 86 00

	ldud	(hl),a			;ED 8E
	ldud	sxoff(ix),a		;DD ED 8E 55
	ldud	(ix+sxoff),a		;DD ED 8E 55
	ldud	(ix),a			;DD ED 8E 00
	ldud	sxoff(iy),a		;FD ED 8E 55
	ldud	(iy+sxoff),a		;FD ED 8E 55
	ldud	(iy),a			;FD ED 8E 00
    .nlist
  .endif
.list  ; end<--

;*******************************************************************
;	LDUP	
;		Leading 'a' operand is optional.
;		If offset is ommitted 0 is assumed.
;*******************************************************************
	;***********************************************************
	;  p. 5-86
	.z280p
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ldup	a,(hl)			;ED 96
	ldup	a,sxoff(ix)		;DD ED 96r00
	ldup	a,(ix+sxoff)		;DD ED 96r00
	ldup	a,(ix)			;DD ED 96 00
	ldup	a,sxoff(iy)		;FD ED 96r00
	ldup	a,(iy+sxoff)		;FD ED 96r00
	ldup	a,(iy)			;FD ED 96 00

	ldup	(hl),a			;ED 9E
	ldup	sxoff(ix),a		;DD ED 9Er00
	ldup	(ix+sxoff),a		;DD ED 9Er00
	ldup	(ix),a			;DD ED 9E 00
	ldup	sxoff(iy),a		;FD ED 9Er00
	ldup	(iy+sxoff),a		;FD ED 9Er00
	ldup	(iy),a			;FD ED 9E 00
      .nlist
    .else
      .list
	ldup	a,(hl)			;ED 96
	ldup	a,sxoff(ix)		;DD ED 96r55
	ldup	a,(ix+sxoff)		;DD ED 96r55
	ldup	a,(ix)			;DD ED 96 00
	ldup	a,sxoff(iy)		;FD ED 96r55
	ldup	a,(iy+sxoff)		;FD ED 96r55
	ldup	a,(iy)			;FD ED 96 00

	ldup	(hl),a			;ED 9E
	ldup	sxoff(ix),a		;DD ED 9Er55
	ldup	(ix+sxoff),a		;DD ED 9Er55
	ldup	(ix),a			;DD ED 9E 00
	ldup	sxoff(iy),a		;FD ED 9Er55
	ldup	(iy+sxoff),a		;FD ED 9Er55
	ldup	(iy),a			;FD ED 9E 00
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ldup	a,(hl)			;ED 96
	ldup	a,sxoff(ix)		;DD ED 96 55
	ldup	a,(ix+sxoff)		;DD ED 96 55
	ldup	a,(ix)			;DD ED 96 00
	ldup	a,sxoff(iy)		;FD ED 96 55
	ldup	a,(iy+sxoff)		;FD ED 96 55
	ldup	a,(iy)			;FD ED 96 00

	ldup	(hl),a			;ED 9E
	ldup	sxoff(ix),a		;DD ED 9E 55
	ldup	(ix+sxoff),a		;DD ED 9E 55
	ldup	(ix),a			;DD ED 9E 00
	ldup	sxoff(iy),a		;FD ED 9E 55
	ldup	(iy+sxoff),a		;FD ED 9E 55
	ldup	(iy),a			;FD ED 9E 00
    .nlist
  .endif
.list  ; end<--

;*******************************************************************
;	LDW	
;*******************************************************************
	;***********************************************************
	;  p. 5-88
	.z280
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ldw	bc,#n			;01r00s00
	ldw	de,#n			;11r00s00
	ldw	hl,#n			;21r00s00
	ldw	sp,#n			;31r00s00
	ldw	ix,#n			;DD 21r00s00
	ldw	iy,#n			;FD 21r00s00
	ldw	(hl),#n			;DD 01r00s00
	ldw	(daddr),#n		;DD 11r00s00r00s00
	ldw	bc,#nn			;01r00s00
	ldw	de,#nn			;11r00s00
	ldw	hl,#nn			;21r00s00
	ldw	sp,#nn			;31r00s00
	ldw	ix,#nn			;DD 21r00s00
	ldw	iy,#nn			;FD 21r00s00
	ldw	(hl),#nn		;DD 01r00s00
	ldw	(daddr),#nn		;DD 11r00s00r00s00
      .nlist
    .else
      .list
	ldw	bc,#n			;01r20s00
	ldw	de,#n			;11r20s00
	ldw	hl,#n			;21r20s00
	ldw	sp,#n			;31r20s00
	ldw	ix,#n			;DD 21r20s00
	ldw	iy,#n			;FD 21r20s00
	ldw	(hl),#n			;DD 01r20s00
	ldw	(daddr),#n		;DD 11r44s33r20s00
	ldw	bc,#nn			;01r84s05
	ldw	de,#nn			;11r84s05
	ldw	hl,#nn			;21r84s05
	ldw	sp,#nn			;31r84s05
	ldw	ix,#nn			;DD 21r84s05
	ldw	iy,#nn			;FD 21r84s05
	ldw	(hl),#nn		;DD 01r84s05
	ldw	(daddr),#nn		;DD 11r44s33r84s05
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ldw	bc,#n			;01 20 00
	ldw	de,#n			;11 20 00
	ldw	hl,#n			;21 20 00
	ldw	sp,#n			;31 20 00
	ldw	ix,#n			;DD 21 20 00
	ldw	iy,#n			;FD 21 20 00
	ldw	(hl),#n			;DD 01 20 00
	ldw	(daddr),#n		;DD 11 44 33 20 00
	ldw	bc,#nn			;01 84 05
	ldw	de,#nn			;11 84 05
	ldw	hl,#nn			;21 84 05
	ldw	sp,#nn			;31 84 05
	ldw	ix,#nn			;DD 21 84 05
	ldw	iy,#nn			;FD 21 84 05
	ldw	(hl),#nn		;DD 01 84 05
	ldw	(daddr),#nn		;DD 11 44 33 84 05
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn ldw01,lxofc,6
      .list
	ldw	ldw01(pc),#n		;DD 31pFEqFFr00s00
      .nlist
      .pcr_xtrn ldw02,lxofc,6
      .list
	ldw	(pc+ldw02),#n		;DD 31pFEqFFr00s00
      .nlist
      .pcr_xtrn ldw03,lxofc,6
      .list
	ldw	[ldw03],#n		;DD 31pFEqFFr00s00
      .nlist
    .else
      .pcr_lclx ldw01,6
      .list
	ldw	lxofc+ldw01(pc),#n	;DD 31p20q11r20s00
      .pcr_lclx ldw02,6
      .list
	ldw	(pc+lxofc+ldw02),#n	;DD 31p20q11r20s00
      .nlist
      .pcr_lclx ldw03,6
      .list
	ldw	[lxofc+ldw03],#n	;DD 31p20q11r20s00
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn ldw01,lxofc,6
      .list
	ldw	ldw01(pc),#n		;DD 31 22 11 20 00
      .nlist
      .pcr_xtrn ldw02,lxofc,6
      .list
	ldw	(pc+ldw02),#n		;DD 31 22 11 20 00
      .nlist
      .pcr_xtrn ldw03,lxofc,6
      .list
	ldw	[ldw03],#n		;DD 31 22 11 20 00
      .nlist
    .else
      .pcr_lclx ldw01,6
      .list
	ldw	lxofc+ldw01(pc),#n	;DD 31 22 11 20 00
      .nlist
      .pcr_lclx ldw02,6
      .list
	ldw	(pc+lxofc+ldw02),#n	;DD 31 22 11 20 00
      .nlist
      .pcr_lclx ldw03,6
      .list
	ldw	[lxofc+ldw03],#n	;DD 31 22 11 20 00
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	ldw	lxoff(pc),#n		;DD 31p20q11 20 00
	ldw	(pc+lxoff),#n		;DD 31p20q11 20 00
	ldw	[lxoff],#n		;DD 31p20q11 20 00
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc,6
      .list
	ldw	pcr_ofst(pc),#n		;DD 31 22 11 20 00
      .nlist
	.pcr_ofst lxofc,6
      .list
	ldw	(pc+pcr_ofst),#n	;DD 31 22 11 20 00
      .nlist
	.pcr_ofst lxofc,6
      .list
	ldw	[pcr_ofst],#n		;DD 31 22 11 20 00
    .nlist
  .endif
.list  ; end<--
	ldw	[.+6],#nnc		;DD 31 00 00 84 05

	;***********************************************************
	;  p. 5-89     two immediates handled above
	.z280
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ldw	hl,(daddr)		;2Ar00s00
	ldw	ix,(daddr)		;DD 2Ar00s00
	ldw	iy,(daddr)		;FD 2Ar00s00
	ldw	hl,sxoff(ix)		;ED 2Cr00s00
	ldw	hl,(ix+sxoff)		;ED 2Cr00s00
	ldw	hl,sxoff(iy)		;ED 34r00s00
	ldw	hl,(iy+sxoff)		;ED 34r00s00
	ldw	hl,sxoff(hl)		;ED 3Cr00s00
	ldw	hl,(hl+sxoff)		;ED 3Cr00s00
	ldw	hl,sxoff(sp)		;ED 04r00s00
	ldw	hl,(sp+sxoff)		;ED 04r00s00
	ldw	hl,lxoff(ix)		;ED 2Cr00s00
	ldw	hl,(ix+lxoff)		;ED 2Cr00s00
	ldw	hl,lxoff(iy)		;ED 34r00s00
	ldw	hl,(iy+lxoff)		;ED 34r00s00
	ldw	hl,lxoff(hl)		;ED 3Cr00s00
	ldw	hl,(hl+lxoff)		;ED 3Cr00s00
	ldw	hl,lxoff(sp)		;ED 04r00s00
	ldw	hl,(sp+lxoff)		;ED 04r00s00
	ldw	ix,sxoff(ix)		;DD ED 2Cr00s00
	ldw	ix,(ix+sxoff)		;DD ED 2Cr00s00
	ldw	ix,sxoff(iy)		;DD ED 34r00s00
	ldw	ix,(iy+sxoff)		;DD ED 34r00s00
	ldw	ix,sxoff(hl)		;DD ED 3Cr00s00
	ldw	ix,(hl+sxoff)		;DD ED 3Cr00s00
	ldw	ix,sxoff(sp)		;DD ED 04r00s00
	ldw	ix,(sp+sxoff)		;DD ED 04r00s00
	ldw	ix,lxoff(ix)		;DD ED 2Cr00s00
	ldw	ix,(ix+lxoff)		;DD ED 2Cr00s00
	ldw	ix,lxoff(iy)		;DD ED 34r00s00
	ldw	ix,(iy+lxoff)		;DD ED 34r00s00
	ldw	ix,lxoff(hl)		;DD ED 3Cr00s00
	ldw	ix,(hl+lxoff)		;DD ED 3Cr00s00
	ldw	ix,lxoff(sp)		;DD ED 04r00s00
	ldw	ix,lxoff(sp)		;DD ED 04r00s00
	ldw	ix,(sp+lxoff)		;DD ED 04r00s00
	ldw	iy,sxoff(ix)		;FD ED 2Cr00s00
	ldw	iy,(ix+sxoff)		;FD ED 2Cr00s00
	ldw	iy,sxoff(iy)		;FD ED 34r00s00
	ldw	iy,(iy+sxoff)		;FD ED 34r00s00
	ldw	iy,sxoff(hl)		;FD ED 3Cr00s00
	ldw	iy,(hl+sxoff)		;FD ED 3Cr00s00
	ldw	iy,sxoff(sp)		;FD ED 04r00s00
	ldw	iy,(sp+sxoff)		;FD ED 04r00s00
	ldw	iy,(ix+lxoff)		;FD ED 2Cr00s00
	ldw	iy,lxoff(ix)		;FD ED 2Cr00s00
	ldw	iy,lxoff(iy)		;FD ED 34r00s00
	ldw	iy,(iy+lxoff)		;FD ED 34r00s00
	ldw	iy,lxoff(hl)		;FD ED 3Cr00s00
	ldw	iy,(hl+lxoff)		;FD ED 3Cr00s00
	ldw	iy,lxoff(sp)		;FD ED 04r00s00
	ldw	iy,(sp+lxoff)		;FD ED 04r00s00
      .nlist
    .else
      .list
	ldw	hl,(daddr)		;2Ar44s33
	ldw	ix,(daddr)		;DD 2Ar44s33
	ldw	iy,(daddr)		;FD 2Ar44s33
	ldw	hl,sxoff(ix)		;ED 2Cr55s00
	ldw	hl,(ix+sxoff)		;ED 2Cr55s00
	ldw	hl,sxoff(iy)		;ED 34r55s00
	ldw	hl,(iy+sxoff)		;ED 34r55s00
	ldw	hl,sxoff(hl)		;ED 3Cr55s00
	ldw	hl,(hl+sxoff)		;ED 3Cr55s00
	ldw	hl,sxoff(sp)		;ED 04r55s00
	ldw	hl,(sp+sxoff)		;ED 04r55s00
	ldw	hl,lxoff(ix)		;ED 2Cr22s11
	ldw	hl,(ix+lxoff)		;ED 2Cr22s11
	ldw	hl,lxoff(iy)		;ED 34r22s11
	ldw	hl,(iy+lxoff)		;ED 34r22s11
	ldw	hl,lxoff(hl)		;ED 3Cr22s11
	ldw	hl,(hl+lxoff)		;ED 3Cr22s11
	ldw	hl,lxoff(sp)		;ED 04r22s11
	ldw	hl,(sp+lxoff)		;ED 04r22s11
	ldw	ix,sxoff(ix)		;DD ED 2Cr55s00
	ldw	ix,(ix+sxoff)		;DD ED 2Cr55s00
	ldw	ix,sxoff(iy)		;DD ED 34r55s00
	ldw	ix,(iy+sxoff)		;DD ED 34r55s00
	ldw	ix,sxoff(hl)		;DD ED 3Cr55s00
	ldw	ix,(hl+sxoff)		;DD ED 3Cr55s00
	ldw	ix,sxoff(sp)		;DD ED 04r55s00
	ldw	ix,(sp+sxoff)		;DD ED 04r55s00
	ldw	ix,lxoff(ix)		;DD ED 2Cr22s11
	ldw	ix,(ix+lxoff)		;DD ED 2Cr22s11
	ldw	ix,lxoff(iy)		;DD ED 34r22s11
	ldw	ix,(iy+lxoff)		;DD ED 34r22s11
	ldw	ix,lxoff(hl)		;DD ED 3Cr22s11
	ldw	ix,(hl+lxoff)		;DD ED 3Cr22s11
	ldw	ix,lxoff(sp)		;DD ED 04r22s11
	ldw	ix,lxoff(sp)		;DD ED 04r22s11
	ldw	ix,(sp+lxoff)		;DD ED 04r22s11
	ldw	iy,sxoff(ix)		;FD ED 2Cr55s00
	ldw	iy,(ix+sxoff)		;FD ED 2Cr55s00
	ldw	iy,sxoff(iy)		;FD ED 34r55s00
	ldw	iy,(iy+sxoff)		;FD ED 34r55s00
	ldw	iy,sxoff(hl)		;FD ED 3Cr55s00
	ldw	iy,(hl+sxoff)		;FD ED 3Cr55s00
	ldw	iy,sxoff(sp)		;FD ED 04r55s00
	ldw	iy,(sp+sxoff)		;FD ED 04r55s00
	ldw	iy,(ix+lxoff)		;FD ED 2Cr22s11
	ldw	iy,lxoff(ix)		;FD ED 2Cr22s11
	ldw	iy,lxoff(iy)		;FD ED 34r22s11
	ldw	iy,(iy+lxoff)		;FD ED 34r22s11
	ldw	iy,lxoff(hl)		;FD ED 3Cr22s11
	ldw	iy,(hl+lxoff)		;FD ED 3Cr22s11
	ldw	iy,lxoff(sp)		;FD ED 04r22s11
	ldw	iy,(sp+lxoff)		;FD ED 04r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ldw	hl,(daddr)		;2A 44 33
	ldw	ix,(daddr)		;DD 2A 44 33
	ldw	iy,(daddr)		;FD 2A 44 33
    .nlist
    .ifeq _X_R
      .list
	ldw	hl,sxoff(ix)		;ED 2C 55 00
	ldw	hl,(ix+sxoff)		;ED 2C 55 00
	ldw	hl,sxoff(iy)		;ED 34 55 00
	ldw	hl,(iy+sxoff)		;ED 34 55 00
      .nlist
    .else
      .list
;	ldw	hl,sxoff(ix)		;ED 2C 55 00
;	ldw	hl,(ix+sxoff)		;ED 2C 55 00
;	ldw	hl,sxoff(iy)		;ED 34 55 00
;	ldw	hl,(iy+sxoff)		;ED 34 55 00
	ldw	hl,sxoff(ix)		;DD ED 26 55
	ldw	hl,(ix+sxoff)		;DD ED 26 55
	ldw	hl,sxoff(iy)		;FD ED 26 55
	ldw	hl,(iy+sxoff)		;FD ED 26 55
      .nlist
    .endif
    .list
	ldw	hl,sxoff(hl)		;ED 3C 55 00
	ldw	hl,(hl+sxoff)		;ED 3C 55 00
	ldw	hl,sxoff(sp)		;ED 04 55 00
	ldw	hl,(sp+sxoff)		;ED 04 55 00
	ldw	hl,lxoff(ix)		;ED 2C 22 11
	ldw	hl,(ix+lxoff)		;ED 2C 22 11
	ldw	hl,lxoff(iy)		;ED 34 22 11
	ldw	hl,(iy+lxoff)		;ED 34 22 11
	ldw	hl,lxoff(hl)		;ED 3C 22 11
	ldw	hl,(hl+lxoff)		;ED 3C 22 11
	ldw	hl,lxoff(sp)		;ED 04 22 11
	ldw	hl,(sp+lxoff)		;ED 04 22 11
	ldw	ix,sxoff(ix)		;DD ED 2C 55 00
	ldw	ix,(ix+sxoff)		;DD ED 2C 55 00
	ldw	ix,sxoff(iy)		;DD ED 34 55 00
	ldw	ix,(iy+sxoff)		;DD ED 34 55 00
	ldw	ix,sxoff(hl)		;DD ED 3C 55 00
	ldw	ix,(hl+sxoff)		;DD ED 3C 55 00
	ldw	ix,sxoff(sp)		;DD ED 04 55 00
	ldw	ix,(sp+sxoff)		;DD ED 04 55 00
	ldw	ix,lxoff(ix)		;DD ED 2C 22 11
	ldw	ix,(ix+lxoff)		;DD ED 2C 22 11
	ldw	ix,lxoff(iy)		;DD ED 34 22 11
	ldw	ix,(iy+lxoff)		;DD ED 34 22 11
	ldw	ix,lxoff(hl)		;DD ED 3C 22 11
	ldw	ix,(hl+lxoff)		;DD ED 3C 22 11
	ldw	ix,lxoff(sp)		;DD ED 04 22 11
	ldw	ix,lxoff(sp)		;DD ED 04 22 11
	ldw	ix,(sp+lxoff)		;DD ED 04 22 11
	ldw	iy,sxoff(ix)		;FD ED 2C 55 00
	ldw	iy,(ix+sxoff)		;FD ED 2C 55 00
	ldw	iy,sxoff(iy)		;FD ED 34 55 00
	ldw	iy,(iy+sxoff)		;FD ED 34 55 00
	ldw	iy,sxoff(hl)		;FD ED 3C 55 00
	ldw	iy,(hl+sxoff)		;FD ED 3C 55 00
	ldw	iy,sxoff(sp)		;FD ED 04 55 00
	ldw	iy,(sp+sxoff)		;FD ED 04 55 00
	ldw	iy,lxoff(ix)		;FD ED 2C 22 11
	ldw	iy,(ix+lxoff)		;FD ED 2C 22 11
	ldw	iy,lxoff(iy)		;FD ED 34 22 11
	ldw	iy,(iy+lxoff)		;FD ED 34 22 11
	ldw	iy,lxoff(hl)		;FD ED 3C 22 11
	ldw	iy,(hl+lxoff)		;FD ED 3C 22 11
	ldw	iy,lxoff(sp)		;FD ED 04 22 11
	ldw	iy,(sp+lxoff)		;FD ED 04 22 11
    .nlist
  .endif
.list  ; end<--
	ldw	hl,(sp)			;ED 04 00 00
	ldw	ix,(sp)			;DD ED 04 00 00
	ldw	iy,(sp)			;FD ED 04 00 00
	ldw	hl,(hl+ix)		;ED 0C
	ldw	hl,(hl+iy)		;ED 14
	ldw	hl,(ix+iy)		;ED 1C
	ldw	ix,(hl+ix)		;DD ED 0C
	ldw	ix,(hl+iy)		;DD ED 14
	ldw	ix,(ix+iy)		;DD ED 1C
	ldw	iy,(hl+ix)		;FD ED 0C
	ldw	iy,(hl+iy)		;FD ED 14
	ldw	iy,(ix+iy)		;FD ED 1C

.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn ldw04,lxofc
      .list
	ldw	hl,ldw04(pc)		;ED 24p00q00
      .nlist
      .pcr_xtrn ldw05,lxofc
      .list
	ldw	hl,(pc+ldw05)		;ED 24p00q00
      .nlist
      .pcr_xtrn ldw06,lxofc
      .list
	ldw	hl,[ldw06]		;ED 24p00q00
      .nlist
    .else
      .pcr_lclx ldw04
      .list
	ldw	hl,lxofc+ldw04(pc)	;ED 24p22q11
      .nlist
      .pcr_lclx ldw05
      .list
	ldw	hl,(pc+lxofc+ldw05)	;ED 24p22q11
      .nlist
      .pcr_lclx ldw06
      .list
	ldw	hl,[lxofc+ldw06]	;ED 24p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn ldw04,lxofc
      .list
	ldw	hl,ldw04(pc)		;ED 24 22 11
      .nlist
      .pcr_xtrn ldw05,lxofc
      .list
	ldw	hl,(pc+ldw05)		;ED 24 22 11
      .nlist
      .pcr_xtrn ldw06,lxofc
      .list
	ldw	hl,[ldw06]		;ED 24 22 11
      .nlist
    .else
      .pcr_lclx ldw04
      .list
	ldw	hl,lxofc+ldw04(pc)	;ED 24 22 11
      .nlist
      .pcr_lclx ldw05
      .list
	ldw	hl,(pc+lxofc+ldw05)	;ED 24 22 11
      .nlist
      .pcr_lclx ldw06
      .list
	ldw	hl,[lxofc+ldw06]	;ED 24 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	ldw	hl,lxoff(pc)		;ED 24p22q11
	ldw	hl,(pc+lxoff)		;ED 24p22q11
	ldw	hl,[lxoff]		;ED 24p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc
      .list
	ldw	hl,pcr_ofst(pc)		;ED 24 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	ldw	hl,(pc+pcr_ofst)	;ED 24 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	ldw	hl,[pcr_ofst]		;ED 24 22 11
    .nlist
  .endif
.list  ; end<--
	ldw	hl,[.+32]		;ED 24 1C 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn ldw07,lxofc,5
      .list
	ldw	ix,ldw07(pc)		;DD ED 24p00q00
      .nlist
      .pcr_xtrn ldw08,lxofc,5
      .list
	ldw	ix,(pc+ldw08)		;DD ED 24p00q00
      .nlist
      .pcr_xtrn ldw09,lxofc,5
      .list
	ldw	ix,[ldw09]		;DD ED 24p00q00
      .nlist
    .else
      .pcr_lclx ldw07,5
      .list
	ldw	ix,lxofc+ldw07(pc)	;DD ED 24p22q11
      .nlist
      .pcr_lclx ldw08,5
      .list
	ldw	ix,(pc+lxofc+ldw08)	;DD ED 24p22q11
      .nlist
      .pcr_lclx ldw09,5
      .list
	ldw	ix,[lxofc+ldw09]	;DD ED 24p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn ldw07,lxofc,5
      .list
	ldw	ix,ldw07(pc)		;DD ED 24 22 11
      .nlist
      .pcr_xtrn ldw08,lxofc,5
      .list
	ldw	ix,(pc+ldw08)		;DD ED 24 22 11
      .nlist
      .pcr_xtrn ldw09,lxofc,5
      .list
	ldw	ix,[ldw09]		;DD ED 24 22 11
      .nlist
    .else
      .pcr_lclx ldw07,5
      .list
	ldw	ix,lxofc+ldw07(pc)	;DD ED 24 22 11
      .nlist
      .pcr_lclx ldw08,5
      .list
	ldw	ix,(pc+lxofc+ldw08)	;DD ED 24 22 11
      .nlist
      .pcr_lclx ldw09,5
      .list
	ldw	ix,[lxofc+ldw09]	;DD ED 24 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	ldw	ix,lxoff(pc)		;DD ED 24p22q11
	ldw	ix,(pc+lxoff)		;DD ED 24p22q11
	ldw	ix,[lxoff]		;DD ED 24p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxoff,5
      .list
	ldw	ix,pcr_ofst(pc)		;DD ED 24 22 11
      .nlist
	.pcr_ofst lxoff,5
      .list
	ldw	ix,(pc+pcr_ofst)	;DD ED 24 22 11
      .nlist
	.pcr_ofst lxoff,5
      .list
	ldw	ix,[pcr_ofst]		;DD ED 24 22 11
    .nlist
  .endif
.list  ; end<--
	ldw	ix,[.+32]		;DD ED 24 1B 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn ldw11,lxofc,5
      .list
	ldw	iy,ldw11(pc)		;FD ED 24p00q00
      .nlist
      .pcr_xtrn ldw12,lxofc,5
      .list
	ldw	iy,(pc+ldw12)		;FD ED 24p00q00
      .nlist
      .pcr_xtrn ldw13,lxofc,5
      .list
	ldw	iy,[ldw13]		;FD ED 24p00q00
      .nlist
    .else
      .pcr_lclx ldw11,5
      .list
	ldw	iy,lxofc+ldw11(pc)	;FD ED 24p22q11
      .nlist
      .pcr_lclx ldw12,5
      .list
	ldw	iy,(pc+lxofc+ldw12)	;FD ED 24p22q11
      .nlist
      .pcr_lclx ldw13,5
      .list
	ldw	iy,[lxofc+ldw13]	;FD ED 24p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn ldw11,lxofc,5
      .list
	ldw	iy,ldw11(pc)		;FD ED 24 22 11
      .nlist
      .pcr_xtrn ldw12,lxofc,5
      .list
	ldw	iy,(pc+ldw12)		;FD ED 24 22 11
      .nlist
      .pcr_xtrn ldw13,lxofc,5
      .list
	ldw	iy,[ldw13]		;FD ED 24 22 11
      .nlist
    .else
      .pcr_lclx ldw11,5
      .list
	ldw	iy,lxofc+ldw11(pc)	;FD ED 24 22 11
      .nlist
      .pcr_lclx ldw12,5
      .list
	ldw	iy,(pc+lxofc+ldw12)	;FD ED 24 22 11
      .nlist
      .pcr_lclx ldw13,5
      .list
	ldw	iy,[lxofc+ldw13]	;FD ED 24 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	ldw	iy,lxoff(pc)		;FD ED 24p22q11
	ldw	iy,(pc+lxoff)		;FD ED 24p22q11
	ldw	iy,[lxoff]		;FD ED 24p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc,5
      .list
	ldw	iy,pcr_ofst(pc)		;FD ED 24 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	ldw	iy,(pc+pcr_ofst)	;FD ED 24 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	ldw	iy,[pcr_ofst]		;FD ED 24 22 11
    .nlist
  .endif
.list  ; end<--
	ldw	iy,[.+32]		;FD ED 24 1B 00
	;***********************************************************
	;  p. 5-90
	.z280
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ldw	(daddr),hl		;22r00s00
	ldw	(daddr),ix		;DD 22r00s00
	ldw	(daddr),iy		;FD 22r00s00
	ldw	sxoff(ix),hl		;ED 2Dr00s00
	ldw	(ix+sxoff),hl		;ED 2Dr00s00
	ldw	sxoff(iy),hl		;ED 35r00s00
	ldw	(iy+sxoff),hl		;ED 35r00s00
	ldw	sxoff(hl),hl		;ED 3Dr00s00
	ldw	(hl+sxoff),hl		;ED 3Dr00s00
	ldw	sxoff(sp),hl		;ED 05r00s00
	ldw	(sp+sxoff),hl		;ED 05r00s00
	ldw	lxoff(ix),hl		;ED 2Dr00s00
	ldw	(ix+lxoff),hl		;ED 2Dr00s00
	ldw	lxoff(iy),hl		;ED 35r00s00
	ldw	(iy+lxoff),hl		;ED 35r00s00
	ldw	lxoff(hl),hl		;ED 3Dr00s00
	ldw	(hl+lxoff),hl		;ED 3Dr00s00
	ldw	lxoff(sp),hl		;ED 05r00s00
	ldw	(sp+lxoff),hl		;ED 05r00s00
	ldw	sxoff(ix),ix		;DD ED 2Dr00s00
	ldw	(ix+sxoff),ix		;DD ED 2Dr00s00
	ldw	sxoff(iy),ix		;DD ED 35r00s00
	ldw	(iy+sxoff),ix		;DD ED 35r00s00
	ldw	sxoff(hl),ix		;DD ED 3Dr00s00
	ldw	(hl+sxoff),ix		;DD ED 3Dr00s00
	ldw	sxoff(sp),ix		;DD ED 05r00s00
	ldw	(sp+sxoff),ix		;DD ED 05r00s00
 	ldw	lxoff(ix),ix		;DD ED 2Dr00s00
	ldw	(ix+lxoff),ix		;DD ED 2Dr00s00
	ldw	lxoff(iy),ix		;DD ED 35r00s00
	ldw	(iy+lxoff),ix		;DD ED 35r00s00
	ldw	lxoff(hl),ix		;DD ED 3Dr00s00
	ldw	(hl+lxoff),ix		;DD ED 3Dr00s00
	ldw	lxoff(sp),ix		;DD ED 05r00s00
	ldw	(sp+lxoff),ix		;DD ED 05r00s00
	ldw	sxoff(ix),iy		;FD ED 2Dr00s00
	ldw	(ix+sxoff),iy		;FD ED 2Dr00s00
	ldw	sxoff(iy),iy		;FD ED 35r00s00
	ldw	(iy+sxoff),iy		;FD ED 35r00s00
	ldw	sxoff(hl),iy		;FD ED 3Dr00s00
	ldw	(hl+sxoff),iy		;FD ED 3Dr00s00
	ldw	sxoff(sp),iy		;FD ED 05r00s00
	ldw	(sp+sxoff),iy		;FD ED 05r00s00
	ldw	lxoff(ix),iy		;FD ED 2Dr00s00
	ldw	(ix+lxoff),iy		;FD ED 2Dr00s00
	ldw	lxoff(iy),iy		;FD ED 35r00s00
	ldw	(iy+lxoff),iy		;FD ED 35r00s00
	ldw	lxoff(hl),iy		;FD ED 3Dr00s00
	ldw	(hl+lxoff),iy		;FD ED 3Dr00s00
	ldw	lxoff(sp),iy		;FD ED 05r00s00
	ldw	(sp+lxoff),iy		;FD ED 05r00s00
      .nlist
    .else
      .list
	ldw	(daddr),hl		;22r44s33
	ldw	(daddr),ix		;DD 22r44s33
	ldw	(daddr),iy		;FD 22r44s33
	ldw	sxoff(ix),hl		;ED 2Dr55s00
	ldw	(ix+sxoff),hl		;ED 2Dr55s00
	ldw	sxoff(iy),hl		;ED 35r55s00
	ldw	(iy+sxoff),hl		;ED 35r55s00
	ldw	sxoff(hl),hl		;ED 3Dr55s00
	ldw	(hl+sxoff),hl		;ED 3Dr55s00
	ldw	sxoff(sp),hl		;ED 05r55s00
	ldw	(sp+sxoff),hl		;ED 05r55s00
	ldw	lxoff(ix),hl		;ED 2Dr22s11
	ldw	(ix+lxoff),hl		;ED 2Dr22s11
	ldw	lxoff(iy),hl		;ED 35r22s11
	ldw	(iy+lxoff),hl		;ED 35r22s11
	ldw	lxoff(hl),hl		;ED 3Dr22s11
	ldw	(hl+lxoff),hl		;ED 3Dr22s11
	ldw	lxoff(sp),hl		;ED 05r22s11
	ldw	(sp+lxoff),hl		;ED 05r22s11
	ldw	sxoff(ix),ix		;DD ED 2Dr55s00
	ldw	(ix+sxoff),ix		;DD ED 2Dr55s00
	ldw	sxoff(iy),ix		;DD ED 35r55s00
	ldw	(iy+sxoff),ix		;DD ED 35r55s00
	ldw	sxoff(hl),ix		;DD ED 3Dr55s00
	ldw	(hl+sxoff),ix		;DD ED 3Dr55s00
	ldw	sxoff(sp),ix		;DD ED 05r55s00
	ldw	(sp+sxoff),ix		;DD ED 05r55s00
 	ldw	lxoff(ix),ix		;DD ED 2Dr22s11
	ldw	(ix+lxoff),ix		;DD ED 2Dr22s11
	ldw	lxoff(iy),ix		;DD ED 35r22s11
	ldw	(iy+lxoff),ix		;DD ED 35r22s11
	ldw	lxoff(hl),ix		;DD ED 3Dr22s11
	ldw	(hl+lxoff),ix		;DD ED 3Dr22s11
	ldw	lxoff(sp),ix		;DD ED 05r22s11
	ldw	(sp+lxoff),ix		;DD ED 05r22s11
	ldw	sxoff(ix),iy		;FD ED 2Dr55s00
	ldw	(ix+sxoff),iy		;FD ED 2Dr55s00
	ldw	sxoff(iy),iy		;FD ED 35r55s00
	ldw	(iy+sxoff),iy		;FD ED 35r55s00
	ldw	sxoff(hl),iy		;FD ED 3Dr55s00
	ldw	(hl+sxoff),iy		;FD ED 3Dr55s00
	ldw	sxoff(sp),iy		;FD ED 05r55s00
	ldw	(sp+sxoff),iy		;FD ED 05r55s00
	ldw	lxoff(ix),iy		;FD ED 2Dr22s11
	ldw	(ix+lxoff),iy		;FD ED 2Dr22s11
	ldw	lxoff(iy),iy		;FD ED 35r22s11
	ldw	(iy+lxoff),iy		;FD ED 35r22s11
	ldw	lxoff(hl),iy		;FD ED 3Dr22s11
	ldw	(hl+lxoff),iy		;FD ED 3Dr22s11
	ldw	lxoff(sp),iy		;FD ED 05r22s11
	ldw	(sp+lxoff),iy		;FD ED 05r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ldw	(daddr),hl		;22 44 33
	ldw	(daddr),ix		;DD 22 44 33
	ldw	(daddr),iy		;FD 22 44 33
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	ldw	sxoff(ix),hl		;ED 2D 55 00
	ldw	(ix+sxoff),hl		;ED 2D 55 00
	ldw	sxoff(iy),hl		;ED 35 55 00
	ldw	(iy+sxoff),hl		;ED 35 55 00
      .nlist
    .else				; (.con/.lst) or (.con/.rst)
      .list
;	ldw	sxoff(ix),hl		;ED 2D 55 00
;	ldw	(ix+sxoff),hl		;ED 2D 55 00
;	ldw	sxoff(iy),hl		;ED 35 55 00
;	ldw	(iy+sxoff),hl		;ED 35 55 00
	ldw	sxoff(ix),hl		;DD ED 2E 55
	ldw	(ix+sxoff),hl		;DD ED 2E 55
	ldw	sxoff(iy),hl		;FD ED 2E 55
	ldw	(iy+sxoff),hl		;FD ED 2E 55
      .nlist
    .endif
    .list
	ldw	sxoff(hl),hl		;ED 3D 55 00
	ldw	(hl+sxoff),hl		;ED 3D 55 00
	ldw	sxoff(sp),hl		;ED 05 55 00
	ldw	(sp+sxoff),hl		;ED 05 55 00
	ldw	lxoff(ix),hl		;ED 2D 22 11
	ldw	(ix+lxoff),hl		;ED 2D 22 11
	ldw	lxoff(iy),hl		;ED 35 22 11
	ldw	(iy+lxoff),hl		;ED 35 22 11
	ldw	lxoff(hl),hl		;ED 3D 22 11
	ldw	(hl+lxoff),hl		;ED 3D 22 11
	ldw	lxoff(sp),hl		;ED 05 22 11
	ldw	(sp+lxoff),hl		;ED 05 22 11
	ldw	sxoff(ix),ix		;DD ED 2D 55 00
	ldw	(ix+sxoff),ix		;DD ED 2D 55 00
	ldw	sxoff(iy),ix		;DD ED 35 55 00
	ldw	(iy+sxoff),ix		;DD ED 35 55 00
	ldw	sxoff(hl),ix		;DD ED 3D 55 00
	ldw	(hl+sxoff),ix		;DD ED 3D 55 00
	ldw	sxoff(sp),ix		;DD ED 05 55 00
	ldw	(sp+sxoff),ix		;DD ED 05 55 00
	ldw	lxoff(ix),ix		;DD ED 2D 22 11
	ldw	(ix+lxoff),ix		;DD ED 2D 22 11
	ldw	lxoff(iy),ix		;DD ED 35 22 11
	ldw	(iy+lxoff),ix		;DD ED 35 22 11
	ldw	lxoff(hl),ix		;DD ED 3D 22 11
	ldw	(hl+lxoff),ix		;DD ED 3D 22 11
	ldw	lxoff(sp),ix		;DD ED 05 22 11
	ldw	(sp+lxoff),ix		;DD ED 05 22 11
	ldw	sxoff(ix),iy		;FD ED 2D 55 00
	ldw	(ix+sxoff),iy		;FD ED 2D 55 00
	ldw	sxoff(iy),iy		;FD ED 35 55 00
	ldw	(iy+sxoff),iy		;FD ED 35 55 00
	ldw	sxoff(hl),iy		;FD ED 3D 55 00
	ldw	(hl+sxoff),iy		;FD ED 3D 55 00
	ldw	sxoff(sp),iy		;FD ED 05 55 00
	ldw	(sp+sxoff),iy		;FD ED 05 55 00
	ldw	lxoff(ix),iy		;FD ED 2D 22 11
	ldw	(ix+lxoff),iy		;FD ED 2D 22 11
	ldw	lxoff(iy),iy		;FD ED 35 22 11
	ldw	(iy+lxoff),iy		;FD ED 35 22 11
	ldw	lxoff(hl),iy		;FD ED 3D 22 11
	ldw	(hl+lxoff),iy		;FD ED 3D 22 11
	ldw	lxoff(sp),iy		;FD ED 05 22 11
	ldw	(sp+lxoff),iy		;FD ED 05 22 11
    .nlist
  .endif
.list  ; end<--

	ldw	(sp),hl			;ED 05 00 00
	ldw	(sp),ix			;DD ED 05 00 00
	ldw	(sp),iy			;FD ED 05 00 00
	ldw	(hl+ix),iy		;FD ED 0D
	ldw	(hl+iy),iy		;FD ED 15
	ldw	(ix+iy),iy		;FD ED 1D
	ldw	(hl+ix),ix		;DD ED 0D
	ldw	(hl+iy),ix		;DD ED 15
	ldw	(ix+iy),ix		;DD ED 1D
	ldw	(hl+ix),hl		;ED 0D
	ldw	(hl+iy),hl		;ED 15
	ldw	(ix+iy),hl		;ED 1D

.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn ldw14,lxofc
      .list
	ldw	ldw14(pc),hl		;ED 25p00q00
      .nlist
      .pcr_xtrn ldw15,lxofc
      .list
	ldw	(pc+ldw15),hl		;ED 25p00q00
      .nlist
      .pcr_xtrn ldw16,lxofc
      .list
	ldw	[ldw16],hl		;ED 25p00q00
      .nlist
    .else
      .pcr_lclx ldw14
      .list
	ldw	lxofc+ldw14(pc),hl	;ED 25p22q11
      .nlist
      .pcr_lclx ldw15
      .list
	ldw	(pc+lxofc+ldw15),hl	;ED 25p22q11
      .nlist
      .pcr_lclx ldw16
      .list
	ldw	[lxofc+ldw16],hl	;ED 25p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn ldw14,lxofc
      .list
	ldw	ldw14(pc),hl		;ED 25 22 11
      .nlist
      .pcr_xtrn ldw15,lxofc
      .list
	ldw	(pc+ldw15),hl		;ED 25 22 11
      .nlist
      .pcr_xtrn ldw16,lxofc
      .list
	ldw	[ldw16],hl		;ED 25 22 11
      .nlist
    .else
      .pcr_lclx ldw14
      .list
	ldw	lxofc+ldw14(pc),hl	;ED 25 22 11
      .nlist
      .pcr_lclx ldw15
      .list
	ldw	(pc+lxofc+ldw15),hl	;ED 25 22 11
      .nlist
      .pcr_lclx ldw16
      .list
	ldw	[lxofc+ldw16],hl	;ED 25 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	ldw	lxoff(pc),hl		;ED 25p22q11
	ldw	(pc+lxoff),hl		;ED 25p22q11
	ldw	[lxoff],hl		;ED 25p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc
      .list
	ldw	pcr_ofst(pc),hl		;ED 25 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	ldw	(pc+pcr_ofst),hl	;ED 25 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	ldw	[pcr_ofst],hl		;ED 25 22 11
    .nlist
  .endif
.list  ; end<--
	ldw	[.+32],hl		;ED 25 1C 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn ldw17,lxofc,5
      .list
	ldw	ldw17(pc),ix		;DD ED 25p00q00
      .nlist
      .pcr_xtrn ldw18,lxofc,5
      .list
	ldw	(pc+ldw18),ix		;DD ED 25p00q00
      .nlist
      .pcr_xtrn ldw19,lxofc,5
      .list
	ldw	[ldw19],ix		;DD ED 25p00q00
      .nlist
    .else
      .pcr_lclx ldw17,5
      .list
	ldw	lxofc+ldw17(pc),ix	;DD ED 25p22q11
      .nlist
      .pcr_lclx ldw18,5
      .list
	ldw	(pc+lxofc+ldw18),ix	;DD ED 25p22q11
      .nlist
      .pcr_lclx ldw19,5
      .list
	ldw	[lxofc+ldw19],ix	;DD ED 25p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn ldw17,lxofc,5
      .list
	ldw	ldw17(pc),ix		;DD ED 25 22 11
      .nlist
      .pcr_xtrn ldw18,lxofc,5
      .list
	ldw	(pc+ldw18),ix		;DD ED 25 22 11
      .nlist
      .pcr_xtrn ldw19,lxofc,5
      .list
	ldw	[ldw19],ix		;DD ED 25 22 11
      .nlist
    .else
      .pcr_lclx ldw17,5
      .list
	ldw	lxofc+ldw17(pc),ix	;DD ED 25 22 11
      .nlist
      .pcr_lclx ldw18,5
      .list
	ldw	(pc+lxofc+ldw18),ix	;DD ED 25 22 11
      .nlist
      .pcr_lclx ldw19,5
      .list
	ldw	[lxofc+ldw19],ix	;DD ED 25 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	ldw	lxoff(pc),ix		;DD ED 25p22q11
	ldw	(pc+lxoff),ix		;DD ED 25p22q11
	ldw	[lxoff],ix		;DD ED 25p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc,5
      .list
	ldw	pcr_ofst(pc),ix		;DD ED 25 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	ldw	(pc+pcr_ofst),ix	;DD ED 25 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	ldw	[pcr_ofst],ix		;DD ED 25 22 11
    .nlist
  .endif
.list  ; end<--
	ldw	[.+32],ix		;DD ED 25 1B 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn ldw21,lxofc,5
      .list
	ldw	ldw21(pc),iy		;FD ED 25p00q00
      .nlist
      .pcr_xtrn ldw22,lxofc,5
      .list
	ldw	(pc+ldw22),iy		;FD ED 25p00q00
      .nlist
      .pcr_xtrn ldw23,lxofc,5
      .list
	ldw	[ldw23],iy		;FD ED 25p00q00
      .nlist
    .else
      .pcr_lclx ldw21,5
      .list
	ldw	lxofc+ldw21(pc),iy	;FD ED 25p22q11
      .nlist
      .pcr_lclx ldw22,5
      .list
	ldw	(pc+lxofc+ldw22),iy	;FD ED 25p22q11
      .nlist
      .pcr_lclx ldw23,5
      .list
	ldw	[lxofc+ldw23],iy	;FD ED 25p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn ldw21,lxofc,5
      .list
	ldw	ldw21(pc),iy		;FD ED 25 22 11
      .nlist
      .pcr_xtrn ldw22,lxofc,5
      .list
	ldw	(pc+ldw22),iy		;FD ED 25 22 11
      .nlist
      .pcr_xtrn ldw23,lxofc,5
      .list
	ldw	[ldw23],iy		;FD ED 25 22 11
      .nlist
    .else
      .pcr_lclx ldw21,5
      .list
	ldw	lxofc+ldw21(pc),iy	;FD ED 25 22 11
      .nlist
      .pcr_lclx ldw22,5
      .list
	ldw	(pc+lxofc+ldw22),iy	;FD ED 25 22 11
      .nlist
      .pcr_lclx ldw23,5
      .list
	ldw	[lxofc+ldw23],iy	;FD ED 25 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	ldw	lxoff(pc),iy		;FD ED 25p22q11
	ldw	(pc+lxoff),iy		;FD ED 25p22q11
	ldw	[lxoff],iy		;FD ED 25p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc,5
      .list
	ldw	pcr_ofst(pc),iy		;FD ED 25 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	ldw	(pc+pcr_ofst),iy	;FD ED 25 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	ldw	[pcr_ofst],iy		;FD ED 25 22 11
    .nlist
  .endif
.list  ; end<--
	ldw	[.+32],iy		;FD ED 25 1B 00
	;***********************************************************
	;  p. 5-91
	.z280
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ldw	bc,#nn			;01r00s00
	ldw	de,#nn			;11r00s00
	ldw	hl,#nn			;21r00s00
	ldw	sp,#nn			;31r00s00
      .nlist
    .else
      .list
	ldw	bc,#nn			;01r84s05
	ldw	de,#nn			;11r84s05
	ldw	hl,#nn			;21r84s05
	ldw	sp,#nn			;31r84s05
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ldw	bc,#nn			;01 84 05
	ldw	de,#nn			;11 84 05
	ldw	hl,#nn			;21 84 05
	ldw	sp,#nn			;31 84 05
    .nlist
  .endif
.list  ; end<--
	ldw	bc,(hl)			;ED 06
	ldw	de,(hl)			;ED 16
	ldw	hl,(hl)			;ED 26
	ldw	sp,(hl)			;ED 36
	ldw	bc,(ix)			;DD ED 06 00
	ldw	de,(ix)			;DD ED 16 00
	ldw	hl,(ix)			;DD ED 26 00
	ldw	sp,(ix)			;DD ED 36 00
	ldw	bc,(iy)			;FD ED 06 00
	ldw	de,(iy)			;FD ED 16 00
	ldw	hl,(iy)			;FD ED 26 00
	ldw	sp,(iy)			;FD ED 36 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ldw	bc,(daddr)		;ED 4Br00s00
	ldw	de,(daddr)		;ED 5Br00s00
	ldw	hl,(daddr)		;2Ar00s00
	ldw	sp,(daddr)		;ED 7Br00s00
	ldw	bc,sxoff(ix)		;DD ED 06r00
	ldw	bc,(ix+sxoff)		;DD ED 06r00
	ldw	bc,sxoff(iy)		;FD ED 06r00
	ldw	bc,(iy+sxoff)		;FD ED 06r00
	ldw	de,sxoff(ix)		;DD ED 16r00
	ldw	de,(ix+sxoff)		;DD ED 16r00
	ldw	de,sxoff(iy)		;FD ED 16r00
	ldw	de,(iy+sxoff)		;FD ED 16r00
	ldw	hl,sxoff(ix)		;ED 2Cr00s00
	ldw	hl,(ix+sxoff)		;ED 2Cr00s00
	ldw	hl,sxoff(iy)		;ED 34r00s00
	ldw	hl,(iy+sxoff)		;ED 34r00s00
	ldw	sp,sxoff(ix)		;DD ED 36r00
	ldw	sp,(ix+sxoff)		;DD ED 36r00
	ldw	sp,sxoff(iy)		;FD ED 36r00
	ldw	sp,(iy+sxoff)		;FD ED 36r00
      .nlist
    .else
      .list
	ldw	bc,(daddr)		;ED 4Br44s33
	ldw	de,(daddr)		;ED 5Br44s33
	ldw	hl,(daddr)		;2Ar44s33
	ldw	sp,(daddr)		;ED 7Br44s33
	ldw	bc,sxoff(ix)		;DD ED 06r55
	ldw	bc,(ix+sxoff)		;DD ED 06r55
	ldw	bc,sxoff(iy)		;FD ED 06r55
	ldw	bc,(iy+sxoff)		;FD ED 06r55
	ldw	de,sxoff(ix)		;DD ED 16r55
	ldw	de,(ix+sxoff)		;DD ED 16r55
	ldw	de,sxoff(iy)		;FD ED 16r55
	ldw	de,(iy+sxoff)		;FD ED 16r55
	ldw	hl,sxoff(ix)		;ED 2Cr55s00
	ldw	hl,(ix+sxoff)		;ED 2Cr55s00
	ldw	hl,sxoff(iy)		;ED 34r55s00
	ldw	hl,(iy+sxoff)		;ED 34r55s00
	ldw	sp,sxoff(ix)		;DD ED 36r55
	ldw	sp,(ix+sxoff)		;DD ED 36r55
	ldw	sp,sxoff(iy)		;FD ED 36r55
	ldw	sp,(iy+sxoff)		;FD ED 36r55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ldw	bc,(daddr)		;ED 4B 44 33
	ldw	de,(daddr)		;ED 5B 44 33
	ldw	hl,(daddr)		;2A 44 33
	ldw	sp,(daddr)		;ED 7B 44 33
	ldw	bc,sxoff(ix)		;DD ED 06 55
	ldw	bc,(ix+sxoff)		;DD ED 06 55
	ldw	bc,sxoff(iy)		;FD ED 06 55
	ldw	bc,(iy+sxoff)		;FD ED 06 55
	ldw	de,sxoff(ix)		;DD ED 16 55
	ldw	de,(ix+sxoff)		;DD ED 16 55
	ldw	de,sxoff(iy)		;FD ED 16 55
	ldw	de,(iy+sxoff)		;FD ED 16 55
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	ldw	hl,sxoff(ix)		;ED 2C 55 00
	ldw	hl,(ix+sxoff)		;ED 2C 55 00
	ldw	hl,sxoff(iy)		;ED 34 55 00
	ldw	hl,(iy+sxoff)		;ED 34 55 00
     .nlist
    .else				; (.con/.lst) or (.con/.rst)
      .list
	ldw	hl,sxoff(ix)		;DD ED 26 55
	ldw	hl,(ix+sxoff)		;DD ED 26 55
	ldw	hl,sxoff(iy)		;FD ED 26 55
	ldw	hl,(iy+sxoff)		;FD ED 26 55
      .nlist
    .endif
    .list
	ldw	sp,sxoff(ix)		;DD ED 36 55
	ldw	sp,(ix+sxoff)		;DD ED 36 55
	ldw	sp,sxoff(iy)		;FD ED 36 55
	ldw	sp,(iy+sxoff)		;FD ED 36 55
    .nlist
  .endif
.list  ; end<--
	ldw	(hl),bc			;ED 0E
	ldw	(hl),de			;ED 1E
	ldw	(hl),hl			;ED 2E
	ldw	(hl),sp			;ED 3E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ldw	(daddr),bc		;ED 43r00s00
	ldw	(daddr),de		;ED 53r00s00
	ldw	(daddr),sp		;ED 73r00s00
	ldw	(daddr),hl		;22r00s00
	ldw	sxoff(ix),bc		;DD ED 0Er00
	ldw	(ix+sxoff),bc		;DD ED 0Er00
	ldw	sxoff(iy),bc		;FD ED 0Er00
	ldw	(iy+sxoff),bc		;FD ED 0Er00
	ldw	sxoff(ix),de		;DD ED 1Er00
	ldw	(ix+sxoff),de		;DD ED 1Er00
	ldw	sxoff(iy),de		;FD ED 1Er00
	ldw	(iy+sxoff),de		;FD ED 1Er00
	ldw	sxoff(ix),hl		;ED 2Dr00s00
	ldw	(ix+sxoff),hl		;ED 2Dr00s00
	ldw	sxoff(iy),hl		;ED 35r00s00
	ldw	(iy+sxoff),hl		;ED 35r00s00
	ldw	sxoff(ix),sp		;DD ED 3Er00
	ldw	(ix+sxoff),sp		;DD ED 3Er00
	ldw	sxoff(iy),sp		;FD ED 3Er00
	ldw	(iy+sxoff),sp		;FD ED 3Er00
      .nlist
    .else
      .list
	ldw	(daddr),bc		;ED 43r44s33
	ldw	(daddr),de		;ED 53r44s33
	ldw	(daddr),sp		;ED 73r44s33
	ldw	(daddr),hl		;22r44s33
	ldw	sxoff(ix),bc		;DD ED 0Er55
	ldw	(ix+sxoff),bc		;DD ED 0Er55
	ldw	sxoff(iy),bc		;FD ED 0Er55
	ldw	(iy+sxoff),bc		;FD ED 0Er55
	ldw	sxoff(ix),de		;DD ED 1Er55
	ldw	(ix+sxoff),de		;DD ED 1Er55
	ldw	sxoff(iy),de		;FD ED 1Er55
	ldw	(iy+sxoff),de		;FD ED 1Er55
	ldw	sxoff(ix),hl		;ED 2Dr55s00
	ldw	(ix+sxoff),hl		;ED 2Dr55s00
	ldw	sxoff(iy),hl		;ED 35r55s00
	ldw	(iy+sxoff),hl		;ED 35r55s00
	ldw	sxoff(ix),sp		;DD ED 3Er55
	ldw	(ix+sxoff),sp		;DD ED 3Er55
	ldw	sxoff(iy),sp		;FD ED 3Er55
	ldw	(iy+sxoff),sp		;FD ED 3Er55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ldw	(daddr),bc		;ED 43 44 33
	ldw	(daddr),de		;ED 53 44 33
	ldw	(daddr),sp		;ED 73 44 33
	ldw	(daddr),hl		;22 44 33
	ldw	sxoff(ix),bc		;DD ED 0E 55
	ldw	(ix+sxoff),bc		;DD ED 0E 55
	ldw	sxoff(iy),bc		;FD ED 0E 55
	ldw	(iy+sxoff),bc		;FD ED 0E 55
	ldw	sxoff(ix),de		;DD ED 1E 55
	ldw	(ix+sxoff),de		;DD ED 1E 55
	ldw	sxoff(iy),de		;FD ED 1E 55
	ldw	(iy+sxoff),de		;FD ED 1E 55
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	ldw	sxoff(ix),hl		;ED 2D 55 00
	ldw	(ix+sxoff),hl		;ED 2D 55 00
	ldw	sxoff(iy),hl		;ED 35 55 00
	ldw	(iy+sxoff),hl		;ED 35 55 00
     .nlist
    .else				; (.con/.lst) or (.con/.rst)
      .list
	ldw	sxoff(ix),hl		;DD ED 2E 55
	ldw	(ix+sxoff),hl		;DD ED 2E 55
	ldw	sxoff(iy),hl		;FD ED 2E 55
	ldw	(iy+sxoff),hl		;FD ED 2E 55
      .nlist
    .endif
    .list
	ldw	sxoff(ix),sp		;DD ED 3E 55
	ldw	(ix+sxoff),sp		;DD ED 3E 55
	ldw	sxoff(iy),sp		;FD ED 3E 55
	ldw	(iy+sxoff),sp		;FD ED 3E 55
    .nlist
  .endif
.list  ; end<--
	ldw	(ix),bc			;DD ED 0E 00
	ldw	(ix),de			;DD ED 1E 00
	ldw	(ix),hl			;DD ED 2E 00
	ldw	(ix),sp			;DD ED 3E 00
	ldw	(iy),bc			;FD ED 0E 00
	ldw	(iy),de			;FD ED 1E 00
	ldw	(iy),hl			;FD ED 2E 00
	ldw	(iy),sp			;FD ED 3E 00
	;***********************************************************
	;  p. 5-92
	ldw	sp,hl			;F9
	ldw	sp,ix			;DD F9
	ldw	sp,iy			;FD F9
	ld	sp,hl			;F9
	ld	sp,ix			;DD F9
	ld	sp,iy			;FD F9
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ldw	sp,#nn			;31r00s00
	ld	sp,#nn			;31r00s00
      .nlist
    .else
      .list
	ldw	sp,#nn			;31r84s05
	ld	sp,#nn			;31r84s05
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ldw	sp,#nn			;31 84 05
	ld	sp,#nn			;31 84 05
    .nlist
  .endif
.list  ; end<--
	ldw	sp,(hl)			;ED 36
	ld	sp,(hl)			;ED 36
	ldw	(hl),sp			;ED 3E
	ld	(hl),sp			;ED 3E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ldw	sp,(daddr)		;ED 7Br00s00
	ld	sp,(daddr)		;ED 7Br00s00
	ldw	sp,(ix+sxoff)		;DD ED 36r00
	ld	sp,(ix+sxoff)		;DD ED 36r00
	ldw	sp,sxoff(ix)		;DD ED 36r00
	ld	sp,sxoff(ix)		;DD ED 36r00
	ldw	sp,(iy+sxoff)		;FD ED 36r00
	ld	sp,(iy+sxoff)		;FD ED 36r00
	ldw	sp,sxoff(iy)		;FD ED 36r00
	ld	sp,sxoff(iy)		;FD ED 36r00
      .nlist
    .else
      .list
	ldw	sp,(daddr)		;ED 7Br44s33
	ld	sp,(daddr)		;ED 7Br44s33
	ldw	sp,(ix+sxoff)		;DD ED 36r55
	ld	sp,(ix+sxoff)		;DD ED 36r55
	ldw	sp,sxoff(ix)		;DD ED 36r55
	ld	sp,sxoff(ix)		;DD ED 36r55
	ldw	sp,(iy+sxoff)		;FD ED 36r55
	ld	sp,(iy+sxoff)		;FD ED 36r55
	ldw	sp,sxoff(iy)		;FD ED 36r55
	ld	sp,sxoff(iy)		;FD ED 36r55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ldw	sp,(daddr)		;ED 7B 44 33
	ld	sp,(daddr)		;ED 7B 44 33
	ldw	sp,(ix+sxoff)		;DD ED 36 55
	ld	sp,(ix+sxoff)		;DD ED 36 55
	ldw	sp,sxoff(ix)		;DD ED 36 55
	ld	sp,sxoff(ix)		;DD ED 36 55
	ldw	sp,(iy+sxoff)		;FD ED 36 55
	ld	sp,(iy+sxoff)		;FD ED 36 55
	ldw	sp,sxoff(iy)		;FD ED 36 55
	ld	sp,sxoff(iy)		;FD ED 36 55
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ldw	(daddr),sp		;ED 73r00s00
	ld	(daddr),sp		;ED 73r00s00
	ldw	(ix+sxoff),sp		;DD ED 3Er00
	ld	(ix+sxoff),sp		;DD ED 3Er00
	ldw	sxoff(ix),sp		;DD ED 3Er00
	ld	sxoff(ix),sp		;DD ED 3Er00
	ldw	(iy+sxoff),sp		;FD ED 3Er00
	ld	(iy+sxoff),sp		;FD ED 3Er00
	ldw	sxoff(iy),sp		;FD ED 3Er00
	ld	sxoff(iy),sp		;FD ED 3Er00
      .nlist
    .else
      .list
	ldw	(daddr),sp		;ED 73r44s33
	ld	(daddr),sp		;ED 73r44s33
	ldw	(ix+sxoff),sp		;DD ED 3Er55
	ld	(ix+sxoff),sp		;DD ED 3Er55
	ldw	sxoff(ix),sp		;DD ED 3Er55
	ld	sxoff(ix),sp		;DD ED 3Er55
	ldw	(iy+sxoff),sp		;FD ED 3Er55
	ld	(iy+sxoff),sp		;FD ED 3Er55
	ldw	sxoff(iy),sp		;FD ED 3Er55
	ld	sxoff(iy),sp		;FD ED 3Er55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ldw	(daddr),sp		;ED 73 44 33
	ld	(daddr),sp		;ED 73 44 33
	ldw	(ix+sxoff),sp		;DD ED 3E 55
	ld	(ix+sxoff),sp		;DD ED 3E 55
	ldw	sxoff(ix),sp		;DD ED 3E 55
	ld	sxoff(ix),sp		;DD ED 3E 55
	ldw	(iy+sxoff),sp		;FD ED 3E 55
	ld	(iy+sxoff),sp		;FD ED 3E 55
	ldw	sxoff(iy),sp		;FD ED 3E 55
	ld	sxoff(iy),sp		;FD ED 3E 55
    .nlist
  .endif
.list  ; end<--

;*******************************************************************
;	LDD	
;*******************************************************************
	;***********************************************************
	; load location (hl)
	; with location (de)
	; decrement de, hl
	; decrement bc
	.z80
	ldd				;ED A8

;*******************************************************************
;	LDDR	
;*******************************************************************
	;***********************************************************
	; load location (hl)
	; with location (de)
	; decrement de, hl
	; decrement bc
	; repeat until bc = 0
	.z80
	lddr				;ED B8

;*******************************************************************
;	LDI	
;*******************************************************************
	;***********************************************************
	; load location (hl)
	; with location (de)
	; increment de, hl
	; decrement bc
	.z80
	ldi				;ED A0

;*******************************************************************
;	LDIR	
;*******************************************************************
	;***********************************************************
	; load location (hl)
	; with location (de)
	; increment de, hl
	; decrement bc
	; repeat until bc = 0
	.z80
	ldir				;ED B0

;*******************************************************************
;	MULT
;		Leading 'a' operand is optional.
;		If offset is ommitted 0 is assumed.
;*******************************************************************
	;***********************************************************
	; multiplication with 'a'
	;  p. 5-93
	.z280
	mult	a,b			;ED C0
	mult	a,c			;ED C8
	mult	a,d			;ED D0
	mult	a,e			;ED D8
	mult	a,h			;ED E0
	mult	a,l			;ED E8
	mult	a,a			;ED F8
	mult	a,ixh			;DD ED E0
	mult	a,ixl			;DD ED E8
	mult	a,iyh			;FD ED E0
	mult	a,iyl			;FD ED E8
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	mult	a,#n			;FD ED F8r00
	mult	a,(daddr)		;DD ED F8r00s00
	mult	a,sxoff(ix)		;FD ED C8r00s00
	mult	a,(ix+sxoff)		;FD ED C8r00s00
	mult	a,sxoff(iy)		;FD ED D0r00s00
	mult	a,(iy+sxoff)		;FD ED D0r00s00
	mult	a,sxoff(hl)		;FD ED D8r00s00
	mult	a,(hl+sxoff)		;FD ED D8r00s00
	mult	a,sxoff(sp)		;DD ED C0r00s00
	mult	a,(sp+sxoff)		;DD ED C0r00s00
	mult	a,lxoff(ix)		;FD ED C8r00s00
	mult	a,(ix+lxoff)		;FD ED C8r00s00
	mult	a,lxoff(iy)		;FD ED D0r00s00
	mult	a,(iy+lxoff)		;FD ED D0r00s00
	mult	a,lxoff(hl)		;FD ED D8r00s00
	mult	a,(hl+lxoff)		;FD ED D8r00s00
	mult	a,lxoff(sp)		;DD ED C0r00s00
	mult	a,(sp+lxoff)		;DD ED C0r00s00
      .nlist
    .else
      .list
	mult	a,#n			;FD ED F8r20
	mult	a,(daddr)		;DD ED F8r44s33
	mult	a,sxoff(ix)		;FD ED C8r55s00
	mult	a,(ix+sxoff)		;FD ED C8r55s00
	mult	a,sxoff(iy)		;FD ED D0r55s00
	mult	a,(iy+sxoff)		;FD ED D0r55s00
	mult	a,sxoff(hl)		;FD ED D8r55s00
	mult	a,(hl+sxoff)		;FD ED D8r55s00
	mult	a,sxoff(sp)		;DD ED C0r55s00
	mult	a,(sp+sxoff)		;DD ED C0r55s00
	mult	a,lxoff(ix)		;FD ED C8r22s11
	mult	a,(ix+lxoff)		;FD ED C8r22s11
	mult	a,lxoff(iy)		;FD ED D0r22s11
	mult	a,(iy+lxoff)		;FD ED D0r22s11
	mult	a,lxoff(hl)		;FD ED D8r22s11
	mult	a,(hl+lxoff)		;FD ED D8r22s11
	mult	a,lxoff(sp)		;DD ED C0r22s11
	mult	a,(sp+lxoff)		;DD ED C0r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	mult	a,#n			;FD ED F8 20
	mult	a,(daddr)		;DD ED F8 44 33
    .nlist
    .ifeq _X_R
      .list
	mult	a,sxoff(ix)		;FD ED C8 55 00
	mult	a,(ix+sxoff)		;FD ED C8 55 00
	mult	a,sxoff(iy)		;FD ED D0 55 00
	mult	a,(iy+sxoff)		;FD ED D0 55 00
      .nlist
    .else
      .list
	mult	a,sxoff(ix)		;DD ED F0 55
	mult	a,(ix+sxoff)		;DD ED F0 55
	mult	a,sxoff(iy)		;FD ED F0 55
	mult	a,(iy+sxoff)		;FD ED F0 55
      .nlist
    .endif
    .list
	mult	a,sxoff(hl)		;FD ED D8 55 00
	mult	a,(hl+sxoff)		;FD ED D8 55 00
	mult	a,sxoff(sp)		;DD ED C0 55 00
	mult	a,(sp+sxoff)		;DD ED C0 55 00
	mult	a,lxoff(ix)		;FD ED C8 22 11
	mult	a,(ix+lxoff)		;FD ED C8 22 11
	mult	a,lxoff(iy)		;FD ED D0 22 11
	mult	a,(iy+lxoff)		;FD ED D0 22 11
	mult	a,lxoff(hl)		;FD ED D8 22 11
	mult	a,(hl+lxoff)		;FD ED D8 22 11
	mult	a,lxoff(sp)		;DD ED C0 22 11
	mult	a,(sp+lxoff)		;DD ED C0 22 11
    .nlist
  .endif
.list  ; end<--
	mult	a,(ix)			;DD ED F0 00
	mult	a,(iy)			;FD ED F0 00
	mult	a,(hl)			;ED F0
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn mult01,lxofc,5
      .list
	mult	a,mult01(pc)		;FD ED C0p00q00
      .nlist
      .pcr_xtrn mult02,lxofc,5
      .list
	mult	a,(pc+mult02)		;FD ED C0p00q00
      .nlist
      .pcr_xtrn mult03,lxofc,5
      .list
	mult	a,[mult03]		;FD ED C0p00q00
      .nlist
    .else
      .pcr_lclx mult01,5
      .list
	mult	a,lxofc+mult01(pc)	;FD ED C0p22q11
      .nlist
      .pcr_lclx mult02,5
      .list
	mult	a,(pc+lxofc+mult02)	;FD ED C0p22q11
      .nlist
      .pcr_lclx mult03,5
      .list
	mult	a,[lxofc+mult03]	;FD ED C0p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn mult01,lxofc,5
      .list
	mult	a,mult01(pc)		;FD ED C0 22 11
      .nlist
      .pcr_xtrn mult02,lxofc,5
      .list
	mult	a,(pc+mult02)		;FD ED C0 22 11
      .nlist
      .pcr_xtrn mult03,lxofc,5
      .list
	mult	a,[mult03]		;FD ED C0 22 11
      .nlist
    .else
      .pcr_lclx mult01,5
      .list
	mult	a,lxofc+mult01(pc)	;FD ED C0 22 11
      .nlist
      .pcr_lclx mult02,5
      .list
	mult	a,(pc+lxofc+mult02)	;FD ED C0 22 11
      .nlist
      .pcr_lclx mult03,5
      .list
	mult	a,[lxofc+mult03]	;FD ED C0 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	mult	a,lxoff(pc)		;FD ED C0p22q11
	mult	a,(pc+lxoff)		;FD ED C0p22q11
	mult	a,[lxoff]		;FD ED C0p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc,5
      .list
	mult	a,pcr_ofst(pc)		;FD ED C0 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	mult	a,(pc+pcr_ofst)		;FD ED C0 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	mult	a,[pcr_ofst]		;FD ED C0 22 11
    .nlist
  .endif
.list  ; end<--
	mult	a,[.-5]			;FD ED C0 F6 FF
	mult	a,(hl+ix)		;DD ED C8
	mult	a,(hl+iy)		;DD ED D0
	mult	a,(ix+iy)		;DD ED D8

	;***********************************************************
	; multiplication without 'a'
	;  p. 5-93
	mult	b			;ED C0
	mult	c			;ED C8
	mult	d			;ED D0
	mult	e			;ED D8
	mult	h			;ED E0
	mult	l			;ED E8
	mult	a			;ED F8
	mult	ixh			;DD ED E0
	mult	ixl			;DD ED E8
	mult	iyh			;FD ED E0
	mult	iyl			;FD ED E8
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	mult	#n			;FD ED F8r00
	mult	(daddr)			;DD ED F8r00s00
	mult	sxoff(ix)		;FD ED C8r00s00
	mult	(ix+sxoff)		;FD ED C8r00s00
	mult	sxoff(iy)		;FD ED D0r00s00
	mult	(iy+sxoff)		;FD ED D0r00s00
	mult	sxoff(hl)		;FD ED D8r00s00
	mult	(hl+sxoff)		;FD ED D8r00s00
	mult	sxoff(sp)		;DD ED C0r00s00
	mult	(sp+sxoff)		;DD ED C0r00s00
	mult	lxoff(ix)		;FD ED C8r00s00
	mult	(ix+lxoff)		;FD ED C8r00s00
	mult	lxoff(iy)		;FD ED D0r00s00
	mult	(iy+lxoff)		;FD ED D0r00s00
	mult	lxoff(hl)		;FD ED D8r00s00
	mult	(hl+lxoff)		;FD ED D8r00s00
	mult	lxoff(sp)		;DD ED C0r00s00
	mult	(sp+lxoff)		;DD ED C0r00s00
      .nlist
    .else
      .list
	mult	#n			;FD ED F8r20
	mult	(daddr)			;DD ED F8r44s33
	mult	sxoff(ix)		;FD ED C8r55s00
	mult	(ix+sxoff)		;FD ED C8r55s00
	mult	sxoff(iy)		;FD ED D0r55s00
	mult	(iy+sxoff)		;FD ED D0r55s00
	mult	sxoff(hl)		;FD ED D8r55s00
	mult	(hl+sxoff)		;FD ED D8r55s00
	mult	sxoff(sp)		;DD ED C0r55s00
	mult	(sp+sxoff)		;DD ED C0r55s00
	mult	lxoff(ix)		;FD ED C8r22s11
	mult	(ix+lxoff)		;FD ED C8r22s11
	mult	lxoff(iy)		;FD ED D0r22s11
	mult	(iy+lxoff)		;FD ED D0r22s11
	mult	lxoff(hl)		;FD ED D8r22s11
	mult	(hl+lxoff)		;FD ED D8r22s11
	mult	lxoff(sp)		;DD ED C0r22s11
	mult	(sp+lxoff)		;DD ED C0r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	mult	#n			;FD ED F8 20
	mult	(daddr)			;DD ED F8 44 33
    .nlist
    .ifeq _X_R
      .list
	mult	sxoff(ix)		;FD ED C8 55 00
	mult	(ix+sxoff)		;FD ED C8 55 00
	mult	sxoff(iy)		;FD ED D0 55 00
	mult	(iy+sxoff)		;FD ED D0 55 00
      .nlist
    .else
      .list
	mult	sxoff(ix)		;DD ED F0 55
	mult	(ix+sxoff)		;DD ED F0 55
	mult	sxoff(iy)		;FD ED F0 55
	mult	(iy+sxoff)		;FD ED F0 55
      .nlist
    .endif
    .list
	mult	sxoff(hl)		;FD ED D8 55 00
	mult	(hl+sxoff)		;FD ED D8 55 00
	mult	sxoff(sp)		;DD ED C0 55 00
	mult	(sp+sxoff)		;DD ED C0 55 00
	mult	lxoff(ix)		;FD ED C8 22 11
	mult	(ix+lxoff)		;FD ED C8 22 11
	mult	lxoff(iy)		;FD ED D0 22 11
	mult	(iy+lxoff)		;FD ED D0 22 11
	mult	lxoff(hl)		;FD ED D8 22 11
	mult	(hl+lxoff)		;FD ED D8 22 11
	mult	lxoff(sp)		;DD ED C0 22 11
	mult	(sp+lxoff)		;DD ED C0 22 11
    .nlist
  .endif
.list  ; end<--
	mult	(ix)			;DD ED F0 00
	mult	(iy)			;FD ED F0 00
	mult	(hl)			;ED F0
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn mult04,lxofc,5
      .list
	mult	mult04(pc)		;FD ED C0p00q00
      .nlist
      .pcr_xtrn mult05,lxofc,5
      .list
	mult	(pc+mult05)		;FD ED C0p00q00
      .nlist
      .pcr_xtrn mult06,lxofc,5
      .list
	mult	[mult06]		;FD ED C0p00q00
      .nlist
    .else
      .pcr_lclx mult04,5
      .list
	mult	lxofc+mult04(pc)	;FD ED C0p22q11
      .nlist
      .pcr_lclx mult05,5
      .list
	mult	(pc+lxofc+mult05)	;FD ED C0p22q11
      .nlist
      .pcr_lclx mult06,5
      .list
	mult	[lxofc+mult06]		;FD ED C0p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn mult04,lxofc,5
      .list
	mult	mult04(pc)		;FD ED C0 22 11
      .nlist
      .pcr_xtrn mult05,lxofc,5
      .list
	mult	(pc+mult05)		;FD ED C0 22 11
      .nlist
      .pcr_xtrn mult06,lxofc,5
      .list
	mult	[mult06]		;FD ED C0 22 11
      .nlist
    .else
      .pcr_lclx mult04,5
      .list
	mult	lxofc+mult04(pc)	;FD ED C0 22 11
      .nlist
      .pcr_lclx mult05,5
      .list
	mult	(pc+lxofc+mult05)	;FD ED C0 22 11
      .nlist
      .pcr_lclx mult06,5
      .list
	mult	[lxofc+mult06]		;FD ED C0 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	mult	lxoff(pc)		;FD ED C0p22q11
	mult	(pc+lxoff)		;FD ED C0p22q11
	mult	[lxoff]			;FD ED C0p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc,5
      .list
	mult	pcr_ofst(pc)		;FD ED C0 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	mult	(pc+pcr_ofst)		;FD ED C0 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	mult	[pcr_ofst]		;FD ED C0 22 11
    .nlist
  .endif
.list  ; end<--
	mult	[.-5]			;FD ED C0 F6 FF
	mult	(hl+ix)		;DD ED C8
	mult	(hl+iy)		;DD ED D0
	mult	(ix+iy)		;DD ED D8

;*******************************************************************
;	MULTU	
;		Leading 'a' operand is optional.
;		If offset is ommitted 0 is assumed.
;*******************************************************************
	; unsigned multiplication with 'a'
	;  p. 5-93
	.z280
	multu	a,b			;ED C1
	multu	a,c			;ED C9
	multu	a,d			;ED D1
	multu	a,e			;ED D9
	multu	a,h			;ED E1
	multu	a,l			;ED E9
	multu	a,a			;ED F9
	multu	a,ixh			;DD ED E1
	multu	a,ixl			;DD ED E9
	multu	a,iyh			;FD ED E1
	multu	a,iyl			;FD ED E9
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	multu	a,#n			;FD ED F9r00
	multu	a,(daddr)		;DD ED F9r00s00
	multu	a,sxoff(ix)		;FD ED C9r00s00
	multu	a,(ix+sxoff)		;FD ED C9r00s00
	multu	a,sxoff(iy)		;FD ED D1r00s00
	multu	a,(iy+sxoff)		;FD ED D1r00s00
	multu	a,sxoff(hl)		;FD ED D9r00s00
	multu	a,(hl+sxoff)		;FD ED D9r00s00
	multu	a,sxoff(sp)		;DD ED C1r00s00
	multu	a,(sp+sxoff)		;DD ED C1r00s00
	multu	a,lxoff(ix)		;FD ED C9r00s00
	multu	a,(ix+lxoff)		;FD ED C9r00s00
	multu	a,lxoff(iy)		;FD ED D1r00s00
	multu	a,(iy+lxoff)		;FD ED D1r00s00
	multu	a,lxoff(hl)		;FD ED D9r00s00
	multu	a,(hl+lxoff)		;FD ED D9r00s00
	multu	a,lxoff(sp)		;DD ED C1r00s00
	multu	a,(sp+lxoff)		;DD ED C1r00s00
      .nlist
    .else
      .list
	multu	a,#n			;FD ED F9r20
	multu	a,(daddr)		;DD ED F9r44s33
	multu	a,sxoff(ix)		;FD ED C9r55s00
	multu	a,(ix+sxoff)		;FD ED C9r55s00
	multu	a,sxoff(iy)		;FD ED D1r55s00
	multu	a,(iy+sxoff)		;FD ED D1r55s00
	multu	a,sxoff(hl)		;FD ED D9r55s00
	multu	a,(hl+sxoff)		;FD ED D9r55s00
	multu	a,sxoff(sp)		;DD ED C1r55s00
	multu	a,(sp+sxoff)		;DD ED C1r55s00
	multu	a,lxoff(ix)		;FD ED C9r22s11
	multu	a,(ix+lxoff)		;FD ED C9r22s11
	multu	a,lxoff(iy)		;FD ED D1r22s11
	multu	a,(iy+lxoff)		;FD ED D1r22s11
	multu	a,lxoff(hl)		;FD ED D9r22s11
	multu	a,(hl+lxoff)		;FD ED D9r22s11
	multu	a,lxoff(sp)		;DD ED C1r22s11
	multu	a,(sp+lxoff)		;DD ED C1r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	multu	a,#n			;FD ED F9 20
	multu	a,(daddr)		;DD ED F9 44 33
    .nlist
    .ifeq _X_R
      .list
	multu	a,sxoff(ix)		;FD ED C9 55 00
	multu	a,(ix+sxoff)		;FD ED C9 55 00
	multu	a,sxoff(iy)		;FD ED D1 55 00
	multu	a,(iy+sxoff)		;FD ED D1 55 00
      .nlist
    .else
      .list
	multu	a,sxoff(ix)		;DD ED F1 55
	multu	a,(ix+sxoff)		;DD ED F1 55
	multu	a,sxoff(iy)		;FD ED F1 55
	multu	a,(iy+sxoff)		;FD ED F1 55
      .nlist
    .endif
    .list
	multu	a,sxoff(hl)		;FD ED D9 55 00
	multu	a,(hl+sxoff)		;FD ED D9 55 00
	multu	a,sxoff(sp)		;DD ED C1 55 00
	multu	a,(sp+sxoff)		;DD ED C1 55 00
	multu	a,lxoff(ix)		;FD ED C9 22 11
	multu	a,(ix+lxoff)		;FD ED C9 22 11
	multu	a,lxoff(iy)		;FD ED D1 22 11
	multu	a,(iy+lxoff)		;FD ED D1 22 11
	multu	a,lxoff(hl)		;FD ED D9 22 11
	multu	a,(hl+lxoff)		;FD ED D9 22 11
	multu	a,lxoff(sp)		;DD ED C1 22 11
	multu	a,(sp+lxoff)		;DD ED C1 22 11
    .nlist
  .endif
.list  ; end<--
	multu	a,(ix)			;DD ED F1 00
	multu	a,(iy)			;FD ED F1 00
	multu	a,(hl)			;ED F1
	multu	a,(sp)			;DD ED C1 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn multu01,lxofc,5
      .list
	multu	a,multu01(pc)		;FD ED C1p00q00
      .nlist
      .pcr_xtrn multu02,lxofc,5
      .list
	multu	a,(pc+multu02)		;FD ED C1p00q00
      .nlist
      .pcr_xtrn multu03,lxofc,5
      .list
	multu	a,[multu03]		;FD ED C1p00q00
      .nlist
    .else
      .pcr_lclx multu01,5
      .list
	multu	a,lxofc+multu01(pc)	;FD ED C1p22q11
      .nlist
      .pcr_lclx multu02,5
      .list
	multu	a,(pc+lxofc+multu02)	;FD ED C1p22q11
      .nlist
      .pcr_lclx multu03,5
      .list
	multu	a,[lxofc+multu03]	;FD ED C1p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn multu01,lxofc,5
      .list
	multu	a,multu01(pc)		;FD ED C1 22 11
      .nlist
      .pcr_xtrn multu02,lxofc,5
      .list
	multu	a,(pc+multu02)		;FD ED C1 22 11
      .nlist
      .pcr_xtrn multu03,lxofc,5
      .list
	multu	a,[multu03]		;FD ED C1 22 11
      .nlist
    .else
      .pcr_lclx multu01,5
      .list
	multu	a,lxofc+multu01(pc)	;FD ED C1 22 11
      .nlist
      .pcr_lclx multu02,5
      .list
	multu	a,(pc+lxofc+multu02)	;FD ED C1 22 11
      .nlist
      .pcr_lclx multu03,5
      .list
	multu	a,[lxofc+multu03]	;FD ED C1 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	multu	a,lxoff(pc)		;FD ED C1p22q11
	multu	a,(pc+lxoff)		;FD ED C1p22q11
	multu	a,[lxoff]		;FD ED C1p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc,5
      .list
	multu	a,pcr_ofst(pc)		;FD ED C1 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	multu	a,(pc+pcr_ofst)		;FD ED C1 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	multu	a,[pcr_ofst]		;FD ED C1 22 11
    .nlist
  .endif
.list  ; end<--
	multu	a,[.-5]			;FD ED C1 F6 FF
	multu	a,(hl+ix)		;DD ED C9
	multu	a,(hl+iy)		;DD ED D1
	multu	a,(ix+iy)		;DD ED D9

	; unsigned multiplication without 'a'
	;  p. 5-93
	.z280
	multu	b			;ED C1
	multu	c			;ED C9
	multu	d			;ED D1
	multu	e			;ED D9
	multu	h			;ED E1
	multu	l			;ED E9
	multu	a			;ED F9
	multu	ixh			;DD ED E1
	multu	ixl			;DD ED E9
	multu	iyh			;FD ED E1
	multu	iyl			;FD ED E9
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	multu	#n			;FD ED F9r00
	multu	(daddr)			;DD ED F9r00s00
	multu	sxoff(ix)		;FD ED C9r00s00
	multu	(ix+sxoff)		;FD ED C9r00s00
	multu	sxoff(iy)		;FD ED D1r00s00
	multu	(iy+sxoff)		;FD ED D1r00s00
	multu	sxoff(hl)		;FD ED D9r00s00
	multu	(hl+sxoff)		;FD ED D9r00s00
	multu	sxoff(sp)		;DD ED C1r00s00
	multu	(sp+sxoff)		;DD ED C1r00s00
	multu	lxoff(ix)		;FD ED C9r00s00
	multu	(ix+lxoff)		;FD ED C9r00s00
	multu	lxoff(iy)		;FD ED D1r00s00
	multu	(iy+lxoff)		;FD ED D1r00s00
	multu	lxoff(hl)		;FD ED D9r00s00
	multu	(hl+lxoff)		;FD ED D9r00s00
	multu	lxoff(sp)		;DD ED C1r00s00
	multu	(sp+lxoff)		;DD ED C1r00s00
      .nlist
    .else
      .list
	multu	#n			;FD ED F9r20
	multu	(daddr)			;DD ED F9r44s33
	multu	sxoff(ix)		;FD ED C9r55s00
	multu	(ix+sxoff)		;FD ED C9r55s00
	multu	sxoff(iy)		;FD ED D1r55s00
	multu	(iy+sxoff)		;FD ED D1r55s00
	multu	sxoff(hl)		;FD ED D9r55s00
	multu	(hl+sxoff)		;FD ED D9r55s00
	multu	sxoff(sp)		;DD ED C1r55s00
	multu	(sp+sxoff)		;DD ED C1r55s00
	multu	lxoff(ix)		;FD ED C9r22s11
	multu	(ix+lxoff)		;FD ED C9r22s11
	multu	lxoff(iy)		;FD ED D1r22s11
	multu	(iy+lxoff)		;FD ED D1r22s11
	multu	lxoff(hl)		;FD ED D9r22s11
	multu	(hl+lxoff)		;FD ED D9r22s11
	multu	lxoff(sp)		;DD ED C1r22s11
	multu	(sp+lxoff)		;DD ED C1r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	multu	#n			;FD ED F9 20
	multu	(daddr)			;DD ED F9 44 33
    .nlist
    .ifeq _X_R
      .list
	multu	sxoff(ix)		;FD ED C9 55 00
	multu	(ix+sxoff)		;FD ED C9 55 00
	multu	sxoff(iy)		;FD ED D1 55 00
	multu	(iy+sxoff)		;FD ED D1 55 00
      .nlist
    .else
      .list
	multu	sxoff(ix)		;DD ED F1 55
	multu	(ix+sxoff)		;DD ED F1 55
	multu	sxoff(iy)		;FD ED F1 55
	multu	(iy+sxoff)		;FD ED F1 55
      .nlist
    .endif
    .list
	multu	sxoff(hl)		;FD ED D9 55 00
	multu	(hl+sxoff)		;FD ED D9 55 00
	multu	sxoff(sp)		;DD ED C1 55 00
	multu	(sp+sxoff)		;DD ED C1 55 00
	multu	lxoff(ix)		;FD ED C9 22 11
	multu	(ix+lxoff)		;FD ED C9 22 11
	multu	lxoff(iy)		;FD ED D1 22 11
	multu	(iy+lxoff)		;FD ED D1 22 11
	multu	lxoff(hl)		;FD ED D9 22 11
	multu	(hl+lxoff)		;FD ED D9 22 11
	multu	lxoff(sp)		;DD ED C1 22 11
	multu	(sp+lxoff)		;DD ED C1 22 11
    .nlist
  .endif
.list  ; end<--
	multu	(ix)			;DD ED F1 00
	multu	(iy)			;FD ED F1 00
	multu	(hl)			;ED F1
	multu	(sp)			;DD ED C1 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn multu04,lxofc,5
      .list
	multu	multu04(pc)		;FD ED C1p00q00
      .nlist
      .pcr_xtrn multu05,lxofc,5
      .list
	multu	(pc+multu05)		;FD ED C1p00q00
      .nlist
      .pcr_xtrn multu06,lxofc,5
      .list
	multu	[multu06]		;FD ED C1p00q00
      .nlist
    .else
      .pcr_lclx multu04,5
      .list
	multu	lxofc+multu04(pc)	;FD ED C1p22q11
      .nlist
      .pcr_lclx multu05,5
      .list
	multu	(pc+lxofc+multu05)	;FD ED C1p22q11
      .nlist
      .pcr_lclx multu06,5
      .list
	multu	[lxofc+multu06]		;FD ED C1p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn multu04,lxofc,5
      .list
	multu	multu04(pc)		;FD ED C1 22 11
      .nlist
      .pcr_xtrn multu05,lxofc,5
      .list
	multu	(pc+multu05)		;FD ED C1 22 11
      .nlist
      .pcr_xtrn multu06,lxofc,5
      .list
	multu	[multu06]		;FD ED C1 22 11
      .nlist
    .else
      .pcr_lclx multu04,5
      .list
	multu	lxofc+multu04(pc)	;FD ED C1 22 11
      .nlist
      .pcr_lclx multu05,5
      .list
	multu	(pc+lxofc+multu05)	;FD ED C1 22 11
      .nlist
      .pcr_lclx multu06,5
      .list
	multu	[lxofc+multu06]		;FD ED C1 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	multu	lxoff(pc)		;FD ED C1p22q11
	multu	(pc+lxoff)		;FD ED C1p22q11
	multu	[lxoff]			;FD ED C1p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc,5
      .list
	multu	pcr_ofst(pc)		;FD ED C1 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	multu	(pc+pcr_ofst)		;FD ED C1 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	multu	[pcr_ofst]		;FD ED C1 22 11
    .nlist
  .endif
.list  ; end<--
	multu	[.-5]			;FD ED C1 F6 FF
	multu	(hl+ix)			;DD ED C9
	multu	(hl+iy)			;DD ED D1
	multu	(ix+iy)			;DD ED D9

;*******************************************************************
;	MULTUW	
;*******************************************************************
	; unsigned word multiplication
	;  p. 5-93
	.z280
	multuw	hl,bc			;ED C3
	multuw	hl,de			;ED D3
	multuw	hl,hl			;ED E3
	multuw	hl,sp			;ED F3
	multuw	hl,ix			;DD ED E3
	multuw	hl,iy			;FD ED E3
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	multuw	hl,#n			;FD ED F3r00s00
	multuw	hl,#nn			;FD ED F3r00s00
	multuw	hl,sxoff(ix)		;FD ED C3r00s00
	multuw	hl,(ix+sxoff)		;FD ED C3r00s00
	multuw	hl,sxoff(iy)		;FD ED D3r00s00
	multuw	hl,(iy+sxoff)		;FD ED D3r00s00
	multuw	hl,lxoff(ix)		;FD ED C3r00s00
	multuw	hl,(ix+lxoff)		;FD ED C3r00s00
	multuw	hl,lxoff(iy)		;FD ED D3r00s00
	multuw	hl,(iy+lxoff)		;FD ED D3r00s00
      .nlist
    .else
      .list
	multuw	hl,#n			;FD ED F3r20s00
	multuw	hl,#nn			;FD ED F3r84s05
	multuw	hl,sxoff(ix)		;FD ED C3r55s00
	multuw	hl,(ix+sxoff)		;FD ED C3r55s00
	multuw	hl,sxoff(iy)		;FD ED D3r55s00
	multuw	hl,(iy+sxoff)		;FD ED D3r55s00
	multuw	hl,lxoff(ix)		;FD ED C3r22s11
	multuw	hl,(ix+lxoff)		;FD ED C3r22s11
	multuw	hl,lxoff(iy)		;FD ED D3r22s11
	multuw	hl,(iy+lxoff)		;FD ED D3r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	multuw	hl,#n			;FD ED F3 20 00
	multuw	hl,#nn			;FD ED F3 84 05
	multuw	hl,sxoff(ix)		;FD ED C3 55 00
	multuw	hl,(ix+sxoff)		;FD ED C3 55 00
	multuw	hl,sxoff(iy)		;FD ED D3 55 00
	multuw	hl,(iy+sxoff)		;FD ED D3 55 00
	multuw	hl,lxoff(ix)		;FD ED C3 22 11
	multuw	hl,(ix+lxoff)		;FD ED C3 22 11
	multuw	hl,lxoff(iy)		;FD ED D3 22 11
	multuw	hl,(iy+lxoff)		;FD ED D3 22 11
    .nlist
  .endif
.list  ; end<--
	multuw	hl,(hl)			;DD ED C3
	multuw	hl,(ix)			;FD ED C3 00 00
	multuw	hl,(iy)			;FD ED D3 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn multuw01,lxofc,5
      .list
	multuw	hl,multuw01(pc)		;DD ED F3p00q00
      .nlist
      .pcr_xtrn multuw02,lxofc,5
      .list
	multuw	hl,(pc+multuw02)	;DD ED F3p00q00
      .nlist
      .pcr_xtrn multuw03,lxofc,5
      .list
	multuw	hl,[multuw03]		;DD ED F3p00q00
      .nlist
    .else
      .pcr_lclx multuw01,5
      .list
	multuw	hl,lxofc+multuw01(pc)	;DD ED F3p22q11
      .nlist
      .pcr_lclx multuw02,5
      .list
	multuw	hl,(pc+lxofc+multuw02)	;DD ED F3p22q11
      .nlist
      .pcr_lclx multuw03,5
      .list
	multuw	hl,[lxofc+multuw03]	;DD ED F3p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn multuw01,lxofc,5
      .list
	multuw	hl,multuw01(pc)		;DD ED F3 22 11
      .nlist
      .pcr_xtrn multuw02,lxofc,5
      .list
	multuw	hl,(pc+multuw02)	;DD ED F3 22 11
      .nlist
      .pcr_xtrn multuw03,lxofc,5
      .list
	multuw	hl,[multuw03]		;DD ED F3 22 11
      .nlist
    .else
      .pcr_lclx multuw01,5
      .list
	multuw	hl,lxofc+multuw01(pc)	;DD ED F3 22 11
      .nlist
      .pcr_lclx multuw02,5
      .list
	multuw	hl,(pc+lxofc+multuw02)	;DD ED F3 22 11
      .nlist
      .pcr_lclx multuw03,5
      .list
	multuw	hl,[lxofc+multuw03]	;DD ED F3 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	multuw	hl,lxoff(pc)		;DD ED F3p22q11
	multuw	hl,(pc+lxoff)		;DD ED F3p22q11
	multuw	hl,[lxoff]		;DD ED F3p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc,5
      .list
	multuw	hl,pcr_ofst(pc)		;DD ED F3 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	multuw	hl,(pc+pcr_ofst)	;DD ED F3 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	multuw	hl,[pcr_ofst]		;DD ED F3 22 11
    .nlist
  .endif
.list  ; end<--
	multuw	hl,[.+nc]		;DD ED F3 1B 00

;*******************************************************************
;	MULTW	
;*******************************************************************
	; word multiplication
	;  p. 5-93
	.z280
	multw	hl,bc			;ED C2
	multw	hl,de			;ED D2
	multw	hl,hl			;ED E2
	multw	hl,sp			;ED F2
	multw	hl,ix			;DD ED E2
	multw	hl,iy			;FD ED E2
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	multw	hl,#n			;FD ED F2r00s00
	multw	hl,#nn			;FD ED F2r00s00
	multw	hl,(daddr)		;DD ED D2r00s00
	multw	hl,sxoff(ix)		;FD ED C2r00s00
	multw	hl,(ix+sxoff)		;FD ED C2r00s00
	multw	hl,sxoff(iy)		;FD ED D2r00s00
	multw	hl,(iy+sxoff)		;FD ED D2r00s00
	multw	hl,lxoff(ix)		;FD ED C2r00s00
	multw	hl,(ix+lxoff)		;FD ED C2r00s00
	multw	hl,lxoff(iy)		;FD ED D2r00s00
	multw	hl,(iy+lxoff)		;FD ED D2r00s00
      .nlist
    .else
      .list
	multw	hl,#n			;FD ED F2r20s00
	multw	hl,#nn			;FD ED F2r84s05
	multw	hl,(daddr)		;DD ED D2r44s33
	multw	hl,sxoff(ix)		;FD ED C2r55s00
	multw	hl,(ix+sxoff)		;FD ED C2r55s00
	multw	hl,sxoff(iy)		;FD ED D2r55s00
	multw	hl,(iy+sxoff)		;FD ED D2r55s00
	multw	hl,lxoff(ix)		;FD ED C2r22s11
	multw	hl,(ix+lxoff)		;FD ED C2r22s11
	multw	hl,lxoff(iy)		;FD ED D2r22s11
	multw	hl,(iy+lxoff)		;FD ED D2r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	multw	hl,#n			;FD ED F2 20 00
	multw	hl,#nn			;FD ED F2 84 05
	multw	hl,(daddr)		;DD ED D2 44 33
	multw	hl,sxoff(ix)		;FD ED C2 55 00
	multw	hl,(ix+sxoff)		;FD ED C2 55 00
	multw	hl,sxoff(iy)		;FD ED D2 55 00
	multw	hl,(iy+sxoff)		;FD ED D2 55 00
	multw	hl,lxoff(ix)		;FD ED C2 22 11
	multw	hl,(ix+lxoff)		;FD ED C2 22 11
	multw	hl,lxoff(iy)		;FD ED D2 22 11
	multw	hl,(iy+lxoff)		;FD ED D2 22 11
    .nlist
  .endif
.list  ; end<--
	multw	hl,(hl)			;DD ED C2
	multw	hl,(ix)			;FD ED C2 00 00
	multw	hl,(iy)			;FD ED D2 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn multw01,lxofc,5
      .list
	multw	hl,multw01(pc)		;DD ED F2p00q00
      .nlist
      .pcr_xtrn multw02,lxofc,5
      .list
	multw	hl,(pc+multw02)		;DD ED F2p00q00
      .nlist
      .pcr_xtrn multw03,lxofc,5
      .list
	multw	hl,[multw03]		;DD ED F2p00q00
      .nlist
    .else
      .pcr_lclx multw01,5
      .list
	multw	hl,lxofc+multw01(pc)	;DD ED F2p22q11
      .nlist
      .pcr_lclx multw02,5
      .list
	multw	hl,(pc+lxofc+multw02)	;DD ED F2p22q11
      .nlist
      .pcr_lclx multw03,5
      .list
	multw	hl,[lxofc+multw03]	;DD ED F2p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn multw01,lxofc,5
      .list
	multw	hl,multw01(pc)		;DD ED F2 22 11
      .nlist
      .pcr_xtrn multw02,lxofc,5
      .list
	multw	hl,(pc+multw02)		;DD ED F2 22 11
      .nlist
      .pcr_xtrn multw03,lxofc,5
      .list
	multw	hl,[multw03]		;DD ED F2 22 11
      .nlist
    .else
      .pcr_lclx multw01,5
      .list
	multw	hl,lxofc+multw01(pc)	;DD ED F2 22 11
      .nlist
      .pcr_lclx multw02,5
      .list
	multw	hl,(pc+lxofc+multw02)	;DD ED F2 22 11
      .nlist
      .pcr_lclx multw03,5
      .list
	multw	hl,[lxofc+multw03]	;DD ED F2 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	multw	hl,lxoff(pc)		;DD ED F2p22q11
	multw	hl,(pc+lxoff)		;DD ED F2p22q11
	multw	hl,[lxoff]		;DD ED F2p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc,5
      .list
	multw	hl,pcr_ofst(pc)		;DD ED F2 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	multw	hl,(pc+pcr_ofst)	;DD ED F2 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	multw	hl,[pcr_ofst]		;DD ED F2 22 11
    .nlist
  .endif
.list  ; end<--
	multw	hl,[.+nc]		;DD ED F2 1B 00

;*******************************************************************
;	NEG	
;*******************************************************************
	;***********************************************************
	; 2's complement of 'a'
	.z80
	neg				;ED 44
	neg	a			;ED 44
	.z280
	neg	hl			;ED 4C

;*******************************************************************
;	NOP	
;*******************************************************************
	;***********************************************************
	; no operation
	.z80
	nop				;00

;*******************************************************************
;	OR	
;		Leading 'a' operand is optional.
;		If offset is ommitted 0 is assumed.
;*******************************************************************
	;***********************************************************
	; logical 'or' operand with 'a'
	.z80
	or	a,(hl)			;B6
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	or	a,#n			;F6r00
	or	a, n			;F6r00
	or	a,offset(ix)		;DD B6r00
	or	a,offset(iy)		;FD B6r00
	or	a,(ix+offset)		;DD B6r00
	or	a,(iy+offset)		;FD B6r00
      .nlist
    .else
      .list
	or	a,#n			;F6r20
	or	a, n			;F6r20
	or	a,offset(ix)		;DD B6r55
	or	a,offset(iy)		;FD B6r55
	or	a,(ix+offset)		;DD B6r55
	or	a,(iy+offset)		;FD B6r55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	or	a,#n			;F6 20
	or	a, n			;F6 20
	or	a,offset(ix)		;DD B6 55
	or	a,offset(iy)		;FD B6 55
	or	a,(ix+offset)		;DD B6 55
	or	a,(iy+offset)		;FD B6 55
    .nlist
  .endif
.list  ; end<--
	or	a,a			;B7
	or	a,b			;B0
	or	a,c			;B1
	or	a,d			;B2
	or	a,e			;B3
	or	a,h			;B4
	or	a,l			;B5
	;***********************************************************
	;  p. 5-100
	.z280
	or	a,(hl+ix)		;DD B1
	or	a,(hl+iy)		;DD B2
	or	a,(ix+iy)		;DD B3
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	or	a,(daddr)		;DD B7r00s00
	or	a,sxoff(ix)		;FD B1r00s00
	or	a,(ix+sxoff)		;FD B1r00s00
	or	a,sxoff(iy)		;FD B2r00s00
	or	a,(iy+sxoff)		;FD B2r00s00
	or	a,sxoff(hl)		;FD B3r00s00
	or	a,(hl+sxoff)		;FD B3r00s00
	or	a,sxoff(sp)		;DD B0r00s00
	or	a,(sp+sxoff)		;DD B0r00s00
	or	a,lxoff(ix)		;FD B1r00s00
	or	a,(ix+lxoff)		;FD B1r00s00
	or	a,lxoff(iy)		;FD B2r00s00
	or	a,(iy+lxoff)		;FD B2r00s00
	or	a,lxoff(hl)		;FD B3r00s00
	or	a,(hl+lxoff)		;FD B3r00s00
	or	a,lxoff(sp)		;DD B0r00s00
	or	a,(sp+lxoff)		;DD B0r00s00
      .nlist
    .else
      .list
	or	a,(daddr)		;DD B7r44s33
	or	a,sxoff(ix)		;FD B1r55s00
	or	a,(ix+sxoff)		;FD B1r55s00
	or	a,sxoff(iy)		;FD B2r55s00
	or	a,(iy+sxoff)		;FD B2r55s00
	or	a,sxoff(hl)		;FD B3r55s00
	or	a,(hl+sxoff)		;FD B3r55s00
	or	a,sxoff(sp)		;DD B0r55s00
	or	a,(sp+sxoff)		;DD B0r55s00
	or	a,lxoff(ix)		;FD B1r22s11
	or	a,(ix+lxoff)		;FD B1r22s11
	or	a,lxoff(iy)		;FD B2r22s11
	or	a,(iy+lxoff)		;FD B2r22s11
	or	a,lxoff(hl)		;FD B3r22s11
	or	a,(hl+lxoff)		;FD B3r22s11
	or	a,lxoff(sp)		;DD B0r22s11
	or	a,(sp+lxoff)		;DD B0r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	or	a,(daddr)		;DD B7 44 33
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	or	a,sxoff(ix)		;FD B1 55 00
	or	a,(ix+sxoff)		;FD B1 55 00
	or	a,sxoff(iy)		;FD B2 55 00
	or	a,(iy+sxoff)		;FD B2 55 00
      .nlist
    .else				; (.con/.lst) or (.con/.rst)
      .list
	or	a,sxoff(ix)		;DD B6 55
	or	a,(ix+sxoff)		;DD B6 55
	or	a,sxoff(iy)		;FD B6 55
	or	a,(iy+sxoff)		;FD B6 55
      .nlist
    .endif
    .list
	or	a,lxoff(ix)		;FD B1 22 11
	or	a,(ix+lxoff)		;FD B1 22 11
	or	a,lxoff(iy)		;FD B2 22 11
	or	a,(iy+lxoff)		;FD B2 22 11
	or	a,lxoff(hl)		;FD B3 22 11
	or	a,(hl+lxoff)		;FD B3 22 11
	or	a,lxoff(sp)		;DD B0 22 11
	or	a,(sp+lxoff)		;DD B0 22 11
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn or01,lxofc
      .list
	or	a,or01(pc)		;FD B0p00q00
      .nlist
      .pcr_xtrn or02,lxofc
      .list
	or	a,(pc+or02)		;FD B0p00q00
      .nlist
      .pcr_xtrn or03,lxofc
      .list
	or	a,[or03]		;FD B0p00q00
      .nlist
    .else
      .pcr_lclx or01
      .list
	or	a,lxofc+or01(pc)	;FD B0p22q11
      .nlist
      .pcr_lclx or02
      .list
	or	a,(pc+lxofc+or02)	;FD B0p22q11
      .nlist
      .pcr_lclx or03
      .list
	or	a,[lxofc+or03]		;FD B0p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn or01,lxofc
      .list
	or	a,or01(pc)		;FD B0 22 11
      .nlist
      .pcr_xtrn or02,lxofc
      .list
	or	a,(pc+or02)		;FD B0 22 11
      .nlist
      .pcr_xtrn or03,lxofc
      .list
	or	a,[or03]		;FD B0 22 11
      .nlist
    .else
      .pcr_lclx or01
      .list
	or	a,lxofc+or01(pc)	;FD B0 22 11
      .nlist
      .pcr_lclx or02
      .list
	or	a,(pc+lxofc+or02)	;FD B0 22 11
      .nlist
      .pcr_lclx or03
      .list
	or	a,[lxofc+or03]		;FD B0 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	or	a,lxoff(pc)		;FD B0p22q11
	or	a,(pc+lxoff)		;FD B0p22q11
	or	a,[lxoff]		;FD B0p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc
      .list
	or	a,pcr_ofst(pc)		;FD B0 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	or	a,(pc+pcr_ofst)		;FD B0 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	or	a,[pcr_ofst]		;FD B0 22 11
    .nlist
  .endif
.list  ; end<--
	or	a,[.+lxofc]		;FD B0 1E 11
	or	a,ixh			;DD B4
	or	a,ixl			;DD B5
	or	a,iyh			;FD B4
	or	a,iyl			;FD B5

	;***********************************************************
	; logical 'or' operand without 'a'
	.z80
	or	a,(hl)			;B6
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	or	#n			;F6r00
	or	 n			;F6r00
	or	offset(ix)		;DD B6r00
	or	offset(iy)		;FD B6r00
	or	(ix+offset)		;DD B6r00
	or	(iy+offset)		;FD B6r00
      .nlist
    .else
      .list
	or	#n			;F6r20
	or	 n			;F6r20
	or	offset(ix)		;DD B6r55
	or	offset(iy)		;FD B6r55
	or	(ix+offset)		;DD B6r55
	or	(iy+offset)		;FD B6r55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	or	#n			;F6 20
	or	 n			;F6 20
	or	offset(ix)		;DD B6 55
	or	offset(iy)		;FD B6 55
	or	(ix+offset)		;DD B6 55
	or	(iy+offset)		;FD B6 55
    .nlist
  .endif
.list  ; end<--
	or	a			;B7
	or	b			;B0
	or	c			;B1
	or	d			;B2
	or	e			;B3
	or	h			;B4
	or	l			;B5
	;***********************************************************
	;  p. 5-100
	.z280
	or	(hl+ix)		;DD B1
	or	(hl+iy)		;DD B2
	or	(ix+iy)		;DD B3
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	or	(daddr)			;DD B7r00s00
	or	sxoff(ix)		;FD B1r00s00
	or	(ix+sxoff)		;FD B1r00s00
	or	sxoff(iy)		;FD B2r00s00
	or	(iy+sxoff)		;FD B2r00s00
	or	sxoff(sp)		;DD B0r00s00
	or	(sp+sxoff)		;DD B0r00s00
	or	sxoff(hl)		;FD B3r00s00
	or	(hl+sxoff)		;FD B3r00s00
	or	lxoff(ix)		;FD B1r00s00
	or	(ix+lxoff)		;FD B1r00s00
	or	lxoff(iy)		;FD B2r00s00
	or	(iy+lxoff)		;FD B2r00s00
	or	lxoff(hl)		;FD B3r00s00
	or	(hl+lxoff)		;FD B3r00s00
	or	lxoff(sp)		;DD B0r00s00
	or	(sp+lxoff)		;DD B0r00s00
      .nlist
    .else
      .list
	or	(daddr)			;DD B7r44s33
	or	sxoff(ix)		;FD B1r55s00
	or	(ix+sxoff)		;FD B1r55s00
	or	sxoff(iy)		;FD B2r55s00
	or	(iy+sxoff)		;FD B2r55s00
	or	sxoff(sp)		;DD B0r55s00
	or	(sp+sxoff)		;DD B0r55s00
	or	sxoff(hl)		;FD B3r55s00
	or	(hl+sxoff)		;FD B3r55s00
	or	lxoff(ix)		;FD B1r22s11
	or	(ix+lxoff)		;FD B1r22s11
	or	lxoff(iy)		;FD B2r22s11
	or	(iy+lxoff)		;FD B2r22s11
	or	lxoff(hl)		;FD B3r22s11
	or	(hl+lxoff)		;FD B3r22s11
	or	lxoff(sp)		;DD B0r22s11
	or	(sp+lxoff)		;DD B0r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	or	(daddr)			;DD B7 44 33
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	or	sxoff(ix)		;FD B1 55 00
	or	(ix+sxoff)		;FD B1 55 00
	or	sxoff(iy)		;FD B2 55 00
	or	(iy+sxoff)		;FD B2 55 00
      .nlist
    .else				; (.con/.lst) or (.con/.rst)
      .list
	or	sxoff(ix)		;DD B6 55
	or	(ix+sxoff)		;DD B6 55
	or	sxoff(iy)		;FD B6 55
	or	(iy+sxoff)		;FD B6 55
      .nlist
    .endif
    .list
	or	sxoff(hl)		;FD B3 55 00
	or	(hl+sxoff)		;FD B3 55 00
	or	sxoff(sp)		;DD B0 55 00
	or	(sp+sxoff)		;DD B0 55 00
	or	lxoff(ix)		;FD B1 22 11
	or	(ix+lxoff)		;FD B1 22 11
	or	lxoff(iy)		;FD B2 22 11
	or	(iy+lxoff)		;FD B2 22 11
	or	lxoff(hl)		;FD B3 22 11
	or	(hl+lxoff)		;FD B3 22 11
	or	lxoff(sp)		;DD B0 22 11
	or	(sp+lxoff)		;DD B0 22 11
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn or04,lxofc
      .list
	or	or04(pc)		;FD B0p00q00
      .nlist
      .pcr_xtrn or05,lxofc
      .list
	or	(pc+or05)		;FD B0p00q00
      .nlist
      .pcr_xtrn or06,lxofc
      .list
	or	[or06]			;FD B0p00q00
      .nlist
    .else
      .pcr_lclx or04
      .list
	or	lxofc+or04(pc)		;FD B0p22q11
      .nlist
      .pcr_lclx or05
      .list
	or	(pc+lxofc+or05)		;FD B0p22q11
      .nlist
      .pcr_lclx or06
      .list
	or	[lxofc+or06]		;FD B0p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn or04,lxofc
      .list
	or	or04(pc)		;FD B0 22 11
      .nlist
      .pcr_xtrn or05,lxofc
      .list
	or	(pc+or05)		;FD B0 22 11
      .nlist
      .pcr_xtrn or06,lxofc
      .list
	or	[or06]			;FD B0 22 11
      .nlist
    .else
      .pcr_lclx or04
      .list
	or	lxofc+or04(pc)		;FD B0 22 11
      .nlist
      .pcr_lclx or05
      .list
	or	(pc+lxofc+or05)		;FD B0 22 11
      .nlist
      .pcr_lclx or06
      .list
	or	[lxofc+or06]		;FD B0 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	or	lxoff(pc)		;FD B0p22q11
	or	(pc+lxoff)		;FD B0p22q11
	or	[lxoff]			;FD B0p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc
      .list
	or	pcr_ofst(pc)		;FD B0 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	or	(pc+pcr_ofst)		;FD B0 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	or	[pcr_ofst]		;FD B0 22 11
    .nlist
  .endif
.list  ; end<--
	or	[.+lxofc]		;FD B0 1E 11
	or	ixh			;DD B4
	or	ixl			;DD B5
	or	iyh			;FD B4
	or	iyl			;FD B5

;*******************************************************************
;	OTDR	
;*******************************************************************
	;***********************************************************
	; load output port (c)
	; with location (hl)
	; decrement hl and decrement b
	; repeat until b = 0
	.z80
	otdr				;ED BB

;*******************************************************************
;	OTIR	
;*******************************************************************
	;***********************************************************
	; load output port (c)
	; with location (hl)
	; increment hl and decrement b
	; repeat until b = 0
	.z80
	otir				;ED B3

;*******************************************************************
;	OUT	
;*******************************************************************
	;***********************************************************
	; load output port (c) with reg
	.z80
	out	(c),a			;ED 79
	out	(c),b			;ED 41
	out	(c),c			;ED 49
	out	(c),d			;ED 51
	out	(c),e			;ED 59
	out	(c),h			;ED 61
	out	(c),l			;ED 69
	;***********************************************************
	;  p. 5-105
	.z280
	out	(c),ixl			;DD ED 69
	out	(c),ixh			;DD ED 61
	out	(c),iyl			;FD ED 69
	out	(c),iyh			;FD ED 61
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	out	(c),(daddr)		;DD ED 79r00s00
	out	(c),sxoff(hl)		;FD ED 59r00s00
	out	(c),(hl+sxoff)		;FD ED 59r00s00
	out	(c),lxoff(hl)		;FD ED 59r00s00
	out	(c),(hl+lxoff)		;FD ED 59r00s00
	out	(c),sxoff(ix)		;FD ED 49r00s00
	out	(c),(ix+sxoff)		;FD ED 49r00s00
	out	(c),lxoff(ix)		;FD ED 49r00s00
	out	(c),(ix+lxoff)		;FD ED 49r00s00
	out	(c),sxoff(iy)		;FD ED 51r00s00
	out	(c),(iy+sxoff)		;FD ED 51r00s00
	out	(c),lxoff(iy)		;FD ED 51r00s00
	out	(c),(iy+lxoff)		;FD ED 51r00s00
	out	(c),offset(sp)		;DD ED 41r00s00
	out	(c),(sp+offset)		;DD ED 41r00s00
	out	(c),lxoff(sp)		;DD ED 41r00s00
	out	(c),(sp+lxoff)		;DD ED 41r00s00
      .nlist
    .else
      .list
	out	(c),(daddr)		;DD ED 79r44s33
	out	(c),sxoff(hl)		;FD ED 59r55s00
	out	(c),(hl+sxoff)		;FD ED 59r55s00
	out	(c),lxoff(hl)		;FD ED 59r22s11
	out	(c),(hl+lxoff)		;FD ED 59r22s11
	out	(c),sxoff(ix)		;FD ED 49r55s00
	out	(c),(ix+sxoff)		;FD ED 49r55s00
	out	(c),lxoff(ix)		;FD ED 49r22s11
	out	(c),(ix+lxoff)		;FD ED 49r22s11
	out	(c),sxoff(iy)		;FD ED 51r55s00
	out	(c),(iy+sxoff)		;FD ED 51r55s00
	out	(c),lxoff(iy)		;FD ED 51r22s11
	out	(c),(iy+lxoff)		;FD ED 51r22s11
	out	(c),offset(sp)		;DD ED 41r55s00
	out	(c),(sp+offset)		;DD ED 41r55s00
	out	(c),lxoff(sp)		;DD ED 41r22s11
	out	(c),(sp+lxoff)		;DD ED 41r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	out	(c),(daddr)		;DD ED 79 44 33
	out	(c),sxoff(hl)		;FD ED 59 55 00
	out	(c),(hl+sxoff)		;FD ED 59 55 00
	out	(c),lxoff(hl)		;FD ED 59 22 11
	out	(c),(hl+lxoff)		;FD ED 59 22 11
	out	(c),sxoff(ix)		;FD ED 49 55 00
	out	(c),(ix+sxoff)		;FD ED 49 55 00
	out	(c),lxoff(ix)		;FD ED 49 22 11
	out	(c),(ix+lxoff)		;FD ED 49 22 11
	out	(c),sxoff(iy)		;FD ED 51 55 00
	out	(c),(iy+sxoff)		;FD ED 51 55 00
	out	(c),lxoff(iy)		;FD ED 51 22 11
	out	(c),(iy+lxoff)		;FD ED 51 22 11
	out	(c),offset(sp)		;DD ED 41 55 00
	out	(c),(sp+offset)		;DD ED 41 55 00
	out	(c),lxoff(sp)		;DD ED 41 22 11
	out	(c),(sp+lxoff)		;DD ED 41 22 11
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn out01,lxofc,5
      .list
	out	(c),out01(pc)		;FD ED 41p00q00
      .nlist
      .pcr_xtrn out02,lxofc,5
      .list
	out	(c),(pc+out02)		;FD ED 41p00q00
      .nlist
      .pcr_xtrn out03,lxofc,5
      .list
	out	(c),[out03]		;FD ED 41p00q00
      .nlist
    .else
      .pcr_lclx out01,5
      .list
	out	(c),lxofc+out01(pc)	;FD ED 41p22q11
      .nlist
      .pcr_lclx out02,5
      .list
	out	(c),(pc+lxofc+out02)	;FD ED 41p22q11
      .nlist
      .pcr_lclx out03,5
      .list
	out	(c),[lxofc+out03]	;FD ED 41p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn out01,lxofc,5
      .list
	out	(c),out01(pc)		;FD ED 41 22 11
      .nlist
      .pcr_xtrn out02,lxofc,5
      .list
	out	(c),(pc+out02)		;FD ED 41 22 11
      .nlist
      .pcr_xtrn out03,lxofc,5
      .list
	out	(c),[out03]		;FD ED 41 22 11
      .nlist
    .else
      .pcr_lclx out01,5
      .list
	out	(c),lxofc+out01(pc)	;FD ED 41 22 11
      .nlist
      .pcr_lclx out02,5
      .list
	out	(c),(pc+lxofc+out02)	;FD ED 41 22 11
      .nlist
      .pcr_lclx out03,5
      .list
	out	(c),[lxofc+out03]	;FD ED 41 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	out	(c),lxoff(pc)		;FD ED 41p22q11
	out	(c),(pc+lxoff)		;FD ED 41p22q11
	out	(c),[lxoff]		;FD ED 41p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc,5
      .list
	out	(c),pcr_ofst(pc)	;FD ED 41 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	out	(c),(pc+pcr_ofst)	;FD ED 41 22 11
      .nlist
	.pcr_ofst lxofc,5
      .list
	out	(c),[pcr_ofst]		;FD ED 41 22 11
    .nlist
  .endif
.list  ; end<--
	out	(c),[.+offsetc]		;FD ED 41 50 00
	out	(c),(hl+ix)		;DD ED 49
	out	(c),(hl+iy)		;DD ED 51
	out	(c),(ix+iy)		;DD ED 59
	;***********************************************************
	; load output port (n) with 'a'
	.z80
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
 	out	(n),a			;D3r00
	out	n,a			;D3r00
     .nlist
    .else
      .list
	out	(n),a			;D3r20
	out	n,a			;D3r20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	out	(n),a			;D3 20
	out	n,a			;D3 20
    .nlist
  .endif
.list  ; end<--

;*******************************************************************
;	OUTD	
;*******************************************************************
	;***********************************************************
	; load output port (c)
	; with location (hl)
	; decrement hl and decrement b
	.z80
	outd				;ED AB

;*******************************************************************
;	OUTI	
;*******************************************************************
	;***********************************************************
	; load output port (c)
	; with location (hl)
	; increment hl and decrement b
	.z80
	outi				;ED A3

;*******************************************************************
;	OUTDW	
;*******************************************************************
	;***********************************************************
	.z280
	outdw				;ED 8B
	outiw				;ED 83
	otdrw				;ED 9B
	otirw				;ED 93

;*******************************************************************
;	OUTW	
;*******************************************************************
	;***********************************************************
	;  p. 5-110	output to word port
	.z280
	out	(c),hl			;ED BF
	outw	(c),hl			;ED BF

;*******************************************************************
;	PCACHE	
;*******************************************************************
	;***********************************************************
	;  p. 5-111    NOT privileged
	.z280
	pcache				;ED 65

;*******************************************************************
;	POP	
;*******************************************************************
	;***********************************************************
	; load destination with top of stack
	.z80
	pop	af			;F1
	pop	bc			;C1
	pop	de			;D1
	pop	hl			;E1
	pop	ix			;DD E1
	pop	iy			;FD E1
	.z280
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	pop	(daddr)			;DD D1r00s00
      .nlist
    .else
      .list
	pop	(daddr)			;DD D1r44s33
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	pop	(daddr)			;DD D1 44 33
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn pop01,lxofc
      .list
	pop	pop01(pc)		;DD F1p00q00
      .nlist
      .pcr_xtrn pop02,lxofc
      .list
	pop	(pc+pop02)		;DD F1p00q00
      .nlist
      .pcr_xtrn pop03,lxofc
      .list
	pop	[pop03]			;DD F1p00q00
      .nlist
    .else
      .pcr_lclx pop01
      .list
	pop	lxofc+pop01(pc)		;DD F1p22q11
      .nlist
      .pcr_lclx pop02
      .list
	pop	(pc+lxofc+pop02)	;DD F1p22q11
      .nlist
      .pcr_lclx pop03
      .list
	pop	[lxofc+pop03]		;DD F1p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn pop01,lxofc
      .list
	pop	pop01(pc)		;DD F1 22 11
      .nlist
      .pcr_xtrn pop02,lxofc
      .list
	pop	(pc+pop02)		;DD F1 22 11
      .nlist
      .pcr_xtrn pop03,lxofc
      .list
	pop	[pop03]			;DD F1 22 11
      .nlist
    .else
      .pcr_lclx pop01
      .list
	pop	lxofc+pop01(pc)		;DD F1 22 11
      .nlist
      .pcr_lclx pop02
      .list
	pop	(pc+lxofc+pop02)	;DD F1 22 11
      .nlist
      .pcr_lclx pop03
      .list
	pop	[lxofc+pop03]		;DD F1 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	pop	lxoff(pc)		;DD F1p22q11
	pop	(pc+lxoff)		;DD F1p22q11
	pop	[lxoff]			;DD F1p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc
      .list
	pop	pcr_ofst(pc)		;DD F1 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	pop	(pc+pcr_ofst)		;DD F1 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	pop	[pcr_ofst]		;DD F1 22 11
    .nlist
  .endif
.list  ; end<--
	pop	[.+lxofc]		;DD F1 1E 11
	pop	(hl)			;DD C1

;*******************************************************************
;	PUSH	
;*******************************************************************
	;***********************************************************
	; put source on stack
	.z80
	push	af			;F5
	push	bc			;C5
	push	de			;D5
	push	hl			;E5
	push	ix			;DD E5
	push	iy			;FD E5
	.z280
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	push	(daddr)			;DD D5r00s00
	push	#nn			;FD F5r00s00
      .nlist
    .else
      .list
	push	(daddr)			;DD D5r44s33
	push	#nn			;FD F5r84s05
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	push	(daddr)			;DD D5 44 33
	push	#nn			;FD F5 84 05
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn push01,lxofc
      .list
	push	push01(pc)		;DD F5p00q00
      .nlist
      .pcr_xtrn push02,lxofc
      .list
	push	(pc+push02)		;DD F5p00q00
      .nlist
      .pcr_xtrn push03,lxofc
      .list
	push	[push03]		;DD F5p00q00
      .nlist
    .else
      .pcr_lclx push01
      .list
	push	lxofc+push01(pc)	;DD F5p22q11
      .nlist
      .pcr_lclx push02
      .list
	push	(pc+lxofc+push02)	;DD F5p22q11
      .nlist
      .pcr_lclx push03
      .list
	push	[lxofc+push03]		;DD F5p22q11
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn push01,lxofc
      .list
	push	push01(pc)		;DD F5 22 11
      .nlist
      .pcr_xtrn push02,lxofc
      .list
	push	(pc+push02)		;DD F5 22 11
      .nlist
      .pcr_xtrn push03,lxofc
      .list
	push	[push03]		;DD F5 22 11
      .nlist
    .else
      .pcr_lclx push01
      .list
	push	lxofc+push01(pc)	;DD F5 22 11
      .nlist
      .pcr_lclx push02
      .list
	push	(pc+lxofc+push02)	;DD F5 22 11
      .nlist
      .pcr_lclx push03
      .list
	push	[lxofc+push03]		;DD F5 22 11
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	push	lxoff(pc)		;DD F5p22q11
	push	(pc+lxoff)		;DD F5p22q11
	push	[lxoff]			;DD F5p22q11
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst lxofc
      .list
	push	pcr_ofst(pc)		;DD F5 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	push	(pc+pcr_ofst)		;DD F5 22 11
      .nlist
	.pcr_ofst lxofc
      .list
	push	[pcr_ofst]		;DD F5 22 11
    .nlist
  .endif
.list  ; end<--
	push	[.+lxofc]		;DD F5 1E 11
	push	(hl)			;DD C5

;*******************************************************************
;	RES	
;*******************************************************************
	;***********************************************************
	; reset bit of location or register
	.z80
	res	0,(hl)			;CB 86
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	res	0,offset(ix)		;DD CBr00 86
	res	0,offset(iy)		;FD CBr00 86
	res	0,(ix+offset)		;DD CBr00 86
	res	0,(iy+offset)		;FD CBr00 86
      .nlist
    .else
      .list
	res	0,offset(ix)		;DD CBr55 86
	res	0,offset(iy)		;FD CBr55 86
	res	0,(ix+offset)		;DD CBr55 86
	res	0,(iy+offset)		;FD CBr55 86
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	res	0,offset(ix)		;DD CB 55 86
	res	0,offset(iy)		;FD CB 55 86
	res	0,(ix+offset)		;DD CB 55 86
	res	0,(iy+offset)		;FD CB 55 86
    .nlist
  .endif
.list  ; end<--
	res	0,a			;CB 87
	res	0,b			;CB 80
	res	0,c			;CB 81
	res	0,d			;CB 82
	res	0,e			;CB 83
	res	0,h			;CB 84
	res	0,l			;CB 85
	res	1,(hl)			;CB 8E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	res	1,offset(ix)		;DD CBr00 8E
	res	1,offset(iy)		;FD CBr00 8E
	res	1,(ix+offset)		;DD CBr00 8E
	res	1,(iy+offset)		;FD CBr00 8E
      .nlist
    .else
      .list
	res	1,offset(ix)		;DD CBr55 8E
	res	1,offset(iy)		;FD CBr55 8E
	res	1,(ix+offset)		;DD CBr55 8E
	res	1,(iy+offset)		;FD CBr55 8E
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	res	1,offset(ix)		;DD CB 55 8E
	res	1,offset(iy)		;FD CB 55 8E
	res	1,(ix+offset)		;DD CB 55 8E
	res	1,(iy+offset)		;FD CB 55 8E
    .nlist
  .endif
.list  ; end<--
	res	1,a			;CB 8F
	res	1,b			;CB 88
	res	1,c			;CB 89
	res	1,d			;CB 8A
	res	1,e			;CB 8B
	res	1,h			;CB 8C
	res	1,l			;CB 8D
	res	2,(hl)			;CB 96
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	res	2,offset(ix)		;DD CBr00 96
	res	2,offset(iy)		;FD CBr00 96
	res	2,(ix+offset)		;DD CBr00 96
	res	2,(iy+offset)		;FD CBr00 96
      .nlist
    .else
      .list
	res	2,offset(ix)		;DD CBr55 96
	res	2,offset(iy)		;FD CBr55 96
	res	2,(ix+offset)		;DD CBr55 96
	res	2,(iy+offset)		;FD CBr55 96
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	res	2,offset(ix)		;DD CB 55 96
	res	2,offset(iy)		;FD CB 55 96
	res	2,(ix+offset)		;DD CB 55 96
	res	2,(iy+offset)		;FD CB 55 96
    .nlist
  .endif
.list  ; end<--
	res	2,a			;CB 97
	res	2,b			;CB 90
	res	2,c			;CB 91
	res	2,d			;CB 92
	res	2,e			;CB 93
	res	2,h			;CB 94
	res	2,l			;CB 95
	res	3,(hl)			;CB 9E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	res	3,offset(ix)		;DD CBr00 9E
	res	3,offset(iy)		;FD CBr00 9E
	res	3,(ix+offset)		;DD CBr00 9E
	res	3,(iy+offset)		;FD CBr00 9E
      .nlist
    .else
      .list
	res	3,offset(ix)		;DD CBr55 9E
	res	3,offset(iy)		;FD CBr55 9E
	res	3,(ix+offset)		;DD CBr55 9E
	res	3,(iy+offset)		;FD CBr55 9E
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	res	3,offset(ix)		;DD CB 55 9E
	res	3,offset(iy)		;FD CB 55 9E
	res	3,(ix+offset)		;DD CB 55 9E
	res	3,(iy+offset)		;FD CB 55 9E
    .nlist
  .endif
.list  ; end<--
	res	3,a			;CB 9F
	res	3,b			;CB 98
	res	3,c			;CB 99
	res	3,d			;CB 9A
	res	3,e			;CB 9B
	res	3,h			;CB 9C
	res	3,l			;CB 9D
	res	4,(hl)			;CB A6
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
 	res	4,offset(ix)		;DD CBr00 A6
	res	4,offset(iy)		;FD CBr00 A6
	res	4,(ix+offset)		;DD CBr00 A6
	res	4,(iy+offset)		;FD CBr00 A6
     .nlist
    .else
      .list
	res	4,offset(ix)		;DD CBr55 A6
	res	4,offset(iy)		;FD CBr55 A6
	res	4,(ix+offset)		;DD CBr55 A6
	res	4,(iy+offset)		;FD CBr55 A6
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	res	4,offset(ix)		;DD CB 55 A6
	res	4,offset(iy)		;FD CB 55 A6
	res	4,(ix+offset)		;DD CB 55 A6
	res	4,(iy+offset)		;FD CB 55 A6
    .nlist
  .endif
.list  ; end<--
	res	4,a			;CB A7
	res	4,b			;CB A0
	res	4,c			;CB A1
	res	4,d			;CB A2
	res	4,e			;CB A3
	res	4,h			;CB A4
	res	4,l			;CB A5
	res	5,(hl)			;CB AE
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	res	5,offset(ix)		;DD CBr00 AE
	res	5,offset(iy)		;FD CBr00 AE
	res	5,(ix+offset)		;DD CBr00 AE
	res	5,(iy+offset)		;FD CBr00 AE
      .nlist
    .else
      .list
	res	5,offset(ix)		;DD CBr55 AE
	res	5,offset(iy)		;FD CBr55 AE
	res	5,(ix+offset)		;DD CBr55 AE
	res	5,(iy+offset)		;FD CBr55 AE
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	res	5,offset(ix)		;DD CB 55 AE
	res	5,offset(iy)		;FD CB 55 AE
	res	5,(ix+offset)		;DD CB 55 AE
	res	5,(iy+offset)		;FD CB 55 AE
    .nlist
  .endif
.list  ; end<--
	res	5,a			;CB AF
	res	5,b			;CB A8
	res	5,c			;CB A9
	res	5,d			;CB AA
	res	5,e			;CB AB
	res	5,h			;CB AC
	res	5,l			;CB AD
	res	6,(hl)			;CB B6
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	res	6,offset(ix)		;DD CBr00 B6
	res	6,offset(iy)		;FD CBr00 B6
	res	6,(ix+offset)		;DD CBr00 B6
	res	6,(iy+offset)		;FD CBr00 B6
      .nlist
    .else
      .list
	res	6,offset(ix)		;DD CBr55 B6
	res	6,offset(iy)		;FD CBr55 B6
	res	6,(ix+offset)		;DD CBr55 B6
	res	6,(iy+offset)		;FD CBr55 B6
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	res	6,offset(ix)		;DD CB 55 B6
	res	6,offset(iy)		;FD CB 55 B6
	res	6,(ix+offset)		;DD CB 55 B6
	res	6,(iy+offset)		;FD CB 55 B6
    .nlist
  .endif
.list  ; end<--
	res	6,a			;CB B7
	res	6,b			;CB B0
	res	6,c			;CB B1
	res	6,d			;CB B2
	res	6,e			;CB B3
	res	6,h			;CB B4
	res	6,l			;CB B5
	res	7,(hl)			;CB BE
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	res	7,offset(ix)		;DD CBr00 BE
	res	7,offset(iy)		;FD CBr00 BE
	res	7,(ix+offset)		;DD CBr00 BE
	res	7,(iy+offset)		;FD CBr00 BE
      .nlist
    .else
      .list
	res	7,offset(ix)		;DD CBr55 BE
	res	7,offset(iy)		;FD CBr55 BE
	res	7,(ix+offset)		;DD CBr55 BE
	res	7,(iy+offset)		;FD CBr55 BE
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	res	7,offset(ix)		;DD CB 55 BE
	res	7,offset(iy)		;FD CB 55 BE
	res	7,(ix+offset)		;DD CB 55 BE
	res	7,(iy+offset)		;FD CB 55 BE
    .nlist
  .endif
.list  ; end<--
	res	7,a			;CB BF
	res	7,b			;CB B8
	res	7,c			;CB B9
	res	7,d			;CB BA
	res	7,e			;CB BB
	res	7,h			;CB BC
	res	7,l			;CB BD

;*******************************************************************
;	RET	
;*******************************************************************
	;***********************************************************
	; return from subroutine
	.z80
	ret				;C9
	;***********************************************************
	; return from subroutine if condition is true
	ret	C			;D8
	ret	M			;F8
	ret	NC			;D0
	ret	NZ			;C0
	ret	P			;F0
	ret	PE			;E8
	ret	PO			;E0
	ret	Z			;C8

;*******************************************************************
;	RETI	
;*******************************************************************
	;***********************************************************
	; return from interrupt (privileged)
	.z80
	reti				;ED 4D

;*******************************************************************
;	RETN	
;*******************************************************************
	;***********************************************************
	; return from non-maskable interrupt (privileged)
	.z80
	retn				;ED 45

;*******************************************************************
;	RETIL	
;*******************************************************************
	;***********************************************************
	; return from interrupt (long)
	.z280p
	retil				;ED 55

;*******************************************************************
;	RL	
;*******************************************************************
.nlist
.ifne ODDBALL_SHIFT_ROTATE
  .list
	;***********************************************************
	; rotate left through carry
	.z80
	rl	a,(hl)			;CB 16
  .nlist ; -->bgn
    .ifeq _XL_				; (.ext/.lst)
      .ifdef .EXLR
        .list
	rl	a,offset(ix)		;DD CBr00 16
	rl	a,offset(iy)		;FD CBr00 16
	rl	a,(ix+offset)		;DD CBr00 16
	rl	a,(iy+offset)		;FD CBr00 16
        .nlist
      .else
        .list
	rl	a,offset(ix)		;DD CBr55 16
	rl	a,offset(iy)		;FD CBr55 16
	rl	a,(ix+offset)		;DD CBr55 16
	rl	a,(iy+offset)		;FD CBr55 16
        .nlist
      .endif
    .else				; (.ext/.rst) (.con/.lst) or (.con/.rst)
      .list
	rl	a,offset(ix)		;DD CB 55 16
	rl	a,offset(iy)		;FD CB 55 16
	rl	a,(ix+offset)		;DD CB 55 16
	rl	a,(iy+offset)		;FD CB 55 16
      .nlist
    .endif
  .list  ; end<--
	rl	a,a			;CB 17
	rl	a,b			;CB 10
	rl	a,c			;CB 11
	rl	a,d			;CB 12
	rl	a,e			;CB 13
	rl	a,h			;CB 14
	rl	a,l			;CB 15

  .nlist
.endif
.list
	;***********************************************************
	; rotate left through carry
	.z80
	rl	(hl)			;CB 16
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	rl	offset(ix)		;DD CBr00 16
	rl	offset(iy)		;FD CBr00 16
	rl	(ix+offset)		;DD CBr00 16
	rl	(iy+offset)		;FD CBr00 16
      .nlist
    .else
      .list
	rl	offset(ix)		;DD CBr55 16
	rl	offset(iy)		;FD CBr55 16
	rl	(ix+offset)		;DD CBr55 16
	rl	(iy+offset)		;FD CBr55 16
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	rl	offset(ix)		;DD CB 55 16
	rl	offset(iy)		;FD CB 55 16
	rl	(ix+offset)		;DD CB 55 16
	rl	(iy+offset)		;FD CB 55 16
    .nlist
  .endif
.list  ; end<--
	rl	a			;CB 17
	rl	b			;CB 10
	rl	c			;CB 11
	rl	d			;CB 12
	rl	e			;CB 13
	rl	h			;CB 14
	rl	l			;CB 15

;*******************************************************************
;	RLA	
;*******************************************************************
	;***********************************************************
	; rotate left 'a' with carry
	.z80
	rla				;17

;*******************************************************************
;	RLC	
;*******************************************************************
.nlist
.ifne ODDBALL_SHIFT_ROTATE
  .list
	;***********************************************************
	; rotate left circular
	.z80
	rlc	a,(hl)			;CB 06
  .nlist ; -->bgn
    .ifeq _XL_				; (.ext/.lst)
      .ifdef .EXLR
        .list
	rlc	a,offset(ix)		;DD CBr00 06
	rlc	a,offset(iy)		;FD CBr00 06
	rlc	a,(ix+offset)		;DD CBr00 06
	rlc	a,(iy+offset)		;FD CBr00 06
        .nlist
      .else
        .list
	rlc	a,offset(ix)		;DD CBr55 06
	rlc	a,offset(iy)		;FD CBr55 06
	rlc	a,(ix+offset)		;DD CBr55 06
	rlc	a,(iy+offset)		;FD CBr55 06
        .nlist
      .endif
    .else				; (.ext/.rst) (.con/.lst) or (.con/.rst)
      .list
	rlc	a,offset(ix)		;DD CB 55 06
	rlc	a,offset(iy)		;FD CB 55 06
	rlc	a,(ix+offset)		;DD CB 55 06
	rlc	a,(iy+offset)		;FD CB 55 06
      .nlist
    .endif
  .list  ; end<--
	rlc	a,a			;CB 07
	rlc	a,b			;CB 00
	rlc	a,c			;CB 01
	rlc	a,d			;CB 02
	rlc	a,e			;CB 03
	rlc	a,h			;CB 04
	rlc	a,l			;CB 05

  .nlist
.endif
.list
	;***********************************************************
	; rotate left circular
	.z80
	rlc	(hl)			;CB 06
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	rlc	offset(ix)		;DD CBr00 06
	rlc	offset(iy)		;FD CBr00 06
	rlc	(ix+offset)		;DD CBr00 06
	rlc	(iy+offset)		;FD CBr00 06
      .nlist
    .else
      .list
	rlc	offset(ix)		;DD CBr55 06
	rlc	offset(iy)		;FD CBr55 06
	rlc	(ix+offset)		;DD CBr55 06
	rlc	(iy+offset)		;FD CBr55 06
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	rlc	offset(ix)		;DD CB 55 06
	rlc	offset(iy)		;FD CB 55 06
	rlc	(ix+offset)		;DD CB 55 06
	rlc	(iy+offset)		;FD CB 55 06
    .nlist
  .endif
.list  ; end<--
	rlc	a			;CB 07
	rlc	b			;CB 00
	rlc	c			;CB 01
	rlc	d			;CB 02
	rlc	e			;CB 03
	rlc	h			;CB 04
	rlc	l			;CB 05

;*******************************************************************
;	RLCA	
;*******************************************************************
	;***********************************************************
	; rotate left 'a' circular
	.z80
	rlca				;07

;*******************************************************************
;	RLD	
;*******************************************************************
	;***********************************************************
	; rotate digit left and right
	; between 'a' and location (hl)
	.z80
	rld				;ED 6F

;*******************************************************************
;	RR	
;*******************************************************************
.nlist
.ifne ODDBALL_SHIFT_ROTATE
  .list
	;***********************************************************
	; rotate right through carry
	.z80
	rr	a,(hl)			;CB 1E
  .nlist ; -->bgn
    .ifeq _XL_				; (.ext/.lst)
      .ifdef .EXLR
        .list
	rr	a,offset(ix)		;DD CBr00 1E
	rr	a,offset(iy)		;FD CBr00 1E
	rr	a,(ix+offset)		;DD CBr00 1E
	rr	a,(iy+offset)		;FD CBr00 1E
        .nlist
      .else
        .list
	rr	a,offset(ix)		;DD CBr55 1E
	rr	a,offset(iy)		;FD CBr55 1E
	rr	a,(ix+offset)		;DD CBr55 1E
	rr	a,(iy+offset)		;FD CBr55 1E
        .nlist
      .endif
    .else				; (.ext/.rst) (.con/.lst) or (.con/.rst)
      .list
	rr	a,offset(ix)		;DD CB 55 1E
	rr	a,offset(iy)		;FD CB 55 1E
	rr	a,(ix+offset)		;DD CB 55 1E
	rr	a,(iy+offset)		;FD CB 55 1E
      .nlist
    .endif
  .list  ; end<--
	rr	a,a			;CB 1F
	rr	a,b			;CB 18
	rr	a,c			;CB 19
	rr	a,d			;CB 1A
	rr	a,e			;CB 1B
	rr	a,h			;CB 1C
	rr	a,l			;CB 1D

  .nlist
.endif
.list
	;***********************************************************
	; rotate right through carry
	.z80
	rr	(hl)			;CB 1E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	rr	offset(ix)		;DD CBr00 1E
	rr	offset(iy)		;FD CBr00 1E
	rr	(ix+offset)		;DD CBr00 1E
	rr	(iy+offset)		;FD CBr00 1E
      .nlist
    .else
      .list
	rr	offset(ix)		;DD CBr55 1E
	rr	offset(iy)		;FD CBr55 1E
	rr	(ix+offset)		;DD CBr55 1E
	rr	(iy+offset)		;FD CBr55 1E
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	rr	offset(ix)		;DD CB 55 1E
	rr	offset(iy)		;FD CB 55 1E
	rr	(ix+offset)		;DD CB 55 1E
	rr	(iy+offset)		;FD CB 55 1E
    .nlist
  .endif
.list  ; end<--
	rr	a			;CB 1F
	rr	b			;CB 18
	rr	c			;CB 19
	rr	d			;CB 1A
	rr	e			;CB 1B
	rr	h			;CB 1C
	rr	l			;CB 1D

;*******************************************************************
;	RRA	
;*******************************************************************
	;***********************************************************
	; rotate 'a' right with carry
	.z80
	rra				;1F

;*******************************************************************
;	RRC	
;*******************************************************************
.nlist
.ifne ODDBALL_SHIFT_ROTATE
  .list
	;***********************************************************
	; rotate right circular
	.z80
	rrc	a,(hl)			;CB 0E
  .nlist ; -->bgn
    .ifeq _XL_				; (.ext/.lst)
      .ifdef .EXLR
        .list
	rrc	a,offset(ix)		;DD CBr00 0E
	rrc	a,offset(iy)		;FD CBr00 0E
	rrc	a,(ix+offset)		;DD CBr00 0E
	rrc	a,(iy+offset)		;FD CBr00 0E
        .nlist
      .else
        .list
	rrc	a,offset(ix)		;DD CBr55 0E
	rrc	a,offset(iy)		;FD CBr55 0E
	rrc	a,(ix+offset)		;DD CBr55 0E
	rrc	a,(iy+offset)		;FD CBr55 0E
        .nlist
      .endif
    .else				; (.ext/.rst) (.con/.lst) or (.con/.rst)
      .list
	rrc	a,offset(ix)		;DD CB 55 0E
	rrc	a,offset(iy)		;FD CB 55 0E
	rrc	a,(ix+offset)		;DD CB 55 0E
	rrc	a,(iy+offset)		;FD CB 55 0E
      .nlist
    .endif
  .list	 ; end<--
	rrc	a,a			;CB 0F
	rrc	a,b			;CB 08
	rrc	a,c			;CB 09
	rrc	a,d			;CB 0A
	rrc	a,e			;CB 0B
	rrc	a,h			;CB 0C
	rrc	a,l			;CB 0D

  .nlist
.endif
.list
	;***********************************************************
	; rotate right circular
	.z80
	rrc	(hl)			;CB 0E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	rrc	offset(ix)		;DD CBr00 0E
	rrc	offset(iy)		;FD CBr00 0E
	rrc	(ix+offset)		;DD CBr00 0E
	rrc	(iy+offset)		;FD CBr00 0E
      .nlist
    .else
      .list
	rrc	offset(ix)		;DD CBr55 0E
	rrc	offset(iy)		;FD CBr55 0E
	rrc	(ix+offset)		;DD CBr55 0E
	rrc	(iy+offset)		;FD CBr55 0E
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	rrc	offset(ix)		;DD CB 55 0E
	rrc	offset(iy)		;FD CB 55 0E
	rrc	(ix+offset)		;DD CB 55 0E
	rrc	(iy+offset)		;FD CB 55 0E
    .nlist
  .endif
.list  ; end<--
	rrc	a			;CB 0F
	rrc	b			;CB 08
	rrc	c			;CB 09
	rrc	d			;CB 0A
	rrc	e			;CB 0B
	rrc	h			;CB 0C
	rrc	l			;CB 0D

;*******************************************************************
;	RRCA	
;*******************************************************************
	.z80
	;***********************************************************
	; rotate 'a' right circular
	rrca				;0F

;*******************************************************************
;	RRD	
;*******************************************************************
	;***********************************************************
	; rotate digit right and left
	; between 'a' and location (hl)
	.z80
	rrd				;ED 67

;*******************************************************************
;	RST	
;*******************************************************************
	;***********************************************************
	; restart location
	.z80
	rst	0x00			;C7
	rst	0x08			;CF
	rst	0x10			;D7
	rst	0x18			;DF
	rst	0x20			;E7
	rst	0x28			;EF
	rst	0x30			;F7
	rst	0x38			;FF

;*******************************************************************
;	SBC	
;		Leading 'a' operand is optional.
;		If offset is ommitted 0 is assumed.
;*******************************************************************
	;***********************************************************
	; subtract with carry to 'a'
	.z80
	sbc	a,(hl)			;9E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
 	sbc	a,offset(ix)		;DD 9Er00
	sbc	a,offset(iy)		;FD 9Er00
	sbc	a,(ix+offset)		;DD 9Er00
	sbc	a,(iy+offset)		;FD 9Er00
     .nlist
    .else
      .list
	sbc	a,offset(ix)		;DD 9Er55
	sbc	a,offset(iy)		;FD 9Er55
	sbc	a,(ix+offset)		;DD 9Er55
	sbc	a,(iy+offset)		;FD 9Er55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	sbc	a,offset(ix)		;DD 9E 55
	sbc	a,offset(iy)		;FD 9E 55
	sbc	a,(ix+offset)		;DD 9E 55
	sbc	a,(iy+offset)		;FD 9E 55
    .nlist
  .endif
.list  ; end<--
	sbc	a,a			;9F
	sbc	a,b			;98
	sbc	a,c			;99
	sbc	a,d			;9A
	sbc	a,e			;9B
	sbc	a,h			;9C
	sbc	a,l			;9D
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	sbc	a,#n			;DEr00
	sbc	a, n			;DEr00
      .nlist
    .else
      .list
	sbc	a,#n			;DEr20
	sbc	a, n			;DEr20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	sbc	a,#n			;DE 20
	sbc	a, n			;DE 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	; subtract with carry to 'a'
	.z80
	sbc	(hl)			;9E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	sbc	offset(ix)		;DD 9Er00
	sbc	offset(iy)		;FD 9Er00
	sbc	(ix+offset)		;DD 9Er00
	sbc	(iy+offset)		;FD 9Er00
      .nlist
    .else
      .list
	sbc	offset(ix)		;DD 9Er55
	sbc	offset(iy)		;FD 9Er55
	sbc	(ix+offset)		;DD 9Er55
	sbc	(iy+offset)		;FD 9Er55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	sbc	offset(ix)		;DD 9E 55
	sbc	offset(iy)		;FD 9E 55
	sbc	(ix+offset)		;DD 9E 55
	sbc	(iy+offset)		;FD 9E 55
    .nlist
  .endif
.list  ; end<--
	sbc	a			;9F
	sbc	b			;98
	sbc	c			;99
	sbc	d			;9A
	sbc	e			;9B
	sbc	h			;9C
	sbc	l			;9D
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
 	sbc	#n			;DEr00
	sbc	 n			;DEr00
     .nlist
    .else
      .list
	sbc	#n			;DEr20
	sbc	 n			;DEr20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	sbc	#n			;DE 20
	sbc	 n			;DE 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	; add with carry register pair to 'hl'
	sbc	hl,bc			;ED 42
	sbc	hl,de			;ED 52
	sbc	hl,hl			;ED 62
	sbc	hl,sp			;ED 72
	;***********************************************************
	;  p. 5-130
	.z280
	sbc	a,ixh			;DD 9C
	sbc	a,ixl			;DD 9D
	sbc	a,iyh			;FD 9C
	sbc	a,iyl			;FD 9D
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	sbc	a,#n			;DEr00
	sbc	a,(daddr)		;DD 9Fr00s00
	sbc	a,sxoff(ix)		;FD 99r00s00
	sbc	a,(ix+sxoff)		;FD 99r00s00
	sbc	a,sxoff(iy)		;FD 9Ar00s00
	sbc	a,(iy+sxoff)		;FD 9Ar00s00
	sbc	a,sxoff(hl)		;FD 9Br00s00
	sbc	a,(hl+sxoff)		;FD 9Br00s00
	sbc	a,sxoff(sp)		;DD 98r00s00
	sbc	a,(sp+sxoff)		;DD 98r00s00
	sbc	a,lxoff(ix)		;FD 99r00s00
	sbc	a,(ix+lxoff)		;FD 99r00s00
	sbc	a,lxoff(iy)		;FD 9Ar00s00
	sbc	a,(iy+lxoff)		;FD 9Ar00s00
	sbc	a,lxoff(hl)		;FD 9Br00s00
	sbc	a,(hl+lxoff)		;FD 9Br00s00
	sbc	a,lxoff(sp)		;DD 98r00s00
	sbc	a,(sp+lxoff)		;DD 98r00s00
      .nlist
    .else
      .list
	sbc	a,#n			;DEr20
	sbc	a,(daddr)		;DD 9Fr44s33
	sbc	a,sxoff(ix)		;FD 99r55s00
	sbc	a,(ix+sxoff)		;FD 99r55s00
	sbc	a,sxoff(iy)		;FD 9Ar55s00
	sbc	a,(iy+sxoff)		;FD 9Ar55s00
	sbc	a,sxoff(hl)		;FD 9Br55s00
	sbc	a,(hl+sxoff)		;FD 9Br55s00
	sbc	a,sxoff(sp)		;DD 98r55s00
	sbc	a,(sp+sxoff)		;DD 98r55s00
	sbc	a,lxoff(ix)		;FD 99r22s11
	sbc	a,(ix+lxoff)		;FD 99r22s11
	sbc	a,lxoff(iy)		;FD 9Ar22s11
	sbc	a,(iy+lxoff)		;FD 9Ar22s11
	sbc	a,lxoff(hl)		;FD 9Br22s11
	sbc	a,(hl+lxoff)		;FD 9Br22s11
	sbc	a,lxoff(sp)		;DD 98r22s11
	sbc	a,(sp+lxoff)		;DD 98r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	sbc	a,#n			;DE 20
	sbc	a,(daddr)		;DD 9F 44 33
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	sbc	a,sxoff(ix)		;FD 99 55 00
	sbc	a,(ix+sxoff)		;FD 99 55 00
	sbc	a,sxoff(iy)		;FD 9A 55 00
	sbc	a,(iy+sxoff)		;FD 9A 55 00
      .nlist
    .else				; (.con/.lst) or (.con/.rst)
      .list
	sbc	a,sxoff(ix)		;DD 9E 55
	sbc	a,(ix+sxoff)		;DD 9E 55
	sbc	a,sxoff(iy)		;FD 9E 55
	sbc	a,(iy+sxoff)		;FD 9E 55
      .nlist
    .endif
    .list
	sbc	a,sxoff(hl)		;FD 9B 55 00
	sbc	a,(hl+sxoff)		;FD 9B 55 00
	sbc	a,sxoff(sp)		;DD 98 55 00
	sbc	a,(sp+sxoff)		;DD 98 55 00
	sbc	a,lxoff(ix)		;FD 99 22 11
	sbc	a,(ix+lxoff)		;FD 99 22 11
	sbc	a,lxoff(iy)		;FD 9A 22 11
	sbc	a,(iy+lxoff)		;FD 9A 22 11
	sbc	a,lxoff(hl)		;FD 9B 22 11
	sbc	a,(hl+lxoff)		;FD 9B 22 11
	sbc	a,lxoff(sp)		;DD 98 22 11
	sbc	a,(sp+lxoff)		;DD 98 22 11
    .nlist
  .endif
.list  ; end<--
	sbc	a,(ix)			;DD 9E 00
	sbc	a,(iy)			;FD 9E 00
	sbc	a,(hl)			;9E
	sbc	a,(sp)			;DD 98 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn sbc01,raofc
      .list
	sbc	a,sbc01(pc)		;FD 98p00q00
      .nlist
      .pcr_xtrn sbc02,raofc
      .list
	sbc	a,(pc+sbc02)		;FD 98p00q00
      .nlist
      .pcr_xtrn sbc03,raofc
      .list
	sbc	a,[sbc03]		;FD 98p00q00
      .nlist
    .else
      .pcr_lclx sbc01
      .list
	sbc	a,raofc+sbc01(pc)	;FD 98p34q12
      .nlist
      .pcr_lclx sbc02
      .list
	sbc	a,(pc+raofc+sbc02)	;FD 98p34q12
      .nlist
      .pcr_lclx sbc03
      .list
	sbc	a,[raofc+sbc03]		;FD 98p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn sbc01,raofc
      .list
	sbc	a,sbc01(pc)		;FD 98 34 12
      .nlist
      .pcr_xtrn sbc02,raofc
      .list
	sbc	a,(pc+sbc02)		;FD 98 34 12
      .nlist
      .pcr_xtrn sbc03,raofc
      .list
	sbc	a,[sbc03]		;FD 98 34 12
      .nlist
    .else
      .pcr_lclx sbc01
      .list
	sbc	a,raofc+sbc01(pc)	;FD 98 34 12
      .nlist
      .pcr_lclx sbc02
      .list
	sbc	a,(pc+raofc+sbc02)	;FD 98 34 12
      .nlist
      .pcr_lclx sbc03
      .list
	sbc	a,[raofc+sbc03]		;FD 98 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	sbc	a,raoff(pc)		;FD 98p34q12
	sbc	a,(pc+raoff)		;FD 98p34q12
	sbc	a,[raoff]		;FD 98p34q12
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	sbc	a,pcr_ofst(pc)		;FD 98 34 12
      .nlist
	.pcr_ofst raofc
      .list
	sbc	a,(pc+pcr_ofst)	;FD 98 34 12
      .nlist
	.pcr_ofst raofc
      .list
	sbc	a,[pcr_ofst]		;FD 98 34 12
    .nlist
  .endif
.list  ; end<--
	sbc	a,[.+nc]		;FD 98 1C 00
	sbc	a,(hl+ix)		;DD 99
	sbc	a,(hl+iy)		;DD 9A
	sbc	a,(ix+iy)		;DD 9B
	;***********************************************************
	;  p. 5-130
	.z280
	sbc	ixh			;DD 9C
	sbc	ixl			;DD 9D
	sbc	iyh			;FD 9C
	sbc	iyl			;FD 9D
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	sbc	#n			;DEr00
	sbc	(daddr)			;DD 9Fr00s00
	sbc	sxoff(ix)		;FD 99r00s00
	sbc	(ix+sxoff)		;FD 99r00s00
	sbc	sxoff(iy)		;FD 9Ar00s00
	sbc	(iy+sxoff)		;FD 9Ar00s00
	sbc	sxoff(hl)		;FD 9Br00s00
	sbc	(hl+sxoff)		;FD 9Br00s00
	sbc	sxoff(sp)		;DD 98r00s00
	sbc	(sp+sxoff)		;DD 98r00s00
	sbc	lxoff(ix)		;FD 99r00s00
	sbc	(ix+lxoff)		;FD 99r00s00
	sbc	lxoff(iy)		;FD 9Ar00s00
	sbc	(iy+lxoff)		;FD 9Ar00s00
	sbc	lxoff(hl)		;FD 9Br00s00
	sbc	(hl+lxoff)		;FD 9Br00s00
	sbc	lxoff(sp)		;DD 98r00s00
	sbc	(sp+lxoff)		;DD 98r00s00
      .nlist
    .else
      .list
	sbc	#n			;DEr20
	sbc	(daddr)			;DD 9Fr44s33
	sbc	sxoff(ix)		;FD 99r55s00
	sbc	(ix+sxoff)		;FD 99r55s00
	sbc	sxoff(iy)		;FD 9Ar55s00
	sbc	(iy+sxoff)		;FD 9Ar55s00
	sbc	sxoff(hl)		;FD 9Br55s00
	sbc	(hl+sxoff)		;FD 9Br55s00
	sbc	sxoff(sp)		;DD 98r55s00
	sbc	(sp+sxoff)		;DD 98r55s00
	sbc	lxoff(ix)		;FD 99r22s11
	sbc	(ix+lxoff)		;FD 99r22s11
	sbc	lxoff(iy)		;FD 9Ar22s11
	sbc	(iy+lxoff)		;FD 9Ar22s11
	sbc	lxoff(hl)		;FD 9Br22s11
	sbc	(hl+lxoff)		;FD 9Br22s11
	sbc	lxoff(sp)		;DD 98r22s11
	sbc	(sp+lxoff)		;DD 98r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	sbc	a,#n			;DE 20
	sbc	(daddr)			;DD 9F 44 33
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	sbc	sxoff(ix)		;FD 99 55 00
	sbc	(ix+sxoff)		;FD 99 55 00
	sbc	sxoff(iy)		;FD 9A 55 00
	sbc	(iy+sxoff)		;FD 9A 55 00
      .nlist
    .else				; (.con/.lst) or (.con/.rst)
      .list
	sbc	sxoff(ix)		;DD 9E 55
	sbc	(ix+sxoff)		;DD 9E 55
	sbc	sxoff(iy)		;FD 9E 55
	sbc	(iy+sxoff)		;FD 9E 55
      .nlist
    .endif
    .list
	sbc	sxoff(hl)		;FD 9B 55 00
	sbc	(hl+sxoff)		;FD 9B 55 00
	sbc	sxoff(sp)		;DD 98 55 00
	sbc	(sp+sxoff)		;DD 98 55 00
	sbc	lxoff(ix)		;FD 99 22 11
	sbc	(ix+lxoff)		;FD 99 22 11
	sbc	lxoff(iy)		;FD 9A 22 11
	sbc	(iy+lxoff)		;FD 9A 22 11
	sbc	lxoff(hl)		;FD 9B 22 11
	sbc	(hl+lxoff)		;FD 9B 22 11
	sbc	lxoff(sp)		;DD 98 22 11
	sbc	(sp+lxoff)		;DD 98 22 11
    .nlist
  .endif
.list  ; end<--
	sbc	(hl)			;9E
	sbc	(ix)			;DD 9E 00
	sbc	(iy)			;FD 9E 00
	sbc	(sp)			;DD 98 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn sbc04,raofc
      .list
	sbc	sbc04(pc)		;FD 98p00q00
      .nlist
      .pcr_xtrn sbc05,raofc
      .list
	sbc	(pc+sbc05)		;FD 98p00q00
      .nlist
      .pcr_xtrn sbc06,raofc
      .list
	sbc	[sbc06]			;FD 98p00q00
      .nlist
    .else
      .pcr_lclx sbc04
      .list
	sbc	raofc+sbc04(pc)		;FD 98p34q12
      .nlist
      .pcr_lclx sbc05
      .list
	sbc	(pc+raofc+sbc05)	;FD 98p34q12
      .nlist
      .pcr_lclx sbc06
      .list
	sbc	[raofc+sbc06]		;FD 98p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn sbc04,raofc
      .list
	sbc	sbc04(pc)		;FD 98 34 12
      .nlist
      .pcr_xtrn sbc05,raofc
      .list
	sbc	(pc+sbc05)		;FD 98 34 12
      .nlist
      .pcr_xtrn sbc06,raofc
      .list
	sbc	[sbc06]			;FD 98 34 12
      .nlist
    .else
      .pcr_lclx sbc04
      .list
	sbc	raofc+sbc04(pc)		;FD 98 34 12
      .nlist
      .pcr_lclx sbc05
      .list
	sbc	(pc+raofc+sbc05)	;FD 98 34 12
      .nlist
      .pcr_lclx sbc06
      .list
	sbc	[raofc+sbc06]		;FD 98 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	sbc	raoff(pc)		;FD 98p34q12
	sbc	(pc+raoff)		;FD 98p34q12
	sbc	[raoff]			;FD 98p34q12
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	sbc	pcr_ofst(pc)		;FD 98 34 12
      .nlist
	.pcr_ofst raofc
      .list
	sbc	(pc+pcr_ofst)		;FD 98 34 12
      .nlist
	.pcr_ofst raofc
      .list
	sbc	[pcr_ofst]		;FD 98 34 12
    .nlist
  .endif
.list  ; end<--
	sbc	[.+nc]			;FD 98 1C 00
	sbc	(hl+ix)			;DD 99
	sbc	(hl+iy)			;DD 9A
	sbc	(ix+iy)			;DD 9B
	;***********************************************************
	;  p. 5-131
	sbc	ix,bc			;DD ED 42
	sbc	ix,de			;DD ED 52
	sbc	ix,ix			;DD ED 62
	sbc	ix,sp			;DD ED 72
	sbc	iy,bc			;FD ED 42
	sbc	iy,de			;FD ED 52
	sbc	iy,iy			;FD ED 62
	sbc	iy,sp			;FD ED 72

;*******************************************************************
;	SC	
;*******************************************************************
	;***********************************************************
	; Z280 system call
	.z280
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
 	sc	n			;ED 71r00s00
	sc	#n			;ED 71r00s00
	sc	(n)			;ED 71r00s00
      .nlist
    .else
      .list
 	sc	n			;ED 71r20s00
	sc	#n			;ED 71r20s00
	sc	(n)			;ED 71r20s00
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	sc	n			;ED 71 20 00
	sc	#n			;ED 71 20 00
	sc	(n)			;ED 71 20 00
    .nlist
  .endif
.list  ; end<--

;*******************************************************************
;	SCF	
;*******************************************************************
	;***********************************************************
	; set carry flag (C=1)
	.z80
	scf				;37

;*******************************************************************
;	SET	
;*******************************************************************
	;***********************************************************
	; set bit of location or register
	.z80
	set	0,(hl)			;CB C6
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	set	0,offset(ix)		;DD CBr00 C6
	set	0,offset(iy)		;FD CBr00 C6
	set	0,(ix+offset)		;DD CBr00 C6
	set	0,(iy+offset)		;FD CBr00 C6
      .nlist
    .else
      .list
	set	0,offset(ix)		;DD CBr55 C6
	set	0,offset(iy)		;FD CBr55 C6
	set	0,(ix+offset)		;DD CBr55 C6
	set	0,(iy+offset)		;FD CBr55 C6
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	set	0,offset(ix)		;DD CB 55 C6
	set	0,offset(iy)		;FD CB 55 C6
	set	0,(ix+offset)		;DD CB 55 C6
	set	0,(iy+offset)		;FD CB 55 C6
    .nlist
  .endif
.list  ; end<--
	set	0,a			;CB C7
	set	0,b			;CB C0
	set	0,c			;CB C1
	set	0,d			;CB C2
	set	0,e			;CB C3
	set	0,h			;CB C4
	set	0,l			;CB C5
	set	1,(hl)			;CB CE
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	set	1,offset(ix)		;DD CBr00 CE
	set	1,offset(iy)		;FD CBr00 CE
	set	1,(ix+offset)		;DD CBr00 CE
	set	1,(iy+offset)		;FD CBr00 CE
      .nlist
    .else
      .list
	set	1,offset(ix)		;DD CBr55 CE
	set	1,offset(iy)		;FD CBr55 CE
	set	1,(ix+offset)		;DD CBr55 CE
	set	1,(iy+offset)		;FD CBr55 CE
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	set	1,offset(ix)		;DD CB 55 CE
	set	1,offset(iy)		;FD CB 55 CE
	set	1,(ix+offset)		;DD CB 55 CE
	set	1,(iy+offset)		;FD CB 55 CE
    .nlist
  .endif
.list  ; end<--
	set	1,a			;CB CF
	set	1,b			;CB C8
	set	1,c			;CB C9
	set	1,d			;CB CA
	set	1,e			;CB CB
	set	1,h			;CB CC
	set	1,l			;CB CD
	set	2,(hl)			;CB D6
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	set	2,offset(ix)		;DD CBr00 D6
	set	2,offset(iy)		;FD CBr00 D6
	set	2,(ix+offset)		;DD CBr00 D6
	set	2,(iy+offset)		;FD CBr00 D6
      .nlist
    .else
      .list
	set	2,offset(ix)		;DD CBr55 D6
	set	2,offset(iy)		;FD CBr55 D6
	set	2,(ix+offset)		;DD CBr55 D6
	set	2,(iy+offset)		;FD CBr55 D6
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	set	2,offset(ix)		;DD CB 55 D6
	set	2,offset(iy)		;FD CB 55 D6
	set	2,(ix+offset)		;DD CB 55 D6
	set	2,(iy+offset)		;FD CB 55 D6
    .nlist
  .endif
.list  ; end<--
	set	2,a			;CB D7
	set	2,b			;CB D0
	set	2,c			;CB D1
	set	2,d			;CB D2
	set	2,e			;CB D3
	set	2,h			;CB D4
	set	2,l			;CB D5
	set	3,(hl)			;CB DE
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	set	3,offset(ix)		;DD CBr00 DE
	set	3,offset(iy)		;FD CBr00 DE
	set	3,(ix+offset)		;DD CBr00 DE
	set	3,(iy+offset)		;FD CBr00 DE
      .nlist
    .else
      .list
	set	3,offset(ix)		;DD CBr55 DE
	set	3,offset(iy)		;FD CBr55 DE
	set	3,(ix+offset)		;DD CBr55 DE
	set	3,(iy+offset)		;FD CBr55 DE
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	set	3,offset(ix)		;DD CB 55 DE
	set	3,offset(iy)		;FD CB 55 DE
	set	3,(ix+offset)		;DD CB 55 DE
	set	3,(iy+offset)		;FD CB 55 DE
    .nlist
  .endif
.list  ; end<--
	set	3,a			;CB DF
	set	3,b			;CB D8
	set	3,c			;CB D9
	set	3,d			;CB DA
	set	3,e			;CB DB
	set	3,h			;CB DC
	set	3,l			;CB DD
	set	4,(hl)			;CB E6
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	set	4,offset(ix)		;DD CBr00 E6
	set	4,offset(iy)		;FD CBr00 E6
	set	4,(ix+offset)		;DD CBr00 E6
	set	4,(iy+offset)		;FD CBr00 E6
      .nlist
    .else
      .list
	set	4,offset(ix)		;DD CBr55 E6
	set	4,offset(iy)		;FD CBr55 E6
	set	4,(ix+offset)		;DD CBr55 E6
	set	4,(iy+offset)		;FD CBr55 E6
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	set	4,offset(ix)		;DD CB 55 E6
	set	4,offset(iy)		;FD CB 55 E6
	set	4,(ix+offset)		;DD CB 55 E6
	set	4,(iy+offset)		;FD CB 55 E6
    .nlist
  .endif
.list  ; end<--
	set	4,a			;CB E7
	set	4,b			;CB E0
	set	4,c			;CB E1
	set	4,d			;CB E2
	set	4,e			;CB E3
	set	4,h			;CB E4
	set	4,l			;CB E5
	set	5,(hl)			;CB EE
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	set	5,offset(ix)		;DD CBr00 EE
	set	5,offset(iy)		;FD CBr00 EE
	set	5,(ix+offset)		;DD CBr00 EE
	set	5,(iy+offset)		;FD CBr00 EE
      .nlist
    .else
      .list
	set	5,offset(ix)		;DD CBr55 EE
	set	5,offset(iy)		;FD CBr55 EE
	set	5,(ix+offset)		;DD CBr55 EE
	set	5,(iy+offset)		;FD CBr55 EE
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	set	5,offset(ix)		;DD CB 55 EE
	set	5,offset(iy)		;FD CB 55 EE
	set	5,(ix+offset)		;DD CB 55 EE
	set	5,(iy+offset)		;FD CB 55 EE
    .nlist
  .endif
.list  ; end<--
	set	5,a			;CB EF
	set	5,b			;CB E8
	set	5,c			;CB E9
	set	5,d			;CB EA
	set	5,e			;CB EB
	set	5,h			;CB EC
	set	5,l			;CB ED
	set	6,(hl)			;CB F6
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	set	6,offset(ix)		;DD CBr00 F6
	set	6,offset(iy)		;FD CBr00 F6
	set	6,(ix+offset)		;DD CBr00 F6
	set	6,(iy+offset)		;FD CBr00 F6
      .nlist
    .else
      .list
	set	6,offset(ix)		;DD CBr55 F6
	set	6,offset(iy)		;FD CBr55 F6
	set	6,(ix+offset)		;DD CBr55 F6
	set	6,(iy+offset)		;FD CBr55 F6
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	set	6,offset(ix)		;DD CB 55 F6
	set	6,offset(iy)		;FD CB 55 F6
	set	6,(ix+offset)		;DD CB 55 F6
	set	6,(iy+offset)		;FD CB 55 F6
    .nlist
  .endif
.list  ; end<--
	set	6,a			;CB F7
	set	6,b			;CB F0
	set	6,c			;CB F1
	set	6,d			;CB F2
	set	6,e			;CB F3
	set	6,h			;CB F4
	set	6,l			;CB F5
	set	7,(hl)			;CB FE
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	set	7,offset(ix)		;DD CBr00 FE
	set	7,offset(iy)		;FD CBr00 FE
	set	7,(ix+offset)		;DD CBr00 FE
	set	7,(iy+offset)		;FD CBr00 FE
      .nlist
    .else
      .list
	set	7,offset(ix)		;DD CBr55 FE
	set	7,offset(iy)		;FD CBr55 FE
	set	7,(ix+offset)		;DD CBr55 FE
	set	7,(iy+offset)		;FD CBr55 FE
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	set	7,offset(ix)		;DD CB 55 FE
	set	7,offset(iy)		;FD CB 55 FE
	set	7,(ix+offset)		;DD CB 55 FE
	set	7,(iy+offset)		;FD CB 55 FE
    .nlist
  .endif
.list  ; end<--
	set	7,a			;CB FF
	set	7,b			;CB F8
	set	7,c			;CB F9
	set	7,d			;CB FA
	set	7,e			;CB FB
	set	7,h			;CB FC
	set	7,l			;CB FD

;*******************************************************************
;	SLA	
;*******************************************************************
.nlist
.ifne ODDBALL_SHIFT_ROTATE
  .list
	;***********************************************************
	; shift operand left arithmetic
	.z80
	sla	a,(hl)			;CB 26
  .nlist ; -->bgn
    .ifeq _XL_				; (.ext/.lst)
      .ifdef .EXLR
        .list
	sla	a,offset(ix)		;DD CBr00 26
	sla	a,offset(iy)		;FD CBr00 26
	sla	a,(ix+offset)		;DD CBr00 26
	sla	a,(iy+offset)		;FD CBr00 26
        .nlist
      .else
        .list
	sla	a,offset(ix)		;DD CBr55 26
	sla	a,offset(iy)		;FD CBr55 26
	sla	a,(ix+offset)		;DD CBr55 26
	sla	a,(iy+offset)		;FD CBr55 26
        .nlist
      .endif
    .else				; (.ext/.rst) (.con/.lst) or (.con/.rst)
      .list
	sla	a,offset(ix)		;DD CB 55 26
	sla	a,offset(iy)		;FD CB 55 26
	sla	a,(ix+offset)		;DD CB 55 26
	sla	a,(iy+offset)		;FD CB 55 26
      .nlist
    .endif
  .list  ; end<--
	sla	a,a			;CB 27
	sla	a,b			;CB 20
	sla	a,c			;CB 21
	sla	a,d			;CB 22
	sla	a,e			;CB 23
	sla	a,h			;CB 24
	sla	a,l			;CB 25

  .nlist
.endif
.list
	;***********************************************************
	; shift operand left arithmetic
	.z80
	sla	(hl)			;CB 26
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	sla	offset(ix)		;DD CBr00 26
	sla	offset(iy)		;FD CBr00 26
	sla	(ix+offset)		;DD CBr00 26
	sla	(iy+offset)		;FD CBr00 26
      .nlist
    .else
      .list
	sla	offset(ix)		;DD CBr55 26
	sla	offset(iy)		;FD CBr55 26
	sla	(ix+offset)		;DD CBr55 26
	sla	(iy+offset)		;FD CBr55 26
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	sla	offset(ix)		;DD CB 55 26
	sla	offset(iy)		;FD CB 55 26
	sla	(ix+offset)		;DD CB 55 26
	sla	(iy+offset)		;FD CB 55 26
    .nlist
  .endif
.list  ; end<--
	sla	a			;CB 27
	sla	b			;CB 20
	sla	c			;CB 21
	sla	d			;CB 22
	sla	e			;CB 23
	sla	h			;CB 24
	sla	l			;CB 25

;*******************************************************************
;	SRA	
;*******************************************************************
.nlist
.ifne ODDBALL_SHIFT_ROTATE
  .list
	;***********************************************************
	; shift operand right arithmetic
	.z80
	sra	a,(hl)			;CB 2E
  .nlist ; -->bgn
    .ifeq _XL_				; (.ext/.lst)
      .ifdef .EXLR
        .list
	sra	a,offset(ix)		;DD CBr00 2E
	sra	a,offset(iy)		;FD CBr00 2E
	sra	a,(ix+offset)		;DD CBr00 2E
	sra	a,(iy+offset)		;FD CBr00 2E
        .nlist
      .else
        .list
	sra	a,offset(ix)		;DD CBr55 2E
	sra	a,offset(iy)		;FD CBr55 2E
	sra	a,(ix+offset)		;DD CBr55 2E
	sra	a,(iy+offset)		;FD CBr55 2E
        .nlist
      .endif
    .else				; (.ext/.rst) (.con/.lst) or (.con/.rst)
      .list
	sra	a,offset(ix)		;DD CB 55 2E
	sra	a,offset(iy)		;FD CB 55 2E
	sra	a,(ix+offset)		;DD CB 55 2E
	sra	a,(iy+offset)		;FD CB 55 2E
      .nlist
    .endif
  .list  ; end<--
	sra	a,a			;CB 2F
	sra	a,b			;CB 28
	sra	a,c			;CB 29
	sra	a,d			;CB 2A
	sra	a,e			;CB 2B
	sra	a,h			;CB 2C
	sra	a,l			;CB 2D

  .nlist
.endif
.list
	;***********************************************************
	; shift operand right arithmetic
	.z80
	sra	(hl)			;CB 2E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	sra	offset(ix)		;DD CBr00 2E
	sra	offset(iy)		;FD CBr00 2E
	sra	(ix+offset)		;DD CBr00 2E
	sra	(iy+offset)		;FD CBr00 2E
      .nlist
    .else
      .list
	sra	offset(ix)		;DD CBr55 2E
	sra	offset(iy)		;FD CBr55 2E
	sra	(ix+offset)		;DD CBr55 2E
	sra	(iy+offset)		;FD CBr55 2E
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	sra	offset(ix)		;DD CB 55 2E
	sra	offset(iy)		;FD CB 55 2E
	sra	(ix+offset)		;DD CB 55 2E
	sra	(iy+offset)		;FD CB 55 2E
    .nlist
  .endif
.list  ; end<--
	sra	a			;CB 2F
	sra	b			;CB 28
	sra	c			;CB 29
	sra	d			;CB 2A
	sra	e			;CB 2B
	sra	h			;CB 2C
	sra	l			;CB 2D

;*******************************************************************
;	SRL	
;*******************************************************************
.nlist
.ifne ODDBALL_SHIFT_ROTATE
  .list
	;***********************************************************
	; shift operand right logical
	.z80
	srl	a,(hl)			;CB 3E
  .nlist ; -->bgn
    .ifeq _XL_				; (.ext/.lst)
      .ifdef .EXLR
        .list
	srl	a,offset(ix)		;DD CBr00 3E
	srl	a,offset(iy)		;FD CBr00 3E
	srl	a,(ix+offset)		;DD CBr00 3E
	srl	a,(iy+offset)		;FD CBr00 3E
        .nlist
      .else
        .list
	srl	a,offset(ix)		;DD CBr55 3E
	srl	a,offset(iy)		;FD CBr55 3E
	srl	a,(ix+offset)		;DD CBr55 3E
	srl	a,(iy+offset)		;FD CBr55 3E
        .nlist
      .endif
    .else				; (.ext/.rst) (.con/.lst) or (.con/.rst)
      .list
	srl	a,offset(ix)		;DD CB 55 3E
	srl	a,offset(iy)		;FD CB 55 3E
	srl	a,(ix+offset)		;DD CB 55 3E
	srl	a,(iy+offset)		;FD CB 55 3E
      .nlist
    .endif
  .list  ; end<--
	srl	a,a			;CB 3F
	srl	a,b			;CB 38
	srl	a,c			;CB 39
	srl	a,d			;CB 3A
	srl	a,e			;CB 3B
	srl	a,h			;CB 3C
	srl	a,l			;CB 3D

  .nlist
.endif
.list
	;***********************************************************
	; shift operand right logical
	.z80
	srl	(hl)			;CB 3E
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	srl	offset(ix)		;DD CBr00 3E
	srl	offset(iy)		;FD CBr00 3E
	srl	(ix+offset)		;DD CBr00 3E
	srl	(iy+offset)		;FD CBr00 3E
      .nlist
    .else
      .list
	srl	offset(ix)		;DD CBr55 3E
	srl	offset(iy)		;FD CBr55 3E
	srl	(ix+offset)		;DD CBr55 3E
	srl	(iy+offset)		;FD CBr55 3E
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	srl	offset(ix)		;DD CB 55 3E
	srl	offset(iy)		;FD CB 55 3E
	srl	(ix+offset)		;DD CB 55 3E
	srl	(iy+offset)		;FD CB 55 3E
    .nlist
  .endif
.list  ; end<--
	srl	a			;CB 3F
	srl	b			;CB 38
	srl	c			;CB 39
	srl	d			;CB 3A
	srl	e			;CB 3B
	srl	h			;CB 3C
	srl	l			;CB 3D

;*******************************************************************
;	SUB	
;		Leading 'a' operand is optional.
;		If offset is ommitted 0 is assumed.
;*******************************************************************
	;***********************************************************
	; subtract operand from 'a'
	.z80
	sub	a,(hl)			;96
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	sub	a,offset(ix)		;DD 96r00
	sub	a,offset(iy)		;FD 96r00
	sub	a,(ix+offset)		;DD 96r00
	sub	a,(iy+offset)		;FD 96r00
      .nlist
    .else
      .list
	sub	a,offset(ix)		;DD 96r55
	sub	a,offset(iy)		;FD 96r55
	sub	a,(ix+offset)		;DD 96r55
	sub	a,(iy+offset)		;FD 96r55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	sub	a,offset(ix)		;DD 96 55
	sub	a,offset(iy)		;FD 96 55
	sub	a,(ix+offset)		;DD 96 55
	sub	a,(iy+offset)		;FD 96 55
    .nlist
  .endif
.list  ; end<--
	sub	a,a			;97
	sub	a,b			;90
	sub	a,c			;91
	sub	a,d			;92
	sub	a,e			;93
	sub	a,h			;94
	sub	a,l			;95
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	sub	a,#n			;D6r00
	sub	a, n			;D6r00
      .nlist
    .else
      .list
	sub	a,#n			;D6r20
	sub	a, n			;D6r20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	sub	a,#n			;D6 20
	sub	a, n			;D6 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	; subtract operand from 'a'
	.z80
	sub	(hl)			;96
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	sub	offset(ix)		;DD 96r00
	sub	offset(iy)		;FD 96r00
	sub	(ix+offset)		;DD 96r00
	sub	(iy+offset)		;FD 96r00
      .nlist
    .else
      .list
	sub	offset(ix)		;DD 96r55
	sub	offset(iy)		;FD 96r55
	sub	(ix+offset)		;DD 96r55
	sub	(iy+offset)		;FD 96r55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	sub	offset(ix)		;DD 96 55
	sub	offset(iy)		;FD 96 55
	sub	(ix+offset)		;DD 96 55
	sub	(iy+offset)		;FD 96 55
    .nlist
  .endif
.list  ; end<--
	sub	a			;97
	sub	b			;90
	sub	c			;91
	sub	d			;92
	sub	e			;93
	sub	h			;94
	sub	l			;95
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	sub	#n			;D6r00
	sub	 n			;D6r00
      .nlist
    .else
      .list
	sub	#n			;D6r20
	sub	 n			;D6r20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	sub	#n			;D6 20
	sub	 n			;D6 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	;  p. 5-139
	.z280
	sub	a,ixh			;DD 94
	sub	a,ixl			;DD 95
	sub	a,iyh			;FD 94
	sub	a,iyl			;FD 95
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
 	sub	a,#n			;D6r00
	sub	a,(daddr)		;DD 97r00s00
	sub	a,sxoff(ix)		;FD 91r00s00
	sub	a,(ix+sxoff)		;FD 91r00s00
	sub	a,sxoff(iy)		;FD 92r00s00
	sub	a,(iy+sxoff)		;FD 92r00s00
	sub	a,sxoff(hl)		;FD 93r00s00
	sub	a,(hl+sxoff)		;FD 93r00s00
	sub	a,sxoff(sp)		;DD 90r00s00
	sub	a,(sp+sxoff)		;DD 90r00s00
	sub	a,lxoff(ix)		;FD 91r00s00
	sub	a,(ix+lxoff)		;FD 91r00s00
	sub	a,lxoff(iy)		;FD 92r00s00
	sub	a,(iy+lxoff)		;FD 92r00s00
	sub	a,lxoff(hl)		;FD 93r00s00
	sub	a,(hl+lxoff)		;FD 93r00s00
	sub	a,lxoff(sp)		;DD 90r00s00
	sub	a,(sp+lxoff)		;DD 90r00s00
     .nlist
    .else
      .list
	sub	a,#n			;D6r20
	sub	a,(daddr)		;DD 97r44s33
	sub	a,sxoff(ix)		;FD 91r55s00
	sub	a,(ix+sxoff)		;FD 91r55s00
	sub	a,sxoff(iy)		;FD 92r55s00
	sub	a,(iy+sxoff)		;FD 92r55s00
	sub	a,sxoff(hl)		;FD 93r55s00
	sub	a,(hl+sxoff)		;FD 93r55s00
	sub	a,sxoff(sp)		;DD 90r55s00
	sub	a,(sp+sxoff)		;DD 90r55s00
	sub	a,lxoff(ix)		;FD 91r22s11
	sub	a,(ix+lxoff)		;FD 91r22s11
	sub	a,lxoff(iy)		;FD 92r22s11
	sub	a,(iy+lxoff)		;FD 92r22s11
	sub	a,lxoff(hl)		;FD 93r22s11
	sub	a,(hl+lxoff)		;FD 93r22s11
	sub	a,lxoff(sp)		;DD 90r22s11
	sub	a,(sp+lxoff)		;DD 90r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	sub	a,#n			;D6 20
	sub	a,(daddr)		;DD 97 44 33
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	sub	a,sxoff(ix)		;FD 91 55 00
	sub	a,(ix+sxoff)		;FD 91 55 00
	sub	a,sxoff(iy)		;FD 92 55 00
	sub	a,(iy+sxoff)		;FD 92 55 00
      .nlist
    .else				; (.con/.lst) or (.con/.rst)
      .list
	sub	a,sxoff(ix)		;DD 96 55
	sub	a,(ix+sxoff)		;DD 96 55
	sub	a,sxoff(iy)		;FD 96 55
	sub	a,(iy+sxoff)		;FD 96 55
      .nlist
    .endif
    .list
	sub	a,sxoff(hl)		;FD 93 55 00
	sub	a,(hl+sxoff)		;FD 93 55 00
	sub	a,sxoff(sp)		;DD 90 55 00
	sub	a,(sp+sxoff)		;DD 90 55 00
	sub	a,lxoff(ix)		;FD 91 22 11
	sub	a,(ix+lxoff)		;FD 91 22 11
	sub	a,lxoff(iy)		;FD 92 22 11
	sub	a,(iy+lxoff)		;FD 92 22 11
	sub	a,lxoff(hl)		;FD 93 22 11
	sub	a,(hl+lxoff)		;FD 93 22 11
	sub	a,lxoff(sp)		;DD 90 22 11
	sub	a,(sp+lxoff)		;DD 90 22 11
    .nlist
  .endif
.list  ; end<--
	sub	a,(hl)			;96
	sub	a,(ix)			;DD 96 00
	sub	a,(iy)			;FD 96 00
	sub	a,(sp)			;DD 90 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn sub01,raofc
      .list
	sub	a,sub01(pc)		;FD 90p00q00
      .nlist
      .pcr_xtrn sub02,raofc
      .list
	sub	a,(pc+sub02)		;FD 90p00q00
      .nlist
      .pcr_xtrn sub03,raofc
      .list
	sub	a,[sub03]		;FD 90p00q00
      .nlist
    .else
      .pcr_lclx sub01
      .list
	sub	a,raofc+sub01(pc)	;FD 90p34q12
      .nlist
      .pcr_lclx sub02
      .list
	sub	a,(pc+raofc+sub02)	;FD 90p34q12
      .nlist
      .pcr_lclx sub03
      .list
	sub	a,[raofc+sub03]		;FD 90p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn sub01,raofc
      .list
	sub	a,sub01(pc)		;FD 90 34 12
      .nlist
      .pcr_xtrn sub02,raofc
      .list
	sub	a,(pc+sub02)		;FD 90 34 12
      .nlist
      .pcr_xtrn sub03,raofc
      .list
	sub	a,[sub03]		;FD 90 34 12
      .nlist
    .else
      .pcr_lclx sub01
      .list
	sub	a,raofc+sub01(pc)	;FD 90 34 12
      .nlist
      .pcr_lclx sub02
      .list
	sub	a,(pc+raofc+sub02)	;FD 90 34 12
      .nlist
      .pcr_lclx sub03
      .list
	sub	a,[raofc+sub03]		;FD 90 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	sub	a,raoff(pc)		;FD 90p34q12
	sub	a,(pc+raoff)		;FD 90p34q12
	sub	a,[raoff]		;FD 90p34q12
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	sub	a,pcr_ofst(pc)		;FD 90 34 12
      .nlist
	.pcr_ofst raofc
      .list
	sub	a,(pc+pcr_ofst)		;FD 90 34 12
      .nlist
	.pcr_ofst raofc
      .list
	sub	a,[pcr_ofst]		;FD 90 34 12
    .nlist
  .endif
.list  ; end<--
	sub	a,[.+nnc]		;FD 90 80 05
	sub	a,(hl+ix)		;DD 91
	sub	a,(hl+iy)		;DD 92
	sub	a,(ix+iy)		;DD 93
	;***********************************************************
	;  p. 5-139
	.z280
	sub	ixh			;DD 94
	sub	ixl			;DD 95
	sub	iyh			;FD 94
	sub	iyl			;FD 95
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	sub	#n			;D6r00
	sub	(daddr)			;DD 97r00s00
	sub	sxoff(ix)		;FD 91r00s00
	sub	(ix+sxoff)		;FD 91r00s00
	sub	sxoff(iy)		;FD 92r00s00
	sub	(iy+sxoff)		;FD 92r00s00
	sub	sxoff(hl)		;FD 93r00s00
	sub	(hl+sxoff)		;FD 93r00s00
	sub	sxoff(sp)		;DD 90r00s00
	sub	(sp+sxoff)		;DD 90r00s00
	sub	lxoff(ix)		;FD 91r00s00
	sub	(ix+lxoff)		;FD 91r00s00
	sub	lxoff(iy)		;FD 92r00s00
	sub	(iy+lxoff)		;FD 92r00s00
	sub	lxoff(hl)		;FD 93r00s00
	sub	(hl+lxoff)		;FD 93r00s00
	sub	lxoff(sp)		;DD 90r00s00
	sub	(sp+lxoff)		;DD 90r00s00
      .nlist
    .else
      .list
	sub	#n			;D6r20
	sub	(daddr)			;DD 97r44s33
	sub	sxoff(ix)		;FD 91r55s00
	sub	(ix+sxoff)		;FD 91r55s00
	sub	sxoff(iy)		;FD 92r55s00
	sub	(iy+sxoff)		;FD 92r55s00
	sub	sxoff(hl)		;FD 93r55s00
	sub	(hl+sxoff)		;FD 93r55s00
	sub	sxoff(sp)		;DD 90r55s00
	sub	(sp+sxoff)		;DD 90r55s00
	sub	lxoff(ix)		;FD 91r22s11
	sub	(ix+lxoff)		;FD 91r22s11
	sub	lxoff(iy)		;FD 92r22s11
	sub	(iy+lxoff)		;FD 92r22s11
	sub	lxoff(hl)		;FD 93r22s11
	sub	(hl+lxoff)		;FD 93r22s11
	sub	lxoff(sp)		;DD 90r22s11
	sub	(sp+lxoff)		;DD 90r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	sub	#n			;D6 20
	sub	(daddr)			;DD 97 44 33
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	sub	sxoff(ix)		;FD 91 55 00
	sub	(ix+sxoff)		;FD 91 55 00
	sub	sxoff(iy)		;FD 92 55 00
	sub	(iy+sxoff)		;FD 92 55 00
      .nlist
    .else				; (.con/.lst) or (.con/.rst)
      .list
	sub	sxoff(ix)		;DD 96 55
	sub	(ix+sxoff)		;DD 96 55
	sub	sxoff(iy)		;FD 96 55
	sub	(iy+sxoff)		;FD 96 55
      .nlist
    .endif
    .list
	sub	sxoff(hl)		;FD 93 55 00
	sub	(hl+sxoff)		;FD 93 55 00
	sub	sxoff(sp)		;DD 90 55 00
	sub	(sp+sxoff)		;DD 90 55 00
	sub	lxoff(ix)		;FD 91 22 11
	sub	(ix+lxoff)		;FD 91 22 11
	sub	lxoff(iy)		;FD 92 22 11
	sub	(iy+lxoff)		;FD 92 22 11
	sub	lxoff(hl)		;FD 93 22 11
	sub	(hl+lxoff)		;FD 93 22 11
	sub	lxoff(sp)		;DD 90 22 11
	sub	(sp+lxoff)		;DD 90 22 11
    .nlist
  .endif
.list  ; end<--
	sub	(ix)			;DD 96 00
	sub	(iy)			;FD 96 00
	sub	(hl)			;96
	sub	(sp)			;DD 90 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn sub04,raofc
      .list
	sub	sub04(pc)		;FD 90p00q00
      .nlist
      .pcr_xtrn sub05,raofc
      .list
	sub	(pc+sub05)		;FD 90p00q00
      .nlist
      .pcr_xtrn sub06,raofc
      .list
	sub	[sub06]			;FD 90p00q00
      .nlist
    .else
      .pcr_lclx sub04
      .list
	sub	raofc+sub04(pc)		;FD 90p34q12
      .nlist
      .pcr_lclx sub05
      .list
	sub	(pc+raofc+sub05)	;FD 90p34q12
      .nlist
      .pcr_lclx sub06
      .list
	sub	[raofc+sub06]		;FD 90p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn sub04,raofc
      .list
	sub	sub04(pc)		;FD 90 34 12
      .nlist
      .pcr_xtrn sub05,raofc
      .list
	sub	(pc+sub05)		;FD 90 34 12
      .nlist
      .pcr_xtrn sub06,raofc
      .list
	sub	[sub06]			;FD 90 34 12
      .nlist
    .else
      .pcr_lclx sub04
      .list
	sub	raofc+sub04(pc)		;FD 90 34 12
      .nlist
      .pcr_lclx sub05
      .list
	sub	(pc+raofc+sub05)	;FD 90 34 12
      .nlist
      .pcr_lclx sub06
      .list
	sub	[raofc+sub06]		;FD 90 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	sub	raoff(pc)		;FD 90p34q12
	sub	(pc+raoff)		;FD 90p34q12
	sub	[raoff]			;FD 90p34q12
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	sub	pcr_ofst(pc)		;FD 90 34 12
      .nlist
	.pcr_ofst raofc
      .list
	sub	(pc+pcr_ofst)		;FD 90 34 12
      .nlist
	.pcr_ofst raofc
      .list
	sub	[pcr_ofst]		;FD 90 34 12
    .nlist
  .endif
.list  ; end<--
	sub	[.+nnc]			;FD 90 80 05
	sub	a,(hl+ix)		;DD 91
	sub	a,(hl+iy)		;DD 92
	sub	a,(ix+iy)		;DD 93
	;***********************************************************
	;  p. 5-140
	.z280
	sub	hl,(hl)			;DD ED CE
	sub	hl,(ix)			;FD ED CE 00 00
	sub	hl,(iy)			;FD ED DE 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	sub	hl,#nn			;FD ED FEr00s00
	sub	hl,(daddr)		;DD ED DEr00s00
	sub	hl,sxoff(ix)		;FD ED CEr00s00
	sub	hl,(ix+sxoff)		;FD ED CEr00s00
	sub	hl,lxoff(ix)		;FD ED CEr00s00
	sub	hl,(ix+lxoff)		;FD ED CEr00s00
	sub	hl,sxoff(iy)		;FD ED DEr00s00
	sub	hl,(iy+sxoff)		;FD ED DEr00s00
	sub	hl,lxoff(iy)		;FD ED DEr00s00
	sub	hl,(iy+lxoff)		;FD ED DEr00s00
      .nlist
    .else
      .list
	sub	hl,#nn			;FD ED FEr84s05
	sub	hl,(daddr)		;DD ED DEr44s33
	sub	hl,sxoff(ix)		;FD ED CEr55s00
	sub	hl,(ix+sxoff)		;FD ED CEr55s00
	sub	hl,lxoff(ix)		;FD ED CEr22s11
	sub	hl,(ix+lxoff)		;FD ED CEr22s11
	sub	hl,sxoff(iy)		;FD ED DEr55s00
	sub	hl,(iy+sxoff)		;FD ED DEr55s00
	sub	hl,lxoff(iy)		;FD ED DEr22s11
	sub	hl,(iy+lxoff)		;FD ED DEr22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	sub	hl,#nn			;FD ED FE 84 05
	sub	hl,(daddr)		;DD ED DE 44 33
	sub	hl,sxoff(ix)		;FD ED CE 55 00
	sub	hl,(ix+sxoff)		;FD ED CE 55 00
	sub	hl,lxoff(ix)		;FD ED CE 22 11
	sub	hl,(ix+lxoff)		;FD ED CE 22 11
	sub	hl,sxoff(iy)		;FD ED DE 55 00
	sub	hl,(iy+sxoff)		;FD ED DE 55 00
	sub	hl,lxoff(iy)		;FD ED DE 22 11
	sub	hl,(iy+lxoff)		;FD ED DE 22 11
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn sub07,raofc,5
      .list
	sub	hl,sub07(pc)		;DD ED FEp00q00
      .nlist
      .pcr_xtrn sub08,raofc,5
      .list
	sub	hl,(pc+sub08)		;DD ED FEp00q00
      .nlist
      .pcr_xtrn sub09,raofc,5
      .list
	sub	hl,[sub09]		;DD ED FEp00q00
      .nlist
    .else
      .pcr_lclx sub07,5
      .list
	sub	hl,raofc+sub07(pc)	;DD ED FEp34q12
      .nlist
      .pcr_lclx sub08,5
      .list
	sub	hl,(pc+raofc+sub08)	;DD ED FEp34q12
      .nlist
      .pcr_lclx sub09,5
      .list
	sub	hl,[raofc+sub09]	;DD ED FEp34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn sub07,raofc,5
      .list
	sub	hl,sub07(pc)		;DD ED FE 34 12
      .nlist
      .pcr_xtrn sub08,raofc,5
      .list
	sub	hl,(pc+sub08)		;DD ED FE 34 12
      .nlist
      .pcr_xtrn sub09,raofc,5
      .list
	sub	hl,[sub09]		;DD ED FE 34 12
      .nlist
    .else
      .pcr_lclx sub07,5
      .list
	sub	hl,raofc+sub07(pc)	;DD ED FE 34 12
      .nlist
      .pcr_lclx sub08,5
      .list
	sub	hl,(pc+raofc+sub08)	;DD ED FE 34 12
      .nlist
      .pcr_lclx sub09,5
      .list
	sub	hl,[raofc+sub09]	;DD ED FE 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	sub	hl,raoff(pc)		;DD ED FEp34q12
	sub	hl,(pc+raoff)		;DD ED FEp34q12
	sub	hl,[raoff]		;DD ED FEp34q12
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc,5
      .list
	sub	hl,pcr_ofst(pc)		;DD ED FE 34 12
      .nlist
	.pcr_ofst raofc,5
      .list
	sub	hl,(pc+pcr_ofst)	;DD ED FE 34 12
      .nlist
	.pcr_ofst raofc,5
      .list
	sub	hl,[pcr_ofst]		;DD ED FE 34 12
    .nlist
  .endif
.list  ; end<--
	sub	hl,[.+nc]		;DD ED FE 1B 00
	sub	hl,bc			;ED CE
	sub	hl,de			;ED DE
	sub	hl,hl			;ED EE
	sub	hl,ix			;DD ED EE
	sub	hl,iy			;FD ED EE
	sub	hl,sp			;ED FE
;*******************************************************************
;	SUBW	
;*******************************************************************
	;***********************************************************
	; subtract operand from 'hl'
	.z280
	subw	hl,bc			;ED CE
	subw	hl,de			;ED DE
	subw	hl,hl			;ED EE
	subw	hl,ix			;DD ED EE
	subw	hl,iy			;FD ED EE
	subw	hl,sp			;ED FE
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
 	subw	hl,#nn			;FD ED FEr00s00
	subw	hl,(daddr)		;DD ED DEr00s00
	subw	hl,sxoff(ix)		;FD ED CEr00s00
	subw	hl,(ix+sxoff)		;FD ED CEr00s00
	subw	hl,sxoff(iy)		;FD ED DEr00s00
	subw	hl,(iy+sxoff)		;FD ED DEr00s00
	subw	hl,lxoff(ix)		;FD ED CEr00s00
	subw	hl,(ix+lxoff)		;FD ED CEr00s00
	subw	hl,lxoff(iy)		;FD ED DEr00s00
	subw	hl,(iy+lxoff)		;FD ED DEr00s00
     .nlist
    .else
      .list
	subw	hl,#nn			;FD ED FEr84s05
	subw	hl,(daddr)		;DD ED DEr44s33
	subw	hl,sxoff(ix)		;FD ED CEr55s00
	subw	hl,(ix+sxoff)		;FD ED CEr55s00
	subw	hl,sxoff(iy)		;FD ED DEr55s00
	subw	hl,(iy+sxoff)		;FD ED DEr55s00
	subw	hl,lxoff(ix)		;FD ED CEr22s11
	subw	hl,(ix+lxoff)		;FD ED CEr22s11
	subw	hl,lxoff(iy)		;FD ED DEr22s11
	subw	hl,(iy+lxoff)		;FD ED DEr22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	subw	hl,#nn			;FD ED FE 84 05
	subw	hl,(daddr)		;DD ED DE 44 33
	subw	hl,sxoff(ix)		;FD ED CE 55 00
	subw	hl,(ix+sxoff)		;FD ED CE 55 00
	subw	hl,sxoff(iy)		;FD ED DE 55 00
	subw	hl,(iy+sxoff)		;FD ED DE 55 00
	subw	hl,lxoff(ix)		;FD ED CE 22 11
	subw	hl,(ix+lxoff)		;FD ED CE 22 11
	subw	hl,lxoff(iy)		;FD ED DE 22 11
	subw	hl,(iy+lxoff)		;FD ED DE 22 11
    .nlist
  .endif
.list  ; end<--
	subw	hl,(hl)			;DD ED CE
	subw	hl,(ix)			;FD ED CE 00 00
	subw	hl,(iy)			;FD ED DE 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn subw01,raofc,5
      .list
	subw	hl,subw01(pc)		;DD ED FEp00q00
      .nlist
      .pcr_xtrn subw02,raofc,5
      .list
	subw	hl,(pc+subw02)		;DD ED FEp00q00
      .nlist
      .pcr_xtrn subw03,raofc,5
      .list
	subw	hl,[subw03]		;DD ED FEp00q00
      .nlist
    .else
      .pcr_lclx subw01,5
      .list
	subw	hl,raofc+subw01(pc)	;DD ED FEp34q12
      .nlist
      .pcr_lclx subw02,5
      .list
	subw	hl,(pc+raofc+subw02)	;DD ED FEp34q12
      .nlist
      .pcr_lclx subw03,5
      .list
	subw	hl,[raofc+subw03]	;DD ED FEp34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn subw01,raofc,5
      .list
	subw	hl,subw01(pc)		;DD ED FE 34 12
      .nlist
      .pcr_xtrn subw02,raofc,5
      .list
	subw	hl,(pc+subw02)		;DD ED FE 34 12
      .nlist
      .pcr_xtrn subw03,raofc,5
      .list
	subw	hl,[subw03]		;DD ED FE 34 12
      .nlist
    .else
      .pcr_lclx subw01,5
      .list
	subw	hl,raofc+subw01(pc)	;DD ED FE 34 12
      .nlist
      .pcr_lclx subw02,5
      .list
	subw	hl,(pc+raofc+subw02)	;DD ED FE 34 12
      .nlist
      .pcr_lclx subw03,5
      .list
	subw	hl,[raofc+subw03]	;DD ED FE 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	subw	hl,raoff(pc)		;DD ED FEp34q12
	subw	hl,(pc+raoff)		;DD ED FEp34q12
	subw	hl,[raoff]		;DD ED FEp34q12
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc,5
      .list
	subw	hl,pcr_ofst(pc)		;DD ED FE 34 12
      .nlist
	.pcr_ofst raofc,5
      .list
	subw	hl,(pc+pcr_ofst)	;DD ED FE 34 12
      .nlist
	.pcr_ofst raofc,5
      .list
	subw	hl,[pcr_ofst]		;DD ED FE 34 12
    .nlist
  .endif
.list  ; end<--
	subw	hl,[.+nc]		;DD ED FE 1B 00

;*******************************************************************
;	TSET	
;*******************************************************************
	;***********************************************************
	; Z280 test and set
	;  p. 5-141
	.z280
	tset	b			;CB 30
	tset	c			;CB 31
	tset	d			;CB 32
	tset	e			;CB 33
	tset	h			;CB 34
	tset	l			;CB 35
	tset	(hl)			;CB 36
	tset	a			;CB 37
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	tset	sxoff(ix)		;DD CBr00 36
	tset	(ix+sxoff)		;DD CBr00 36
	tset	sxoff(iy)		;FD CBr00 36
	tset	(iy+sxoff)		;FD CBr00 36
      .nlist
    .else
      .list
	tset	sxoff(ix)		;DD CBr55 36
	tset	(ix+sxoff)		;DD CBr55 36
	tset	sxoff(iy)		;FD CBr55 36
	tset	(iy+sxoff)		;FD CBr55 36
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	tset	sxoff(ix)		;DD CB 55 36
	tset	(ix+sxoff)		;DD CB 55 36
	tset	sxoff(iy)		;FD CB 55 36
	tset	(iy+sxoff)		;FD CB 55 36
    .nlist
  .endif
.list  ; end<--

;*******************************************************************
;	TSTI	
;*******************************************************************
	;***********************************************************
	; Z280 test input
	.z280
	tsti	(c)			;ED 70

;*******************************************************************
;	XOR	
;		Leading 'a' operand is optional.
;		If offset is ommitted 0 is assumed.
;*******************************************************************
	;***********************************************************
	; logical 'xor' operand with 'a'
	.z80
	xor	a,(hl)			;AE
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	xor	a,offset(ix)		;DD AEr00
	xor	a,offset(iy)		;FD AEr00
	xor	a,(ix+offset)		;DD AEr00
	xor	a,(iy+offset)		;FD AEr00
      .nlist
    .else
      .list
	xor	a,offset(ix)		;DD AEr55
	xor	a,offset(iy)		;FD AEr55
	xor	a,(ix+offset)		;DD AEr55
	xor	a,(iy+offset)		;FD AEr55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	xor	a,offset(ix)		;DD AE 55
	xor	a,offset(iy)		;FD AE 55
	xor	a,(ix+offset)		;DD AE 55
	xor	a,(iy+offset)		;FD AE 55
    .nlist
  .endif
.list  ; end<--
	xor	a,a			;AF
	xor	a,b			;A8
	xor	a,c			;A9
	xor	a,d			;AA
	xor	a,e			;AB
	xor	a,h			;AC
	xor	a,l			;AD
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	xor	a,#n			;EEr00
	xor	a, n			;EEr00
      .nlist
    .else
      .list
	xor	a,#n			;EEr20
	xor	a, n			;EEr20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	xor	a,#n			;EE 20
	xor	a, n			;EE 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	; logical 'xor' operand without 'a'
	.z80
	xor	(hl)			;AE
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	xor	offset(ix)		;DD AEr00
	xor	offset(iy)		;FD AEr00
	xor	(ix+offset)		;DD AEr00
	xor	(iy+offset)		;FD AEr00
      .nlist
    .else
      .list
	xor	offset(ix)		;DD AEr55
	xor	offset(iy)		;FD AEr55
	xor	(ix+offset)		;DD AEr55
	xor	(iy+offset)		;FD AEr55
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	xor	offset(ix)		;DD AE 55
	xor	offset(iy)		;FD AE 55
	xor	(ix+offset)		;DD AE 55
	xor	(iy+offset)		;FD AE 55
    .nlist
  .endif
.list  ; end<--
	xor	a			;AF
	xor	b			;A8
	xor	c			;A9
	xor	d			;AA
	xor	e			;AB
	xor	h			;AC
	xor	l			;AD
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	xor	#n			;EEr00
	xor	 n			;EEr00
      .nlist
    .else
      .list
	xor	#n			;EEr20
	xor	 n			;EEr20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	xor	#n			;EE 20
	xor	 n			;EE 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	;  p. 5-143
	.z280
	xor	a,ixh			;DD AC
	xor	a,ixl			;DD AD
	xor	a,iyh			;FD AC
	xor	a,iyl			;FD AD
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	xor	a,#n			;EEr00
	xor	a,(daddr)		;DD AFr00s00
	xor	a,sxoff(ix)		;FD A9r00s00
	xor	a,(ix+sxoff)		;FD A9r00s00
	xor	a,sxoff(iy)		;FD AAr00s00
	xor	a,(iy+sxoff)		;FD AAr00s00
	xor	a,sxoff(hl)		;FD ABr00s00
	xor	a,(hl+sxoff)		;FD ABr00s00
	xor	a,sxoff(sp)		;DD A8r00s00
	xor	a,(sp+sxoff)		;DD A8r00s00
	xor	a,lxoff(ix)		;FD A9r00s00
	xor	a,(ix+lxoff)		;FD A9r00s00
	xor	a,lxoff(iy)		;FD AAr00s00
	xor	a,(iy+lxoff)		;FD AAr00s00
	xor	a,lxoff(hl)		;FD ABr00s00
	xor	a,(hl+lxoff)		;FD ABr00s00
	xor	a,lxoff(sp)		;DD A8r00s00
	xor	a,(sp+lxoff)		;DD A8r00s00
      .nlist
    .else
      .list
	xor	a,#n			;EEr20
	xor	a,(daddr)		;DD AFr44s33
	xor	a,sxoff(ix)		;FD A9r55s00
	xor	a,(ix+sxoff)		;FD A9r55s00
	xor	a,sxoff(iy)		;FD AAr55s00
	xor	a,(iy+sxoff)		;FD AAr55s00
	xor	a,sxoff(hl)		;FD ABr55s00
	xor	a,(hl+sxoff)		;FD ABr55s00
	xor	a,sxoff(sp)		;DD A8r55s00
	xor	a,(sp+sxoff)		;DD A8r55s00
	xor	a,lxoff(ix)		;FD A9r22s11
	xor	a,(ix+lxoff)		;FD A9r22s11
	xor	a,lxoff(iy)		;FD AAr22s11
	xor	a,(iy+lxoff)		;FD AAr22s11
	xor	a,lxoff(hl)		;FD ABr22s11
	xor	a,(hl+lxoff)		;FD ABr22s11
	xor	a,lxoff(sp)		;DD A8r22s11
	xor	a,(sp+lxoff)		;DD A8r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	xor	a,#n			;EE 20
	xor	a,(daddr)		;DD AF 44 33
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	xor	a,sxoff(ix)		;FD A9 55 00
	xor	a,(ix+sxoff)		;FD A9 55 00
	xor	a,sxoff(iy)		;FD AA 55 00
	xor	a,(iy+sxoff)		;FD AA 55 00
      .nlist
    .else				; (.con/.lst) or (.con/.rst)
      .list
	xor	a,sxoff(ix)		;DD AE 55
	xor	a,(ix+sxoff)		;DD AE 55
	xor	a,sxoff(iy)		;FD AE 55
	xor	a,(iy+sxoff)		;FD AE 55
      .nlist
    .endif
    .list
	xor	a,sxoff(hl)		;FD AB 55 00
	xor	a,(hl+sxoff)		;FD AB 55 00
	xor	a,sxoff(sp)		;DD A8 55 00
	xor	a,(sp+sxoff)		;DD A8 55 00
	xor	a,lxoff(ix)		;FD A9 22 11
	xor	a,(ix+lxoff)		;FD A9 22 11
	xor	a,lxoff(iy)		;FD AA 22 11
	xor	a,(iy+lxoff)		;FD AA 22 11
	xor	a,lxoff(hl)		;FD AB 22 11
	xor	a,(hl+lxoff)		;FD AB 22 11
	xor	a,lxoff(sp)		;DD A8 22 11
	xor	a,(sp+lxoff)		;DD A8 22 11
    .nlist
  .endif
.list  ; end<--
	xor	a,(hl)			;AE
	xor	a,(ix)			;DD AE 00
	xor	a,(iy)			;FD AE 00
	xor	a,(sp)			;DD A8 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn zor01,raofc
      .list
	xor	a,zor01(pc)		;FD A8p00q00
      .nlist
      .pcr_xtrn zor02,raofc
      .list
	xor	a,(pc+zor02)		;FD A8p00q00
      .nlist
      .pcr_xtrn zor03,raofc
      .list
	xor	a,[zor03]		;FD A8p00q00
      .nlist
    .else
      .pcr_lclx zor01
      .list
	xor	a,raofc+zor01(pc)	;FD A8p34q12
      .nlist
      .pcr_lclx zor02
      .list
	xor	a,(pc+raofc+zor02)	;FD A8p34q12
      .nlist
      .pcr_lclx zor03
      .list
	xor	a,[raofc+zor03]		;FD A8p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn zor01,raofc
      .list
	xor	a,zor01(pc)		;FD A8 34 12
      .nlist
      .pcr_xtrn zor02,raofc
      .list
	xor	a,(pc+zor02)		;FD A8 34 12
      .nlist
      .pcr_xtrn zor03,raofc
      .list
	xor	a,[zor03]		;FD A8 34 12
      .nlist
    .else
      .pcr_lclx zor01
      .list
	xor	a,raofc+zor01(pc)	;FD A8 34 12
      .nlist
      .pcr_lclx zor02
      .list
	xor	a,(pc+raofc+zor02)	;FD A8 34 12
      .nlist
      .pcr_lclx zor03
      .list
	xor	a,[raofc+zor03]		;FD A8 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	xor	a,raoff(pc)		;FD A8p34q12
	xor	a,(pc+raoff)		;FD A8p34q12
	xor	a,[raoff]		;FD A8p34q12
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	xor	a,pcr_ofst(pc)		;FD A8 34 12
      .nlist
	.pcr_ofst raofc
      .list
	xor	a,(pc+pcr_ofst)		;FD A8 34 12
      .nlist
	.pcr_ofst raofc
      .list
	xor	a,[pcr_ofst]		;FD A8 34 12
    .nlist
  .endif
.list  ; end<--
	xor	a,[.+nc]		;FD A8 1C 00
	xor	a,(hl+ix)		;DD A9
	xor	a,(hl+iy)		;DD AA
	xor	a,(ix+iy)		;DD AB
	;***********************************************************
	;  p. 5-143
	.z280
	xor	ixh			;DD AC
	xor	ixl			;DD AD
	xor	iyh			;FD AC
	xor	iyl			;FD AD
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
 	xor	#n			;EEr00
	xor	(daddr)			;DD AFr00s00
	xor	sxoff(ix)		;FD A9r00s00
	xor	(ix+sxoff)		;FD A9r00s00
	xor	sxoff(iy)		;FD AAr00s00
	xor	(iy+sxoff)		;FD AAr00s00
	xor	sxoff(hl)		;FD ABr00s00
	xor	(hl+sxoff)		;FD ABr00s00
	xor	sxoff(sp)		;DD A8r00s00
	xor	(sp+sxoff)		;DD A8r00s00
	xor	lxoff(ix)		;FD A9r00s00
	xor	(ix+lxoff)		;FD A9r00s00
	xor	lxoff(iy)		;FD AAr00s00
	xor	(iy+lxoff)		;FD AAr00s00
	xor	lxoff(hl)		;FD ABr00s00
	xor	(hl+lxoff)		;FD ABr00s00
	xor	lxoff(sp)		;DD A8r00s00
	xor	(sp+lxoff)		;DD A8r00s00
     .nlist
    .else
      .list
	xor	#n			;EEr20
	xor	(daddr)			;DD AFr44s33
	xor	sxoff(ix)		;FD A9r55s00
	xor	(ix+sxoff)		;FD A9r55s00
	xor	sxoff(iy)		;FD AAr55s00
	xor	(iy+sxoff)		;FD AAr55s00
	xor	sxoff(hl)		;FD ABr55s00
	xor	(hl+sxoff)		;FD ABr55s00
	xor	sxoff(sp)		;DD A8r55s00
	xor	(sp+sxoff)		;DD A8r55s00
	xor	lxoff(ix)		;FD A9r22s11
	xor	(ix+lxoff)		;FD A9r22s11
	xor	lxoff(iy)		;FD AAr22s11
	xor	(iy+lxoff)		;FD AAr22s11
	xor	lxoff(hl)		;FD ABr22s11
	xor	(hl+lxoff)		;FD ABr22s11
	xor	lxoff(sp)		;DD A8r22s11
	xor	(sp+lxoff)		;DD A8r22s11
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	xor	#n			;EE 20
	xor	(daddr)			;DD AF 44 33
    .nlist
    .ifeq _X_R				; (.ext/.rst)
      .list
	xor	sxoff(ix)		;FD A9 55 00
	xor	(ix+sxoff)		;FD A9 55 00
	xor	sxoff(iy)		;FD AA 55 00
	xor	(iy+sxoff)		;FD AA 55 00
      .nlist
    .else				; (.con/.lst) or (.con/.rst)
      .list
	xor	sxoff(ix)		;DD AE 55
	xor	(ix+sxoff)		;DD AE 55
	xor	sxoff(iy)		;FD AE 55
	xor	(iy+sxoff)		;FD AE 55
      .nlist
    .endif
    .list
	xor	sxoff(hl)		;FD AB 55 00
	xor	(hl+sxoff)		;FD AB 55 00
	xor	sxoff(sp)		;DD A8 55 00
	xor	(sp+sxoff)		;DD A8 55 00
	xor	lxoff(ix)		;FD A9 22 11
	xor	(ix+lxoff)		;FD A9 22 11
	xor	lxoff(iy)		;FD AA 22 11
	xor	(iy+lxoff)		;FD AA 22 11
	xor	lxoff(hl)		;FD AB 22 11
	xor	(hl+lxoff)		;FD AB 22 11
	xor	lxoff(sp)		;DD A8 22 11
	xor	(sp+lxoff)		;DD A8 22 11
    .nlist
  .endif
.list  ; end<--
	xor	(hl)			;AE
	xor	(ix)			;DD AE 00
	xor	(iy)			;FD AE 00
	xor	(sp)			;DD A8 00 00
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .pcr_xtrn zor04,raofc
      .list
	xor	zor04(pc)		;FD A8p00q00
      .nlist
      .pcr_xtrn zor05,raofc
      .list
	xor	(pc+zor05)		;FD A8p00q00
      .nlist
      .pcr_xtrn zor06,raofc
      .list
	xor	[zor06]			;FD A8p00q00
      .nlist
    .else
      .pcr_lclx zor04
      .list
	xor	raofc+zor04(pc)		;FD A8p34q12
      .nlist
      .pcr_lclx zor05
      .list
	xor	(pc+raofc+zor05)	;FD A8p34q12
      .nlist
      .pcr_lclx zor06
      .list
	xor	[raofc+zor06]		;FD A8p34q12
      .nlist
    .endif
  .endif
  .ifeq _X_R				; (.ext/.rst)
    .ifdef .EXLR
      .pcr_xtrn zor04,raofc
      .list
	xor	zor04(pc)		;FD A8 34 12
      .nlist
      .pcr_xtrn zor05,raofc
      .list
	xor	(pc+zor05)		;FD A8 34 12
      .nlist
      .pcr_xtrn zor06,raofc
      .list
	xor	[zor06]			;FD A8 34 12
      .nlist
    .else
      .pcr_lclx zor04
      .list
	xor	raofc+zor04(pc)		;FD A8 34 12
      .nlist
      .pcr_lclx zor05
      .list
	xor	(pc+raofc+zor05)	;FD A8 34 12
      .nlist
      .pcr_lclx zor06
      .list
	xor	[raofc+zor06]		;FD A8 34 12
      .nlist
    .endif
  .endif
  .ifeq C_L_				; (.con/.lst)
    .list
	xor	raoff(pc)		;FD A8p34q12
	xor	(pc+raoff)		;FD A8p34q12
	xor	[raoff]			;FD A8p34q12
    .nlist
    .endif
  .ifeq C__R				; (.con/.rst)
    .list
      .nlist
	.pcr_ofst raofc
      .list
	xor	pcr_ofst(pc)		;FD A8 34 12
      .nlist
	.pcr_ofst raofc
      .list
	xor	(pc+pcr_ofst)		;FD A8 34 12
      .nlist
	.pcr_ofst raofc
      .list
	xor	[pcr_ofst]		;FD A8 34 12
    .nlist
  .endif
.list  ; end<--
	xor	[.+nc]			;FD A8 1C 00
	xor	(hl+ix)			;DD A9
	xor	(hl+iy)			;DD AA
	xor	(ix+iy)			;DD AB

	;***********************************************************
	; Hitachi HD64180 Codes
	;***********************************************************

	.hd64

	;***********************************************************
	; start of the Z180 section
	;***********************************************************
	

;*******************************************************************
;	IN0	
;*******************************************************************
	;***********************************************************
	; load register with input from port (n)
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	in0	a,(n)			;ED 38r00
	in0	b,(n)			;ED 00r00
	in0	c,(n)			;ED 08r00
	in0	d,(n)			;ED 10r00
	in0	e,(n)			;ED 18r00
	in0	h,(n)			;ED 20r00
	in0	l,(n)			;ED 28r00
      .nlist
    .else
      .list
	in0	a,(n)			;ED 38r20
	in0	b,(n)			;ED 00r20
	in0	c,(n)			;ED 08r20
	in0	d,(n)			;ED 10r20
	in0	e,(n)			;ED 18r20
	in0	h,(n)			;ED 20r20
	in0	l,(n)			;ED 28r20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	in0	a,(n)			;ED 38 20
	in0	b,(n)			;ED 00 20
	in0	c,(n)			;ED 08 20
	in0	d,(n)			;ED 10 20
	in0	e,(n)			;ED 18 20
	in0	h,(n)			;ED 20 20
	in0	l,(n)			;ED 28 20
    .nlist
  .endif
.list  ; end<--

;*******************************************************************
;	mlt	
;*******************************************************************
	;***********************************************************
	; multiplication of each half
	; of the specified register pair
	; with the 16-bit result going to
	; the specified register pair
	mlt	bc			;ED 4C
	mlt	de			;ED 5C
	mlt	hl			;ED 6C
	mlt	sp			;ED 7C

;*******************************************************************
;	OTDM	
;*******************************************************************
	;***********************************************************
	; load output port (c) with
	; location (hl),
	; decrement hl and b
	; decrement c
	otdm				;ED 8B

;*******************************************************************
;	OTDMR	
;*******************************************************************
	;***********************************************************
	; load output port (c) with
	; location (hl),
	; decrement hl and c
	; decrement b
	; repeat until b = 0
	otdmr				;ED 9B

;*******************************************************************
;	OTIM	
;*******************************************************************
	;***********************************************************
	; load output port (c) with
	; location (hl),
	; increment hl and b
	; decrement c
	otim				;ED 83

;*******************************************************************
;	OTIMR	
;*******************************************************************
	;***********************************************************
	; load output port (c) with
	; location (hl),
	; increment hl and c
	; decrement b
	; repeat until b = 0
	otimr				;ED 93

;*******************************************************************
;	OUT0	
;*******************************************************************
	;***********************************************************
	; load output port (n) from register
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	out0	(n),a			;ED 39r00
	out0	(n),b			;ED 01r00
	out0	(n),c			;ED 09r00
	out0	(n),d			;ED 11r00
	out0	(n),e			;ED 19r00
	out0	(n),h			;ED 21r00
	out0	(n),l			;ED 29r00
      .nlist
    .else
      .list
	out0	(n),a			;ED 39r20
	out0	(n),b			;ED 01r20
	out0	(n),c			;ED 09r20
	out0	(n),d			;ED 11r20
	out0	(n),e			;ED 19r20
	out0	(n),h			;ED 21r20
	out0	(n),l			;ED 29r20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	out0	(n),a			;ED 39 20
	out0	(n),b			;ED 01 20
	out0	(n),c			;ED 09 20
	out0	(n),d			;ED 11 20
	out0	(n),e			;ED 19 20
	out0	(n),h			;ED 21 20
	out0	(n),l			;ED 29 20
    .nlist
  .endif
.list  ; end<--

;*******************************************************************
;	SLP	
;*******************************************************************
	;***********************************************************
	; enter sleep mode
	slp				;ED 76

;*******************************************************************
;	TST	
;*******************************************************************
	;***********************************************************
	; non-destructive'and' with accumulator and specified operand
	tst	a,a			;ED 3C
	tst	a,b			;ED 04
	tst	a,c			;ED 0C
	tst	a,d			;ED 14
	tst	a,e			;ED 1C
	tst	a,h			;ED 24
	tst	a,l			;ED 2C
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	tst	a,#n			;ED 64r00
	tst	a, n			;ED 64r00
      .nlist
    .else
      .list
	tst	a,#n			;ED 64r20
	tst	a, n			;ED 64r20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	tst	a,#n			;ED 64 20
	tst	a, n			;ED 64 20
    .nlist
  .endif
.list  ; end<--
	tst	a,(hl)			;ED 34
	;***********************************************************
	tst	a			;ED 3C
	tst	b			;ED 04
	tst	c			;ED 0C
	tst	d			;ED 14
	tst	e			;ED 1C
	tst	h			;ED 24
	tst	l			;ED 2C
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	tst	#n			;ED 64r00
	tst	 n			;ED 64r00
      .nlist
    .else
      .list
	tst	#n			;ED 64r20
	tst	 n			;ED 64r20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	tst	#n			;ED 64 20
	tst	 n			;ED 64 20
    .nlist
  .endif
.list  ; end<--
	tst	(hl)			;ED 34

;*******************************************************************
;	TSTIO	
;*******************************************************************
	;***********************************************************
	; non-destructive 'and' of n and the contents of port (c)
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	tstio	#n,(c)			;ED 74r00
	tstio	(c),#n			;ED 74r00
	tstio	#n			;ED 74r00
	tstio	 n			;ED 74r00
      .nlist
    .else
      .list
	tstio	#n,(c)			;ED 74r20
	tstio	(c),#n			;ED 74r20
	tstio	#n			;ED 74r20
	tstio	 n			;ED 74r20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	tstio	#n,(c)			;ED 74 20
	tstio	(c),#n			;ED 74 20
	tstio	#n			;ED 74 20
	tstio	 n			;ED 74 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	; end of the Z180 section
	;***********************************************************
	
;*******************************************************************
;	UNDOCUMENTED	
;*******************************************************************
	;***********************************************************
	; start of the Z80 undocumented section
	;***********************************************************
	.z80u
	adc	a,ixh			;DD 8C
	adc	a,ixl			;DD 8D
	adc	a,iyh			;FD 8C
	adc	a,iyl			;FD 8D
	add	a,ixh			;DD 84
	add	a,ixl			;DD 85
	add	a,iyh			;FD 84
	add	a,iyl			;FD 85
	and	a,ixh			;DD A4
	and	a,ixl			;DD A5
	and	a,iyh			;FD A4
	and	a,iyl			;FD A5
	cp	a,ixh			;DD BC
	cp	a,ixl			;DD BD
	cp	a,iyh			;FD BC
	cp	a,iyl			;FD BD
	or	a,ixh			;DD B4
	or	a,ixl			;DD B5
	or	a,iyh			;FD B4
	or	a,iyl			;FD B5
	sbc	a,ixh			;DD 9C
	sbc	a,ixl			;DD 9D
	sbc	a,iyh			;FD 9C
	sbc	a,iyl			;FD 9D
	sub	a,ixh			;DD 94
	sub	a,ixl			;DD 95
	sub	a,iyh			;FD 94
	sub	a,iyl			;FD 95
	xor	a,ixh			;DD AC
	xor	a,ixl			;DD AD
	xor	a,iyh			;FD AC
	xor	a,iyl			;FD AD
					;
	dec	ixh			;DD 25
	dec	ixl			;DD 2D
	dec	iyh			;FD 25
	dec	iyl			;FD 2D
	inc	ixh			;DD 24
	inc	ixl			;DD 2C
	inc	iyh			;FD 24
	inc 	iyl			;FD 2C
					;
	in	ixh,(c)			;DD ED 60
	in	ixl,(c)			;DD ED 68
	in	iyh,(c)			;FD ED 60
	in	iyl,(c)			;FD ED 68
					;
	ld	ixh,a			;DD 67
	ld	ixl,a			;DD 6F
	ld	iyh,a			;FD 67
	ld	iyl,a			;FD 6F
	ld	ixh,b			;DD 60
	ld	ixl,b			;DD 68
	ld	iyh,b			;FD 60
	ld	iyl,b			;FD 68
	ld	ixh,c			;DD 61
	ld	ixl,c			;DD 69
	ld	iyh,c			;FD 61
	ld	iyl,c			;FD 69
	ld	ixh,d			;DD 62
	ld	ixl,d			;DD 6A
	ld	iyh,d			;FD 62
	ld	iyl,d			;FD 6A
	ld	ixh,e			;DD 63
	ld	ixl,e			;DD 6B
	ld	iyh,e			;FD 63
	ld	iyl,e			;FD 6B
					;
	ld	a,ixh			;DD 7C
	ld	a,ixl			;DD 7D
	ld	a,iyh			;FD 7C
	ld	a,iyl			;FD 7D
	ld	b,ixh			;DD 44
	ld	b,ixl			;DD 45
	ld	b,iyh			;FD 44
	ld	b,iyl			;FD 45
	ld	c,ixh			;DD 4C
	ld	c,ixl			;DD 4D
	ld	c,iyh			;FD 4C
	ld	c,iyl			;FD 4D
	ld	d,ixh			;DD 54
	ld	d,ixl			;DD 55
	ld	d,iyh			;FD 54
	ld	d,iyl			;FD 55
	ld	e,ixh			;DD 5C
	ld	e,ixl			;DD 5D
	ld	e,iyh			;FD 5C
	ld	e,iyl			;FD 5D
.if 1
					;
	ld	ixh,ixh			;DD 64
	ld	ixh,ixl			;DD 65
	ld	ixl,ixh			;DD 6C
	ld	ixl,ixl			;DD 6D
	ld	iyh,iyh			;FD 64
	ld	iyh,iyl			;FD 65
	ld	iyl,iyh			;FD 6C
	ld	iyl,iyl			;FD 6D
.endif
					;
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	ixh,#n			;DD 26r00
	ld	ixl,#n			;DD 2Er00
	ld	iyh,#n			;FD 26r00
	ld	iyl,#n			;FD 2Er00
      .nlist
    .else
      .list
	ld	ixh,#n			;DD 26r20
	ld	ixl,#n			;DD 2Er20
	ld	iyh,#n			;FD 26r20
	ld	iyl,#n			;FD 2Er20
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	ixh,#n			;DD 26 20
	ld	ixl,#n			;DD 2E 20
	ld	iyh,#n			;FD 26 20
	ld	iyl,#n			;FD 2E 20
    .nlist
  .endif
.list  ; end<--
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	ld	ixh,#n			;DD 26r00
	ld	ixl,#n+3		;DD 2Er03
	ld	iyh,#n-1		;FD 26rFF
	ld	iyl,#n			;FD 2Er00
      .nlist
    .else
      .list
 	ld	ixh,#n			;DD 26r20
	ld	ixl,#n+3		;DD 2Er23
	ld	iyh,#n-1		;FD 26r1F
	ld	iyl,#n			;FD 2Er20
     .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	ld	ixh,#n			;DD 26 20
	ld	ixl,#n+3		;DD 2E 23
	ld	iyh,#n-1		;FD 26 1F
	ld	iyl,#n			;FD 2E 20
    .nlist
  .endif
.list  ; end<--
	;***********************************************************
	; without 'a'
	adc	ixh			;DD 8C
	adc	ixl			;DD 8D
	adc	iyh			;FD 8C
	adc	iyl			;FD 8D
	add	ixh			;DD 84
	add	ixl			;DD 85
	add	iyh			;FD 84
	add	iyl			;FD 85
	and	ixh			;DD A4
	and	ixl			;DD A5
	and	iyh			;FD A4
	and	iyl			;FD A5
	cp	ixh			;DD BC
	cp	ixl			;DD BD
	cp	iyh			;FD BC
	cp	iyl			;FD BD
	or	ixh			;DD B4
	or	ixl			;DD B5
	or	iyh			;FD B4
	or	iyl			;FD B5
	sbc	ixh			;DD 9C
	sbc	ixl			;DD 9D
	sbc	iyh			;FD 9C
	sbc	iyl			;FD 9D
	sub	ixh			;DD 94
	sub	ixl			;DD 95
	sub	iyh			;FD 94
	sub	iyl			;FD 95
	xor	ixh			;DD AC
	xor	ixl			;DD AD
	xor	iyh			;FD AC
	xor	iyl			;FD AD
	;***********************************************************
	; c.f. 'tset' on Z280 (see above)
	; shift left (like SLA), but shift a '1' into bit 0 !!!
	sll	(hl)			;CB 36
.nlist ; -->bgn
  .ifeq _XL_				; (.ext/.lst)
    .ifdef .EXLR
      .list
	sll	offset(ix)		;DD CBr00 36
	sll	offset(iy)		;FD CBr00 36
	sll	(ix+offset)		;DD CBr00 36
	sll	(iy+offset)		;FD CBr00 36
      .nlist
    .else
      .list
	sll	offset(ix)		;DD CBr55 36
	sll	offset(iy)		;FD CBr55 36
	sll	(ix+offset)		;DD CBr55 36
	sll	(iy+offset)		;FD CBr55 36
      .nlist
    .endif
  .else					; (.ext/.rst) (.con/.lst) or (.con/.rst)
    .list
	sll	offset(ix)		;DD CB 55 36
	sll	offset(iy)		;FD CB 55 36
	sll	(ix+offset)		;DD CB 55 36
	sll	(iy+offset)		;FD CB 55 36
    .nlist
  .endif
.list  ; end<--
	sll	a			;CB 37
	sll	b			;CB 30
	sll	c			;CB 31
	sll	d			;CB 32
	sll	e			;CB 33
	sll	h			;CB 34
	sll	l			;CB 35
	;  sll a  ==  tset a	may be used to distinguish Z80 from Z280 with Areg = 0x41
	;***********************************************************
	; end of the Z80 undocumented section
	;***********************************************************

	.globl	z
	ld	a,# >0x1234
	ld	a,# <0x1234
	ld	a,# >(z+0x1234)
	ld	a,# <(z+0x1234)
	

	.end

