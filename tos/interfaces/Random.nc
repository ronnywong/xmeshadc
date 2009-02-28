/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Random.nc,v 1.1.4.1 2007/04/25 23:28:12 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, David Gay, Philip Levis, Alec Woo
 * Date last modified:  6/25/02
 */

/**
 * This is the interface to a simple pseudorandom number generator.  Currently
 * this interface is implemented by the RandomLFSR, which uses a linear
 * feedback shift register to generate the sequence and mote address to
 * initialize the register.
 *
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 * @author Alec Woo
 * @modified 6/25/02
 */

interface Random
{
    /**
     * Initialize the random number generator
     * @return Returns SUCCESS if the initialization is successful, or FAIL if
     * the initialization failed.  For the currently existing implementations
     * there is no known faliure modes.
     */
  async command result_t init();

    /** 
     * Produces a 16-bit pseudorandom number. 
     * @return Returns a 16-bit pseudorandom number.
     */
  async command uint16_t rand();
}

    
