/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RF230Const.h,v 1.1.2.2 2007/04/27 05:01:31 njain Exp $
 */

 
#ifndef _RF230CONST_H
#define _RF230CONST_H


/* === Channel / Frequency ================================================= */

//NOTE:
//internally only channels are used.  Frequency values are only there as a
// convenience for users.

//default channel, can be overwritten at compile time
#ifndef RF230_DEF_CHANNEL
#define RF230_DEF_CHANNEL 11  
#endif

//frequency, channel coversion macro functions
#define ctof(chan) ((chan-10)*5 + 2400)
#define ftoc(freq) ((freq - 2400)/5 + 10)

//AVRLIBC CRC function
#define CRC_CCITT_UPDATE(crc, data) _crc_ccitt_update(crc, data)

/* === TX Power ============================================================ */

//convenience macros for compile time selection of output power
//+3.2dbm
#define TXPOWER_3_2DBM 0	
#define TXPOWER_2_8DBM 1
#define TXPOWER_2_3DBM 2
#define TXPOWER_1_8DBM 3
#define TXPOWER_1_3DBM 4
#define TXPOWER_0_7DBM 5
#define TXPOWER_0DBM 6
#define TXPOWER_M1DBM 7
#define TXPOWER_M2DBM 8
#define TXPOWER_M3DBM 9
#define TXPOWER_M4DBM 10
#define TXPOWER_M5DBM 11
#define TXPOWER_M7DBM 12
#define TXPOWER_M9DBM 13
#define TXPOWER_M12DBM 14
#define TXPOWER_M17DBM 15	//-17dbm

#define TXPOWER_MAX (TXPOWER_3_2DBM)
#define TXPOWER_MIN (TXPOWER_M17DBM)

//default power select, can be overwritten at compile time
#ifndef RF230_TXPOWER
#define RF230_TXPOWER (TXPOWER_MAX)
#endif

/* === Global variables ==================================================== */

//These values are made global so moteconfig can set them
// (ie changable in binary)

// This line is for fixing binary scan bug: if using volatile when power=o, compiler will put this variable into .bss.
uint8_t TOS_RF230_TXPOWER __attribute__((section(".data")))  = RF230_TXPOWER;
volatile uint8_t TOS_RF230_CHANNEL = RF230_DEF_CHANNEL; 


/* === 15.4 Packet fields and Radio params ================================= */

//This radio stack uses a subset of 15.4 defined mac frame formats.  These are
//the default header values for the frame formats that are used.

#define IEEE15_4_DEF_FCF_LO         	(0x08)	// destination address mode, 16bit short
#define IEEE15_4_DEF_FCF_HI         	(0x01)	// data type without ACK
#define IEEE15_4_DEF_FCF_HI_ACKREQ     	(0x21)	// data type with ACK
#define IEEE15_4_DEF_BCAST_PAN     	    (0xFFFF)	// dest pan with bcast

#define IEEE15_4_DEF_FCF_LO_ACK         (0x00)	//nothing
#define IEEE15_4_DEF_FCF_HI_ACK         (0x02)	//type ack

#define IEEE15_4_FCF_TYPE_BEACON    	(0x00)	// beacon type
#define IEEE15_4_FCF_TYPE_DATA      	(0x01)	// data type
#define IEEE15_4_FCF_TYPE_ACK       	(0x02)	// ack type

#define IEEE15_4_SYMBOL_TIME        	(16)	//us
#define IEEE15_4_LENGTH_MASK        	(0x7F)	//7 LSB
#define IEEE15_4_ACK_LENGTH				(5)		//bytes

//Timing Constants
#define RF_230_SYMBOL_UNIT          	(10)	//number of jiffies
#define RF_230_ACK_DELAY            	(20)	//ack wait time in number of jiffies ~ 640us

#define RF_230_MAX_CAA_CYCLES			(30)	//depends on frequency & spi settings - do not use
#define RF_230_CCA_WAIT_TIME_US			(200)	//conservative - minimum 128us
#define RF_230_ED_WAIT_TIME_US			(200)	//conservative - minimum 128us

