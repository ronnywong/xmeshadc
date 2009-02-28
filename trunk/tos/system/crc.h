/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: crc.h,v 1.1.4.1 2007/04/27 06:05:55 njain Exp $
 */

/**
 * Default CRC function. Note that avrmote has a much more efficient one. 
 *
 * This CRC-16 function produces a 16-bit running CRC that adheres to the
 * ITU-T CRC standard.
 *
 * The ITU-T polynomial is: G_16(x) = x^16 + x^12 + x^5 + 1
 *
 */

uint16_t crcByte(uint16_t crc, uint8_t b)
{
  uint8_t i;
  
  crc = crc ^ b << 8;
  i = 8;
  do
    if (crc & 0x8000)
      crc = crc << 1 ^ 0x1021;
    else
      crc = crc << 1;
  while (--i);

  return crc;
}
