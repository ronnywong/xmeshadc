/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: QueuedSend.nc,v 1.1.4.1 2007/04/25 23:38:25 njain Exp $
 */

/* 
 * Author: Phil Buonadonna
 * $Revision: 1.1.4.1 $
 */

/**
 * @author Phil Buonadonna
 */


includes AM;

configuration QueuedSend {
  provides {
    interface StdControl;
    interface SendMsg[uint8_t id];
    interface QueueControl;
  }

}

implementation {
  components QueuedSendM,  GENERICCOMMPROMISCUOUS as Comm, NoLeds;

  StdControl = QueuedSendM;
  QueueControl = QueuedSendM;

  SendMsg = QueuedSendM.QueueSendMsg;
  QueuedSendM.SerialSendMsg -> Comm.SendMsg;
  QueuedSendM.Leds -> NoLeds;
}
