// $Id: SlottedSendShimM.nc,v 1.1.2.1 2007/02/02 22:02:54 xyang Exp $

/**
 * Copyright (c) 2005-2006 Crossbow Technology, Inc.
 * All rights reserved.
 *
 * Use, copy, modification, reproduction and distribution of
 * this software and documentation are governed by the
 * Crossbow Technology End User License Agreement.
 * To obtain a copy of this Agreement, please contact
 * Crossbow Technology, 4145 N. First St., San Jose, CA 95134.
 */
 
module SlottedSendShimM {
	
	provides {
		interface ReceiveMsg as LPRecv;
	}
	
	uses {
		interface ReceiveMsg as LPRecvUsed;
	}
}

implementation {
	event TOS_MsgPtr LPRecvUsed.receive(TOS_MsgPtr m) {
		return signal LPRecv.receive(m);
	}
	
	default event TOS_MsgPtr LPRecv.receive(TOS_MsgPtr m) {
		return m;
	}
}
