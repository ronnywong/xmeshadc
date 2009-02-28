/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: I2CPot.nc,v 1.1.4.1 2007/04/25 23:24:10 njain Exp $
 */
 
interface I2CPot
{
  command result_t writePot(char addr, char pot, char data);
  command result_t readPot(char addr, char pot);  
  event result_t readPotDone(char data, bool result);
  event result_t writePotDone(bool result);
}
