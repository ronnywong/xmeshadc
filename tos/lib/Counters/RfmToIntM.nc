/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RfmToIntM.nc,v 1.1.4.1 2007/04/25 23:36:49 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


includes IntMsg;

module RfmToIntM {
  provides interface StdControl;
  uses {
    interface ReceiveMsg as ReceiveIntMsg;
    interface IntOutput;
    interface StdControl as CommControl;
  }
}
implementation {

  command result_t StdControl.init() {
    return call CommControl.init();
  }

  command result_t StdControl.start() {
    return call CommControl.start();
  }

  command result_t StdControl.stop() {
    return call CommControl.stop();
  }

  event TOS_MsgPtr ReceiveIntMsg.receive(TOS_MsgPtr m) {
    IntMsg *message = (IntMsg *)m->data;
    call IntOutput.output(message->val);

    return m;
  }

  event result_t IntOutput.outputComplete(result_t success) {
    return SUCCESS;
  }

}
