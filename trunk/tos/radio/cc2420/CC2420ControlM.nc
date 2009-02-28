/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CC2420ControlM.nc,v 1.7.2.2 2007/04/27 04:56:47 njain Exp $
 */

/*
 *
 * Authors:		Alan Broad, Joe Polastre
 * Date last modified:  $Revision: 1.7.2.2 $
 *
 * This module provides the CONTROL functionality for the 
 * Chipcon2420 series radio. It exports both a standard control 
 * interface and a custom interface to control CC2420 operation.
 */

/**
 * @author Alan Broad, Crossbow
 * @author Joe Polastre
 */
/*
 *
 * $Log: CC2420ControlM.nc,v $
 * Revision 1.7.2.2  2007/04/27 04:56:47  njain
 * CVS: Please enter a Bugzilla bug number on the next line.
 * BugID: 1100
 *
 * CVS: Please enter the commit log message below.
 * License header modified in each file for MoteWorks_2_0_F release
 *
 * Revision 1.7.2.1  2007/01/31 19:43:40  xyang
 *
 * BugID:936
 *
 * The bit mask for setting rfpower is wrong.  It did not clear the most significant bit.
 *
 * Revision 1.7  2006/02/17 03:10:59  xyang
 * provides new RadioControl interface that is platform independent
 *
 * Revision 1.6  2006/02/11 03:25:53  xyang
 * reduced wake up time by 600us, 33uA avg pwr savings
 *
 * Revision 1.5  2006/02/08 21:55:29  xyang
 * Added support to do activity detection based on packet header.  Reduced unnecessary power up time.
 *
 * Revision 1.4  2006/01/17 04:23:57  sfmao
 * fix a error occured when transfered to new folder "internal"
 *
 * Revision 1.3  2006/01/16 01:01:37  xyang
 * Changed RSSI vaulues & Start up times
 *
 * Revision 1.1  2006/01/03 07:45:02  mturon
 * Initial install of MoteWorks tree
 *
 * Revision 1.3  2005/04/22 01:54:11  husq
 * Added freq channel variable exportion`:
 *
 * Revision 1.2  2005/03/02 22:34:16  jprabhu
 * Added Log-tag for capturing changes in files.
 *
 *
 */


includes byteorder;

