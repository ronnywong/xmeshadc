/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: UART1.nc,v 1.1.4.3 2007/04/27 05:42:28 njain Exp $
 */

/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

configuration UART1 {
  provides {
    interface ByteComm;
    interface StdControl as Control;
  }
}
implementation {
  components UARTM, HPLUARTC1;

  ByteComm = UARTM;
  Control = UARTM;
  UARTM.HPLUART -> HPLUARTC1;
}
