/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLUSARTFeedback.nc,v 1.1.4.1 2007/04/26 22:06:32 njain Exp $
 */

/*
 * - Description ----------------------------------------------------------
 * Feedback from the USART. 
 * - Revision -------------------------------------------------------------
 * $Revision: 1.1.4.1 $
 * $Date: 2007/04/26 22:06:32 $
 * @author: Jan Hauer (hauer@tkn.tu-berlin.de)
 * ========================================================================
 */
 
interface HPLUSARTFeedback {

  /**
   * A byte of data is about to be transmitted, 
   * ie. the TXBuffer is empty and ready to accept
   * next byte.
   * @return SUCCESS always.
   */
  async event result_t txDone();
	
	
  /**
   * A byte of data has been received. 
   * @return SUCCESS always.
   */
  async event result_t rxDone(uint8_t data);
}

