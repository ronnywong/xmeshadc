/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: UART1.nc,v 1.1.4.1 2007/04/27 05:58:26 njain Exp $
 */

/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


configuration UART1 {
  provides {
    interface ByteComm;
    interface StdControl as Control;
  }
}
implementation {
  components UART1M, HPLUART1C;

  ByteComm = UART1M;
  Control = UART1M;
  UART1M.HPLUART -> HPLUART1C;
}
