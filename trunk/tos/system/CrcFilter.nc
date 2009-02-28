/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CrcFilter.nc,v 1.1.4.1 2007/04/27 06:00:11 njain Exp $
 */
 
/*
 *
 * Authors:		Philip Levis
 * Date last modified:  9/16/02
 *
 */

/**
 * This component filters packet receptions that do not pass a CRC
 * check.
 * @author Philip Levis
 */

module CrcFilter {
  provides interface ReceiveMsg as UpperReceive;
  uses interface ReceiveMsg as LowerReceive;
}


implementation {

  event TOS_MsgPtr LowerReceive.receive(TOS_MsgPtr msg) {
    if (msg->crc) {
      dbg(DBG_CRC, "CrcFilter: Packet passed CRC, signaling.\n");
      return signal UpperReceive.receive(msg);
    }
    else {
      dbg(DBG_CRC, "CrcFilter: Packet failed CRC.\n");
      return msg;
    }
  }
  
}
