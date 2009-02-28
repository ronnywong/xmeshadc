/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: DS2411.nc,v 1.1.4.1 2007/04/26 22:23:40 njain Exp $
 */


//@author Cory Sharp <cssharp@eecs.berkeley.edu>

interface DS2411
{
  command result_t init();

  command void copy_id( uint8_t* id ); // 6 bytes
  command uint8_t get_id_byte( uint8_t index );

  command uint8_t get_family();

  command uint8_t get_crc();
  command bool is_crc_okay();
}

