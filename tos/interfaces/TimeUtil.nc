/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TimeUtil.nc,v 1.1.4.1 2007/04/25 23:32:13 njain Exp $
 */

/*
 * Authors:		Su Ping  <sping@intel-research.net>
 *
 */

/**
 * The  TimeUtil interface provides utility commands for handling logical time
 * or other 64 bits intergers in Mica platform. 
 * @author Su Ping <sping@intel-research.net>
 */
includes TosTime;
interface TimeUtil {

  /**
   *  Add a signed 32 bits integer  to a logical time
   *
   * @param a  Logical Time
   *
   * @Param x  A 32 bit integer. If it represent a time, the unit
   *           should be binary milliseconds
   * @return   The new time in tos_time_t format.
   */
  async command tos_time_t addint32( tos_time_t a , int32_t x);

  /** 
   *  Add a unsigned 32 bits integer  to a logical time   
   *  
   * @param a  Logical Time
   *
   * @Param x  A unsigned 32 bit integer. If it represent a time, the unit 
   *           should be binary milliseconds
   * @return   The difference in tos_time_t format.
   */
  async command tos_time_t addUint32( tos_time_t a , uint32_t x);

  /**
   *  Subtract a unsigned 32 bits integer  from a logical time
   *
   * @param a  Logical Time
   *
   * @Param x  A unsigned 32 bit integer. If it represent a time, the unit
   *           should be binary milliseconds
   * @return   The result in tos_time_t format.
   */
  async command  tos_time_t subtractUint32( tos_time_t a, uint32_t x);

  /**
   *  Compare logical time a and b. 
   *  If a>b return 1, if a=b return 0 if a<b return -1
   */
  async command char compare(tos_time_t a,  tos_time_t b);

  /**
   *  Add logical time a and b return the sum
   */
  async command tos_time_t add( tos_time_t a, tos_time_t b);

  /**
   * Subtract logical time b from a, return the difference
   */
  async command tos_time_t subtract( tos_time_t a, tos_time_t b);

  /** 
   * Create a logical time from two unsigned 32 bits integer
   *
   * @param timeH represent the high 32 bits of a logical time
   *
   * @param timeL low 32 bits of a logical time
   *
   * @return The created logical time
   */ 
  async command tos_time_t create(uint32_t timeH, uint32_t timeL);
  
  /**
   * Extract higher 32 bits from a given logical time
   *
   * @param a logical time
   *
   * @return The higher 32 bits of logical time a
   */
  async command uint32_t high32(tos_time_t a);

  /**
   * Extract Lower 32 bits from a given logical time
   *
   * @param a logical time
   *
   * @return The lower 32 bits of logical time a
   */
  async command uint32_t low32(tos_time_t a);

}










