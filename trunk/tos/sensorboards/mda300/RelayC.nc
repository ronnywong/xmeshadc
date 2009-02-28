/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RelayC.nc,v 1.1.4.1 2007/04/27 05:10:54 njain Exp $
 */
 
/*
 *
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created 11/14/2003
 *
 */

configuration RelayC
{
  provides {
  interface StdControl as RelayControl;
  interface Relay as relay_normally_closed;
  interface Relay as relay_normally_open;
  }
}
implementation
{
  components RelayM,DioC;

  RelayControl = RelayM.RelayControl;
  relay_normally_closed = RelayM.relay_normally_closed;
  relay_normally_open = RelayM.relay_normally_open;

  RelayM.DioControl -> DioC.StdControl;  
  RelayM.Dio6 -> DioC.Dio[6];
  RelayM.Dio7 -> DioC.Dio[7];

}
