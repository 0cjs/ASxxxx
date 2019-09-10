/* R78K0MCH.C */

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

char	*cpu	= "Renesas/NEC 78K/0";
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
#define	P2	((char) (OPCY_NONE | 0x02))
#define	P3	((char) (OPCY_NONE | 0x03))

/*
 * 78K0 Cycle Count
 *
 *	opcycles = r78k0pg[opcode]
 */
static char r78k0pg[256] = {
/*--*--* 0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F */
/*--*--* -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - */
/*00*/   2, 2,12,12,10, 6,UN, 6, 9, 9, 6, 6, 5, 4, 5, 5,
/*10*/   6, 7, 6, 7, 6,UN, 6,UN, 9, 9, 6, 6, 5, 4, 5, 5,
/*20*/   2, 2, 2, 2, 2, 2, 2, 2, 9, 9, 6, 6, 5, 4, 5, 5,
/*30*/   2,P1, 2, 2, 2, 2, 2, 2, 9, 9, 6, 6, 5, 4, 5, 5,
/*40*/   2, 2, 2, 2, 2, 2, 2, 2, 9, 9, 6, 6, 5, 4, 5, 5,
/*50*/   2, 2, 2, 2, 2, 2, 2, 2, 9, 9, 6, 6, 5, 4, 5, 5,
/*60*/   2,P2, 2, 2, 2, 2, 2, 2, 9, 9, 6, 6, 5, 4, 5, 5,
/*70*/   2,P3, 2, 2, 2, 2, 2, 2, 9, 9, 6, 6, 5, 4, 5, 5,
/*80*/   4, 6, 4, 6, 4, 5, 4, 5, 8, 8, 6, 6, 9, 6, 9, 6,
/*90*/   4, 6, 4, 6, 4, 5, 4, 5, 8, 8, 7, 6, 9, 6, 9, 6,
/*A0*/   4, 4, 4, 4, 4, 4, 4, 4, 8, 8, 7, 7, 9, 6, 9, 6,
/*B0*/   4, 4, 4, 4, 4, 4, 4, 4, 8, 8, 7, 7, 9, 6, 9, 6,
/*C0*/  UN, 6, 4, 6, 4, 6, 4, 6, 8, 6, 6, 6, 9, 6,10, 6,
/*D0*/  UN, 6, 4, 6, 4, 6, 4, 6, 8, 6, 6, 6, 9, 6,10, 6,
/*E0*/  UN, 6, 4, 6, 4, 6, 4, 6, 8, 6, 6, 6, 9, 6,10, 6,
/*F0*/   5, 6, 5, 6, 5, 6, 5, 6, 8, 6, 6, 6, 9, 6,10, 6
};

static char r78k0pg31[256] = {
/*--*--* 0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F */
/*--*--* -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - */
/*00*/  UN,12,UN,11,UN,12,11,11,UN,UN, 9, 9,UN, 8, 8, 8,
/*10*/  UN,12,UN,11,UN,12,11,11,UN,UN, 9, 9,UN, 8, 8, 8,
/*20*/  UN,12,UN,11,UN,12,11,11,UN,UN, 9, 9,UN, 8, 8, 8,
/*30*/  UN,12,UN,11,UN,12,11,11,UN,UN, 9, 9,UN, 8, 8, 8,
/*40*/  UN,12,UN,11,UN,12,11,11,UN,UN, 9, 9,UN, 8, 8, 8,
/*50*/  UN,12,UN,11,UN,12,11,11,UN,UN, 9, 9,UN, 8, 8, 8,
/*60*/  UN,12,UN,11,UN,12,11,11,UN,UN, 9, 9,UN, 8, 8, 8,
/*70*/  UN,12,UN,11,UN,12,11,11,UN,UN, 9, 9,UN, 8, 8, 8,
/*80*/  12,UN,25,UN,UN,12,11,11,16,UN,10,10,UN,UN,UN,UN,
/*90*/  12,UN,UN,UN,UN,12,11,11, 8,UN,UN,UN,UN,UN,UN,UN,
/*A0*/  UN,UN,UN,UN,UN,12,11,11,UN,UN,UN,UN,UN,UN,UN,UN,
/*B0*/  UN,UN,UN,UN,UN,12,11,11,UN,UN,UN,UN,UN,UN,UN,UN,
/*C0*/  UN,UN,UN,UN,UN,12,11,11,UN,UN,UN,UN,UN,UN,UN,UN,
/*D0*/  UN,UN,UN,UN,UN,12,11,11,UN,UN,UN,UN,UN,UN,UN,UN,
/*E0*/  UN,UN,UN,UN,UN,12,11,11,UN,UN,UN,UN,UN,UN,UN,UN,
/*F0*/  UN,UN,UN,UN,UN,12,11,11,UN,UN,UN,UN,UN,UN,UN,UN
};

