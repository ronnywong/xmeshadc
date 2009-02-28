/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMeshBase.nc,v 1.3.2.1 2007/04/26 20:24:14 njain Exp $
 */
 
/*
 * @author   Martin Turon <mturon@xbow.com>
 * @Date     September 7, 2005
 *
 * Modified by Ning Xu (nxu@xbow.com) on:
 *  1. remove deluge, queuedsend, Bcast components to conserve ram space
 *  2. add xotap support
 */

#include "appFeatures.h"

includes sensorboardApp;
/**
 * XMeshBase is the gateway firmware for all XMesh suite applications.
 */
configuration XMeshBase {
// this module does not provide any interface
}
implementation
{
    components Main,
	MULTIHOPROUTER,XMeshBaseM,
	JOIN_COMPONENT
	LEDS_COMPONENT
	HEARTBEAT_COMPONENT
	XCommandC;

    Main.StdControl -> XMeshBaseM;
    JOIN_WIRING()
    HEARTBEAT_WIRING()

    LEDS_WIRING(XMeshBaseM)

    XMeshBaseM.XCommand -> XCommandC;

    // Wiring for RF mesh networking.
    XMeshBaseM.RouteControl -> MULTIHOPROUTER;
}