#define RF_230_OSC_STABLE_TIME_US		(650)
#define RF_230_CLK_STABLE_TIME_US		(256)
#define RF_230_RX_ON_SETTLE_TIME_US		(200)	//76 - 200us depending on data sheet

#define RF_230_PLL_ON_SETTLE_TIME_US	(200)	//76 - 200us depending on data sheet
#define RF_230_PLL_ON_FAST_SETTLE_TIME_US	(100)	//76 - 200us depending on data sheet - acks

#define RF_230_RESET_SETTLE_TIME_US		(120)	//90 - 120us depending on data sheet

#define RF_230_ACK_TRANSMIT_TIME_US		(400)	//11bytes

//Back off special values
#define NOBACKOFF 	  0x0000
#define FAILONBACKOFF 0xffff

//FCS?
//#define MSG_ACK_SIZE 			2+1+2	//FCF + SeqNo + FCS

/* === Radio Commands ====================================================== */

#   define TRX_CMD_RW         ((1<<7) | (1<<6))
#   define TRX_CMD_RR         ((1<<7) | (0<<6))
#   define TRX_CMD_FW         ((0<<7) | (1<<6) | (1<<5))
#   define TRX_CMD_FR         ((0<<7) | (0<<6) | (1<<5))
#   define TRX_CMD_SW         ((0<<7) | (1<<6) | (0<<5))
#   define TRX_CMD_SR         ((0<<7) | (0<<6) | (0<<5))

#   define TRX_CMD_RADDRM     ((0<<7) | (0<<6) | (1<<5) | (1<<4) | (1<<3) | (1<<2) |(1<<1) | (1<<0))
#   define TRX_CMD_CNTRLM     ((0<<7) | (0<<6) | (1<<5) | (1<<4) | (1<<3) | (1<<2) |(1<<1) | (1<<0))

/* === Interrupt mask ====================================================== */

#   define TRX_IRQ_BAT_LOW             (0x80)
#   define TRX_IRQ_TRX_UR              (0x40)
#   define TRX_IRQ_5                   (0x20)
#   define TRX_IRQ_4                   (0x10)
#   define TRX_IRQ_TRX_END             (0x08)
#   define TRX_IRQ_RX_START            (0x04)
#   define TRX_IRQ_PLL_UNLOCK          (0x02)
#   define TRX_IRQ_PLL_LOCK            (0x01)

#   define TRX_KNOWN_IRQS     (TRX_IRQ_TRX_UR | TRX_IRQ_TRX_END | TRX_IRQ_RX_START)

/* === Wake Sequence ======================================================= */

#define RF230_WAKE_FCF_HI (0x04) //reserved type

//Before Optimization
// #define PREAMBLE_256MS 696
// #define PREAMBLE_128MS 348
// #define PREAMBLE_64MS  174
// #define PREAMBLE_32MS   87
// #define PREAMBLE_16MS   44
// #define PREAMBLE_8MS    22
// #define PREAMBLE_4MS    11
// #define PREAMBLE_2MS     6
// #define PREAMBLE_0MS     0

#define PREAMBLE_256MS 
#define PREAMBLE_128MS 462
#define PREAMBLE_64MS
#define PREAMBLE_32MS
#define PREAMBLE_16MS
#define PREAMBLE_8MS
#define PREAMBLE_4MS
#define PREAMBLE_2MS
#define PREAMBLE_0MS

#define PREAMBLE_PADDING 20	//5ms

#define RF230_GAP 224 //not actual time
//#define RF230_SNIFF_PADDING 32 
#define RF230_SNIFF_PADDING 64

//#define RF230_WAKE_PACKET_DELAY 375
//#define RF230_WAKE_PACKET_DELAY 288

#define SNIFF_DURATION (RF230_GAP + RF230_SNIFF_PADDING)

/* === Register Map ======================================================== */

#include "phy230_registermap.h"


#endif /* _RF230CONST_H */
