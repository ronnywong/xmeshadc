/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Photo_old.nc,v 1.1.4.1 2007/04/27 05:55:51 njain Exp $
 */

/*
 *
 * Authors:  Mike Grimmer
 * Date last modified:  6/25/02
 *
 */

includes sensorboard;
configuration Photo
{
  provides interface ADC as PhotoADC;
  provides interface StdControl;
}
implementation
{
  components PhotoTemp;

  StdControl = Photo.PhotoStdControl;
  PhotoADC = Photo.ExternalPhotoADC;
}
