/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: hardware.h,v 1.1.2.3 2007/04/26 22:03:31 njain Exp $
 */


#ifndef TOSH_HARDWARE_H
#define TOSH_HARDWARE_H

#ifndef TOSH_HARDWARE_MICAZC
#define TOSH_HARDWARE_MICAZC
#endif // tosh hardware

#define TOSH_NEW_AVRLIBC // mica128 requires avrlibc v. 20021209 or greater
#include <avrhardware.h>
#include <RF230Const.h>

// avrlibc may define ADC as a 16-bit register read.  This collides with the nesc
// ADC interface name
uint16_t inline getADC() {
  return inw(ADC);
}
#undef ADC

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

//More Accurate TOSH_uwait, Verified w/oscope and compiler -Os
//However it would be better if the entire tosh_uwait was one asm call
void inline TOSH_uwait2(int u_sec) {
    while (u_sec > 0) {
      asm volatile  ("nop" ::);
      u_sec--;
    }
}

// LED assignments
TOSH_ASSIGN_PIN(RED_LED, A, 2);
TOSH_ASSIGN_PIN(GREEN_LED, A, 1);
TOSH_ASSIGN_PIN(YELLOW_LED, A, 0);

TOSH_ASSIGN_PIN(SERIAL_ID, A, 4);
TOSH_ASSIGN_PIN(BAT_MON, A, 5);
TOSH_ASSIGN_PIN(THERM_PWR, A, 7);


// RF230 pins assignments
TOSH_ASSIGN_PIN(RF230_SLP_TR, B, 7); //This is MicaZC's change.  RCB230 is (B, 4)
TOSH_ASSIGN_PIN(RF230_RSTN, A, 6); 	 //This is MicaZC's change.  RCB230 is (B, 5)
TOSH_ASSIGN_PIN(RF230_IRQ, D, 4);
TOSH_ASSIGN_PIN(RF230_CLKM, D, 6);

// Flash assignments
TOSH_ASSIGN_PIN(FLASH_SELECT, A, 3);
TOSH_ASSIGN_PIN(FLASH_CLK,  D, 5);
TOSH_ASSIGN_PIN(FLASH_OUT,  D, 3);
TOSH_ASSIGN_PIN(FLASH_IN,  D, 2);

// interrupt assignments
TOSH_ASSIGN_PIN(INT0, E, 4);
TOSH_ASSIGN_PIN(INT1, E, 5);
TOSH_ASSIGN_PIN(INT2, E, 6);
TOSH_ASSIGN_PIN(INT3, E, 7);
TOSH_ASSIGN_PIN(ACN, E, 3);// added for support in test

// spibus assignments
TOSH_ASSIGN_PIN(SPI_CS,  B, 0);
TOSH_ASSIGN_PIN(SPI_SCK, B, 1);
TOSH_ASSIGN_PIN(MOSI,  B, 2);
TOSH_ASSIGN_PIN(MISO,  B, 3);

// power control assignments
TOSH_ASSIGN_PIN(PW0, C, 0);
TOSH_ASSIGN_PIN(PW1, C, 1);
TOSH_ASSIGN_PIN(PW2, C, 2);
TOSH_ASSIGN_PIN(PW3, C, 3);
TOSH_ASSIGN_PIN(PW4, C, 4);
TOSH_ASSIGN_PIN(PW5, C, 5);
TOSH_ASSIGN_PIN(PW6, C, 6);
TOSH_ASSIGN_PIN(PW7, C, 7);

// i2c bus assignments
TOSH_ASSIGN_PIN(I2C_BUS1_SCL, D, 0);
TOSH_ASSIGN_PIN(I2C_BUS1_SDA, D, 1);

// uart assignments
TOSH_ASSIGN_PIN(UART_RXD0, E, 0);
TOSH_ASSIGN_PIN(UART_TXD0, E, 1);
TOSH_ASSIGN_PIN(UART_XCK0, E, 2)

TOSH_ASSIGN_PIN(UART_RXD1, D, 2);
TOSH_ASSIGN_PIN(UART_TXD1, D, 3);
TOSH_ASSIGN_PIN(UART_XCK1, D, 5);

