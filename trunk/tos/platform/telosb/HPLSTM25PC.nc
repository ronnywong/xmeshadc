/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLSTM25PC.nc,v 1.1.4.1 2007/04/26 22:24:58 njain Exp $
 */
 
/*
 * @author: Jonathan Hui <jwhui@cs.berkeley.edu>
 */

includes HALSTM25P;

configuration HPLSTM25PC {
  provides {
    interface StdControl;
    interface HPLSTM25P;
  }
}

implementation {
  components 
    HPLSTM25PM, 
    BusArbitrationC, 
    HPLUSART0M;

  StdControl = HPLSTM25PM;
  HPLSTM25P = HPLSTM25PM;

  HPLSTM25PM.BusArbitration -> BusArbitrationC.BusArbitration[unique("BusArbitration")];
  HPLSTM25PM.USARTControl -> HPLUSART0M;
}
