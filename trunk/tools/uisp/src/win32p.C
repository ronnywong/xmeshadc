// $Id: win32p.C,v 1.1.2.1 2007/01/26 06:24:02 pipeng Exp $

/*
 * $Id: win32p.C,v 1.1.2.1 2007/01/26 06:24:02 pipeng Exp $
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


#if defined(__WIN32__)

#include "config.h"


#include <windows.h>
#include "WinIo.h"
#include "win32p.h"
#include "DAPA.h"

unsigned char inb(unsigned short port)
{
    unsigned char t;
	PDWORD dval=(PDWORD)(&t);
	if(InitializeWinIo()==false) return 0xFF;
	GetPortVal(port,dval,1);
	ShutdownWinIo();
    return t;
}

void outb(unsigned char value, unsigned short port)
{
	if(InitializeWinIo()==false) return;
	SetPortVal(port,value,1);
	ShutdownWinIo();
}

int ioperm(unsigned short port, int num, int enable)
{
    if (enable) {
	// Only try to use directio under Windows NT/2000.
	OSVERSIONINFO ver_info;
	memset(&ver_info, 0, sizeof(ver_info));
	ver_info.dwOSVersionInfoSize = sizeof(ver_info);
	if (! GetVersionEx(&ver_info))
	    return -1;
	else if (ver_info.dwPlatformId == VER_PLATFORM_WIN32_NT) {
	    HANDLE h =
		CreateFile("\\\\.\\giveio",
			   GENERIC_READ,
			   0,
			   NULL,
			   OPEN_EXISTING,
			   FILE_ATTRIBUTE_NORMAL,
			   NULL);
	    if (h == INVALID_HANDLE_VALUE)
		return -1;
	    CloseHandle(h);
	}
    }
    return 0;
}

bool win32p_delay_usec(long t)
{
    static bool perf_counter_checked = false;
    static bool use_perf_counter = false;
    static LARGE_INTEGER freq;

    if (! perf_counter_checked) {
	if (QueryPerformanceFrequency(&freq))
	    use_perf_counter = true;
	perf_counter_checked = true;
    }

    if (! use_perf_counter)
	return false;
    else {
	LARGE_INTEGER now;
	LARGE_INTEGER finish;
	QueryPerformanceCounter(&now);
	finish.QuadPart = now.QuadPart + (t * freq.QuadPart) / 1000000;
	do {
	    QueryPerformanceCounter(&now);
	} while (now.QuadPart < finish.QuadPart);
	return true;
    }
}




#endif
