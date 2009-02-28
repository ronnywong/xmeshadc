/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboard.h,v 1.1.4.1 2007/04/27 05:21:55 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 */

#define HUMIDITY_POWER_ON() { TOSH_MAKE_ADC7_OUTPUT(); TOSH_SET_ADC7_PIN(); }
#define HUMIDITY_POWER_OFF()         TOSH_CLR_ADC7_PIN()

#define HUMIDITY_INT_ENABLE()        sbi(EIMSK , 0) // was 1 ***
#define HUMIDITY_INT_DISABLE()       cbi(EIMSK , 0) // was 1 ***
#define HUMIDITY_INTERRUPT           SIG_INTERRUPT0 // was 1 ***

#define HUMIDITY_MAKE_CLOCK_OUTPUT() TOSH_MAKE_PW0_OUTPUT()  //sbi(DDRC, 3)
#define HUMIDITY_MAKE_CLOCK_INPUT()  TOSH_MAKE_PW0_INPUT()   //sbi(DDRC, 3)
#define HUMIDITY_SET_CLOCK()         TOSH_SET_PW0_PIN()      // sbi(PORTC, 3)
#define HUMIDITY_CLEAR_CLOCK()       TOSH_CLR_PW0_PIN()      // cbi(PORTC, 3)
#define HUMIDITY_SET_DATA()          TOSH_SET_INT0_PIN()     // sbi(PORTD, 3)
#define HUMIDITY_CLEAR_DATA()        TOSH_CLR_INT0_PIN()     // cbi(PORTD, 3)
#define HUMIDITY_MAKE_DATA_OUTPUT()  TOSH_MAKE_INT0_OUTPUT() // sbi(DDRD, 3)
#define HUMIDITY_MAKE_DATA_INPUT()   TOSH_MAKE_INT0_INPUT()  //cbi(DDRD, 3)
#define HUMIDITY_GET_DATA()          TOSH_READ_INT0_PIN()    // (inp(PIND) >> 3) & 0x1
#define HUMIDITY_TIMEOUT_MS          30
#define HUMIDITY_TIMEOUT_TRIES       20

enum {
  // Sensirion Humidity addresses and commands
  TOSH_HUMIDITY_ADDR = 5,
  TOSH_HUMIDTEMP_ADDR = 3,
  TOSH_HUMIDITY_RESET = 0x1E
};

const char crctable[256] = { 0, 49, 98, 83, 196, 245, 166, 151, 185,
  136, 219, 234, 125, 76, 31, 46, 67, 114, 33, 16, 135, 182, 229, 212,
  250, 203, 152, 169, 62, 15, 92, 109, 134, 183, 228, 213, 66, 115,
  32, 17, 63, 14, 93, 108, 251, 202, 153, 168, 197, 244, 167, 150, 1,
  48, 99, 82, 124, 77, 30, 47, 184, 137, 218, 235, 61, 12, 95, 110,
  249, 200, 155, 170, 132, 181, 230, 215, 64, 113, 34, 19, 126, 79,
  28, 45, 186, 139, 216, 233, 199, 246, 165, 148, 3, 50, 97, 80, 187,
  138, 217, 232, 127, 78, 29, 44, 2, 51, 96, 81, 198, 247, 164, 149,
  248, 201, 154, 171, 60, 13, 94, 111, 65, 112, 35, 18, 133, 180, 231,
  214, 122, 75, 24, 41, 190, 143, 220, 237, 195, 242, 161, 144, 7, 54,
  101, 84, 57, 8, 91, 106, 253, 204, 159, 174, 128, 177, 226, 211, 68,
  117, 38, 23, 252, 205, 158, 175, 56, 9, 90, 107, 69, 116, 39, 22,
  129, 176, 227, 210, 191, 142, 221, 236, 123, 74, 25, 40, 6, 55, 100,
  85, 194, 243, 160, 145, 71, 118, 37, 20, 131, 178, 225, 208, 254,
  207, 156, 173, 58, 11, 88, 105, 4, 53, 102, 87, 192, 241, 162, 147,
  189, 140, 223, 238, 121, 72, 27, 42, 193, 240, 163, 146,5, 52, 103,
  86, 120, 73, 26, 43, 188, 141, 222, 239, 130, 179, 224, 209, 70,
  119, 36, 21, 59, 10, 89, 104, 255, 206, 157, 172};
