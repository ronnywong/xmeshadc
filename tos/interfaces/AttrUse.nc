/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: AttrUse.nc,v 1.1.4.1 2007/04/25 23:18:45 njain Exp $
 */

/* 
 * Authors:  Wei Hong
 *           Intel Research Berkeley Lab
 * Date:     6/27/2002
 *
 */

/**
 * @author Wei Hong
 * @author Intel Research Berkeley Lab
 */


includes SchemaType;
includes Attr;

/** Interface for using Attributes.  Attributes provided a generic mechanism for 
	registering named attribute-value pairs and retrieving their values.
    <p>
    See lib/Attributes/... for examples of components that register attributes
    <p>
    See interfaces/Attr.h for the data structures used in this interface 
    <p>
    Implemented by lib/Attr.td
    <p>
    @author Wei Hong (wei.hong@intel-research.net)
*/

interface AttrUse
{
  /** Get a descriptor for the specified attribute
      @param name The (8 byte or shorted, null-terminated) name for the attribute of interest.
      @return A pointer to the attribute descriptior, or NULL if no such attribute exists.
  */
  command AttrDescPtr getAttr(char *name);

  /** Get a descriptor for the specified attribute
      @param attrIdx THe (0-based) index of the attribute of interest
      @return A pointer to the attribute descriptior, or NULL if no such attribute exists.
  */
  command AttrDescPtr getAttrById(uint8_t attrIdx);

  /** Get the number of attributes currently registered with the system
      @return The number of attributes currently registered with the system. 
  */	
  command uint8_t numAttrs();

  /** Returns a list of all attributes in the system.
      @return A list of all the attributes in the system 
  */
  command AttrDescsPtr getAttrs();

  /** Get the value of a specified attribute.
      @param name The name of the attribute to fetch
      @param resultBuf The buffer to write the value into (must be at least sizeOf(AttrDescPtr.type) long)
      @param errorNo (on return) The error code, if any (see SchemaType.h for a list of error codes.) Note that
             the error code may be SCHEMA_RESULT_PENDING, in which case a getAttrDone event will be fired
	     at some point to indicate that the data has been written into resultBuf.
  */	     
  command result_t getAttrValue(char *name, char *resultBuf, SchemaErrorNo *errorNo);

  /** Set the value of the specified attribute.
      @param name The attribute to set
      @param attrVal The value to set it to
  */
  command result_t setAttrValue(char *name, char *attrVal);

  /** Signal that a specific getAttrValue command is complete.
      @param name The name of the command that finished
      @param resultBuf The buffer that the value was written into
      @param errorNo The result code from the get command
  */
  event result_t getAttrDone(char *name, char *resultBuf, SchemaErrorNo errorNo);
  /** start an attribute, e.g., power up a sensor
      @param name The name of the attribute to start
  */	     
  command result_t startAttr(uint8_t id);

  /** Signal that an attribute has been started
      @param name attribute name
  */
  event result_t startAttrDone(uint8_t id);
}
