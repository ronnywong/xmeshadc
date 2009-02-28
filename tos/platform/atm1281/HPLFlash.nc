/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLFlash.nc,v 1.1.2.2 2007/04/26 00:05:10 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/**
 * Low level hardware access to the onboard EEPROM (well, Flash actually)
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */

module HPLFlash {
  provides {
    interface StdControl as FlashControl;
    interface SlavePin as FlashSelect;
    interface FastSPI as FlashSPI;
    interface Resource as FlashIdle;
    command bool getCompareStatus();
  }
}
implementation
{
  // We use SPI mode 0 (clock low at select time)

  command result_t FlashControl.init() {
    TOSH_MAKE_FLASH_SELECT_OUTPUT();
    TOSH_SET_FLASH_SELECT_PIN();
    TOSH_CLR_FLASH_CLK_PIN();
    TOSH_MAKE_FLASH_CLK_OUTPUT();
    TOSH_SET_FLASH_OUT_PIN();
    TOSH_MAKE_FLASH_OUT_OUTPUT();
    TOSH_CLR_FLASH_IN_PIN();
    TOSH_MAKE_FLASH_IN_INPUT();

    return SUCCESS;
  }

  command result_t FlashControl.start() {
    return SUCCESS;
  }

  command result_t FlashControl.stop() {
    return SUCCESS;
  }

  // The flash select is not shared on mica2, mica2dot
  async command result_t FlashSelect.low() {
    TOSH_CLR_FLASH_CLK_PIN(); // ensure SPI mode 0
    TOSH_CLR_FLASH_SELECT_PIN();
    return SUCCESS;
  }

  task void sigHigh() {
    signal FlashSelect.notifyHigh();
  }

  async command result_t FlashSelect.high(bool needEvent) {
    TOSH_SET_FLASH_SELECT_PIN();
    if (needEvent)
      post sigHigh();
    return SUCCESS;
  }
  
#define BITINIT \
  uint8_t clrClkAndData = inp(PORTD) & ~0x28

#define BIT(n) \
	outp(clrClkAndData, PORTD); \
	asm __volatile__ \
        (  "sbrc %2," #n "\n" \
	 "\tsbi 11,3\n" \
	 "\tsbi 11,5\n" \
	 "\tsbic 9,2\n" \
	 "\tori %0,1<<" #n "\n" \
	 : "=d" (spiIn) : "0" (spiIn), "r" (spiOut))

  async inline command uint8_t FlashSPI.txByte(uint8_t spiOut) {
    uint8_t spiIn = 0;

    // This atomic ensures integrity at the hardware level...
    atomic
      {
	BITINIT;

	BIT(7);
	BIT(6);
	BIT(5);
	BIT(4);
	BIT(3);
	BIT(2);
	BIT(1);
	BIT(0);
      }

    return spiIn;
  }

  task void idleWait() {
    if (TOSH_READ_FLASH_IN_PIN())
      signal FlashIdle.available();
    else
      post idleWait();
  }

  command result_t FlashIdle.wait() {
    TOSH_CLR_FLASH_CLK_PIN();

    // Early exit. Must wait a little for flash in to be acquired
    TOSH_uwait(1);
    if (TOSH_READ_FLASH_IN_PIN())
      return FAIL;

    post idleWait();
    return SUCCESS;
  }

  command bool getCompareStatus() {
    TOSH_SET_FLASH_CLK_PIN();
    TOSH_CLR_FLASH_CLK_PIN();
    // Wait for compare value to propagate
    asm volatile("nop");
    asm volatile("nop");
    return !TOSH_READ_FLASH_IN_PIN();
  }
}
