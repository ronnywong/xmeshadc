/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: EventRegister.nc,v 1.1.4.1 2007/04/25 23:22:22 njain Exp $
 */

/* 
 * Authors:  Wei Hong
 *           Intel Research Berkeley Lab
 * Date:     9/25/2002
 *
 */

/**
 * @author Wei Hong
 * @author Intel Research Berkeley Lab
 */


includes Event;

/** The interface for registering events
    <p>
    See lib/Events/... for examples of components that register commands.
    <p>
    See interfaces/Event.h for the data structures used in this interface 
    <p>
    Implemented by lib/Event.nc
    <p>
    @author Wei Hong (wei.hong@intel-research.net)
*/
interface EventRegister
{
  /** Register an event with the specified name and parameters.
      @param name The name of the event to register
      @param paramList The parameters to this event (see Params.h for the def of paramList)
  */
  command result_t registerEvent(char *name, ParamList *paramList);

  /** delete an event
      @param name The name of the event to delete
  */
  command result_t deleteEvent(char *name);
}
