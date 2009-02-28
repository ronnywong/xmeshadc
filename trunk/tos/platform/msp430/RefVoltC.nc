/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RefVoltC.nc,v 1.1.4.1 2007/04/26 22:13:52 njain Exp $
 */
 
/*
 * - Description ----------------------------------------------------------
 * Configuration for Reference Voltage Generator.
 * - Revision -------------------------------------------------------------
 * $Revision: 1.1.4.1 $
 * $Date: 2007/04/26 22:13:52 $
 * @author: Jan Hauer (hauer@tkn.tu-berlin.de)
 * @author: Kevin Klues (klues@tkn.tu-berlin.de)
 * ========================================================================
 */

configuration RefVoltC
{
  provides interface RefVolt;
}

implementation
{
  components Main, RefVoltM, TimerC, HPLADC12M;
  
  Main.StdControl -> TimerC;
  
  RefVolt = RefVoltM;
  RefVoltM.SwitchOnTimer -> TimerC.TimerMilli[unique("TimerMilli")];
  RefVoltM.SwitchOffTimer -> TimerC.TimerMilli[unique("TimerMilli")];
  RefVoltM.HPLADC12 -> HPLADC12M;
}

