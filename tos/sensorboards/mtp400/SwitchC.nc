/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SwitchC.nc,v 1.1.4.1 2007/04/27 05:33:15 njain Exp $
 */

/*
 * driver for 3 Multiplexer on mtp400ca
 *
 * PW0/PW1/PW2 control selecting of Channel
 * PW0 -> A0
 * PW1 -> A1
 * PW2 -> A2
 * A2A1A0 are the address of channel
 * 
 * VSensor provides the VCC and control the Enable/Disable of ADG708 
 *
 * COM port output the select channel
 *
 * Authors: Hu Siquan <husq@xbow.com>
 *
 * $Id: SwitchC.nc,v 1.1.4.1 2007/04/27 05:33:15 njain Exp $  
 */

configuration SwitchC
{
  provides {
    interface StdControl as SwitchControl;
    interface Switch;
  }
}
implementation
{
  components SwitchM;
  Switch = SwitchM;
  SwitchControl = SwitchM;
}
