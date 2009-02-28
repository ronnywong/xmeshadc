/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004 SenseTech Software
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Interrupt.nc,v 1.1.4.1 2007/04/25 23:24:52 njain Exp $
 */
 
/******************************************************************************
 *
 *	Mobile Pipeline Intrusion Detection System (MPIDS)
 *
 *	Authors:	Tim Reilly
 *
 *****************************************************************************/
 
/**
 * Sensor device interrupt control Interface
 * 
 * @modified  8/18/04
 *
 * @author Tim Reilly
 */
interface Interrupt 
{
  /**
   * Enable sensor device interrupt
   *
   * @return SUCCESS
   */
	command result_t enable();
  /**
   * Disable sensor device interrupt
   *
   * @return SUCCESS
   */
	command result_t disable();

 
}
