/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: I2CPotM.nc,v 1.1.4.2 2007/04/27 05:44:11 njain Exp $
 */
 
/*
 *
 * Authors:		Alec Woo
 * Date last modified:  7/23/02
 *
 */

module I2CPotM
{
  provides {
    interface StdControl;
    interface I2CPot;
  }
  uses {
    interface I2C;
	interface StdControl as I2CControl;
  }
}

implementation
{

  /* state of the i2c request */
  enum {IDLE=0,
	READ_POT_START=11,
	READ_COMMAND = 13,
	READ_COMMAND_2 = 14,
	READ_COMMAND_3 = 15,
	READ_COMMAND_4 = 16,
	READ_COMMAND_5 = 17,
	READ_POT_READING_DATA = 18,
        READ_FAIL = 19,
	WRITE_POT_START = 30,
	WRITE_COMMAND = 31,
	WRITE_COMMAND_2 = 32,
	WRITING_TO_POT = 33,
	WRITE_POT_STOP = 40,
        WRITE_FAIL = 49,
	READ_POT_STOP = 41
	};	

  // Frame variables
  char data;	/* data to be written */
  norace char state;   /* state of this module */
  char addr;    /* addr to be read/written */
  char pot;     /* pot select */


  void wait() {
    asm volatile  ("nop" ::);
    asm volatile  ("nop" ::);
  }

  void waitn(uint16_t n)
  {
  	uint16_t i;
  	for(i=0;i<n;i++)
  	{
  		wait();
  	}
  }


  command result_t StdControl.init() 
  {
    call I2CControl.init();
    state = IDLE;
    return SUCCESS;
  }

  command result_t StdControl.start() 
  {
    call I2CControl.start();
    return SUCCESS;
  }

  command result_t StdControl.stop() 
  {
    call I2CControl.stop();
    return SUCCESS;
  }

  /***********************************************
   writes the new pot setting over the I2C bus 
   ************************************************/
  command result_t I2CPot.writePot(char line_addr, 
	char pot_addr, char in_data)
  {	
    if (state == IDLE)
    {
  /*  reset variables  */
      addr = line_addr;
      pot = pot_addr;
      data = in_data;
      state = WRITE_POT_START;
      if (call I2C.sendStart())
      {
	    return SUCCESS;
      }
	  else
      {
	    state = IDLE;
	    return FAIL;
      }
    }
	else
	{
      return FAIL;
    }
  }
  
  command result_t I2CPot.readPot(char line_addr, char pot_addr)
  {
    if (state == IDLE)
    {
      addr = line_addr;
      pot = pot_addr;
      state = READ_POT_START;
      if (call I2C.sendStart())
	  {
	    return SUCCESS;
      }
	  else
	  {
	    state = IDLE;
	    return FAIL;
      }
    }
    else
	{
      return FAIL;
    }
  }
/**********************************************************/
/* tos events           */
/**********************************************************/

  event result_t I2C.sendStartDone() 
  {
//    waitn(4);
    if(state == WRITE_POT_START)
	{
      state = WRITE_COMMAND;
      call I2C.write(0x58 | ((addr << 1) & 0x06));
    }
    else if (state == READ_POT_START)
	{
      state = READ_COMMAND;
      call I2C.write(0x59 | ((addr << 1) & 0x06));
    }
    return SUCCESS;
  }
/********************************************************/
  /* notification that the stop symbol was sent */
  event result_t I2C.sendEndDone() 
  {
    if (state == WRITE_POT_STOP)
	{
      state = IDLE;
      signal I2CPot.writePotDone(SUCCESS);
    }
    else if (state == READ_POT_STOP) 
	{
      state = IDLE;
      signal I2CPot.readPotDone(data, SUCCESS);
    }
    else if ( state == READ_FAIL )
	{
      state = IDLE ;
      signal I2CPot.readPotDone(data, FAIL);
    }
    else if ( state == WRITE_FAIL ) 
	{
      state = IDLE ;
      signal I2CPot.writePotDone(FAIL);
    }
    return SUCCESS;
  }
/*************************************************/
  /* notification of a byte sucessfully written to the bus */
  event result_t I2C.writeDone(bool result) 
  {
    waitn(2);
/*
TOSH_MAKE_YELLOW_LED_OUTPUT();
TOSH_CLR_YELLOW_LED_PIN();
TOSH_uwait(1000);
TOSH_SET_YELLOW_LED_PIN();
*/
    if (result == FAIL)
	{
/*
TOSH_MAKE_RED_LED_OUTPUT();
TOSH_CLR_RED_LED_PIN();
TOSH_uwait(1000);
TOSH_SET_RED_LED_PIN();
*/
      state = WRITE_FAIL;
      call I2C.sendEnd();
      return FAIL ;
    }
    if (state== WRITING_TO_POT) 
	{
      state = WRITE_POT_STOP;
//	  TOSH_uwait(3);
      call I2C.sendEnd();
      return 0;
    } 
	else if (state == WRITE_COMMAND) 
	{
      state = WRITE_COMMAND_2;
//	  TOSH_uwait(3);
      call I2C.write(0 | ((pot << 7) & 0x80));

    } 
	else if (state == WRITE_COMMAND_2)
	{
      state = WRITING_TO_POT;
//	  TOSH_uwait(3);
      call I2C.write(data);
    } 
	else if (state ==READ_COMMAND) 
	{
      state = READ_POT_READING_DATA;
      call I2C.read(0 | ((pot << 7) & 0x80));
    }

    return SUCCESS;
  }
/*********************************************************/
  /* read a byte off the bus and add it to the packet */
  event result_t I2C.readDone(char in_data) 
  {
    if (state == IDLE)
	{
      data = 0;
      return FAIL;
    }
    if (state == READ_POT_READING_DATA)
	{
      state = READ_POT_STOP;
      data = in_data;
      call I2C.sendEnd();
      return FAIL; 
    }
    return SUCCESS;
  }
/*************************************************************/
  default event result_t I2CPot.readPotDone(char in_data, bool result) 
  {
    return SUCCESS;
  }

  default event result_t I2CPot.writePotDone(bool result) 
  {
    return SUCCESS;
  }

}










