/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CC2420RadioC.nc,v 1.3.2.1 2007/04/25 23:38:53 njain Exp $
 */
 
/* 
 * Author: Xin Yang (xyang@xbow.com)
 * Date:   11/05/05
 */

 /**
 * CC2420RadioC.nc - CC2420 radio configuration for async LP stack
 *
 * This configuration file overwrites the CC2420RadioC.nc located in
 * /lib/CC2420Radio.  It wiries in the low power mac module on top
 * of the standard CC2420RadioM.nc module.
 *
 * <pre>
 *	$Id: CC2420RadioC.nc,v 1.3.2.1 2007/04/25 23:38:53 njain Exp $
 * </pre>
 * 
 * @author Joe Polastre
 * @author Xin Yang
 * @date November 13 2005
 */
 
#define NO_LEDS_SLOTTEDSENDM
#define NO_LEDS_RADIOM

configuration CC2420RadioC
{
  provides {
    interface StdControl;
    interface BareSendMsg as Send;
    interface ReceiveMsg as Receive;
    interface CC2420Control;
    interface MacControl;
    interface RadioPower;
  }
}
implementation
{
  components CC2420RadioM, CC2420ControlM, HPLCC2420C,
  
  	SlottedSendC,
  	SlottedSendShimM,
  	SlottedSendBuffersM as BuffersM,
  	
    RandomLFSR, 
    TimerC, 
    TimerJiffyAsyncC,
    LedsC, NoLeds, HPLPowerManagementM;

/*===CC2420RadioC -> SlottedSendC =======================================*/
      
  //StdControl
  StdControl = SlottedSendC;
  
  //Receive Shim
  Receive = SlottedSendShimM.LPRecv;
  SlottedSendShimM.LPRecvActual -> SlottedSendC;

  Send = SlottedSendC;  								

/*===CC2420RadioC -> CC2420RadioM =========================================*/

  RadioPower = CC2420RadioM;
  MacControl = CC2420RadioM; //Acks should not be wired to
  
  //  RadioReceiveCoordinator = CC2420RadioM.RadioReceiveCoordinator;
  //  RadioSendCoordinator = CC2420RadioM.RadioSendCoordinator;
 
/*===CC2420RadioC -> CC2420ControlM =======================================*/

  CC2420Control = CC2420ControlM;

/*===SlottedSendM -> CC2420RadioM =========================================*/

  SlottedSendC.RadioControl -> CC2420RadioM;
  SlottedSendC.PHYSend -> CC2420RadioM;
  SlottedSendC.PHYRecv -> CC2420RadioM;
  SlottedSendC.MacBackoff -> CC2420RadioM;
  
  SlottedSendC.checkCCA -> CC2420RadioM.checkCCA; 
  SlottedSendC.setImmediateSendMode -> CC2420RadioM.setImmediateSendMode; 
  SlottedSendC.isImmediateSendMode -> CC2420RadioM.isImmediateSendMode;	
  SlottedSendC.stopCCA -> CC2420RadioM.stopCCA;
  SlottedSendC.checkSFD -> CC2420RadioM.checkSFD;
  SlottedSendC.asyncSend -> CC2420RadioM.asyncSend;
	
/*===SlottedSendM -> other stuff ==========================================*/

  SlottedSendC.SniffTimer ->  TimerC.Timer[unique("Timer")];
  SlottedSendC.SleepTimer ->  TimerC.Timer[unique("Timer")];
  SlottedSendC.SlotBackoffTimer ->  TimerC.Timer[unique("Timer")];
  SlottedSendC.TimerControl -> TimerC.StdControl;
  SlottedSendC.Random -> RandomLFSR;
  
  	#ifdef NO_LEDS_SLOTTEDSENDM
  	SlottedSendC.Leds -> NoLeds;
  	#else
  	SlottedSendC.Leds -> LedsC;
  	#endif
  
  SlottedSendC.MacTimer -> TimerC.Timer[unique("Timer")];
  SlottedSendC.dbgTimer -> TimerC.Timer[unique("Timer")];
  
  SlottedSendC.Buffers -> BuffersM.Buffers;
  
/*===CC2420RadioM -> SlottedSendM =========================================*/
  
  CC2420RadioM.asyncReceive -> SlottedSendC;
  CC2420RadioM.shortReceived -> SlottedSendC.shortReceived;
  
/*===CC2420RadioM -> other stuff ==========================================*/
  
  CC2420RadioM.CC2420StdControl -> CC2420ControlM;
  CC2420RadioM.CC2420Control -> CC2420ControlM;
  CC2420RadioM.Random -> RandomLFSR;
  CC2420RadioM.TimerControl -> TimerC.StdControl;
  CC2420RadioM.BackoffTimerJiffy -> TimerJiffyAsyncC.TimerJiffyAsync;
  //  CC2420RadioM.InitialTimerJiffy -> TimerC.TimerJiffy[unique("TimerJiffy")];
  //  CC2420RadioM.BackoffTimerJiffy -> TimerC.TimerJiffy[unique("TimerJiffy")];
  //  CC2420RadioM.AckTimerJiffy -> TimerC.TimerJiffy[unique("TimerJiffy")];
  //  CC2420RadioM.DelayRXTimerJiffy -> TimerC.TimerJiffy[unique("TimerJiffy")];
  CC2420RadioM.HPLChipcon -> HPLCC2420C.HPLCC2420;
  CC2420RadioM.HPLChipconFIFO -> HPLCC2420C.HPLCC2420FIFO;

  CC2420ControlM.HPLChipconControl -> HPLCC2420C.StdControl;
  CC2420ControlM.HPLChipcon -> HPLCC2420C.HPLCC2420;
  CC2420ControlM.HPLChipconRAM -> HPLCC2420C.HPLCC2420RAM;

  CC2420RadioM.EnableLowPower ->HPLPowerManagementM.Enable;
  
  	#ifdef NO_LEDS_RADIOM
  	CC2420RadioM.Leds -> NoLeds;
  	#else
  	CC2420RadioM.Leds -> LedsC;
  	#endif
}
