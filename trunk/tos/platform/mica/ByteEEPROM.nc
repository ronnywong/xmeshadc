/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ByteEEPROM.nc,v 1.1.4.1 2007/04/26 00:22:37 njain Exp $
 */
 
/*
 * Authors:		Nelson Lee, David Gay
 * Date last modified:  7/17/03
 */
/**
 * Provide access to, and sharing of, the mote flash
 * chip. <code>ByteEEPROM</code> does not interact properly with the
 * (deprecated) <code>Logger</code> component.
 *
 * The flash chip is shared by giving each user a separate "region" of the
 * flash. These regions are identified by the parameter to the
 * <code>AllocationReq</code>, <code>WriteData</code>,
 * <code>ReadData</code> and <code>LogData</code> parameterised
 * interfaces. A user of byte eeprom should define a constant with 
 * enum { MY_FLASH_REGION_ID = unique("ByteEEPROM") }; 
 * in some .h file, and use <code>MY_FLASH_REGION_ID</code> when wiring
 * interfaces to <code>ByteEEPROM</code>.
 *
 * Flash regions must be allocated via the <code>AllocationReq</code>
 * interface.  All allocation requests must be made at mote initialisation
 * time (in <code>StdControl.init</code> commands). Later allocation
 * requests will be refused.
 *
 * <code>ReadData</code> and <code>WriteData</code> provides
 * straightforward data reading and writing at arbitrary offsets in a flash
 * region. The <code>WriteData</code> interface guarantees that the data
 * has been committed to the flash when the <code>writeDone</code> event
 * completes successfully. As this has high overhead (both in time and
 * power), the alternative <code>LogData</code> interface is provided for
 * high-speed, low-overhead data logging.
 *
 * The <code>BufferedLog</code> component can be used in conjunction with
 * <code>ByteEEPROM</code> to provide even lower logging overhead at the cost
 * of extra RAM buffers. The <code>HighFrequencySampling</code> application
 * is an example of all this.
 * @author Nelson Lee
 * @author David Gay
 */
configuration ByteEEPROM {
  provides {
    interface AllocationReq[uint8_t id];
    interface WriteData[uint8_t id];
    interface LogData[uint8_t id];
    interface ReadData[uint8_t id];
    interface StdControl;
  }
}
implementation {
  components PageEEPROMC, ByteEEPROMC, ByteEEPROMAllocate;

  AllocationReq = ByteEEPROMAllocate;
  WriteData = ByteEEPROMC;
  LogData = ByteEEPROMC;
  ReadData = ByteEEPROMC;
  StdControl = ByteEEPROMAllocate;
  StdControl = PageEEPROMC;
  
  ByteEEPROMC.PageEEPROM -> PageEEPROMC.PageEEPROM[unique("PageEEPROM")];
  ByteEEPROMC.getRegion -> ByteEEPROMAllocate;
}









