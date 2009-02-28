/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PotC.nc,v 1.1.4.1 2007/04/27 06:02:25 njain Exp $
 */


/*
 *
 * Authors:		Vladimir Bychkovskiy, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/* Potentiometer control component

 Functionality: Set and get potentiometer value (transmit power)

 USAGE:

  POT_INIT(char power)
      - reset the potentiometer device and set the initial value(see below)

  POT_SET(char power)
      - set new potentiometer value (see below)
      
  POT_GET()
      - get current setting of the potentiometer

  POT_INC()
  POT_DEC()
      - increment (decrement) current setting by 1

  Potentiometer setting vs. transmit power

  Valid range: 
     Mica --  0 (high power, low potentioneter resistance)
             99 (low power, high potentioneter resistance)
	     Actual range depends very much on the antenna; with the built in
	     antenna the range is from 1in to about 15 feet; with the external
	     bead antenna the range is from 1 foot to about 100 feet

     Rene -- 20 (high power, low potentiometer resistance)
             77 (low power, EXACT BOUND DEPENDS ON BATTERY VOLTAGE)
	     Again, range depends on the antenna, and can cover roughly the
	     same range as a Mica. WARNING: the low power bound is strongly
	     dependent on battery voltage, it is fairly difficult to get a
	     reliable short range over time without active control of the
	     potentiometer. 

   Note: transmit power is NOT linear w.r.t. potentiometer setting,
   see mote schematics & RFM chip manual for more information
*/

/**
 * @author Vladimir Bychkovskiy
 * @author David Gay
 * @author Philip Levis
 */

configuration PotC
{
  provides interface Pot;
}
implementation 
{
  components PotM, HPLPotC;

  Pot = PotM;
  PotM.HPLPot -> HPLPotC;
}
