
/*
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created @ 01/14/2003 
 * Last Modified:     @ 08/14/2003
 * 
 * driver for ADG715BRU on mda300ca 
 * inspired from joe Polastre previous driver 
 */

configuration SwitchC
{
  provides {
    interface StdControl as SwitchControl;
    interface Switch;
  }
}
implementation
{
  components I2CPacketC,SwitchM;
  Switch = SwitchM;
  SwitchControl = SwitchM;
  SwitchM.I2CPacket -> I2CPacketC.I2CPacket[75];
}
