/* R78K0PST.C */

/*
 *  Copyright (C) 2019  Alan R. Baldwin
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

#include "asxxxx.h"
#include "r78k0.h"

/*
 * Coding Banks
 */
struct	bank	bank[2] = {
    /*	The '_CODE' area/bank has a NULL default file suffix.	*/
    {	NULL,		"_CSEG",	NULL,		0,	0,	0,	0,	0	},
    {	&bank[0],	"_DSEG",	"_DS",		1,	0,	0,	0,	B_FSFX	}
};

/*
 * Coding Areas
 */
struct	area	area[2] = {
    {	NULL,		&bank[0],	"_CODE",	0,	0,	0,	A_1BYTE|A_BNK|A_CSEG	},
    {	&area[0],	&bank[1],	"_DATA",	1,	0,	0,	A_1BYTE|A_BNK|A_DSEG	}
};

/*
 * Basic Relocation Mode Definition
 *
 *	#define		R_NORM	0000		No Bit Positioning
 */
char	mode0[32] = {	/* R_NORM */
	'\200',	'\201',	'\202',	'\203',	'\204',	'\205',	'\206',	'\207',
	'\210',	'\211',	'\212',	'\213',	'\214',	'\215',	'\216',	'\217',
	'\220',	'\221',	'\222',	'\223',	'\224',	'\225',	'\226',	'\227',
	'\230',	'\231',	'\232',	'\233',	'\234',	'\235',	'\236',	'\237'
};

/*
 * Additional Relocation Mode Definitions
*
 *	#define		R_3BIT	0100		Bit Positioning Required
 */
char	mode1[32] = {	/* R_3BIT */
	'\204',	'\205',	'\206',	'\003',	'\004',	'\005',	'\006',	'\007',
	'\010',	'\011',	'\012',	'\013',	'\014',	'\015',	'\016',	'\017',
	'\020',	'\021',	'\022',	'\023',	'\024',	'\025',	'\026',	'\027',
	'\030',	'\031',	'\032',	'\033',	'\034',	'\035',	'\036',	'\037'
};

/*
 *	#define		R_5BIT	0200		No Bit Positioning
 */
char	mode2[32] = {	/* R_5BIT */
	'\000',	'\201',	'\202',	'\203',	'\204',	'\205',	'\006',	'\007',
	'\010',	'\011',	'\012',	'\013',	'\014',	'\015',	'\016',	'\017',
	'\020',	'\021',	'\022',	'\023',	'\024',	'\025',	'\026',	'\027',
	'\030',	'\031',	'\032',	'\033',	'\034',	'\035',	'\036',	'\037'
};

/*
 *	#define		R_11BIT	0300		Bit Positioning Required
 */
char	mode3[32] = {	/* R_11BIT */
	'\210',	'\211',	'\212',	'\213',	'\214',	'\215',	'\216',	'\217',
	'\204',	'\205',	'\206',	'\013',	'\014',	'\015',	'\016',	'\017',
	'\020',	'\021',	'\022',	'\023',	'\024',	'\025',	'\026',	'\027',
	'\030',	'\031',	'\032',	'\033',	'\034',	'\035',	'\036',	'\037'
};

/*
 *     *m_def is a pointer to the bit relocation definition.
 *	m_flag indicates that bit position swapping is required.
 *	m_dbits contains the active bit positions for the output.
 *	m_sbits contains the active bit positions for the input.
 *
 *	struct	mode
 *	{
 *		char *	m_def;		Bit Relocation Definition
 *		a_uint	m_flag;		Bit Swapping Flag
 *		a_uint	m_dbits;	Destination Bit Mask
 *		a_uint	m_sbits;	Source Bit Mask
 *	};
 */
