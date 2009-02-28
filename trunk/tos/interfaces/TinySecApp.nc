/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TinySecApp.nc,v 1.1.4.1 2007/04/25 23:32:47 njain Exp $
 */

/* Authors: Naveen Sastry
 * Date:    6/4/03
 */

/**
 * Library to provide application level encryption / decryption support using
 * TinySec. 
 * @author Naveen Sastry
 */
interface TinySecApp
{
  /**
   * Initializes the library using the given key. This key will be used for
   * all operations until another key reset.
   *
   * @param key a pointer to the key buffer. it must be one block size in
   *        length.
   * @param globalkey if true, indicates that the key is shared by other
   *        nodes; the library then changes its behavior accordingly to include
   *        the TOS_LOCAL_ADDRESS in the IV when possible. This is only
   *        necessary, though, if the key is shared with other nodes.
   * @returns whether the initialization was successful or not. This can return
   *        FAILURE if the mode could not be initialized properly.
   */
  command result_t init (uint8_t * key, bool globalkey);

  /**
   * Encrypts the given plaintext data in the ciphertext buffer. Furthermore,
   * IVlength bytes of an initialization vector will be created and populated
   * into the buffer pointed by IV. 
   *
   * In place encryption should work provided that the plain and and cipher
   * buffer are the same. (they may either be the same or
   * non-overlapping. partial overlaps are not supported).
   *
   * @param plaintext the original, cleartext buffer
   * @param plainLength length of the cleartext. This must be at least
   *        blcoksize bytes.
   * @param IVlength number of bytes to use for the IV. This must not be
   *        greater the blocksize. Confidentiality and semantic security
   *        increases with larger iv lengths.
   * @param IV the system will generate the IV and place a copy of the IVlength
   *        bytes in this buffer. The IV is necessary to decrypt the
   *        ciphertext.
   * @param ciphertext the resulting encrypted data. this pointer may EITHER
   *        be exactly the same as plaintext or it must not overlap with the
   *        plaintext buffer.
   * @returns whether or not the operation was successful. This operation can
   *        fail if the task queue fills up, or if the underlying mode fails,
   *        or if the plainLength is not at least the block size.
   */
  command result_t encryptData (uint8_t * plaintext,
                                uint8_t plainLength, 
                                uint8_t IVlength,
                                uint8_t * IV,
                                uint8_t * ciphertext);

  /**
   * Event signalled wehn the encrypt operation completes.
   *
   * @param result whether the encryption operation was successful or not.
   * @param ciphertext the ciphertext buffer that was passed in during the
   *        encrypt operation.
   * @return whether the event was successfully handled. 
   */
  event result_t encryptDataDone (result_t result,
                                  uint8_t* ciphertext);

  /**
   * Decrypts the given ciphertext data in the plaintext buffer. 
   *
   * In place decryption should work provided that the plain and and cipher
   * buffer are the same. (they may either be the same or
   * non-overlapping. partial overlaps are not supported).
   *
   * @param ciphertext the original, encrypted data
   * @param cipherLengh length of the ciphertext. This must be at least
   *        blcoksize bytes.
   * @param IVlength number of bytes to use for the IV. This must not be
   *        greater the blocksize. Confidentiality and semantic security
   *        increases with larger iv lengths.
   * @param IV the initializtion vector for this buffer.
   * @param plaintext the resulting encrypted data. this pointer may EITHER
   *        be exactly the same as ciphertext or it must not overlap with the
   *        ciphertext buffer.
   * @returns whether or not the operation was successful. This operation can
   *        fail if the task queue fills up, or if the underlying mode fails,
   *        or if the plainLength is not at least the block size.
   */
  command result_t decryptData (uint8_t * ciphertext,
                                uint8_t cipherLength, 
                                uint8_t IVlength,
                                uint8_t * IV,
                                uint8_t * plaintext);

  /**
   * Event signalled wehn the decrypt operation completes.
   *
   * @param result whether the decryption operation was successful or not.
   * @param ciphertext the plaintext buffer that was passed in during the
   *        decrypt operation.
   * @return whether the event was successfully handled. 
   */
  event result_t decryptDataDone (result_t result, uint8_t* plaintext);
}
