/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: DetectM.nc,v 1.4.2.2 2007/04/26 20:14:17 njain Exp $
 */

/** 
 * XSensor multi-hop application for MSP410 sensorboard.
 *	This application:
 *   - senses PIR signals for quadrature detect
 *   - senses Mag signals for magentometer detect
 *   - xmit a msg to the base whenever a sensor event is detected.
 *   - if no sensor event then xmits a health msg every 30 sec
 *   - once a sensor detects an event there is a 4 sec dead time before
 *     the sensor can sent another event.
 *
 * @author Tim Reilly, Martin Turon, Pi Peng
 */
 
#include "appFeatures.h"
includes XCommand;

includes sensorboard;
module DetectM
{
    provides {
	interface StdControl;
	interface IntOutput as MicOutput;
    }
	
    uses {
	interface Leds;
	interface MhopSend as Send;
	interface PIR;
	interface Mic;
	interface Maglib;
        interface Sounder;
	interface RouteControl;
	interface Timer as SampleTimer;
	interface Timer as HBTimer;              //heartbeat timer
	interface Timer as PIRTimer;
	interface Interrupt as MicInterrupt;
	interface Sample as PIRSample;
	interface Sample as MicSample;
	interface XCommand;
	interface XEEControl;
        
	//   interface ADC as Battery;    
	interface ADC;
	interface ADCControl; 
        command void health_packet(bool enable, uint16_t intv);
        command HealthMsg* HealthMsgGet();
    }
}

