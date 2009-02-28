/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: LogData.nc,v 1.1.4.1 2007/04/25 23:25:09 njain Exp $
 */
 
/*
 * Authors:		David Gay
 * Date last modified:  7/15/03
 *
 */

/** 
 * This interface is used to provide efficient, byte level logging to
 * a region of memory/flash/etc (the actual region is specified through
 * some other mechanism, e.g., in ByteEEPROM by providing a parameterised
 * LogData interface). Unlike the WriteData interface, the data written
 * via append is only guaranteed to be present in the region once sync
 * has completed.
 *
 * Note: this interface is purposefully restrictive to allow logging to
 * be as fast as possible. Calls to LogData must not be interspersed
 * with calls to WriteData on the same area of memory/flash/etc
 * (ReadData is fine). WriteData can be called after syncDone returns.
 * This interface is currently used by ByteEEPROM
 * @author David Gay
 */

interface LogData
{
  /** Erase region, reset append pointer to beginning of region
   * @return FAIL if erase request was refused. Otherwise SUCCESS
   *   is returned and <code>eraseDone</code> will be signaled.
   */
  command result_t erase();

  /**
   * Report erase completion.
   * @param success FAIL if erase failed, in which case appends are not allowed.
   * @return Ignored.
   */
  event result_t eraseDone(result_t success);

  /** Append bytes to region (erase must be called first)

   * @return FAIL if appends are not allowed (erase failed or sync has been
   * called). If the result is SUCCESS, <code>appendDone</code> will be signaled.
   */
  command result_t append(uint8_t* data, uint32_t numBytes);

  /**
   * Report append completion.
   * @param data Address of data written
   * @param numBytesWrite Number of bytes written
   * @param success SUCCESS if write was successful, FAIL otherwise
   * @return Ignored.
   */
  event result_t appendDone(uint8_t* data, uint32_t numBytes, result_t success);

  /**
   * Report current append offset.
   * @return the current append offset, or (uint32_t)-1
      if appends are not allowed (after sync or before erase)
   */
  command uint32_t currentOffset();

  /** 
   * Ensure all data written by append is committed to flash.
   * Once sync is called, no more appends are allowed.
   * @return FAIL if sync request is refused. If the result is SUCCESS
   * the <code>syncDone</code> event will be signaled.
   */
  command result_t sync();

  /**
   * Report sync completion.
   * @param success FAIL if sync failed, SUCCESS otherwise.
   * @return Ignored.
   */
  event result_t syncDone(result_t success);
}
