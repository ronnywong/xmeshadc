/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SendData.nc,v 1.1.4.1 2007/04/25 23:30:08 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 *
 */

/**
 * Interface for sending arbitrary streams of bytes.
 *
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */

interface SendData
{
  /**
   * Send <code>numBytes</code> of the buffer <code>data</code>.
   *
   * @return SUCCESS if send request accepted, FAIL otherwise. SUCCCES
   * means that a sendDone should be expected, FAIL means it should
   * not.
   */ 
  command result_t send(uint8_t* data, uint8_t numBytes);

  /**
   * Send request completed. The buffer sent and whether the send was
   * successful are passed.
   *
   * @return SUCCESS always.
   */
  event result_t sendDone(uint8_t* data, result_t success);
}
