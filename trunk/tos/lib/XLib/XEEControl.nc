/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XEEControl.nc,v 1.2.4.1 2007/04/25 23:43:13 njain Exp $
 */

/**
 *
 * @return SUCCESS if XEE restore saved parameters; FAIL otherwise
 *
 * @author Hu Siquan
 */
interface XEEControl
{ 

 /** @return SUCCESS if XEE restore saved parameters; FAIL otherwise */

  event result_t restoreDone(result_t success);  

}
