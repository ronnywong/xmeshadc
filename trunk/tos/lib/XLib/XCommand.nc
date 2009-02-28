/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XCommand.nc,v 1.2.4.1 2007/04/25 23:42:48 njain Exp $
 */

/**
 * Provides a library module for handling basic application messages for
 * controlling a wireless sensor network.
 * 
 * @file      XCommand.nc
 * @author    Martin Turon
 * @version   2004/10/1    mturon      Initial version
 *
 * Summary of XSensor commands:
 *      reset, sleep, wakeup
 *  	set/get (rate) "heartbeat"
 *  	set/get (nodeid, group)
 *  	set/get (radio freq, band, power)
 *  	actuate (device, state)
 *  	set/get (calibration)
 *  	set/get (mesh type, max resend)
 */

includes XCommand;

/**
 * This interface defines callback routines for command messages 
 * received by the mote.  All commands are sent to the application 
 * for handling.
 *
 * @return SUCCESS if application can handle the request; FAIL otherwise
 *
 * @author Martin Turon
 */
interface XCommand
{ 
  /** All commands that are received send this handler */


  event result_t received(XCommandOp *op);

}
