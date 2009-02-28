/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: WriteData.nc,v 1.1.4.1 2007/04/25 23:34:01 njain Exp $
 */

/*
 * Authors:		David Gay, Philip Levis, Nelson Lee
 * Date last modified:  8/13/02
 *
 *
 */

/**
 * General interface to write n bytes of data to a particular offset.
 * @author David Gay
 * @author Philip Levis
 * @author Nelson Lee
 */
interface WriteData
{ 
  /**
   * Write data.
   * @param offset Offset at which to write.
   * @param data data to write
   * @param numBytesWrite number of bytes to write
   * @return FAIL if the write request is refused. If the result is SUCCESS, 
   *   the <code>writeDone</code> event will be signaled.
   */
  command result_t write(uint32_t offset, uint8_t *data, uint32_t numBytesWrite);		

  /**
   * Signal write completion
   * @param data Address of data written
   * @param numBytesWrite Number of bytes written
   * @param success SUCCESS if write was successful, FAIL otherwise
   * @return Ignored.
   */
  event result_t writeDone(uint8_t *data, uint32_t numBytesWrite, result_t success);
}
