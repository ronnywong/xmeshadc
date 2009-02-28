/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Photo.nc,v 1.1.4.1 2007/04/27 05:55:34 njain Exp $
 */

/*
 *
 * Authors:  Mike Grimmer
 * Date last modified:  2-19-04
 *
 */
includes sensorboard;
configuration Photo
{
  provides interface ADC as ExternalPhotoADC;
  provides interface StdControl as PhotoStdControl;
}
implementation
{
  components PhotoM, ADCC;

  PhotoStdControl = PhotoM.PhotoStdControl;
  ExternalPhotoADC = PhotoM.ExternalPhotoADC;
  PhotoM.InternalPhotoADC -> ADCC.ADC[TOS_ADC_PHOTO_PORT];
  PhotoM.ADCControl -> ADCC;
}
