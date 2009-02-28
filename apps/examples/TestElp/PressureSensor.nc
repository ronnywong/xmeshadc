/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PressureSensor.nc,v 1.1.4.2 2007/04/26 19:34:04 njain Exp $
 */
 
/* 
 * Author: Xin Yang (xyang@xbow.com)
 * Date:   11/05/05
 */
 
/**
 * PressureSensor.nc - Main config file for pressure sensor app
 *
 * @author Xin Yang
 * @date November 13 2005
 */
 
 includes SensorMsgs;
 
#define NO_LEDS 
 
 configuration PressureSensor { }
 
 implementation {
	 
/*=== Components ============================================================*/

	components Main,
				//GenericComm,
				MULTIHOPROUTER,
				TimerC,
				LedsC, NoLeds,
				HPLPowerManagementM,
				PressureSensorM
			;
				
/*=== Main -> PressureSensorM ================================================*/

	Main.StdControl -> PressureSensorM;
	
/*=== PressureSensorM -> COMM ================================================*/
	PressureSensorM.XMeshControl -> MULTIHOPROUTER;
	PressureSensorM.RouteControl -> MULTIHOPROUTER;
	PressureSensorM.COMM -> MULTIHOPROUTER.MhopSend[AM_PRESSURE];
	PressureSensorM.ElpI -> MULTIHOPROUTER.ElpI;
	PressureSensorM.ElpControlI -> MULTIHOPROUTER.ElpControlI;
	
/*=== PressureSensorM -> Power Management ====================================*/

	PressureSensorM.Enable -> HPLPowerManagementM.Enable;
	PressureSensorM.Disable -> HPLPowerManagementM.Disable;
	PressureSensorM.PowerManagement -> HPLPowerManagementM;

/*=== PressureSensorM -> Peripherals =========================================*/

	PressureSensorM.TimerControl -> TimerC.StdControl;
	PressureSensorM.UpdateTimer -> TimerC.Timer[unique("Timer")];
	PressureSensorM.WaitTimer ->   TimerC.Timer[unique("Timer")];
    PressureSensorM.HealthTimer -> TimerC.Timer[unique("Timer")];
    //PressureSensorM.ElpRetryTimer -> TimerC.Timer[unique("Timer")];
	#ifdef NO_LEDS
		PressureSensorM.Leds -> NoLeds;
	#else
		PressureSensorM.Leds -> LedsC;
	#endif
 }
