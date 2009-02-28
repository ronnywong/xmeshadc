/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: IntToRfmM.nc,v 1.1.4.1 2007/04/25 23:36:33 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, David Gay, Philip Levis, Nelson Lee
 * Date last modified:  6/25/02
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 * @author Nelson Lee
 */


includes IntMsg;

module IntToRfmM 
{
  uses {
    interface StdControl as SubControl;
    interface SendMsg as Send;
  }
  provides {
    interface IntOutput;
    interface StdControl;
  }
}
implementation
{
  bool pending;
  TOS_Msg data;

  command result_t StdControl.init() {
    pending = FALSE;
    return call SubControl.init();
  }

  command result_t StdControl.start() 
  {
    return call SubControl.start();
  }


    command result_t StdControl.stop() 
  {
    return call SubControl.stop();
  }

  command result_t IntOutput.output(uint16_t value)
  {
    IntMsg *message = (IntMsg *)data.data;

    if (!pending) 
      {
	pending = TRUE;

	message->val = value;
	atomic {
	  message->src = TOS_LOCAL_ADDRESS;
	}
	if (call Send.send(TOS_BCAST_ADDR, sizeof(IntMsg), &data))
	  return SUCCESS;

	pending = FALSE;
      }
    return FAIL;
  }

  event result_t Send.sendDone(TOS_MsgPtr msg, result_t success)
  {
    if (pending && msg == &data)
      {
	pending = FALSE;
	signal IntOutput.outputComplete(success);
      }
    return SUCCESS;
  }
}




