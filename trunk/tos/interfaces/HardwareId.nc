/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HardwareId.nc,v 1.1.4.1 2007/04/25 23:23:29 njain Exp $
 */
 
/**
 * Interface to read hardware identification number
 */
/* The HardwareId.h file is platform-specific (possibly different hardware
   id lengths) */
includes HardwareId;
interface HardwareId {
  /**
   * Start a hardware id read
   * @param id Buffer (HARDWARE_ID_LEN bytes) to hold hardware id
   * @return SUCCESS if request begun, FAIL otherwise
   */
  command result_t read(uint8_t *id);
  
  /**
   * Signal completion of hardware id read (signaled only if <code>read</code>
   * returned SUCCESS).
   * @param id Buffer passed to corresponding <code>read</code> request
   * @param success SUCCESS if hardware id read successful, FAIL otherwise
   * @return Ignored.
   */
  event result_t readDone(uint8_t *id, result_t success);
}