static char r78k0pg61[256] = {
/*--*--* 0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F */
/*--*--* -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - */
/*00*/   4, 4, 4, 4, 4, 4, 4, 4, 4,UN, 4, 4, 4, 4, 4, 4,
/*10*/   4, 4, 4, 4, 4, 4, 4, 4, 4,UN, 4, 4, 4, 4, 4, 4,
/*20*/   4, 4, 4, 4, 4, 4, 4, 4, 4,UN, 4, 4, 4, 4, 4, 4,
/*30*/   4, 4, 4, 4, 4, 4, 4, 4, 4,UN, 4, 4, 4, 4, 4, 4,
/*40*/   4, 4, 4, 4, 4, 4, 4, 4, 4,UN, 4, 4, 4, 4, 4, 4,
/*50*/   4, 4, 4, 4, 4, 4, 4, 4, 4,UN, 4, 4, 4, 4, 4, 4,
/*60*/   4, 4, 4, 4, 4, 4, 4, 4, 4,UN, 4, 4, 4, 4, 4, 4,
/*70*/   4, 4, 4, 4, 4, 4, 4, 4, 4,UN, 4, 4, 4, 4, 4, 4,
/*80*/   4,UN,UN,UN,UN,UN,UN,UN,UN, 4, 4, 4, 4, 4, 4, 4,
/*90*/   4,UN,UN,UN,UN,UN,UN,UN,UN, 4, 4, 4, 4, 4, 4, 4,
/*A0*/  UN,UN,UN,UN,UN,UN,UN,UN,UN, 4, 4, 4, 4, 4, 4, 4,
/*B0*/  UN,UN,UN,UN,UN,UN,UN,UN,UN, 4, 4, 4, 4, 4, 4, 4,
/*C0*/  UN,UN,UN,UN,UN,UN,UN,UN,UN, 4, 4, 4, 4, 4, 4, 4,
/*D0*/   4,UN,UN,UN,UN,UN,UN,UN, 4, 4, 4, 4, 4, 4, 4, 4,
/*E0*/  UN,UN,UN,UN,UN,UN,UN,UN,UN, 4, 4, 4, 4, 4, 4, 4,
/*F0*/   4,UN,UN,UN,UN,UN,UN,UN, 4, 4, 4, 4, 4, 4, 4, 4
};

static char r78k0pg71[256] = {
/*--*--* 0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F */
/*--*--* -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - */
/*00*/   6, 8,UN,UN, 7, 7, 7, 7,UN, 8, 8, 8, 7, 7, 7, 7,
/*10*/   6, 8,UN,UN, 7, 7, 7, 7,UN, 8, 8, 8, 7, 7, 7, 7,
/*20*/  UN, 8,UN,UN, 7, 7, 7, 7,UN, 8, 8, 8, 7, 7, 7, 7,
/*30*/  UN, 8,UN,UN, 7, 7, 7, 7,UN, 8, 8, 8, 7, 7, 7, 7,
/*40*/  UN, 8,UN,UN, 7, 7, 7, 7,UN, 8, 8, 8, 7, 7, 7, 7,
/*50*/  UN, 8,UN,UN, 7, 7, 7, 7,UN, 8, 8, 8, 7, 7, 7, 7,
/*60*/  UN, 8,UN,UN, 7, 7, 7, 7,UN, 8, 8, 8, 7, 7, 7, 7,
/*70*/  UN, 8,UN,UN, 7, 7, 7, 7,UN, 8, 8, 8, 7, 7, 7, 7,
/*80*/  UN, 8, 8, 8, 7, 7, 7, 7,UN,UN,UN,UN,UN,UN,UN,UN,
/*90*/  UN, 8, 8, 8, 7, 7, 7, 7,UN,UN,UN,UN,UN,UN,UN,UN,
/*A0*/  UN, 8, 8, 8, 7, 7, 7, 7,UN,UN,UN,UN,UN,UN,UN,UN,
/*B0*/  UN, 8, 8, 8, 7, 7, 7, 7,UN,UN,UN,UN,UN,UN,UN,UN,
/*C0*/  UN, 8, 8, 8, 7, 7, 7, 7,UN,UN,UN,UN,UN,UN,UN,UN,
/*D0*/  UN, 8, 8, 8, 7, 7, 7, 7,UN,UN,UN,UN,UN,UN,UN,UN,
/*E0*/  UN, 8, 8, 8, 7, 7, 7, 7,UN,UN,UN,UN,UN,UN,UN,UN,
/*F0*/  UN, 8, 8, 8, 7, 7, 7, 7,UN,UN,UN,UN,UN,UN,UN,UN
};

static char *Page[4] = {
    r78k0pg, r78k0pg31, r78k0pg61, r78k0pg71
};

a_uint xerr;
int setdp;

/*
 * Process a machine op.
 */
VOID
machine(mp)
struct mne *mp;
{
	int op, rf, c;
	struct area *espa;
	char id[NCPS];
	struct expr e1, e2, e3;
	int t1, x1;
	int t2, x2;
	int t3, x3;
	int cidx, eidx, xidx;
	char *iptr;

	if (setdp == 0) {
		clrexpr(&e1);
		e1.e_addr = 0xFF00;
		outdp(dot.s_area, &e1, 0);
		setdp = 1;
	}

	clrexpr(&e1);
	clrexpr(&e2);
	clrexpr(&e3);
	cidx = eidx = 0;
	op = (int) mp->m_valu;

