/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PhotoTemp.nc,v 1.1.4.1 2007/04/27 05:06:50 njain Exp $
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

includes sensorboard;
configuration PhotoTemp
{
  provides interface ADC as ExternalPhotoADC;
  provides interface ADC as ExternalTempADC;
  provides interface StdControl as TempStdControl;
  provides interface StdControl as PhotoStdControl;
}
implementation
{
  components PhotoTempM, ADCC, TimerC;

  TempStdControl = PhotoTempM.TempStdControl;
  PhotoStdControl = PhotoTempM.PhotoStdControl;
  ExternalPhotoADC = PhotoTempM.ExternalPhotoADC;
  ExternalTempADC = PhotoTempM.ExternalTempADC;
  PhotoTempM.InternalPhotoADC -> ADCC.ADC[TOS_ADC_PHOTO_PORT];
  PhotoTempM.InternalTempADC -> ADCC.ADC[TOS_ADC_TEMP_PORT];
  PhotoTempM.ADCControl -> ADCC;
  PhotoTempM.TimerControl -> TimerC;
  PhotoTempM.PhotoTempTimer -> TimerC.Timer[unique("Timer")];
}
