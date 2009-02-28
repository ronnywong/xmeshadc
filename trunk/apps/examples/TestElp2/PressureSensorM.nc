/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PressureSensorM.nc,v 1.1.4.1 2007/04/26 19:33:36 njain Exp $
 */
 
/* 
 * Author: Xin Yang (xyang@xbow.com)
 * Date:   11/05/05
 */
 
/**
 * PressureSensorM.nc - Main module for pressure sensor app
 *
 *
 * @author Xin Yang
 * @author Alan Broad
 * @date November 13 2005
 */
 
/*===Notice: ================================================================*/
/*
 * ELP Power Strategy: 
 * - On startup:
 *     - no data sent until mote has joined the mesh
 *     - if elp route_discover() returns false, not joined to mesh 
 *
 */
  
/*===LED Debug ==============================================================*/
/*
 * LED Debug
 * - Red    - 
 * - Green  -
 * - Yellow - 
 */
 
module PressureSensorM {
	 
  provides interface StdControl;
	
  uses {
	
    //XMesh
    interface StdControl as XMeshControl;
 //   interface MhopSend as COMM;
    interface RouteControl;
    interface ElpI;
    interface ElpControlI;
    		
    //Leds
    interface Leds;
		
    //Power Management
    command result_t Enable();
    command result_t Disable();
    interface PowerManagement;
  }
	 
}
 
 
implementation {
#include "PressureSensor.h"
	 
  /*===Local state and buffer =================================================*/

  uint16_t g_parent = 0xFFFF;                //Xmesh parent
  	
  /*===Tasks ==================================================================*/
 
  task void ElpSleepAgain(){
      call ElpI.sleep(ELP_SLEEP,ELP_HINT,ELP_RETRIES,HEALTH_XMIT); 
  }
  	
  task void route_discover_again(){
     call ElpI.route_discover(NUM_ROUTE_DISCOVER_INTS);    //try to join mesh for n ROUTE_UPDATE INTERVALS  	
  }
  
  /*===StdControl =============================================================*/

  command result_t StdControl.init() {
		
    //init peripherals
	call XMeshControl.init();
	call Leds.init();
	call Enable();					//explicitly enable sleep
		
    return SUCCESS;
  }
	
  command result_t StdControl.start() {
 	call XMeshControl.start();
	call ElpControlI.enable();
	call ElpI.route_discover(NUM_ROUTE_DISCOVER_INTS);    //try to join mesh for n ROUTE_UPDATE INTERVALS		
    return SUCCESS;
  }
	
  command result_t StdControl.stop() {
    call XMeshControl.stop();
    return SUCCESS;		
  }
	

  /**
   * Elp sleep cycle is over.  If FAIL, the mote might not be part of mesh.
   * If mote is part of mesh, this event should not fire unless e2e ack was 
   * dropped.
   */
   event result_t ElpI.sleep_done(result_t success) {
	   if(success == FAIL) {
		   //try to rejoin network
		   call ElpI.route_discover(NUM_ROUTE_DISCOVER_INTS);
	   } else {
		   post ElpSleepAgain();
	   }
   }
   
   
  /**
   * XMesh finished trying to rejoin the network.
   */
   event result_t ElpI.route_discover_done(uint8_t success,uint16_t parent){
     g_parent = parent;
	 if (success == FAIL) {
	    g_parent = TOS_BCAST_ADDR; 
	    post route_discover_again();
     }
	 else post ElpSleepAgain();
   }
	  
    event result_t ElpI.wake_done(result_t success){
   }
 
}