implementation
{
#include "SODebug.h"
    enum
    {
	MAX_MESSAGES = 8
    };
    
    //uint8_t 	s_msgIndex = 0;            //tim code
    //TOS_Msg 	s_msg[MAX_MESSAGES];       //tim code
    
    
    TOS_Msg    msg_buf_radio;
    TOS_MsgPtr msg_radio;
    HealthMsg *h_msg;
    bool       sending_packet;
    
    uint16_t    msg_seqno;
    uint8_t	quadrant_g	= 0;
    uint16_t	mag_g		= 0;
    int16_t	magDelta_g	= 0;
    uint16_t	audio_g		= 0;
    uint16_t	deadTime_g	= 0;
    bool 	pirDetect_g	= FALSE;
    bool 	audioDetect_g	= FALSE;
    bool 	magDetect_g	= FALSE;
    uint8_t	masterState_g	= START;
    uint8_t	detectType_g	= NONE; // type of detection triggered

//debug
    
//mag    
    uint16_t    mag_trig_cnt;
    uint16_t    magx_data;                 //lastest magx data
    uint16_t    magy_data;                 //lastest magy data
    uint16_t    magx_avg_sum;               // sum for averaging mag bias
    uint16_t    magy_avg_sum;               // sum for averaging mag bias
    uint16_t    magx_mv_arry[MAG_MW_SIZE]; // moving mag_x window array
    uint16_t    magy_mv_arry[MAG_MW_SIZE]; // moving mag_y window array
    uint16_t    mag_sum_xy[MAG_XY_SIZE];   // moving window to track x+y correlation
    uint16_t    mag_dif_xy[MAG_XY_SIZE];   // moving window to track x-y correlation
    uint8_t     mag_indx;                  // indx for mag moving window array
    uint8_t     mag_diff_indx;             // indx for mag diff arrays
    uint16_t    mag_msg_cnt;               //cnts nmb mag msg xmitted
    uint8_t	    MagMsgDeadTimeCnt;         //counter to for dead time between mag msgs          
    bool        bMagTrg;                   //true if mag tripped
    //bool        bArryZeroed;               //true until once pass thru avg array
    //bool        bArry2ndPass;              //true until 2nd pass thru arrays
    uint8_t     zero_ary_cnt;              //counts time thru mag arrays for correct zeroing
    bool        bMagMsgSent;               //TRUE if mag event msg sent
    bool        bXBiasAdjust;              //TRUE if x bias pot being adjusted
    bool        bYBiasAdjust;              //TRUE if y bias pot being adjusted
    bool        bPotAdjust;                //TRUE if x or y bias pot being adjusted                  
//pir
    uint16_t	pir_g;
    uint8_t     PIR_Detect_State;         //tracks state of pir detection alg
    uint16_t    PIR_cnt;                  //cnts pirs
    uint8_t     bPIRstate;                //tracks pir hi/lo detects
    uint8_t     PIR_xings;                 //track # of pir zero crossings
    uint8_t     PIR_quad;                 // instantaneous quad detect state
    uint8_t     PIR_quad_tot;             // tracks if all quads that fired
    uint16_t    pir_msg_cnt;              //cnts nmb pir msg xmitted
    bool        bPIRTrg;                  //true if mag tripped
    bool        bPIRMsgSent;              //TRUE if mag event msg sent
    bool	    PIRMsgDeadTimeCnt;        //counter to for dead time between mag msgs          
    
//sounder
    bool        bSounder;                 //true if sounder activated for detect events 
//battery
    uint16_t    adc_bg_ref;               //adc band gap reference
    uint16_t    BattMV;                   //computed battery voltage (mv)
    
// heartbeat
    uint8_t    HB_cnt;                   //counts timer tics between HB msg
    uint16_t   hb_msg_cnt;               //counts # of heart beat msg xmitted.
    
    /**
     * Enables all sensor device interrupts.
     */
    void EnableInterrupts() {
	
//		call MicInterrupt.enable();                !!!! disable
	call PIR.IntEnable();             
	call Leds.greenOn();
    }
    
    /**
     * Disables all sensor device interrupts.
     */
    void DisableInterrupts() {
//		call MicInterrupt.disable();
	call PIR.IntDisable();
	call Leds.greenOff();
    }
    
#ifdef TimeCode	
    
    /**
     * Selects the next available message buffer for sending message.
     */
    void SelectNextMessage() {
	s_msgIndex = (s_msgIndex + 1) % MAX_MESSAGES;
    }
#endif
    
    
    /*************************************************************************
     * Task to rest mag tracking arrays
     *************************************************************************/
    task void ZeroMVArray(){
	uint16_t i;
	
	
	for (i =0 ; i <= MAG_MW_SIZE-1; i++){
	    magx_mv_arry[i] = 0;
	    magy_mv_arry[i] = 0;
	}
	for (i=0; i < MAG_XY_SIZE-1; i++){
	    mag_sum_xy[i] = 0;
	    mag_dif_xy[i] = 0;
	}
	mag_indx = 0;
	mag_diff_indx = 0;
	magx_avg_sum = 0;
	magy_avg_sum = 0;
	zero_ary_cnt = 0;
	return;
    }
    
    
    /************************************************************************************
     * Task to set magnetometer on
     ***********************************************************************************/
    task void MagOnTask(){
	call Mic.MicOff();
	call Maglib.mag_measure();
	masterState_g = INITIALIZED;
	call SampleTimer.start(TIMER_ONE_SHOT,POWERON_TIME);         
	
    }
    
    /************************************************************************************
     * Task to set quad detect adjust
     ***********************************************************************************/
    task void QuadDetectAdjTask(){
	call PIR.QuadAdjust(PIR_QUAD_ADJUST);	
    }
    
    
     /************************************************************************************
      * Task used to send detection message into network.
      ***********************************************************************************/
    task void SendMessageTask() {
	uint16_t len;
	if (!sending_packet){
	    
	    // XDataMsg *xDataMsg =  (XDataMsg*)call Send.getBuffer(&s_msg[s_msgIndex],&len);
	    
	    
	    
	    XDataMsg *xDataMsg = (XDataMsg*)call Send.getBuffer(msg_radio, &len);
	    
	    
	    
	    call Leds.yellowOn();	   
	    
	    msg_seqno++;
	    
	    xDataMsg->xMeshHeader.board_id  = SENSOR_BOARD_ID;
	    xDataMsg->xMeshHeader.packet_id = 1;    
//	    xDataMsg->node_id   = TOS_LOCAL_ADDRESS;
	    xDataMsg->xMeshHeader.parent    = call RouteControl.getParent();
	    xDataMsg->xData.datap1.seq_no = msg_seqno;
	    atomic xDataMsg->xData.datap1.batt = BattMV; 
	    xDataMsg->xData.datap1.quadrant = PIR_quad_tot;
	    xDataMsg->xData.datap1.pir = pir_g;
	    xDataMsg->xData.datap1.mag = magDelta_g;
	    xDataMsg->xData.datap1.audio = audio_g;
	    xDataMsg->xData.datap1.pirThreshold = PIR_THRESHOLD;
	    xDataMsg->xData.datap1.magThreshold = MAG_THRESHOLD;
	    xDataMsg->xData.datap1.audioThreshold = AUDIO_THRESHOLD;
	    
	    sending_packet = TRUE;

	    if (call Send.send(BASE_STATION_ADDRESS,MODE_UPSTREAM,msg_radio, sizeof(XDataMsg)) != SUCCESS) {
		atomic sending_packet = FALSE;
		call Leds.yellowOff();
	    }
	    
	    
	    
//		if (call Send.send(&s_msg[s_msgIndex],sizeof(XDataMsg)))
//		{
//			SelectNextMessage();
//		}
	    
	    
	}
    }
    
	
    /**
     * Initialize components.
     *
     * @return SUCCESS
     */
    command result_t StdControl.init() {
	
	atomic msg_radio = &msg_buf_radio;
	sending_packet = FALSE;
// init hb
        HB_cnt = 0;        
        hb_msg_cnt = 0;
	
// sounder
        bSounder = FALSE;            //set true for sounder activation on sensor event
	
//init mag params	    
	bMagTrg = FALSE;
        bMagMsgSent = FALSE;
	MagMsgDeadTimeCnt = 0;
        mag_msg_cnt = 0; 
        msg_seqno = 0;
	bXBiasAdjust = FALSE;
	bYBiasAdjust = FALSE;
	post ZeroMVArray();
	
//init pir params       
	pir_g			= 0;
        PIR_Detect_State = PIR_IDLE;
        PIR_cnt = 0;
        PIR_xings = 0;
        PIR_quad = 0;
	PIR_quad_tot = 0;
	bPIRTrg = FALSE;
        bPIRMsgSent = FALSE;
        PIRMsgDeadTimeCnt = 0;
        pir_msg_cnt = 0;
	
#ifdef DEBUG
        init_debug();
#endif

	  TOSH_CLR_PW0_PIN();            //photo power off
	  TOSH_SET_PW2_PIN();            //sounder power off
	
	  TOSH_SET_PW3_PIN();            //mic power off
	  TOSH_CLR_PW4_PIN();            //accel power off
	  TOSH_SET_PW5_PIN();            //mag power off
	  TOSH_SET_PW6_PIN();            //PIR power off

    	call Leds.init();
        call ADCControl.bindPort(TOS_ADC_BG_PORT,TOSH_ACTUAL_BANDGAP_PORT);
	call ADCControl.init();
//	outp(0x40,ADMUX);
	return SUCCESS;
    }
    
    /**
     * Start components.
     *
     * @return SUCCESS
     */
    command result_t StdControl.start() {
	call Leds.redOn();
	SODbg(DBG_USR2, "Started \n");	
	// Setup mic sensor
	//call Mic.gainAdjust(MIC_GAIN);
	//call Mic.detectAdjust(MIC_DETECT_ADJUST);
	//call Mic.LPFsetFreq(MIC_LPF);
	//call Mic.HPFsetFreq(MIC_HPF);
	
        
        call Sounder.setInterval(921);
	
	// start app
    	masterState_g = START;
	
	h_msg = call HealthMsgGet();
	h_msg->rsvd_app_type = SENSOR_BOARD_ID;
	call SampleTimer.start(TIMER_ONE_SHOT,START_TIME);   //give system time to start
	call HBTimer.start(TIMER_REPEAT,HB_TIME);            //start heartbeat monitor	
	call health_packet(TRUE,TOS_HEALTH_UPDATE);
		return SUCCESS;
    }
    
    /**
     * Stop components.
     *
     * @return SUCCESS
     */
    command result_t StdControl.stop() {
	call Maglib.mag_stop();
	
	return SUCCESS;
    }
    
    
    
    /**
     * Event signaled when detection message has been sent.
     * 
     * @param m Pointer to sent message.
     * @param success SUCCESS or FAIL
     * @return SUCCESS or FAIL
     */
    event result_t Send.sendDone(TOS_MsgPtr msg, result_t success) {
        sending_packet = FALSE;
	
	call Leds.yellowOff();
	msg_radio = msg;
	return success;
    }
    
    /**************************************************************************
     * Data ready from PIR
     * - test value every 1 msec.
     * - test for max time of 500msec
     * - if adc data does not toggle from max to min then reject
     * - PIR interrupt is off  
     * - value = data from PIR window detect
     * - PIR bias is ~512
     * - On first detect: if
     * @return SUCCESS
     ***************************************************************************/
    
    event result_t PIR.DataDone(uint16_t value){
	bool bDetectDone = FALSE;
	
	//  SODbg(DBG_USR2, "PIR Data: %i  : PIR_Detect_State: %i \n", value, PIR_Detect_State); 
	
        switch (PIR_Detect_State){
	    case PIR_IDLE:    
		if (value < PIR_MIN) bPIRstate = FALSE;
		if (value > PIR_MAX) bPIRstate = TRUE;
		if ((value < PIR_MAX) && (value > PIR_MIN)){ //not outside window detect
		    call PIR.IntEnable();  
		    return SUCCESS;
		}
		PIR_Detect_State = PIR_MONITOR;
		PIR_cnt = 0;
		PIR_xings = 0;
		pir_g = 0;
		break;
		
	    case PIR_MONITOR:            
		if (value > pir_g) pir_g = value;   //find greated pir_g value during detect
		PIR_cnt++;
		call PIR.QuadRead(&PIR_quad);
		PIR_quad_tot = PIR_quad_tot | PIR_quad;
		
		switch (bPIRstate){
		    
		    case FALSE:
			if (value > PIR_MAX){
			    //!!!!       SODbg(DBG_USR2, "POS PIR detect PIR_cnt: %i PIRQUAD: %i pir_g: %i \n",PIR_cnt,PIR_quad_tot,pir_g);
			    //  call Sounder.Beep(2000);
			    PIR_xings++;
			    bPIRstate = TRUE;
			}
			break;
		    case TRUE:   
			if (value < PIR_MIN){
			    //!!!         SODbg(DBG_USR2, "NEG PIR detect PIR_cnt: %i  PIRQUAD: %i pir_g: %i \n",PIR_cnt,PIR_quad_tot,pir_g);
			    //    call Sounder.Beep(2000);
			    PIR_xings++;
			    bPIRstate = FALSE;
			}
			break;
		}//switch bPIRstate
		break;
	} //switch PIR_Detect_State
	
	//SODbg(DBG_USR2, "DETECT STATE: %i, PIR_cnt: %i bPIRState: %i  data %i \n",PIR_Detect_State,PIR_cnt,bPIRstate,value);
	
	
	
         if (PIR_xings >= PIR_TRAN_THRESH){
	     if (bSounder){ 
		 call Sounder.setInterval(921);      
		 call Sounder.Beep(4000);
	     }
	     //SODbg(DBG_USR2, "DETECT STATE target; PIR crossings: %i  \n", PIR_xings);
	     if (!PIR_quad_tot){
		 PIR_quad_tot = 0x1f;
		 //!!!     SODbg(DBG_USR2, "************************PIR DETECT: NO QUAD  : Quad: %i  \n",PIR_quad_tot);
	     }
	     else
	     {
		 //!!!      SODbg(DBG_USR2, "************************PIR DETECT  : Quad: %i  \n",PIR_quad_tot);
	     }
	     PIR_Detect_State = PIR_IDLE;
	     bPIRTrg = TRUE;
	     //call PIR.IntEnable();
	     return SUCCESS;
	 }
	 
	 if (PIR_cnt == PIR_CNT_MAX){     //timeout, no detect
	     //!!!     SODbg(DBG_USR2, "DETECT STATE timeout; PIR crossings: %i  \n", PIR_xings);
	     PIR_Detect_State = PIR_IDLE;
	     PIR_quad_tot = 0;
	     call PIR.IntEnable();
	     return SUCCESS;
	 }
         
         
	 if (!bDetectDone){
//		     SODbg(DBG_USR2, "Firing PRI Timer  \n");
             call ADC.getData();                           //battery data ready causes reentry into this routine!
             call PIRTimer.start(TIMER_ONE_SHOT,PIR_SAMPLE_TIME);
             return SUCCESS;
         }
	 
    }	
    
    /**************************************************************************
     * PIRTimer.fired
     * - read a pir adc value
     * @return SUCCESS
     *************************************************************************/
    
    event result_t PIRTimer.fired(){
	
//        SODbg(DBG_USR2, "PIRTimer fired \n");
        call PIR.sampleNow();
	return SUCCESS;
	
    }
    
    /**************************************************************************
	 * PIR window threshold crossed.
	 * 
	 * Interrupt driver disables interrupt before signaling this event
	 * - keep PIR interrupt off.
	 * - Get PIR data
	 * @return SUCCESS
	 *************************************************************************/
    event result_t PIR.InterruptEvent(){
	//!!!     SODbg(DBG_USR2, "PIR INTERUPT event \n");
        call PIR.sampleNow();
	return SUCCESS;
    }
    
    /**************************************************************************
     * PIR detection threshold set
     *************************************************************************/
    event result_t PIR.detectAdjustDone(){
	SODbg(DBG_USR2, "PIR detect adjust done \n"); 
	call Mic.MicOff();                                   //make sure microphone is off!!!!!!!!!!!
	post QuadDetectAdjTask();
	return SUCCESS;
    }
    
    /**************************************************************************
     * PIR quad detection treshold set
     * Init timer to allow sensor to settle
     *************************************************************************/
    event result_t PIR.QuadAdjustDone() {
	SODbg(DBG_USR2, "PIR quad adjust done \n");  
	post MagOnTask();
	return SUCCESS;
	
    }
    
    /**************************************************************************
     * Event signaled when SampleTimer fires
     * - if masterState_g == START then turn on PIR detectors, init the 
     *   digital pot setting the window detect. This occurs about 10msec
     *   after system starts.
     * - INITIALIZED occurs after all sensors are on and set
     * - DETECTION = sensors can start detecting
     **************************************************************************/
    event result_t SampleTimer.fired() {
 
        SODbg(DBG_USR2, "SampleTimer Fired: state = : %i \n",masterState_g);
	call Sounder.Beep(2000);                               
    	if (masterState_g == START ){
	    
            call ADC.getData();
	    call PIR.On();
            SODbg(DBG_USR2, "PIR ON \n");
            call PIR.detectAdjust(PIR_DETECT_ADJUST); // lower value => more sensitive
            return SUCCESS;
        }    
        if (masterState_g == INITIALIZED){       
	    call Leds.redOff();
	    EnableInterrupts();                           //asb- move from ProcessState
            masterState_g = DETECTION;
	}
	
	return SUCCESS;
    }
    
    
    /**
     * Command invoked by sensor component to deliver a new sample.
     * 
     * @param value New sensor sample
     * @return SUCCESS
     */
    command result_t MicOutput.output(uint16_t value) {
	return SUCCESS;
    }
    
    /**************************************************************************
     * task to detect magnetometer triggers
     *  - occurs at rate of 100Hz with new magx and magy data
     *  - MWA = moving window average of MAG_MW_SIZE samples to remove dc
     *    for both magx and magy.
     *  - LPF = low pass filter, another moving window average of size MAG_LP_SIZE
     *    to remove high freq noise, both magx and magy
     *  - every sample compute magx_amp= abs(magx(LPF) - magy(MWA) 
     *    to get amplitude of  signal over base line, same for y
     *  - DIF_ARY = moving window difference array, size = MAG_XY_SIZE
     *  - SUM_ARY = moving window sum array, size = MAG_XY_SIZE
     *  - mag_dif = abs(magx_amp - magyamp)   
     *  - mag_sum = abs(magx_amp + magyamp)
     *  - trigger requires:
     *     SUM(mag_dif) > MAG_DIFFSUM_THRESH   AND SUM(MAG_sum) > MAG_DIFFDIFF_THRESH
     *  - high freq noise pulses are correlated in both magx and magy, this removes
     *    these common noise sources
     **************************************************************************/
    task void DetectMag(){
	uint16_t magx_lp_avg = 0;
	uint16_t magy_lp_avg = 0;
	uint16_t magx_avg,magy_avg;
	int16_t  magx_delta,magy_delta;   //changed from unit16
	uint16_t diff_xy,sum_xy;
	uint16_t sum_xysum = 0;
	uint16_t sum_xydiff = 0;
	uint8_t  i;
	int16_t  lp_indx;
	
	//SODbg(DBG_USR2, "          MagFired: Data %i  MagxData: %i  MagxAvg: %i  MagyData: %i MagyAvg: %i \n", abs_delta,magx_data,magx_avg,magy_data,magy_avg); 
	
        if (bPotAdjust){         //don't compute trigger if bias pots are being adjusted
	    post ZeroMVArray();   //keep arrays zeroed.		
	    return;               
        }
	
	
	
// compute moving average background mag bias,moving window bias
	
	magx_avg_sum += magx_data - magx_mv_arry[mag_indx];    //update sum
	magx_mv_arry[mag_indx] = magx_data;
	magy_avg_sum += magy_data - magy_mv_arry[mag_indx];    //update sum
	magy_mv_arry[mag_indx] = magy_data;
	mag_indx++;
	
	//SODbg(DBG_USR2, "MagFired:magx_data: %i magx_avg: %i magy_data: %i magy_avg: %i \n", magx_data,magx_avg_sum >> 2,magy_data,magy_avg_sum >> 2);  	
	if (mag_indx == MAG_MW_SIZE){
	    mag_indx = 0;
	    if (zero_ary_cnt ==0)zero_ary_cnt = 1;		   
	}
	if (zero_ary_cnt == 0)return; 
        
	magx_avg = magx_avg_sum >> 2;   //scale to 14 bit number (2^^10*2^^6)/2^^2
        magy_avg = magy_avg_sum >> 2;
	
	//sum lastest MAG_LP_SIZE samples
	lp_indx = mag_indx - MAG_LP_SIZE;
	if (lp_indx < 0) lp_indx += MAG_MW_SIZE; 
	for (i = 0; i <= MAG_LP_SIZE-1; i++){
	    magx_lp_avg += magx_mv_arry[lp_indx];
	    magy_lp_avg += magy_mv_arry[lp_indx];
	    lp_indx++; 
	    if (lp_indx == MAG_MW_SIZE) lp_indx = 0;
        }
 // magx_lp_avg,.. are 14 bit numbers, 2^10*2^4       
//	    magx_delta = abs(magx_avg - magx_lp_avg); //14bit
//        magy_delta = abs(magy_avg - magy_lp_avg);

	magx_delta = magx_avg - magx_lp_avg; //14bit
        magy_delta = magy_avg - magy_lp_avg;
	

// scale magx_delta to 12 bit number so that 2^12*2^4 = 2^16
	magx_delta = magx_delta >> 2;
        magy_delta = magy_delta >> 2;
        
        diff_xy = abs(magx_delta - magy_delta);   
//		sum_xy  = abs(magx_delta + magy_delta); org code
        sum_xy  = abs(magx_delta) + abs(magy_delta); 
	
// update moving window diff arrays
        mag_sum_xy[mag_diff_indx] = sum_xy;
        mag_dif_xy[mag_diff_indx] = diff_xy;
        mag_diff_indx++;
	if (mag_diff_indx == MAG_XY_SIZE){
	    mag_diff_indx = 0;
	    if (zero_ary_cnt == 1){
		zero_ary_cnt = 2;
		//SODbg(DBG_USR2,"1st pass thru diff arrays \n");
	    }
        }
	
	
	
//if 2nd pass thru arrays not complete, exit
        if (zero_ary_cnt == 1) return; 
	
	
// sum moving diff arrays
	for (i = 0; i <= MAG_XY_SIZE-1;i++){
	    sum_xysum += mag_sum_xy[i];
	    sum_xydiff += mag_dif_xy[i];
        }
	
	//   SODbg(DBG_USR2, "          MagFired: MagxData: %i  magx_delta: %i MagyData: %i  magydelta: %i x-y: %i  x+y: %i sum_sumxy: %i sum_difxy: %i  \n", \
					       //			                            magx_data,magx_delta, magy_data,magy_delta,diff_xy,sum_xy,sum_xysum,sum_xydiff); 
					       
	if (bMagTrg) return;   		            //if mag trg has occurred then don't track signal
					       
					       // SODbg(DBG_USR2, "          MagFired: MagxData: %i  magx_delta: %i MagyData: %i  magydelta: %i x-y: %i  x+y: %i sum_sumxy: %i sum_difxy: %i  \n", \
								//			                            magx_data,magx_delta, magy_data,magy_delta,diff_xy,sum_xy,sum_xysum,sum_xydiff); 
								
	if (masterState_g  == DETECTION)
	{
	    
	    
	    
	    if ((sum_xysum >= MAG_DIFFSUM_THRESH) && (sum_xydiff > MAG_DIFFDIFF_THRESH)){
		SODbg(DBG_USR2, "          MagFired: MagxData: %i  magx_delta: %i MagyData: %i  magydelta: %i x-y: %i  x+y: %i sum_sumxy: %i sum_difxy: %i  \n", \
		      magx_data,magx_delta, magy_data,magy_delta,diff_xy,sum_xy,sum_xysum,sum_xydiff); 
		
		//	for (i = 0; i <= MAG_XY_SIZE-1; i++){
		//      SODbg(DBG_USR2," mag_diff_indx %i xyindx: %i mag_sum_xy %i mag_diff_xy %i \n", mag_diff_indx,i, mag_sum_xy[i], mag_dif_xy[i]);
		//	}
		
		call Maglib.mag_bias_stop();
		magDelta_g = sum_xysum;
		bMagTrg = TRUE;
		
		if (bSounder){ 
		    call Sounder.setInterval(1821);
                    call Sounder.Beep(25000);
		}
	    }  //if abs_delta
	} //if DETECTION
	return;
    }
    /**************************************************************************
     * Event signaled when Maglib magx,magx is making a pot bias change
     *  - results in very large change of x or y mag values .
     *  - disable mag detection for xxx
     **************************************************************************/
    event result_t Maglib.biasx_change(uint8_t MagDCx){                       
	SODbg(DBG_USR2, "XPot Adjust: Data %i  \n",MagDCx); 
	bXBiasAdjust = TRUE;
	bPotAdjust = TRUE;
	return SUCCESS;
    }
    event result_t Maglib.biasy_change(uint8_t MagDCy){
	SODbg(DBG_USR2, "YPot Adjust: Data %i  \n",MagDCy);
	bYBiasAdjust = TRUE;
	bPotAdjust = TRUE; 
	return SUCCESS;
    }
    event result_t Maglib.biasx_changedone(uint8_t MagDCx){
	SODbg(DBG_USR2, "XPot Adjust Done: Data %i  \n",MagDCx); 
	bXBiasAdjust = FALSE;
	if (!bYBiasAdjust) bPotAdjust = FALSE;
	return SUCCESS;
    }
    event result_t Maglib.biasy_changedone(uint8_t MagDCy){
	SODbg(DBG_USR2, "YPot Adjust Done: Data %i  \n",MagDCy); 
	bYBiasAdjust = FALSE;
        if (!bXBiasAdjust) bPotAdjust = FALSE;
	return SUCCESS;
    }
    event result_t Maglib.MagxReady(uint16_t data){
	magx_data = data;
	post DetectMag();
	return SUCCESS;
    } 
    event result_t Maglib.MagyReady(uint16_t data){
	magy_data = data;
	//post DetectMagy();
	return SUCCESS;
    }
    
    
/**************************************************************************
 * Read ADC internal bandgap refernce value
 **************************************************************************/
  async event result_t ADC.dataReady(uint16_t data){
        atomic BattMV = data/2;
	//!!!      SODbg(DBG_USR2, "       Band gap ref  %i \n", adc_bg_ref); 
        return SUCCESS;
   }
    
/**************************************************************************
 * Heartbeat timer
 * - Fires every HB_TIME (~0.5 sec)
 *
 * - If bMagTrg = TRUE then mag trigger has occurred.
 *   If not sent mag event msg within DEAD_TIME then send new msg
 *
 * - Same with PIR

 * - 
 *   If no trig msg after HB_MAX_CNT then send heart beat message
 *  
 **************************************************************************/
    event result_t HBTimer.fired() {
	bool bPostMsg = FALSE;                  //true if new message to send
	bool bHeartBeatMsg = FALSE;
	bool bMagMsg = FALSE;
	bool bPIRMsg = FALSE;
	
	if(sending_packet == TRUE) 
	    return SUCCESS;                      //try next timer fire
	
// magnetometer event?
	if (bMagTrg) {                          //mag trigger
	    if (!bMagMsgSent){                    //msg already not already sent   
		bPostMsg = TRUE;                    //send new msg
		bMagMsgSent = TRUE;
		mag_msg_cnt++;
		MagMsgDeadTimeCnt = 0;                      //reset dead time counter 
		bMagMsg = TRUE;
	    }
	    else{                                 //mag msg already sent, dead time zone
		MagMsgDeadTimeCnt++;
		if (MagMsgDeadTimeCnt > MAX_DEAD_TIME_CNT){ 
		    magDelta_g = 0;                 //reset mag report level reported in msg
		    bMagMsgSent = FALSE;            //ok to send new msg
		    bMagTrg = FALSE;                //ok for new msg
              call Maglib.mag_bias_start();   //enable mag bias autotrack 
		}
	    } 
	} //bMagTrg
	
	// PIR event?
	if (bPIRTrg) {                          //mag trigger
	    if (!bPIRMsgSent){                    //msg already not already sent   
		bPostMsg = TRUE;                    //send new msg
		bPIRMsgSent = TRUE;
		pir_msg_cnt++;
		PIRMsgDeadTimeCnt = 0;                      //reset dead time counter 
		bPIRMsg = TRUE;
		}
	    else{                                 //mag msg already sent, dead time zone
    	  PIRMsgDeadTimeCnt++;
	  if (PIRMsgDeadTimeCnt > MAX_DEAD_TIME_CNT){ 
              PIR_quad_tot = 0;
	      bPIRMsgSent = FALSE;            //ok to send new msg
	      bPIRTrg = FALSE;                //ok for new msg
              call PIR.IntEnable();           //reenable PIR interrupt
          }
	    } 
	} //bPIRTrg
	
	
	
	
	
	// heart beat?     
	if (bPostMsg){                            //new msg, reset heart beat
	    HB_cnt = 0;
	}
	else{
	    HB_cnt++;
	    if (HB_cnt > HB_MAX_CNT){
		HB_cnt = 0;
		hb_msg_cnt++;
		bHeartBeatMsg = TRUE;
		bPostMsg = TRUE;                  //send new hb msg
		}	       
	} //bPostMsg
	
	
	if (bPostMsg){
	    if (bHeartBeatMsg){ 
		SODbg(DBG_USR2, "***************************************HEARTBEAT msg : Batter mV: %i hb_msg_cnt: %i  \n", 100*BattMV,hb_msg_cnt);
	    }
	    if (bMagMsg){
		SODbg(DBG_USR2, "****************************************MAG msg sent: magDelta_g: %i mag_msg_cnt: %i \n",magDelta_g,mag_msg_cnt); 
	    }
	    if (bPIRMsg){
		SODbg(DBG_USR2, "****************************************PIR msg sent: PIR_quad_tot: %i pir_msg_cnt %i \n",PIR_quad_tot,pir_msg_cnt); 
	    }
	    
	    post SendMessageTask();
	}	
	return SUCCESS;
	
    }
    
 /** 
  * Handles all broadcast command messages sent over network. 
  *
  * NOTE: Bcast messages will not be received if seq_no is not properly
  *       set in first two bytes of data payload.  Also, payload is 
  *       the remaining data after the required seq_no.
  *
  * @version   2004/10/5   mturon     Initial version
  */
  event result_t XCommand.received(XCommandOp *opcode) {
      return SUCCESS;
  }
  
   event result_t XEEControl.restoreDone(result_t result)
   {
 	 return SUCCESS;
   }  

}
  
