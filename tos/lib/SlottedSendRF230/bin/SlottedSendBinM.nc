// $Id: SlottedSendBinM.nc,v 1.1.2.1 2007/02/02 22:02:44 xyang Exp $

/**
 * Copyright (c) 2005-2006 Crossbow Technology, Inc.
 * All rights reserved.
 *
 * Use, copy, modification, reproduction and distribution of
 * this software and documentation are governed by the
 * Crossbow Technology End User License Agreement.
 * To obtain a copy of this Agreement, please contact
 * Crossbow Technology, 4145 N. First St., San Jose, CA 95134.
 */
 
component SlottedSendBinM {
	
	provides {
		interface StdControl;
		
		//LP send/recv
		interface BareSendMsg as Send;
		interface ReceiveMsg as Recv;
		
		//not implemented
		interface RadioPower;
		
	}
	
	uses {
		//Radio stuff
		interface SplitControl as RadioSplitControl;
		interface WakeSequence;
		interface MacBackoff;
		
		//driver send/recv
		interface BareSendMsg as PHYSend;
		interface ReceiveMsg as PHYRecv;
		
		//Timers
		interface StdControl as TimerControl;
		interface Timer as IntervalTimer;
		interface Timer as SleepTimer;
		
		//misc
		interface Random;		
		interface Leds;
	}
	
}