//MICA Connector Defined Lines added 12/20/04
TOSH_ASSIGN_PIN(AC_NEG, E, 3);
TOSH_ASSIGN_PIN(PWM1A, B, 5);
TOSH_ASSIGN_PIN(PWM0, B, 4);
//TOSH_ASSIGN_PIN(PWM1B, B, 6); //MTS410 has already defined this Pin's name.
TOSH_ASSIGN_PIN(ADC7, F, 7);
TOSH_ASSIGN_PIN(ADC6, F, 6);

//Additional Port Assignments 
TOSH_ASSIGN_PIN(WR, G, 0);
TOSH_ASSIGN_PIN(RD, G, 1);
TOSH_ASSIGN_PIN(ALE, G, 2);


void TOSH_SET_PIN_DIRECTIONS(void)
{
  /*  outp(0x00, DDRA);
  outp(0x00, DDRB);
  outp(0x00, DDRD);
  outp(0x02, DDRE);
  outp(0x02, PORTE);
  */

  TOSH_MAKE_RED_LED_OUTPUT();
  TOSH_MAKE_YELLOW_LED_OUTPUT();
  TOSH_MAKE_GREEN_LED_OUTPUT();


  TOSH_MAKE_PW7_OUTPUT();
  TOSH_MAKE_PW6_OUTPUT();
  TOSH_MAKE_PW5_OUTPUT();
  TOSH_MAKE_PW4_OUTPUT();
  TOSH_MAKE_PW3_OUTPUT();
  TOSH_MAKE_PW2_OUTPUT();
  TOSH_MAKE_PW1_OUTPUT();
  TOSH_MAKE_PW0_OUTPUT();

/*//CC2420 pins
  TOSH_MAKE_MISO_INPUT();
  TOSH_MAKE_MOSI_OUTPUT();
  TOSH_MAKE_SPI_SCK_OUTPUT();
  TOSH_MAKE_CC_RSTN_OUTPUT();
  TOSH_MAKE_CC_VREN_OUTPUT();
  TOSH_MAKE_CC_CS_INPUT();
  TOSH_MAKE_CC_FIFOP1_INPUT();
  TOSH_MAKE_CC_CCA_INPUT();
  TOSH_MAKE_CC_SFD_INPUT();
  TOSH_MAKE_CC_FIFO_INPUT();

  TOSH_MAKE_RADIO_CCA_INPUT();*/



  TOSH_MAKE_SERIAL_ID_INPUT();
  TOSH_CLR_SERIAL_ID_PIN();  // Prevent sourcing current

  TOSH_MAKE_FLASH_SELECT_OUTPUT();
  TOSH_MAKE_FLASH_OUT_OUTPUT();
  TOSH_MAKE_FLASH_CLK_OUTPUT();
  TOSH_SET_FLASH_SELECT_PIN();

  TOSH_SET_RED_LED_PIN();
  TOSH_SET_YELLOW_LED_PIN();
  TOSH_SET_GREEN_LED_PIN();

}

enum {
  TOSH_ADC_PORTMAPSIZE = 12
};

enum
{
//  TOSH_ACTUAL_CC_RSSI_PORT = 0,
  TOSH_ACTUAL_VOLTAGE_PORT = 30,   //map to internal BG ref
  TOSH_ACTUAL_BANDGAP_PORT = 30,  // 1.23 Fixed bandgap reference
  TOSH_ACTUAL_GND_PORT     = 31   // GND
};

enum
{
 // TOS_ADC_CC_RSSI_PORT = 0,
  TOS_ADC_VOLTAGE_PORT = 7,
  TOS_ADC_BANDGAP_PORT = 10,
  TOS_ADC_GND_PORT     = 11
};

#ifdef UART0_BAUDRATE
	uint32_t TOS_UART0_BAUDRATE = UART0_BAUDRATE;
#else
	uint32_t TOS_UART0_BAUDRATE = 57600u;
#endif

#ifdef UART1_BAUDRATE
	uint32_t TOS_UART1_BAUDRATE = UART1_BAUDRATE;
#else
	uint32_t TOS_UART1_BAUDRATE = 57600u;
#endif

#endif //TOSH_HARDWARE_H




