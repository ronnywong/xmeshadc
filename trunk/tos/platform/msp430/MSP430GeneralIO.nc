/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430GeneralIO.nc,v 1.1.4.1 2007/04/26 22:09:41 njain Exp $
 */

// @author Cory Sharp <cssharp@eecs.berkeley.edu>

interface MSP430GeneralIO
{
  async command void setHigh();
  async command void setLow();
  async command void toggle();
  async command uint8_t getRaw();
  async command bool get();
  async command void makeInput();
  async command void makeOutput();
  async command void selectModuleFunc();
  async command void selectIOFunc();
}

