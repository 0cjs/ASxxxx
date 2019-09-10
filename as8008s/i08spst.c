/* i08spst.c */

/*
 *  Copyright (C) 2018-2019  Alan R. Baldwin
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
#include "i08s.h"

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
 *	#define		R_INP	0100		----xxx-
 */
char	mode1[32] = {	/* R_INP */
	'\201',	'\202',	'\203',	'\003',	'\004',	'\005',	'\006',	'\007',
	'\010',	'\011',	'\012',	'\013',	'\014',	'\015',	'\016',	'\017',
	'\020',	'\021',	'\022',	'\023',	'\024',	'\025',	'\026',	'\027',
	'\030',	'\031',	'\032',	'\033',	'\034',	'\035',	'\036',	'\037'
};

/*
 *	#define		R_OUT	0200		--xxxxx-
 */
char	mode2[32] = {	/* R_OUT */
	'\201',	'\202',	'\203',	'\204',	'\205',	'\005',	'\006',	'\007',
	'\010',	'\011',	'\012',	'\013',	'\014',	'\015',	'\016',	'\017',
	'\020',	'\021',	'\022',	'\023',	'\024',	'\025',	'\026',	'\027',
	'\030',	'\031',	'\032',	'\033',	'\034',	'\035',	'\036',	'\037'
};

/*
 *	#define		R_RST	0300		--xxx---
 */
