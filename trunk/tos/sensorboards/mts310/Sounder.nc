/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Sounder.nc,v 1.1.4.1 2007/04/27 05:36:14 njain Exp $
 */


/*
 *
 * Authors:		Alec Woo, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/**
 * @author Alec Woo
 * @author David Gay
 * @author Philip Levis
 */

includes sensorboard;

configuration Sounder
{
  provides interface StdControl;
}
implementation
{
  components SounderM;

  StdControl = SounderM;
}
