/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CommandRegister.nc,v 1.1.4.1 2007/04/25 23:21:23 njain Exp $
 */

includes SchemaType;
includes Command;

/** The interface for registering commands.
    <p>
    See lib/Commands/... for examples of components that register commands.
    <p>
    See interfaces/Command.h for the data structures used in this interface 
    <p>
    Implemented by lib/Command.td
    <p>
    @author Wei Hong (wei.hong@intel-research.net)
*/
interface CommandRegister
{
  /** Register a command with the specified name, return type, return length, and parameters.
      @param name The name of the command to register. Must be in global
        storage.
      @param retType The type of the command (see SchemaType.h) 
      @param retLen The length (in bytes) of the command
      @param paramList The parameters to this command (see Command.h for the def of paramList)
  */
  command result_t registerCommand(char *name, TOSType retType, uint8_t retLen, ParamList *paramList);

  /** Called by Command.td when a specified command is invoked by the user.  The implementer must
      actually carry out the command.
      @param The name of the command that was invoked
      @param The buffer where the command result should be written
      @param An error code (may be SCHEMA_RESULT_PENDING, in which case commandDone must be called at some time in
       the future.)
  */
  event result_t commandFunc(char *commandName, char *resultBuf, SchemaErrorNo *errorNo, ParamVals *params);

  /** Should be called when a specified command invocation has completed
   @param The name of the command that completed
   @param resultBuf The buffer where the result was written
   @param errorNo The result code for the command
  */
  command result_t commandDone(char *commandName, char *resultBuf, SchemaErrorNo errorNo);
}
