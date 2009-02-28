/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CheckpointWrite.nc,v 1.1.4.1 2007/04/25 23:20:42 njain Exp $
 */

interface CheckpointWrite
{
  /**
   * Write one of the checkpoint data sets. 
   * @param dataSet dataSet to write (from 0 to <code>nDataSets</code> - 1
   * @param data buffer with data to checkpoint
   * @return FAIL if checkpointer is busy or invalid data set specified,
   *   SUCCESS otherwise
   */
  command result_t write(uint8_t dataSet, uint8_t *data);

  /**
   * Signaled when checkpoint write completes if <code>write</code> returned
   * SUCCESS. 
   * @param success SUCCESS if write successfully completed, FAIL otherwise
   * @param data buffer which was checkpointed
   * @return Ignored.
   */
  event result_t writeDone(result_t success, uint8_t *data);
}
