/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLCC2420C.nc,v 1.1.4.1 2007/04/26 00:30:28 njain Exp $
 */
 
/*
 *
 * Authors: Alan Broad, Crossbow
 * Date last modified:  $Revision: 1.1.4.1 $
 *
 */

/**
 * Low level hardware access to the CC2420
 * @author Joe Polastre
 */

/***************************************************************************** 
$Log: HPLCC2420C.nc,v $
Revision 1.1.4.1  2007/04/26 00:30:28  njain
CVS: Please enter a Bugzilla bug number on the next line.
BugID: 1100

CVS: Please enter the commit log message below.
License header modified in each file for MoteWorks_2_0_F release

Revision 1.1  2006/01/03 07:46:18  mturon
Initial install of MoteWorks tree

Revision 1.2  2005/03/02 22:45:00  jprabhu
Added Log CVS-Tag

*****************************************************************************/
configuration HPLCC2420C {
  provides {
    interface StdControl;
    interface HPLCC2420;
    interface HPLCC2420FIFO;
    interface HPLCC2420RAM;
  }
}
implementation
{
  components HPLCC2420M, HPLCC2420FIFOM;

  StdControl = HPLCC2420M;
  HPLCC2420 = HPLCC2420M;
  HPLCC2420FIFO = HPLCC2420FIFOM;
  HPLCC2420RAM = HPLCC2420M;

}
