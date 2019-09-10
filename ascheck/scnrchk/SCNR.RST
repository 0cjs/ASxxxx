ASxxxx Assembler V05.06+  (ASxxxx Test Assembler)                       Page 1
Hexadecimal [16-Bits]                                 Thu Aug 14 08:59:32 2014
ASXSCN Scanner Testing


                              1 	.title	ASXSCN Scanner Testing
                              2 
                              3 	.area	A	(rel,con)
                              4 
   0000                       5 	100$:
   0000                       6 	101$:	.blkb	0x10
   0010                       7 		.blkb	0x10
   0020 00 01 02 03           8 		.byte	0,1,2,3
   0024                       9 		.blkb	0x20
                             10 
   0044 44                   11 	byte0:	.byte	#byte0
   0045 45                   12 	byte1:	.byte	#byte1
   0046 46                   13 	byte2:	.byte	#byte2
   0047 47                   14 	byte3:	.byte	#byte3
   0048 48                   15 	byte4:	.byte	#byte4
   0049 49                   16 	byte5:	.byte	#byte5
   004A 4A                   17 	byte6:	.byte	#byte6
   004B 4B                   18 	byte7:	.byte	#byte7
   004C 4C                   19 	byte8:	.byte	#byte8
   004D 4D                   20 	byte9:	.byte	#byte9
   004E 4E                   21 	byteA:	.byte	#byteA
   004F 4F                   22 	byteB:	.byte	#byteB
   0050 50                   23 	byteC:	.byte	#byteC
   0051 51                   24 	byteD:	.byte	#byteD
   0052 52                   25 	byteE:	.byte	#byteE
   0053 53                   26 	byteF:	.byte	#byteF
   0054 00 01 02 03 04 05    27 		.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
        06 07 08 09 0A 0B
        0C 0D 0E 0F
                             28 
   0064                      29 	byte10:


                             34 ;	.list (!,err,loc,bin,eqt,cyc,lin,src)
   0064 00            [ 0]   36 	0$:	.opcode	0
                     0044    37 		code = #byte0
                             38 
                             40 ;	.list (!,err,loc,bin,eqt,cyc,lin)
   0065 01            [ 1]   42
                     0045    43
                             44
                             46 ;	.list (!,err,loc,bin,eqt,cyc)
   0066 02            [ 2]
                     0046

                             52 ;	.list (!,err,loc,bin,eqt)
   0067 03
                     0047

                             58 ;	.list (!,err,loc,bin)
   0068 04


                             64 ;	.list (!,err,loc)
   0069


                             70 ;	.list (!,err)



                             76 	.area B
                             77 
   006D 6D                   78 	byte20:	.byte	#byte20
   006E 6E                   79 	byte21:	.byte	#byte21
   006F 6F                   80 	byte22:	.byte	#byte22
   0070 70                   81 	byte23:	.byte	#byte23
   0071 71                   82 	byte24:	.byte	#byte24
   0072 72                   83 	byte25:	.byte	#byte25
   0073 73                   84 	byte26:	.byte	#byte26
   0074 74                   85 	byte27:	.byte	#byte27
   0075 75                   86 	byte28:	.byte	#byte28
   0076 76                   87 	byte29:	.byte	#byte29
   0077 77                   88 	byte2A:	.byte	#byte2A
   0078 78                   89 	byte2B:	.byte	#byte2B
   0079 79                   90 	byte2C:	.byte	#byte2C
   007A 7A                   91 	byte2D:	.byte	#byte2D
   007B 7B                   92 	byte2E:	.byte	#byte2E
   007C 7C                   93 	byte2F:	.byte	#byte2F
   007D 00 01 02 03 04 05    94 		.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
        06 07 08 09 0A 0B
        0C 0D 0E 0F
                             95 
   008D                      96 	byte30:


                            101 ;	.list (!,loc,bin,eqt,cyc,lin,src)
   008D 00            [ 0]  103 	10$:	.opcode	0
                     0044   104 		code = #byte0
                     006D   105 		code = #byte20
   008E                     106 	20$:
                            107 
                            109 ;	.list (!,bin,eqt,cyc,lin,src)
        01            [ 1]  111 	11$:	.opcode	1
                     0045   112 		code = #byte1
                     006E   113 		code = #byte21
                            114 	21$:
                            115 
                            117 ;	.list (!,loc,eqt,cyc,lin,src)
   008F               [ 2]  119 	12$:	.opcode	2
                     0046   120 		code = #byte2
                     006F   121 		code = #byte22
   0090                     122 	22$:
                            123 
                            125 ;	.list (!,loc,bin,cyc,lin,src)
   0090 03            [ 3]  127 	13$:	.opcode	3
                            128 		code = #byte3
                            129 		code = #byte23
   0091                     130 	23$:
                            131 
                            133 ;	.list (!,loc,bin,eqt,lin,src)
   0091 04                  135 	14$:	.opcode	4
                     0048   136 		code = #byte4
                     0071   137 		code = #byte24
   0092                     138 	24$:
                            139 
                            141 ;	.list (!,loc,bin,eqt,cyc,src)
   0092 05            [ 5]      	15$:	.opcode	5
                     0049       		code = #byte5
                     0072       		code = #byte25
   0093                         	25$:
                                
                            149 		.globl	byte40
r                    0000   150 		cddd = byte40
r                    0000   151 		cdde = byte41
                     0093   152 		cddf = .
                     0095   153 		cddj = . + 2
                     0091   154 		cddj = . - 2
   0093 00 93               155 		.word	cddf
                     0002   156 		cddg = 2
                            157 
                            158 	.area	A
                            159 
   006B 00 6B               160 		.word	.
                     0002   161 	a = 2
                     006D   162 	b = .
                     008F   163 	c = .+34
                     006F   164 	d = c-32
                            165 
                            166 	.area	B
                            167 
                     0002   168 	j = 2
                            169 
                     0095   170 	k = .
                            171 		;
                     00B7   172 	l = .+34
                            173 
                            174 		;

                     002A   178 	m = l-32
                            179 
                            180 	;as:
                            180 	;as:
                            181 
                            181 
