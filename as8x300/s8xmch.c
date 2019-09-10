/* s8xmch.c */

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
#include "s8x.h"

char	*cpu	= "Signetics 8x300";
char	*dsft	= "asm";

/*
 * Opcode Cycle Definitions
 */
#define	OPCY_CPU	((char) (0xFF))
#define	OPCY_DEF	((char) (0xFE))
#define	OPCY_ERR	((char) (0xFD))

/*	OPCY_NONE	((char) (0x80))	*/
/*	OPCY_MASK	((char) (0x7F))	*/

a_uint xerr;

struct	xdef	xfield[16];
int d_xtnd;
int d_xdef;

struct area *xtndap;

a_uint	codedot;
a_uint	calldot;

struct area *eap;
struct area *cap;
a_uint cdot;

/*
 * Process machine ops.
 */
VOID
machine(mp)
struct mne *mp;
{
	unsigned int op;
	struct expr e1,n1,x1;
	int m1, v1;
	struct expr e2,n2,x2;
	int m2, v2;
	struct expr e3,n3,x3;
	int m3, v3;
	int code;

	int argcnt;

	char id[NCPS];
	int c;
	char *ips;
	struct sym *sp,*vp;

	clrexpr(&e1);	clrexpr(&n1);	clrexpr(&x1);
	m1 = v1 = 0;
	clrexpr(&e2);	clrexpr(&n2);	clrexpr(&x2);
	m2 = v2 = 0;
	clrexpr(&e3);	clrexpr(&n3);	clrexpr(&x3);
	m3 = v3 = 0;
	code = 0;

	cap  = dot.s_area;
	cdot = dot.s_addr;

