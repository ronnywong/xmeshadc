/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SlottedSendShimM.nc,v 1.1.4.1 2007/04/25 23:39:43 njain Exp $
 */

module SlottedSendShimM {
	
	provides {
		interface ReceiveMsg as LPRecv;
	}
	
	uses {
		interface ReceiveMsg as LPRecvActual;
	}
}

implementation {
	event TOS_MsgPtr LPRecvActual.receive(TOS_MsgPtr m) {
		return signal LPRecv.receive(m);
	}
	
	default event TOS_MsgPtr LPRecv.receive(TOS_MsgPtr m) {
		return m;
	}
}
