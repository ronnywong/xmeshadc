/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RF230RadioC.nc,v 1.1.2.2 2007/04/27 05:02:13 njain Exp $
 */

 
#ifdef USE_LOW_POWER
#define RADIOMODULE SlottedSendC as RadioM
#else 
#define RADIOMODULE RF230RadioM as RadioM
#endif

configuration RF230RadioC
{
	provides {
		interface StdControl;
		
		//timing
// 		interface RadioCoordinator as sendCoordinator;
// 		interface RadioCoordinator as recvCoordinator;
		
		//sending tinyos packets
		interface BareSendMsg as Send;
		
		//receiving tinyos packets
		interface ReceiveMsg as Receive;
		
		interface RadioPower;
		
	}	
}

implementation 
{
	components 
		RADIOMODULE,
		RF230RadioRawM,
		RF230ControlM,
		RF230InterruptsM,
		
		HPLRadioCaptureC,
		HPLRF230C,
				
		TimerC,
		TimerJiffyAsyncC,
		HPLPowerManagementM,
		RandomLFSR,
		LedsC,
		NoLeds;
		
/* === Provided Interfaces ================================================= */

	StdControl = RadioM;
	Send = RadioM;
	Receive = RadioM;
	RadioPower = RadioM;

/* === RF230RadioM ========================================================= */

	RadioM.RadioSplitControl -> RF230RadioRawM.RadioSplitControl;
	RadioM.PHYSend -> RF230RadioRawM.Send;
	RadioM.PHYRecv -> RF230RadioRawM.Receive;
	RadioM.WakeSequence -> RF230RadioRawM.WakeSequence;
	RadioM.MacBackoff -> RF230RadioRawM.MacBackoff;
	RadioM.Random -> RandomLFSR.Random;
	
	RadioM.TimerControl -> TimerC.StdControl;
	RadioM.IntervalTimer -> TimerC.Timer[unique("Timer")];
	RadioM.SleepTimer -> TimerC.Timer[unique("Timer")];
	RadioM.Leds -> LedsC.Leds;
	
/* === RF230RadioRawM ====================================================== */
		
	RF230RadioRawM.RF230ControlSplitControl -> RF230ControlM.SplitControl;
	RF230RadioRawM.RF230Control -> RF230ControlM.RF230Control;
	
	RF230RadioRawM.HPLRF230 -> HPLRF230C.HPLRF230;
	
	RF230RadioRawM.RF230Interrupts -> RF230InterruptsM.RF230Interrupts;
	
	RF230RadioRawM.TimerJiffyAsync -> TimerJiffyAsyncC.TimerJiffyAsync;
	RF230RadioRawM.Random -> RandomLFSR.Random;
	RF230RadioRawM.Leds -> LedsC.Leds;

/* === RF230ControlM ======================================================= */

	RF230ControlM.HPLRF230Init -> HPLRF230C.HPLRF230Init;
	RF230ControlM.HPLRF230 -> HPLRF230C.HPLRF230;
		
	RF230ControlM.TimerControl -> TimerC.StdControl;
	RF230ControlM.initTimer -> TimerC.Timer[unique("Timer")];
		
	RF230ControlM.InterruptControl -> RF230InterruptsM.InterruptControl;
		
	//RF230ControlM.PowerManagement -> HPLPowerManagementM;
		
	RF230ControlM.Leds -> LedsC.Leds;;
	
/* === RF230InterruptsM ==================================================== */

	RF230InterruptsM.HPLRF230 -> HPLRF230C.HPLRF230;
	RF230InterruptsM.TimerCapture -> HPLRadioCaptureC.TimerCapture;
	RF230InterruptsM.PowerManagement -> HPLPowerManagementM;
}
