/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: AllocationReq.nc,v 1.1.4.1 2007/04/25 23:18:12 njain Exp $
 */
 
/*
 * Authors:		Nelson Lee, David Gay
 * Date last modified:  8/13/02
 *
 *
 */

/**
 * This interface is used as a two-phase allocation protocol for
 * ByteEEPROM. Applications that require memory from the flash call request or
 * requestAddr in their <code>StdControl.init</code> command. They later get a
 * <code>requestProcessed</code> event back reporting success or failure of
 * the allocation.
 * @author Nelson Lee
 * @author David Gay
 */

interface AllocationReq
{
  /**
   * Request a <code>numBytesReq</code> byte section of the flash. This request
   * must be made at initilisation time (at the same time as ByteEEPROM is
   * initialised)
   * @param numBytesReq Number of bytes required
   * @return FAIL for invalid arguments, or if the flash has already been
   *   allocated. <code>requestProcessed</code> will be signaled if SUCCESS
   *   is returned.
   */
  command result_t request(uint32_t numBytesReq);

  /**
   * Request a specific section of the flash. This request must be made at
   * initilisation time (at the same time as ByteEEPROM is initialised)
   * @param byteAddr The starting byte offset. This must be on a page boundary
   * (the <code>TOS_BYTEEEPROM_PAGESIZE</code> constant gives the page size)
   * @param numBytesReq Number of bytes required 
   * @return FAIL for invalid arguments, or if the flash has already been
   *   allocated. <code>requestProcessed</code> will be signaled if SUCCESS
   *   is returned.
   */
  command result_t requestAddr(uint32_t byteAddr, uint32_t numBytesReq);

  /**
   * Signal result of a flash allocation request.
   * @param success SUCCESS if the requested flash section was allocated.
   * @return Ignored.
   */
  event result_t requestProcessed(result_t success);
}




