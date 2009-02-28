/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430I2CPacket.nc,v 1.1.4.1 2007/04/26 22:10:42 njain Exp $
 */

interface MSP430I2CPacket {
  command result_t readPacket(uint16_t _addr, uint8_t _length, uint8_t* _data);
  command result_t writePacket(uint16_t _addr, uint8_t _length, uint8_t* _data);

  event void readPacketDone(uint16_t addr, uint8_t length, uint8_t* data, result_t success);
  event void writePacketDone(uint16_t addr, uint8_t length, uint8_t* data, result_t success);
}