struct	mode	mode[4] = {
    {	&mode0[0],	0,	0x0000FFFF,	0x0000FFFF	},	/* R_NORM  */
    {	&mode1[0],	1,	0x00000070,	0x00000007	},	/* R_3BIT */
    {	&mode2[0],	0,	0x0000003E,	0x0000003E	},	/* R_5BIT  */
    {	&mode3[0],	1,	0x0000FF70,	0x000007FF	}	/* R_11BIT */
};

/*
 * Array of Pointers to mode Structures
 */
struct	mode	*modep[16] = {
	&mode[0],	&mode[1],	&mode[2],	&mode[3],
	NULL,		NULL,		NULL,		NULL,
	NULL,		NULL,		NULL,		NULL,
	NULL,		NULL,		NULL,		NULL
};

/*
 * Mnemonic Structure
 */
struct	mne	mne[] = {

	/* machine */

    {	NULL,	"CSEG",		S_ATYP,		0,	A_CSEG|A_1BYTE	},
    {	NULL,	"DSEG",		S_ATYP,		0,	A_DSEG|A_1BYTE	},

/*    {	NULL,	".setdp",	S_SDP,		0,	0	}, */

	/* system */

    {	NULL,	"BANK",		S_ATYP,		0,	A_BNK	},
    {	NULL,	"CON",		S_ATYP,		0,	A_CON	},
    {	NULL,	"OVR",		S_ATYP,		0,	A_OVR	},
    {	NULL,	"REL",		S_ATYP,		0,	A_REL	},
    {	NULL,	"ABS",		S_ATYP,		0,	A_ABS	},
    {	NULL,	"NOPAG",	S_ATYP,		0,	A_NOPAG	},
    {	NULL,	"PAG",		S_ATYP,		0,	A_PAG	},

    {	NULL,	"BASE",		S_BTYP,		0,	B_BASE	},
    {	NULL,	"SIZE",		S_BTYP,		0,	B_SIZE	},
    {	NULL,	"FSFX",		S_BTYP,		0,	B_FSFX	},
    {	NULL,	"MAP",		S_BTYP,		0,	B_MAP	},

