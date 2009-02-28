// $Id: hardware.h,v 1.1.4.2 2007/04/26 00:28:23 njain Exp $

/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: hardware.h,v 1.1.4.2 2007/04/26 00:28:23 njain Exp $
 */

/*
 *
 * Authors:             Jason Hill, Philip Levis, Nelson Lee, David Gay
 *
 *
 */

/**
 * @author Jason Hill
 * @author Philip Levis
 * @author Nelson Lee
 * @author David Gay
 */


#ifndef TOSH_HARDWARE_H
#define TOSH_HARDWARE_H

#include <avrhardware.h>

#define TOSH_CYCLE_TIME_NS 250

void inline TOSH_wait_250ns() {
      asm volatile  ("nop" ::);
}  

//NOTE:
//We need to undef ADC because it is somethind defined in avrlibc
//and it conflicts with our ADC component
#undef ADC

TOSH_ASSIGN_PIN(RED_LED, A, 2);
TOSH_ASSIGN_PIN(YELLOW_LED, A, 0);
TOSH_ASSIGN_PIN(GREEN_LED, A, 1);

TOSH_ASSIGN_PIN(UD, A, 1);
TOSH_ASSIGN_PIN(INC, A, 2);
TOSH_ASSIGN_PIN(POT_SELECT, D, 5);
TOSH_ASSIGN_PIN(POT_POWER, E, 7);
TOSH_ASSIGN_PIN(BOOST_ENABLE, E, 4);

TOSH_ASSIGN_PIN(FLASH_SELECT,  B, 0);
TOSH_ASSIGN_PIN(FLASH_CLK,  A, 3);
TOSH_ASSIGN_PIN(FLASH_OUT,  A, 7);
TOSH_ASSIGN_PIN(FLASH_IN,  A, 6);

TOSH_ASSIGN_PIN(INT1, D, 1);
TOSH_ASSIGN_PIN(INT2, D, 2);
TOSH_ASSIGN_PIN(INT3, D, 3);

TOSH_ASSIGN_PIN(RFM_RXD,  B, 2);
TOSH_ASSIGN_PIN(RFM_TXD,  B, 3);
TOSH_ASSIGN_PIN(RFM_CTL0, D, 7);
TOSH_ASSIGN_PIN(RFM_CTL1, D, 6);

TOSH_ASSIGN_OUTPUT_ONLY_PIN(PW0, C, 0);
TOSH_ASSIGN_OUTPUT_ONLY_PIN(PW1, C, 1);
TOSH_ASSIGN_OUTPUT_ONLY_PIN(PW2, C, 2);
TOSH_ASSIGN_OUTPUT_ONLY_PIN(PW3, C, 3);
TOSH_ASSIGN_OUTPUT_ONLY_PIN(PW4, C, 4);
TOSH_ASSIGN_OUTPUT_ONLY_PIN(PW5, C, 5);
TOSH_ASSIGN_OUTPUT_ONLY_PIN(PW6, C, 6);
TOSH_ASSIGN_OUTPUT_ONLY_PIN(PW7, C, 7);

TOSH_ASSIGN_PIN(I2C_BUS1_SCL, A, 4);
TOSH_ASSIGN_PIN(I2C_BUS1_SDA, A, 5);

TOSH_ASSIGN_OUTPUT_ONLY_PIN(I2W_BUS_SCL, C, 3);
TOSH_ASSIGN_PIN(I2W_BUS_SDA, D, 3);

TOSH_ASSIGN_PIN(LITTLE_GUY_RESET, E, 6);

TOSH_ASSIGN_PIN(UART_RXD0, E, 0);
TOSH_ASSIGN_PIN(UART_TXD0, E, 1);

TOSH_ASSIGN_PIN(ONE_WIRE, E, 5);

void TOSH_SET_PIN_DIRECTIONS(void)
{
  outp(0x00, DDRA);
  outp(0x00, DDRB);
  outp(0x00, DDRD);
  outp(0x02, DDRE);
  outp(0x02, PORTE);
  TOSH_MAKE_POT_SELECT_OUTPUT();
  TOSH_MAKE_POT_POWER_OUTPUT();
    
  TOSH_MAKE_PW7_OUTPUT();
  TOSH_MAKE_PW6_OUTPUT();
  TOSH_MAKE_PW5_OUTPUT();
  TOSH_MAKE_PW4_OUTPUT();
  TOSH_MAKE_PW3_OUTPUT();
  TOSH_MAKE_PW2_OUTPUT();
  TOSH_MAKE_PW1_OUTPUT();
  TOSH_MAKE_PW0_OUTPUT();
    
  TOSH_MAKE_RFM_CTL0_OUTPUT();
  TOSH_MAKE_RFM_CTL1_OUTPUT();
  TOSH_MAKE_RFM_TXD_OUTPUT();
  TOSH_SET_POT_POWER_PIN();

  /* flash select and 1-wire are connected - get flash select out of 
     the way. We use one-wire only */
  TOSH_MAKE_FLASH_SELECT_INPUT();
    
  TOSH_MAKE_BOOST_ENABLE_OUTPUT();
  TOSH_SET_BOOST_ENABLE_PIN();

  TOSH_MAKE_ONE_WIRE_INPUT();
  TOSH_SET_ONE_WIRE_PIN();
}

enum {
  TOSH_ADC_PORTMAPSIZE = 12
};

// define the voltage port here because it's not associated with any sensorboards
enum
{
	TOSH_ACTUAL_VOLTAGE_PORT = 7
};
enum
{
	TOS_ADC_VOLTAGE_PORT = 7
};

/**
 * (Busy) wait <code>usec</code> microseconds
 */
void inline TOSH_uwait(int u_sec)
{
  /* In most cases (constant arg), the test is elided at compile-time */
  if (u_sec)
    /* loop takes 4 cycles, aka 1us */
    asm volatile (
"1:	sbiw	%0,1\n"
"	brne	1b" : "+w" (u_sec));
}

#endif //TOSH_HARDWARE_H
