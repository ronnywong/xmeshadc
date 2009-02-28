/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SwitchC.nc,v 1.1.4.1 2007/04/27 05:11:53 njain Exp $
 */
 
/*
 *
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created @ 01/14/2003 
 * Last Modified:     @ 08/14/2003
 * 
 * driver for ADG715BRU on mda300ca 
 * inspired from joe Polastre previous driver 
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
  components I2CPacketC,SwitchM;
  Switch = SwitchM;
  SwitchControl = SwitchM;
  SwitchM.I2CPacket -> I2CPacketC.I2CPacket[75];
}
