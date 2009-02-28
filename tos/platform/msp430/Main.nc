/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Main.nc,v 1.1.4.1 2007/04/26 22:12:57 njain Exp $
 */

/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  $Id: Main.nc,v 1.1.4.1 2007/04/26 22:12:57 njain Exp $
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


configuration Main
{
  uses interface StdControl;
}
implementation
{
  components MainM, HPLInitC;

  StdControl = MainM.StdControl;
  MainM.hardwareInit -> HPLInitC;
}

