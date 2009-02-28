/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ServiceScheduler.nc,v 1.1.4.1 2007/04/25 23:30:33 njain Exp $
 */

// Authors: Robert Szewczyk
// $Id: ServiceScheduler.nc,v 1.1.4.1 2007/04/25 23:30:33 njain Exp $


/** 
 * Interface to the scheduler module
 */

includes TosServiceSchedule;

interface ServiceScheduler {
    
    /** 
     * This command is used to (re)schedule a service.  ServiceScheduler
     * assumes the time syncronization and consequently uses an absolute timer
     * to express the schedule. 
     */
    
    command result_t reschedule(uint8_t svc_id,
				tos_service_schedule sched
				);

    /** 
     * This command allows an external component to get the schedule for an
     * individual component. 
     */

    command tos_service_schedule get(uint8_t svc_id);

    /** 
     * This command allows an external component to start all services.  This
     * is useful when it is desirable to disable the service coordinator and
     * leave it in a fully operational state.  
     *
     * @return SUCCESS if all coordinated services were started successfully,
     * FAIL if at least one of them failed. 
     */

    command result_t start_all();

    command result_t setNextEventTime(uint8_t svc_id, tos_time_t nextTime);


    command tos_time_t getNextEventTime(uint8_t svc_id);


    command result_t setExtraSleepTime(uint8_t svc_id, int32_t extraTime);


    command result_t remove(uint8_t svc_id);
}
