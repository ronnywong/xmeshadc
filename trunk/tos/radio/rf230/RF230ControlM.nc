/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RF230ControlM.nc,v 1.1.2.2 2007/04/27 05:01:48 njain Exp $
 */

 
#define RESET_ON_CCA_ERROR
#define RESET_ON_WAKEUP

module RF230ControlM {
	provides {

		interface SplitControl;
		interface RF230Control;
	}
	
	uses {
		interface HPLRF230Init;	//initialization
		interface HPLRF230;  	//registers access
		
		interface StdControl as TimerControl;
		interface Timer as initTimer;
		
		//start the interrupt, don't enable events
		interface StdControl as InterruptControl;
		
		//interface PowerManagement;
		
		interface Leds;
	}
	
}

implementation {

#include "pinMacros.h"	
	
/* === Module state ======================================================== */
	
	//TOS_RF230_TXPOWER - defined in RF230const.h
	//TOS_RF230_CHANNEL - defined in RF230const.h
	
	enum {
		RF230_CTL_POWERON,
		//RF230_CTL_INIT,
		//RF230_CTL_INIT_DONE,
		RF230_CTL_START,
		RF230_CTL_START_DONE
		//RF230_CTL_STOP,
		//RF230_CTL_STOP_DONE
	};
	
	uint8_t controlState = RF230_CTL_POWERON;		//inital value

/* === Funciton Prototypes ================================================= */

	result_t powerOnInitial();
	result_t powerOnSleep();
	void initRegisters();

/* === Tasks =============================================================== */

	task void sigInitDone() {
		//DO NOT USE
	}
	
	task void sigStartDone() {
		//release state lock		
		atomic controlState = RF230_CTL_START_DONE;		//atomic overkill	
		signal SplitControl.startDone();
	}
	
	task void sigStopDone() {
		//DO NOT USE
	}
	
/* === Initialization Functions ============================================ */

  /**
   *
   */
  result_t powerOnInitial() {
	  
	  //P_ON

	  TOSH_uwait2(RF_230_OSC_STABLE_TIME_US);		//650us
	  call RF230Control.set_TRX_OFF();
	  TOSH_uwait2(RF_230_CLK_STABLE_TIME_US);		//256us  
	  
	  //reset
	  //initialize radio registers
	  //waits for TRX_OFF
	  call RF230Control.resetRadio();				//120us
	  
	  //NOTE:
	  //setup capture upedge.  This doesn't enable events, only sets up edge, 
	  //clears old events.  We do this here so that we can capture a rx_int 
	  //before events are enabled in RawM module.  Recall interrupts occruing
	  //before event enable are queued up.
	  call InterruptControl.start();
	  
	  //TRX_OFF
	  call RF230Control.set_RX_ON();
	  TOSH_uwait2(RF_230_PLL_ON_SETTLE_TIME_US);	//200us
	  
	  //RX_ON
	  
	  if (post sigStartDone()) return SUCCESS; else return FAIL;
	  
  }
  
  /**
   *
   */
  result_t powerOnSleep() {
	  
	  //SLEEP
	  TOSH_CLR_RF230_SLP_TR_PIN();
	  
	  return (call initTimer.start(TIMER_ONE_SHOT, 1));		//this fires ~ 2 - 3 ms
	  
	  //SLEEP -> PLL_ON/RX_ON
	  //No interrupt occurs to allow us to do this
	  
  }
  
  /**
   *
   */
  void initRegisters() {
	  
	  //CLKM Output - default to 1mhz
	  //PAD Current - default to 2mA & 4mA
	  //Auto CRC	- not on
	  //CCA Mode	- default to Energy above threshold
	  //VReg 		- default?
	  //BattMon		- not used
	  //XOSC		- default to internal + no trim
	  //FTN			- how does the filter tuning work, does it need recal?
	  
	  call HPLRF230.bitWrite(SR_TX_PWR, TOS_RF230_TXPOWER);		//tx pwr
	  call HPLRF230.bitWrite(SR_CHANNEL, TOS_RF230_CHANNEL);	//channel 
	  call HPLRF230.writeReg(RG_IRQ_MASK, TRX_KNOWN_IRQS);		//irq mask
	  call HPLRF230.writeReg(RG_TRX_CTRL_0, 0x08);				//disable CLKM
		  
  }
  
/* === Split Control ======================================================= */

  /**
   * Initialize the component and its subcomponents.
   *
   * @return Whether initialization was successful.
   */
  command result_t SplitControl.init() {
	
	  call TimerControl.init();
	  call HPLRF230Init.init();
	  call InterruptControl.init();
	  call Leds.init();
	  
	  return SUCCESS;
	  
	  //LOCK OUT REPEAT CALLS:
	  //Too much hassel to lock out repeat calls of this.  These call usually
	  //can be to be recalled without ill effect before the modules starts.
	  //Also it should be the responsibility of the upper module to make sure this
	  //module isn't called too many times.
	  
	  //SPLIT PHASE:
	  //Split phase isn't used.  Nothing ever signals initDone().  The reason 
	  //for this is two folds.  First it will allow the layer which translates 
	  //splitControl to stdControl possible.  Otherwise if a user calls start 
	  //before initDone comes back, how will the bridging module handle this?
	  //If it returns fail then it isn't a very good bridge since the user will
	  //assume after init return he can call start.  Second it makes initialization
	  //eaiser since caller of this module doesn't have to use it like a split
	  //phase.
  }


  /**
   * Start the component and its subcomponents.  
   *
   * @return Whether starting was successful.
   */
  command result_t SplitControl.start() {
	  bool bPowerOn = TRUE;
	  bool result;
	  
	  //State Check: In many ways atomic in unnecessary
	  atomic {
		  if (controlState == RF230_CTL_START) {
			  result = FALSE;
		  } else {
			  result = TRUE;
			  if (controlState == RF230_CTL_POWERON) bPowerOn = TRUE;
			  else bPowerOn = FALSE;
			  controlState = RF230_CTL_START;
		  }
	  }
	  
	  //the previous start call has not completed
	  if (!result) return FAIL;
	  
	  //Start
	  //call TimerControl.start();  //start does nothing in TimerM
	  
	  if (bPowerOn) {
		  return powerOnInitial();
	  } else {
		  return powerOnSleep();
	  }

	  //NOTE:
	  //Registers are set in the powerOn____ functions
	  
	  //NOTE:
	  //Interrupts are started but even aren't enabled here - radioM
	  
	  //NOTE:
	  //SOME WHERE I NEED TO MAKE SURE THAT THE STATE IS IN PLL_ON
  }



  /**
   * Stop the component and pertinent subcomponents (not all
   * subcomponents may be turned off due to wakeup timers, etc.).
   *
   * @return Whether stopping was successful.
   */
  command result_t SplitControl.stop() {
	  
	  //stop - doesn't disable events
	  call InterruptControl.stop();
	  
	  //force trx_off
	  call RF230Control.force_TRX_OFF();
	  TOSH_SET_RF230_SLP_TR_PIN();
	  
	  //SLEEP
	  return SUCCESS;
	  
	  //NOTE:
	  //State aren't protected here
	  
	  //SPLIT PHASE:
	  //Split phase isn't used.  Nothing ever signals stopDone(). 
  }
  

  
/* === Timer Fire ========================================================== */

  /**
   *  @brief Handle milisecond timer fire
   *
   *  @return result_t SUCCESS
   */
   event result_t initTimer.fired() {
	   
	   //TRX_OFF
	   	   
	   //RESET:
	   //This reset should not be necessary.  However the low power mac
	   //missbehaves when i do not do this reset.  Must figure out if this
	   //is an hardware or software issue.  Reset function call will init
	   //registers
	   #ifdef RESET_ON_WAKEUP
	   	call RF230Control.resetRadio();  //120us
	   #else
	   	initRegisters();
	   #endif
	   
	   //NOTE:
	   //setup capture upedge.  This doesn't enable events, only sets up edge, 
	   //clears old events.  We do this here so that we can capture a rx_int 
	   //before events are enabled in RawM module.  Recall interrupts occruing
	   //before event enable are queued up.
	   call InterruptControl.start();
	   
	   //TRX_OFF
	   call RF230Control.set_RX_ON();
	   TOSH_uwait2(RF_230_PLL_ON_SETTLE_TIME_US);	//200us
	   
	   //RX_ON
	   
	   //release lock state
	   atomic controlState = RF230_CTL_START_DONE;		//atomic overkill
	   
	   //must signal here, screwed if post fails
	   signal SplitControl.startDone();
	   
	   return SUCCESS;
	   
	   //NOTE:
	   //Interrupt enable/disable controlled in radioM.
	   
	}
   
	
/* === RF230Control ======================================================== */
	

/* === General Reset ======================================================= */

  /**
   * @brief Reset the radio and reinitialize the registers
   *
   */
  async command void RF230Control.resetRadio() {
	  
	  TOSH_CLR_RF230_RSTN_PIN();
	  TOSH_uwait2(1);
	  TOSH_SET_RF230_RSTN_PIN();
	  TOSH_uwait2(RF_230_RESET_SETTLE_TIME_US);	//120us
	  
	  //TRX_OFF
	  initRegisters();
	  
	  return;
  }
  	
/* === Channel Settings ==================================================== */
	
  /**
   * Tune the radio to one of the 802.15.4 present channels.
   * Valid channel values are 11 through 26.
   * The channels are calculated by:
   *  Freq = 2405 + 5(k-11) MHz for k = 11,12,...,26
   * 
   * @param freq requested 802.15.4 channel
   * 
   * @return Status of the tune operation
   */
  async command result_t RF230Control.TunePreset(uint8_t channel) {
	  if (channel < 11 || channel > 26) return FAIL;
	  call HPLRF230.bitWrite(SR_CHANNEL, channel);
	  
	  return SUCCESS;
  }
  
  async command uint8_t RF230Control.GetPreset() {
	  uint8_t value;
	  call HPLRF230.bitRead(SR_CHANNEL, &value);
	  
	  return value;
  }

  /**
   * Tune the radio to a given frequency. Frequencies may be set in
   * 1 MHz steps between 2400 MHz and 2483 MHz
   * 
   * @param freq The desired channel frequency, in MHz.
   * 
   * @return Status of the tune operation
   */
  async command result_t RF230Control.TuneManual(uint16_t freq) {
	  return call RF230Control.TunePreset(ftoc(freq));
  }
  
  async command uint16_t RF230Control.GetManual() {
	  return ctof(call RF230Control.GetPreset());
  }

/* === Power Settings ====================================================== */

  /**
   * Set the transmit RF power value.  The input value is platform dependent.
   * consult datasheet for the resulting power output/current consumption 
   * values.
   *
   * @param power A power index between 1 and 15.
   * 
   * @return SUCCESS if the radio power was adequately set.
   */
  async command result_t RF230Control.SetRFPower(uint8_t power) {
	  call HPLRF230.bitWrite(SR_TX_PWR, power);
	  
	  return SUCCESS;
  }

  /**
   * Get the present RF power index.
   *
   * @reutrn The power index value.
   */
  async command uint8_t RF230Control.GetRFPower() {
	  uint8_t value;
	  call HPLRF230.bitRead(SR_TX_PWR, &value);
	  
	  return value;
  }
  
/* === RSSI / CRC / CCA / ED =============================================== */

  /**
   * @brief get the CRC and RSSI values after a packet reception
   *
   * @param crcValid ptr to a bool that indicates if crc is valid
   * @param rssi value representing rssi
   * @return void
   */
  async command void RF230Control.getRSSIandCRC(bool * crcValid, uint8_t * rssi) {
	  uint8_t value;
	  
	  value = call HPLRF230.readReg(RG_PHY_RSSI);
	  	  
	  if (value & 0x80) *crcValid = TRUE; else *crcValid = FALSE;
	  
	  *rssi  = call HPLRF230.readReg(RG_PHY_ED_LEVEL);
  }
  
  /**
   * @brief Get the value of the energy detection
   *
   * @param  void
   * @return rf energy in db
   */
  async command uint8_t RF230Control.getED() {
	  call HPLRF230.writeReg(RG_PHY_ED_LEVEL, 50);	//write anything to initiate
	  TOSH_uwait2(RF_230_ED_WAIT_TIME_US);	//200us
	  return call HPLRF230.readReg(RG_PHY_ED_LEVEL);
  }
  
  /**
   * @brief get the results of the clear channel assessment
   *
   * The radio must be in RX_ON state.  Repeated Calls to CCA will result in error.
   * Error condition can be detected when cca takes longer than 128us.
   *
   * @param  void
   * @return bool, is the channel clear or not
   */
  async command bool RF230Control.CCA() {
	  uint8_t value;

IO_DEBUG_SET(CCA_TIME);

	  call HPLRF230.bitWrite(SR_CCA_REQUEST, 1);	//initiate the cca
	  TOSH_uwait2(RF_230_CCA_WAIT_TIME_US);			//wait for value ready - 200us
	  
	  value = call HPLRF230.readReg(RG_TRX_STATUS);
	  
IO_DEBUG_CLR(CCA_TIME);

	  if (value & 0x80) {
		  //CCA Ready	  
		  if (value & 0x40) return TRUE; else return FALSE;
		  
	  } else {
		  //CCA Not Ready
		  
		  #ifdef RESET_ON_CCA_ERROR
		  	//call Leds.greenToggle();
		  	call RF230Control.resetRadio();
		  	call RF230Control.set_RX_ON();	//assume previous state was RX_ON
		  	TOSH_uwait2(RF_230_RX_ON_SETTLE_TIME_US);	//100us
		  #endif
		  
		  return FALSE;
	  }
  }
  
/* === Radio State Transitions ============================================= */

  /**
   * @brief set the radio state to TRX_OFF (with out forcing)
   *
   */
  async command void RF230Control.set_TRX_OFF() {
	  call HPLRF230.bitWrite(SR_TRX_CMD, CMD_TRX_OFF);	//does not force
  }
  
  /**
   * @brief set the radio state to TRX_OFF (with force) - terminate active send/recv
   *
   */
  async command void RF230Control.force_TRX_OFF() {
	  call HPLRF230.bitWrite(SR_TRX_CMD, CMD_FORCE_TRX_OFF);	//force
  }
  
  /**
   * @brief set the radio state to PLL_ON for transmission
   *
   */
  async command void RF230Control.set_PLL_ON() {
	  call HPLRF230.bitWrite(SR_TRX_CMD, CMD_PLL_ON);
  }
  
  /**
   * @brief set the radio state to RX_ON for reception
   *
   */
  async command void RF230Control.set_RX_ON() {
	  call HPLRF230.bitWrite(SR_TRX_CMD, CMD_RX_ON);
  }

/* === Test Interfaces ===================================================== */
	
	
}