    {	NULL,	".page",	S_PAGE,		0,	0	},
    {	NULL,	".title",	S_HEADER,	0,	O_TITLE	},
    {	NULL,	".sbttl",	S_HEADER,	0,	O_SBTTL	},
    {	NULL,	".module",	S_MODUL,	0,	0	},
    {	NULL,	".include",	S_INCL,		0,	0	},
    {	NULL,	".area",	S_AREA,		0,	0	},
    {	NULL,	".bank",	S_BANK,		0,	0	},
    {	NULL,	".org",		S_ORG,		0,	0	},
    {	NULL,	".radix",	S_RADIX,	0,	0	},
    {	NULL,	".globl",	S_GLOBL,	0,	0	},
    {	NULL,	".local",	S_LOCAL,	0,	0	},
    {	NULL,	".if",		S_CONDITIONAL,	0,	O_IF	},
    {	NULL,	".iff",		S_CONDITIONAL,	0,	O_IFF	},
    {	NULL,	".ift",		S_CONDITIONAL,	0,	O_IFT	},
    {	NULL,	".iftf",	S_CONDITIONAL,	0,	O_IFTF	},
    {	NULL,	".ifdef",	S_CONDITIONAL,	0,	O_IFDEF	},
    {	NULL,	".ifndef",	S_CONDITIONAL,	0,	O_IFNDEF},
    {	NULL,	".ifgt",	S_CONDITIONAL,	0,	O_IFGT	},
    {	NULL,	".iflt",	S_CONDITIONAL,	0,	O_IFLT	},
    {	NULL,	".ifge",	S_CONDITIONAL,	0,	O_IFGE	},
    {	NULL,	".ifle",	S_CONDITIONAL,	0,	O_IFLE	},
    {	NULL,	".ifeq",	S_CONDITIONAL,	0,	O_IFEQ	},
    {	NULL,	".ifne",	S_CONDITIONAL,	0,	O_IFNE	},
    {	NULL,	".ifb",		S_CONDITIONAL,	0,	O_IFB	},
    {	NULL,	".ifnb",	S_CONDITIONAL,	0,	O_IFNB	},
    {	NULL,	".ifidn",	S_CONDITIONAL,	0,	O_IFIDN	},
    {	NULL,	".ifdif",	S_CONDITIONAL,	0,	O_IFDIF	},
    {	NULL,	".iif",		S_CONDITIONAL,	0,	O_IIF	},
    {	NULL,	".iiff",	S_CONDITIONAL,	0,	O_IIFF	},
    {	NULL,	".iift",	S_CONDITIONAL,	0,	O_IIFT	},
    {	NULL,	".iiftf",	S_CONDITIONAL,	0,	O_IIFTF	},
    {	NULL,	".iifdef",	S_CONDITIONAL,	0,	O_IIFDEF},
    {	NULL,	".iifndef",	S_CONDITIONAL,	0,	O_IIFNDEF},
    {	NULL,	".iifgt",	S_CONDITIONAL,	0,	O_IIFGT	},
    {	NULL,	".iiflt",	S_CONDITIONAL,	0,	O_IIFLT	},
    {	NULL,	".iifge",	S_CONDITIONAL,	0,	O_IIFGE	},
    {	NULL,	".iifle",	S_CONDITIONAL,	0,	O_IIFLE	},
    {	NULL,	".iifeq",	S_CONDITIONAL,	0,	O_IIFEQ	},
    {	NULL,	".iifne",	S_CONDITIONAL,	0,	O_IIFNE	},
    {	NULL,	".iifb",	S_CONDITIONAL,	0,	O_IIFB	},
    {	NULL,	".iifnb",	S_CONDITIONAL,	0,	O_IIFNB	},
    {	NULL,	".iifidn",	S_CONDITIONAL,	0,	O_IIFIDN},
    {	NULL,	".iifdif",	S_CONDITIONAL,	0,	O_IIFDIF},
    {	NULL,	".else",	S_CONDITIONAL,	0,	O_ELSE	},
    {	NULL,	".endif",	S_CONDITIONAL,	0,	O_ENDIF	},
    {	NULL,	".list",	S_LISTING,	0,	O_LIST	},
    {	NULL,	".nlist",	S_LISTING,	0,	O_NLIST	},
    {	NULL,	".equ",		S_EQU,		0,	O_EQU	},
    {	NULL,	".gblequ",	S_EQU,		0,	O_GBLEQU},
    {	NULL,	".lclequ",	S_EQU,		0,	O_LCLEQU},
    {	NULL,	".byte",	S_DATA,		0,	O_1BYTE	},
    {	NULL,	".db",		S_DATA,		0,	O_1BYTE	},
    {	NULL,	".fcb",		S_DATA,		0,	O_1BYTE	},
    {	NULL,	".word",	S_DATA,		0,	O_2BYTE	},
    {	NULL,	".dw",		S_DATA,		0,	O_2BYTE	},
    {	NULL,	".fdb",		S_DATA,		0,	O_2BYTE	},
/*    {	NULL,	".3byte",	S_DATA,		0,	O_3BYTE	},	*/
/*    {	NULL,	".triple",	S_DATA,		0,	O_3BYTE	},	*/
/*    {	NULL,	".4byte",	S_DATA,		0,	O_4BYTE	},	*/
/*    {	NULL,	".quad",	S_DATA,		0,	O_4BYTE	},	*/
    {	NULL,	".blkb",	S_BLK,		0,	O_1BYTE	},
    {	NULL,	".ds",		S_BLK,		0,	O_1BYTE	},
    {	NULL,	".rmb",		S_BLK,		0,	O_1BYTE	},
    {	NULL,	".rs",		S_BLK,		0,	O_1BYTE	},
    {	NULL,	".blkw",	S_BLK,		0,	O_2BYTE	},
/*    {	NULL,	".blk3",	S_BLK,		0,	O_3BYTE	},	*/
/*    {	NULL,	".blk4",	S_BLK,		0,	O_4BYTE	},	*/
    {	NULL,	".ascii",	S_ASCIX,	0,	O_ASCII	},
    {	NULL,	".ascis",	S_ASCIX,	0,	O_ASCIS	},
    {	NULL,	".asciz",	S_ASCIX,	0,	O_ASCIZ	},
    {	NULL,	".str",		S_ASCIX,	0,	O_ASCII	},
    {	NULL,	".strs",	S_ASCIX,	0,	O_ASCIS	},
    {	NULL,	".strz",	S_ASCIX,	0,	O_ASCIZ	},
    {	NULL,	".fcc",		S_ASCIX,	0,	O_ASCII	},
    {	NULL,	".define",	S_DEFINE,	0,	O_DEF	},
    {	NULL,	".undefine",	S_DEFINE,	0,	O_UNDEF	},
    {	NULL,	".even",	S_BOUNDARY,	0,	O_EVEN	},
    {	NULL,	".odd",		S_BOUNDARY,	0,	O_ODD	},
    {	NULL,	".bndry",	S_BOUNDARY,	0,	O_BNDRY	},
    {	NULL,	".msg"	,	S_MSG,		0,	0	},
    {	NULL,	".assume",	S_ERROR,	0,	O_ASSUME},
    {	NULL,	".error",	S_ERROR,	0,	O_ERROR	},
/*    {	NULL,	".msb",		S_MSB,		0,	0	},	*/
/*    {	NULL,	".lohi",	S_MSB,		0,	O_LOHI	},	*/
/*    {	NULL,	".hilo",	S_MSB,		0,	O_HILO	},	*/
/*    {	NULL,	".8bit",	S_BITS,		0,	O_1BYTE	},	*/
/*    {	NULL,	".16bit",	S_BITS,		0,	O_2BYTE	},	*/
/*    {	NULL,	".24bit",	S_BITS,		0,	O_3BYTE	},	*/
/*    {	NULL,	".32bit",	S_BITS,		0,	O_4BYTE	},	*/
    {	NULL,	".end",		S_END,		0,	0	},

