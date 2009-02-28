/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * Copyright (c) 2004 by Sensicast, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ConfigSave.nc,v 1.1.4.1 2007/04/25 23:41:33 njain Exp $
 */


//
// @Author: Michael Newman
//
//

#define ConfigSaveEdit 1
//
// Modification History:
//  13Jan04 MJNewman 1: Created.

includes config;
interface ConfigSave
{
    // Read each parameter from memory and store it in EEPROM
    // Save all  parameters in range start to end inclusive.
    // The save occurs in order. Parameters that follow any failure
    // are not saved. The parameters must have the same application ID.
    //
    // Inputs:
    //	start	first parameter ID of set to save
    //	end	last parameter ID of set
    // Returns:
    //	FAIL on illegal argument types or start > end
    command result_t save(AppParamID_t start, AppParamID_t end);

    // Report result of save request.
    //
    // Inputs:
    //	success		FAIL if a parameter could not be written to flash.
    //	failed		ID of last paramter written or first failing parameter.
    // Returns:
    //	SUCCESS normally 
    event result_t saveDone(result_t success, AppParamID_t failed);

#if 0
    //??? not implemented yet
    // Remove a parameter from the flash. Any value stored in flash is
    // removed. If multiple copies exist in flash all will be removed.
    //
    // NOTE: The default value can not be restored, but will be used at
    //    the next reboot
    //
    // Inputs:
    //	param	parameter ID to remove from flash
    // Returns:
    //	FAIL on illegal argument type
    command result_t unSave param);

    // Report result of unsave request.
    //
    // Inputs:
    //	success		FAIL if a parameter could not be written to flash.
    //	failed		ID of last paramter written or first failing parameter.
    // Returns:
    //	SUCCESS normally 
    event result_t unSaveDone(result_t success);
#endif

}
