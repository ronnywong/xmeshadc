/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLCC2420C.nc,v 1.1.4.1 2007/04/27 05:04:36 njain Exp $
 */

/*
 *
 * Authors: Joe Polastre
 * Date last modified:  $Revision: 1.1.4.1 $
 *
 */

/**
 * Low level hardware access to the CC2420
 * @author Joe Polastre
 */

configuration HPLCC2420C {
  provides {
    interface StdControl;
    interface HPLCC2420;
    interface HPLCC2420RAM;
    interface HPLCC2420FIFO;
    interface HPLCC2420Interrupt as InterruptFIFOP;
    interface HPLCC2420Interrupt as InterruptFIFO;
    interface HPLCC2420Interrupt as InterruptCCA;
    interface HPLCC2420Capture as CaptureSFD;
  }
}
implementation
{
  components HPLCC2420M
         , HPLUSART0M
         , HPLCC2420InterruptM
         , MSP430InterruptC
         , MSP430TimerC
         , BusArbitrationC;

  StdControl = HPLCC2420M;
  HPLCC2420 = HPLCC2420M;
  HPLCC2420RAM = HPLCC2420M;
  HPLCC2420FIFO = HPLCC2420M;

  InterruptFIFOP = HPLCC2420InterruptM.FIFOP;
  InterruptFIFO = HPLCC2420InterruptM.FIFO;
  InterruptCCA = HPLCC2420InterruptM.CCA;
  CaptureSFD = HPLCC2420InterruptM.SFD;

  HPLCC2420M.USARTControl -> HPLUSART0M;
  HPLCC2420M.BusArbitration -> BusArbitrationC.BusArbitration[unique("BusArbitration")];

  HPLCC2420InterruptM.FIFOPInterrupt -> MSP430InterruptC.Port10;
  HPLCC2420InterruptM.FIFOInterrupt -> MSP430InterruptC.Port13;
  HPLCC2420InterruptM.CCAInterrupt -> MSP430InterruptC.Port14;
  HPLCC2420InterruptM.SFDControl -> MSP430TimerC.ControlB1;
  HPLCC2420InterruptM.SFDCapture -> MSP430TimerC.CaptureB1;
}
