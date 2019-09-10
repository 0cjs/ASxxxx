	.module func10
	.area	func10

	.globl	lfnc10		; Make Internal Element Global
	.globl	lfnc07		; Define External Element As Global

	.list	(md,meb)

	.macro	call	arg	; dumby function call
	.byte	0xFF, >arg, <arg
	.endm

lfnc10:	.byte	0,0xA,0		; dumby function entry point

	call	lfnc07		; external function call

	.end