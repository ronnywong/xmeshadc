/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RefVolt.nc,v 1.1.4.1 2007/04/26 22:13:34 njain Exp $
 */
 
/*
 * - Description ----------------------------------------------------------
 * Interface for reference voltage generator.
 * This interface will be used as a parameterized - it treats the 
 * reference voltage generator like a semaphore: Components can
 * request that they need the generator be switched on at a certain  
 * voltage level (1.5V or 2.5V). Once a level has been set
 * (signalled by an event) these settings remain fixed until every 
 * component that has successfully requested these settings has released  
 * them. This implies that every component that called
 * the <code>get</code> must call <code>release</code> 
 * after it is done.
 * - Revision -------------------------------------------------------------
 * $Revision: 1.1.4.1 $
 * $Date: 2007/04/26 22:13:34 $
 * @author: Jan Hauer (hauer@tkn.tu-berlin.de)
 * ========================================================================
 */
includes  RefVolt;

interface RefVolt
{ 
  /**
   * This command is similar to the P operation on semaphores:
   * If successful the reference voltage generator will be set to
   * the settings in <code>vref</code>. These settings can
   * not be changed, until <code>release</code> has been called, ie.
   * any further call to <code>get</code> with <b>different</b> 
   * <code>vref</code> will fail.
   * Note that a SUCCESS as return value does NOT imply that 
   * vref is stable (the initial switching time is 17ms). 
   * However after a change of vref the event
   * <code>isStable</code> will be signalled (only once).
   * Implementation-Example:  
   *           ...
   *           if (call RefVolt.get(REFERENCE_2_5V) == SUCCESS){
   *             if (call RefVolt.getState() == REFERENCE_2_5V){
   *                continueWithStableVref();
   *                return;
   *             } else
   *                return; // we will get the event isStable
   *           } else {
   *           ... we failed ...
   *           }
   *
   *         event void RefVolt.isStable(RefVolt_t vref){
   *           // maybe also check some global state if we are ready
   *           if (vref == REFERENCE_STABLE_2_5V) continueWithStableVref();
   *         }
   *
   *         void continueWithStableVref(){ // remember to call RefVolt.release! }
   *         
   *
   * @param REFERENCE_1_5V set vref to 1.5 V
   *        REFERENCE_2_5V set vref to 2.5 V
   *
   * @return SUCCESS if command was accepted, use <code>getState</code>
   *                 to find out if vref is stable. Always call 
   *                 <code>release</code> after you dont need vref anymore.
   *         FAIL if reference voltage generator is 
   *              already in use at a different voltage level or
   *              ADC is busy doing a conversion (during that time
   *              the reference voltage generator may not be switched
   *              on).
   */
  async command result_t get(RefVolt_t vref);
  
  /**
   * This command is similar to the V operation on semaphores:
   * It turns the reference voltage generator off, if it is not needed
   * by any other component that previously <code>get</code>d it.
   * It will not be turned off immediately, but with a delay specified
   * in RefVolt.h, to avoid 17 ms startup time if components frequenty need
   * to use VREF.
   * (If there were n successful calls to <code>get</code>  
   * there must be n calls to <code>release</code> to actually 
   * switch the reference voltage generator off).
   *
   * @return FAIL if the semaphore-counter is 0 already !
   *         SUCCESS else
   */
  async command result_t release();
  
  /**
   * State of reference voltage generator.
   *
   * @return REFERENCE_1_5V if vref is 1.5 V (stable)
   *         REFERENCE_2_5V if vref is 2.5 V (stable)
   *         UNSTABLE if reference voltage generator is off or vref is unstable.
   */
  async command RefVolt_t getState();

  /*
   * After this event has been signalled, reference voltage generator
   * is stable at a new state.
   *
   * @param REFERENCE_1_5V if vref is 1.5 V (stable)
   *        REFERENCE_2_5V if vref is 2.5 V (stable)
   */
  event void isStable(RefVolt_t vref);
}

