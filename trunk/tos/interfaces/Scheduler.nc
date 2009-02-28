/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Scheduler.nc,v 1.1.4.1 2007/04/25 23:29:43 njain Exp $
 */
 
/**
 * Simplest interface to a TinyOS scheduler. <p>
 * 
 * @modified  1/20/03
 *
 * @author Philip Levis
 */

interface Scheduler {

  command result_t init();
  /**
   * Run a single task. If the queue is empty (no task is run),
   * return false. If a task is run, return true.
   */
  command bool run();
}

