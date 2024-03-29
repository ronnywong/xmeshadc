/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430I2CM.nc,v 1.1.4.1 2007/04/26 22:10:34 njain Exp $
 */

/**
 * @author Joe Polastre
 * Revision:  $Revision: 1.1.4.1 $
 * 
 * Primitives for accessing the hardware I2C module on MSP430 microcontrollers.
 * This module assumes that the bus is available and reserved prior to the
 * commands in this module being invoked.  Most applications will use the
 * readPacket and writePacket interfaces as they provide the master-mode
 * read and write operations from/to a slave device.  An I2C slave
 * implementation may be built above the primitives provided in this module.
 */

includes msp430usart;

module MSP430I2CM
{
  provides {
    interface StdControl;
    interface MSP430I2C;
    interface MSP430I2CPacket;
    interface MSP430I2CEvents;
  }
  uses {
    interface HPLUSARTControl as USARTControl;
    interface HPLI2CInterrupt;
  }
}
implementation
{
  // 16-bit writes are atomic
  MSP430REG_NORACE(I2COA);
  MSP430REG_NORACE(I2CSA);
  MSP430REG_NORACE(I2CNDAT);
  MSP430REG_NORACE(I2CDR);
  MSP430REG_NORACE(I2CTCTL);

#ifndef __msp430_have_usart0_with_i2c
#error MSP430I2C: Compiling with hardware I2C support, but MCU does not support I2C
#endif

  // init() command causes nesC to complain about a race condition
  // other variables protected by only being modified when the stateI2C
  // variable allows modification (ie stateI2C != IDLE)
  norace uint8_t stateI2C;
  uint8_t length;
  uint8_t ptr;
  norace result_t result;
  uint8_t* data;
  msp430_usartmode_t usart_mode;

  enum {
    OFF = 1,
    IDLE,
    PACKET_WRITE,
    PACKET_READ
  };

  task void readDone() {
    // variables protected from change by the stateI2C state machine
    result_t _result;
    uint8_t _length;
    uint8_t* _data;
    uint16_t _addr;

    _result = result;
    _length = length;
    _data = data;
    _addr = I2CSA;

    atomic stateI2C = IDLE;
    signal MSP430I2CPacket.readPacketDone(_addr, _length, _data, _result);
  }

  task void writeDone() {
    // variables protected from change by the stateI2C state machine
    result_t _result;
    uint8_t _length;
    uint8_t* _data;
    uint16_t _addr;

    _result = result;
    _length = length;
    _data = data;
    _addr = I2CSA;

    // wait for the module to finish its transmission
    // spin only lasts ~4bit times == 4us.
    while (I2CDCTL & I2CBUSY) ;

    atomic stateI2C = IDLE;
    signal MSP430I2CPacket.writePacketDone(_addr, _length, _data, _result);
  }

  command result_t StdControl.init() {
    // init does not apply to "non-atomic access to shared variable"
    stateI2C = OFF;
    return SUCCESS;
  }

  command result_t StdControl.start() {
    uint8_t _state = 0;
    
    atomic {
      _state = stateI2C;
      if (_state == OFF) 
	stateI2C = IDLE;
    }

    if (_state == OFF) {
      usart_mode = call USARTControl.getMode();
      if (usart_mode != USART_I2C)
	call USARTControl.setModeI2C();
      return SUCCESS;
    }
    else if (_state == IDLE)
      return SUCCESS;

    return FAIL;
  }

  command result_t StdControl.stop() {
    atomic {
      stateI2C = OFF;
      call MSP430I2C.disable();
    }
    call USARTControl.setMode(usart_mode);
    return SUCCESS;
  }

  async command result_t MSP430I2C.isArbitrationLostPending() {
    if (I2CIFG & ALIFG){
      I2CIFG &= ~ALIFG;
      return SUCCESS;
    }
    return FAIL;
  }

  async command result_t MSP430I2C.isNoAckPending() {
    if (I2CIFG & NACKIFG){
      I2CIFG &= ~NACKIFG;
      return SUCCESS;
    }
    return FAIL;
  }

  async command result_t MSP430I2C.isOwnAddrPending() {
    if (I2CIFG & OAIFG){
      I2CIFG &= ~OAIFG;
      return SUCCESS;
    }
    return FAIL;
  }

  async command result_t MSP430I2C.isReadyRegAccessPending() {
    if (I2CIFG & ARDYIFG){
      I2CIFG &= ~ARDYIFG;
      return SUCCESS;
    }
    return FAIL;
  }

  async command result_t MSP430I2C.isReadyRxDataPending() {
    if (I2CIFG & RXRDYIFG){
      I2CIFG &= ~RXRDYIFG;
      return SUCCESS;
    }
    return FAIL;
  }

  async command result_t MSP430I2C.isReadyTxDataPending() {
    if (I2CIFG & TXRDYIFG){
      I2CIFG &= ~TXRDYIFG;
      return SUCCESS;
    }
    return FAIL;
  }

  async command result_t MSP430I2C.isGeneralCallPending() {
    if (I2CIFG & GCIFG){
      I2CIFG &= ~GCIFG;
      return SUCCESS;
    }
    return FAIL;
  }

  async command result_t MSP430I2C.isStartRecvPending() {
    if (I2CIFG & STTIFG){
      I2CIFG &= ~STTIFG;
      return SUCCESS;
    }
    return FAIL;
  }

  async command void MSP430I2C.enableArbitrationLost() {
    atomic I2CIE |= ALIE;
  }
  async command void MSP430I2C.enableNoAck() {
    atomic I2CIE |= NACKIE;
  }
  async command void MSP430I2C.enableOwnAddr() {
    atomic I2CIE |= OAIE;
  }
  async command void MSP430I2C.enableReadyRegAccess() {
    atomic I2CIE |= ARDYIE;
  }
  async command void MSP430I2C.enableReadyRxData() {
    atomic I2CIE |= RXRDYIE;
  }
  async command void MSP430I2C.enableReadyTxData() {
    atomic I2CIE |= TXRDYIE;
  }
  async command void MSP430I2C.enableGeneralCall() {
    atomic I2CIE |= GCIE;
  }
  async command void MSP430I2C.enableStartRecv() {
    atomic I2CIE |= STTIE;
  }

  async command void MSP430I2C.disableArbitrationLost() {
    atomic I2CIE &= ~ALIE;
  }
  async command void MSP430I2C.disableNoAck() {
    atomic I2CIE &= ~NACKIE;
  }
  async command void MSP430I2C.disableOwnAddr() {
    atomic I2CIE &= ~OAIE;
  }
  async command void MSP430I2C.disableReadyRegAccess() {
    atomic I2CIE &= ~ARDYIE;
  }
  async command void MSP430I2C.disableReadyRxData() {
    atomic I2CIE &= ~RXRDYIE;
  }
  async command void MSP430I2C.disableReadyTxData() {
    atomic I2CIE &= ~TXRDYIE;
  }
  async command void MSP430I2C.disableGeneralCall() {
    atomic I2CIE &= ~GCIE;
  }
  async command void MSP430I2C.disableStartRecv() {
    atomic I2CIE &= ~STTIE;
  }

  async command result_t MSP430I2C.setModeMaster() {
    bool _res = FAIL;
    atomic {
      if (call USARTControl.isI2C()) {
	U0CTL |= MST;
	_res = SUCCESS;
      }
    }
    return _res;
  }

  async command result_t MSP430I2C.setModeSlave() {
    bool _res = FAIL;
    atomic {
      if (call USARTControl.isI2C()) {
	U0CTL &= ~MST;
	_res = SUCCESS;
      }
    }
    return _res;
  }

  async command result_t MSP430I2C.setAddr7bit() {
    bool _res = FAIL;
    atomic {
      if (call USARTControl.isI2C()) {
	U0CTL &= ~XA;
	_res = SUCCESS;
      }
    }
    return _res;
  }

  async command result_t MSP430I2C.setAddr10bit() {
    bool _res = FAIL;
    atomic {
      if (call USARTControl.isI2C()) {
	U0CTL |= XA;
	_res = SUCCESS;
      }
    }
    return _res;
  }

  async command result_t MSP430I2C.setOwnAddr(uint16_t _addr) {
    bool _res = FAIL;
    atomic {
      if (call USARTControl.isI2C()) {
	U0CTL &= ~I2CEN;
	I2COA = _addr;
	U0CTL |= I2CEN;
	_res = SUCCESS;
      }
    }
    return _res;
  }

  async command result_t MSP430I2C.setSlaveAddr(uint16_t _addr) {
    I2CSA = _addr;
  }

  // only valid in master mode
  async command result_t MSP430I2C.setTx() {
    bool _res = FAIL;
    atomic {
      if ((call USARTControl.isI2C()) && (U0CTL & MST)) {
	I2CTCTL |= I2CTRX;
	_res = SUCCESS;
      }
    }
    return _res;
  }

  // only valid in master mode
  async command result_t MSP430I2C.setRx() {
    bool _res = FAIL;
    atomic {
      if ((call USARTControl.isI2C()) && (U0CTL & MST)) {
	I2CTCTL &= ~I2CTRX;
	_res = SUCCESS;
      }
    }
    return _res;
  }

  async command result_t MSP430I2C.setData(uint16_t value) {
    bool _res = FAIL;
    if (call USARTControl.isI2C()) {
      I2CDR = value;
      _res = SUCCESS;
    }
    return _res;
  }

  async command uint16_t MSP430I2C.getData() {
    return I2CDR;
  }

  async command result_t MSP430I2C.setByteCount(uint8_t value) {
    if (call USARTControl.isI2C()) {
      I2CNDAT = value;
      return SUCCESS;
    }
    return FAIL;
  }

  async command uint8_t MSP430I2C.getByteCount() {
    return I2CNDAT;
  }

  async command result_t MSP430I2C.enable() {
    result_t _res = FAIL;
    atomic {
      if (call USARTControl.isI2C()) {
	U0CTL |= I2CEN | I2C;
	_res = SUCCESS;
      }
    }
    return _res;
  }

  async command result_t MSP430I2C.disable() {
    result_t _res = FAIL;
    atomic {
      if (call USARTControl.isI2C()) {
	U0CTL &= ~I2CEN;
	U0CTL &= ~I2C;
	_res = SUCCESS;
      }
    }
    return _res;
  }

  command result_t MSP430I2CPacket.readPacket(uint16_t _addr, uint8_t _length, uint8_t* _data) {
    uint8_t _state;

    atomic {
      _state = stateI2C;
      if (_state == IDLE) {
	stateI2C = PACKET_READ;
      }
    }

    if (_state == IDLE) {
      // perform register modifications with interrupts disabled
      // to maintain consistent state
      atomic {
	result = FAIL;

	// disable I2C to set the registers
	U0CTL &= ~I2CEN;

	I2CSA = _addr;

	length = _length;
	data = _data;
	ptr = 0;

	U0CTL |= MST;

	// enable I2C module
	U0CTL |= I2CEN;
	
	I2CNDAT = _length;

	// set transmit mode
	I2CTCTL &= ~I2CTRX;

	// get an event if the receiver does not ACK
	I2CIE = RXRDYIE | NACKIE;
	I2CIFG = 0;

	// start condition and stop condition need to be sent
	I2CTCTL |= (I2CSTP | I2CSTT);
      }

      return SUCCESS;
    }

    return FAIL;
  }

  // handle the interrupt within this component
  void localRxData() {
    uint16_t* _data16 = (uint16_t*)data;

    if (stateI2C != PACKET_READ)
      return;

    // figure out where we are in the transmission
    // should only occur when I2CNDAT > 0
    if (I2CTCTL & I2CWORD) {
      _data16[(int)ptr] = I2CDR;
      ptr = ptr + 2;
    }
    else {
      data[(int)ptr] = I2CDR & 0xFF;
      ptr++;
    }

    I2CIFG = 0;
    
    if (ptr == length) {
      I2CIE &= ~RXRDYIE;
      result = SUCCESS;
      if (!post readDone())
	stateI2C = IDLE;
    }
  }

  command result_t MSP430I2CPacket.writePacket(uint16_t _addr, uint8_t _length, uint8_t* _data) {
    uint8_t _state;

    atomic {
      _state = stateI2C;
      if (_state == IDLE) {
	stateI2C = PACKET_WRITE;
      }
    }

    if (_state == IDLE) {
      // perform register modifications with interrupts disabled
      atomic {
	// disable I2C to set the registers
	result = FAIL;

	U0CTL &= ~I2CEN;

	I2CSA = _addr;
	
	length = _length;
	data = _data;
	ptr = 0;

	U0CTL |= MST;
	
	// enable I2C module
	U0CTL |= I2CEN;
	
	I2CNDAT = _length;

	// set transmit mode
	I2CTCTL |= I2CTRX;

	// get an event if the receiver does not ACK
	I2CIE = TXRDYIE | NACKIE;
	I2CIFG = 0;

	// start condition and stop condition need to be sent
	I2CTCTL |= (I2CSTP | I2CSTT);
      }

      return SUCCESS;
    }

    return FAIL;
  }

  // handle the interrupt within this component
  void localTxData() {
    uint16_t* _data16 = (uint16_t*)data;

    if (stateI2C != PACKET_WRITE)
      return;

    // figure out where we are in the transmission
    // should only occur when I2CNDAT > 0
    if (I2CTCTL & I2CWORD) {
      I2CDR = _data16[(int)ptr];
      ptr = ptr + 2;
    }
    else {
      I2CDR = data[(int)ptr];
      ptr++;
    }

    I2CIFG = 0;
    
    if (ptr == length) {
      I2CIE &= ~TXRDYIE;
      result = SUCCESS;
      if (!post writeDone())
	stateI2C = IDLE;
    }
  }

  // handle the interrupt within this component
  void localNoAck() {
    if ((stateI2C != PACKET_WRITE) || (stateI2C != PACKET_READ))
      return;

    I2CNDAT = 0;

    // issue a stop command to clear the bus if it has not been stopped
    if (I2CDCTL & I2CBB)
      I2CTCTL |= I2CSTP;

    if (stateI2C == PACKET_WRITE) {
      if (!post writeDone())
	stateI2C = IDLE;
    }
    else if (stateI2C == PACKET_READ) {
      if (!post readDone())
	stateI2C = IDLE;
    }
  }

  async event void HPLI2CInterrupt.fired() {
    volatile uint16_t value = I2CIV;
    switch (value) {
    case 0x0000:
      break;
    case 0x0002:
      signal MSP430I2CEvents.arbitrationLost();
      break;
    case 0x0004:
      localNoAck();
      signal MSP430I2CEvents.noAck();
      break;
    case 0x0006:
      signal MSP430I2CEvents.ownAddr();
      break;
    case 0x0008:
      signal MSP430I2CEvents.readyRegAccess();
      break;
    case 0x000A:
      localRxData();
      signal MSP430I2CEvents.readyRxData();
      break;
    case 0x000C:
      localTxData();
      signal MSP430I2CEvents.readyTxData();
      break;
    case 0x000E:
      signal MSP430I2CEvents.generalCall();
      break;
    case 0x0010:
      signal MSP430I2CEvents.startRecv();
      break;
    }
  }

  default event void MSP430I2CPacket.readPacketDone(uint16_t _addr, uint8_t _length, uint8_t* _data, result_t _success) { }
  default event void MSP430I2CPacket.writePacketDone(uint16_t _addr, uint8_t _length, uint8_t* _data, result_t _success) { }

  default async event void MSP430I2CEvents.arbitrationLost() { }
  default async event void MSP430I2CEvents.noAck() { }
  default async event void MSP430I2CEvents.ownAddr() { }
  default async event void MSP430I2CEvents.readyRegAccess() { }
  default async event void MSP430I2CEvents.readyRxData() { }
  default async event void MSP430I2CEvents.readyTxData() { }
  default async event void MSP430I2CEvents.generalCall() { }
  default async event void MSP430I2CEvents.startRecv() { }

}
