/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MicInterrupt.nc,v 1.1.4.1 2007/04/25 23:26:24 njain Exp $
 */
 
/*
 * Authors:		Alec Woo
 * Date last modified:  8/20/02
 * 
 * The microphone on the mica sensor board has the tone detector interrupt.
 * If an audio signal at 4.3kHz is picked up by the microphone, the tone
 * detect will decode it and generate a toneDetected interrupt if the
 * interrupt is enabled.
 *
 */

/**
 * @author Alec Woo
 */



interface MicInterrupt
{
  /* Effects: disable interrupts
     Returns: SUCCESS
  */
  async command bool disable();

  /* Effects: enable interrupts
     Returns: SUCCESS
  */
  async command result_t enable();

  /* Interrupt signal for tone detected.  Note that MicInterrupt is automatically disabled
   * before this event is signaled.  (Upper layer needs to reenable this interrupt for future
   * tone detect.
   *
   *  Returns: SUCCESS
   */
  async event result_t toneDetected();
}
