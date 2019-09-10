	.list	(meb)

;    .__.CPU. = 1    ; .pic12bit
;    .__.CPU. = 2    ; .pic14bit
;    .__.CPU. = 3    ; .pic16bit
;    .__.CPU. = 4    ; .pic20bit

.macro	tris arg
    ; arg must evaluate to a constant
    ; an external argument is NOT validated
    .ntyp  .$.tris,arg
    .ifeq  .$.tris     ; only test absolute arguments
        .iiflt arg-5   .error 1 ; tris argument < 5
        .iifgt arg-7   .error 1 ; tris argument > 7
    .endif
    .ifeq  .__.CPU.-1	; .pic12bit
    	.word   0x0000 | arg
        .mexit
    .endif
    .ifeq  .__.CPU.-2   ; .pic14bit
        .word   0x0060 | arg
        .mexit
    .endif
    .error 1 ; No tris instruction in .pic16bit/.pic20bit
.endm

    .__.CPU. = 1    ; .pic12bit

	tris	#4
	tris	#5
	tris	#6
	tris	#7
	tris	#8


    .__.CPU. = 2    ; .pic14bit

	tris	#4
	tris	#5
	tris	#6
	tris	#7
	tris	#8

