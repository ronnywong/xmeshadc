// $Id: sensorboardApp.h,v 1.1.2.2 2006/12/07 15:19:29 chenrl Exp $
/* sensorboard.h - hardware specific definitions for the MTS300/310 
*/
// controls for the voltage reference monitor
#define MAKE_BAT_MONITOR_OUTPUT() sbi(DDRA, 5)
#define MAKE_ADC_INPUT() cbi(DDRF, 7)
#define SET_BAT_MONITOR() sbi(PORTA, 5)
#define CLEAR_BAT_MONITOR() cbi(PORTA, 5)

// Define SOUND_STATE_CHANGE one of two ways:
//      One time sound at test init   ==>  FALSE
//      Continuous beeping throughout ==>  !sound_state


#define SOUND_STATE_CHANGE  FALSE
//#define SOUND_STATE_CHANGE  !sound_state

typedef struct XDataMsg {
  uint8_t  board_id;
  uint8_t  packet_id;
  //uint8_t  node_id;
  uint16_t  parent;       // 4
  uint16_t vref;
  uint16_t thermistor;
  uint16_t light;
  uint16_t mic;
  uint16_t accelX;
  uint16_t accelY;
  uint16_t magX;
  uint16_t magY;
} __attribute__ ((packed)) XDataMsg;

enum {
    BATT_PORT = 7,             //adc port for battery voltage
};

enum {
    AM_XDEBUG_MSG    = 49,
    AM_XSENSOR_MSG   = 50,
    AM_XMULTIHOP_MSG = 51,         // xsensor multihop 
};

// Zero out the accelerometer, chrl@20061207
#define ACCEL_AVERAGE_POINTS 3

#ifdef APP_RATE
uint32_t XSENSOR_SAMPLE_RATE = APP_RATE;
#else
#ifdef USE_LOW_POWER
uint32_t XSENSOR_SAMPLE_RATE = 184320;
#else
uint32_t XSENSOR_SAMPLE_RATE = 1843;
#endif
#endif

 uint32_t   timer_rate;
 
