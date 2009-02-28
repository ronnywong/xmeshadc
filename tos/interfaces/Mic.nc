/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Mic.nc,v 1.1.4.1 2007/04/25 23:26:15 njain Exp $
 */

/*
 * Authors:		Alec Woo
 * Date last modified:  8/20/02
 * 
 * The microphone on the mica sensor board has two methods for control and
 * one method to read the binary output of the tone detector.  (Note:  The tone
 * detector's binary output can be configured as an interrupt.  Please see MicInterrupt.ti)
 *
 * muxSel allows users to switch the ADC to sample from phase lock loop output of
 * the tone detector (by setting the value to 0 (default))  or the raw voice-band output 
 * of the micrphone (by setting the value to 1).
 *
 * gainAdjust allows users to adjust the amplification gain on the microphone. The range
 * is 0 to 255 with 0 being the minmum and 255 being the maximum amplification.  Note that
 * setting amplification too high can result in clipping (signal distortion).
 *
 * If an audio signal at 4.3kHz is picked up by the microphone, the tone
 * detect will decode it and generate a binary ouput (0 meaning tone is detected, 1 meaning
 * tone is not detected).  Users can read this output simply by calling readToneDetector().
 *
 */

/**
 * @author Alec Woo
 */

interface Mic {
  /* Effect:  Set the multiplexer's setting on the microphone
   * Return:  returns SUCCESS or FAIL
   */
  command result_t muxSel(uint8_t sel);
  /* Effect:  Set the amplificatoin gain  on the microphone
   * Return:  returns SUCCESS or FAIL
   */
  command result_t gainAdjust(uint8_t val);

  /* Effect:  returns the binary tone detector's output
   * Return:  0 meaning tone is detected, 1 meanning tone is not detected
   */
  command uint8_t readToneDetector();
}
