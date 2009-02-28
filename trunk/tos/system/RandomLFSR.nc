/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RandomLFSR.nc,v 1.1.4.1 2007/04/27 06:02:50 njain Exp $
 */

/*
 *
 * Authors:		Alec Woo, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 * +1 necessary to prevent spinning on zero.
 */

/* This is a 16 bit Linear Feedback Shift Register pseudo random number
   generator */

/**
 * @author Alec Woo
 * @author David Gay
 * @author Philip Levis
 */

module RandomLFSR 
{
  provides interface Random;
}
implementation
{
  uint16_t shiftReg;
  uint16_t initSeed;
  uint16_t mask;

  /* Initialize the seed from the ID of the node */
  async command result_t Random.init() {
    dbg(DBG_BOOT, "RANDOM_LFSR initialized.\n");
    atomic {
      shiftReg = 119 * 119 * (TOS_LOCAL_ADDRESS + 1);
      initSeed = shiftReg;
      mask = 137 * 29 * (TOS_LOCAL_ADDRESS + 1);
    }
    return SUCCESS;
  }

  /* Return the next 16 bit random number */
  async command uint16_t Random.rand() {
    bool endbit;
    uint16_t tmpShiftReg;
    atomic {
      tmpShiftReg = shiftReg;
      endbit = ((tmpShiftReg & 0x8000) != 0);
      tmpShiftReg <<= 1;
      if (endbit) 
	tmpShiftReg ^= 0x100b;
      tmpShiftReg++;
      shiftReg = tmpShiftReg;
      tmpShiftReg = tmpShiftReg ^ mask;
    }
    return tmpShiftReg;
  }
  
  uint16_t TOSH_rand() __attribute__((C)) {
    return call Random.rand();
  }
}
