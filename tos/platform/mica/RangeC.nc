/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RangeC.nc,v 1.1.4.1 2007/04/26 00:26:48 njain Exp $
 */

/* Authors:  David Gay  <dgay@intel-research.net>
 *           Intel Research Berkeley Lab
 *
 */

/**
 * @author David Gay <dgay@intel-research.net>
 * @author Intel Research Berkeley Lab
 */

configuration RangeC {
  provides interface Range;
}
implementation
{
  components RangeM, PotC;

  Range = RangeM;
  RangeM.Pot -> PotC;
}
