==============================================================
Version: MoteWorks 2.0.21 rev. F Standard 
Part #:  5230-0102-01_F Release Notes

$Id: README.txt,v 1.14.2.27 2007/05/03 00:08:58 jprabhu Exp $
==============================================================

1. Introduction

   MoteWorks 2.0 is a complete software development platform for wireless
   sensor networking applications.

   This release is composed of the following parts:
	MoteWorks 2.0 Release Notes	    		5230_0102_01_F
	MoteWorks 2.0 Installer		    		5220_0102_01_F

	MoteView 2.0 Installer		    		5620_0008_05_F
	MoteView 2.0 Manual		     		7430_0008_05_F

	MoteWorks 2.0 Getting Started Guide		7430_0102_01_E
	XMesh 2.0 Manual		     		7430_0108_01_D
	XServe 2.0 Manual		     		7430_0111_01_E
	

2. System Requirements
   * Microsoft Windows XP or 2000 Pro
   * PIII 500MHz, 256 MB RAM, 1GB Hard Disk

   Note: Windows Vista is not supported


3. New Features
 
   3.1 MICAz Low Power (LP)

   The MICAz platform now has an asyncrounous low power radio stack.
   The algorithm is similar to the MICA2 low power stack, except there
   are no time synchronization optimizations at this time.  The baseline
   power consumption for this stack is ~400 uAmps when simply listening.  
   Typical power consumption for a 3 minute data rate is about ~700 uAmps 
   average current.

   3.2 XMesh Downstream

   XMesh 2.0 now provides a two-way communication service.  In addition to
   the standard upstream (any to base) communication, this version of
   XMesh provides a directed downstream (base to any) data delivery service. 

   3.3 XMesh Extended Low Power (ELP)

   XMesh can now be configured into a hybrid star configuration with a
   high power (HP) backbone, and extended low power (ELP) end points. 
   
   3.4 XServe 2.0

   XServe 2.0 provides a much more comprehensive and powerful set of features
   than the previous version.  All mote data can be described with XML.  Live
   mote data can be transformed into XML in real-time.  Commands can be sent to 
   xserve or injected into the mote network using XML-RPC as well.
   
   3.5 New Platform Support
   
   MoteWorks 2.0.E adds support for three new modules: M2100, M2110, and M9100.
   These are based on the ATmega1281 processor which provides the following benefits:
   	- 2x RAM space increase to 8KB
   	- Low voltage operation down to 1.8 Volts
   	- Ultra-low 1uA deep sleep
   
   Included in this new platform support is an updated Atmega 1281 Toolchain
   and a new RF230 Radio Driver.

   3.6 AvrStudio JTAG debugging
   
   MoteWorks 2.0.E supports symbol level JTAG debugging of firmware.
	 
4. Advisories and Work Arounds

   4.1 Mica2 Low Power Clock

   The Mica2 Low Power stack requires the internal 8MHz clock fuse setting on 
   all remote nodes.  This is because on the internal oscillator, the wake up 
   time is very fast (us).  The mica2 lp stack was designed to leverage quick 
   sleeps when possible, thus the internal oscillator is required.  Use the 
   external clock for the base station to provide UART stability.

   Please refer to the Getting Start Guide section on the fuses tool for 
   setting clkint or clkext.  MoteConfig will set these fuses correctly.

   4.2 MicaZ Low Power Clock

   The MicaZ Low Power stack requires all nodes to use the external clock fuse
   setting.  Since the external crystal provides uart debugging, and quick 
   wakeup is not as critical on packet based radio hardware, the micaz lp 
   timing is designed with the external clock in mind.  In the future, this 
   might change, but currently MicaZ lp needs the external 7.37MHz crystal.

   Please refer to the Getting Start Guide section on the fuses tool for 
   setting clkext.  MoteConfig will set these fuses correctly.

   4.3 Avarice JTAG obscures filename

   The code module filenames may be obscured in Avarice when using JTAG 
   to debug code.  There are two variants to this issue:

   The first is that the source file pulldown does not appear at all.  
   Resize the ice-insight window to make the source file pulldown appear 
   in the tool bar.  

   The second is that long paths obscure the filename.  To get around this, 
   click and drag on the source file pulldown.  You can scroll the filenames 
   right, left, up, and down within the window this way to view the 
   full filename.
   
   4.4 MIB520

   The MIB520 with a Mote may draw up to 150mA of current.  Some laptops can
   only drive less than 100mA on their USB ports.  On such systems, use an
   externally powered USB hub to supply more current.
   