	switch (rf = mp->m_type) {
	case S_SDP:
		opcycles = OPCY_SDP;
		espa = NULL;
		e1.e_addr = 0xFF00;
		if (more()) {
			expr(&e1, 0);
			if (e1.e_flag == 0 && e1.e_base.e_ap == NULL) {
				if (e1.e_addr & 0xFF) {
					err('b');
				}
			}
			if ((c = getnb()) == ',') {
				getid(id, -1);
				espa = alookup(id);
				if (espa == NULL) {
					err('u');
				}
			} else {
				unget(c);
			}
		}
		if (espa) {
			outdp(espa, &e1, 0);
		} else {
			outdp(dot.s_area, &e1, 0);
		}
		lmode = SLIST;
		break;

	case S_XERR:
		xerr = 0;
		if (more()) {
			xerr = absexpr();
		}
		lmode = SLIST;
		break;

	case S_ACC:
		t1 = addr(&e1, &x1);
		comma(1);
		t2 = addr(&e2, &x2);
		switch(t1) {
		case S_REG8:
			if (t2 == S_REG8) {
				if ((x1 == REG8_A) && (x2 == REG8_A)) {
					outab(RK0PG61);
					outab(op + x1);
				} else
				/* A,R8n */
				if (x1 == REG8_A) {
					outab(RK0PG61);
					outab(op + 0X08+ x2);
				} else
				/* R8n,A */
				if (x2 == REG8_A) {
					outab(RK0PG61);
					outab(op + x1);
				}
			} else
			if (x1 == REG8_A) {
				switch(t2) {
				case S_IMM:	/* A,#Byte */
					outab(op + 0x0D);
					outrb(&e2, 0);
					break;
				case S_SADDR:	/* A,saddr */
					outab(op + 0x0E);
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
						outab(op + 0x09);
						outrb(&e2, 0);
					} else {
						mcherr("HL is the only 16-Bit register allowed");
					}
					break;
				case S_IDX:	/* A,[HL] */
					if (x2 == REG16_HL) {
						outab(op + 0x0F);
					} else {
						mcherr("HL is the only 16-Bit register allowed");
					}
					break;
				case S_IHLR:	/* A,[HL+B]  or  A,[HL+C] */
					switch(x2) {
					case REG8_B:	outab(RK0PG31);   outab(op | 0x0B);	break;
					case REG8_C:	outab(RK0PG31);   outab(op | 0x0A);	break;
					default:
						mcherr("B and C are the only 8-Bit registers allowed");
						break;
					}
					break;
				default:
					aerr();
					break;
				}
			} else {
				mcherr("A is the only 8-Bit register allowed");
			}
			break;
		case S_SADDR:	/* saddr,#Byte */
			if (t2 == S_IMM) {
				outab(op + 0x88);
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
			mcherr("AX is the only 16-Bit register allowed");
		}
		break;

	case S_ACC1:
		if (admode(spcl, &x1) && (x1 == SPCL_CY)) {
			comma(1);
			iptr = ip;
			addrbit(&e1, &x1, &t1, &e2, &x2, &t2, &eidx);
			switch(t1) {
			case S_REG8:	/* A.bit  or  A,#bit */
				if (x1 == REG8_A) {
					outab(RK0PG61);
					outrbm(&e2, R_3BIT, op | 0x88);
				} else {
					mcherr("A is the only 8-Bit register allowed");
				}
				break;
			case S_SPCL:	/* PSW.bit  or  PSW,#bit */
				if (x1 == SPCL_PSW) {
					outab(RK0PG71);
					outrbm(&e2, R_3BIT, op);
					outab(0x1E);
				} else {
					mcherr("PSW is the only special register allowed");
				}
				break;
			case S_SFR:	/* sfr.bit  or  sfr,#bit */
				outab(RK0PG71);
				outrbm(&e2, R_3BIT, op | 0x08);
				outrb(&e1, is_abs(&e1) ? 0 : R_PAGN);
				break;
			case S_SADDR:	/* saddr.bit  or  saddr,#bit */
				outab(RK0PG71);
				outrbm(&e2, R_3BIT, op);
				outrb(&e1, 0);
				break;
			case S_IDX:	/* [HL].bit  or  [HL],#bit */
				if ((t1 == S_IDX) && (x1 == REG16_HL)) {
					outab(RK0PG71);
					outrbm(&e2, R_3BIT, op | 0x80);
				} else {
					mcherr("Only [HL] is allowed");
				}
				break;
			default:
				aerr();
				break;
			}
			if (eidx != 0) {
				ip = iptr + eidx;
			}
		} else {
			aerr();
		}
		break;
		
	case S_ROT:	/* A  or  A,1 */
		t1 = addr(&e1, &x1);
		if ((t1 == S_REG8) && (x1 == REG8_A)) {
			outab(op);
		} else {
			mcherr("A is the only 8-Bit register allowed");
		}
		if (comma(0)) {
			t2 = addr(&e2, &x2);
			if (is_abs(&e2)) {
				if (e2.e_addr != 1) {
					mcherr("A value of 1 is required");
				}
			} else {
				mcherr("A constant value of 1 is required");
			}
		}
		break;

	case S_ROT4:	/* [hl] */
		t1 = addr(&e1, &x1);
		if ((t1 == S_IDX) && (x1 == REG16_HL)) {
			outaw(op);
		} else {
			mcherr("Only [HL] is allowed");
		}
		break;

	case S_DEC:
	case S_INC:
		t1 = addr(&e1, &x1);
		/* R8n */
		if (t1 == S_REG8) {
			outab(op | x1);
		} else
		/* saddr */
		if (t1 == S_SADDR) {
			switch(rf) {
			case S_INC:	outab(0x81);	break;
			case S_DEC:	outab(0x91);	break;
			default:	break;
			}
			outrb(&e1, 0);
		} else {
			aerr();
		}
		break;

	case S_DECW:
	case S_INCW:	/* R16n */
		t1 = addr(&e1, &x1);
		if (t1 == S_REG16) {
			outab(op | (x1 << 1));
		} else {
			mcherr("Only 16-Bit registers are allowed");
		}
		break;

	case S_XCH:
		t1 = addr(&e1, &x1);
		comma(1);
		t2 = addr(&e2, &x2);
		if (t1 == S_REG8) {
			if (t2 == S_REG8) {
				/* A,R8n   R8n != A */
				if (x1 == REG8_A) {
					if (x2 == REG8_A) {
						mcherr("XCH  A,A  is not allowed");
					} else {
						outab(op | x2);
					}
				} else
				/* R8n,A   R8n != A */
				if (x2 == REG8_A) {
					if (x1 == REG8_A) {
						mcherr("XCH  A,A  is not allowed");
					} else {
						outab(op | x1);
					}
				} else {
					aerr();
				}
			} else
			if (x1 == REG8_A) {
				switch(t2) {
				case S_SADDR:	/* A,saddr */
					outab(0x83);
					outrb(&e2, 0);
					break;
				case S_SFR:	/* A,sfr */
					outab(0x93);
					outrb(&e2, is_abs(&e2) ? 0 : R_PAGN);
					break;
				case S_EXT:
				case S_AEXT:	/* !addr16,A */
					outab(0xCE);
					outrw(&e2, 0);
					break;
				case S_IDX:
					/* A,[DE] */
					if (x2 == REG16_DE) {
						outab(0x05);
					} else
					/* A,[HL] */
					if (x2 == REG16_HL) {
						outab(0x07);
					} else {
						mcherr("DE and HL are the only 16-Bit registers allowed");
					}
					break;
				case S_IDXB:	/* A,[HL+Byte]  or  A,[HL,Byte] */
					if (x2 == REG16_HL) {
						outab(0xDE);
						outrb(&e2, 0);
					} else {
						mcherr("HL is the only 16-Bit register allowed");
					}
					break;
				case S_IHLR:	/* A,[HL+B]  or  A,[HL+C] */
					switch(x2) {
					case REG8_B:	outab(RK0PG31);   outab(0x8B);	break;
					case REG8_C:	outab(RK0PG31);   outab(0x8A);	break;
					default:
						mcherr("B and C are the only 8-Bit registers allowed");
						break;
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
				outab(op | (x2 << 1));
			} else
			/* R16n,AX    R16n != AX */
			if ((x1 != REG16_AX) && (x2 == REG16_AX)) {
				outab(op | (x1 << 1));
			} else {
				mcherr("XCHW  AX,AX  is not allowed");
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
				outab(0x60 | x2 );
			} else
			/* R8n,A    R8n != A */
			if ((x1 != REG8_A) && (x2 == REG8_A)) {
				outab(0x70 | x1);
			} else {
				mcherr("MOV  A,A  is not allowed");
			}
		} else
		/* R8n,#Byte */
		if ((t1 == S_REG8) && (t2 == S_IMM)) {
			outab(op | x1);
			outrb(&e2, 0);
		} else
		if ((t1 == S_REG8) && (x1 == REG8_A)) {
			switch(t2) {
			case S_SPCL: /* A,PSW */
				if (x2 == SPCL_PSW) {
					outaw(0x1EF0);
				} else {
					mcherr("PSW is the only special register allowed");
				}
				break;
			case S_SADDR:	/* A,saddr */
				outab(0xF0);
				outrb(&e2, 0);
				break;
			case S_SFR:	/* A,sfr */
				outab(0xF4);
				outrb(&e2, is_abs(&e2) ? 0 : R_PAGN);
				break;
			case S_EXT:	/* A,addr16 */
			case S_AEXT:	/* A,!addr16 */
				outab(0x8E);
				outrw(&e2, 0);
				break;
			case S_IDXB:	/* A,[HL+Byte]  or  A,[HL, Byte] */
				if (x2 == REG16_HL) {
					outab(0xAE);
					outrb(&e2, 0);
				} else {
					mcherr("HL is the only 16-Bit register allowed");
				}
				break;
			case S_IDX:
				/* A,[HL] */
				if (x2 == REG16_HL) {
					outab(0x87);
				} else
				/* A,[DE] */
				if (x2 == REG16_DE) {
					outab(0x85);
				} else {
					mcherr("DE and HL are the only 16-Bit registers allowed");
				}
				break;
			case S_IHLR:	/* A,[HL+B]  or  A,[HL+C] */
				switch(x2) {
				case REG8_B:	outab(0xAB);	break;
				case REG8_C:	outab(0xAA);	break;
				default:
					mcherr("B and C are the only 8-Bit registers allowed");
					break;
				}
				break;
			default:
				aerr();
				break;
			}
		} else
		if ((t2 == S_REG8) && (x2 == REG8_A)) {
			switch(t1) {
			case S_SPCL:	/* PSW,A */
				if (x1 == SPCL_PSW) {
					outaw(0x1EF2);
				} else{
					mcherr("PSW is the only special register allowed");
				}
				break;
			case S_SADDR:	/* saddr,A */
				outab(0xF2);
				outrb(&e1, 0);
				break;
			case S_SFR:	/* sfr,A */
				outab(0xF6);
				outrb(&e1, is_abs(&e1) ? 0 : R_PAGN);
				break;
			case S_EXT:	/* addr16,A */
			case S_AEXT:	/* !addr16,A */
				outab(0x9E);
				outrw(&e1, 0);
				break;
			case S_IDXB:	/* [HL+Byte],A  or  [HL,Byte],A */
				if (x1 == REG16_HL) {
					outab(0xBE);
					outrb(&e1, 0);
				} else {
					mcherr("HL is the only 16-Bit register allowed");
				}
				break;
			case S_IDX:
				/* [HL],A */
				if (x1 == REG16_HL) {
					outab(0x97);
				} else
				/* [DE],A */
				if (x1 == REG16_DE) {
					outab(0x95);
				} else {
					mcherr("DE and HL are the only 16-Bit registers allowed");
				}
				break;
			case S_IHLR:	/* [HL+B],A  or  [HL+C],A */
				switch(x1) {
				case REG8_B:	outab(0xBB);	break;
				case REG8_C:	outab(0xBA);	break;
				default:
					mcherr("B and C are the only 8-Bit registers allowed");
					break;
				}
				break;
			default:
				aerr();
				break;
			}
		} else
		if ((t1 == S_SADDR) && (t2 == S_IMM)) {
			outab(0x11);
			outrb(&e1, 0);
			outrb(&e2, 0);
		} else
		if ((t1 == S_SFR) && (t2 == S_IMM)) {
			outab(0x13);
			outrb(&e1, is_abs(&e1) ? 0 : R_PAGN);
			outrb(&e2, 0);
		} else
		if ((t1 == S_IHLR) && (x2 == REG8_A)) {
			switch(x1) {
			case REG8_B:	outab(op | 0xBB);	break;
			case REG8_C:	outab(op | 0xBA);	break;
			default:	aerr();		break;
			}
			break;
		} else
		if ((t1 == S_SPCL) && (x1 == SPCL_PSW)) {
			switch(t2) {
			case S_REG8:	/* PSW,A */
				if (x2 == REG8_A) {
					outaw(0x1EF2);
				} else{
					mcherr("A is the only 8-Bit register allowed");
				}
				break;
			case S_IMM:	/* PSW,#byte */
				outaw(0x1E11);
				outrb(&e2, 0);
				break;
			default:
				aerr();
				break;
			}
		} else {
			aerr();
		}
		break;

	case S_MOVW:
		t1 = addr(&e1, &x1);
		comma(1);
		t2 = addr(&e2, &x2);
		if ((t1 == S_REG16) && (t2 == S_REG16)) {
			/* AX,R16n    R16n != AX */
			if ((x1 == REG16_AX) && (x2 != REG16_AX)) {
				outab(0xC0 | (x2 << 1));
			} else
			/* R16n,AX    R16n != AX */
			if ((x1 != REG16_AX) && (x2 == REG16_AX)) {
				outab(0xD0 | (x1 << 1));
			} else {
				aerr();
			}
		} else
		if (t2 == S_IMM) {
			switch(t1) {
			case S_SPCL:	/* SP,#Word */
				if (x1 == SPCL_SP) {
					outaw(0x1CEE);
					outrw(&e2, 0);
				} else {
					mcherr("SP is the only special register allowed");
				}
				break;
			case S_REG16:	/* R16n,#Word */
				outab(op + (x1 << 1));
				outrw(&e2, 0);
				break;
			case S_SADDR:	/* saddr,#Word */
				outab(0xEE);
				outrb(&e1, 0);
				outrw(&e2, 0);
				break;
			case S_SFR:	/* sfr,#Word */
				outab(0xFE);
				outrb(&e1, is_abs(&e1) ? 0 : R_PAGN);
				outrw(&e2, 0);
				break;
			default:
				aerr();
				break;
			}
		} else
		if ((t1 == S_REG16) && (x1 == REG16_AX)) {
			switch(t2) {
			case S_SPCL:	/* AX,SP */
				if (x2 == SPCL_SP) {
					outaw(0x1C89);
				} else {
					mcherr("SP is the only special register allowed");
				}
				break;
			case S_SADDR:	/* AX,saddr */
				outab(0x89);
				outrb(&e2, 0);
				break;
			case S_SFR:	/* AX,sfr */
				outab(0xA9);
				outrb(&e2, is_abs(&e2) ? 0 : R_PAGN);
				break;
			case S_EXT:	/* AX,addr16 */
			case S_AEXT:	/* AX,!addr16 */
				outab(0x02);
				outrw(&e2, 0);
				break;
			default:
				aerr();
				break;
			}
		} else
		if ((t2 == S_REG16) && (x2 == REG16_AX)) {
			switch(t1) {
			case S_SPCL:	/* SP,AX */
				if (x1 == SPCL_SP) {
					outaw(0x1C99);
				} else {
					mcherr("SP is the only special register allowed");
				}
				break;
			case S_SADDR:	/* saddr,AX */
				outab(0x99);
				outrb(&e1, 0);
				break;
			case S_SFR:	/* sfr,AX */
				outab(0xB9);
				outrb(&e1, is_abs(&e1) ? 0 : R_PAGN);
				break;
			case S_EXT:	/* addr16,AX */
			case S_AEXT:	/* !addr16,AX */
				outab(0x03);
				outrw(&e1, 0);
				break;
			default:
				aerr();
				break;
			}
		} else {
			aerr();
		}
		break;

	case S_MOV1:
		if (admode(spcl, &x3)) {
			if (x3 == SPCL_CY) {
				comma(1);
				iptr = ip;
				addrbit(&e1, &x1, &t1, &e2, &x2, &t2, &eidx);
				switch(t1) {
				case S_REG8:	/* A.bit  or  A,#bit */
					if (x1 == REG8_A) {
						outab(RK0PG61);
						outrbm(&e2, R_3BIT, op | 0x88);
					} else {
						mcherr("A is the only 8-Bit register allowed");
					}
					break;
				case S_SPCL:	/* PSW.bit  or  PSW,#bit */
					if (x1 == SPCL_PSW) {
						outab(RK0PG71);
						outrbm(&e2, R_3BIT, op);
						outab(0x1E);
					} else {
						mcherr("PSW is the only special register allowed");
					}
					break;
				case S_SFR:	/* sfr.bit  or  sfr,#bit */
					outab(RK0PG71);
					outrbm(&e2, R_3BIT, op | 0x08);
					outrb(&e1, is_abs(&e1) ? 0 : R_PAGN);
					break;
				case S_SADDR:	/* saddr.bit  or  saddr,#bit */
					outab(RK0PG71);
					outrbm(&e2, R_3BIT, op);
					outrb(&e1, 0);
					break;
				case S_IDX:	/* [HL].bit  or  [HL],#bit */
					if ((t1 == S_IDX) && (x1 == REG16_HL)) {
						outab(RK0PG71);
						outrbm(&e2, R_3BIT, op | 0x80);
					} else {
						aerr();
					}
					break;
				default:
					aerr();
					break;
				}
				if (eidx != 0) {
					ip = iptr + eidx;
				}
			} else {
				mcherr("Only special register CY allowed as destination");
			}
		} else {
			iptr = ip;
			t3 = addrext(&e3, &x3, &cidx, &eidx);
			if (cidx != 0) {
				iptr[cidx] = 0;
			}
			ip = iptr;
			addrbit(&e1, &x1, &t1, &e2, &x2, &t2, &xidx);
			if ((t3 == S_SPCL) && (x3 == SPCL_CY)) {
				if (t2 == S_IMM) {
					switch(t1) {
					case S_REG8:	/* A.bit  or  A,#bit */
						if (x1 == REG8_A) {
							outab(RK0PG61);
							outrbm(&e2, R_3BIT, 0x89);
						} else {
							mcherr("A is the only 8-Bit register allowed");
						}
						break;
					case S_SPCL:	/* PSW.bit  or  PSW,#bit */
						if (x1 == SPCL_PSW) {
							outab(RK0PG71);
							outrbm(&e2, R_3BIT, 0x01);
							outab(0x1E);
						} else {
							mcherr("PSW is the only special register allowed");
						}
						break;
					case S_SFR:	/* sfr.bit  or  sfr,#bit */
						outab(RK0PG71);
						outrbm(&e2, R_3BIT, 0x09);
						outrb(&e1, is_abs(&e1) ? 0 : R_PAGN);
						break;
					case S_SADDR:	/* saddr.bit  or  saddr,#bit */
						outab(RK0PG71);
						outrbm(&e2, R_3BIT, 0x01);
						outrb(&e1, 0);
						break;
					case S_IDX:	/* [HL].bit  or  [HL],#bit */
						outab(RK0PG71);
						outrbm(&e2, R_3BIT, 0x81);
						break;
					default:
						aerr();
						break;
					}
				} else {
					mcherr("Only special register CY allowed as source");
				}
			} else {
				aerr();
			}
			if (cidx != 0) {
				iptr[cidx] = ',';
			}
			if (eidx != 0) {
				ip = iptr + eidx;
			}
		}
		break;

	case S_MUL:
		if (admode(reg8, &x1) && (x1 == REG8_X)) {
			outaw(op);
		} else {
			mcherr("X is the only 8-Bit register allowed");
		}
		break;

	case S_DIV:
		if (admode(reg8, &x1) && (x1 == REG8_C)) {
			outaw(op);
		} else {
			mcherr("C is the only 8-Bit register allowed");
		}
		break;

	case S_CLR1:
	case S_SET1:
		if (admode(spcl, &x1)) {
			if (x1 == SPCL_CY) {
				switch(rf) {
				case S_CLR1:
					outab(0x21);
					break;
				case S_SET1:
					outab(0x20);
					break;
				default:
					aerr();
					break;
				}
			} else {
				mcherr("CY is the only special register allowed");
			}
			break;
		}
		iptr = ip;
		addrbit(&e1, &x1, &t1, &e2, &x2, &t2, &eidx);
		if (t2 == S_IMM) {
			switch(t1) {
			case S_REG8:	/* A.bit  or  A,#bit */
				if (x1 == REG8_A) {
					outab(RK0PG61);
					outrbm(&e2, R_3BIT, op | 0x80);
				} else {
					mcherr("A is the only 8-Bit register allowed");
				}
				break;
			case S_SPCL:	/* PSW.bit  or  PSW,#bit */
				if (x1 == SPCL_PSW) {
					outrbm(&e2, R_3BIT, op);
					outab(0x1E);
				} else {
					mcherr("PSW is the only special register allowed");
				}
				break;
			case S_SFR:	/* sfr.bit  or  sfr,#bit */
				outab(RK0PG71);
				outrbm(&e2, R_3BIT, op);
				outrb(&e1, is_abs(&e1) ? 0 : R_PAGN);
				break;
			case S_SADDR:	/* saddr.bit  or  saddr,#bit */
				outrbm(&e2, R_3BIT, op);
				outrb(&e1, 0);
				break;
			case S_IDX:	/* [HL].bit  or  [HL],#bit */
				if ((t1 == S_IDX) && (x1 == REG16_HL)) {
					outab(RK0PG71);
					outrbm(&e2, R_3BIT, (op & 0x03) | 0x80);
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

	case S_NOT1:	/* CY */
		if (admode(spcl, &x1) && (x1 == SPCL_CY)) {
			outab(op);
		} else {
			aerr();
		}
		break;

	case S_BT:	/* ----,addr16  or  ----,!addr16 */
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
		case S_IDX:	/* [HL] */
			if (t2 == S_IMM) {
				switch(t1) {
				case S_REG8:	/* A.bit,addr  or  A,#bit,addr */
					if (x1 == REG8_A) {
						outab(RK0PG31);
						outrbm(&e2, R_3BIT, 0x0E);
						pcrbra(&e3);
					} else {
						mcherr("A is the only 8-Bit register allowed");
					}
					break;
				case S_SPCL:	/* PSW.bit,addr  or  PSW,#bit,addr */
					if (x1 == SPCL_PSW) {
						outrbm(&e2, R_3BIT, 0x8C);
						outab(0x1E);
						pcrbra(&e3);
					} else {
						mcherr("PSW is the only special register allowed");
					}
					break;
				case S_SFR:	/* sfr.bit,addr  or  sfr,#bit,addr */
					outab(RK0PG31);
					outrbm(&e2, R_3BIT, 0x06);
					outrb(&e1, is_abs(&e1) ? 0 : R_PAGN);
					pcrbra(&e3);
					break;
				case S_SADDR:	/* saddr.bit,addr  or  saddr,#bit,addr */
					outrbm(&e2, R_3BIT, 0x8C);
					outrb(&e1, 0);
					pcrbra(&e3);
					break;
				case S_IDX:	/* [HL].bit  or  [HL],#bit */
					outab(RK0PG31);
					outrbm(&e2, R_3BIT, 0x86);
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

	case S_BF:	/* ----,addr16  or  ----,!addr16 */
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
		case S_IDX:	/* [HL] */
			if (t2 == S_IMM) {
				switch(t1) {
				case S_REG8:	/* A.bit,addr  or  A,#bit,addr */
					if (x1 == REG8_A) {
						outab(RK0PG31);
						outrbm(&e2, R_3BIT, 0x0F);
						pcrbra(&e3);
					} else {
						mcherr("A is the only 8-Bit register allowed");
					}
					break;
				case S_SPCL:	/* PSW.bit,addr  or  PSW,#bit,addr */
					if (x1 == SPCL_PSW) {
						outab(RK0PG31);
						outrbm(&e2, R_3BIT, 0x03);
						outab(0x1E);
						pcrbra(&e3);
					} else {
						mcherr("PSW is the only special register allowed");
					}
					break;
				case S_SFR:	/* sfr.bit,addr  or  sfr,#bit,addr */
					outab(RK0PG31);
					outrbm(&e2, R_3BIT, 0x07);
					outrb(&e1, is_abs(&e1) ? 0 : R_PAGN);
					pcrbra(&e3);
					break;
				case S_SADDR:	/* saddr.bit,addr  or  saddr,#bit,addr */
					outab(RK0PG31);
					outrbm(&e2, R_3BIT, 0x03);
					outrb(&e1, 0);
					pcrbra(&e3);
					break;
				case S_IDX:	/* [HL].bit  or  [HL],#bit */
					outab(RK0PG31);
					outrbm(&e2, R_3BIT, 0x87);
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

	case S_BTCLR:	/* ----,addr16  or  ----,!addr16 */
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
		case S_IDX:	/* [HL] */
			if (t2 == S_IMM) {
				switch(t1) {
				case S_REG8:	/* A.bit,addr  or  A,#bit,addr */
					if (x1 == REG8_A) {
						outab(RK0PG31);
						outrbm(&e2, R_3BIT, 0x0D);
						pcrbra(&e3);
					} else {
						mcherr("A is the only 8-Bit register allowed");
					}
					break;
				case S_SPCL:	/* PSW.bit,addr  or  PSW,#bit,addr */
					if (x1 == SPCL_PSW) {
						outab(RK0PG31);
						outrbm(&e2, R_3BIT, 0x01);
						outab(0x1E);
						pcrbra(&e3);
					} else {
						mcherr("PSW is the only special register allowed");
					}
					break;
				case S_SFR:	/* sfr.bit,addr  or  sfr,#bit,addr */
					outab(RK0PG31);
					outrbm(&e2, R_3BIT, 0x05);
					outrb(&e1, is_abs(&e1) ? 0 : R_PAGN);
					pcrbra(&e3);
					break;
				case S_SADDR:	/* saddr.bit,addr  or  saddr,#bit,addr */
					outab(RK0PG31);
					outrbm(&e2, R_3BIT, 0x01);
					outrb(&e1, 0);
					pcrbra(&e3);
					break;
				case S_IDX:	/* [HL].bit  or  [HL],#bit */
					outab(RK0PG31);
					outrbm(&e2, R_3BIT, 0x85);
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
			outab(0x9B);
			outrw(&e1, 0);
			break;
		case S_SFR:	/* sfr */
		case S_SADDR:	/* saddr */
		case S_EXT:	/* addr16 */
			outab(0xFA);
			pcrbra(&e1);
			break;
		case  S_REG16:	/* AX */
			if (x1 == REG16_AX) {
				outaw(op);
			} else {
				mcherr("AX is the only 16-Bit register allowed");
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
				outab(op);
				outrb(&e1, 0);
				pcrbra(&e2);
				break;
			case S_REG8:
				/* C,addr16  or  C,!addr16 */
				if (x1 == REG8_C) {
					outab(0x8A);
					pcrbra(&e2);
				} else
				/* B,addr16  or  B,!addr16 */
				if (x1 == REG8_B) {
					outab(0x8B);
					pcrbra(&e2);
				} else {
					mcherr("B and C are the only 8-Bit registers allowed");
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

	case S_CALLF:	/* addr11  */
		t1 = addr(&e1, &x1);
		switch(t1) {
		case S_SFR:	/* sfr */
		case S_SADDR:	/* saddr */
		case S_EXT:	/* addr16 */
		case S_AEXT:	/* !addr16 */
			if (is_abs(&e1)) {
				if ((e1.e_addr >= 0x0800) && (e1.e_addr <= 0x0FFF)) {
					outaw(op | ((e1.e_addr & 0x0700) >> 4) | ((e1.e_addr & 0x00FF) << 8));
				} else {
					mcherr("Address is outside of CallF Range");
				}
			} else {
				outrwm(&e1, R_11BIT, op);
			}
			break;
		default:
			mcherr("Invalid CALLF argument");
			break;
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
						mcherr("Address is odd or outside of CallT Range");
					}
					outab(op | (e1.e_addr & 0x3E));
				} else {
					outrbm(&e1, R_5BIT, op);
				}
				break;
			default:
				mcherr("Invalid CALLT argument");
			}
			if (getnb() != ']') {
				mcherr("Missing ']'");
			}
		} else {
			mcherr("CALLT [arg] is the required syntax");
		}
		break;

	case S_PSH:
	case S_POP:
		t1 = addr(&e1, &x1);
		/* R16n */
		if (t1 == S_REG16) {
			outab(op + (x1 << 1));
		} else
		/* PSW */
		if ((t1 == S_SPCL) && (x1 == SPCL_PSW)) {
			switch(rf) {
			case S_PSH:	outab(0x22);	break;
			case S_POP:	outab(0x23);	break;
			default:	aerr();		break;
			}
		} else {
			mcherr("Only the 16-Bit registers and PSW are allowed");
		}
		break;

	case S_SEL:	/* RBn */
		if (admode(rb, &x1)) {
			outab(RK0PG61);
			outab(op | ((x1 & 2) << 4) | ((x1 & 1) << 3));
		} else {
			mcherr("RB0, RB1, RB2, or RB3 bank required");
		}
		break;

	case S_INH:
		outab(op);
		break;

	case S_INHW:
		outaw(op);
		break;

	default:
		opcycles = OPCY_ERR;
		err('o');
		break;
	}

	if (opcycles == OPCY_NONE) {
		opcycles = r78k0pg[cb[0] & 0xFF];
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
		if ((v < -128) || (v > 127))
			mcherr("Destination outside of branching range");
		outab(v);
	} else {
		outrb(esp, R_PCR);
	}
	if (esp->e_mode != S_USER)
		rerr();
}

/*
 * Expanded Error Reporting
 */
VOID
mcherr(str)
char *str;
{
	if (xerr == 0) {
		aerr();
	} else {
		err('x');
		if (pass == 2) {
			if (xerr > 1) {
				fprintf(stdout, "?ASxxxx-Error-<x> in line %d of %s\n", getlnm(), afn);
				fprintf(stdout, "              <x> %s\n", str);
			}
			if ((xerr > 2) && (lfp != NULL)) {
				fprintf(lfp, "?ASxxxx-Error-<x> in line %d of %s\n", getlnm(), afn);
				fprintf(lfp, "              <x> %s\n", str);
				if (hfp != NULL) {
					listhlr(HLR_NLST, SLIST, 0);
					listhlr(HLR_NLST, SLIST, 0);
				}
			}
		}
	}
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
 */
VOID
minit()
{
	/*
	 * Byte Order
	 */
	hilo = 0;
	/*
	 * Initialize SFR Page
	 */
	setdp = 0;
	/*
	 * Extended Error Flag
	 */
	xerr = 0;
}

