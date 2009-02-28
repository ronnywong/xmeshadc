/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RelayC.nc,v 1.1.4.1 2007/04/27 05:46:17 njain Exp $
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
  interface Relay as relay1;
  interface Relay as relay2;
  }
}
implementation
{
  components RelayM;

  RelayControl = RelayM.RelayControl;
  relay1 = RelayM.relay1;
  relay2 = RelayM.relay2;


}
