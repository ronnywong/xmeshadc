/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XCommandC.nc,v 1.3.4.1 2007/04/25 23:42:57 njain Exp $
 */

/**
 * Provides a library module for handling basic application messages for
 * controlling a wireless sensor network.
 *
 * @file      XCommandC.nc
 * @author    Martin Turon
 * @version   2004/10/1    mturon      Initial version
 *
 * All wiring of internal components for this module is done here.
 *
 */

includes XCommand;

configuration XCommandC {
  provides interface XCommand;
  provides interface XEEControl;
}

implementation {
    components Main, LedsC, RecoverParamsC, XCommandM,GenericCommPromiscuous as Comm, MULTIHOPROUTER as MultiHopM,Bcast;

    XCommand   = XCommandM;
    XEEControl = RecoverParamsC;

	XCommandM.CmdRcv -> MultiHopM.Receive[AM_XCOMMAND_MSG];
	XCommandM.Bcast -> Bcast.Receive[AM_XCOMMAND_MSG];
	Bcast.ReceiveMsg[AM_XCOMMAND_MSG] -> Comm.ReceiveMsg[AM_XCOMMAND_MSG];
	XCommandM.Send -> MultiHopM.MhopSend[AM_XCOMMAND_MSG];

	RecoverParamsC.CommControl -> Comm;
    Main.StdControl -> RecoverParamsC.ParamControl;
    XCommandM.Config -> RecoverParamsC;
    XCommandM.ConfigSave -> RecoverParamsC;
    XCommandM.Leds -> LedsC;
}
