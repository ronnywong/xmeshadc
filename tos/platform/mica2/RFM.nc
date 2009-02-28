/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RFM.nc,v 1.1.4.1 2007/04/26 00:16:24 njain Exp $
 */
 
 /*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

configuration RFM
{
  provides {
    interface StdControl as Control;
    interface Radio;
  }
}
implementation
{
  components RFMM, HPLRFMC;

  Control = RFMM;
  Radio = RFMM;
  RFMM.RFM -> HPLRFMC;
}
