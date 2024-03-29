/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MAC.nc,v 1.1.4.1 2007/04/25 23:25:34 njain Exp $
 */

/* Authors: Naveen Sastry
 * Date:    10/18/02
 */

/**
 * @author Naveen Sastry
 */

includes crypto;
/**
 * Interface to compute a message authentication code.
 */
interface MAC
{
  /**
   * Initializes the MAC layer and stores any local state into the context
   * variable. The context variable should be used for future invocations
   * which share this key. It uses the preferred block size of the underlying
   * BlockCipher
   *
   * @param context opaque data structure to hold the module specific state
   *        associated with this key.
   * @param keySize length of the key in bytes.
   * @param key pointer to a buffer containing keySize bytes of shared key data
   * @return Whether initialization was successful. The command may be
   *         unsuccessful if the key size or blockSize are not valid for the
   *         given cipher implementation. 
   */
  command result_t init (MACContext * context, uint8_t keySize, uint8_t * key);
                         
  /**
   * Initializes an invocation of an incremental MAC computation. This is
   * provided for asynchronous operation so that the MAC may be incrementally
   * computed. Partial state is stored in the context.
   *
   * @param context opaque data structure to hold the module specific state
   *        associated with this invocation of the incremental computation.
   * @param length the total length of data that is forthcoming
   * @return whether the incremental initialization was successful. This can
   *        fail if the underlying cipher operation fails.
   */
  async command result_t initIncrementalMAC (MACContext * context, uint16_t length);

  /**
   * Computes an incremental MAC on msgLen bytes of the msg. This call is
   * tied to the initIncrementalMAC call, which must be made first. This call
   * can fail if the msgLen provided exceeds the amount specified earlier or
   * if a block cipher operation fails.
   *
   * @param context opaque data structure to hold the module specific state
   *        associated with this invocation of the incremental computation.
   * @param msg the message data to add to the incremental computation.
   * @param msgLen number of bytes to add for the incremental computation.
   * @return whether the incremental mac computation succeeded or not. It can
   *        fail if more data is provided than the initial initialization
   *        indicated or if the underlying block cipher fails.
   */
  async command result_t incrementalMAC (MACContext * context, uint8_t * msg, 
					 uint16_t msgLen);

  /**
   * Returns the actual MAC code from an in-progress incremental MAC
   * computation. The initIncrementalMAC and length bytes of data must have
   * been computed using the provided context for this function to succeed.
   * This function may fail if the requested MAC size exceeds the underlying
   * cipher block size, or if the incremental MAC computation has not yet
   * finished.
   *
   * @param context opaque data structure to hold the module specific state
   *        associated with this invocation of the incremental computation.
   * @param MAC resulting buffer of at least macSize to hold the generated MAC
   * @param macSize the number of bytes of MAC to generate. This must be
   *        less than or equal to the underlying blockCipher block size.
   * @return whether the command succeeded or not. It can fail if the
   *        underlying block cipher fails or if not all expected data was
   *        received from the initialization function
   */
  async command result_t getIncrementalMAC (MACContext * context, uint8_t * MAC,
					    uint8_t macSize);

  /**
   * Computes a non-incremental MAC calculation on the given message. The
   * key from the init() call will be used for the MAC calculation.
   *
   * @param context opaque data structure to hold the module specific state
   *        associated with this invocation of the incremental computation.
   * @param msg a buffer of length size on which the MAC will be calculated
   * @param length the total length of the msg
   * @param buffer of at least macSize where the resulting MAC calculation
   *        will be stored.
   * @param macSzie the number of bytes of MAC to generate. This must be
   *        less than or equal to the underlying blockCipher block size.
   * @return whether the command suceeds or not. It can fail if the underlying
   *        blockCipher fails. 
   */
  async command result_t MAC (MACContext * context, uint8_t * msg, uint16_t length,
			      uint8_t *MAC, uint8_t macSize);
}
