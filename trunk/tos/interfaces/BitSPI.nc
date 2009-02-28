/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: BitSPI.nc,v 1.1.4.1 2007/04/25 23:19:02 njain Exp $
 */
/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 *
 */

/** 
 * The SPI bit transmit interface.
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */
interface BitSPI {
  /**
   * Transmit a bit to an SPI
   * @return bit read from the SPI
   */
  command bool txBit(bool bit);
}
