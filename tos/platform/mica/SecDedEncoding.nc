/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SecDedEncoding.nc,v 1.1.4.1 2007/04/26 00:27:07 njain Exp $
 */

module SecDedEncoding{
  provides {
    interface RadioEncoding as Code;
  }
}

implementation{
  enum {
    IDLE_STATE         = 0,
    DECODING_BYTE_3    = 1,
    DECODING_BYTE_2    = 2,
    DECODING_BYTE_1    = 3,
    ENCODING_BYTE      = 4
  };
  
  char data1;
  char data2;
  char data3;
  char state;                     // state of this component
  
  void radio_decode_thread();
  void radio_encode_thread();
  
  async command result_t Code.decode(char d1){
    result_t rval = 1;
    atomic {
      if(state == IDLE_STATE){
	state = DECODING_BYTE_1;
	data1 = d1;
      }else if(state == DECODING_BYTE_1){
	state = DECODING_BYTE_2;
	data2 = d1;
      }else if(state == DECODING_BYTE_2){
	state = DECODING_BYTE_3;
	data3 = d1;	
	radio_decode_thread();
      }else {
	rval = 0;
      }
    }
    return rval;
  }


  async command result_t Code.encode_flush(){
    return 1;
  }
  
  async command result_t Code.encode(char d){
    uint8_t oldState;
    atomic {
      oldState = state;
      if(state == IDLE_STATE){
	state = ENCODING_BYTE;
	data1 = d;
      }
    }
    if (oldState == IDLE_STATE) {
      radio_encode_thread();
      return 1;
    }
    else {
      return 0;
    }
  }

  /* This function encode the data using SEC_DED encoding */
  void radio_encode_thread(){
    char ret_high = 0;
    char ret_low = 0;
    char parity = 0;
    char val;
    atomic {
      val = data1;
    }
    //encode then expand.
     
    //encode first.
     
    if((val & 0x1) != 0) {
      parity ^=0x5b;
      ret_low |= 0x1;
    } else { ret_low |= 0x2;}
     
    if((val & 0x2) != 0) {
      parity ^=0x58;
      ret_low |= 0x4;} 
    else { ret_low |= 0x8;}

    if((val & 0x4) != 0) {
      parity ^=0x52;
      ret_low |= 0x10;} 
    else { ret_low |= 0x20;}

    if((val & 0x8) != 0) {
      parity ^=0x51;
      ret_low |= 0x40;} 
    else { ret_low |= 0x80;}

    if((val & 0x10) != 0) {
      parity ^=0x4a;
      ret_high |= 0x1;} 
    else { ret_high |= 0x2;}

    if((val & 0x20) != 0) {
      parity ^=0x49;
      ret_high |= 0x4;} 
    else { ret_high |= 0x8;}

    if((val & 0x40) != 0) {
      parity ^=0x13;
      ret_high |= 0x10;} 
    else { ret_high |= 0x20;}

    if((val & 0x80) != 0) {
      parity ^=0x0b;
      ret_high |= 0x40;} 
    else { ret_high |= 0x80;}
     
    //now balance the the parity parts.
     
    if(!(parity & 0x40)) parity |= 0x80;
    if(!(parity & 0x50)) parity |= 0x20;
    if(!(parity & 0xa)) parity |= 0x4;

    atomic {
      state = IDLE_STATE;
    }
    signal Code.encodeDone(parity);
    signal Code.encodeDone(ret_high);
    signal Code.encodeDone(ret_low);

  }

  /* This function decodes SEC_DED encoded data */
  void radio_decode_thread(){
    
    //strip the data
    char ret_high = 0;
    char ret_low = 0;
    char parity;
    char error = 0;
    short encoded_value = 0;
    atomic {
      parity = data1;
      ret_high = data2;
      ret_low = data3;
    }
     
    if((ret_low & 0x1) != 0) encoded_value |= 0x1;  
    if((ret_low & 0x4) != 0) encoded_value |= 0x2;
    if((ret_low & 0x10) != 0) encoded_value |= 0x4;
    if((ret_low & 0x40) != 0) encoded_value |= 0x8;
    if((ret_high & 0x01) != 0) encoded_value |= 0x10;
    if((ret_high & 0x04) != 0) encoded_value |= 0x20;
    if((ret_high & 0x10) != 0) encoded_value |= 0x40;
    if((ret_high & 0x40) != 0) encoded_value |= 0x80;

    parity = (parity & 0x3) | ((parity & 0x18) >> 1) | ((parity & 0x40) >> 2);
    encoded_value =  encoded_value << 5 | parity;

    // check the parity
    parity = 0;
    if((encoded_value & 0x1) != 0) parity ^= 0x1;
    if((encoded_value & 0x2) != 0) parity ^= 0x2;
    if((encoded_value & 0x4) != 0) parity ^= 0x4;
    if((encoded_value & 0x8) != 0) parity ^= 0x8;
    if((encoded_value & 0x10) != 0) parity ^= 0x10;
    if((encoded_value & 0x20) != 0) parity ^= 0x1f;
    if((encoded_value & 0x40) != 0) parity ^= 0x1c;
    if((encoded_value & 0x80) != 0) parity ^= 0x1a;
    if((encoded_value & 0x100) != 0) parity ^= 0x19;
    if((encoded_value & 0x200) != 0) parity ^= 0x16;
    if((encoded_value & 0x400) != 0) parity ^= 0x15;
    if((encoded_value & 0x800) != 0) parity ^= 0xb;
    if((encoded_value & 0x1000) != 0) parity ^= 0x7;
     
    //now fix the error.
    error = -1;
    if(parity == 0){}
    else if(parity == 0x1) { encoded_value ^= 0x1;}
    else if(parity == 0x2) { encoded_value ^= 0x2; }
    else if(parity == 0x4) { encoded_value ^= 0x4; }
    else if(parity == 0x8) { encoded_value ^= 0x8; }
    else if(parity == 0x10) { encoded_value ^= 0x10;}
    else{
      error = 0;
      if(parity == 0x1f) { encoded_value ^= 0x20;}
      else if(parity == 0x1c) { encoded_value ^= 0x40;}
      else if(parity == 0x1a) { encoded_value ^= 0x80;}
      else if(parity == 0x19) { encoded_value ^= 0x100; }
      else if(parity == 0x16) { encoded_value ^= 0x200; }
      else if(parity == 0x15) { encoded_value ^= 0x400; }
      else if(parity == 0xb) { encoded_value ^= 0x800; }
      else if(parity == 0x7) { encoded_value ^= 0x1000;}
      else {
	error = 1;
      }
    }
     
    //pull off the data bits
    atomic {
      state = IDLE_STATE;
    }
    signal Code.decodeDone((encoded_value >> 5) & 0xff, error);
  }
}
