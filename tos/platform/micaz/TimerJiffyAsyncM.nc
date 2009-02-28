/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TimerJiffyAsyncM.nc,v 1.2.4.1 2007/04/26 21:51:34 njain Exp $
 */
 
/* 
 * Author: Xin Yang (xyang@xbow.com)
 * Date:   11/05/05
 */

/**
 * TimerJiffyAsyncM.nc - Provides a (32uSec interval) timer for CC2420Radio
 *
 *
 * <pre>
 *	$Id: TimerJiffyAsyncM.nc,v 1.2.4.1 2007/04/26 21:51:34 njain Exp $
 * </pre>
 *
 * @author Joe Polastre 
 * @author Xin Yang
 * @date November 13 2005
 */


module TimerJiffyAsyncM
{
  provides interface StdControl;
  provides interface TimerJiffyAsync;
  uses interface Clock as Timer;
  uses interface PowerManagement;
}

implementation
{
#define  JIFFY_SCALE 0x4 //cpu clk/256 ~ 32uSec
#define  JIFFY_INTERVAL 2

/*===Local State ============================================================*/

  uint32_t jiffy;
  bool bSet;

/*===StdControl =============================================================*/

  command result_t StdControl.init()
    {
      return SUCCESS;
    }

  command result_t StdControl.start()
    {
      atomic bSet = FALSE;
      return SUCCESS;
    }

  command result_t StdControl.stop()
    {
      atomic {
	bSet = FALSE;
	call Timer.intDisable();
      }
      return SUCCESS;
    }


/*===Timer Fire =============================================================*/

  async event result_t Timer.fire() {
    uint16_t localjiffy;
    atomic localjiffy = jiffy;
    if (localjiffy < 0xFF) {
      call Timer.intDisable();
      atomic bSet = FALSE;
      signal TimerJiffyAsync.fired();  //finished!
      call PowerManagement.adjustPower();
    }
    else {

      localjiffy = localjiffy >> 8;
      atomic jiffy = localjiffy;
      call Timer.setIntervalAndScale(localjiffy, JIFFY_SCALE  );  //sets timer,starts and enables interrupt
    }
    return(SUCCESS);
  }

/*===Jiffy Timer ============================================================*/
  
  async command result_t TimerJiffyAsync.setOneShot( uint32_t _jiffy )
    {
      atomic {
	jiffy = _jiffy;
	bSet = TRUE;
      }
      if (_jiffy > 0xFF) {
	call Timer.setIntervalAndScale(0xFF, JIFFY_SCALE  );  //sets timer,starts and enables interrupt
      }
      else {
	call Timer.setIntervalAndScale(_jiffy, JIFFY_SCALE  );  // enables timer interrupt
      }
    
      call PowerManagement.adjustPower();
      return SUCCESS;
    }

  async command bool TimerJiffyAsync.isSet( )
    {
      return bSet;
    }

  async command result_t TimerJiffyAsync.stop()
    {
      atomic { 
	bSet = FALSE;
	call Timer.intDisable();
      }
      return SUCCESS;
    }
}

