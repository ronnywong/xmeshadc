// $Id: win32p.h,v 1.1.2.1 2007/01/26 06:24:07 pipeng Exp $

/*
 * $Id: win32p.h,v 1.1.2.1 2007/01/26 06:24:07 pipeng Exp $
 *
 ****************************************************************************
 *
 * uisp - The Micro In-System Programmer for Atmel AVR microcontrollers.
 * Copyright (C) 1999, 2000, 2001, 2002  Uros Platise
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 ****************************************************************************
 */


#include <time.h>

unsigned char inb(unsigned short port);
void outb(unsigned char value, unsigned short port);
int ioperm(unsigned short port, int num, int enable);
//int cfmakeraw(struct termios *termios_p);
bool win32p_delay_usec(long t);
