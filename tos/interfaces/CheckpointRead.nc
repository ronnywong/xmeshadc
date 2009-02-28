/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CheckpointRead.nc,v 1.1.4.1 2007/04/25 23:20:33 njain Exp $
 */

interface CheckpointRead
{
  /**
   * Read one of the checkpoint data sets. 
   * @param dataSet dataSet to read (from 0 to <code>nDataSets</code> - 1
   * @param data destination buffer for checkpoint data
   * @return FAIL if checkpointer is busy or invalid data set requested,
   *   SUCCESS otherwise
   */
  command result_t read(uint8_t dataSet, uint8_t *data);

  /**
   * Signaled when checkpoint read completes if <code>read</code> returned
   * SUCCESS. 
   * @param success SUCCESS if read successfully completed, FAIL otherwise
   * @param data buffer into which checkpoint data was read
   * @return Ignored.
   */
  event result_t readDone(result_t success, uint8_t *data);
}
