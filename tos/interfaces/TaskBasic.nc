/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TaskBasic.nc,v 1.1.4.1 2007/04/25 23:31:15 njain Exp $
 */

/**
 * Simplest interface for posting a task to TinyOS scheduler. <p>
 * Provides a bare bones mechanism to transform the asynchronous
 * to the synchronous.
 * 
 * @modified  1/21/03
 *
 * @author Philip Levis
 */

interface TaskBasic {

  /**
   * Submit a task to run. Will cause the corresponding run() to be
   * later called in a synchronous context. Once submit() is called,
   * it should not be called again until run() is signalled.
   *
   * @return SUCCESS: run() will be called in the future, FAIL if
   * it will not be called.
   */
  
  command result_t submit();

  /**
   * Called at an indeterminate point in the future in response to a
   * call to submit().
   *
   */
  event void run();

}

