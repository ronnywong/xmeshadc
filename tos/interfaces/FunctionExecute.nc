/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: FunctionExecute.nc,v 1.1.4.1 2007/04/25 23:22:47 njain Exp $
 */
 
/*
 * Authors:		Nelson Lee
 * Date last modified:  6/26/02
 *
 *
 */

/**
 * @author Nelson Lee
 */

includes ExternalFunctionMsg;
/**
 * The FunctionExecute interface
 */ 
interface FunctionExecute {

  /// Parses and executes a function according to the string argument <code>cmd</code>
  command result_t execute(String cmd);
  /// An event sent when the function has been executed
  event result_t functionExecuteDone(String cmd, result_t success);
}


