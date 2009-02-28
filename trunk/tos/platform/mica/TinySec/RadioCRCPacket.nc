/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RadioCRCPacket.nc,v 1.1.4.1 2007/04/26 00:29:26 njain Exp $
 */
 
configuration RadioCRCPacket
{
  provides {
    interface StdControl as Control;
    interface BareSendMsg as Send;
    interface ReceiveMsg as Receive;
  }
}
implementation
{
  components SlavePinC,  SecDedEncoding, RandomLFSR,
    ChannelMonC, RadioTimingC, SpiByteFifoC,
    TinySecC, MicaHighSpeedRadioM,
    CrcFilter, LogicalTime, HPLPowerManagementM,
    LedsC;
  
  Control = MicaHighSpeedRadioM.Control;

  Control = TinySecC;
  Send = TinySecC.Send;
  Receive = TinySecC.Receive;
  TinySecC.RadioSend -> MicaHighSpeedRadioM;
  TinySecC.RadioReceive -> MicaHighSpeedRadioM;
  TinySecC.TinySecRadio -> MicaHighSpeedRadioM.TinySecRadio;
  MicaHighSpeedRadioM.TinySec -> TinySecC.TinySec;
  
  MicaHighSpeedRadioM.PowerManagement -> HPLPowerManagementM;
  MicaHighSpeedRadioM.Code -> SecDedEncoding.Code;
  MicaHighSpeedRadioM.Random -> RandomLFSR;
  MicaHighSpeedRadioM.ChannelMon -> ChannelMonC;
  MicaHighSpeedRadioM.RadioTiming -> RadioTimingC;
  MicaHighSpeedRadioM.SpiByteFifo -> SpiByteFifoC;
  MicaHighSpeedRadioM.Time -> LogicalTime;
  MicaHighSpeedRadioM.Leds -> LedsC;
  
  ChannelMonC.Random -> RandomLFSR;
  SpiByteFifoC.SlavePin -> SlavePinC;

}