	/* Macro Processor */

    {	NULL,	".macro",	S_MACRO,	0,	O_MACRO	},
    {	NULL,	".endm",	S_MACRO,	0,	O_ENDM	},
    {	NULL,	".mexit",	S_MACRO,	0,	O_MEXIT	},

    {	NULL,	".narg",	S_MACRO,	0,	O_NARG	},
    {	NULL,	".nchr",	S_MACRO,	0,	O_NCHR	},
    {	NULL,	".ntyp",	S_MACRO,	0,	O_NTYP	},

    {	NULL,	".irp",		S_MACRO,	0,	O_IRP	},
    {	NULL,	".irpc",	S_MACRO,	0,	O_IRPC	},
    {	NULL,	".rept",	S_MACRO,	0,	O_REPT	},

    {	NULL,	".nval",	S_MACRO,	0,	O_NVAL	},

    {	NULL,	".mdelete",	S_MACRO,	0,	O_MDEL	},

	/* 78K0 Assembler Specific Directives */

    {	NULL,	".setdp",	S_SDP,		0,	0	},
    {	NULL,	".xerr",	S_XERR,		0,	0	},

	/* 78K0 */

    {	NULL,	"mov",		S_MOV,		0,	0xA0	},
    {	NULL,	"xch",		S_XCH,		0,	0x30	},
    {	NULL,	"movw",		S_MOVW,		0,	0x10	},
    {	NULL,	"xchw",		S_XCHW,		0,	0xE0	},

    {	NULL,	"add",		S_ACC,		0,	0x00	},
    {	NULL,	"addc",		S_ACC,		0,	0x20	},
    {	NULL,	"sub",		S_ACC,		0,	0x10	},
    {	NULL,	"subc",		S_ACC,		0,	0x30	},
    {	NULL,	"and",		S_ACC,		0,	0x50	},
    {	NULL,	"or",		S_ACC,		0,	0x60	},
    {	NULL,	"xor",		S_ACC,		0,	0x70	},
    {	NULL,	"cmp",		S_ACC,		0,	0x40	},

