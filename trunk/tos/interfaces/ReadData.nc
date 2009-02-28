/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ReadData.nc,v 1.1.4.1 2007/04/25 23:28:37 njain Exp $
 */
 
/*
 * Authors:		David Gay, Philip Levis, Nelson Lee
 * Date last modified:  8/13/02
 *
 *
 */

/**
 * General interface to read n bytes of data from a particular offset.
 * @author David Gay
 * @author Philip Levis
 * @author Nelson Lee
 */
interface ReadData
{ 
  /**
   * Read data.
   * @param offset Offset at which to read.
   * @param data Where to place read data
   * @param numBytesRead number of bytes to read
   * @return FAIL if the read request is refused. If the result is SUCCESS, 
   *   the <code>readDone</code> event will be signaled.
   */
  command result_t read(uint32_t offset, uint8_t* buffer, uint32_t numBytesRead);

  /**
   * Signal read completion
   * @param data Address where read data was placed
   * @param numBytesRead Number of bytes read
   * @param success SUCCESS if read was successful, FAIL otherwise
   * @return Ignored.
   */
  event result_t readDone(uint8_t* buffer, uint32_t numBytesRead, result_t success);
}
