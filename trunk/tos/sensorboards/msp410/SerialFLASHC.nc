/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SerialFLASHC.nc,v 1.1.4.1 2007/04/27 05:29:05 njain Exp $
 */

/*								
 *
 *
 * Authors:		Mike Grimmer
 * Date last modified:  3/6/03
 *
 */

configuration SerialFLASHC
{
  provides interface SerialFLASH;
}
implementation
{
  components SerialFLASHM;

  SerialFLASH = SerialFLASHM;
}
