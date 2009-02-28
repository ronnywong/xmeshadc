/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PowerC.nc,v 1.1.4.1 2007/04/27 05:10:37 njain Exp $
 */
 
/*
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created 11/14/2003
 *
 */

configuration PowerC
{
  provides {
    interface Power as EXCITATION25;
    interface Power as EXCITATION33;
    interface Power as EXCITATION50;
  }
}
implementation
{
  components IBADC;

  EXCITATION25 = IBADC.EXCITATION25;
  EXCITATION33 = IBADC.EXCITATION33;
  EXCITATION50 = IBADC.EXCITATION50;    
}
