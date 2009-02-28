/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RadioNoCRCPacket.nc,v 1.1.4.1 2007/04/27 06:02:42 njain Exp $
 */

/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


includes RFM;
configuration RadioNoCRCPacket
{
  provides {
    interface StdControl as Control;
    interface BareSendMsg as Send;
    interface ReceiveMsg as Receive;
  }
}
implementation
{
  components NoCRCPacket as Packet, SecDedRadioByteSignal, RFM, RandomLFSR, ADCC,
    NoLeds as Leds;

  Control = Packet.Control;
  Send = Packet.Send;
  Receive = Packet.Receive;

  Packet.Leds -> Leds;
  Packet.ByteControl -> SecDedRadioByteSignal;
  Packet.ByteComm -> SecDedRadioByteSignal;

  SecDedRadioByteSignal.StrengthADC -> ADCC.ADC[TOS_ADC_SIGNAL_STRENGTH_PORT];
  SecDedRadioByteSignal.ADCControl -> ADCC;
  SecDedRadioByteSignal.Random -> RandomLFSR;
  SecDedRadioByteSignal.Radio -> RFM;
  SecDedRadioByteSignal.RadioControl -> RFM;
  SecDedRadioByteSignal.Leds -> Leds;
					     
}
