/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: StdControl.nc,v 1.1.4.1 2007/04/27 05:05:51 njain Exp $
 */


/**
 * The TinyOS standard control interface. All components that require
 * initialization or can be powered down should provide this
 * interface. start() and stop() are synonymous with powering on and
 * off, when appropriate.
 *
 * On boot, the init() of all wired components must be called. init()
 * may be called multiple times, and in subcomponents before some of
 * their supercomponents (e.g. if they are the subcomponent of
 * multiple components). After init() has been called, start() and
 * stop() may be called multiple times, in any order. The call
 * sequence is therefore:
 *
 * <p>init* (start|stop)*</p>
 *
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 * @modified  6/25/02
 *
 *
 */


interface StdControl
{
  /**
   * Initialize the component and its subcomponents.
   *
   * @return Whether initialization was successful.
   */
  command result_t init();

  /**
   * Start the component and its subcomponents.
   *
   * @return Whether starting was successful.
   */
  command result_t start();

  /**
   * Stop the component and pertinent subcomponents (not all
   * subcomponents may be turned off due to wakeup timers, etc.).
   *
   * @return Whether stopping was successful.
   */
  command result_t stop();
}
