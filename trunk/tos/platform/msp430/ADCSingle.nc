/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ADCSingle.nc,v 1.1.4.1 2007/04/26 22:04:36 njain Exp $
 */
 
/*
 * - Revision -------------------------------------------------------------
 * $Revision: 1.1.4.1 $
 * $Date: 2007/04/26 22:04:36 $
 * @author: Jan Hauer <hauer@tkn.tu-berlin.de>
 * ========================================================================
 */
includes ADCHIL;
interface ADCSingle
{
  /**
    * Initiates one single conversion. The conversion result
    * is signalled in the event <code>dataReady</code>.
    *
    * @return ADC_SUCCESS if the ADC is free and available 
    * to accept the request, error code otherwise (see ADCHIL.h).
    */
  async command adcresult_t getData();

  /**
    * Initiates conversions in repeat mode, ie. continuously.
    * After each conversion an event <code>dataReady</code>
    * is signalled with the conversion result until 
    * the eventhandler returns <code>FAIL</code>.
    *
    * @return ADC_SUCCESS if the ADC is free and available 
    * to accept the request, error code otherwise (see ADCHIL.h).
    */
  async command adcresult_t getDataContinuous();
    
  /**
    * Reserves the ADC for one single conversion.  If this call  
    * succeeds the next call to <code>getData</code> will also succeed 
    * and the corresponding conversion will then be started with a
    * minimum latency.
    *
    * @return ADC_SUCCESS if reservation was successful,
    * to accept the request, error code otherwise (see ADCHIL.h).
    */
  async command adcresult_t reserve();
  
  /**
    * Reserves the ADC for continuous conversions. If this call  
    * succeeds the next call to <code>getDataContinuous/code> will also succeed 
    * and the corresponding conversion will then be started with a
    * minimum latency.
    *
    * @return ADC_SUCCESS if reservation was successful,
    * error code otherwise (see ADCHIL.h).
    */
  async command adcresult_t reserveContinuous();

  /**
    * Cancels a reservation made by <code>reserve</code> or
    * <code>reserveRepeat</code>.
    *
    * @return ADC_SUCCESS if reservation was cancelled successfully,
    * error code otherwise (see ADCHIL.h).
    */
  async command adcresult_t unreserve();
  
  /**
    * Conversion result from call to <code>getData</code> or 
    * <code>getDataRepeat</code> is ready. In the first case
    * the returned value is ignored, in the second it defines
    * whether any further conversions will be made or not.
    *
    * @param result ADC_SUCCESS if the conversion was performed
    * successfully and <code>data</code> is valid, error 
    * code otherwise (see ADCHIL.h).
    * @param data The conversion result, an uninterpreted 
    * 16-bit value.
    *
    * @return SUCCESS continues conversions in continuous mode,
    * FAIL stops further conversions in continuous mode
    * (ignored if not in continuous mode).
    */
  async event result_t dataReady(adcresult_t result, uint16_t data); 
}

