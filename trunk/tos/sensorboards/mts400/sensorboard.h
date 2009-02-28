/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboard.h,v 1.1.4.2 2007/04/27 05:42:53 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 */

#define UART1_DISABLE()                outp(0 ,UCSR1B);        //disable uart1   

#define PRESSURE_SET_CLOCK()           TOSH_SET_FLASH_CLK_PIN()
#define PRESSURE_CLEAR_CLOCK()         TOSH_CLR_FLASH_CLK_PIN()
#define PRESSURE_MAKE_CLOCK_OUTPUT()   asm volatile ("nop" ::)
#define PRESSURE_MAKE_IN_INPUT()       TOSH_MAKE_FLASH_IN_INPUT()
#define PRESSURE_READ_IN_PIN()         TOSH_READ_FLASH_IN_PIN()
#define PRESSURE_SET_IN_PIN()          TOSH_SET_FLASH_IN_PIN()
#define PRESSURE_CLEAR_IN_PIN()        TOSH_CLR_FLASH_IN_PIN()


#define PRESSURE_MAKE_OUT_OUTPUT()     TOSH_MAKE_FLASH_OUT_OUTPUT()
#define PRESSURE_SET_OUT_PIN()         TOSH_SET_FLASH_OUT_PIN()
#define PRESSURE_CLEAR_OUT_PIN()       TOSH_CLR_FLASH_OUT_PIN()


#define HUMIDITY_INT_DISABLE() cbi(EIMSK , 7)       //disable int 7

// #define HUMIDITY_INTERRUPT     SIG_INTERRUPT3
#define HUMIDITY_INTERRUPT     SIG_INTERRUPT7    //Atmega128 INT7

#define HUMIDITY_MAKE_CLOCK_OUTPUT() asm volatile  ("nop" ::)
#define HUMIDITY_MAKE_CLOCK_INPUT() { }
#define HUMIDITY_SET_CLOCK() TOSH_SET_PW3_PIN()   // sbi(PORTC, 3)
#define HUMIDITY_CLEAR_CLOCK() TOSH_CLR_PW3_PIN() // cbi(PORTC, 3)
#define HUMIDITY_SET_DATA() TOSH_SET_INT3_PIN()   // sbi(PORTD, 3)
#define HUMIDITY_CLEAR_DATA() TOSH_CLR_INT3_PIN() // cbi(PORTD, 3)
#define HUMIDITY_MAKE_DATA_OUTPUT() TOSH_MAKE_INT3_OUTPUT() // sbi(DDRD, 3)
#define HUMIDITY_MAKE_DATA_INPUT() TOSH_MAKE_INT3_INPUT() //cbi(DDRD, 3)
#define HUMIDITY_GET_DATA() TOSH_READ_INT3_PIN()  // (inp(PIND) >> 3) & 0x1

#define HUMIDITY_TIMEOUT_MS          45
#define HUMIDITY_TIMEOUT_TRIES       6
//#define HUMIDITY_TIMEOUT_TRIES       50

#define PRESSURE_TIMEOUT_TRIES       5

// adc channels for accel x,y outputs
#define ADC_ACCEL_X_PORT   1
#define ADC_ACCEL_Y_PORT   2

#define   TOS_ADC_ACCEL_X_PORT  2
#define   TOS_ADC_ACCEL_Y_PORT  3

  const char crctable[256] = {
    0, 49, 98, 83, 196, 245, 166, 151, 185, 136, 219, 234, 125, 76, 31, 46,
    67, 114, 33, 16,
    135, 182, 229, 212, 250, 203, 152, 169, 62, 15, 92, 109, 134, 183, 228,
    213, 66, 115, 32, 17,
    63, 14, 93, 108,251, 202,153, 168,197, 244,167, 150,1, 48, 99, 82, 124, 
    77, 30, 47,
    184, 137,218, 235,61, 12, 95, 110,249, 200,155, 170,132, 181,230, 215,
    64, 113,34, 19,
    126, 79, 28, 45, 186, 139,216, 233,199, 246,165, 148,3, 50, 97, 80, 187, 
    138,217, 232,
    127, 78, 29, 44, 2, 51, 96, 81, 198, 247,164, 149,248, 201,154, 171,60, 
    13, 94, 111,
    65, 112,35, 18, 133, 180,231, 214,122, 75, 24, 41, 190, 143,220, 237,
    195, 242,161, 144,
    7, 54, 101, 84, 57, 8, 91, 106,253, 204,159, 174,128, 177,226, 211,68, 
    117,38, 23,
    252, 205,158, 175,56, 9, 90, 107,69, 116,39, 22, 129, 176,227, 210,191,
    142,221, 236,
    123, 74, 25, 40, 6, 55, 100, 85, 194, 243,160, 145,71, 118,37, 20, 131, 
    178,225, 208,
    254, 207,156, 173,58, 11, 88, 105,4, 53, 102, 87, 192, 241,162, 147,189, 
    140,223, 238,
    121, 72, 27, 42, 193, 240,163, 146,5, 52, 103, 86, 120, 73, 26, 43, 188, 
    141,222, 239,
    130, 179,224, 209,70, 119,36, 21, 59, 10, 89, 104,255, 206,157, 172};



enum {
  // Main Switch addresses
  MICAWB_LIGHT_POWER = 1,
  MICAWB_PRESSURE_POWER = 3,
  MICAWB_HUMIDITY_POWER = 4,
  MICAWB_EEPROM_POWER = 5,
  MICAWB_ACCEL_POWER = 6,
  MICAWB_GPS_POWER = 7,
  MICAWB_GPS_ENABLE = 8,

  // I/O Switch addresses
  MICAWB_GPS_RX_SELECT = 1,             //enable GPS serial Rx line
  MICAWB_GPS_TX_SELECT = 2,             //enable GPS serial Tx line
  MICAWB_PRESSURE_SCLK = 3,             //enable Intersema SCLK
  MICAWB_PRESSURE_DIN = 4,              //enable Intersema Data In
  MICAWB_PRESSURE_DOUT = 5,             //enable Intersema Data Out
  MICAWB_HUMIDITY_SCLK = 7,             //enable Sensirion SCLK
  MICAWB_HUMIDITY_DATA = 8,             //enable Sensirion Data I/O

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

