/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430InterruptC.nc,v 1.1.4.1 2007/04/26 22:10:59 njain Exp $
 */

//@author Joe Polastre

configuration MSP430InterruptC
{
  provides interface MSP430Interrupt as Port10;
  provides interface MSP430Interrupt as Port11;
  provides interface MSP430Interrupt as Port12;
  provides interface MSP430Interrupt as Port13;
  provides interface MSP430Interrupt as Port14;
  provides interface MSP430Interrupt as Port15;
  provides interface MSP430Interrupt as Port16;
  provides interface MSP430Interrupt as Port17;

  provides interface MSP430Interrupt as Port20;
  provides interface MSP430Interrupt as Port21;
  provides interface MSP430Interrupt as Port22;
  provides interface MSP430Interrupt as Port23;
  provides interface MSP430Interrupt as Port24;
  provides interface MSP430Interrupt as Port25;
  provides interface MSP430Interrupt as Port26;
  provides interface MSP430Interrupt as Port27;

  provides interface MSP430Interrupt as NMI;
  provides interface MSP430Interrupt as OF;
  provides interface MSP430Interrupt as ACCV;
}
implementation
{
  components MSP430InterruptM;

  Port10 = MSP430InterruptM.Port10;
  Port11 = MSP430InterruptM.Port11;
  Port12 = MSP430InterruptM.Port12;
  Port13 = MSP430InterruptM.Port13;
  Port14 = MSP430InterruptM.Port14;
  Port15 = MSP430InterruptM.Port15;
  Port16 = MSP430InterruptM.Port16;
  Port17 = MSP430InterruptM.Port17;

  Port20 = MSP430InterruptM.Port20;
  Port21 = MSP430InterruptM.Port21;
  Port22 = MSP430InterruptM.Port22;
  Port23 = MSP430InterruptM.Port23;
  Port24 = MSP430InterruptM.Port24;
  Port25 = MSP430InterruptM.Port25;
  Port26 = MSP430InterruptM.Port26;
  Port27 = MSP430InterruptM.Port27;

  NMI = MSP430InterruptM.NMI;
  OF = MSP430InterruptM.OF;
  ACCV = MSP430InterruptM.ACCV;
}
