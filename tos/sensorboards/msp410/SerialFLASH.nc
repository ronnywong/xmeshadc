/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SerialFLASH.nc,v 1.1.4.1 2007/04/27 05:28:57 njain Exp $
 */


interface SerialFLASH
{
  command result_t check_flash();
  command result_t write_flash_block(char *buf);
  command result_t read_flash_block(char *buf);
}

