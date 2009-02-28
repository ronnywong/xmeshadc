/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: BlockCipherInfo.nc,v 1.1.4.1 2007/04/25 23:19:18 njain Exp $
 */

/* Authors: Naveen Sastry
 * Date:    9/26/02
 */

/**
 * @author Naveen Sastry
 */


includes crypto;
interface BlockCipherInfo
{

  /**
   * Returns the preferred block size that this cipher operates with. 
   *
   * @return the preferred block size for this cipher. In the case where the
   *         cipher operates with multiple block sizes, this will pick one
   *         particular size (deterministically).
   */
  async command uint8_t getPreferredBlockSize();
  
}

