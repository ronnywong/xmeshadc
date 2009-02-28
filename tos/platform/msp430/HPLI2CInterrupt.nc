/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLI2CInterrupt.nc,v 1.1.4.1 2007/04/26 22:05:09 njain Exp $
 */
 
/*
 * - Description ----------------------------------------------------------
 * Feedback from the USART. 
 * - Revision -------------------------------------------------------------
 * $Revision: 1.1.4.1 $
 * $Date: 2007/04/26 22:05:09 $
 * @author: Jan Hauer (hauer@tkn.tu-berlin.de)
 * ========================================================================
 */
 
interface HPLI2CInterrupt {

  /**
   * Signals that an I2C Interrupt has occurred.
   */
  async event void fired();

}

