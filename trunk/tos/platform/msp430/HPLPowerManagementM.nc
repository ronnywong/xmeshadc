/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLPowerManagementM.nc,v 1.1.4.1 2007/04/26 22:05:37 njain Exp $
 */

/* Author:  Robert Szewczyk
 *
 * $Id: HPLPowerManagementM.nc,v 1.1.4.1 2007/04/26 22:05:37 njain Exp $
 */

/**
 * @author Robert Szewczyk
 * @author Vlado Handziski
 * @author Jan Hauer
 */


module HPLPowerManagementM {
    provides {
      interface PowerManagement;
      command result_t Enable();
      command result_t Disable();
    }
}
implementation{  
 
  
  async command uint8_t PowerManagement.adjustPower() {
    return SUCCESS;
  }

  command result_t Enable() {
    LPMode_enable();
    return SUCCESS;
  }

  command result_t Disable() {
    LPMode_disable();
    return SUCCESS;
  }
}
