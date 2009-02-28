/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SlottedSendC.nc,v 1.2.4.1 2007/04/25 23:39:26 njain Exp $
 */

/* 
 * Author: Xin Yang (xyang@xbow.com)
 * Date:   11/05/05
 */

/**
 * SlottedSendC.nc - Binary Component of SlottedSendM module
 *
 * <pre>
 *	$Id: SlottedSendC.nc,v 1.2.4.1 2007/04/25 23:39:26 njain Exp $
 * </pre>
 * 
 * @author Xin Yang 
 * @date November 13 2005
 */
 
component SlottedSendC {
	
  provides {
    interface StdControl as SlottedSendControl;
		
    // slottedSend configuration interface
    interface SlottedSendParams;
				
    // upper layers wires to these to use slotted send service
    interface BareSendMsg as LPSend;
    interface ReceiveMsg as LPRecv;
		
    // interface used by driver layer to signal recv asynchronoulsy
    async event TOS_MsgPtr asyncReceive(TOS_MsgPtr m);
    async event void shortReceived();
  }
	
  uses {
    interface StdControl as TimerControl;
    interface Timer as SniffTimer; //to be replaced by global time element
    interface Timer as SleepTimer; //to timeout incomplete preamble sequences
    interface Timer	as SlotBackoffTimer;	//slot back off timer
    interface StdControl as RadioControl;
    interface BareSendMsg as PHYSend;
    interface ReceiveMsg as PHYRecv;
    interface Random;		
    interface MacBackoff;
    interface Leds;
		
    interface Timer as MacTimer;
    interface Timer as dbgTimer;
    
    //buffer pool
    interface SlottedSendBuffers as Buffers;
		
    // required functionalities, provided by radio driver layer
    command result_t checkCCA(uint32_t t);
    //configures the lower layers to use the asyncReceive instead
    command result_t setImmediateSendMode(result_t option);
    command result_t isImmediateSendMode();
    async command result_t stopCCA();
    async command result_t asyncSend(uint8_t * bufferPtr);
	command result_t checkSFD (uint32_t t);

  }
	
}
