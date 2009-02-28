/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PhotoC.nc,v 1.1.4.1 2007/04/27 05:28:32 njain Exp $
 */

/*
 *
 * Authors: Mike Grimmer
 * Date last modified:  2-19-04
 *
 */
includes sensorboard;
configuration PhotoC
{
  provides interface ADC as PhotoADC;
  provides interface StdControl;
  provides interface Photo;
}
implementation
{
  components PhotoM, ADCC;

  StdControl = PhotoM;
  PhotoADC = ADCC.ADC[TOS_ADC_PHOTO_PORT];
  Photo = PhotoM;
  PhotoM.ADCControl -> ADCC;
}