	op = (int) mp->m_valu;
	switch (mp->m_type) {

	case S_XERR:
		xerr = 0;
		if (more()) {
			xerr = absexpr();
		}
		lmode = SLIST;
		break;

	case S_CPU:
		sym[2].s_addr = op;
		opcycles = OPCY_CPU;
		lmode = SLIST;
		break;

	case S_MOV:
	case S_ADD:
	case S_AND:
	case S_XOR:
		argcnt = 2;
		m1 = addr(&e1,&n1,&x1);
		v1 = (int) e1.e_addr;
		comma(1);
		m2 = addr(&e2,&n2,&x2);
		v2 = (int) e2.e_addr;
		if (comma(0)) {
			argcnt = 3;
			m3 = addr(&e3,&n3,&x3);
			v3 = (int) e3.e_addr;
		}
		/* Rs,len,Rd */
		if ((((m1 & (A_EXT | A_REG)) && ((v1 & ~0x1F) == 0)) || (m1 & (A_LIV | A_RIV))) && (n1.e_mode == 0) &&
		      (m2 & (A_EXT)) &&
		    (((m3 & (A_EXT | A_REG)) && ((v3 & ~0x1F) == 0)) || (m3 & (A_LIV | A_RIV)))) {
			if (m1 & A_LIV) { v1 = 0x17 | ((int) (n1.e_addr >> 3) & 0x07); } else
			if (m1 & A_RIV) { v1 = 0x1F | ((int) (n1.e_addr >> 3) & 0x07); }
			if (m3 & A_LIV) { v3 = 0x17 | ((int) (n3.e_addr >> 3) & 0x07); } else
			if (m3 & A_RIV) { v3 = 0x1F | ((int) (n3.e_addr >> 3) & 0x07); }
			code = ((v1 & 0x1F) << 8) | (v3 & 0x1F);
			outrwm(&e2, R_LEN, op|code);

			/*
			 * Argument Errors
			 */
			if (regchk(v1,v3)) {
				mcherr("Invalid source or destination register");
			}
			if (v2 > 0x08) {
				mcherr("Invalid len value");
			}

			/*
			 * Other Errors
			 */
			if (n1.e_mode || n2.e_mode || n3.e_mode) {
				mcherr("Form symbol(n) not allowed");
			}
			if (x1.e_mode || x2.e_mode) {
				mcherr("Extended data not allowed");
			}
		} else
		/* Rs,Rd or Rs(n),Rd */
		if ((m1 & (A_REG | A_EXT | A_LIV | A_RIV)) &&
		    (m2 & (A_REG | A_EXT | A_LIV | A_RIV)) &&
		    (m3 == 0)) {
			if (m1 & A_LIV) { v1 = 0x10 | ((v1 >> 3) & 0x07); } else
			if (m1 & A_RIV) { v1 = 0x18 | ((v1 >> 3) & 0x07); }
			if (m1 & (A_LIV | A_RIV)) { code |= (int) (e1.e_addr & 0x07) << 5; }
			if (m2 & A_LIV) { v2 = 0x10 | ((v2 >> 3) & 0x07); } else
			if (m2 & A_RIV) { v2 = 0x18 | ((v2 >> 3) & 0x07); }
			if (m2 & (A_LIV | A_RIV)) { code |= (int) (e2.e_addr & 0x07) << 5; }
			switch(n1.e_mode) {
			case A_REG:
			case A_EXT:	code = (int) ((n1.e_addr & 0x07) << 5);	break;
			case A_LIV:
			case A_RIV:	code = (int) (((n1.e_addr >> 6) & 0x07) << 5);	break;
			default:	break;
			}
			code |= ((v1 & 0x01F) << 8) | (v2 & 0x01F);
			outaw(op|code);

			/*
			 * Instruction Errors
			 */
			if ((m1 & (A_LIV | A_RIV)) && (m2 & (A_LIV | A_RIV))) {
				if ((v1 & 0x18) != (v2 & 0x18)) {
					switch(n1.e_mode) {
					case A_REG:
					case A_EXT:
						if ((n1.e_addr & 0x07) != 0) {
							mcherr("I/O transfers between different banks requires len = 8");
						}
						break;
					case A_LIV:
					case A_RIV:
						if (((n1.e_addr >> 6) & 0x07) != 0) {
							mcherr("I/O transfers between different banks requires len = 8");
						}
						break;
					default:
						if (((e1.e_addr & 0x07) != 0) || ((e2.e_addr & 0x07) != 0)) {
							mcherr("I/O transfers between different banks requires len = 8");
						}
						break;
					}
				}
				if (v1 == v2) {
					if ((e1.e_addr & 0x07) != (e2.e_addr & 0x07)) {
						mcherr("I/O Transfers with the same address requires identical lengths");
					}
				}
			}
			if (regchk(v1,v2)) {
				mcherr("Invalid source or destination register");
			}
			if ((n1.e_mode & (A_REG | A_EXT)) && (n1.e_addr > 0x08)) {
				mcherr("Invalid (n) value");
			}

			/*
			 * Other Errors
			 */
			if (x1.e_mode || (n1.e_mode & A_REG)) {
				mcherr("Rs(Rn) or Rs[...] or Rs(n)[...] not allowed");
			}
			if (n2.e_mode) {
				mcherr("Form Rs,Rd(n) not allowed");
			}
		} else {
			outaw(op | code);
			aerr();
		}
		if (argcnt == 2) { xtndout(&x2); } else { xtndout(&x3); }
		break;

	case S_XEC:
		argcnt = 1;
		m1 = addr(&e1,&n1,&x1);
		v1 = (int) e1.e_addr;
		if (comma(0)) {
			argcnt = 2;
			m2 = addr(&e2,&n2,&x2);
			v2 = (int) e2.e_addr;
		}
		/* exp8(Rx) */
		/* Rx is Reg/Number */
		if ((m1 & (A_EXT | A_REG | A_LIV | A_RIV)) &&
		   ((n1.e_mode & A_REG) || ((n1.e_mode & A_EXT) && (n1.e_addr <= 0x1F) && (regchk((int) n1.e_addr,0) == 0)))) {
			code = (int) (n1.e_addr & 0x1F) << 8;
			if (m2) {
				if (((e1.e_addr + e2.e_addr - 1) & ~0xFF) != (dot.s_addr & ~0xFF)) {
					mcherr("Not enough space in page");
				}
			}
			if (m1 & (A_LIV | A_RIV)) {
				outrwm(&e1, R_VO8, op|code);
				if ((e1.e_addr & ~0x00FF) >> 6) {
					mcherr("8 Bit Address paging error");
				}
			} else {
				outrwm(&e1, R_LO8, op|code);
				if ((e1.e_addr & ~0x00FF) != (dot.s_addr & ~0x00FF)) {
					mcherr("8 Bit Address paging error");
				}
			}
		} else
		/* exp5(df) */
		/* exp5(df,n) */
		if ((m1 & (A_EXT | A_REG | A_LIV | A_RIV)) &&
		    (n1.e_mode & (A_EXT | A_LIV | A_RIV))) {
			switch(n1.e_mode) {
			case A_EXT:	code = (int) (n1.e_addr & 0xFF) << 5;	break;
			case A_LIV:	code = (int) (0x80 | (n1.e_addr & 0x3F)) << 5;	break;
			case A_RIV:	code = (int) (0xC0 | (n1.e_addr & 0x3F)) << 5;	break;
			default:	break;
			}
			if (m2) {
				if (((e1.e_addr + e2.e_addr - 1) & ~0x1F) != (dot.s_addr & ~0x1F)) {
					mcherr("Not enough space in page");
				}
			}
			if (m1 & (A_LIV | A_RIV)) {
				outrwm(&e1, R_VO5, op|code);
				if ((e1.e_addr >> 6) & ~0x001F) {
					mcherr("5 Bit Address paging error");
				}
			} else {
				outrwm(&e1, R_LO5, op|code);
				if ((e1.e_addr & ~0x001F) != (dot.s_addr & ~0x001F)) {
					mcherr("5 Bit Address paging error");
				}
			}
		} else {
			outaw(op);
			aerr();
		}
		if (argcnt == 1) { xtndout(&x1); } else { xtndout(&x2); }
		break;

	case S_XMT:
		argcnt = 2;
		m1 = addr(&e1,&n1,&x1);
		v1 = (int) e1.e_addr;
		comma(1);
		m2 = addr(&e2,&n2,&x2);
		v2 = (int) e2.e_addr;
		if (comma(0)) {
			argcnt = 3;
			m3 = addr(&e3,&n3,&x3);
			v3 = (int) e3.e_addr;
		}
		/* exp8,reg  reg = R or n */
		if ((m1 & (A_EXT | A_REG | A_LIV | A_RIV)) &&
		    (m2 & (A_EXT | A_REG)) &&
		    (m3 == 0)) {
		    	abscheck(&e2);
		    	code = (v2 & 0x1F) << 8;
		   	if (m1 & (A_LIV | A_RIV)) {
				outrwm(&e1, R_VO8, op|code);
			} else {
				if ((v1 > 0xFF) || (v1 < -0x80)) {
					mcherr("Out Of Range Integer Value");
				}
				outrwm(&e1, R_LO8, op|code);
			}
			if (regchk(0,v2)) {
				mcherr("Invalid register");
			}
		} else
		/* exp5,df,len */
		if ((m1 & (A_EXT | A_REG  | A_LIV | A_RIV)) &&
		    (m2 & (A_EXT | A_LIV | A_RIV)) &&
		    (m3 & (A_EXT | A_LIV | A_RIV))) {
			/* df */
			abscheck(&e2);
			/* A_EXT | A_LIV | A_RIV */
			switch(m2) {
			case A_EXT:	code = (v2 & 0x1F) << 8;	break;
			case A_LIV:	code = 0x1700;	break;
			case A_RIV:	code = 0x1F00;	break;
			default:	break;
			}
			/* len */
			abscheck(&e3);
			code |= ((v3 & 0x07) << 5);
		   	if (m1 & (A_LIV | A_RIV)) {
				outrwm(&e1, R_VO5, op|code);
			} else {
				if ((v1 > 0x1F) || (v1 < -0x10)) {
					mcherr("Out Of Range Integer Value");
				}
				outrwm(&e1, R_LO5, op|code);
			}
		} else
		/* exp5,df */
		if ((m1 & (A_EXT | A_REG | A_LIV | A_RIV)) &&
		    (m2 & (A_EXT | A_LIV | A_RIV)) &&
		    (m3 == 0)) {
		    	/* exp5 */
			code = 0;
			/* df */
			abscheck(&e2);
			/* A_EXT | A_LIV | A_RIV */
			if (m2 & A_LIV) {
				code = 0x1700;
			} else
			if (m2 & A_RIV) {
				code = 0x1F00;
			} else
			if ((v2 == 0x07) | (v2 = 0x0F)) {
				code = v2 << 8;
			   	if (m1 & (A_LIV | A_RIV)) {
					outrwm(&e1, R_VO8, op|code);
				} else {
					if ((v1 > 0xFF) || (v1 < -0x80)) {
						mcherr("Out Of Range Integer Value");
					}
					outrwm(&e1, R_LO8, op|code);
				}
				xtndout(&x2);
				break;
			}
		   	if (m1 & (A_LIV | A_RIV)) {
				outrwm(&e1, R_VO5, op|code);
			} else {
				if ((v1 > 0x1F) || (v1 < -0x10)) {
					mcherr("Out Of Range Integer Value");
				}
				outrwm(&e1, R_LO5, op|code);
			}
		} else {
			outaw(op);
			aerr();
		}
		if (argcnt == 2) { xtndout(&x2); } else { xtndout(&x3); }
		break;

	case S_NZT:
		argcnt = 2;
		m1 = addr(&e1,&n1,&x1);
		v1 = (int) e1.e_addr;
		comma(1);
		m2 = addr(&e2,&n2,&x2);
		v2 = (int) e2.e_addr;
		if (comma(0)) {
			argcnt = 3;
			m3 = addr(&e3,&n3,&x3);
			v3 = (int) e3.e_addr;
		}
		/* reg,exp8  reg = R or n */
		if ((m1 & (A_EXT | A_REG)) && (regchk(v1,0) == 0) && (v1 != 0x07) && (v1 != 0x0F) &&
		    (m2 & (A_EXT | A_REG | A_LIV | A_RIV)) &&
		    (m3 == 0)) {
		    	abscheck(&e1);
		    	code = v1 << 8;
		   	if (m2 & (A_LIV | A_RIV)) {
				outrwm(&e2, R_VO8, op|code);
				if ((e2.e_addr >> 6) & ~0x00FF) {
					mcherr("8 Bit Address paging error");
				}
			} else {
				outrwm(&e2, R_LO8, op|code);
				if ((e2.e_addr & ~0x00FF) != (dot.s_addr & ~0x00FF)) {
					mcherr("8 Bit Address paging error");
				}
			}
		} else
		/* df,len,exp5 */
		if ((m1 & (A_EXT | A_LIV | A_RIV)) &&
		    (m2 & (A_EXT | A_LIV | A_RIV)) &&
		    (m3 & (A_EXT | A_REG | A_LIV | A_RIV))) {
			/* df */
			abscheck(&e1);
			/* A_EXT | A_LIV | A_RIV */
			switch(m1) {
			case A_EXT:	code = (v1 & 0x1F) << 8;	break;
			case A_LIV:	code = 0x1700;	break;
			case A_RIV:	code = 0x1F00;	break;
			default:	break;
			}
			/* len */
			abscheck(&e2);
			switch(m2) {
			case A_EXT:	code |= ((v2 & 0x07) << 5);
					if (v2 > 8) {
						mcherr("Bits more than 8");
					}
					break;
			case A_LIV:
			case A_RIV:	code |= (((v2 >> 6) & 0x07) << 5);	break;
			default:	break;
			}
		    	/* exp5 */
		   	if (m3 & (A_LIV | A_RIV)) {
				outrwm(&e3, R_VO5, op|code);
				if ((e3.e_addr >> 6) & ~0x001F) {
					mcherr("5 Bit Address paging error");
				}
			} else {
				outrwm(&e3, R_LO5, op|code);
				if ((e3.e_addr & ~0x001F) != (dot.s_addr & ~0x001F)) {
					mcherr("5 Bit Address paging error");
				}
			}
		} else
		/* df,exp5  df = A_LIV/A_RIV (len=0) */
		if ((m1 & (A_EXT | A_LIV | A_RIV)) &&
		    (m2 & (A_EXT | A_REG | A_LIV | A_RIV)) &&
		    (m3 == 0)) {
			/* df */
			abscheck(&e1);
			/* A_EXT | A_LIV | A_RIV */
			switch(m1) {
			case A_EXT:	code = (v1 & 0x1F) << 8;	break;
			case A_LIV:	code = 0x1700;	break;
			case A_RIV:	code = 0x1F00;	break;
			default:	break;
			}
		    	/* exp5 */
		   	if (m2 & (A_LIV | A_RIV)) {
				outrwm(&e2, R_VO5, op|code);
				if ((e2.e_addr >> 6) & ~0x001F) {
					mcherr("5 Bit Address paging error");
				}
			} else {
				outrwm(&e2, R_LO5, op|code);
				if ((e2.e_addr & ~0x001F) != (dot.s_addr & ~0x001F)) {
					mcherr("5 Bit Address paging error");
				}
			}
		} else {
			outaw(op);
			aerr();
		}
		if (argcnt == 2) { xtndout(&x2); } else { xtndout(&x3); }
		break;

	case S_JMP:
		m1 = addr(&e1,&n1,&x1);
		if (m1 == A_EXT) {
			outrwm(&e1, R_JMP, op);
			if (is_abs(&e1)) {
				if (e1.e_addr & ~0x1FFF) {
					mcherr("Jump Address out of range");
				}
			}
			/*
			 * Other Errors
			 */
			if (n1.e_mode) {
				mcherr("Form symbol(n) not allowed");
			}
		} else {
			outaw(op);
			aerr();
		}
		xtndout(&x1);
		break;

	case S_SEL:
		m1 = addr(&e1,&n1,&x1);
		if (m1) {
			if (m1 == A_LIV) {
				code = 0x07 << 8;
			} else
			if (m1 == A_RIV) {
				code =  0x0F << 8;
			} else {
				sprintf(id, "Symbol not of LIV/RIV type");
				mcherr(id);
			}
		} else {
			mcherr("Symbol not of LIV/RIV type");
		}
	   	if (m1 & (A_LIV | A_RIV)) {
			outrwm(&e1, R_VO8, op|code);
		} else {
			outrwm(&e1, R_LO8, op|code);
		}
		xtndout(&x1);
		break;

	case S_NOP:
		xaddr(&x1);
		outaw(op);
		xtndout(&x1);
		break;

	case S_HLT:
		xaddr(&x1);
		sp = lookup(".");
		e1.e_mode = sp->s_type;
		e1.e_addr = sp->s_addr;
		e1.e_base.e_ap = sp->s_area;
		outrwm(&e1, R_JMP, op);
		xtndout(&x1);
		break;

	case S_XML:
	case S_XMR:
		m1 = addr(&e1,&n1,&x1);
		if (sym[2].s_addr == X_305) {
			outrwm(&e1, R_LO8, op);
			if (m1 != A_EXT) {
				aerr();
			}
		} else {
			outaw(op);
			err('o');
		}
		xtndout(&x1);
		break;

	case S_XTND:
		xtndap = NULL;
		if (more()) {
			getid(id,-1);
			xtndap = alookup(id);
			if (xtndap == NULL) {
				err('u');
			}
		}
		lmode = SLIST;
		break;

	case S_LIV:
	case S_RIV:
		getid(id, -1);
		sp = lookup(id);
		sp->s_type = S_USER;
		switch(mp->m_type) {
		default:
		case S_LIV:
			sp->s_flag |=  F_LIV;
			sp->s_flag &= ~F_RIV;
			break;
		case S_RIV:
			sp->s_flag |=  F_RIV;
			sp->s_flag &= ~F_LIV;
			break;
		}
		for (argcnt=0; (argcnt == 0) || comma(0); argcnt++) {
			switch(argcnt) {
			case 0:
				ips = ip;
				c = getnb();
				if (ctype[c] & LETTER) {
					getid(id, c);
					vp = lookup(id);
					if (vp->s_flag & (F_LIV | F_RIV)) {
						v2 = (int) vp->s_addr;
						vp->s_addr = v2 >> 6;
						ip = ips;
						v1 = (int) absexpr();
						vp->s_addr = v2;
						v2 = 0;
						if ((vp->s_flag & (F_LIV | F_RIV)) != (sp->s_flag & (F_LIV | F_RIV))) {
							mcherr("Mixed IVL/IVR symbols");
						}
					} else {
						ip = ips;
						v1 = (int) absexpr();
					}
				} else {
					ip = ips;
					v1 = (int) absexpr();
				}
				break;
			case 1: v2 = (int) absexpr();	break;
			case 2: v3 = (int) absexpr();	break;
			default:		break;
			}
		}
		/* Byte <15:6> */
		sp->s_addr &= 0xFFC0;
		if (argcnt > 0) {
			sp->s_addr |= ((v1 & 0x03FF) << 6);
		}
		/* Bit <5:3> */
		sp->s_addr &= 0xFFC7;
		if (argcnt > 1) {
			sp->s_addr |= ((v2 & 0x07) << 3);
		} else {
			sp->s_addr |= 0x0038;
		}
		/* Len <2:0> */
		sp->s_addr &= 0xFFF8;
		if (argcnt > 2) {
			sp->s_addr |= (v3 & 0x07);
		} else {
			sp->s_addr |= 0x0001;
		}

		/*
		 * Errors
		 */
		if (argcnt == 0) { qerr(); }
		if (v1 > 0xFF) { mcherr("Byte value greater than 255"); }
		if (v2 > 0x07) { mcherr("Bit value greater than 7"); }
		if (v3 > 0x08) { mcherr("Len value greater then 8"); }

		lmode = ELIST;
		eqt_area = NULL;
		laddr = sp->s_addr;
		break;		        

	case S_DEF:
		d_xtnd = 0;
		d_xdef = 0;
		for (argcnt=0; argcnt<16; argcnt++) {
			xfield[argcnt].d_bits = 0;
			xfield[argcnt].d_dval = 0;
			xfield[argcnt].d_skip = 0;
		}
		if (more()) {
			for (argcnt=0; (argcnt == 0) || (comma(0) && (argcnt <= 15)); argcnt++) {
				if (argcnt != 0) {
					clrexpr(&e1);	clrexpr(&n1);	clrexpr(&x1);
					m1 = 0; v1 = 0;
					v2 = 0;
				}
				m1 = addr(&e1,&n1,&x1);
				v1 = (int) e1.e_addr;
				if ((m1 != A_EXT) || (n1.e_mode && (n1.e_mode != A_EXT))) {
					sprintf(id, "Invalid argument in field %d", argcnt+1);
					mcherr(id);
				}
				abscheck(&e1);
				abscheck(&n1);
				xfield[argcnt].d_dval = (int) n1.e_addr;
				if (v1 & s_mask) {
					v1 = -v1;
					xfield[argcnt].d_skip = 1;
				}
				xfield[argcnt].d_bits = (int) v1;
				for (c=0,v2=1; c<v1; c++) {
					v2 *= 2;
				}
				if (((e1.e_addr & s_mask) == 0) && (n1.e_addr & (~v2 + 1))) {
					sprintf(id, "Default value %d exceeds maximum bit range of %d", n1.e_addr, v2-1);
					mcherr(id);
				}
				v2 -= 1;
				v3 += xfield[argcnt].d_bits;
				d_xtnd |= (int) ((n1.e_addr & v2) << (16 - v3));
				d_xdef += 1;
			}
			if (v3 > 16) {
				mcherr("More than 16 bits defined");
			}
		}
		opcycles = OPCY_DEF;
		lmode = ELIST;
		eqt_area = NULL;
		laddr = d_xtnd;
		break;

	default:
		opcycles = OPCY_ERR;
		err('o');
		break;
	}
	if (opcycles == OPCY_NONE) {
		opcycles = 1;
	}
}

