/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLCC2420C.nc,v 1.1.2.2 2007/04/26 22:00:24 njain Exp $
 */

/*
 *
 * Authors: Alan Broad, Crossbow
 * Date last modified:  $Revision: 1.1.2.2 $
 *
 */

/**
 * Low level hardware access to the CC2420
 * @author Joe Polastre
 */

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
