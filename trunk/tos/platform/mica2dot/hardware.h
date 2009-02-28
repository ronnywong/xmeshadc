/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: hardware.h,v 1.1.4.1 2007/04/26 00:22:11 njain Exp $
 */

/*
 *
 * Authors:             Jason Hill, Philip Levis, Nelson Lee, David Gay
 * Version:		$Id: hardware.h,v 1.1.4.1 2007/04/26 00:22:11 njain Exp $
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

#ifndef TOSH_HARDWARE_MICA2DOT
#define TOSH_HARDWARE_MICA2DOT
#endif // tosh hardware

#define TOSH_NEW_AVRLIBC // mica128 requires avrlibc v. 20021209 or greater
#include <avrhardware.h>
#include "CC1000Const.h"
//#include "mydebug.h"
// avrlibc may define ADC as a 16-bit register read.  This collides with the nesc
// ADC interface name
uint16_t inline getADC() {
  return inw(ADC);
}
#undef ADC

// LED assignments
TOSH_ASSIGN_PIN(RED_LED, A, 2);

// YELLOW_LED and GREEN_LED pins don't exist on mica2dot, but do exist on
// mica2 prerelease which uses the same platform files with mica2dot.
TOSH_ASSIGN_PIN(YELLOW_LED, A, 0); // Doesn't actually exist on mica2dot
TOSH_ASSIGN_PIN(GREEN_LED, A, 1);  // Doesn't actually exist on mica2dot

// ChipCon control assignments
TOSH_ASSIGN_PIN(CC_CHP_OUT, E, 7); 	// chipcon CHP_OUT
TOSH_ASSIGN_PIN(CC_PDATA, D, 7);  	// chipcon PDATA 
TOSH_ASSIGN_PIN(CC_PCLK, D, 6);		// chipcon PCLK
TOSH_ASSIGN_PIN(CC_PALE, D, 5);		// chipcon PALE

// "GPS" pin
TOSH_ASSIGN_PIN(GPS_ENA, E, 6);

TOSH_ASSIGN_PIN(PWM1B, B, 6);

// Flash assignments
TOSH_ASSIGN_PIN(FLASH_SELECT, E, 5);	// changed for mica2dot
TOSH_ASSIGN_PIN(FLASH_CLK,  A, 3);
TOSH_ASSIGN_PIN(FLASH_OUT,  A, 7);
TOSH_ASSIGN_PIN(FLASH_IN,  A, 6);

// interrupt assignments
TOSH_ASSIGN_PIN(INT0, D, 0);
TOSH_ASSIGN_PIN(INT1, D, 1);
TOSH_ASSIGN_PIN(INT2, D, 2);
TOSH_ASSIGN_PIN(INT3, D, 3);

// spibus assignments 
TOSH_ASSIGN_PIN(MOSI,  B, 2);
TOSH_ASSIGN_PIN(MISO,  B, 3);
TOSH_ASSIGN_PIN(SPI_OC1C, B, 7);
TOSH_ASSIGN_PIN(SPI_SCK,  B, 1);

// power control assignments
TOSH_ASSIGN_PIN(PW0, C, 0);
TOSH_ASSIGN_PIN(PW1, C, 1);
TOSH_ASSIGN_PIN(PW2, C, 2);
TOSH_ASSIGN_PIN(PW3, C, 3);
TOSH_ASSIGN_PIN(PW4, C, 4);
TOSH_ASSIGN_PIN(PW5, C, 5);
TOSH_ASSIGN_PIN(PW6, C, 6);
TOSH_ASSIGN_PIN(PW7, C, 7);

// adc assignments
TOSH_ASSIGN_PIN(ADC2, F, 2);
TOSH_ASSIGN_PIN(ADC3, F, 3);
TOSH_ASSIGN_PIN(ADC4, F, 4);
TOSH_ASSIGN_PIN(ADC5, F, 5);
TOSH_ASSIGN_PIN(ADC6, F, 6);
TOSH_ASSIGN_PIN(ADC7, F, 7);

// i2c bus assignments
TOSH_ALIAS_PIN(I2C_BUS1_SCL, PW0);
TOSH_ALIAS_PIN(I2C_BUS1_SDA, INT1);


// general purpose io assignements
TOSH_ASSIGN_PIN(LITTLE_GUY_RESET, E, 6);

// uart assignments
TOSH_ASSIGN_PIN(UART_RXD0, E, 0);
TOSH_ASSIGN_PIN(UART_TXD0, E, 1);

void TOSH_SET_PIN_DIRECTIONS(void)
{
  outp(0x00, DDRA);
  outp(0x00, DDRB);
  outp(0x00, DDRD);
  outp(0x02, DDRE);
  outp(0x02, PORTE);

  TOSH_MAKE_INT3_INPUT();
  TOSH_MAKE_ADC7_INPUT();
  
  // Only PW0, PW1 are connected, and we leave it to their users
  // to make them outputs
  outp(0x0, DDRC);
  outp(0xff, PORTC);

  TOSH_MAKE_CC_CHP_OUT_INPUT();	// modified for mica2dot
    
  TOSH_MAKE_CC_PALE_OUTPUT();    
  TOSH_MAKE_CC_PDATA_OUTPUT();
  TOSH_MAKE_CC_PCLK_OUTPUT();
  TOSH_MAKE_MISO_INPUT();
  TOSH_MAKE_SPI_OC1C_INPUT();
}

enum {
  TOSH_ADC_PORTMAPSIZE = 12
};

enum 
{
  TOSH_ACTUAL_CC_RSSI_PORT = 0,
  TOSH_ACTUAL_BANDGAP_PORT = 30,
  TOSH_ACTUAL_GND_PORT	   = 31
};

enum 
{
  TOS_ADC_CC_RSSI_PORT = 0,
  TOS_ADC_BANDGAP_PORT = 10,
  TOS_ADC_GND_PORT     = 11
};

// define the voltage port here because it's not associated with any sensorboards
enum
{
	TOSH_ACTUAL_VOLTAGE_PORT = 1
};
enum
{
	TOS_ADC_VOLTAGE_PORT = 1
};

/**
 * (Busy) wait <code>usec</code> microseconds
 */
#if CPU_CLK == 4000000
#define TOSH_CYCLE_TIME_NS 250

void inline TOSH_wait_250ns() {
      asm volatile  ("nop" ::);
}  

void inline TOSH_uwait(int u_sec)
{
  /* In most cases (constant arg), the test is elided at compile-time */
  if (u_sec)
    /* loop takes 4 cycles, aka 1us */
    asm volatile (
"1:	sbiw	%0,1\n"
"	brne	1b" : "+w" (u_sec));
}
#else
#define TOSH_CYCLE_TIME_NS 136

// each nop is 1 clock cycle
// 1 clock cycle on mica2 == 136ns
void inline TOSH_wait_250ns() {
      asm volatile  ("nop" ::);
      asm volatile  ("nop" ::);
}

void inline TOSH_uwait(int u_sec) {
    while (u_sec > 0) {
      asm volatile  ("nop" ::);
      asm volatile  ("nop" ::);
      asm volatile  ("nop" ::);
      asm volatile  ("nop" ::);
      asm volatile  ("nop" ::);
      asm volatile  ("nop" ::);
      asm volatile  ("nop" ::);
      asm volatile  ("nop" ::);
      u_sec--;
    }
}

#endif

#endif //TOSH_HARDWARE_H
