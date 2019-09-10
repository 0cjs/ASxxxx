/* R78KMCH.C */

/*
 *  Copyright (C) 2014  Alan R. Baldwin
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
#include "r78k0s.h"

char	*cpu	= "Renesas/NEC 78K/OS";
char	*dsft	= "asm";

/*
 * Opcode Cycle Definitions
 */
#define	OPCY_SDP	((char) (0xFF))
#define	OPCY_ERR	((char) (0xFE))

/*	OPCY_NONE	((char) (0x80))	*/
/*	OPCY_MASK	((char) (0x7F))	*/

#define	UN	((char) (OPCY_NONE | 0x00))
#define	P1	((char) (OPCY_NONE | 0x01))

/*
 * 78KOS Cycle Count
 *
 *	opcycles = r78kpg[opcode]
 */
static char r78kpg[256] = {
/*--*--* 0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F */
/*--*--* -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - */
/*00*/   6,UN, 2,UN, 2, 6, 2, 6, 2,UN,P1, 8, 2, 8, 2, 8,
/*10*/   2, 6, 2, 4, 2, 4,UN,UN,UN, 8,UN,UN,UN, 6,UN, 6,
/*20*/   6,UN, 6,UN, 8, 4,UN, 4,UN, 8,UN,UN, 4, 6, 2, 6,
/*30*/   6,UN, 8,UN, 6,UN, 6,UN, 6,UN, 6,UN, 6,UN, 6,UN,
/*40*/   8, 6, 8, 4, 8, 4, 8,UN, 8, 8, 8, 6, 8, 6, 8, 6,
/*50*/   8,UN, 8,UN, 8,UN, 8,UN, 8,UN, 8,UN, 8,UN, 8,UN,
/*60*/   8, 6, 8, 4, 8, 4, 8,UN, 8, 8, 8,UN, 8, 6, 8, 6,
/*70*/   8, 6, 8, 4, 8, 4, 8,UN, 8, 8, 8,UN, 8, 6, 8, 6,
/*80*/   4, 6,UN, 4, 4, 4,UN,UN, 4, 8,UN,UN, 4, 6,UN, 6,
/*90*/   4, 6,UN, 4, 4, 4,UN,UN, 4, 8,UN,UN, 4, 6,UN, 6,
/*A0*/   6, 6, 4, 4, 6, 4, 4,UN, 6, 8, 4,UN, 6, 6, 4, 6,
/*B0*/   6, 6, 6, 4,UN, 4,UN,UN,UN, 8,UN,UN,UN, 6,UN, 6,
/*C0*/   4,UN, 6,UN, 8, 4,UN,UN, 8,UN,UN,UN, 8,UN,UN,UN,
/*D0*/  UN,UN, 6,UN, 4, 4, 6,UN, 4,UN,UN,UN, 4,UN,UN,UN,
/*E0*/  UN,UN, 6,UN, 4, 4, 8, 4, 4, 8,UN, 6, 4, 6,UN, 6,
/*F0*/   6,UN,UN,UN, 6, 6,UN, 6, 6,UN,UN,UN, 6,UN,UN,UN
};

static char r78kpg1[256] = {
/*--*--* 0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F */
/*--*--* -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - */
/*00*/   8, 6, 4, 6,10, 6, 6, 6,10, 6, 6, 6,UN, 6,10, 6,
/*10*/   8, 4, 4, 4,10, 4, 6, 4,10, 4, 6, 4,UN, 4,10, 4,
/*20*/   8, 4, 4, 4,10, 4, 6, 4,10, 4, 6, 4,UN, 4,10, 4,
/*30*/   8,UN, 4,UN,10,UN, 6,UN,10,UN, 6,UN,UN,UN,10,UN,
/*40*/   8, 4, 4, 4,10, 4, 6, 4,10, 4, 6, 4,UN, 4,10, 4,
/*50*/   8,UN, 4,UN,10,UN, 6,UN,10,UN, 6,UN,UN,UN,10,UN,
/*60*/   8, 4, 4, 4,10, 4, 6, 4,10, 4, 6, 4,UN, 4,10, 4,
/*70*/   8, 4, 4, 4,10, 4, 6, 4,10, 4, 6, 4,UN, 4,10, 4,
/*80*/   8, 4, 4, 4,10, 4, 6, 4,10, 4, 6, 4,UN, 4,10, 4,
/*90*/   8, 4, 4, 4,10, 4, 6, 4,10, 4, 6, 4,UN, 4,10, 4,
/*A0*/   8, 4, 4, 4,10, 4, 6, 4,10, 4, 6, 4,UN, 4,10, 4,
/*B0*/   8, 4, 4, 4,10, 4, 6, 4,10, 4, 6, 4,UN, 4,10, 4,
/*C0*/   8, 4, 4, 4,10, 4, 6, 4,10, 4, 6, 4,UN, 4,10, 4,
/*D0*/   8, 4, 4, 4,10, 4, 6, 4,10, 4, 6, 4,UN, 4,10, 4,
/*E0*/   8, 4, 4, 4,10, 4, 6, 4,10, 4, 6, 4,UN, 4,10, 4,
/*F0*/   8, 6, 4, 6,10, 6, 6, 6,10, 6, 6, 6,UN, 6,10, 6
};