    {	NULL,	"addw",		S_ACCW,		0,	0xCA	},
    {	NULL,	"subw",		S_ACCW,		0,	0xDA	},
    {	NULL,	"cmpw",		S_ACCW,		0,	0xEA	},

    {	NULL,	"mulu",		S_MUL,		0,	0x8831	},
    {	NULL,	"divuw",	S_DIV,		0,	0x8231	},

    {	NULL,	"inc",		S_INC,		0,	0x40	},
    {	NULL,	"dec",		S_DEC,		0,	0x50	},
    {	NULL,	"incw",		S_INCW,		0,	0x80	},
    {	NULL,	"decw",		S_DECW,		0,	0x90	},

    {	NULL,	"ror",		S_ROT,		0,	0x24	},
    {	NULL,	"rorc",		S_ROT,		0,	0x25	},
    {	NULL,	"rol",		S_ROT,		0,	0x26	},
    {	NULL,	"rolc",		S_ROT,		0,	0x27	},
    {	NULL,	"ror4",		S_ROT4,		0,	0x9031	},
    {	NULL,	"rol4",		S_ROT4,		0,	0x8031	},

    {	NULL,	"adjba",	S_INHW,		0,	0x8061	},
    {	NULL,	"adjbs",	S_INHW,		0,	0x9061	},

    {	NULL,	"mov1",		S_MOV1,		0,	0x04	},
    {	NULL,	"and1",		S_ACC1,		0,	0x05	},
    {	NULL,	"or1",		S_ACC1,		0,	0x06	},
    {	NULL,	"xor1",		S_ACC1,		0,	0x07	},

    {	NULL,	"set1",		S_SET1,		0,	0x0A	},
    {	NULL,	"clr1",		S_CLR1,		0,	0x0B	},
    {	NULL,	"not1",		S_NOT1,		0,	0x01	},

    {	NULL,	"call",		S_CALL,		0,	0x9A	},
    {	NULL,	"callf",	S_CALLF,	0,	0x000C	},
    {	NULL,	"callt",	S_CALLT,	0,	0xC1	},
    {	NULL,	"brk",		S_INH,		0,	0xBF	},
    {	NULL,	"ret",		S_INH,		0,	0xAF	},
    {	NULL,	"retb",		S_INH,		0,	0x9F	},
    {	NULL,	"reti",		S_INH,		0,	0x8F	},

    {	NULL,	"push",		S_PSH,		0,	0xB1	},
    {	NULL,	"pop",		S_POP,		0,	0xB0	},

    {	NULL,	"br",		S_BR,		0,	0x9831	},

    {	NULL,	"bc",		S_BRCZ,		0,	0x8D	},
    {	NULL,	"bnc",		S_BRCZ,		0,	0x9D	},
    {	NULL,	"bz",		S_BRCZ,		0,	0xAD	},
    {	NULL,	"bnz",		S_BRCZ,		0,	0xBD	},

    {	NULL,	"bt",		S_BT,		0,	0x00	},
    {	NULL,	"bf",		S_BF,		0,	0x01	},
    {	NULL,	"btclr",	S_BTCLR,	0,	0x02	},

    {	NULL,	"dbnz",		S_DBNZ,		0,	0x04	},

    {	NULL,	"sel",		S_SEL,		0,	0xD0	},
    {	NULL,	"nop",		S_INH,		0,	0x00	},
    {	NULL,	"ei",		S_INHW,		0,	0x1E7A	},
    {	NULL,	"di",		S_INHW,		0,	0x1E7B	},
    {	NULL,	"halt",		S_INHW,		0,	0x1071	},
    {	NULL,	"stop",		S_INHW,		S_EOL,	0x0071	}
};

