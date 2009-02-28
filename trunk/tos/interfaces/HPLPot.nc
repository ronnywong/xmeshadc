/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLPot.nc,v 1.1.4.1 2007/04/25 23:23:04 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 *
 */

/**
 * Interface to a variable potentiometer. Calls to
 * <code>increase</code> and <code>decrease</code> must be actualized
 * with a call to <code>finalise</code>
 *
 * <p>Because this is a direct hardware interface, it does not
 * maintain state; checks for potentiometer bounds must be performed
 * by a higher-level interface.
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */

interface HPLPot
{
  /**
   * Decrease the resistance by one unit.
   *
   * @return SUCCESS always.
   */
  
  command result_t decrease();

  /**
   * Increase the resistance by one unit.
   *
   * @return SUCCESS always.
   */
  
  command result_t increase();

  /**
   * Finalize the adjusted value.
   *
   * @return SUCCESS always.
   */
  command result_t finalise();
}
