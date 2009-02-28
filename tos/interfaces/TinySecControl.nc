/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TinySecControl.nc,v 1.1.4.1 2007/04/25 23:32:55 njain Exp $
 */

/* Authors: Chris Karlof
 * Date:    9/26/02
 */

/**
 * @author Chris Karlof
 */


interface TinySecControl
{

  /**
   * Updates the MAC key.
   *
   * @param MACKey pointer to an array of TINYSEC_KEYSIZE bytes 
   *        representing the key used for calculating MAC's
   * @return Whether key update was successful. Will return FAIL if any
   *         crypto is currently running or TinySecM is not initialized.
   */  
  command result_t updateMACKey(uint8_t * MACKey);

  /**
   * Gets the current MAC key.
   *
   * @param result pointer to an array of TINYSEC_KEYSIZE bytes 
   *        to store the current MAC key
   * @return Whether the operation was successful. Will return FAIL if
   *         TinySecM is not initialized.
   */  
  command result_t getMACKey(uint8_t * result);
  
  /**
   * Updates the encryption key. This does not change the IV. 
   *
   * @param encryptionKey pointer to an array of TINYSEC_KEYSIZE bytes 
   *        representing the key used for encryption
   * @return Whether the key update was successful. Will return FAIL if any
   *         crypto operation is currently running or TinySecM is not initialized.
   */  
  command result_t updateEncryptionKey(uint8_t * encryptionKey);

  /**
   * Gets the current encryption key.
   *
   * @param result pointer to an array of TINYSEC_KEYSIZE bytes 
   *        to store the current encryption key. 
   * @return Whether the operation was successful. Will return FAIL if
   *         TinySecM is not initialized.
   */  
  command result_t getEncryptionKey(uint8_t * result);

  /**
   * Reinitializes the counter portion of the IV.
   *
   * @return Whether the operation was successful. Will return FAIL if
   *         TinySecM is not initialized or any crypto operation is
   *         currently running.
   */  
  command result_t resetIV();

  /**
   * Gets the current IV.
   *
   * @param result pointer to an array of TINYSEC_IV_SIZE bytes 
   *        to store the IV. 
   * @return Whether the operation was successful. Will return FAIL if
   *         TinySecM is not initialized.
   */   
  command result_t getIV(uint8_t * result);
}
