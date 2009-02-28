/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMeshBaseM.nc,v 1.3.2.1 2007/04/26 20:24:22 njain Exp $
 */

/**
 * XMeshBase is the gateway firmware for all XMesh suite applications.
 */
 
#include "appFeatures.h"


module XMeshBaseM {
    provides {
	interface StdControl;
    }
    uses {
	interface RouteControl;
	interface XCommand;
	interface Leds;
    }
}

implementation {


  command result_t StdControl.init() {
	  call Leds.init();
	  //this is to make sure that
	  //no matter how the application is loaded (jtag,etc)
	  //the local address of the base station is 0
	  atomic{ TOS_LOCAL_ADDRESS = 0; }
      return SUCCESS;
  }
  command result_t StdControl.start(){
      return SUCCESS;
  }

  command result_t StdControl.stop() {
      return SUCCESS;
  }

  event result_t XCommand.received(XCommandOp *opcode) {

      switch (opcode->cmd) {
	  case XCOMMAND_SET_RATE:
	      break;

	  case XCOMMAND_SLEEP:
              break;

	  case XCOMMAND_WAKEUP:
	      break;

	  case XCOMMAND_RESET:
	      break;

	  default:
	      break;
      }

      return SUCCESS;
  }

}



