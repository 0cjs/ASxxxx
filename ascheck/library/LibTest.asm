	.module	LibTest
	.area	LibTest

	; Test the importation of library elements

	.globl	lfnc02,lfnc03,lfnc10

	.list	(md,meb)

	.macro	call	arg	; dumby function call
	.byte	0xFF, >arg, <arg
	.endm


start:	Call	lfnc02		; call a library function which
				; has no dependencies

	Call	lfnc03		; call a library function which
				; has a dependency

	Call	lfnc10		; call a library function which
				; has dependencies that have
				; dependencies

	.end