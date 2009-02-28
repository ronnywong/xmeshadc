/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * Copyright (c) 2003 by Sensicast, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PhotoM.nc,v 1.1.2.2 2007/04/26 20:04:52 njain Exp $
 */
 
#define PhotoMedit 3
/*
 * Modification History:
 *  11Nov03 MJNewman 3: TinyOS 1.1 atomic updates.
 *  20Oct03 MJNewman 2:	Redo copyright and initial comments.
 *   7May03 MJNewman 1:	Add proper delays when sensor is switched.
 *			It is important to wait about 10ms from
 *			starting a sensor to reading data from the
 *			sensor.
 *   7May03 MJNewman 1:	Created.
 *
 * This module is a rewrite of the PhotoM.nc module written by
 * Jason Hill, David Gay and Philip Levis. This module solves
 * fundamental sampling problems in their module having to do with
 * waiting for logic to settle when changing between the photo and
 * temperature sensors.
 * 
 * ISSUE: Continuous data in ADCC is supposed to sample at some rate
 * controlled by ADCControl.setSamplingRate. The original Photo
 * example does not appear to do this. No support has been added. The
 * implementation of getContinuousData in the current code will sample
 * as fast as it can. When both Photo and Temp samples are requested
 * they will alternate producing one sample every 10 ms.
 */

// OS component abstraction of the analog photo sensor and temperature
// sensor with associated A/D support. This code provides an
// asynchronous interface to the photo and temperature sensors. One
// TimerC timer is used, certain forms of clock use are not compatible
// with using a timer. (i.e. the ClockC component)
//
// It is important to note that the temperature and photo sensors share
// hardware and can not be used at the same time. Proper delays are
// implemented here. Using ExternalXxxADC.getData will initiate the
// appropriate delays prior to sampling data. getData for temperature
// and light may both be invoked in any order and at any time. A
// correct sample will be signalled by the corresponding dataReady.
//
// Photo and Temp provide the same interfaces. Exposed interfaces are
// ExternalPhotoADC and ExternalPhotoADC as well as PhotoStdControl and
// PhotoStdControl. The following routines are the public interface:
//
// xxxStdControl.init	initializes the device
// xxxADC.start		starts a particular sensor
// xxxADC.stop		stops a particular sensor, this will also stop
//			any getContinuousData on that sensor.
// xxxADC.getData	reads data from a sensor. This may be called in
//			any order. A dataReady event is signalled
//			when the data is ready. Temperature and Photo
//			will wait for each other as needed.
// xxxADC.getContinuousData	reads data from a sensor and when the
//			read completes triggers an additional getData.
//			Continuous data from both sensors will work but
//			a 10 ms delay will occur between each sample.
//			Continuous data from a single sensor will run
//			at a higher sampling rate.
//
// A timer from TimerC is used to manage the delays required between
// setting up the hardware and reading the data.

//includes sensorboard;

module PhotoM 
{
    provides interface StdControl as PhotoStdControl;
    provides interface ADC as ExternalPhotoADC;
    uses 
    {
    	interface ADCControl;
    	interface ADC as InternalPhotoADC;
    	interface StdControl as TimerControl;
    	interface Timer as PhotoTimer;
    }
}

implementation 
{

    // Logs what the hardware is set up to do.
    enum {
    	sensorIdle = 0,
    	sensorPhotoStarting,
    	sensorPhotoReady,
    	sensorTempStarting,
    	sensorTempReady,
    } hardwareStatus;

    // Logs what a particular sensor is trying to do. When a single
    // read completes the value reverts to idle.
    typedef enum {
    	stateIdle = 0,
    	stateReadOnce,
    	stateContinuous,
    } SensorState_t;

    SensorState_t photoSensor;
    SensorState_t tempSensor;

    // TRUE when waiting for a sample to be read and another sample can
    // not start. getSample will always be triggered again when this is
    // true.
    bool waitingForSample;

    command result_t PhotoStdControl.init() 
    {
    	call ADCControl.bindPort(TOS_ADC_PHOTO_PORT, TOSH_ACTUAL_PHOTO_PORT);
    	call TimerControl.init();
    	atomic photoSensor = stateIdle;
    	dbg(DBG_BOOT, "TEMP initialized.\n");    
    	return call ADCControl.init();
    }

    command result_t PhotoStdControl.start() 
    {
    	atomic photoSensor = stateIdle;
    	TOSH_SET_PHOTO_CTL_PIN();
    	return SUCCESS;
    }

    command result_t PhotoStdControl.stop() 
    {
    	atomic photoSensor = stateIdle;
    	TOSH_CLR_PHOTO_CTL_PIN();
    	return SUCCESS;
    }

    // Gets the next sample. Deals with which sample to get now
    task void getSample() 
    {
	    TOSH_CLR_TEMP_CTL_PIN();
	    TOSH_MAKE_TEMP_CTL_INPUT();
	    TOSH_SET_PHOTO_CTL_PIN();
	    TOSH_MAKE_PHOTO_CTL_OUTPUT();
	    call PhotoTimer.stop(); // just in case
	    if (call PhotoTimer.start(TIMER_ONE_SHOT, 10) != SUCCESS) 
	    {
   			post getSample();
	    };
	    return;
    }


    // After waiting a little we can take a reading
    event result_t PhotoTimer.fired() 
    {
  		if (call InternalPhotoADC.getData() == SUCCESS) 
  		{
  		    // Trigger the read which will post a new sample
  		    TOSH_uwait(1000);
  		    return SUCCESS;
  		};
    	return SUCCESS;
    }

    async command result_t ExternalPhotoADC.getData()
    {
    	atomic photoSensor = stateReadOnce;
    	post getSample();
    	return SUCCESS;
    }

    async command result_t ExternalPhotoADC.getContinuousData()
    {
    	atomic tempSensor = stateContinuous;
    	post getSample();
    	return SUCCESS;
    }


    default async event result_t ExternalPhotoADC.dataReady(uint16_t data) 
    {
    	return SUCCESS;
    }

    async event result_t InternalPhotoADC.dataReady(uint16_t data)
    {
	    return signal ExternalPhotoADC.dataReady(data);
    }

}

