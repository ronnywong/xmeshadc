/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XCommandM.nc,v 1.4.4.5 2007/04/25 23:43:05 njain Exp $
 */
 
 /**
 * Provides a library module for handling basic application messages for
 * controlling a wireless sensor network.
 *
 * @file      XCommandM.nc
 * @author    Martin Turon
 * @version   2004/10/1    mturon      Initial version
 *
 * Summary of XSensor commands:
 *      reset, sleep, wakeup
 *  	set/get (rate) "heartbeat"
 *  	set/get (nodeid, group)
 *  	set/get (radio freq, band, power)
 *  	actuate (device, state)
 *  	set/get (calibration)
 *  	set/get (mesh type, max resend)
 *
 */

includes XCommand;
includes config;

module XCommandM {
  provides {
    interface XCommand;
  }

  uses {
    interface MhopSend as Send;
    interface Receive as Bcast;
    interface Receive as CmdRcv;
    interface Leds;
    interface Config[uint32_t setting];
    interface ConfigSave;
  }
}

implementation {

  enum {CONFIG_PKT=0x81,
  		UID_PKT,
  		SETNODEID_PKT,
  		SETGROUPID_PKT,
  		SETFREQ_PKT,
  		SETRFPOWER_PKT,
  		SETTIMERRATE_PKT
  		}; // packet id
  enum {IDLE,
  		GET_CONFIG,
  		CONFIG_UID,
  		SET_NODEID,
  		SET_GROUPID,
  		SET_RFFREQ,
  		SET_RFPOWER,
  		SET_TIMERRATE
  		}; // xcommand excution state

  TOS_Msg msg_buf;
  XCmdDataMsg readings;
  uint8_t nextPacketID;
  uint8_t state;
  uint8_t cmdkey;

  /***************************************************************************
 * Task to xmit radio message
 *
 *    msg_radio->addr = TOS_BCAST_ADDR;
 *    msg_radio->type = 0x31;
 *    msg_radio->length = MSG_LEN;
 *    msg_radio->group = TOS_AM_GROUP;
 ***************************************************************************/
    task void send_msg() {
	uint8_t   i;
	uint16_t  len;
	XCmdDataMsg *data;

	// Fill the given data buffer.
	data = (XCmdDataMsg*)call Send.getBuffer(&msg_buf, &len);

	for (i = 0; i <= sizeof(XCmdDataMsg)-1; i++)
	    ((uint8_t*)data)[i] = ((uint8_t*)&readings)[i];

	data->xHeader.board_id  = MOTE_BOARD_ID;
	data->xHeader.node_id   = TOS_LOCAL_ADDRESS;
    data->xHeader.packet_id = nextPacketID;

    data->xHeader.cmdkey = cmdkey;

    if (call Send.send(BASE_STATION_ADDRESS, MODE_UPSTREAM, &msg_buf, sizeof(XCmdDataMsg)) != SUCCESS) {

	}

	return;
}


 /**
  * Handle default LED acctuation handling.
  *
  * @version   2004/11/2   mturon     Initial version
  */
  static void XCommandAcctuate(uint16_t device, uint16_t cmd_state) {
      switch (device) {

	  case XCMD_DEVICE_LEDS:
	      call Leds.set(cmd_state);
	      break;

	  case XCMD_DEVICE_LED_GREEN:
	      switch (cmd_state) {
		  case 0: call Leds.greenOff();     break;
		  case 1: call Leds.greenOn();      break;
		  case 2: call Leds.greenToggle();  break;
	      }
	      break;

	  case XCMD_DEVICE_LED_RED:
	      switch (cmd_state) {
		  case 0: call Leds.redOff();       break;
		  case 1: call Leds.redOn();        break;
		  case 2: call Leds.redToggle();    break;
	      }
	      break;

	  case XCMD_DEVICE_LED_YELLOW:
	      switch (cmd_state) {
		  case 0: call Leds.yellowOff();    break;
		  case 1: call Leds.yellowOn();     break;
		  case 2: call Leds.yellowToggle(); break;
	      }
	      break;

	  default: break;
      }

  }

   event result_t ConfigSave.saveDone(result_t success, AppParamID_t failed)
  {
  	switch(state){
  		case CONFIG_UID:
  			readings.xData.uidData1.nodeid = TOS_LOCAL_ADDRESS;
			readings.xHeader.responseCode  = XCMD_RES_SUCCESS;
		  	state = IDLE;
		  	nextPacketID = UID_PKT; // UID Packet
		  	post send_msg();
		  	break;
		case SET_NODEID:
			readings.xHeader.responseCode  = XCMD_RES_SUCCESS;

			readings.xData.nodeid = TOS_LOCAL_ADDRESS;
			state = IDLE;
			nextPacketID = SETNODEID_PKT; // UID Packet
			post send_msg();
			break;
		case SET_GROUPID:
			readings.xHeader.responseCode  = XCMD_RES_SUCCESS;
			readings.xData.groupid = TOS_AM_GROUP;
			state = IDLE;
			nextPacketID = SETGROUPID_PKT; // UID Packet
			post send_msg();
			break;
		case SET_RFFREQ:
			readings.xHeader.responseCode  = XCMD_RES_SUCCESS;
			call Config.get[CONFIG_RF_CHANNEL](&readings.xData.rf_channel, sizeof(uint8_t));
			state = IDLE;
			nextPacketID = SETFREQ_PKT; // Set_RFCHANNEL Packet
			post send_msg();
			break;
		case SET_RFPOWER:
			readings.xHeader.responseCode  = XCMD_RES_SUCCESS;
			TOSH_uwait(5);
			call Config.get[CONFIG_RF_POWER](&readings.xData.rfParams.rf_power, sizeof(uint8_t));
			call Config.get[CONFIG_RF_CHANNEL](&readings.xData.rfParams.rf_channel, sizeof(uint8_t));
			state = IDLE;
			nextPacketID = SETRFPOWER_PKT; // Set_RFPOWER Packet
			post send_msg();
			break;
		case SET_TIMERRATE:
			readings.xHeader.responseCode  = XCMD_RES_SUCCESS;
			readings.xData.newrate = timer_rate;
			state = IDLE;
			nextPacketID = SETTIMERRATE_PKT; // set data collection rate
			post send_msg();
			break;
		default:
			break;
  		}
    return SUCCESS;
  }

void getMyConfig()
{
	state = GET_CONFIG;
	call Config.get[CONFIG_MOTE_SERIAL](&(readings.xData.configdata1.uid[0]),8);
	call Config.get[CONFIG_MOTE_ID](&readings.xData.configdata1.nodeid,sizeof(uint16_t));
	call Config.get[CONFIG_MOTE_GROUP](&readings.xData.configdata1.group,sizeof(uint8_t));
	call Config.get[CONFIG_RF_POWER](&readings.xData.configdata1.rf_power,sizeof(uint8_t));
	call Config.get[CONFIG_RF_CHANNEL](&readings.xData.configdata1.rf_channel,sizeof(uint8_t));
	readings.xHeader.responseCode = XCMD_RES_SUCCESS;
	state = IDLE;
	nextPacketID = CONFIG_PKT;
  	post send_msg();
    return;

}

  void Uid_Config(void *ptrSerialid, uint16_t *ptrNodeid)
 {

 	state = CONFIG_UID;
	call Config.get[CONFIG_MOTE_SERIAL]((uint8_t *)(&(readings.xData.uidData1.serialid[0])),8);

   	memcmp(readings.xData.uidData1.serialid, ptrSerialid,8);
	readings.xData.uidData1.oldNodeid = TOS_LOCAL_ADDRESS;
	atomic call Config.set[CONFIG_MOTE_ID](ptrNodeid,sizeof(uint16_t));
	if( call ConfigSave.save(CONFIG_MOTE_ID,CONFIG_MOTE_ID) != SUCCESS)
	{
		readings.xHeader.responseCode  = XCMD_RES_FAIL;
		readings.xData.uidData1.nodeid = TOS_LOCAL_ADDRESS;
		state = IDLE;
		nextPacketID = UID_PKT; // UID Packet
		post send_msg();
	}

	return;
 }

 void Set_NodeID(uint16_t *ptrNodeid)
 {
 	state = SET_NODEID;
	call Config.set[CONFIG_MOTE_ID](ptrNodeid,sizeof(uint16_t));
	if(call ConfigSave.save(CONFIG_MOTE_ID,CONFIG_MOTE_ID) != SUCCESS)
	{
		readings.xHeader.responseCode  = XCMD_RES_FAIL;
		readings.xData.nodeid = TOS_LOCAL_ADDRESS;
		state = IDLE;
		nextPacketID = SETNODEID_PKT; // UID Packet
		post send_msg();
	}
	return;
 }

   void Set_GroupID(uint8_t *ptrGroupid)
 {
 	state = SET_GROUPID;
	call Config.set[CONFIG_MOTE_GROUP](ptrGroupid,sizeof(uint8_t));
	if(call ConfigSave.save(CONFIG_MOTE_GROUP,CONFIG_MOTE_GROUP) != SUCCESS)
	{
		readings.xHeader.responseCode  = XCMD_RES_FAIL;
		readings.xData.groupid = TOS_AM_GROUP;
		state = IDLE;
		nextPacketID = SETGROUPID_PKT; // Groupid Packet
		post send_msg();
	}
	return;
 }

   void Set_TimerRate(uint32_t *ptrTimerRate)
 {
 	state = SET_TIMERRATE;
	// Change the data collection rate.
	call Config.set[CONFIG_XMESHAPP_TIMER_RATE](ptrTimerRate,4*sizeof(uint8_t));
	if(call ConfigSave.save(CONFIG_XMESHAPP_TIMER_RATE,CONFIG_XMESHAPP_TIMER_RATE) != SUCCESS)
	{
		readings.xHeader.responseCode  = XCMD_RES_FAIL;
		readings.xData.newrate = timer_rate;
		state = IDLE;
		nextPacketID = SETTIMERRATE_PKT; // set data collection rate
		post send_msg();
	}
	return;
 }

  void Set_RFCHANNEL(uint8_t *ptrCH)
 {
	state = SET_RFFREQ;
	call Config.set[CONFIG_RF_CHANNEL](ptrCH,sizeof(uint8_t));
	if(call ConfigSave.save(CONFIG_RF_CHANNEL,CONFIG_RF_CHANNEL) != SUCCESS)
	{
		readings.xHeader.responseCode  = XCMD_RES_FAIL;
		call Config.get[CONFIG_RF_CHANNEL](&readings.xData.rf_channel, sizeof(uint8_t));
		state = IDLE;
		nextPacketID = SETFREQ_PKT; // Set_RFCHANNEL Packet

		post send_msg();
	}
	return;
 }

  void Set_RFPOWER(uint8_t *ptrRFPower)
 {
 	state = SET_RFPOWER;
  call Config.set[CONFIG_RF_POWER](ptrRFPower,sizeof(uint8_t));
  if(call ConfigSave.save(CONFIG_RF_POWER,CONFIG_RF_POWER)!= SUCCESS)
	{
		readings.xHeader.responseCode  = XCMD_RES_FAIL;
		call Config.get[CONFIG_RF_CHANNEL](&readings.xData.rfParams.rf_channel, sizeof(uint8_t));
		call Config.get[CONFIG_RF_POWER](&readings.xData.rfParams.rf_power, sizeof(uint8_t));
		state = IDLE;
		nextPacketID = SETRFPOWER_PKT; // Set_RFPOWER Packet
		post send_msg();
	}
	return;
 }


 void handleCommand(XCommandOp* opcode, uint16_t addr){

      // Forward command message to application.
      if (signal XCommand.received(opcode) != SUCCESS) return;

	  //store cmd key
	  cmdkey = opcode->cmdkey;

      // Perform default handling.
      switch (opcode->cmd) {

	  case XCOMMAND_SLEEP:
		break;

	  case XCOMMAND_WAKEUP:
		break;

	  case XCOMMAND_RESET:
	      // Link into NetProg instead.
	      wdt_disable();
	      wdt_enable(1); while(1);
              break;
	  	  break;

	  case XCOMMAND_GET_CONFIG:
	  	   getMyConfig();
	  	   break;


	  case XCOMMAND_SET_RATE: // save timer_rate into eeprom
		  Set_TimerRate(&(opcode->param.newrate));
	  	  break;

	  case XCOMMAND_SET_NODEID:
	      // Only allow programming nodeid via direct UART,
	      // or over RF to a specific destination node (broadcast illegal)
	      if (addr == 0xFFFF)
		  break;    // In case of broadcast to UART, drop forwarding.
		  Set_NodeID(&(opcode->param.nodeid));
	      break;

	  case XCOMMAND_SET_GROUP:
		  Set_GroupID(&(opcode->param.group));
	      break;

	  case XCOMMAND_SET_RF_POWER:
	  	  Set_RFPOWER(&(opcode->param.rf_power));
	      break;

	  case XCOMMAND_SET_RF_CHANNEL:
  		  Set_RFCHANNEL(&(opcode->param.rf_channel));
	      break;

	  case XCOMMAND_CONFIG_UID:
	  	  Uid_Config(&(opcode->param.uidconfig.serialid[0]),&(opcode->param.uidconfig.nodeid));
	  	  break;


	  // Handle LED actuation.
	  case XCOMMAND_ACTUATE: {
	      uint16_t device = opcode->param.actuate.device;
	      uint16_t l_state  = opcode->param.actuate.state;
	      XCommandAcctuate(device, l_state);
	      break;
	  }

	  default:
	      break;
      }

 }




 /**
  * Received downstream command message
  *
  */
  event TOS_MsgPtr CmdRcv.receive(TOS_MsgPtr pMsg, void* payload, uint16_t payloadLen)
  {
      XMeshMsg *cmdMsg = (XMeshMsg *)payload;
      XCommandOp  *opcode = &(cmdMsg->inst);

	  //cmd messages can only be sent point to point
	  handleCommand(opcode,TOS_LOCAL_ADDRESS);

      return pMsg;
  }



 /**
  * Performs main command parsing and signal callback to application.
  *
  * NOTE: Bcast messages will not be received if seq_no is not properly
  *       set in first two bytes of data payload.  Also, payload is
  *       the remaining data after the required seq_no.
  *
  * @version   2004/10/5   mturon     Initial version
  */
  event TOS_MsgPtr Bcast.receive(TOS_MsgPtr pMsg, void* payload,
				 uint16_t payloadLen)
  {

      XCommandMsg *cmdMsg = (XCommandMsg *)payload;
      XCommandOp  *opcode = &(cmdMsg->inst);

      // Basic group filter
      if (!((pMsg->group == 0xFF) || (pMsg->group == TOS_AM_GROUP)))
	  return pMsg;

      // Basic nodeid filter
      if ((cmdMsg->dest != 0xFFFF) && (cmdMsg->dest != TOS_LOCAL_ADDRESS))
	  return pMsg;

	  handleCommand(opcode, cmdMsg->dest);

      return pMsg;
  }


/**
  * Handle completion of sent RF packet.
  *
  * @author    Martin Turon
  * @version   2004/5/27      mturon       Initial revision
  */
  event result_t Send.sendDone(TOS_MsgPtr msg, result_t success)
  {
      return SUCCESS;
  }


}