int
regchk(src,dst)
int src;
int dst;
{
	if (sym[2].s_addr == X_300) {
		/* SRC - 7/12/13/14/15/16/17 Not Allowed */
		if (src < 0x10) {
			if (src == 0x07) {
				return(1);
			}
			if (src > 0x09) {
				return(1);
			}
		}
		/* DST - 10/12/13/14/15/16 Not Allowed */
		if (dst < 0x10) {
			if (dst == 0x08) {
				return(1);
			}
			if ((dst > 0x09) && (dst < 0x0F)) {
				return(1);
			}
		}
	} else
	if (sym[2].s_addr == X_305) {
		/* SRC - All Allowed */
		/* DST - 10 Not Allowed */
		if (dst < 0x10) {
			if (dst == 0x08) {
				return(1);
			}
		}
	}
	if ((src >= 0x20) || (dst >= 0x20)) {
		return(1);
	}
	return(0);
}

VOID
xtndout(esp)
struct expr *esp;
{
	if ((xtndap != NULL) && (d_xdef != 0)) {
		newdot(xtndap);
		dot.s_addr = cdot;
		if (esp->e_mode & A_XTND) {
			outaw(esp->e_addr);
		} else {
			outaw(d_xtnd);
		}
		newdot(cap);
	}
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
 * Register Symbols
 */

struct	adsym	regsym[] = {
    {	"aux",	0x00	},
    {	 "r0",	0x00	},
    {	"r1",	0x01	},
    {	"r2",	0x02	},
    {	"r3",	0x03	},
    {	"r4",	0x04	},
    {	"r5",	0x05	},
    {	"r6",	0x06	},
    {	"ivl",	0x07	},
    {	 "r7",	0x07	},
    {	"ovf",	0x08	},
    {	 "r10",	0x08	},
    {	"r11",	0x09	},
    {	"r12",	0x0A	},
    {	"r13",	0x0B	},
    {	"r14",	0x0C	},
    {	"r15",	0x0D	},
    {	"r16",	0x0E	},
    {	"ivr",	0x0F	},
    {	 "r17",	0x0F	},
    {	"AUX",	0x00	},
    {	 "R0",	0x00	},
    {	"R1",	0x01	},
    {	"R2",	0x02	},
    {	"R3",	0x03	},
    {	"R4",	0x04	},
    {	"R5",	0x05	},
    {	"R6",	0x06	},
    {	"IVL",	0x07	},
    {	 "R7",	0x07	},
    {	"OVF",	0x08	},
    {	 "R10",	0x08	},
    {	"R11",	0x09	},
    {	"R12",	0x0A	},
    {	"R13",	0x0B	},
    {	"R14",	0x0C	},
    {	"R15",	0x0D	},
    {	"R16",	0x0E	},
    {	"IVR",	0x0F	},
    {	 "R17",	0x0F	},
    {	"",	0000	}
};

/*
 *Machine specific initialization.
 */
VOID
minit()
{
	int i;
	struct sym *sp;
	char id[NCPS];

	/*
	 * Byte Order
	 */
	hilo = 1;
	/*
	 * Extended Error Flag
	 */
	xerr = 0;
	/*
	 * CPU type
	 */
	sym[2].s_addr = X_300;
	/*
	 * Define Register Symbols
	 */
	for (i=0; *regsym[i].a_str; i++) {
		sp = lookup(regsym[i].a_str);
		if (pass == 2) {
			if (sp->s_addr != (a_uint) regsym[i].a_val) {
				sprintf(id, "Register symbol %s value changed to %d  [line number is unknown]", regsym[i].a_str, sp->s_addr);
				mcherr(id);
			}
		}
		sp->s_addr = regsym[i].a_val;
		sp->s_type = S_USER;
	}
	/*
	 * Extended Area
	 */
	xtndap = NULL;
	/*
	 * Extended Field
	 */
	d_xtnd = 0;
	d_xdef = 0;
	for (i=0; i<16; i++) {
		xfield[i].d_bits = 0;
		xfield[i].d_dval = 0;
		xfield[i].d_skip = 0;
	}
}
