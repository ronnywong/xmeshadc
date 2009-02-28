/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SounderM.nc,v 1.1.4.5 2007/04/27 05:47:07 njain Exp $
 */
 
/*
 *
 * Authors:  Mike Grimmer
 * Revision:		$Rev$
 *
 */

includes sensorboard;
module SounderM 
{
  provides interface Sounder;
}
implementation 
{
  uint16_t soundtime;
  command result_t Sounder.Beep(uint32_t interval)
  {
    uint32_t i;
    bool open;

	atomic open = FALSE;
    TOSH_CLR_PW2_PIN();  // xscale enable
    TOSH_uwait(1);
    TOSH_MAKE_PWM1B_OUTPUT();  // enable the timer output
    TOSH_SET_PWM1B_PIN();

    for (i=0;i<interval;i++)
    {
      // TOSH_uwait(1);
/**************************************************************************
      now the sounder uses voltage control mode.
      if it is of frequency control type,
      comment the above line and uncomment the followiwng block        
***************************************************************************/
///*
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      TOSH_wait_250ns();
      
      if ((i%4) == 0)
      {
      	if (open)      	
      	{
      		cbi(PORTB,6);
      		atomic open = FALSE;
      	}
      	else
      	{
      		sbi(PORTB,6);
      		atomic open = TRUE;
      	}
      }
//*/
    }
    TOSH_SET_PW2_PIN();  // xscale disable
    TOSH_CLR_PWM1B_PIN();
	return SUCCESS;
  }

  command result_t Sounder.Off()
  {
    TOSH_SET_PW2_PIN();
    TOSH_CLR_PWM1B_PIN();

    return SUCCESS;
  }
 
}