module CC2420ControlM {
  provides {
    interface StdControl;
    interface CC2420Control;
    interface RadioControl;
  }
  uses {
    interface StdControl as HPLChipconControl;
    interface HPLCC2420 as HPLChipcon;
    interface HPLCC2420RAM as HPLChipconRAM;
  }
}
implementation
{
  #define XOSC_TIMEOUT 200     //times to chk if CC2420 crystal is on

  norace uint16_t gCurrentParameters[14];

   /************************************************************************
   * SetRegs
   *  - Configure CC2420 registers with current values
   *  - Readback 1st register written to make sure electrical connection OK
   *************************************************************************/
  bool SetRegs(){
    uint16_t data;
	      
    call HPLChipcon.write(CC2420_MAIN,gCurrentParameters[CP_MAIN]);   		    
    call HPLChipcon.write(CC2420_MDMCTRL0, gCurrentParameters[CP_MDMCTRL0]);
    data = call HPLChipcon.read(CC2420_MDMCTRL0);
    if (data != gCurrentParameters[CP_MDMCTRL0]) return FALSE;
    
    call HPLChipcon.write(CC2420_MDMCTRL1, gCurrentParameters[CP_MDMCTRL1]);
    call HPLChipcon.write(CC2420_RSSI, gCurrentParameters[CP_RSSI]);
    call HPLChipcon.write(CC2420_SYNCWORD, gCurrentParameters[CP_SYNCWORD]);
    call HPLChipcon.write(CC2420_TXCTRL, gCurrentParameters[CP_TXCTRL]);
    call HPLChipcon.write(CC2420_RXCTRL0, gCurrentParameters[CP_RXCTRL0]);
    call HPLChipcon.write(CC2420_RXCTRL1, gCurrentParameters[CP_RXCTRL1]);
    call HPLChipcon.write(CC2420_FSCTRL, gCurrentParameters[CP_FSCTRL]);

    call HPLChipcon.write(CC2420_SECCTRL0, gCurrentParameters[CP_SECCTRL0]);
    call HPLChipcon.write(CC2420_SECCTRL1, gCurrentParameters[CP_SECCTRL1]);
    call HPLChipcon.write(CC2420_IOCFG0, gCurrentParameters[CP_IOCFG0]);
    call HPLChipcon.write(CC2420_IOCFG1, gCurrentParameters[CP_IOCFG1]);

    call HPLChipcon.cmd(CC2420_SFLUSHTX);    //flush Tx fifo
    call HPLChipcon.cmd(CC2420_SFLUSHRX);
 
    return TRUE;
  
  }

  /*************************************************************************
   * Init CC2420 radio:
   *
   *************************************************************************/
  command result_t StdControl.init() {
	  
	//turn on voltage regulator, keep this on since active draws ~29uA
    TOSH_SET_CC_VREN_PIN();    
    TOSH_uwait2(600);
      
    call HPLChipconControl.init();
	
    // Set default parameters
    gCurrentParameters[CP_MAIN] = 0xf800;
    
    gCurrentParameters[CP_MDMCTRL0] = 
    	( (CC2420_ADDRDECODE << CC2420_MDMCTRL0_ADRDECODE) | 
       	(2 << CC2420_MDMCTRL0_CCAHIST) | (3 << CC2420_MDMCTRL0_CCAMODE)  | 
       	(1 << CC2420_MDMCTRL0_AUTOCRC) | (2 << CC2420_MDMCTRL0_PREAMBL) );

    gCurrentParameters[CP_MDMCTRL1] = 20 << CC2420_MDMCTRL1_CORRTHRESH;

    gCurrentParameters[CP_RSSI] = 0xE080;  //CCA threshold = -32dbm
    
    gCurrentParameters[CP_SYNCWORD] = 0xA70F;
    
    gCurrentParameters[CP_TXCTRL] = 
    	( (1 << CC2420_TXCTRL_BUFCUR) | 
    	(1 << CC2420_TXCTRL_TURNARND) | 
    	(3 << CC2420_TXCTRL_PACUR) | 
    	(1 << CC2420_TXCTRL_PADIFF) | 
    	(TOS_CC2420_TXPOWER << CC2420_TXCTRL_PAPWR) );
   
    gCurrentParameters[CP_RXCTRL0] = 
    	( (1 << CC2420_RXCTRL0_BUFCUR) | 
    	(2 << CC2420_RXCTRL0_MLNAG) | 
    	(3 << CC2420_RXCTRL0_LOLNAG) | 
    	(2 << CC2420_RXCTRL0_HICUR) | 
    	(1 << CC2420_RXCTRL0_MCUR) | 
    	(1 << CC2420_RXCTRL0_LOCUR) );

    gCurrentParameters[CP_RXCTRL1] =
    	( (1 << CC2420_RXCTRL1_LOLOGAIN) | 
    	(1 << CC2420_RXCTRL1_HIHGM) |
	    (1 << CC2420_RXCTRL1_LNACAP) | 
	    (1 << CC2420_RXCTRL1_RMIXT) |
		(1 << CC2420_RXCTRL1_RMIXV) | 
		(2 << CC2420_RXCTRL1_RMIXCUR) );
    
	gCurrentParameters[CP_FSCTRL] = 
		((1 << CC2420_FSCTRL_LOCK) | 
		((357+5*(TOS_CC2420_CHANNEL-11)) << CC2420_FSCTRL_FREQ));

    gCurrentParameters[CP_SECCTRL0] = 
    	( (1 << CC2420_SECCTRL0_CBCHEAD) |
    	(1 << CC2420_SECCTRL0_SAKEYSEL)  | 
    	(1 << CC2420_SECCTRL0_TXKEYSEL) |
		(1 << CC2420_SECCTRL0_SECM ) );

    gCurrentParameters[CP_SECCTRL1] = 0;
    gCurrentParameters[CP_BATTMON]  = 0;
    
    //gCurrentParameters[CP_IOCFG0] = 
    //	(((TOSH_DATA_LENGTH + 2) << CC2420_IOCFG0_FIFOTHR) | 
    //	(1 <<CC2420_IOCFG0_FIFOPPOL)) ;
    
	//1) set fifop threshold >> size of tos msg, 
	//	 so fifpo only triggers at packet end
	//2) FIFOP INterrupt active LOW
	gCurrentParameters[CP_IOCFG0] = 
		(((CC2420_RXFIFO_THRESHOLD) << CC2420_IOCFG0_FIFOTHR) | 
		(CC2420_RXFIFO_PPOL <<CC2420_IOCFG0_FIFOPPOL)) ;

    gCurrentParameters[CP_IOCFG1] = 0;

    return SUCCESS;
  }


  command result_t StdControl.stop() {
    return call HPLChipconControl.stop();
  }

/******************************************************************************
 * Start CC2420 radio:
 * -Turn on 1.8V voltage regulator, wait for power-up, 0.6msec
 * -Release reset line
 * -Enable CC2420 crystal,          wait for stabilization, 0.9 msec
 *
 ******************************************************************************/

  command result_t StdControl.start() {
    result_t status;

    call HPLChipconControl.start();
    
    //put radio into reset
    TOSH_CLR_CC_RSTN_PIN();
    TOSH_uwait2(5);
    
    //come out of reset	        
    TOSH_SET_CC_RSTN_PIN();
    TOSH_uwait2(5);
    
    // turn on crystal, takes about 860 usec, 
    // chk CC2420 status reg for stablize
    status = call CC2420Control.OscillatorOn();
    
    //set freq, load regs
    status = SetRegs() && status;
    status = status && call CC2420Control.setShortAddress(TOS_LOCAL_ADDRESS);
    status = status && call CC2420Control.TunePreset(TOS_CC2420_CHANNEL);
    
    call CC2420Control.RxMode();            //radio in receive mode	
    call HPLChipcon.enableFIFOP();          //enable interrupt when pkt rcvd
    return status;
  }

  /*************************************************************************
   * TunePreset
   * -Set CC2420 channel
   * Valid channel values are 11 through 26.
   * The channels are calculated by:
   *  Freq = 2405 + 5(k-11) MHz for k = 11,12,...,26
   * chnl requested 802.15.4 channel 
   * return Status of the tune operation
   *************************************************************************/
  command result_t CC2420Control.TunePreset(uint8_t chnl) {
    int fsctrl;
    
    fsctrl = 357 + 5*(chnl-11);
    gCurrentParameters[CP_FSCTRL] = (gCurrentParameters[CP_FSCTRL] & 0xfc00) | (fsctrl << CC2420_FSCTRL_FREQ);
    call HPLChipcon.write(CC2420_FSCTRL, gCurrentParameters[CP_FSCTRL]);
    return SUCCESS;
  }

  /*************************************************************************
   * TuneManual
   * Tune the radio to a given frequency. Frequencies may be set in
   * 1 MHz steps between 2400 MHz and 2483 MHz
   * 
   * Desiredfreq The desired frequency, in MHz.
   * Return Status of the tune operation
   *************************************************************************/
  command result_t CC2420Control.TuneManual(uint16_t DesiredFreq) {
   int fsctrl;
   
   fsctrl = DesiredFreq - 2048;
   gCurrentParameters[CP_FSCTRL] = (gCurrentParameters[CP_FSCTRL] & 0xfc00) | (fsctrl << CC2420_FSCTRL_FREQ);
   call HPLChipcon.write(CC2420_FSCTRL, gCurrentParameters[CP_FSCTRL]);
   return SUCCESS;
  }

  /*************************************************************************
   * TxMode
   * Shift the CC2420 Radio into transmit mode.
   * return SUCCESS if the radio was successfully switched to TX mode.
   *************************************************************************/
  async command result_t CC2420Control.TxMode() {
    call HPLChipcon.cmd(CC2420_STXON);
    return SUCCESS;
  }

  /*************************************************************************
   * TxModeOnCCA
   * Shift the CC2420 Radio into transmit mode when the next clear channel
   * is detected.
   *
   * return SUCCESS if the transmit request has been accepted
   *************************************************************************/
  async command result_t CC2420Control.TxModeOnCCA() {
   call HPLChipcon.cmd(CC2420_STXONCCA);
   return SUCCESS;
  }

  /*************************************************************************
   * RxMode
   * Shift the CC2420 Radio into receive mode 
   *************************************************************************/
  async command result_t CC2420Control.RxMode() {
    call HPLChipcon.cmd(CC2420_SRXON);
    return SUCCESS;
  }

  /*************************************************************************
   * SetRFPower
   * power = 31 => full power    (0dbm)
   *          3 => lowest power  (-25dbm)
   * return SUCCESS if the radio power was successfully set
   *************************************************************************/
  command result_t CC2420Control.SetRFPower(uint8_t power) {
    result_t value;
	  
	  //reject bad values 
	  //only 3,7,11,15,19,23,27,31 are valid
	  if (power != 3 && 
	  	  power != 7 && 
	  	  power != 11 && 
	  	  power != 15 && 
	  	  power != 19 && 
	  	  power != 23 &&
	  	  power != 27 &&
	  	  power != 31 ) return FAIL;

	  //set value localy & in register
	  atomic {
		  gCurrentParameters[CP_TXCTRL] = (gCurrentParameters[CP_TXCTRL] & 0xffe0) | (power << CC2420_TXCTRL_PAPWR);
		  value = call HPLChipcon.write(CC2420_TXCTRL,gCurrentParameters[CP_TXCTRL]);
  	  }
	  
	  return value;
  }

  /*************************************************************************
   * GetRFPower
   * return power seeting
   *************************************************************************/
  command uint8_t CC2420Control.GetRFPower() {
    return (gCurrentParameters[CP_TXCTRL] & 0x000f); //rfpower;
  }

  async command result_t CC2420Control.OscillatorOn() {
    uint8_t i;
    uint8_t status;
    bool bXoscOn = FALSE;

    i = 0;
    call HPLChipcon.cmd(CC2420_SXOSCON);   //turn-on crystal
    while ((i < XOSC_TIMEOUT) && (bXoscOn == FALSE)) {
      TOSH_uwait(100);
      status = call HPLChipcon.cmd(CC2420_SNOP);      //read status
      status = status & ( 1 << CC2420_XOSC16M_STABLE);
      if (status) bXoscOn = TRUE;
      i++;
    }
    if (!bXoscOn) return FAIL;
    return SUCCESS;
  }

  async command result_t CC2420Control.OscillatorOff() {
    call HPLChipcon.cmd(CC2420_SXOSCOFF);   //turn-off crystal
    return SUCCESS;
  }

  async command result_t CC2420Control.VREFOn(){
    TOSH_SET_CC_VREN_PIN();                    //turn-on  
    TOSH_uwait(1800);          
  }

  async command result_t CC2420Control.VREFOff(){
    TOSH_CLR_CC_VREN_PIN();                    //turn-off  
    TOSH_uwait(1800);  
  }

  async command result_t CC2420Control.enableAutoAck() {
    gCurrentParameters[CP_MDMCTRL0] |= (1 << CC2420_MDMCTRL0_AUTOACK);
    return call HPLChipcon.write(CC2420_MDMCTRL0,gCurrentParameters[CP_MDMCTRL0]);
  }

  async command result_t CC2420Control.disableAutoAck() {
    gCurrentParameters[CP_MDMCTRL0] &= ~(1 << CC2420_MDMCTRL0_AUTOACK);
    return call HPLChipcon.write(CC2420_MDMCTRL0,gCurrentParameters[CP_MDMCTRL0]);
  }

  command result_t CC2420Control.setShortAddress(uint16_t addr) {
    addr = toLSB16(addr);
    return call HPLChipconRAM.write(CC2420_RAM_SHORTADR, 2, (uint8_t*)&addr);
  }

  async event result_t HPLChipcon.FIFOPIntr() {
    return SUCCESS;
  }

  async event result_t HPLChipconRAM.readDone(uint16_t addr, uint8_t length, uint8_t* buffer) {
     return SUCCESS;
  }

  async event result_t HPLChipconRAM.writeDone(uint16_t addr, uint8_t length, uint8_t* buffer) {
     return SUCCESS;
  }

  /**
  Enable CC2420 Receiver Hardware Address Decode.
  ************************************************************/
  async command result_t CC2420Control.enableAddrDecode() {
    gCurrentParameters[CP_MDMCTRL0] |= (CC2420_ADDRDECODE_ON << CC2420_MDMCTRL0_ADRDECODE);
    return call HPLChipcon.write(CC2420_MDMCTRL0,gCurrentParameters[CP_MDMCTRL0]);
  }
  /**
  Disable CC2420 Receiver Hardware Address Decode.
  ************************************************************/
  async command result_t CC2420Control.disableAddrDecode() {
    gCurrentParameters[CP_MDMCTRL0] &= ~(1 << CC2420_MDMCTRL0_ADRDECODE); //invert/clear
    return call HPLChipcon.write(CC2420_MDMCTRL0,gCurrentParameters[CP_MDMCTRL0]);
  }
  
  /*************************************************************************
   * Radio Control interface
   * 
   *************************************************************************/
   command result_t RadioControl.TunePreset(uint8_t freq) {
	   return call CC2420Control.TunePreset(freq);
   }

   command uint32_t RadioControl.TuneManual(uint32_t DesiredFreq) {
	   return call CC2420Control.TuneManual(DesiredFreq);
   }
   
   command result_t RadioControl.SetRFPower(uint8_t power) {
	   return call CC2420Control.SetRFPower(power);
	   
   }

   command uint8_t  RadioControl.GetRFPower() {
	   return call CC2420Control.GetRFPower();
   }
   
	
}//CC2420ControlM module