static char *Page[2] = {
    r78kpg, r78kpg1
};

/*
 * Process a machine op.
 */
VOID
machine(mp)
struct mne *mp;
{
	int op, rf;
	struct expr e1, e2, e3;
	int t1, x1;
	int t2, x2;
	int t3, x3;
	int cidx, eidx, xidx;
	char *iptr;

	clrexpr(&e1);
	clrexpr(&e2);
	clrexpr(&e3);
	cidx = eidx = 0;
	op = (int) mp->m_valu;

	switch (rf = mp->m_type) {
	case S_ACC:
		t1 = addr(&e1, &x1);
		comma(1);
		t2 = addr(&e2, &x2);
		switch(t1) {
		case S_REG8:
			if (t2 == S_REG8) {
				/* A,R8n */
				if (x1 == REG8_A) {
					outab(RK0SPG1);
					outab(op + (x2 << 1));
				} else
				/* R8n,A */
				if (x2 == REG8_A) {
					outab(RK0SPG1);
					outab(op + (x1 << 1));
				} else {
					aerr();
				}
			} else
			if (x1 == REG8_A) {
				switch(t2) {
				case S_IMM:	/* A,#Byte */
					outab(op + 0x02);
					outrb(&e2, 0);
					break;
				case S_SADDR:	/* A,saddr */
					outab(op + 0x04);
					outrb(&e2, 0);
					break;
				case S_SFR:	/* A,sfr */
				case S_EXT:	/* A,addr16 */
				case S_AEXT:	/* A,!addr16 */
					outab(op + 0x08);
					outrw(&e2, 0);
					break;
				case S_IDXB:	/* A,[HL+Byte]  or  A,[HL,Byte] */
					if (x2 == REG16_HL) {
						outab(op + 0x0C);
						outrb(&e2, 0);
					} else {
						aerr();
					}
					break;
				case S_IDX:	/* A,[HL] */
					if (x2 == REG16_HL) {
						outab(op + 0x0E);
					} else {
						aerr();
					}
					break;
				default:
					aerr();
					break;
				}
			} else {
				aerr();
			}
			break;
		case S_SADDR:	/* saddr,#Byte */
			if (t2 == S_IMM) {
				outab(op);
				outrb(&e1, 0);
				outrb(&e2, 0);
			} else {
				aerr();
			}
			break;
		default:
			aerr();
			break;
		}
		break;

	case S_ACCW:	/* AX,#Word */
		t1 = addr(&e1, &x1);
		comma(1);
		t2 = addr(&e2, &x2);
		if ((t1 == S_REG16) && (x1 == REG16_AX) && (t2 == S_IMM)) {
			outab(op);
			outrw(&e2, 0);
		} else {
			aerr();
		}
		break;

	case S_ROT:	/* A  or  A,1 */
		t1 = addr(&e1, &x1);
		if ((t1 == S_REG8) && (x1 == REG8_A)) {
			outab(op);
		} else {
			aerr();
		}
		if (comma(0)) {
			t2 = addr(&e2, &x2);
			if (is_abs(&e2)) {
				if (e2.e_addr != 1) {
					aerr();
				}
			} else {
				aerr();
			}
		}	
		break;

	case S_DEC:
	case S_INC:
		t1 = addr(&e1, &x1);
		/* R8n */
		if (t1 == S_REG8) {
			outab(RK0SPG1);
			switch(rf) {
			case S_DEC:	outab(0xD1 | (x1 << 1));	break;
			case S_INC:	outab(0xC1 | (x1 << 1));	break;
			default:	break;
			}
		} else
		/* saddr */
		if (t1 == S_SADDR) {
			outab(op);
			outrb(&e1, 0);
		} else {
			aerr();
		}
		break;

	case S_DECW:
	case S_INCW:	/* R16n */
		t1 = addr(&e1, &x1);
		if (t1 == S_REG16) {
			outab(op | (x1 << 2));
		} else {
			aerr();
		}
		break;

	case S_XCH:
		t1 = addr(&e1, &x1);
		comma(1);
		t2 = addr(&e2, &x2);
		if (t1 == S_REG8) {
			if (t2 == S_REG8) {
				/* A,X */
				if ((x1 == REG8_A) && (x2 == REG8_X)) {
					outab(0xC0);
				} else
				/* X,A */
				if ((x1 == REG8_X) && (x2 == REG8_A)) {
					outab(0xC0);
				} else
				/* A,R8n   R8n != A */
				if (x1 == REG8_A) {
					if (x2 == REG8_A) {
						aerr();
					} else {
						outab(RK0SPG1);
						outab(0x01 | (x2 << 1));
					}
				} else
				/* R8n,A   R8n != A */
				if (x2 == REG8_A) {
					if (x1 == REG8_A) {
						aerr();
					} else {
						outab(RK0SPG1);
						outab(0x01 | (x1 << 1));
					}
				} else {
					aerr();
				}
			} else
			if (x1 == REG8_A) {
				switch(t2) {
				case S_SADDR:	/* A,saddr */
					outab(op + 0x05);
					outrb(&e2, 0);
					break;
				case S_EXT:
				case S_SFR:	/* A,sfr */
					outab(op + 0x07);
					outrb(&e2, 0);
					break;
				case S_IDX:
					/* A,[DE] */
					if (x2 == REG16_DE) {
						outab(op + 0x0B);
					} else
					/* A,[HL] */
					if (x2 == REG16_HL) {
						outab(op + 0x0F);
						break;
					} else {
						aerr();
					}
					break;
				case S_IDXB:	/* A,[HL+Byte]  or  A,[HL,Byte] */
					if (x2 == REG16_HL) {
						outab(op + 0x0D);
						outrb(&e2, 0);
					} else {
						aerr();
					}
					break;
				default:
					aerr();
					break;
				}
			}
		} else {
			aerr();
		}
		break;

	case S_XCHW:
		t1 = addr(&e1, &x1);
		comma(1);
		t2 = addr(&e2, &x2);
		if ((t1 == S_REG16) && (t2 == S_REG16)) {
			/* AX,R16n    R16n != AX */
			if ((x1 == REG16_AX) && (x2 != REG16_AX)) {
				outab(op | (x2 << 2));
			} else
			/* R16n,AX    R16n != AX */
			if ((x1 != REG16_AX) && (x2 == REG16_AX)) {
				outab(op | (x1 << 2));
			} else {
				aerr();
			}
		} else {
			aerr();
		}
		break;

	case S_MOV:
		t1 = addr(&e1, &x1);
		comma(1);
		t2 = addr(&e2, &x2);
		if ((t1 == S_REG8) && (t2 == S_REG8)) {
			/* A,R8n    R8n != A */
			if ((x1 == REG8_A) && (x2 != REG8_A)) {
				outab(RK0SPG1);
				outab(0x21 | (x2 << 1));
			} else
			/* R8n,A    R8n != A */
			if ((x1 != REG8_A) && (x2 == REG8_A)) {
				outab(RK0SPG1);
				outab(0xE1 | (x1 << 1));
			} else {
				aerr();
			}
		} else
		/* R8n,#Byte */
		if ((t1 == S_REG8) && (t2 == S_IMM)) {
			outab(RK0SPG1);
			outab(0xF1 | (x1 << 1));
			outrb(&e2, 0);
		} else
		if ((t1 == S_REG8) && (x1 == REG8_A)) {
			switch(t2) {
			case S_SADDR:	/* A,saddr */
				outab(0x25);
				outrb(&e2, 0);
				break;
			case S_SFR:	/* A,sfr */
				outab(0x27);
				outrb(&e2, 0);
				break;
			case S_EXT:	/* A,addr16 */
			case S_AEXT:	/* A,!addr16 */
				outab(0x29);
				outrw(&e2, 0);
				break;
			case S_IDXB:	/* A,[HL+Byte]  or  A,[HL, Byte] */
				if (x2 == REG16_HL) {
					outab(0x2D);
					outrb(&e2, 0);
				} else {
					aerr();
				}
				break;
			case S_IDX:
				/* A,[HL] */
				if (x2 == REG16_HL) {
					outab(0x2F);
				} else
				/* A,[DE] */
				if (x2 == REG16_DE) {
					outab(0x4B);
				} else {
					aerr();
				}
				break;
			default:
				aerr();
				break;
			}
		} else
		if ((t2 == S_REG8) && (x2 == REG8_A)) {
			switch(t1) {
			case S_SADDR:	/* saddr,A */
				outab(0xE5);
				outrb(&e1, 0);
				break;
			case S_SFR:	/* sfr,A */
				outab(0xE7);
				outrb(&e1, 0);
				break;
			case S_EXT:	/* addr16,A */
			case S_AEXT:	/* !addr16,A */
				outab(0xE9);
				outrw(&e1, 0);
				break;
			case S_IDXB:	/* [HL+Byte],A  or  [HL,Byte],A */
				if (x1 == REG16_HL) {
					outab(0xED);
					outrb(&e1, 0);
				} else {
					aerr();
				}
				break;
			case S_IDX:
				/* [HL],A */
				if (x1 == REG16_HL) {
					outab(0xEF);
				} else
				/* [DE],A */
				if (x1 == REG16_DE) {
					outab(0xEB);
				} else {
					aerr();
				}
				break;
			default:
				aerr();
				break;
			}
		} else
		if ((t1 == S_SADDR) && (t2 == S_IMM)) {
			outab(0xF5);
			outrb(&e1, 0);
			outrb(&e2, 0);
		} else
		if ((t1 == S_SFR) && (t2 == S_IMM)) {
			outab(0xF7);
			outrb(&e1, 0);
			outrb(&e2, 0);
		} else {
			aerr();
		}
		break;

	case S_MOVW:
		t1 = addr(&e1, &x1);
		comma(1);
		t2 = addr(&e2, &x2);
		/* R16n,#Word */
		if ((t1 == S_REG16) && (t2 == S_IMM)) {
			outab(0xF0 | (x1 << 2));
			outrw(&e2, 0);
		} else
		/* AX,saddr */
		if ((t1 == S_REG16) && (x1 == REG16_AX) && (t2 == S_SADDR)) {
			outab(0xD6);
			outrb(&e2, 0);
		} else
		/* saddr,AX */
		if ((t1 == S_SADDR) && (t2 == S_REG16) && (x2 == REG16_AX)) {
			outab(0xE6);
			outrb(&e1, 0);
		} else
		if ((t1 == S_REG16) && (t2 == S_REG16)) {
			/* AX,R16n    R16n != AX */
			if ((x1 == REG16_AX) && (x2 != REG16_AX)) {
				outab(0xD0 | (x2 << 2));
			} else
			/* R16n,AX    R16n != AX */
			if ((x1 != REG16_AX) && (x2 == REG16_AX)) {
				outab(0xE0 | (x1 << 2));
			} else {
				aerr();
			}
		} else {
			aerr();
		}
		break;

	case S_CLR:
	case S_SET:
		if (admode(spcl, &x1)) {
			if (x1 == SPCL_CY) {
				switch(rf) {
				case S_CLR:
					outab(0x04);
					break;
				case S_SET:
					outab(0x14);
					break;
				default:
					aerr();
					break;
				}
				break;
			} else {
				aerr();
			}
			break;
		}
		iptr = ip;
		addrbit(&e1, &x1, &t1, &e2, &x2, &t2, &eidx);
		if (t2 == S_IMM) {
			switch(t1) {
			case S_REG8:	/* A.bit  or  A,#bit */
				outab(RK0SPG1);
				outrbm(&e2, R_3BITU, op | 0x02);
				break;
			case S_SPCL:	/* PSW.bit  or  PSW,#bit */
				outab(RK0SPG1);
				outrbm(&e2, R_3BITU, op | 0x0A);
				outab(0x1E);
				break;
			case S_SFR:	/* sfr.bit  or  sfr,#bit */
				outab(RK0SPG1);
				outrbm(&e2, R_3BITU, op | 0x06);
				outrb(&e1, 0);
				break;
			case S_SADDR:	/* saddr.bit  or  saddr,#bit */
				outab(RK0SPG1);
				outrbm(&e2, R_3BITU, op | 0x0A);
				outrb(&e1, 0);
				break;
			case S_IDX:	/* [HL].bit  or  [HL],#bit */
				if ((t1 == S_IDX) && (x1 == REG16_HL)) {
					outab(RK0SPG1);
					outrbm(&e2, R_3BITU, op | 0x0E);
				} else {
					aerr();
				}
				break;
			default:
				aerr();
				break;
			}
		} else {
			aerr();
		}
		if (eidx != 0) {
			ip = iptr + eidx;
		}
		break;

	case S_NOT:	/* CY */
		if (admode(spcl, &x1) && (x1 == SPCL_CY)) {
			outab(op);
		} else {
			aerr();
		}
		break;

	case S_BTF:	/* ----,addr16  or  ----,!addr16 */
		iptr = ip;
		t3 = addrext(&e3, &x3, &cidx, &eidx);
		if (cidx != 0) {
			iptr[cidx] = 0;
		}
		ip = iptr;
		addrbit(&e1, &x1, &t1, &e2, &x2, &t2, &xidx);
		switch(t3) {
		case S_SFR:	/* sfr */
		case S_SADDR:	/* saddr */
		case S_EXT:	/* addr16 */
		case S_AEXT:	/* !addr16 */
			if (t2 == S_IMM) {
				switch(t1) {
				case S_REG8:	/* A.bit,addr  or  A,#bit,addr */
					outab(RK0SPG1);
					outrbm(&e2, R_3BITU, op | 0x00);
					pcrbra(&e3);
					break;
				case S_SPCL:	/* PSW.bit,addr  or  PSW,#bit,addr */
					outab(RK0SPG1);
					outrbm(&e2, R_3BITU, op | 0x08);
					outab(0x1E);
					pcrbra(&e3);
					break;
				case S_SFR:	/* sfr.bit,addr  or  sfr,#bit,addr */
					outab(RK0SPG1);
					outrbm(&e2, R_3BITU, op | 0x04);
					outrb(&e1, 0);
					pcrbra(&e3);
					break;
				case S_SADDR:	/* saddr.bit,addr  or  saddr,#bit,addr */
					outab(RK0SPG1);
					outrbm(&e2, R_3BITU, op | 0x08);
					outrb(&e1, 0);
					pcrbra(&e3);
					break;
				default:
					aerr();
					break;
				}
			} else {
				aerr();
			}
			break;
		default:
			aerr();
			break;
		}
		if (cidx != 0) {
			iptr[cidx] = ',';
		}
		if (eidx != 0) {
			ip = iptr + eidx;
		}
		break;

	case S_BR:
		t1 = addr(&e1, &x1);
		switch(t1) {
		case S_AEXT:	/* !addr16 */
			outab(0xB2);
			outrw(&e1, 0);
			break;
		case S_SFR:	/* sfr */
		case S_SADDR:	/* saddr */
		case S_EXT:	/* addr16 */
			outab(op);
			pcrbra(&e1);
			break;
		case  S_REG16:	/* AX */
			if (x1 == REG16_AX) {
				outab(0xB0);
			} else {
				aerr();
			}
			break;
		default:
			aerr();
			break;
		}
		break;

	case S_BRCZ:	/* addr16  or  !addr16 */
		t1 = addr(&e1, &x1);
		switch(t1) {
		case S_SFR:	/* sfr */
		case S_SADDR:	/* saddr */
		case S_AEXT:	/* !addr16 */
		case S_EXT:	/* addr16 */
			outab(op);
			pcrbra(&e1);
			break;
		default:
			aerr();
			break;
		}
		break;

	case S_DBNZ:
		t1 = addr(&e1, &x1);
		comma(1);
		t2 = addr(&e2, &x2);
		switch(t2) {
		case S_SFR:	/* sfr */
		case S_SADDR:	/* saddr */
		case S_EXT:	/* addr16 */
		case S_AEXT:	/* !addr16 */
			switch(t1) {
			case S_SADDR:	/* saddr,---- */
				outab(op + 0x02);
				outrb(&e1, 0);
				pcrbra(&e2);
				break;
			case S_REG8:
				/* C,addr16  or  C,!addr16 */
				if (x1 == REG8_C) {
					outab(op + 0x04);
					pcrbra(&e2);
				} else
				/* B,addr16  or  B,!addr16 */
				if (x1 == REG8_B) {
					outab(op + 0x06);
					pcrbra(&e2);
				} else {
					aerr();
				}
				break;
			default:
				aerr();
				break;
			}
			break;
		default:
			aerr();
			break;
		}
		break;

	case S_CALL:	/* addr16  or  !addr16 */
		t1 = addr(&e1, &x1);
		if ((t1 == S_AEXT) || (t1 == S_EXT)) {
			outab(op);
			outrw(&e1, 0);
		} else {
			aerr();
		}
		break;

	case S_CALLT:
		if (getnb() == '[') {
			t1 = addr(&e1, &x1);
			switch(t1) {
			case S_SFR:	/* sfr */
			case S_SADDR:	/* saddr */
			case S_EXT:	/* addr16 */
			case S_AEXT:	/* !addr16 */
				if (is_abs(&e1)) {
					if ((0xFF81 & e1.e_addr) || ((0x0040 & e1.e_addr) != 0x0040)) {
						aerr();
					}
					outab(op | (e1.e_addr & 0x3E));
				} else {
					outrbm(&e1, R_5BIT, op);
				}
				break;
			default:
				aerr();
				break;
			}
			if (getnb() != ']') {
				aerr();
			}
		} else {
			aerr();
		}
		break;

	case S_POP:
		t1 = addr(&e1, &x1);
		/* R16n */
		if (t1 == S_REG16) {
			outab(op + (4 * x1));
		} else
		/* PSW */
		if ((t1 == S_SPCL) && (x1 == SPCL_PSW)) {
			if (op == 0xA0) {
				outab(0x2C);
			} else {
				outab(0x2E);
			}
		} else {
			aerr();
		}
		break;

	case S_INH:
		outab(op);
		break;

	case S_INHP:
		outab(RK0SPG1);
		outaw(op);
		break;

	default:
		opcycles = OPCY_ERR;
		err('o');
		break;
	}

