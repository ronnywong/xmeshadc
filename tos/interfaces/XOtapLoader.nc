/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XOtapLoader.nc,v 1.6.2.1 2007/04/25 23:34:10 njain Exp $
 */
 
interface XOtapLoader
{
  /** 
   * if an OTAP boot command is received, this event event will be signaled.
   * the whole idea here is to let application decide whether to boot into
   * the specifed image;
   * this event should be implemented by the upper application
   */
  event result_t boot_request(uint8_t imgID); 
  /** 
   * application calls this command to reboot into the image specified in 
   * the request
   */
  command result_t boot(uint8_t id);
}

