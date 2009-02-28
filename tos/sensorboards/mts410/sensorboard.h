/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboard.h,v 1.1.4.2 2007/04/27 05:47:49 njain Exp $
 */

// Added MTS410 TOSH pin mappings [2005/9/9] -PIPENG 
#define TOS_PIR_POT_ADDR  0
#define TOS_MIC_POT_ADDR  1
#define TOS_LPF_POT_ADDR  3
#define TOS_HPF_POT_ADDR  2

//TOSH_ASSIGN_PIN(ALE,  G, 2);
//TOSH_ASSIGN_PIN(PWM0,   B, 4);
TOSH_ASSIGN_PIN(PWM1B,   B, 6);
TOSH_ASSIGN_PIN(INT5,  E, 5);
TOSH_ASSIGN_PIN(INT7,  E, 7);
TOSH_ASSIGN_PIN(RELAY1,  E, 2);
TOSH_ASSIGN_PIN(RELAY2,  A, 7);
TOSH_ASSIGN_PIN(PG0,  G, 0);
TOSH_ASSIGN_PIN(PG1,  G, 1);
TOSH_ASSIGN_PIN(PG2,  G, 2);

TOSH_ALIAS_PIN(ACCEL_CTL, PW4);
TOSH_ALIAS_PIN(MIC_CTL, PW3);
TOSH_ALIAS_PIN(AUDIO_DETECT, INT5);
TOSH_ALIAS_OUTPUT_ONLY_PIN(PIR_CTL, PW6);
TOSH_ALIAS_PIN(PIR_DETECT, INT7);

#define UART1_DISABLE()                outp(0 ,UCSR1B);        //disable uart1   

#define PRESSURE_SET_CLOCK()           TOSH_SET_FLASH_CLK_PIN()
#define PRESSURE_CLEAR_CLOCK()         TOSH_CLR_FLASH_CLK_PIN()
#define PRESSURE_MAKE_CLOCK_OUTPUT()   TOSH_MAKE_FLASH_CLK_OUTPUT() //asm volatile ("nop" ::)

#define PRESSURE_MAKE_IN_INPUT()       TOSH_MAKE_FLASH_IN_INPUT()
#define PRESSURE_READ_IN_PIN()         TOSH_READ_FLASH_IN_PIN()
#define PRESSURE_SET_IN_PIN()          TOSH_SET_FLASH_IN_PIN()
#define PRESSURE_CLEAR_IN_PIN()        TOSH_CLR_FLASH_IN_PIN()

#define PRESSURE_MAKE_OUT_OUTPUT()     TOSH_MAKE_FLASH_OUT_OUTPUT()
#define PRESSURE_SET_OUT_PIN()         TOSH_SET_FLASH_OUT_PIN()
#define PRESSURE_CLEAR_OUT_PIN()       TOSH_CLR_FLASH_OUT_PIN()
#define PRESSURE_TIMEOUT_TRIES         5

#define PRESSURE_POWER_ON()            { TOSH_MAKE_PW7_OUTPUT(); TOSH_SET_PW7_PIN(); }
#define PRESSURE_POWER_OFF()           TOSH_CLR_PW7_PIN()

#define PHOTO_POWER_ON()            { TOSH_MAKE_PW1_OUTPUT(); TOSH_SET_PW1_PIN(); }
#define PHOTO_POWER_OFF()           TOSH_CLR_PW1_PIN()

#define HUMIDITY_MAKE_CLOCK_OUTPUT() 	TOSH_MAKE_PG0_OUTPUT() //asm volatile  ("nop" ::)
#define HUMIDITY_MAKE_CLOCK_INPUT() 	TOSH_MAKE_PG0_INPUT()
#define HUMIDITY_SET_CLOCK()		TOSH_SET_PG0_PIN()   // sbi(PORTC, 3)
#define HUMIDITY_CLEAR_CLOCK()		TOSH_CLR_PG0_PIN() // cbi(PORTC, 3)
#define HUMIDITY_SET_DATA()		TOSH_SET_PG1_PIN()   // sbi(PORTD, 3)
#define HUMIDITY_CLEAR_DATA()		TOSH_CLR_PG1_PIN() // cbi(PORTD, 3)
#define HUMIDITY_MAKE_DATA_OUTPUT()	TOSH_MAKE_PG1_OUTPUT() // sbi(DDRD, 3)
#define HUMIDITY_MAKE_DATA_INPUT()	TOSH_MAKE_PG1_INPUT() //cbi(DDRD, 3)
#define HUMIDITY_GET_DATA()		TOSH_READ_PG1_PIN()  // (inp(PIND) >> 3) & 0x1
#define HUMIDITY_POWER_ON()            { TOSH_MAKE_PW0_OUTPUT(); TOSH_SET_PW0_PIN(); }
#define HUMIDITY_POWER_OFF()		TOSH_CLR_PW0_PIN()

#define PIR_INT_ENABLE()  sbi(EIMSK,7)
#define PIR_INT_DISABLE() cbi(EIMSK,7)

#define MIC_INT_ENABLE()  sbi(EIMSK,5)
#define MIC_INT_DISABLE() cbi(EIMSK,5)

#define EEPROM_POWER_ON()            { TOSH_MAKE_PG2_OUTPUT(); TOSH_SET_PG2_PIN(); }
#define EEPROM_POWER_OFF()		TOSH_CLR_PG2_PIN()

#define HUMIDITY_TIMEOUT_MS          45
#define HUMIDITY_TIMEOUT_TRIES       6
//#define HUMIDITY_TIMEOUT_TRIES       50



enum {
  TOSH_ACTUAL_ACCEL_X_PORT = 1, 
  TOSH_ACTUAL_ACCEL_Y_PORT = 2,
  TOSH_ACTUAL_MIC_PORT = 3,
  TOSH_ACTUAL_PIR_PORT = 4,
};

enum {
  TOS_ADC_ACCEL_X_PORT = 1,
  TOS_ADC_ACCEL_Y_PORT = 2,
  TOS_ADC_MIC_PORT = 3,
  TOS_ADC_PIR_PORT = 5,
};

enum {

  // for the ADC[] parameterized interface in IntersemaPressure.ADC[]
  MICAWB_PRESSURE = 0,
  MICAWB_PRESSURE_TEMP = 1,
  MICAWB_HUMIDITY = 0,
  MICAWB_HUMIDITY_TEMP = 1,

  // I2C Switch Addresses
  TOSH_SWITCH0_ADDR = 72,
  TOSH_SWITCH1_ADDR = 73,

  // I2C Taos Photo Sensor Switch Address
  TOSH_PHOTO_ADDR = 57,

 
  MELEXIS_WP_EN = 0x0065,


  // Sensirion Humidity addresses and commands
  TOSH_HUMIDITY_ADDR = 5,
  TOSH_HUMIDTEMP_ADDR = 3,
  TOSH_HUMIDITY_RESET = 0x1E
};


