/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PressureSensor.nc,v 1.1.4.2 2007/04/26 19:33:27 njain Exp $
 */
 
/* 
 * Author: Xin Yang (xyang@xbow.com)
 * Date:   11/05/05
 */
 
/**
 * PressureSensor.nc - Main config file for pressure sensor app
 *
 *
 * @author Xin Yang
 * @date November 13 2005
 */
 
 #define NO_LEDS 
 
 configuration PressureSensor { }
 
 implementation {
	 
/*=== Components ============================================================*/

	components Main,
				//GenericComm,
				MULTIHOPROUTER,
				LedsC, NoLeds,
				HPLPowerManagementM,
				PressureSensorM
			;
				
/*=== Main -> PressureSensorM ================================================*/

	Main.StdControl -> PressureSensorM;
	
/*=== PressureSensorM -> COMM ================================================*/
	PressureSensorM.XMeshControl -> MULTIHOPROUTER;
	PressureSensorM.RouteControl -> MULTIHOPROUTER;
	PressureSensorM.ElpI -> MULTIHOPROUTER.ElpI;
	PressureSensorM.ElpControlI -> MULTIHOPROUTER.ElpControlI;
	
/*=== PressureSensorM -> Power Management ====================================*/

	PressureSensorM.Enable -> HPLPowerManagementM.Enable;
	PressureSensorM.Disable -> HPLPowerManagementM.Disable;
	PressureSensorM.PowerManagement -> HPLPowerManagementM;

/*=== PressureSensorM -> Peripherals =========================================*/
	#ifdef NO_LEDS
		PressureSensorM.Leds -> NoLeds;
	#else
		PressureSensorM.Leds -> LedsC;
	#endif
 }
