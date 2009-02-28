/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RF230RadioM.nc,v 1.1.2.2 2007/04/27 05:02:21 njain Exp $
 */

module RF230RadioM {
	
	provides {
		interface StdControl;
		
		//HP send/recv
		interface BareSendMsg as Send;
		interface ReceiveMsg as Recv;
		
		//dummy wake up sequence control
		interface RadioPower;
	}
	
	uses {
		//Radio Stuff
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
		
		//interface for doing random
		interface Random;
		interface Leds;
	}
}

implementation {
	
	
/* === StdControl ========================================================== */
	
	command result_t StdControl.init() {
		result_t ok1, ok2;
		
		ok1 = call RadioSplitControl.init();
		ok2 = call Random.init();
		return rcombine(ok1,ok2);
	}
	
	command result_t StdControl.start() {
		return call RadioSplitControl.start();
	}
	
	command result_t StdControl.stop() {
		return call RadioSplitControl.stop();
	}
	
/* === Send ================================================================ */

	//Send will reject all sends if it is not ready
	
	command result_t Send.send (TOS_MsgPtr pMsg) {
		//call Leds.greenOn();
		return call PHYSend.send(pMsg);
	}

/* === SplitControl Callbacks ============================================== */

	event result_t RadioSplitControl.initDone() {
		//Never Called
		return SUCCESS;
	}
	
	event result_t RadioSplitControl.startDone() {
		return SUCCESS;
	}
	
	event result_t RadioSplitControl.stopDone() {
		//Never Called
		return SUCCESS;
	}
	
/* === Send ================================================================ */

	event result_t PHYSend.sendDone(TOS_MsgPtr msg, result_t succ) {
		//call Leds.greenOff();
		return signal Send.sendDone(msg, succ);
	}
	
/* === Receive ============================================================= */

	event TOS_MsgPtr PHYRecv.receive(TOS_MsgPtr msg) { 
		return signal Recv.receive(msg);		
	}
	
	event result_t IntervalTimer.fired() {
		return SUCCESS;	
	}
	
/* === Timers ============================================================== */

	event result_t SleepTimer.fired() {
		return SUCCESS;	
	}
	
/* === Backoff ============================================================= */

	/**
	 * How many basic time periods to back off.
	 * Each basic time period consists of 20 symbols (16uS per symbol)
	 */
	async event int16_t MacBackoff.initialBackoff (TOS_MsgPtr m) {
		return ((call Random.rand () & 0xF) + 1);
	}

	/**
	 * How many symbols to back off when there is congestion (16uS per symbol)
	 */
	async event int16_t MacBackoff.congestionBackoff (TOS_MsgPtr m) {
		return ((call Random.rand () & 0xF) + 1); //xin change 2.27.06
	}

	
/* === Wake sequence ======================================================= */
		
	async event void WakeSequence.IncomingPacket() { }
	
	async event void WakeSequence.sniffExpired(bool channelClear) { }
	
	async event void WakeSequence.sendWakeDone(result_t succ) { }

/* === Dummmy wakeup adjust ================================================ */

	command result_t RadioPower.SetListeningMode(uint8_t mode) { return SUCCESS; }
	
	command result_t RadioPower.SetTransmitMode(uint8_t mode) { return SUCCESS; }
	
/* === Default ============================================================= */

	default event TOS_MsgPtr Recv.receive(TOS_MsgPtr msg) { return msg; }
		

}
