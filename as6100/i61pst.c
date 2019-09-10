/* i61pst.c */

/*
 *  Copyright (C) 2013-2014  Alan R. Baldwin
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
#include "i6100.h"

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
    {	NULL,		&bank[0],	"_CODE",	0,	0,	0,	A_2BYTE|A_BNK|A_CSEG	},
    {	&area[0],	&bank[1],	"_DATA",	1,	0,	0,	A_2BYTE|A_BNK|A_DSEG	}
};

/*
 * Basic Relocation Mode Definition
 *
 *	#define		R_NORM	0000		No Bit Positioning
 */
char mode0[32] = {	/* R_NORM */
	'\200',	'\201',	'\202',	'\203',	'\204',	'\205',	'\206',	'\207',
	'\210',	'\211',	'\212',	'\213',	'\214',	'\215',	'\216',	'\217',
	'\220',	'\221',	'\222',	'\223',	'\224',	'\225',	'\226',	'\227',
	'\230',	'\231',	'\232',	'\233',	'\234',	'\235',	'\236',	'\237'
};

/*
 * Additional Relocation Mode Definitions
 *
 * Specification for the 6-bit addressing mode: --- xxx xxx ---
 */
char mode1[32] = {	/* R_6BIT */
	'\203',	'\204',	'\205',	'\206',	'\207',	'\210',	'\006',	'\007',
	'\010',	'\011',	'\012',	'\013',	'\014',	'\015',	'\016',	'\017',
	'\020',	'\021',	'\022',	'\023',	'\024',	'\025',	'\026',	'\027',
	'\030',	'\031',	'\032',	'\033',	'\034',	'\035',	'\036',	'\037'
};

/*
 * Specification for the 7-bit addressing mode: --- --x xxx xxx
 */
char mode2[32] = {	/* R_7BIT */
	'\200',	'\201',	'\202',	'\203',	'\204',	'\205',	'\206',	'\007',
	'\010',	'\011',	'\012',	'\013',	'\014',	'\015',	'\016',	'\017',
	'\020',	'\021',	'\022',	'\023',	'\024',	'\025',	'\026',	'\027',
	'\030',	'\031',	'\032',	'\033',	'\034',	'\035',	'\036',	'\037'
};

/*
 * Specification for the 8-bit addressing mode: --- -xx xxx xxx
 */
char mode3[32] = {	/* R_8BIT */
	'\200',	'\201',	'\202',	'\203',	'\204',	'\205',	'\206',	'\207',
	'\010',	'\011',	'\012',	'\013',	'\014',	'\015',	'\016',	'\017',
	'\020',	'\021',	'\022',	'\023',	'\024',	'\025',	'\026',	'\027',
	'\030',	'\031',	'\032',	'\033',	'\034',	'\035',	'\036',	'\037'
};

/*
 * Specification for the 9-bit addressing mode: --- xxx xxx xxx
 */
char mode4[32] = {	/* R_9BIT */
	'\200',	'\201',	'\202',	'\203',	'\204',	'\205',	'\206',	'\207',
	'\210',	'\011',	'\012',	'\013',	'\014',	'\015',	'\016',	'\017',
	'\020',	'\021',	'\022',	'\023',	'\024',	'\025',	'\026',	'\027',
	'\030',	'\031',	'\032',	'\033',	'\034',	'\035',	'\036',	'\037'
};

/*
 * Specification for the 12-bit addressing mode: --- < 11 : 00 >
 */
char mode5[32] = {	/* R_LOWRD */
	'\200',	'\201',	'\202',	'\203',	'\204',	'\205',	'\206',	'\207',
	'\210',	'\211',	'\212',	'\213',	'\014',	'\015',	'\016',	'\017',
	'\020',	'\021',	'\022',	'\023',	'\024',	'\025',	'\026',	'\027',
	'\030',	'\031',	'\032',	'\033',	'\034',	'\035',	'\036',	'\037'
};

/*
 * Specification for the 24-bit addressing mode: --- < 23 : 12 >
 */
