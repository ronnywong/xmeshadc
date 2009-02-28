/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TOSBase.nc,v 1.1.4.1 2007/04/26 19:37:11 njain Exp $
 */

/* Author:	Phil Buonadonna
 */

/**
 * @author Phil Buonadonna
 */

configuration TOSBase {
}
implementation {
    components Main, TOSBaseM, RadioCRCPacket as Comm, FramerM, UART, HPLUART0M,LedsC
#ifdef FLS_DEBUG
	,TimerC
#endif
	;

  Main.StdControl -> TOSBaseM;
#ifdef FLS_DEBUG
  TOSBaseM.Timer -> TimerC.Timer [unique("Timer")];  
#endif

  TOSBaseM.UARTControl -> FramerM;
  TOSBaseM.UARTSend -> FramerM;
  TOSBaseM.UARTReceive -> FramerM;
  TOSBaseM.UARTTokenReceive -> FramerM;
  TOSBaseM.Setbaud -> HPLUART0M.Setbaud;
  TOSBaseM.RadioControl -> Comm;
  TOSBaseM.RadioSend -> Comm;
  TOSBaseM.RadioReceive -> Comm;

  TOSBaseM.Leds -> LedsC;

  FramerM.ByteControl -> UART;
  FramerM.ByteComm -> UART;
}
