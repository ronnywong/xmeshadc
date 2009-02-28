/*
 * Copyright (c) 2002-2005 Intel Corporation
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: FramerM.nc,v 1.1.4.2 2007/04/26 19:37:03 njain Exp $
 */

/* 
 * Author: Phil Buonadonna
 * Revision: $Revision: 1.1.4.2 $
 * 
 */

/*
 * FramerM
 * 
 * This modules provides framing for TOS_Msg's using PPP-HDLC-like framing 
 * (see RFC 1662).  When sending, a TOS_Msg is encapsulated in an HLDC frame.
 * Receiving is similar EXCEPT that the component expects a special token byte
 * be received before the data payload. The purpose of the token is to feed back
 * an acknowledgement to the sender which serves as a crude form of flow-control.
 * This module is intended for use with the Packetizer class found in
 * tools/java/net/packet/Packetizer.java.
 * 
 */

/**
 * @author Phil Buonadonna
 */

 /* Revision: asb
 *  revised to xmit the RSSI strength value
 */

includes AM;
includes crc;
includes hardware;

module FramerM {

  provides {
    interface StdControl;
    interface TokenReceiveMsg;
    interface ReceiveMsg;
    interface BareSendMsg;
  }

  uses {
    interface ByteComm;
    interface StdControl as ByteControl;
  }
}

