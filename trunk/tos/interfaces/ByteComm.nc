/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ByteComm.nc,v 1.1.4.1 2007/04/25 23:19:43 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 *
 */

/**
 * A byte-level communication interface. It signals byte receptions and
 * provides a split-phased byte send interface. txByteReady states
 * that the component can accept another byte in its queue to send,
 * while txDone states that the send queue has been emptied.
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */
interface ByteComm {
  /**
   * Transmits a byte over the radio
   *
   * @param data the byte to be transmitted
   *
   * @return SUCCESS if successful
   */
  async command result_t txByte(uint8_t data);

  /**
   * Notification that the radio is ready to receive another byte
   *
   * @param data the byte read from the radio
   * @param error determines the success of receiving the byte
   * @param strength the signal strength of the received byte
   *
   * @return SUCCESS if successful
   */
  async event result_t rxByteReady(uint8_t data, bool error, uint16_t strength);

  /**
   * Notification that the bus is ready to transmit/queue another byte
   *
   * @param success Notification of the successful transmission of the last byte
   *
   * @return SUCCESS if successful
   */
  async event result_t txByteReady(bool success);

  /**
   * Notification that the transmission has been completed
   * and the transmit queue has been emptied.
   *
   * @return SUCCESS always
   */
  async event result_t txDone();
}
