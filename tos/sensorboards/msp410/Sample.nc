/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004 SenseTech Software / Crossbow Technology Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Sample.nc,v 1.1.4.1 2007/04/27 05:28:49 njain Exp $
 */
 
/******************************************************************************
 *
 *	Mobile Pipeline Intrusion Detection System (MPIDS)
 *
 *	Authors:	Tim Reilly
 *
 *****************************************************************************/
 
/**
 * Sensor sampling Interface
 * 
 * @modified  8/18/04
 *
 * @author Tim Reilly
 */
interface Sample 
{
  /**
   * Sample sensor ASAP
   *
   * @return SUCCESS
   */
	command result_t sampleNow();
}
