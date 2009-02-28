/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SlavePinC.nc,v 1.1.4.1 2007/04/26 00:27:35 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  $Id: SlavePinC.nc,v 1.1.4.1 2007/04/26 00:27:35 njain Exp $
 *
 */

/**
 * Provide shared control of SlavePin (radio, flash) in a semaphore-like
 * fashion.
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */

configuration SlavePinC {
  provides interface SlavePin;
  provides interface StdControl;
}
implementation
{
  components SlavePinM, HPLSlavePinC;

  SlavePin = SlavePinM;
  StdControl = SlavePinM;

  SlavePinM.HPLSlavePin -> HPLSlavePinC;
}