char mode6[32] = {	/* R_HIWRD */
	'\000',	'\001',	'\002',	'\003',	'\004',	'\005',	'\006',	'\007',
	'\010',	'\011',	'\012',	'\013',	'\200',	'\201',	'\202',	'\203',
	'\204',	'\205',	'\206',	'\207',	'\210',	'\211',	'\212',	'\213',
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
struct	mode	mode[7] = {
#ifdef	LONGINT
    {	&mode0[0],	0,	0x00000FFFl,	0x00000FFFl	},	/* R_NORM  */
    {	&mode1[0],	1,	0x000001F8l,	0x0000003Fl	},	/* R_6BIT  */
    {	&mode2[0],	0,	0x0000007Fl,	0x0000007Fl	},	/* R_7BIT  */
    {	&mode3[0],	0,	0x000000FFl,	0x000000FFl	},	/* R_8BIT  */
    {	&mode4[0],	0,	0x000001FFl,	0x000001FFl	},	/* R_9BIT  */
    {	&mode5[0],	0,	0x00000FFFl,	0x00000FFFl	},	/* R_12BIT */
    {	&mode6[0],	1,	0x00000FFFl,	0x00FFF000l	}	/* R_24BIT */
#else
    {	&mode0[0],	0,	0x00000FFF,	0x00000FFF	},	/* R_NORM  */
    {	&mode1[0],	1,	0x000001F8,	0x0000003F	},	/* R_6BIT  */
    {	&mode2[0],	0,	0x0000007F,	0x0000007F	},	/* R_7BIT  */
    {	&mode3[0],	0,	0x000000FF,	0x000000FF	},	/* R_8BIT  */
    {	&mode4[0],	0,	0x000001FF,	0x000001FF	},	/* R_9BIT  */
    {	&mode5[0],	0,	0x00000FFF,	0x00000FFF	},	/* R_12BIT */
    {	&mode6[0],	1,	0x00000FFF,	0x00FFF000	}	/* R_24BIT */
#endif
};

/*
 * Array of Pointers to mode Structures
 */
struct	mode	*modep[16] = {
	&mode[0],	&mode[1],	&mode[2],	&mode[3],
	&mode[4],	&mode[5],	&mode[6],	NULL,
	NULL,		NULL,		NULL,		NULL,
	NULL,		NULL,		NULL,		NULL
};

struct	mne	mne[] = {

	/* machine */

    {	NULL,	"CSEG",		S_ATYP,		0,	A_CSEG|A_2BYTE	},
    {	NULL,	"DSEG",		S_ATYP,		0,	A_DSEG|A_2BYTE	},

/*    {	NULL,	".setdp",	S_SDP,		0,	0	},	*/

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
/*    {	NULL,	".byte",	S_DATA,		0,	O_1BYTE	},	*/
/*    {	NULL,	".db",		S_DATA,		0,	O_1BYTE	},	*/
/*    {	NULL,	".fcb",		S_DATA,		0,	O_1BYTE	},	*/
/*    {	NULL,	".word",	S_DATA,		0,	O_2BYTE	},	*/
/*    {	NULL,	".dw",		S_DATA,		0,	O_2BYTE	},	*/
/*    {	NULL,	".fdb",		S_DATA,		0,	O_2BYTE	},	*/
/*    {	NULL,	".3byte",	S_DATA,		0,	O_3BYTE	},	*/
/*    {	NULL,	".triple",	S_DATA,		0,	O_3BYTE	},	*/
/*    {	NULL,	".4byte",	S_DATA,		0,	O_4BYTE	},	*/
/*    {	NULL,	".quad",	S_DATA,		0,	O_4BYTE	},	*/
/*    {	NULL,	".blkb",	S_BLK,		0,	O_1BYTE	},	*/
/*    {	NULL,	".ds",		S_BLK,		0,	O_1BYTE	},	*/
/*    {	NULL,	".rmb",		S_BLK,		0,	O_1BYTE	},	*/
/*    {	NULL,	".rs",		S_BLK,		0,	O_1BYTE	},	*/
/*    {	NULL,	".blkw",	S_BLK,		0,	O_2BYTE	},	*/
/*    {	NULL,	".blk3",	S_BLK,		0,	O_3BYTE	},	*/
/*    {	NULL,	".blk4",	S_BLK,		0,	O_4BYTE	},	*/
/*    {	NULL,	".ascii",	S_ASCIX,	0,	O_ASCII	},	*/
/*    {	NULL,	".ascis",	S_ASCIX,	0,	O_ASCIS	},	*/
/*    {	NULL,	".asciz",	S_ASCIX,	0,	O_ASCIZ	},	*/
/*    {	NULL,	".str",		S_ASCIX,	0,	O_ASCII	},	*/
/*    {	NULL,	".strs",	S_ASCIX,	0,	O_ASCIS	},	*/
/*    {	NULL,	".strz",	S_ASCIX,	0,	O_ASCIZ	},	*/
/*    {	NULL,	".fcc",		S_ASCIX,	0,	O_ASCII	},	*/
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

	/* IM6100 Instructions */

	/* Replacement System Functions */
    {	NULL,	".byte",	S_VAL,		0,	O_1BYTE	},
    {	NULL,	".db",		S_VAL,		0,	O_1BYTE	},
    {	NULL,	".fcb",		S_VAL,		0,	O_1BYTE	},

    {	NULL,	".word",	S_VAL,		0,	O_2BYTE	},
    {	NULL,	".dw",		S_VAL,		0,	O_2BYTE	},
    {	NULL,	".fdb",		S_VAL,		0,	O_2BYTE	},

    {	NULL,	".dubl",	S_VAL,		0,	O_4BYTE	},
    {	NULL,	".4byte",	S_VAL,		0,	O_4BYTE	},
    {	NULL,	".quad",	S_VAL,		0,	O_4BYTE	},

    {	NULL,	".blkb",	S_WRD,		0,	O_2BYTE	},
    {	NULL,	".ds",		S_WRD,		0,	O_2BYTE	},
    {	NULL,	".rmb",		S_WRD,		0,	O_2BYTE	},
    {	NULL,	".rs",		S_WRD,		0,	O_2BYTE	},

    {	NULL,	".blkw",	S_WRD,		0,	O_2BYTE	},

    {	NULL,	".blkd",	S_WRD,		0,	O_4BYTE	},
    {	NULL,	".blk4",	S_WRD,		0,	O_4BYTE	},

    {	NULL,	".ascii",	S_STR,		0,	O_ASCII	},
    {	NULL,	".ascis",	S_STR,		0,	O_ASCIS	},
    {	NULL,	".asciz",	S_STR,		0,	O_ASCIZ	},
    {	NULL,	".str",		S_STR,		0,	O_ASCII	},
    {	NULL,	".strs",	S_STR,		0,	O_ASCIS	},
    {	NULL,	".strz",	S_STR,		0,	O_ASCIZ	},
    {	NULL,	".fcc",		S_STR,		0,	O_ASCII	},

	/* Special System Functions */
    {	NULL,	".mempn",	S_MPN,		0,	0	},
    {	NULL,	".mempa",	S_MPA,		0,	0	},
    {	NULL,	".setpg",	S_SPG,		0,	0	},
    {	NULL,	".text",	S_TXT,		0,	O_ASCII	},
    {	NULL,	".textz",	S_TXT,		0,	O_ASCIZ	},

	/* Memory Reference Instructions */
    {	NULL,	"and",		S_MRI,		0,	00000	},
    {	NULL,	"tad",		S_MRI,		0,	01000	},
    {	NULL,	"isz",		S_MRI,		0,	02000	},
    {	NULL,	"dca",		S_MRI,		0,	03000	},
    {	NULL,	"jms",		S_MRI,		0,	04000	},
    {	NULL,	"jmp",		S_MRI,		0,	05000	},

	/* IOT Instructions */
    {	NULL,	"iot",		S_IOT,		0,	06000	},

    {	NULL,	"skon",		S_INH,		0,	06000	},
    {	NULL,	"ion",		S_INH,		0,	06001	},
    {	NULL,	"iof",		S_INH,		0,	06002	},
    {	NULL,	"srq",		S_INH,		0,	06003	},
    {	NULL,	"gtf",		S_INH,		0,	06004	},
    {	NULL,	"rtf",		S_INH,		0,	06005	},
    {	NULL,	"sgt",		S_INH,		0,	06006	},
    {	NULL,	"caf",		S_INH,		0,	06007	},

	/* Common Operate Instructions */
    {	NULL,	"cla",		S_GOP,		0,	07200	},
    {	NULL,	"nop",		S_INH,		0,	07000	},

	/* Operate Instructions - Group 1 */
	/* 111:0xx:xx-:--x  Part A */ 
    {	NULL,	"cll",		S_GOP,		0,	07100	},
    {	NULL,	"cma",		S_GOP,		0,	07040	},
    {	NULL,	"cml",		S_GOP,		0,	07020	},
    {	NULL,	"iac",		S_GOP,		0,	07001	},
	/* 111:0--:--x:xx-  Part B */ 
    {	NULL,	"rtr",		S_GOP,		0,	07012	},
    {	NULL,	"rar",		S_GOP,		0,	07010	},
    {	NULL,	"rtl",		S_GOP,		0,	07006	},
    {	NULL,	"ral",		S_GOP,		0,	07004	},
    {	NULL,	"bsw",		S_GOP,		0,	07002	},
	/* Common Combinations */
    {	NULL,	"sta",		S_INH,		0,	07240	},
    {	NULL,	"glt",		S_INH,		0,	07204	},
    {	NULL,	"stl",		S_INH,		0,	07120	},
    {	NULL,	"cia",		S_INH,		0,	07041	},

	/* Operate Instructions - Group 2 */
	/* 111:1x-:---:xx0  Part A */ 
    {	NULL,	"osr",		S_GOP,		0,	07404	},
    {	NULL,	"hlt",		S_GOP,		0,	07402	},
	/* 111:1-x:xxx:--0  Part B */
    {	NULL,	"spa",		S_GOP,		0,	07510	},
    {	NULL,	"sma",		S_GOP,		0,	07500	},
    {	NULL,	"sna",		S_GOP,		0,	07450	},
    {	NULL,	"sza",		S_GOP,		0,	07440	},
    {	NULL,	"szl",		S_GOP,		0,	07430	},
    {	NULL,	"snl",		S_GOP,		0,	07420	},
	/* Common Combinations */
    {	NULL,	"las",		S_INH,		0,	07604	},
    {	NULL,	"skp",		S_INH,		0,	07410	},

	/* Operate Instructions - Group 3 */
	/* 111:1xx:-x-:--1  Part A */ 
    {	NULL,	"mqa",		S_GOP,		0,	07501	},
    {	NULL,	"mql",		S_GOP,		0,	07421	},
	/* Common Combinations */
    {	NULL,	"acl",		S_INH,		0,	07701	},
    {	NULL,	"cam",		S_INH,		0,	07621	},
    {	NULL,	"swp",		S_INH,		S_EOL,	07521	}
};
