/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SplitControl.nc,v 1.1.4.1 2007/04/25 23:30:50 njain Exp $
 */

/* Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 *
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
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */

interface SplitControl
{
  /**
   * Initialize the component and its subcomponents.
   *
   * @return Whether initialization was successful.
   */
  command result_t init();

    /** 
     * Notify components that the component has been init
     *
     */
    event result_t initDone();

  /**
   * Start the component and its subcomponents.
   *
   * @return Whether starting was successful.
   */
  command result_t start();

    /** 
     * Notify components that the component has been started and is ready to
     * receive other commands
     *
     */

    event result_t startDone();

  /**
   * Stop the component and pertinent subcomponents (not all
   * subcomponents may be turned off due to wakeup timers, etc.).
   *
   * @return Whether stopping was successful.
   */
  command result_t stop();

    /**
     * Notify components that the component has been stopped. 
     */

    event result_t stopDone();
}
