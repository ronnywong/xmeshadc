/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLADC12.nc,v 1.1.4.1 2007/04/26 22:04:53 njain Exp $
 */
 
 
/*
 * - Description ----------------------------------------------------------
 * Interface for controlling ADC12-functionality of MSP430.
 * - Revision -------------------------------------------------------------
 * $Revision: 1.1.4.1 $
 * $Date: 2007/04/26 22:04:53 $
 * @author: Jan Hauer (hauer@tkn.tu-berlin.de)
 * ========================================================================
 */
        
includes  MSP430ADC12;

interface HPLADC12
{
  async command void setControl0(adc12ctl0_t control0); 
  async command void setControl1(adc12ctl1_t control1);
  async command adc12ctl0_t getControl0(); 
  async command adc12ctl1_t getControl1(); 
  
  /* Sets ADC12CTL0 to control0 except it leaves REFON, REF2_5V unchanged */
  async command void setControl0_IgnoreRef(adc12ctl0_t control0); 
  
  async command void setMemControl(uint8_t index, adc12memctl_t memControl); 
  async command adc12memctl_t getMemControl(uint8_t i); 
  async command uint16_t getMem(uint8_t i); 

  
  async command void setIEFlags(uint16_t mask); 
  async command uint16_t getIEFlags(); 
  
  async command void resetIFGs(); 
  async command uint16_t getIFGs(); 

  async event void memOverflow();
  async event void timeOverflow();
  async event void converted(uint8_t number);

  async command bool isBusy();
  /* ATTENTION: setConversionMode and setSHT etc. require ENC-flag to be reset! 
     (disableConversion) */
  async command void setConversionMode(uint8_t mode);
  async command void setSHT(uint8_t sht);
  async command void setMSC();
  async command void resetMSC();
  async command void setRefOn();
  async command void setRefOff();
  async command uint8_t getRefon();     // off if 0, else on
  async command void setRef1_5V();
  async command void setRef2_5V();
  async command uint8_t getRef2_5V();   // 1.5 V if 0, else 2.5 V
    
  async command void enableConversion();
  async command void disableConversion();
  async command void startConversion();
  async command void stopConversion();
  
  async command bool isInterruptPending();
  async command void off();
  async command void on();
}

