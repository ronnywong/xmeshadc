/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * Copyright (c) 2003 by Sensicast, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Photo.nc,v 1.1.2.2 2007/04/26 19:59:46 njain Exp $
 */

/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 * Modifications:
 *  20Oct03 MJNewman: Add timer used for delays when sensor is switched.
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 * @author Michael Newman
 */

//includes sensorboard;
configuration Photo
{
  provides interface ADC as ExternalPhotoADC;
  provides interface StdControl as PhotoStdControl;
}
implementation
{
  components PhotoM, ADCC, TimerC;

  PhotoStdControl = PhotoM.PhotoStdControl;
  ExternalPhotoADC = PhotoM.ExternalPhotoADC;
  PhotoM.InternalPhotoADC -> ADCC.ADC[TOS_ADC_PHOTO_PORT];
  PhotoM.ADCControl -> ADCC;
  PhotoM.TimerControl -> TimerC;
  PhotoM.PhotoTimer -> TimerC.Timer[unique("Timer")];
}