char	mode3[32] = {	/* R_RST */
	'\203',	'\204',	'\205',	'\003',	'\004',	'\005',	'\006',	'\007',
	'\010',	'\011',	'\012',	'\013',	'\014',	'\015',	'\016',	'\017',
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
    {	&mode0[0],	0,	0x0000FFFF,	0x0000FFFF	},
    {	&mode1[0],	1,	0x0000000E,	0x00000007	},
    {	&mode2[0],	1,	0x0000003E,	0x0000001F	},
    {	&mode3[0],	1,	0x00000038,	0x00000007	}
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

	/* system */

    {	NULL,	"CSEG",		S_ATYP,		0,	A_CSEG|A_1BYTE	},
    {	NULL,	"DSEG",		S_ATYP,		0,	A_DSEG|A_1BYTE	},

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

	/* 8008S */
    	/* SIM8 Instruction Mnemonics */

    {	NULL,	"hlt",		S_INH,		0,	0x00	},
/*    {	NULL,	"---",		---,		0,	0x01	}, */
    {	NULL,	"rlc",		S_INH,		0,	0x02	},
    {	NULL,	"rfc",		S_INH,		0,	0x03	},
    {	NULL,	"adi",		S_ADI,		0,	0x04	},
    {	NULL,	"rst",		S_RST,		0,	0x05	},
    {	NULL,	"lia",		S_MVI,		0,	0x06	},
    {	NULL,	"ret",		S_INH,		0,	0x07	},

    {	NULL,	"inb",		S_INH,		0,	0x08	},
    {	NULL,	"dcb",		S_INH,		0,	0x09	},
    {	NULL,	"rrc",		S_INH,		0,	0x0A	},
    {	NULL,	"rfz",		S_INH,		0,	0x0B	},
    {	NULL,	"aci",		S_ADI,		0,	0x0C	},
/*    {	NULL,	"rst 1",	S_RST,		0,	0x0D	}, */
    {	NULL,	"lib",		S_MVI,		0,	0x0E	},
/*    {	NULL,	"ret",		S_INH,		0,	0x0F	}, */

    {	NULL,	"inc",		S_INH,		0,	0x10	},
    {	NULL,	"dcc",		S_INH,		0,	0x11	},
    {	NULL,	"ral",		S_INH,		0,	0x12	},
    {	NULL,	"rfs",		S_INH,		0,	0x13	},
    {	NULL,	"sui",		S_ADI,		0,	0x14	},
/*    {	NULL,	"rst 2",	S_RST,		0,	0x15	}, */
    {	NULL,	"lic",		S_MVI,		0,	0x16	},
/*    {	NULL,	"ret",		S_INH,		0,	0x17	}, */

    {	NULL,	"ind",		S_INH,		0,	0x18	},
    {	NULL,	"dcd",		S_INH,		0,	0x19	},
    {	NULL,	"rar",		S_INH,		0,	0x1A	},
    {	NULL,	"rfp",		S_INH,		0,	0x1B	},
    {	NULL,	"sbi",		S_ADI,		0,	0x1C	},
/*    {	NULL,	"rst 3",	S_RST,		0,	0x1D	}, */
    {	NULL,	"lid",		S_MVI,		0,	0x1E	},
/*    {	NULL,	"ret",		S_INH,		0,	0x1F	}, */

    {	NULL,	"ine",		S_INH,		0,	0x20	},
    {	NULL,	"dce",		S_INH,		0,	0x21	},
/*    {	NULL,	"---",		---,		0,	0x22	}, */
    {	NULL,	"rtc",		S_INH,		0,	0x23	},
    {	NULL,	"ndi",		S_ADI,		0,	0x24	},
/*    {	NULL,	"rst 4",	S_RST,		0,	0x25	}, */
    {	NULL,	"lie",		S_MVI,		0,	0x26	},
/*    {	NULL,	"---",		---,		0,	0x27	}, */

    {	NULL,	"inh",		S_INH,		0,	0x28	},
    {	NULL,	"dch",		S_INH,		0,	0x29	},
/*    {	NULL,	"---",		---,		0,	0x2A	}, */
    {	NULL,	"rtz",		S_INH,		0,	0x2B	},
    {	NULL,	"xri",		S_ADI,		0,	0x2C	},
/*    {	NULL,	"rst 5",	S_RST,		0,	0x2D	}, */
    {	NULL,	"lih",		S_MVI,		0,	0x2E	},
/*    {	NULL,	"---",		---,		0,	0x2F	}, */

    {	NULL,	"inl",		S_INH,		0,	0x30	},
    {	NULL,	"dcl",		S_INH,		0,	0x31	},
/*    {	NULL,	"---",		---,		0,	0x32	}, */
    {	NULL,	"rts",		S_INH,		0,	0x33	},
    {	NULL,	"ori",		S_ADI,		0,	0x34	},
/*    {	NULL,	"rst 6",	S_RST,		0,	0x35	}, */
    {	NULL,	"lil",		S_MVI,		0,	0x36	},
/*    {	NULL,	"ret",		S_INH,		0,	0x37	}, */

/*    {	NULL,	"---",		---,		0,	0x38	}, */
/*    {	NULL,	"---",		---,		0,	0x39	}, */
/*    {	NULL,	"---",		---,		0,	0x3A	}, */
    {	NULL,	"rtp",		S_INH,		0,	0x3B	},
    {	NULL,	"cpi",		S_ADI,		0,	0x3C	},
/*    {	NULL,	"rst 7",	S_RST,		0,	0x3D	}, */
    {	NULL,	"lim",		S_MVI,		0,	0x3E	},
/*    {	NULL,	"ret",		S_INH,		0,	0x3F	}, */

    {	NULL,	"jfc",		S_JMP,		0,	0x40	},
    {	NULL,	"inp",		S_INP,		0,	0x41	},
    {	NULL,	"cfc",		S_JMP,		0,	0x42	},
/*    {	NULL,	"inp 1",	S_INP,		0,	0x43	}, */
    {	NULL,	"jmp",		S_JMP,		0,	0x44	},
/*    {	NULL,	"inp 2",	S_INP,		0,	0x45	}, */
    {	NULL,	"cal",		S_JMP,		0,	0x46	},
/*    {	NULL,	"inp 3",	S_INP,		0,	0x47	}, */

    {	NULL,	"jfz",		S_JMP,		0,	0x48	},
/*    {	NULL,	"inp 4",	S_INP,		0,	0x49	}, */
    {	NULL,	"cnz",		S_JMP,		0,	0x4A	},
/*    {	NULL,	"inp 5",	S_INP,		0,	0x4B	}, */
/*    {	NULL,	"---",		---,		0,	0x4C	}, */
/*    {	NULL,	"inp 6",	S_INP,		0,	0x4D	}, */
/*    {	NULL,	"---",		---,		0,	0x4E	}, */
/*    {	NULL,	"inp 7",	S_INP,		0,	0x4F	}, */

    {	NULL,	"jfs",		S_JMP,		0,	0x50	},
    {	NULL,	"out",		S_OUT,		0,	0x41	},  /* This is the base for inp and out */
    {	NULL,	"cfs",		S_JMP,		0,	0x52	},
/*    {	NULL,	"ou1 9",	S_OUT,		0,	0x53	}, */
/*    {	NULL,	"---",		---,		0,	0x54	}, */
/*    {	NULL,	"out 10",	S_OUT,		0,	0x55	}, */
/*    {	NULL,	"---",		---,		0,	0x56	}, */
/*    {	NULL,	"out 11",	S_OUT,		0,	0x57	}, */

    {	NULL,	"jfp",		S_JMP,		0,	0x58	},
/*    {	NULL,	"out 12",	S_OUT,		0,	0x59	}, */
    {	NULL,	"cfp",		S_JMP,		0,	0x5A	},
/*    {	NULL,	"out 13",	S_OUT,		0,	0x5B	}, */
/*    {	NULL,	"---",		---,		0,	0x5C	}, */
/*    {	NULL,	"out 14",	S_OUT,		0,	0x5D	}, */
/*    {	NULL,	"---",		---,		0,	0x5E	}, */
/*    {	NULL,	"out 15",	S_OUT,		0,	0x5F	}, */

    {	NULL,	"jtc",		S_JMP,		0,	0x60	},
/*    {	NULL,	"out 16",	S_OUT,		0,	0x61	}, */
    {	NULL,	"ctc",		S_JMP,		0,	0x62	},
/*    {	NULL,	"out 17",	S_OUT,		0,	0x63	}, */
/*    {	NULL,	"---",		---,		0,	0x64	}, */
/*    {	NULL,	"out 18",	S_OUT,		0,	0x65	}, */
/*    {	NULL,	"---",		---,		0,	0x66	}, */
/*    {	NULL,	"out 19",	S_OUT,		0,	0x67	}, */

    {	NULL,	"jtz",		S_JMP,		0,	0x68	},
/*    {	NULL,	"out 20",	S_OUT,		0,	0x69	}, */
    {	NULL,	"ctz",		S_JMP,		0,	0x6A	},
/*    {	NULL,	"out 21",	S_OUT,		0,	0x6B	}, */
/*    {	NULL,	"---",		---,		0,	0x6C	}, */
/*    {	NULL,	"out 22",	S_OUT,		0,	0x6D	}, */
/*    {	NULL,	"---",		---,		0,	0x6E	}, */
/*    {	NULL,	"out 23",	S_OUT,		0,	0x6F	}, */

    {	NULL,	"jtm",		S_JMP,		0,	0x70	},
/*    {	NULL,	"out 24",	S_OUT,		0,	0x71	}, */
    {	NULL,	"ctm",		S_JMP,		0,	0x72	},
/*    {	NULL,	"oup 25",	S_OUT,		0,	0x73	}, */
/*    {	NULL,	"---",		---,		0,	0x74	}, */
/*    {	NULL,	"out 26",	S_OUT,		0,	0x75	}, */
/*    {	NULL,	"---",		---,		0,	0x76	}, */
/*    {	NULL,	"out 27",	S_OUT,		0,	0x77	}, */

    {	NULL,	"jtp",		S_JMP,		0,	0x78	},
/*    {	NULL,	"out 28",	S_OUT,		0,	0x79	}, */
    {	NULL,	"ctp",		S_JMP,		0,	0x7A	},
/*    {	NULL,	"out 29",	S_OUT,		0,	0x7B	}, */
/*    {	NULL,	"---",		---,		0,	0x7C	}, */
/*    {	NULL,	"out 30",	S_OUT,		0,	0x7D	}, */
/*    {	NULL,	"---",		---,		0,	0x7E	}, */
/*    {	NULL,	"out 31",	S_OUT,		0,	0x7F	}, */

    {	NULL,	"ada",		S_INH,		0,	0x80	},
    {	NULL,	"adb",		S_INH,		0,	0x81	},
    {	NULL,	"adc",		S_INH,		0,	0x82	},
    {	NULL,	"add",		S_INH,		0,	0x83	},
    {	NULL,	"ade",		S_INH,		0,	0x84	},
    {	NULL,	"adh",		S_INH,		0,	0x85	},
    {	NULL,	"adl",		S_INH,		0,	0x86	},
    {	NULL,	"adm",		S_INH,		0,	0x87	},

    {	NULL,	"aca",		S_INH,		0,	0x88	},
    {	NULL,	"acb",		S_INH,		0,	0x89	},
    {	NULL,	"acc",		S_INH,		0,	0x8A	},
    {	NULL,	"acd",		S_INH,		0,	0x8B	},
    {	NULL,	"ace",		S_INH,		0,	0x8C	},
    {	NULL,	"ach",		S_INH,		0,	0x8D	},
    {	NULL,	"acl",		S_INH,		0,	0x8E	},
    {	NULL,	"acm",		S_INH,		0,	0x8F	},

    {	NULL,	"sua",		S_INH,		0,	0x90	},
    {	NULL,	"sub",		S_INH,		0,	0x91	},
    {	NULL,	"suc",		S_INH,		0,	0x92	},
    {	NULL,	"sud",		S_INH,		0,	0x93	},
    {	NULL,	"sue",		S_INH,		0,	0x94	},
    {	NULL,	"suh",		S_INH,		0,	0x95	},
    {	NULL,	"sul",		S_INH,		0,	0x96	},
    {	NULL,	"sum",		S_INH,		0,	0x97	},

    {	NULL,	"sba",		S_INH,		0,	0x98	},
    {	NULL,	"sbb",		S_INH,		0,	0x99	},
    {	NULL,	"sbc",		S_INH,		0,	0x9A	},
    {	NULL,	"sbd",		S_INH,		0,	0x9B	},
    {	NULL,	"sbe",		S_INH,		0,	0x9C	},
    {	NULL,	"sbh",		S_INH,		0,	0x9D	},
    {	NULL,	"sbl",		S_INH,		0,	0x9E	},
    {	NULL,	"sbm",		S_INH,		0,	0x9F	},

    {	NULL,	"nda",		S_INH,		0,	0xA0	},
    {	NULL,	"ndb",		S_INH,		0,	0xA1	},
    {	NULL,	"ndc",		S_INH,		0,	0xA2	},
    {	NULL,	"ndd",		S_INH,		0,	0xA3	},
    {	NULL,	"nde",		S_INH,		0,	0xA4	},
    {	NULL,	"ndh",		S_INH,		0,	0xA5	},
    {	NULL,	"ndl",		S_INH,		0,	0xA6	},
    {	NULL,	"ndm",		S_INH,		0,	0xA7	},

    {	NULL,	"xra",		S_INH,		0,	0xA8	},
    {	NULL,	"xrb",		S_INH,		0,	0xA9	},
    {	NULL,	"xrc",		S_INH,		0,	0xAA	},
    {	NULL,	"xrd",		S_INH,		0,	0xAB	},
    {	NULL,	"xre",		S_INH,		0,	0xAC	},
    {	NULL,	"xrh",		S_INH,		0,	0xAD	},
    {	NULL,	"xrl",		S_INH,		0,	0xAE	},
    {	NULL,	"xrm",		S_INH,		0,	0xAF	},

    {	NULL,	"ora",		S_INH,		0,	0xB0	},
    {	NULL,	"orb",		S_INH,		0,	0xB1	},
    {	NULL,	"orc",		S_INH,		0,	0xB2	},
    {	NULL,	"ord",		S_INH,		0,	0xB3	},
    {	NULL,	"ore",		S_INH,		0,	0xB4	},
    {	NULL,	"orh",		S_INH,		0,	0xB5	},
    {	NULL,	"orl",		S_INH,		0,	0xB6	},
    {	NULL,	"orm",		S_INH,		0,	0xB7	},

    {	NULL,	"cpa",		S_INH,		0,	0xB8	},
    {	NULL,	"cpb",		S_INH,		0,	0xB9	},
    {	NULL,	"cpc",		S_INH,		0,	0xBA	},
    {	NULL,	"cpd",		S_INH,		0,	0xBB	},
    {	NULL,	"cpe",		S_INH,		0,	0xBC	},
    {	NULL,	"cph",		S_INH,		0,	0xBD	},
    {	NULL,	"cpl",		S_INH,		0,	0xBE	},
    {	NULL,	"cpm",		S_INH,		0,	0xBF	},

    {	NULL,	"nop",		S_INH,		0,	0xC0	},
    {	NULL,	"lab",		S_INH,		0,	0xC1	},
    {	NULL,	"lac",		S_INH,		0,	0xC2	},
    {	NULL,	"lad",		S_INH,		0,	0xC3	},
    {	NULL,	"lae",		S_INH,		0,	0xC4	},
    {	NULL,	"lah",		S_INH,		0,	0xC5	},
    {	NULL,	"lal",		S_INH,		0,	0xC6	},
    {	NULL,	"lam",		S_INH,		0,	0xC7	},

    {	NULL,	"lba",		S_INH,		0,	0xC8	},
    {	NULL,	"lbb",		S_INH,		0,	0xC9	},
    {	NULL,	"lbc",		S_INH,		0,	0xCA	},
    {	NULL,	"lbd",		S_INH,		0,	0xCB	},
    {	NULL,	"lbe",		S_INH,		0,	0xCC	},
    {	NULL,	"lbh",		S_INH,		0,	0xCD	},
    {	NULL,	"lbl",		S_INH,		0,	0xCE	},
    {	NULL,	"lbm",		S_INH,		0,	0xCF	},

    {	NULL,	"lca",		S_INH,		0,	0xD0	},
    {	NULL,	"lcb",		S_INH,		0,	0xD1	},
    {	NULL,	"lcc",		S_INH,		0,	0xD2	},
    {	NULL,	"lcd",		S_INH,		0,	0xD3	},
    {	NULL,	"lce",		S_INH,		0,	0xD4	},
    {	NULL,	"lch",		S_INH,		0,	0xD5	},
    {	NULL,	"lcl",		S_INH,		0,	0xD6	},
    {	NULL,	"lcm",		S_INH,		0,	0xD7	},

    {	NULL,	"lda",		S_INH,		0,	0xD8	},
    {	NULL,	"ldb",		S_INH,		0,	0xD9	},
    {	NULL,	"ldc",		S_INH,		0,	0xDA	},
    {	NULL,	"ldd",		S_INH,		0,	0xDB	},
    {	NULL,	"lde",		S_INH,		0,	0xDC	},
    {	NULL,	"ldh",		S_INH,		0,	0xDD	},
    {	NULL,	"ldl",		S_INH,		0,	0xDE	},
    {	NULL,	"ldm",		S_INH,		0,	0xDF	},

    {	NULL,	"lea",		S_INH,		0,	0xE0	},
    {	NULL,	"leb",		S_INH,		0,	0xE1	},
    {	NULL,	"lec",		S_INH,		0,	0xE2	},
    {	NULL,	"led",		S_INH,		0,	0xE3	},
    {	NULL,	"lee",		S_INH,		0,	0xE4	},
    {	NULL,	"leh",		S_INH,		0,	0xE5	},
    {	NULL,	"lel",		S_INH,		0,	0xE6	},
    {	NULL,	"lem",		S_INH,		0,	0xE7	},

    {	NULL,	"lha",		S_INH,		0,	0xE8	},
    {	NULL,	"lhb",		S_INH,		0,	0xE9	},
    {	NULL,	"lhc",		S_INH,		0,	0xEA	},
    {	NULL,	"lhd",		S_INH,		0,	0xEB	},
    {	NULL,	"lhe",		S_INH,		0,	0xEC	},
    {	NULL,	"lhh",		S_INH,		0,	0xED	},
    {	NULL,	"lhl",		S_INH,		0,	0xEE	},
    {	NULL,	"lhm",		S_INH,		0,	0xEF	},

    {	NULL,	"lla",		S_INH,		0,	0xF0	},
    {	NULL,	"llb",		S_INH,		0,	0xF1	},
    {	NULL,	"llc",		S_INH,		0,	0xF2	},
    {	NULL,	"lld",		S_INH,		0,	0xF3	},
    {	NULL,	"lle",		S_INH,		0,	0xF4	},
    {	NULL,	"llh",		S_INH,		0,	0xF5	},
    {	NULL,	"lll",		S_INH,		0,	0xF6	},
    {	NULL,	"llm",		S_INH,		0,	0xF7	},

    {	NULL,	"lma",		S_INH,		0,	0xF8	},
    {	NULL,	"lmb",		S_INH,		0,	0xF9	},
    {	NULL,	"lmc",		S_INH,		0,	0xFA	},
    {	NULL,	"lmd",		S_INH,		0,	0xFB	},
    {	NULL,	"lme",		S_INH,		0,	0xFC	},
    {	NULL,	"lmh",		S_INH,		0,	0xFD	},
    {	NULL,	"lml",		S_INH,		0,	0xFE	},

    {	NULL,	"shl",		S_SHL,		S_EOL,	0xFD	}
};