	if (opcycles == OPCY_NONE) {
		opcycles = r78kpg[cb[0] & 0xFF];
		if ((opcycles & OPCY_NONE) && (opcycles & OPCY_MASK)) {
			opcycles = Page[opcycles & OPCY_MASK][cb[1] & 0xFF];
		}
	}
}

VOID
pcrbra(esp)
struct expr *esp;
{
	int v;

	if (mchpcr(esp)) {
		v = (int) (esp->e_addr - dot.s_addr - 1);
		if ((v < -128) || (v> 127))
			aerr();
		outab(v);
	} else {
		outrb(esp, R_PCR);
	}
	if (esp->e_mode != S_USER)
		rerr();
}

/*
 * Branch/Jump PCR Mode Check
 */
int
mchpcr(esp)
struct expr *esp;
{
	if (esp->e_base.e_ap == dot.s_area) {
		return(1);
	}
	if (esp->e_flag==0 && esp->e_base.e_ap==NULL) {
		/*
		 * Absolute Destination
		 *
		 * Use the global symbol '.__.ABS.'
		 * of value zero and force the assembler
		 * to use this absolute constant as the
		 * base value for the relocation.
		 */
		esp->e_flag = 1;
		esp->e_base.e_sp = &sym[1];
	}
	return(0);
}

/*
 * Machine specific initialization.
 * Set up the bit table.
 */
VOID
minit()
{
	/*
	 * Byte Order
	 */
	hilo = 0;
}

