/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RfmToInt.nc,v 1.1.4.1 2007/04/25 23:36:41 njain Exp $
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

configuration RfmToInt {
  provides interface StdControl;
  uses interface IntOutput;
}
implementation {
  components RfmToIntM, GenericComm;

  IntOutput = RfmToIntM;
  StdControl = RfmToIntM;
  RfmToIntM.ReceiveIntMsg -> GenericComm.ReceiveMsg[AM_INTMSG];
  RfmToIntM.CommControl -> GenericComm;
}