implementation {

  enum {
    HDLC_QUEUESIZE	   = 2,
    HDLC_MTU		   = (sizeof(TOS_Msg)),
    HDLC_FLAG_BYTE	   = 0x7e,
    HDLC_CTLESC_BYTE	   = 0x7d,
    PROTO_ACK              = 64,
    PROTO_PACKET_ACK       = 65,
    PROTO_PACKET_NOACK     = 66,
    PROTO_UNKNOWN          = 255
  };

  enum {
    RXSTATE_NOSYNC,
    RXSTATE_PROTO,
    RXSTATE_TOKEN,
    RXSTATE_INFO,
    RXSTATE_ESC
  };

  enum {
    TXSTATE_IDLE,
    TXSTATE_PROTO,
    TXSTATE_INFO,
    TXSTATE_ESC,
    TXSTATE_RSSI_1,              //asb mod
    TXSTATE_RSSI_2,              //asb mod 
	TXSTATE_FCS1,
    TXSTATE_FCS2,
    TXSTATE_ENDFLAG,
    TXSTATE_FINISH,
    TXSTATE_ERROR
  };

  enum {
    FLAGS_TOKENPEND = 0x2,
    FLAGS_DATAPEND  = 0x4,
    FLAGS_UNKNOWN   = 0x8
  };

  TOS_Msg gMsgRcvBuf[HDLC_QUEUESIZE];

  typedef struct _MsgRcvEntry {
    uint8_t Proto;
    uint8_t Token;	// Used for sending acknowledgements
    uint16_t Length;	// Does not include 'Proto' or 'Token' fields
    TOS_MsgPtr pMsg;
  } MsgRcvEntry_t ;

  MsgRcvEntry_t gMsgRcvTbl[HDLC_QUEUESIZE];

  uint8_t * gpRxBuf;    
  uint8_t * gpTxBuf;

  uint8_t  gFlags;

  // Flags variable protects atomicity
  norace uint8_t  gTxState;
  norace uint8_t  gPrevTxState;
  norace uint8_t  gTxProto;
  norace uint16_t gTxByteCnt;
  norace uint16_t gTxLength;
  norace uint16_t gTxRunningCRC;


  uint8_t  gRxState;
  uint8_t  gRxHeadIndex;
  uint8_t  gRxTailIndex;
  uint16_t gRxByteCnt;
  
  uint16_t gRxRunningCRC;
  
  TOS_MsgPtr gpTxMsg;
  uint8_t gTxTokenBuf;
  uint8_t gTxUnknownBuf;
  norace uint8_t gTxEscByte;

  task void PacketSent();

uint8_t  fRemapRxPos( uint8_t InPos ); //remap standard TOSMessage fields to CC2420TOSMsg

//*************************************************************************
/*
fRemapRxPos
Map incomming byte positions into new TOSmessage structure
 Does NOT handle CRC bytes correctly
*/
uint8_t  fRemapRxPos( uint8_t InPos ) {

	if( InPos<4 )
		return( InPos+offsetof(struct TOS_Msg, addr) );	//addr,AM,groupid
	else if( InPos==4 )
		return( offsetof(struct TOS_Msg, length) ); //length
	else return( (InPos-5)+offsetof(struct TOS_Msg, data) ); //data and subsequent
}//fRemapRxByte


  result_t StartTx() {
    result_t Result = SUCCESS;
    bool fInitiate = FALSE;

    atomic {
      if (gTxState == TXSTATE_IDLE) {
        if (gFlags & FLAGS_TOKENPEND) {
          gpTxBuf = (uint8_t *)&gTxTokenBuf;
          gTxProto = PROTO_ACK;
          gTxLength = sizeof(gTxTokenBuf);
          fInitiate = TRUE;
          gTxState = TXSTATE_PROTO;
        }
        else if (gFlags & FLAGS_DATAPEND) {
          gpTxBuf = (uint8_t *)gpTxMsg;
#if defined (TOSH_HARDWARE_MICAZ) || defined (TOSH_HARDWARE_RCB230) || defined (TOSH_HARDWARE_MICAZC) || defined (TOSH_HARDWARE_MICAZB)
	  gpTxBuf += 6; /* Skip the extra bytes of the Zigbee in MicaZ */
#else
#define TOS_HEADER_SIZE 5 /* Not defined in Mica2 -- found in AM.h of Micaz */
#endif

          gTxProto = PROTO_PACKET_NOACK;
//           gTxLength = gpTxMsg->length + (MSG_DATA_SIZE - DATA_LENGTH - 2);
          gTxLength = gpTxMsg->length + TOS_HEADER_SIZE;
		//number of bytes to xfer = TOSHeader + data + 2CRC bytes
          fInitiate = TRUE;
          gTxState = TXSTATE_PROTO;
        }
        else if (gFlags & FLAGS_UNKNOWN) {
          gpTxBuf = (uint8_t *)&gTxUnknownBuf;
          gTxProto = PROTO_UNKNOWN;
          gTxLength = sizeof(gTxUnknownBuf);
          fInitiate = TRUE;
          gTxState = TXSTATE_PROTO;
        }
      }
    }
    
    if (fInitiate) {
      atomic {
        gTxRunningCRC = 0;	 //initialize CRC calculation
        // gTxByteCnt = 6;	 //start at addr in tosmsg
	gTxByteCnt = 0;
      }
      Result = call ByteComm.txByte(HDLC_FLAG_BYTE);
      if (Result != SUCCESS) {
        atomic gTxState = TXSTATE_ERROR;
        post PacketSent();
      }
    }
    
    return Result;
  }    
  
  task void PacketUnknown() {
    atomic {
      gFlags |= FLAGS_UNKNOWN;
    }
    
    StartTx();
  }

  task void PacketRcvd() {
    MsgRcvEntry_t *pRcv = &gMsgRcvTbl[gRxTailIndex];
    TOS_MsgPtr pBuf = pRcv->pMsg;

    // Does the rcvd frame actually have a meaningful message??
    if (pRcv->Length >= offsetof(struct TOS_Msg,data)) {

      switch (pRcv->Proto) {
		case PROTO_ACK:
			break;
		case PROTO_PACKET_ACK:
			pBuf->crc = 1;  // Easier to set here... 
			pBuf = signal TokenReceiveMsg.receive(pBuf,pRcv->Token);
			break;
		case PROTO_PACKET_NOACK:
			pBuf->crc = 1;
			pBuf = signal ReceiveMsg.receive(pBuf);
			break;
		default:
			gTxUnknownBuf = pRcv->Proto;
			post PacketUnknown();
			break;
		}  //switch
    } //if

    atomic {
      if (pBuf) {
	pRcv->pMsg = pBuf;
      }
      pRcv->Length = 0; 
      pRcv->Token = 0; 
      gRxTailIndex++;
      gRxTailIndex %= HDLC_QUEUESIZE;
    }
  }

  task void PacketSent() {
    result_t TxResult = SUCCESS;

    atomic {
      if (gTxState == TXSTATE_ERROR) {
	TxResult = FAIL;
        gTxState = TXSTATE_IDLE;
      }
    }
    if (gTxProto == PROTO_ACK) {
      atomic gFlags ^= FLAGS_TOKENPEND;
    }
    else{
      atomic gFlags ^= FLAGS_DATAPEND;
      signal BareSendMsg.sendDone((TOS_MsgPtr)gpTxMsg,TxResult);
      atomic gpTxMsg = NULL;
    }

    // Trigger transmission in case something else is pending
    StartTx();
  }

  void HDLCInitialize() {
    int i;
    atomic {
      for (i = 0;i < HDLC_QUEUESIZE; i++) {
        gMsgRcvTbl[i].pMsg = &gMsgRcvBuf[i];
        gMsgRcvTbl[i].Length = 0;
        gMsgRcvTbl[i].Token = 0;
      }
      gTxState = TXSTATE_IDLE;
      gTxByteCnt = 0;
      gTxLength = 0;
      gTxRunningCRC = 0;
      gpTxMsg = NULL;
      
      gRxState = RXSTATE_NOSYNC;
      gRxHeadIndex = 0;
      gRxTailIndex = 0;
      gRxByteCnt = 0;
      gRxRunningCRC = 0;
      gpRxBuf = (uint8_t *)gMsgRcvTbl[gRxHeadIndex].pMsg;
    }
  }

  command result_t StdControl.init() {
    HDLCInitialize();
    return call ByteControl.init();
  }

  command result_t StdControl.start() {
    HDLCInitialize();
    return call ByteControl.start();
  }
  
  command result_t StdControl.stop() {
    return call ByteControl.stop();
  }

  
  command result_t BareSendMsg.send(TOS_MsgPtr pMsg) {
    result_t Result = SUCCESS;

    atomic {
      if (!(gFlags & FLAGS_DATAPEND)) {
       gFlags |= FLAGS_DATAPEND; 
       gpTxMsg = pMsg;
       //gTxLength = pMsg->length + (MSG_DATA_SIZE - DATA_LENGTH - 2);
       //gTxProto = PROTO_PACKET_NOACK;
      }
      else {
        Result = FAIL;
      }
    }

    if (Result == SUCCESS) {
      Result = StartTx();
    }

    return Result;
  }

  command result_t TokenReceiveMsg.ReflectToken(uint8_t Token) {
    result_t Result = SUCCESS;

    atomic {
      if (!(gFlags & FLAGS_TOKENPEND)) {
        gFlags |= FLAGS_TOKENPEND;
        gTxTokenBuf = Token;
      }
      else {
        Result = FAIL;
      }
    }

    if (Result == SUCCESS) {
      Result = StartTx();
    }

    return Result;
  }

  async event result_t ByteComm.rxByteReady(uint8_t data, bool error, uint16_t strength) {

    switch (gRxState) {

    case RXSTATE_NOSYNC: 
      if ((data == HDLC_FLAG_BYTE) && (gMsgRcvTbl[gRxHeadIndex].Length == 0)) {
        gMsgRcvTbl[gRxHeadIndex].Token = 0;
		gRxByteCnt = gRxRunningCRC = 0;
        gpRxBuf = (uint8_t *)gMsgRcvTbl[gRxHeadIndex].pMsg;
    	gRxState = RXSTATE_PROTO;
      }
      break;

    case RXSTATE_PROTO:
      if (data == HDLC_FLAG_BYTE) {
        break;
      }
      gMsgRcvTbl[gRxHeadIndex].Proto = data;
      gRxRunningCRC = crcByte(gRxRunningCRC,data);
      switch (data) {
      case PROTO_PACKET_ACK:
		gRxState = RXSTATE_TOKEN;
		break;
      case PROTO_PACKET_NOACK:
		gRxState = RXSTATE_INFO;
		break;
      default:  // PROTO_ACK packets are not handled
		gRxState = RXSTATE_NOSYNC;
		break;
      }//case data
      break;

    case RXSTATE_TOKEN:
      if (data == HDLC_FLAG_BYTE) {
        gRxState = RXSTATE_NOSYNC;
      }
      else if (data == HDLC_CTLESC_BYTE) {
        gMsgRcvTbl[gRxHeadIndex].Token = 0x20;
      }
      else {
        gMsgRcvTbl[gRxHeadIndex].Token ^= data;
        gRxRunningCRC = crcByte(gRxRunningCRC,gMsgRcvTbl[gRxHeadIndex].Token);
        gRxState = RXSTATE_INFO;
      }
      break;


    case RXSTATE_INFO:
      if (gRxByteCnt > HDLC_MTU) {
		gRxByteCnt = gRxRunningCRC = 0;
		gMsgRcvTbl[gRxHeadIndex].Length = 0;
		gMsgRcvTbl[gRxHeadIndex].Token = 0;
		gRxState = RXSTATE_NOSYNC;
      }
      else if (data == HDLC_CTLESC_BYTE) {
		gRxState = RXSTATE_ESC;
      }
      else if (data == HDLC_FLAG_BYTE) {
		if (gRxByteCnt >= 2) {
		//fetch the received CRC
		  uint16_t usRcvdCRC = (gpRxBuf[fRemapRxPos(gRxByteCnt-1)] & 0xff);
		  usRcvdCRC = (usRcvdCRC << 8) | fRemapRxPos(gpRxBuf[(gRxByteCnt-2)] & 0xff);
//DEBUG - FORCE CRC OK
		  gRxRunningCRC= usRcvdCRC;

		  if (usRcvdCRC == gRxRunningCRC) {
		    gMsgRcvTbl[gRxHeadIndex].Length = gRxByteCnt - 2;
		    post PacketRcvd();
		    gRxHeadIndex++; gRxHeadIndex %= HDLC_QUEUESIZE;
          	}
          else {
            gMsgRcvTbl[gRxHeadIndex].Length = 0;
            gMsgRcvTbl[gRxHeadIndex].Token = 0;
          	}
          if (gMsgRcvTbl[gRxHeadIndex].Length == 0) {
             gpRxBuf = (uint8_t *)gMsgRcvTbl[gRxHeadIndex].pMsg;
            gRxState = RXSTATE_PROTO;
          	}
          else {
            gRxState = RXSTATE_NOSYNC;
	  		}//if usRcvdCRC
		}//if gRXBytecnt
		else {
			gMsgRcvTbl[gRxHeadIndex].Length = 0;
			gMsgRcvTbl[gRxHeadIndex].Token = 0;
			gRxState = RXSTATE_NOSYNC;
			}
		gRxByteCnt = gRxRunningCRC = 0;
		} //if data
		else {
			gpRxBuf[fRemapRxPos(gRxByteCnt)] = data;
			if (gRxByteCnt >= 2) {
				gRxRunningCRC = crcByte(gRxRunningCRC,gpRxBuf[(gRxByteCnt-2)]);	//start computing CRC-need remap
			}
			gRxByteCnt++;
			}
		break;

    case RXSTATE_ESC:
      if (data == HDLC_FLAG_BYTE) {
	// Error case, fail and resync
	gRxByteCnt = gRxRunningCRC = 0;
	gMsgRcvTbl[gRxHeadIndex].Length = 0;
	gMsgRcvTbl[gRxHeadIndex].Token = 0;
	gRxState = RXSTATE_NOSYNC;
      }
      else {
	data = data ^ 0x20;
        gpRxBuf[fRemapRxPos(gRxByteCnt)] = data;
	if (gRxByteCnt >= 2) {
	  gRxRunningCRC = crcByte(gRxRunningCRC,gpRxBuf[(gRxByteCnt-2)]);
	}
	gRxByteCnt++;
	gRxState = RXSTATE_INFO;
      }
      break;

    default:
      gRxState = RXSTATE_NOSYNC;
      break;
    }

    return SUCCESS;
  }
//*****************************************************************************
  result_t TxArbitraryByte(uint8_t inByte) {
    if ((inByte == HDLC_FLAG_BYTE) || (inByte == HDLC_CTLESC_BYTE)) {
      atomic {
        gPrevTxState = gTxState;
        gTxState = TXSTATE_ESC;
        gTxEscByte = inByte;
      }
      inByte = HDLC_CTLESC_BYTE;
    }
    
    return call ByteComm.txByte(inByte);
  }
    
  async event result_t ByteComm.txByteReady(bool LastByteSuccess) {
    result_t TxResult = SUCCESS;
    uint8_t nextByte;
	uint16_t tmpW;

    if (LastByteSuccess != TRUE) {
      atomic gTxState = TXSTATE_ERROR;
      post PacketSent();
      return SUCCESS;
    }

    switch (gTxState) {

    case TXSTATE_PROTO:
      gTxState = TXSTATE_INFO;
      gTxRunningCRC = crcByte(gTxRunningCRC,gTxProto);
      TxResult = call ByteComm.txByte(gTxProto);
      break;
 // ---------------------------modified to output RSSI value ------------------------     
    case TXSTATE_INFO:
	atomic {
#if defined (TOSH_HARDWARE_MICAZ) || defined (TOSH_HARDWARE_RCB230) || defined (TOSH_HARDWARE_MICAZC) || defined (TOSH_HARDWARE_MICAZB) 
	    if(gTxByteCnt == 4)
		gpTxBuf = &gpTxMsg->length;	  //insert TOSMsg Length field
	    if(gpTxBuf == ((char *)(&gpTxMsg->length) + 1)) { 
		gpTxBuf = &gpTxMsg->data [0];	 //back to TOSMsg.data
// 	        nextByte = gpTxBuf[gTxByteCnt] + 2; //len = len + RSSI and LQI
	    }
#endif /* TOSH_HARDWARE_MICAZ */
//      if (gTxByteCnt >= gTxLength)	gTxState = TXSTATE_FCS1;

	    nextByte = *gpTxBuf++;
	    gTxByteCnt++;
	    if (gTxByteCnt >= gTxLength)	gTxState = TXSTATE_RSSI_1;
	}
	gTxRunningCRC = crcByte(gTxRunningCRC,nextByte);
      
	TxResult = TxArbitraryByte(nextByte);
      break;


//next 2 bytes are RSSI and lqi
//RSSI is single byte for micaz, 2nd byte lqi (send this as zero) - old
    case TXSTATE_RSSI_1:
	//   nextByte = gpTxBuf[gTxByteCnt+2];
	nextByte = gpTxMsg->strength;
      /*
       * Convert to dBm - different for CC1000 and CC2420
       */
#if defined (TOSH_HARDWARE_MICA2) || defined (TOSH_HARDWARE_MICA2DOT) || defined (TOSH_HARDWARE_MICA3) || defined (TOSH_HARDWARE_MICA2B)
	/* P = -Vrssi * 50 - 45 -- approximately - Vrssi is 0 to 1.2Volts*/
	/* assume avg batt voltage of 3.0V, strength is adc output without Vref corr. */
	/* P = (3 * ADC*50)/1024 - 45 =~ (ADC* 37)/256 - 45   */
	tmpW = gpTxMsg->strength;
	tmpW =  ((tmpW * 37) >> 8) + 45;
    nextByte = 255 - (uint8_t)tmpW;
#elif defined (TOSH_HARDWARE_MICAZ) || defined (TOSH_HARDWARE_MICAZB)
	/* for the MicaZ */
	nextByte = nextByte - 45;
	
#elif defined (TOSH_HARDWARE_MICAZC) || defined (TOSH_HARDWARE_RCB230)  
  /* for the RF230 radio*/
      gTxRunningCRC = crcByte(gTxRunningCRC,nextByte);
      gTxByteCnt++;
      gTxState = TXSTATE_RSSI_2;
     
      TxResult = TxArbitraryByte(nextByte);
      break;

#else
#error "Mica Hardware not defined"
#endif /* TOSH_HARDWARE_MICA2 */
	if (!(nextByte & 0x80)) 
	    nextByte = 0x80; /* Smallest value is -127dbm - fix for rounding error */
      gTxRunningCRC = crcByte(gTxRunningCRC,nextByte);
      gTxByteCnt++;
      gTxState = TXSTATE_RSSI_2;
     
      TxResult = TxArbitraryByte(nextByte);
      break;

#if 1 /* Send only 2nd RSSI byte (as zero) */
//xmit 2nd byte of LQI
    case TXSTATE_RSSI_2:
     //nextByte = gpTxBuf[gTxByteCnt+3];
     // nextByte = gpTxBuf[gTxByteCnt];
      nextByte = 0;
      gTxRunningCRC = crcByte(gTxRunningCRC,nextByte);
      gTxByteCnt++;
      gTxState = TXSTATE_FCS1;
      
      
      TxResult = TxArbitraryByte(nextByte);
      break;
#endif
 // ---------------------------modified to output RSSI value ------------------------	     
    case TXSTATE_ESC:

      TxResult = call ByteComm.txByte((gTxEscByte ^ 0x20));
      gTxState = gPrevTxState;
      break;
	
    case TXSTATE_FCS1:
      nextByte = (uint8_t)(gTxRunningCRC & 0xff); // LSB
      gTxState = TXSTATE_FCS2;
      TxResult = TxArbitraryByte(nextByte);
      break;

    case TXSTATE_FCS2:
      nextByte = (uint8_t)((gTxRunningCRC >> 8) & 0xff); // MSB
      gTxState = TXSTATE_ENDFLAG;
      TxResult = TxArbitraryByte(nextByte);
      break;

    case TXSTATE_ENDFLAG:
      gTxState = TXSTATE_FINISH;
      TxResult = call ByteComm.txByte(HDLC_FLAG_BYTE);

      break;

    case TXSTATE_FINISH:
    case TXSTATE_ERROR:

    default:
      break;

    }

    if (TxResult != SUCCESS) {
      gTxState = TXSTATE_ERROR;
      post PacketSent();
    }

    return SUCCESS;
  }

  async event result_t ByteComm.txDone() {

    if (gTxState == TXSTATE_FINISH) {
      gTxState = TXSTATE_IDLE;
      post PacketSent();
    }
    
    return SUCCESS;
  }


  default event TOS_MsgPtr ReceiveMsg.receive(TOS_MsgPtr Msg) {
    return Msg;
  }

  default event TOS_MsgPtr TokenReceiveMsg.receive(TOS_MsgPtr Msg,uint8_t Token) {
    return Msg;
  }
}
