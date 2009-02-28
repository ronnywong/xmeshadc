/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLCC1000M.nc,v 1.1.2.2 2007/04/26 00:19:16 njain Exp $
 */
 
/*
 *
 * Authors:		Jaein Jeong, Philip Buonadonna
 * Date last modified:  $Revision: 1.1.2.2 $
 *
 */

/**
 * Low level hardware access to the CC1000
 * @author Jaein Jeong
 * @author Philip Buonadonna
 */

module HPLCC1000M {
  provides {
    interface HPLCC1000;
  }
}
implementation
{
  command result_t HPLCC1000.init() {
    TOSH_MAKE_CC_CHP_OUT_INPUT();
    TOSH_MAKE_CC_PALE_OUTPUT();  // PALE
    TOSH_MAKE_CC_PCLK_OUTPUT();    // PCLK
    TOSH_MAKE_CC_PDATA_OUTPUT();    // PDATA
    TOSH_SET_CC_PALE_PIN();      // set PALE high
    TOSH_SET_CC_PDATA_PIN();        // set PCLK high
    TOSH_SET_CC_PCLK_PIN();        // set PDATA high
    return SUCCESS;
  }

  //********************************************************/
  // function: write                                       */
  // description: accepts a 7 bit address and 8 bit data,  */
  //    creates an array of ones and zeros for each, and   */
  //    uses a loop counting thru the arrays to get        */
  //    consistent timing for the chipcon radio control    */
  //    interface.  PALE active low, followed by 7 bits    */
  //    msb first of address, then lsb high for write      */
  //    cycle, followed by 8 bits of data msb first.  data */
  //    is clocked out on the falling edge of PCLK.        */
  // Input:  7 bit address, 8 bit data                     */
  //********************************************************/

  async command result_t HPLCC1000.write(uint8_t addr, uint8_t data) {
    char cnt = 0;

    // address cycle starts here
    addr <<= 1;
    TOSH_CLR_CC_PALE_PIN();  // enable PALE
    for (cnt=0;cnt<7;cnt++)  // send addr PDATA msb first
    {
      if (addr&0x80)
        TOSH_SET_CC_PDATA_PIN();
      else
        TOSH_CLR_CC_PDATA_PIN();
      TOSH_CLR_CC_PCLK_PIN();   // toggle the PCLK
      TOSH_SET_CC_PCLK_PIN();
      addr <<= 1;
    }
    TOSH_SET_CC_PDATA_PIN();
    TOSH_CLR_CC_PCLK_PIN();   // toggle the PCLK
    TOSH_SET_CC_PCLK_PIN();

    TOSH_SET_CC_PALE_PIN();  // disable PALE

    // data cycle starts here
    for (cnt=0;cnt<8;cnt++)  // send data PDATA msb first
    {
      if (data&0x80)
        TOSH_SET_CC_PDATA_PIN();
      else
        TOSH_CLR_CC_PDATA_PIN();
      TOSH_CLR_CC_PCLK_PIN();   // toggle the PCLK
      TOSH_SET_CC_PCLK_PIN();
      data <<= 1;
    }
    TOSH_SET_CC_PALE_PIN();
    TOSH_SET_CC_PDATA_PIN();
    TOSH_SET_CC_PCLK_PIN();
    return SUCCESS;
  }

  //********************************************************/
  // function: read                                        */
  // description: accepts a 7 bit address,                 */
  //    creates an array of ones and zeros for each, and   */
  //    uses a loop counting thru the arrays to get        */
  //    consistent timing for the chipcon radio control    */
  //    interface.  PALE active low, followed by 7 bits    */
  //    msb first of address, then lsb low for read        */
  //    cycle, followed by 8 bits of data msb first.  data */
  //    is clocked in on the falling edge of PCLK.         */
  // Input:  7 bit address                                 */
  // Output:  8 bit data                                   */
  //********************************************************/

  async command uint8_t HPLCC1000.read(uint8_t addr) {
    int cnt;
    uint8_t din;
    uint8_t data = 0;

    // address cycle starts here
    addr <<= 1;
    TOSH_CLR_CC_PALE_PIN();  // enable PALE
    for (cnt=0;cnt<7;cnt++)  // send addr PDATA msb first
    {
      if (addr&0x80)
        TOSH_SET_CC_PDATA_PIN();
      else
        TOSH_CLR_CC_PDATA_PIN();
      TOSH_CLR_CC_PCLK_PIN();   // toggle the PCLK
      TOSH_SET_CC_PCLK_PIN();
      addr <<= 1;
    }
    TOSH_CLR_CC_PDATA_PIN();
    TOSH_CLR_CC_PCLK_PIN();   // toggle the PCLK
    TOSH_SET_CC_PCLK_PIN();

    TOSH_MAKE_CC_PDATA_INPUT();  // read data from chipcon
    TOSH_SET_CC_PALE_PIN();  // disable PALE

    // data cycle starts here
    for (cnt=7;cnt>=0;cnt--)  // send data PDATA msb first
    {
      TOSH_CLR_CC_PCLK_PIN();  // toggle the PCLK
      din = TOSH_READ_CC_PDATA_PIN();
      if(din)
        data = (data<<1)|0x01;
      else
        data = (data<<1)&0xfe;
      TOSH_SET_CC_PCLK_PIN();
    }

    TOSH_SET_CC_PALE_PIN();
    TOSH_MAKE_CC_PDATA_OUTPUT();
    TOSH_SET_CC_PDATA_PIN();

    return data;
  }


  async command bool HPLCC1000.GetLOCK() {
    char cVal;

    cVal = TOSH_READ_CC_CHP_OUT_PIN();

    return cVal;
  }
}
  
