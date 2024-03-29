// $Id: Serial.h,v 1.1.4.1 2007/01/26 06:05:41 pipeng Exp $

/*
 * $Id: Serial.h,v 1.1.4.1 2007/01/26 06:05:41 pipeng Exp $
 *
 ****************************************************************************
 *
 * uisp - The Micro In-System Programmer for Atmel AVR microcontrollers.
 * Copyright (C) 1997, 1998, 1999, 2000, 2001, 2002  Uros Platise
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

/*
	Serial.h  
	RS232 Serial Interface for the standard Atmel Programmer
	Uros Platise(c) copyright 1997-1999
*/

#ifndef __Serial
#define __Serial


#include "stddefine.h"
#if defined(__CYGWIN__)
#include "cygwinp.h"
#endif

#include "Global.h"
#include "Error.h"

class TSerial{
private:
  XPL_SERIAL serline;
  bool remote;
  struct termios saved_modes;
  
protected:
  int Tx(unsigned char* queue, int queue_size);
  int Rx(unsigned char* queue, int queue_size, timeval* timeout);
  void OpenPort();
  void OpenTcp();

public:
  int Send(unsigned char* queue, int queue_size, int rec_queue_size=-1,
	   int timeout = 4);
  void  SendOnly(unsigned char* queue, int queue_size);

  TSerial();
  ~TSerial();
};

#endif
