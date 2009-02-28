/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: BlockCipher.nc,v 1.1.4.1 2007/04/25 23:19:10 njain Exp $
 */

/* Authors: Naveen Sastry
 * Date:    9/26/02
 */

/**
 * @author Naveen Sastry
 */


includes crypto;
interface BlockCipher
{
  /**
   * Initialize the BlockCipher context.
   *
   * @param context structure to hold the opaque data from this initialization
   *        call. It should be passed to future invocations of this module
   *        which use this particular key.
   * @param blockSize size of the block in bytes. Some cipher implementation
   *        may support multiple block sizes, in which case any valid size
   *        is valid.
   * @param keySize key size in bytes
   * @param key pointer to the key
   *
   * @return Whether initialization was successful. The command may be
   *         unsuccessful if the key size or blockSize are not valid for the
   *         given cipher implementation. 
   */
  command result_t init(CipherContext * context,
                        uint8_t blockSize, uint8_t keySize, uint8_t * key);

  /**
   * Encrypts a single block (of blockSize) using the key in the keySize.
   *
   * @param context holds the module specific opaque data related to the
   *        key (perhaps key expansions). 
   * @param plainBlock a plaintext block of blockSize
   * @param cipherBlock the resulting ciphertext block of blockSize
   *
   * @return Whether the encryption was successful. Possible failure reasons
   *         include not calling init(). 
   */
  async command result_t encrypt(CipherContext * context,
				 uint8_t * plainBlock, uint8_t * cipherBlock);

  /**
   * Decrypts a single block (of blockSize) using the key in the keySize. Not
   * all ciphers will implement this function (since providing encryption
   * is a useful primitive). 
   *
   * @param context holds the module specific opaque data related to the
   *        key (perhaps key expansions).    
   * @param cipherBlock a ciphertext block of blockSize
   * @param plainBlock the resulting plaintext block of blockSize
   *
   * @return Whether the decryption was successful. Possible failure reasons
   *         include not calling init() or an unimplimented decrypt function.
   */
  async command result_t decrypt(CipherContext * context,
				 uint8_t * cipherBlock, uint8_t * plainBlock);

  
}

