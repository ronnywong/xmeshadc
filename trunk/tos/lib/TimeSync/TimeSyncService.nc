/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TimeSyncService.nc,v 1.2.4.3 2007/04/27 04:52:36 njain Exp $
 */
 
configuration TimeSyncService {
  
  provides {
    interface StdControl;
    // The interface are as parameterised by the active message id
	// only the 10 active message ids defined MultiHop.h are supported.
    interface Time;
  }

}

implementation {
  
  components 
  		/*GenericComm*/ 
  		GenericCommPromiscuous as Comm, 
  		TimerC, 
  		TimeSyncM, 
  		TimeUtilC,  		
  		
#if defined(TOSH_HARDWARE_MICA2)|| defined(TOSH_HARDWARE_MICA2DOT)|| defined(TOSH_HARDWARE_MICA2B)
	CC1000RadioC, 
#elif defined(TOSH_HARDWARE_MICAZ)||defined(TOSH_HARDWARE_MICAZB)
	CC2420RadioC, 
#endif

  		QueuedSend, 
  		LedsC;

  StdControl = TimeSyncM;
  Time = TimeSyncM;

  TimeSyncM.TimerControl -> TimerC;
  TimeSyncM.CommControl -> Comm;
  TimeSyncM.UpdateTimer -> TimerC.Timer[unique("Timer")];  
  TimeSyncM.Timer -> TimerC.Timer[unique("Timer")];  
  TimeSyncM.ReceiveMsg -> Comm.ReceiveMsg[239];
  TimeSyncM.SendMsg -> QueuedSend.SendMsg[239];
  //TimeSyncM.SendMsg -> Comm.SendMsg[239];
  TimeSyncM.TimeUtil -> TimeUtilC;
  
#if defined(TOSH_HARDWARE_MICA2)|| defined(TOSH_HARDWARE_MICA2DOT)|| defined(TOSH_HARDWARE_MICA2B)
	TimeSyncM.RadioCoordinator -> CC1000RadioC.RadioSendCoordinator;	
#elif defined(TOSH_HARDWARE_MICAZ) ||defined(TOSH_HARDWARE_MICAZB)
	TimeSyncM.RadioCoordinator -> CC2420RadioC.RadioSendCoordinator;	
#endif
  
  TimeSyncM.Leds -> LedsC;
  
  //debugging
  //TimeSyncM.Timer128 -> TimerC.Timer[unique("Timer")];  
}
