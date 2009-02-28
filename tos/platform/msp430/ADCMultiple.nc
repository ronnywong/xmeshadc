/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ADCMultiple.nc,v 1.1.4.1 2007/04/26 22:04:27 njain Exp $
 */
 
/*
 * - Revision -------------------------------------------------------------
 * $Revision: 1.1.4.1 $
 * $Date: 2007/04/26 22:04:27 $
 * @author: Jan Hauer <hauer@tkn.tu-berlin.de>
 * ========================================================================
 */
includes ADCHIL;
interface ADCMultiple
{
  /**
    * Initiates a series of, i.e. multiple successive conversions. 
    * The length of a series must match and is only bounded by the 
    * size of the buffer. An event <code>dataReady</code> is signalled
    * when the buffer is filled with conversion results. 
    * Successive conversions are performed as quickly as possible.
    *
    * @param buf Buffer to store the conversion results. Ignored
    * if <code>reserve</code> was called successfully before,
    * because then those settings are applicable.
    *
    * @param length The size of the buffer and number of conversions.
    * Ignored if <code>reserve</code> was called successfully before,
    * because then those settings are applicable.
    *
    * @return ADC_SUCCESS if the ADC is free and available 
    * to accept the request, error code otherwise (see ADCHIL.h).
    */
  async command adcresult_t getData(uint16_t *buf, uint16_t length);

  /**
    * Initiates a series of, i.e. multiple successive conversions,
    * in repeat mode, i.e. continuously.
    * After each series of conversions is performed an event 
    * <code>dataReady</code> is signalled with the conversion results.
    * This continues until the eventhandler returns <code>FAIL</code>.
    *
    * @param buf Buffer to store the conversion results. Ignored
    * if <code>reserveContinuous</code> was called successfully before,
    * because then those settings are applicable.
    *
    * @param length The size of the buffer and number of conversions.
    * Ignored if <code>reserveContinuous</code> was called successfully before,
    * because then those settings are applicable.
    *
    * @return ADC_SUCCESS if the ADC is free and available 
    * to accept the request, error code otherwise (see ADCHIL.h).
    */
  async command adcresult_t getDataContinuous(uint16_t *buf, uint16_t length);
    
  /**
    * Reserves the ADC for a series of conversions.  If this call  
    * succeeds the next call to <code>getData</code> will also succeed 
    * and the first corresponding conversion will then be started with a
    * minimum latency.
    *
    * @return ADC_SUCCESS if reservation was successful,
    * error code otherwise (see ADCHIL.h).
    */
  async command adcresult_t reserve(uint16_t *buf, uint16_t length);
  
  /**
    * Reserves the ADC for a series of conversions in repeat mode. If this call  
    * succeeds the next call to <code>getDataRepeat</code> will also succeed 
    * and the first corresponding conversion will then be started with a
    * minimum latency.
    *
    * @return ADC_SUCCESS if reservation was successful,
    * error code otherwise (see ADCHIL.h).
    */
  async command adcresult_t reserveContinuous(uint16_t *buf, uint16_t length);

  /**
    * Cancels a reservation made by <code>reserve</code> or
    * <code>reserveRepeat</code>.
    *
    * @return ADC_SUCCESS if reservation was cancelled successfully,
    * error code otherwise (see ADCHIL.h).
    */
  async command adcresult_t unreserve();
  
  /**
    * Conversion results from call to <code>getData</code> or 
    * <code>getDataContinuous</code> are ready. In the first case
    * the returned value is ignored, in the second it defines
    * whether any further conversions will be made or not.
    *
    * @param result ADC_SUCCESS if the conversions were performed
    * successfully and the results are valid, error code 
    * otherwise (see ADCHIL.h).
    * @param buf The address of the conversion results, identical 
    * to buf passed to <code>getData</code> or 
    * <code>reserveContinuous</code> .
    * @param length Size of the buffer, identical to length passed to
    * <code>getData</code> or <code>reserveContinuous</code> .
    *
    * @return 0 (nullpointer) stops further conversions in continuous mode,
    * otherwise the pointer points to a buffer of the same length 
    * where the next conversion results are to be stored in continuous mode
    * (ignored if not in continuous mode).
    */
  async event uint16_t* dataReady(adcresult_t result, uint16_t *buf, uint16_t length); 
}

