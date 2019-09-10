/* i61mch.c */

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

char *cpu  = "Intersil IM6100 / Harris HM6100";
char *dsft = "asm";

/*
 * Opcode Cycle Definitions
 */
#define	OPCY_SDP	((char) (0xFF))
#define	OPCY_ERR	((char) (0xFE))

/*	OPCY_NONE	((char) (0x80))	*/
/*	OPCY_MASK	((char) (0x7F))	*/

#define	OPCY_SKP	((char) (0xFD))

/*
 * Process a machine op.
 */
VOID
machine(mp)
struct mne *mp;
{
	int op, t1;
	struct expr e1, e2;
	char id[NCPS];
	struct mne *gmp;
	int c, cnt, d, nc, opc;

	clrexpr(&e1);
	clrexpr(&e2);
	op = (int) mp->m_valu;
	t1 = 0;
	switch (mp->m_type) {

	/*
	 * Set Page by Number (0 - 31)    or
	 * Set page to Next Page
	 */
	case S_SPG:
		opcycles = OPCY_SDP;
		outall();
		if (more()) {
			expr(&e1, 0);
			if (e1.e_flag == 0 && e1.e_base.e_ap == NULL) {
				if (e1.e_addr & ~0x1F) {
					err('b');
					e1.e_addr = 0;
				}
				e1.e_addr <<= 7;
			} else {
				err('b');
				clrexpr(&e1);
			}
			dot.s_addr = e1.e_addr;
		} else {
			dot.s_addr = (dot.s_addr + 0x7F) & ~0x7F;
			if (dot.s_addr & ~0xFFF) {
				err('b');
				dot.s_addr = 0;
			}
			e1.e_addr = dot.s_addr;
		}
		outdp(dot.s_area, &e1, 0);
		laddr = e1.e_addr;
		lmode = ELIST;
		break;

	/*
	 * Select Page by Number (0 - 31)
	 */
	case S_MPN:
		opcycles = OPCY_SDP;
		expr(&e1, 0);
		if (e1.e_flag == 0 && e1.e_base.e_ap == NULL) {
			if (e1.e_addr & ~0x1F) {
				err('b');
				e1.e_addr = 0;
			}
			e1.e_addr <<= 7;
		} else {
			err('b');
			clrexpr(&e1);
		}
		outdp(dot.s_area, &e1, 0);
		laddr = e1.e_addr;
		lmode = ELIST;
		break;

	/*
	 * Select Page by Address (0x000, 0x080, 0x100, ..., 0xF80)
	 */
	case S_MPA:
		opcycles = OPCY_SDP;
		expr(&e1, 0);
		if (e1.e_flag == 0 && e1.e_base.e_ap == NULL) {
			if (e1.e_addr & ~0x0F80) {
				err('b');
				e1.e_addr &= 0x0F80;
			}
		} else {
			err('b');
			clrexpr(&e1);
		}
		outdp(dot.s_area, &e1, 0);
		laddr = e1.e_addr;
		lmode = ELIST;
		break;

	case S_VAL:
		opcycles = OPCY_SKP;
		do {
			clrexpr(&e1);
			if (mp->m_valu == O_4BYTE) { exprmasks(3); }
			expr(&e1, 0);
			if (mp->m_valu == O_4BYTE) { exprmasks(2); }
			switch(mp->m_valu) {
			case O_1BYTE:	outrwm(&e1, R_8BIT,  0);	break;
			case O_4BYTE:	outrwm(&e1, R_HIWRD, 0);
			case O_2BYTE:	outrwm(&e1, R_LOWRD, 0);	break;
			default:	break;
			}
		} while (comma(0));
		break;

	case S_WRD:
		clrexpr(&e1);
		expr(&e1, 0);
		outchk(HUGE,HUGE);
		cnt = (int) e1.e_addr * mp->m_valu;
		nc = 1 + ((dot.s_area->a_flag) & A_BYTES);
		dot.s_addr += (cnt/nc) + (cnt % nc ? 1 : 0);
		lmode = BLIST;
		break;

	case S_STR:
		opcycles = OPCY_SKP;
		switch(mp->m_valu) {
		case O_ASCII:
		case O_ASCIZ:
			d = getdlm();
			while ((c = getmap(d)) >= 0) {
				outaw(c & 0x7F);
			}
			if (mp->m_valu == O_ASCIZ) {
				outaw(0);
			}
			break;

		case O_ASCIS:
			d = getdlm();
			if ((c = getmap(d)) < 0) {
				outaw(0x80);
			} else {
				while (c >= 0) {
					c &= 0x7F;
					if ((nc = getmap(d)) < 0) {
						c |= 0x80;
					}
					outaw(c);
					c = nc;
				}
			}
			break;
		default:
			break;
		}
		break;

	case S_TXT:
		opcycles = OPCY_SKP;
		d = getdlm();
		cnt = 0;
		nc = 0;
		while ((c = getmap(d)) >= 0) {
			switch(cnt){
			case 0:	nc = mapchr(c) << 6;	break;
			case 1: nc = mapchr(c) | nc;	break;
			default:			break;
			}
			cnt += 1;
			if (cnt == 2) {
				outaw(nc);
				cnt = 0;
				nc = 0;
			}
		}
		if (mp->m_valu == O_ASCIZ) {
			cnt += 1;
		}
		if (cnt != 0) {
			outaw(nc);
		}
		break;

	case S_MRI:
		t1 = addr(&e1);
		if (t1 & S_IND) { op |= 00400; }
		if (t1 & S_ZP) {
			outrwm(&e1, R_7BIT | R_MBRO, op); 
		} else {
			op |= 00200;
			outrwm(&e1, R_7BIT | R_PAGN, op); 
		}
		break;

	case S_IOT:
		expr(&e1, 0);
		if (more()) {
			comma(0);
			expr(&e2, 0);
			abscheck(&e2);
			outrwm(&e1, R_6BIT, op | (e2.e_addr & 0x07));
		} else {
			outrwm(&e1, R_9BIT, op);
		}
		break;

	case S_GOP:
		while(more()) {
			getid(id, -1);
			gmp = mlookup(id);
			if ((gmp != NULL) && (gmp->m_type == S_GOP)) {
				opc = (int) gmp->m_valu;
				/* CLA + Any Group */
				if ((op == 07200) || (opc == 07200)) {
					;
				} else
				/* Group 1 */
				if ((op & 00400) == 0) {
					if ((opc & 00400) == 00400) {
						err('1');
					} else
					if (((op & 00016) != 0) && ((opc & 00016) != 0)){
						if (((op & 00016) == 00002) || ((opc & 00016) == 00002)) {
							err('1');
						} else
						if ((op & 00002) != (opc & 00002)) {
							err('1');
						}
					}
				} else
				/* Group 2 */
				if ((op & 00401) == 00400) {
					if ((opc & 00401) != 00400) {
						err('2');
					} else
					if (((op & 00170) != 0) && ((opc & 00170) != 0)) {
						if ((op & 00010) != (opc & 00010)) {
							err('2');
						}
					}
				} else
				/* Group 3 */
				if ((op & 00401) == 00401) {
					if ((opc & 00401) != 00401) {
						err('3');
					}
				}
				op |= opc;
			} else {
				qerr();
			}
		}
		outaw(op);
		break;

	case S_INH:
		outaw(op);
		break;

	default:
		opcycles = OPCY_ERR;
		err('o');
		break;
	}
	if (opcycles == OPCY_NONE) {
		opc = (op >> 9) & 0x07;
		switch(opc) {
		default: /* 0 - 5 */
			switch(t1) {
			default:
			case S_ADDR:
			case S_ZP:
				switch(opc) {
				default:
			/*AND*/	case 0:	opcycles = 20;	break;
			/*TAD*/	case 1:	opcycles = 20;	break;
			/*ISZ*/	case 2:	opcycles = 32;	break;
			/*DCA*/	case 3:	opcycles = 22;	break;
			/*JMS*/	case 4:	opcycles = 22;	break;
			/*JMP*/	case 5:	opcycles = 20;	break;
				}
				break;
			case S_IND:
			case S_ZPIND:
				switch(opc) {
				default:
			/*AND*/	case 0:	opcycles = 30;	break;
			/*TAD*/	case 1:	opcycles = 32;	break;
			/*ISZ*/	case 2:	opcycles = 42;	break;
			/*DCA*/	case 3:	opcycles = 32;	break;
			/*JMS*/	case 4:	opcycles = 32;	break;
			/*JMP*/	case 5:	opcycles = 30;	break;
				}
				if ((t1 == S_ZPIND) && (e1.e_addr >= 010) && (e1.e_addr <= 017)) {
				   opcycles += 2;
				}
				break;
			}
			break;
		case 6:
			opcycles = 34;
			break;
		case 7:
			opcycles = 20;
			switch(op & 00401) {
			case 00400:
				if (op & 00004) { opcycles += 10; }
				break;
			case 00401:
				break;
			default:
				if (op & 00016) { opcycles += 10; }
				break;
			}
			break;
		}
	}
}

/*
 * Map Standard ASCII Characters to 6-Bits
 */
int
mapchr(c)
int c;
{
	c &= 0x7F;
	/* 'A'(0x01) - '_'(0x1F) */
	if ((c >= 'A') && (c <= '_')) {
		c &= 0x1F;
	} else
	/* 'a'(0x01) - 'z'(0x1A) */
	if ((c >= 'a') && (c <= 'z')) {
		c &= 0x1F;
	} else
	/* ' '(0x20) - '?'(0x3F) */
	if ((c >= ' ') && (c <= '?')) {
		c &= 0x3F;
	} else
	/* Unmapped Characters */
	{
		c = 0x20;
		err('c');
	}
	return(c);
}

/*
 * Machine dependent initialization
 */
VOID
minit()
{
	struct expr e1;

	/*
	 * Byte Order
	 */
	hilo = 1;
	/*
	 * Overide Default Page Length Mask
	 */
	p_mask = 0x7F;
	/*
	 * Notify Linker of Page Length
	 */
	clrexpr(&e1);
	outdp(dot.s_area, &e1, 0);
}

