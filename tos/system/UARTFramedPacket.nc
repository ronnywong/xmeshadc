/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: UARTFramedPacket.nc,v 1.1.4.1 2007/04/27 06:04:48 njain Exp $
 */

/*
 *
 * Authors:		Phil Buonadonna
 *
 */

/**
 * @author Phil Buonadonna
 */


configuration UARTFramedPacket
{
  provides {
    interface StdControl as Control;
    interface BareSendMsg as Send;
    interface ReceiveMsg as Receive;
  }
}
implementation
{
  components FramerM, FramerAckM, UART;

  Control = FramerM;
  Send = FramerM;
  Receive = FramerAckM;

  FramerAckM.TokenReceiveMsg -> FramerM;
  FramerAckM.ReceiveMsg -> FramerM;

  FramerM.ByteControl -> UART;
  FramerM.ByteComm -> UART;

}
