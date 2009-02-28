/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430GeneralIOC.nc,v 1.1.4.1 2007/04/26 22:09:50 njain Exp $
 */

// @author Cory Sharp <cssharp@eecs.berkeley.edu>

configuration MSP430GeneralIOC
{
  provides interface MSP430GeneralIO as Port10;
  provides interface MSP430GeneralIO as Port11;
  provides interface MSP430GeneralIO as Port12;
  provides interface MSP430GeneralIO as Port13;
  provides interface MSP430GeneralIO as Port14;
  provides interface MSP430GeneralIO as Port15;
  provides interface MSP430GeneralIO as Port16;
  provides interface MSP430GeneralIO as Port17;

  provides interface MSP430GeneralIO as Port20;
  provides interface MSP430GeneralIO as Port21;
  provides interface MSP430GeneralIO as Port22;
  provides interface MSP430GeneralIO as Port23;
  provides interface MSP430GeneralIO as Port24;
  provides interface MSP430GeneralIO as Port25;
  provides interface MSP430GeneralIO as Port26;
  provides interface MSP430GeneralIO as Port27;

  provides interface MSP430GeneralIO as Port30;
  provides interface MSP430GeneralIO as Port31;
  provides interface MSP430GeneralIO as Port32;
  provides interface MSP430GeneralIO as Port33;
  provides interface MSP430GeneralIO as Port34;
  provides interface MSP430GeneralIO as Port35;
  provides interface MSP430GeneralIO as Port36;
  provides interface MSP430GeneralIO as Port37;

  provides interface MSP430GeneralIO as Port40;
  provides interface MSP430GeneralIO as Port41;
  provides interface MSP430GeneralIO as Port42;
  provides interface MSP430GeneralIO as Port43;
  provides interface MSP430GeneralIO as Port44;
  provides interface MSP430GeneralIO as Port45;
  provides interface MSP430GeneralIO as Port46;
  provides interface MSP430GeneralIO as Port47;

  provides interface MSP430GeneralIO as Port50;
  provides interface MSP430GeneralIO as Port51;
  provides interface MSP430GeneralIO as Port52;
  provides interface MSP430GeneralIO as Port53;
  provides interface MSP430GeneralIO as Port54;
  provides interface MSP430GeneralIO as Port55;
  provides interface MSP430GeneralIO as Port56;
  provides interface MSP430GeneralIO as Port57;

  provides interface MSP430GeneralIO as Port60;
  provides interface MSP430GeneralIO as Port61;
  provides interface MSP430GeneralIO as Port62;
  provides interface MSP430GeneralIO as Port63;
  provides interface MSP430GeneralIO as Port64;
  provides interface MSP430GeneralIO as Port65;
  provides interface MSP430GeneralIO as Port66;
  provides interface MSP430GeneralIO as Port67;
}
implementation
{
  components MSP430GeneralIOM;

  Port10 = MSP430GeneralIOM.Port10;
  Port11 = MSP430GeneralIOM.Port11;
  Port12 = MSP430GeneralIOM.Port12;
  Port13 = MSP430GeneralIOM.Port13;
  Port14 = MSP430GeneralIOM.Port14;
  Port15 = MSP430GeneralIOM.Port15;
  Port16 = MSP430GeneralIOM.Port16;
  Port17 = MSP430GeneralIOM.Port17;

  Port20 = MSP430GeneralIOM.Port20;
  Port21 = MSP430GeneralIOM.Port21;
  Port22 = MSP430GeneralIOM.Port22;
  Port23 = MSP430GeneralIOM.Port23;
  Port24 = MSP430GeneralIOM.Port24;
  Port25 = MSP430GeneralIOM.Port25;
  Port26 = MSP430GeneralIOM.Port26;
  Port27 = MSP430GeneralIOM.Port27;

  Port30 = MSP430GeneralIOM.Port30;
  Port31 = MSP430GeneralIOM.Port31;
  Port32 = MSP430GeneralIOM.Port32;
  Port33 = MSP430GeneralIOM.Port33;
  Port34 = MSP430GeneralIOM.Port34;
  Port35 = MSP430GeneralIOM.Port35;
  Port36 = MSP430GeneralIOM.Port36;
  Port37 = MSP430GeneralIOM.Port37;

  Port40 = MSP430GeneralIOM.Port40;
  Port41 = MSP430GeneralIOM.Port41;
  Port42 = MSP430GeneralIOM.Port42;
  Port43 = MSP430GeneralIOM.Port43;
  Port44 = MSP430GeneralIOM.Port44;
  Port45 = MSP430GeneralIOM.Port45;
  Port46 = MSP430GeneralIOM.Port46;
  Port47 = MSP430GeneralIOM.Port47;

  Port50 = MSP430GeneralIOM.Port50;
  Port51 = MSP430GeneralIOM.Port51;
  Port52 = MSP430GeneralIOM.Port52;
  Port53 = MSP430GeneralIOM.Port53;
  Port54 = MSP430GeneralIOM.Port54;
  Port55 = MSP430GeneralIOM.Port55;
  Port56 = MSP430GeneralIOM.Port56;
  Port57 = MSP430GeneralIOM.Port57;

  Port60 = MSP430GeneralIOM.Port60;
  Port61 = MSP430GeneralIOM.Port61;
  Port62 = MSP430GeneralIOM.Port62;
  Port63 = MSP430GeneralIOM.Port63;
  Port64 = MSP430GeneralIOM.Port64;
  Port65 = MSP430GeneralIOM.Port65;
  Port66 = MSP430GeneralIOM.Port66;
  Port67 = MSP430GeneralIOM.Port67;
}

