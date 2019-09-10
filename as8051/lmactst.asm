.nlist	(!) 

.MACRO SET_DATA_BYTE addr, rbyte                                                                                                                    
; Update the mask                                                                                                                          
.iflt (addr - RSC_INDIR_ADD) ;RAMBUS                                                                                                                 
                mov addr, #rbyte                                                                                                            
.else                                                                                                                     
                .iflt (addr - RSC_EXT_ADD) ;RAMBUS - Indirect resource                                                                                                               
                                mov R0, #addr ; 2 clx, 2 bytes                                                                                     
                                mov @R0, #rbyte ; 3 clx, 2 bytes                                                                                               
                .else ;MEMBUS                                                                                                
                                mov dptr, #addr ; 3 clx, 3 bytes - load data pointer with a 16b data                                                                                           
                                mov a, #rbyte ; 2 clx, 2 bytes                                                                                      
                                movx @dptr, a ; 4 clx, 1 byte                                                                                      
                .endif                                                                                                   
.endif                                                                                                                   

.ENDM

	addr = 0
	RSC_INDIR_ADD = 0x05
        RSC_EXT_ADD = 0x10

;#Problem/Error message >> Bus error (core dumped)

SET_DATA_BYTE IADDR_PGMCTRL_START1, ^/(MCU_SELFLAG_DREF_MASK | MCU_DREF1_LS_MASK | MCU_DREF0_LS_MASK | MCU_DREF1_RS_MASK | MCU_DREF0_RS_MASK)/

