/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CC1000RadioM.nc,v 1.2.4.1 2007/04/27 04:55:01 njain Exp $
 */

/*  
 *  Authors: Philip Buonadonna, Jaein Jeong, Joe Polastre
 *  Date last modified: $Revision: 1.2.4.1 $
 *
 * This module provides the layer2 functionality for the mica2 radio.
 * While the internal architecture of this module is not CC1000 specific,
 * It does make some CC1000 specific calls via CC1000Control.
 * 
 */

/**
 * @author Philip Buonadonna
 * @author Jaein Jeong
 * @author Joe Polastre
 */

// a wrapper component for radio binary
  

configuration CC1000RadioM {
  provides {
 //   interface StdControl;
 //   interface BareSendMsg as Send;
 //   interface ReceiveMsg as Receive;
    interface RadioPower;

    command uint8_t GetListeningMode();
    command uint8_t GetTransmitMode();
    command uint16_t GetSquelch();
    command uint16_t GetRxCount();
    command uint16_t GetSendCount();
    command uint16_t GetPower();
    command uint16_t GetPower_check();
    command uint16_t GetPower_send();
    command uint16_t GetPower_receive();
    command uint16_t GetPower_total_sum();
    interface RadioCoordinator as RadioSendCoordinator;
    interface RadioCoordinator as RadioReceiveCoordinator;
 }
}
implementation {
	components RadioC;
   
         RadioPower = RadioC;
         GetPower = RadioC.GetPower;
         GetListeningMode = RadioC.GetListeningMode;
         GetTransmitMode = RadioC.GetTransmitMode;
	 GetSquelch = RadioC.GetSquelch;
         GetRxCount = RadioC.GetRxCount;
         GetSendCount = RadioC.GetSendCount;
         GetPower_check = RadioC.GetPower_check;
         GetPower_send = RadioC.GetPower_send;
         GetPower_receive = RadioC.GetPower_receive;
         GetPower_total_sum = RadioC.GetPower_total_sum;
         RadioSendCoordinator = RadioC.RadioSendCoordinator;
         RadioReceiveCoordinator = RadioC.RadioReceiveCoordinator;


}
