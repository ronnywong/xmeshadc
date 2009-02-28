/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * Copyright (c) 2004 by Sensicast, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: InternalEEPROMC.nc,v 1.1.4.1 2007/04/25 23:41:58 njain Exp $
 */

//
// @Author: Michael Newman
//
//
#define InternalEEPROMedit 1
//
// Modification History:
//  22Jan04 MJNewman 1: Created.
/**
 * Provide access to the internal EEPROM.
 *
 * <code>ReadData</code> and <code>WriteData</code> provides
 * straightforward data reading and writing at arbitrary offsets in a flash
 * region. The <code>WriteData</code> interface guarantees that the data
 * has been committed to the flash when the <code>writeDone</code> event
 * completes successfully. 
 *
 * @author Michael Newman
 */
configuration InternalEEPROMC {
  provides {
    interface WriteData;
    interface ReadData;
    interface StdControl;
  }
}
implementation {
  components InternalEEPROMM;

  WriteData = InternalEEPROMM;
  ReadData = InternalEEPROMM;
  StdControl = InternalEEPROMM;
  
}
