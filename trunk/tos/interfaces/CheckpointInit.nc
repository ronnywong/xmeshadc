/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CheckpointInit.nc,v 1.1.4.1 2007/04/25 23:20:25 njain Exp $
 */
 
interface CheckpointInit
{
  /**
   * Initialise the checkpointer for checkpoint state. <code>initialised</code>
   * is signaled when initialisation is complete.
   *
   * @param eepromBase The EEPROM line from which the checkpoint state is 
   * stored.
   *
   * @param dataLength The size of data to be checkpointed.
   *
   * @param nDataSets The number of different data sets (all of the same
   * length) which you want to checkpoint. The maximum number is 16 (the
   * EEPROM line size). 
   * 
   * The EEPROM storage requirements are (in EEPROM lines):
   * <p> (<code>nDataSets</code) + 1) * dlines + 4
   * <p>where dlines = (<code>datalength</code> + 15) / 16
   *
   * @return FAIL if the checkpointer cannot be initialised, SUCCESS otherwise
   */
  command result_t init(uint16_t eepromBase, uint16_t dataLength,
			uint8_t nDataSets);

  /**
   * Signaled when the checkpointer is initialised if <code>init</code> 
   * returnd SUCESS.
   * @param cleared TRUE if no valid checkpoint state was found based
   * on the parameters passed to <code>init</code>.
   * @return Ignored.
   */
  event result_t initialised(bool cleared);
}
