/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Echo10.nc,v 1.1.4.1 2007/04/27 05:09:38 njain Exp $
 */

#ifndef MDA300_CHANNEL_ECHO
#define MDA300_CHANNEL_ECHO 4
#endif

configuration Echo10 {
  provides {
    interface SplitControl;
    interface ADConvert;
  }
}
implementation {
  components IBADC, Echo10M, TimerC;

  ADConvert = IBADC.ADConvert[MDA300_CHANNEL_ECHO];
  SplitControl = Echo10M;
  Echo10M.Power -> IBADC.EXCITATION25;
  Echo10M.SetParam -> IBADC.SetParam[MDA300_CHANNEL_ECHO];
  //Echo10M.SubControl -> TimerC;
  Echo10M.SubControl -> IBADC;
  Echo10M.Timer -> TimerC.Timer[unique("Timer")];
}
