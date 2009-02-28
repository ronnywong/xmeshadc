/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: AttrRegisterConst.nc,v 1.1.4.1 2007/04/25 23:18:37 njain Exp $
 */

/* 
 * Authors:  Wei Hong
 *           Intel Research Berkeley Lab
 * Date:     7/1/2002
 *
 */

/**
 * @author Wei Hong
 * @author Intel Research Berkeley Lab
 */


includes SchemaType;
includes Attr;

// interface for registering constant attributes
interface AttrRegisterConst
{
  command result_t registerAttr(char *name, TOSType attrType, char *attrVal);
}
