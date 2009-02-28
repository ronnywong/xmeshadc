/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Clock.nc,v 1.1.4.1 2007/04/25 23:20:58 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, David Gay, Philip Levis, Nelson Lee
 * Date last modified:  6/25/02
 *
 *
 */



/**
 * The hardware clock interface. 
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 * @author Nelson Lee
 **/
includes Clock;

interface Clock {

  /**
   *  Set the clock rate.  For the specific meanings of interval
   * and scale, refer to the processor data sheet. For the mica and rene:
   * <p>
   * <pre>
   *     Clock scale
   *         0 - off
   *         1 - 32768 ticks/second
   *         2 - 4096 ticks/second
   *         3 - 1024 ticks/second
   *         4 - 512 ticks/second
   *         5 - 256 ticks/second
   *         6 - 128 ticks/second
   *         7 - 32 ticks/second
   * </pre>
   * <p>
   *
   * Interval is how many ticks per clock firing.
   * For example, setRate(160,7) will result in an event every 160/32
   * seconds.
   *
   * See also: <code>Clock.h</code> for predefined macros:
   *
   * <p>
   * <pre>
   *  interval      scale         result
   *  TOS_I1000PS   TOS_S1000PS   1000 ticks/sec
   *  TOS_I100PS    TOS_S100PS     100 ticks/sec
   *  TOS_I10PS     TOS_S10PS       10 ticks/sec
   *  TOS_I4096PS   TOS_S4096PS   4096 ticks/sec
   *  TOS_I2048PS   TOS_S2048PS   2048 ticks/sec
   *  TOS_I1024PS   TOS_S1024PS   1024 ticks/sec
   *  TOS_I512PS    TOS_S512PS     512 ticks/sec
   *  TOS_I256PS    TOS_S256PS     256 ticks/sec
   *  TOS_I128PS    TOS_S128PS     128 ticks/sec
   *  TOS_I64PS     TOS_S64PS       64 ticks/sec
   *  TOS_I32PS     TOS_S32PS       32 ticks/sec
   *  TOS_I16PS     TOS_S16PS       16 ticks/sec
   *  TOS_I8PS      TOS_S8PS         8 ticks/sec
   *  TOS_I4PS      TOS_S4PS         4 ticks/sec
   *  TOS_I2PS      TOS_S2PS         2 ticks/sec
   *  TOS_I1PS      TOS_S1PS         1 tick/sec
   *  TOS_I0PS      TOS_S0PS         0 ticks/sec (clock off)
   * </pre>
   **/
  async command result_t setRate(char interval, char scale);

  /**
   *  Set clock interval 
   * 
   *  @param value New clock interval
   *
   *  @return none
   **/
  async command void setInterval(uint8_t value);

  /**
   *  Set clock interval at next clock interrupt time
   * 
   *  @param value New clock interval
   *
   *  @return none
   **/
  async command void setNextInterval(uint8_t value);

  /**
   *  Get clock interval 
   * 
   *  @return current clock interval
   **/
  async command uint8_t getInterval();

  /**
   *  Get clock scale 
   * 
   *  @return current clock scale level
   **/  
  async command uint8_t getScale();

  /**
   *  Set clock scale at next clock interrupt time 
   * 
   *  @param scale New clock scale
   *
   *  @return none
   **/
  async command void setNextScale(uint8_t scale);

  /**
   *  Set both clock interval and scale
   * 
   *  @param interval New clock interval
   *
   *  @param scale New clock scale
   *
   *  @return SUCCESS or FAILED 
   **/
  async command result_t setIntervalAndScale(uint8_t interval, uint8_t scale);

  /**
   *  Read HW clock counter
   */
  async command uint8_t readCounter() ;

  /**
   *  Set HW clock counter to a specified value
   *
   *  @param n Value to write to TCNT0
   *
   *  @return None
   */
  async command void setCounter(uint8_t n);


  /**
   *  Disable Clock interrupt
   */
  async command void intDisable();


  /**
   *  Enable Clock interrupt
   */
  async command void intEnable() ;


  /**
   *  An event sent when the clock goes off.
   **/
  async event result_t fire();
}










