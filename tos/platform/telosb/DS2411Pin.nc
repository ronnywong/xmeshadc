/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: DS2411Pin.nc,v 1.1.4.1 2007/04/26 22:24:08 njain Exp $
 */


//@author Cory Sharp <cssharp@eecs.berkeley.edu>

interface DS2411Pin
{
  command void init();
  command void output_low();
  command void output_high();
  command void prepare_read();
  command uint8_t read(); //zero=0, nonzero=1
}

