/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Bcast.nc,v 1.1.4.1 2007/04/25 23:35:23 njain Exp $
 */
 
/*
 * Authors:	Philip Buonadonna
 * $Revision: 1.1.4.1 $
 *
 */

/**
 * @author Philip Buonadonna
 */


includes Bcast;

configuration Bcast {

  provides {
    interface StdControl;
    interface Receive[uint8_t id];
  }

  uses {
    interface ReceiveMsg[uint8_t id];
  }

}

implementation {
  components BcastM,  GENERICCOMMPROMISCUOUS as Comm, QueuedSend;

  StdControl = BcastM;
  Receive = BcastM;

  ReceiveMsg = BcastM;

  BcastM.SubControl -> QueuedSend.StdControl;
  BcastM.SubControl -> Comm;
  BcastM.SendMsg -> QueuedSend.SendMsg;

}
