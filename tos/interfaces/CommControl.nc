/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CommControl.nc,v 1.1.4.1 2007/04/25 23:21:07 njain Exp $
 */
 
/*
 * Authors:		Matt Welsh
 * Date last modified:  9/29/02
 */

/**
 * This interface defines commands for controlling aspects of the 
 * communication layer.
 * @author Matt Welsh
 */
interface CommControl 
{ 
  /** 
   * Set the value of the CRC check flag.
   * If set to 'true', received packets with a CRC field other than '1'
   * are dropped.
   * @return SUCCESS if the CRC check value could be set; FAIL otherwise
   *   (for example, if CRC check is not implemented).
   */
  command result_t setCRCCheck(bool value);

  /**
   * Return the current value of the CRC check flag.
   */
  command bool getCRCCheck();

  /** 
   * Set the value of the promiscuous mode flag.
   * If set to 'true', all received packets are passed to the receiver.
   * If set to 'false', only packets destined for this node (or sent to
   * the broadcast address) are passed up.
   * @return SUCCESS if the promiscuous flag could be set; FAIL otherwise
   *   (for example, if promiscuous mode is not implemented).
   */
  command result_t setPromiscuous(bool value);

  /**
   * Return the current value of the promiscuous mode flag.
   */
  command bool getPromiscuous();
}