5. Known Issues and Limitations

   5.1 OTAP for XMesh HP only

   The Over-The-Air-Programming capability is only supported on
   XMesh High Power networks at this time.

   5.2 TimeSync for MICA2 LP only

   The Time Synchronization service is only qualified for use with
   the CC1000 Low Power radio stack.

   5.3 XServe web interface for health only

   The health statistics page is the only supported portion of the current
   XServe web interface.  Use MoteConfig to perform remote reprogramming 
   using OTAP.  Use MoteView to send commands using XCommand.  For best results,
   start xserve from /opt/MoteWorks/tools/xserve/bin to enable the web interface.

   5.4 ELP mode limited to send only

   The Extended Low Power mode is only available for sending data from a 
   remote edge node.  There is no capability to send commands to ELP nodes
   at this time.

   5.5 INT2 issues with MICAZ 

   Sensor boards that use the INT2 line have known issues when used with the
   MICAZ Low Power stack.  These sensor boards include MTS300, MTS310, MTS400, 
   MTS420, and MDA100.  These issues are resolved with the MTS300CB, MTS310CB,
   and MDA100CB boards when using updated firmware.
   
   5.6 XServe 2.0 maximum data rate
   
   The data rate limit for xserve 2.0 is 5 packets/sec with database logging 
   enabled on a Stargate class CPU.  Actual performance varies depending on 
   services enabled and system performance.

   5.7 XServe "-platform" flag
   XServe tool does not list 'iris' as one of the valid options for 
   '-platform' flag. Since this flag is no longer used, the users may just 
   ignore this and use '-baud' flag while communicating with IRIS base 
   station while connecting for non default baudrates (i.e. other than 57600).


6. Bug Fixes   
   
   6.1 Programmers Notepad regional fix
   
   The issue with compiling nesC from within Programmers Notepad with certain 
   regional settings (Spain, France, etc.) has been resolved.  It is now possible
   to compile firmware from within Programmers Notepad, or as before from the cygwin 
   command line in these areas.

   6.2 XServe updates
   
   6.2.1 The xserve patches that were distributed with MoteWorks 2.0.B are now 
   integrated into the installer.  
   
   6.2.2 XServe connections have been made forward and backward compatible 
   with XServe 1.x and 2.x protocol.  Also, the connection timeout has been
   extended to 5 seconds.

   6.3 UISP updates
   
   MoteWorks 2.0.E updates the uisp mote programming tool to fix the following issues:
      - Node loads incorrect node_id from Internal EEPROM when using internal oscillator.
      - Cygwin cannot communicate with serial ports above COM16.
      
   6.4 Sensor driver updates
   
      - Support for new sensor boards: MTS410 / MTS420CC
      - Initialize Accelerator readings to be zero g for mts310 / mts400 / 410 / 420
      - Fixed mep510 and mts510 voltage incorrect on low voltage bug
      - Fixed incorrect MDA3X0 excitation bug
      - Fixed MTS300CB and MTS310CB light affects temp
 
   
7. Release History
   MoteWorks 2.0   Prerelease 	2006/03/06	(ec13)
   MoteWorks 2.0a  Standard  	2006/03/30	(rc3)
   MoteWorks 2.0b  Standard  	2006/05/03	(rc5)
   MoteWorks 2.0c  Standard  	2006/05/22	(rc5)
   MoteWorks 2.0d  Standard  	2006/11/30	(rc11)
   MoteWorks 2.0e  Standard  	2007/03/15 	(rc18)
   MoteWorks 2.0f  Standard  	2007/05/03 	(rc21)

