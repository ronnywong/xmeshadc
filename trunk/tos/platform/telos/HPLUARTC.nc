/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLUARTC.nc,v 1.1.4.1 2007/04/26 22:20:09 njain Exp $
 */
 
/*
 *
 * Authors:		Joe Polastre
 * Date last modified:  $Id: HPLUARTC.nc,v 1.1.4.1 2007/04/26 22:20:09 njain Exp $
 *
 */

/**
 * @author Joe Polastre
 */
configuration HPLUARTC {
  provides interface HPLUART as UART;
}
implementation
{
  components HPLUARTM, HPLUSART1M as HPLUSART;

  UART=HPLUARTM;

  HPLUARTM.USARTControl -> HPLUSART;
  HPLUARTM.USARTData -> HPLUSART;

}
