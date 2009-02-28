#define nx_struct struct
#define nx_union union
#define dbg(mode, format, ...) ((void)0)
#define dbg_clear(mode, format, ...) ((void)0)
#define dbg_active(mode) 0
# 116 "C:\\Crossbow\\cygwin\\usr\\local\\avr\\include\\stdint.h" 3
typedef int int8_t __attribute((__mode__(__QI__))) ;
typedef unsigned int uint8_t __attribute((__mode__(__QI__))) ;
typedef int int16_t __attribute((__mode__(__HI__))) ;
typedef unsigned int uint16_t __attribute((__mode__(__HI__))) ;
typedef int int32_t __attribute((__mode__(__SI__))) ;
typedef unsigned int uint32_t __attribute((__mode__(__SI__))) ;
typedef int int64_t __attribute((__mode__(__DI__))) ;
typedef unsigned int uint64_t __attribute((__mode__(__DI__))) ;
#line 135
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
#line 152
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;




typedef int64_t int_least64_t;




typedef uint64_t uint_least64_t;
#line 200
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;




typedef int64_t int_fast64_t;




typedef uint64_t uint_fast64_t;
#line 249
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 76 "C:\\Crossbow\\cygwin\\usr\\local\\avr\\include\\inttypes.h"
typedef int32_t int_farptr_t;



typedef uint32_t uint_farptr_t;
# 385 "C:\\Crossbow\\cygwin\\lib\\ncc\\nesc_nx.h"
typedef struct { char data[1]; } __attribute__((packed)) nx_int8_t;typedef int8_t __nesc_nxbase_nx_int8_t  ;
typedef struct { char data[2]; } __attribute__((packed)) nx_int16_t;typedef int16_t __nesc_nxbase_nx_int16_t  ;
typedef struct { char data[4]; } __attribute__((packed)) nx_int32_t;typedef int32_t __nesc_nxbase_nx_int32_t  ;
typedef struct { char data[8]; } __attribute__((packed)) nx_int64_t;typedef int64_t __nesc_nxbase_nx_int64_t  ;
typedef struct { char data[1]; } __attribute__((packed)) nx_uint8_t;typedef uint8_t __nesc_nxbase_nx_uint8_t  ;
typedef struct { char data[2]; } __attribute__((packed)) nx_uint16_t;typedef uint16_t __nesc_nxbase_nx_uint16_t  ;
typedef struct { char data[4]; } __attribute__((packed)) nx_uint32_t;typedef uint32_t __nesc_nxbase_nx_uint32_t  ;
typedef struct { char data[8]; } __attribute__((packed)) nx_uint64_t;typedef uint64_t __nesc_nxbase_nx_uint64_t  ;


typedef struct { char data[1]; } __attribute__((packed)) nxle_int8_t;typedef int8_t __nesc_nxbase_nxle_int8_t  ;
typedef struct { char data[2]; } __attribute__((packed)) nxle_int16_t;typedef int16_t __nesc_nxbase_nxle_int16_t  ;
typedef struct { char data[4]; } __attribute__((packed)) nxle_int32_t;typedef int32_t __nesc_nxbase_nxle_int32_t  ;
typedef struct { char data[8]; } __attribute__((packed)) nxle_int64_t;typedef int64_t __nesc_nxbase_nxle_int64_t  ;
typedef struct { char data[1]; } __attribute__((packed)) nxle_uint8_t;typedef uint8_t __nesc_nxbase_nxle_uint8_t  ;
typedef struct { char data[2]; } __attribute__((packed)) nxle_uint16_t;typedef uint16_t __nesc_nxbase_nxle_uint16_t  ;
typedef struct { char data[4]; } __attribute__((packed)) nxle_uint32_t;typedef uint32_t __nesc_nxbase_nxle_uint32_t  ;
typedef struct { char data[8]; } __attribute__((packed)) nxle_uint64_t;typedef uint64_t __nesc_nxbase_nxle_uint64_t  ;
# 213 "C:\\Crossbow\\cygwin\\usr\\local\\lib\\gcc\\avr\\3.4.5\\include\\stddef.h" 3
typedef unsigned int size_t;
# 110 "C:\\Crossbow\\cygwin\\usr\\local\\avr\\include\\string.h" 3
extern int memcmp(const void *, const void *, size_t ) __attribute((__pure__)) ;
# 325 "C:\\Crossbow\\cygwin\\usr\\local\\lib\\gcc\\avr\\3.4.5\\include\\stddef.h" 3
typedef int wchar_t;
# 69 "C:\\Crossbow\\cygwin\\usr\\local\\avr\\include\\stdlib.h"
#line 66
typedef struct __nesc_unnamed4242 {
  int quot;
  int rem;
} div_t;





#line 72
typedef struct __nesc_unnamed4243 {
  long quot;
  long rem;
} ldiv_t;


typedef int (*__compar_fn_t)(const void *, const void *);
# 151 "C:\\Crossbow\\cygwin\\usr\\local\\lib\\gcc\\avr\\3.4.5\\include\\stddef.h" 3
typedef int ptrdiff_t;
# 71 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\tos.h"
typedef unsigned char bool;






enum __nesc_unnamed4244 {
  FALSE = 0, 
  TRUE = 1
};


uint16_t TOS_LOCAL_ADDRESS = 1;





uint8_t TOS_ROUTE_PROTOCOL = 0x90;
#line 104
uint8_t TOS_BASE_STATION = 0;



const uint8_t TOS_DATA_LENGTH = 55;
#line 120
uint8_t TOS_PLATFORM = 3;
#line 143
enum __nesc_unnamed4245 {
  FAIL = 0, 
  SUCCESS = 1
};


static inline uint8_t rcombine(uint8_t r1, uint8_t r2);
typedef uint8_t result_t  ;







static inline result_t rcombine(result_t r1, result_t r2);







static inline result_t rcombine3(result_t r1, result_t r2, result_t r3);




static inline result_t rcombine4(result_t r1, result_t r2, result_t r3, 
result_t r4);





enum __nesc_unnamed4246 {
  NULL = 0x0
};
# 203 "C:\\Crossbow\\cygwin\\usr\\local\\avr\\include\\avr\\pgmspace.h" 3
typedef void prog_void __attribute((__progmem__)) ;
typedef char prog_char __attribute((__progmem__)) ;
typedef unsigned char prog_uchar __attribute((__progmem__)) ;

typedef int8_t prog_int8_t __attribute((__progmem__)) ;
typedef uint8_t prog_uint8_t __attribute((__progmem__)) ;
typedef int16_t prog_int16_t __attribute((__progmem__)) ;
typedef uint16_t prog_uint16_t __attribute((__progmem__)) ;
typedef int32_t prog_int32_t __attribute((__progmem__)) ;
typedef uint32_t prog_uint32_t __attribute((__progmem__)) ;
typedef int64_t prog_int64_t __attribute((__progmem__)) ;
typedef uint64_t prog_uint64_t __attribute((__progmem__)) ;
# 128 "C:\\Crossbow\\cygwin\\usr\\local\\avr\\include\\avr\\eeprom.h"
#line 127
static __inline uint8_t __attribute((always_inline)) 
eeprom_read_byte(const uint8_t *addr);










#line 138
static __inline void __attribute((always_inline)) 
eeprom_write_byte(uint8_t *addr, uint8_t value);
# 189 "C:\\Crossbow\\cygwin\\usr\\local\\avr\\include\\avr\\eeprom.h" 3
#line 188
uint8_t 
eeprom_read_byte(const uint8_t *addr);
#line 284
#line 283
void 
eeprom_write_byte(uint8_t *addr, uint8_t value);
# 117 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\avrhardware.h"
enum __nesc_unnamed4247 {
  TOSH_period16 = 0x00, 
  TOSH_period32 = 0x01, 
  TOSH_period64 = 0x02, 
  TOSH_period128 = 0x03, 
  TOSH_period256 = 0x04, 
  TOSH_period512 = 0x05, 
  TOSH_period1024 = 0x06, 
  TOSH_period2048 = 0x07
};

static inline void TOSH_wait(void);







typedef uint8_t __nesc_atomic_t;

__nesc_atomic_t __nesc_atomic_start(void );
void __nesc_atomic_end(__nesc_atomic_t oldSreg);



__inline __nesc_atomic_t __nesc_atomic_start(void )  ;






__inline void __nesc_atomic_end(__nesc_atomic_t oldSreg)  ;




static __inline void __nesc_atomic_sleep(void);









static __inline void __nesc_enable_interrupt(void);
# 83 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420Const.h"
uint8_t TOS_CC2420_TXPOWER = 0x1F;
uint8_t TOS_CC2420_CHANNEL = 11;
#line 267
enum __nesc_unnamed4248 {
  CP_MAIN = 0, 
  CP_MDMCTRL0, 
  CP_MDMCTRL1, 
  CP_RSSI, 
  CP_SYNCWORD, 
  CP_TXCTRL, 
  CP_RXCTRL0, 
  CP_RXCTRL1, 
  CP_FSCTRL, 
  CP_SECCTRL0, 
  CP_SECCTRL1, 
  CP_BATTMON, 
  CP_IOCFG0, 
  CP_IOCFG1
};
#line 298
static void __inline TOSH_uwait2(int u_sec);
# 102 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static void __inline TOSH_uwait(int u_sec);
#line 117
static __inline void TOSH_SET_RED_LED_PIN(void);
#line 117
static __inline void TOSH_CLR_RED_LED_PIN(void);
#line 117
static __inline void TOSH_MAKE_RED_LED_OUTPUT(void);
static __inline void TOSH_SET_GREEN_LED_PIN(void);
#line 118
static __inline void TOSH_CLR_GREEN_LED_PIN(void);
#line 118
static __inline void TOSH_MAKE_GREEN_LED_OUTPUT(void);
static __inline void TOSH_SET_YELLOW_LED_PIN(void);
#line 119
static __inline void TOSH_CLR_YELLOW_LED_PIN(void);
#line 119
static __inline void TOSH_MAKE_YELLOW_LED_OUTPUT(void);

static __inline void TOSH_SET_SERIAL_ID_PIN(void);
#line 121
static __inline void TOSH_CLR_SERIAL_ID_PIN(void);
#line 121
static __inline int TOSH_READ_SERIAL_ID_PIN(void);
#line 121
static __inline void TOSH_MAKE_SERIAL_ID_OUTPUT(void);
#line 121
static __inline void TOSH_MAKE_SERIAL_ID_INPUT(void);
#line 142
static __inline void TOSH_SET_CC_RSTN_PIN(void);
#line 142
static __inline void TOSH_CLR_CC_RSTN_PIN(void);
#line 142
static __inline void TOSH_MAKE_CC_RSTN_OUTPUT(void);
static __inline void TOSH_SET_CC_VREN_PIN(void);
#line 143
static __inline void TOSH_MAKE_CC_VREN_OUTPUT(void);


static __inline void TOSH_MAKE_CC_FIFOP1_INPUT(void);

static __inline void TOSH_MAKE_CC_CCA_INPUT(void);
static __inline int TOSH_READ_CC_SFD_PIN(void);
#line 149
static __inline void TOSH_MAKE_CC_SFD_INPUT(void);
static __inline void TOSH_SET_CC_CS_PIN(void);
#line 150
static __inline void TOSH_CLR_CC_CS_PIN(void);
#line 150
static __inline void TOSH_MAKE_CC_CS_OUTPUT(void);
#line 150
static __inline void TOSH_MAKE_CC_CS_INPUT(void);
static __inline int TOSH_READ_CC_FIFO_PIN(void);
#line 151
static __inline void TOSH_MAKE_CC_FIFO_INPUT(void);

static __inline int TOSH_READ_RADIO_CCA_PIN(void);
#line 153
static __inline void TOSH_MAKE_RADIO_CCA_INPUT(void);


static __inline void TOSH_SET_FLASH_SELECT_PIN(void);
#line 156
static __inline void TOSH_MAKE_FLASH_SELECT_OUTPUT(void);
static __inline void TOSH_MAKE_FLASH_CLK_OUTPUT(void);
static __inline void TOSH_MAKE_FLASH_OUT_OUTPUT(void);









static __inline void TOSH_MAKE_MOSI_OUTPUT(void);
static __inline void TOSH_MAKE_MISO_INPUT(void);

static __inline void TOSH_MAKE_SPI_SCK_OUTPUT(void);


static __inline void TOSH_MAKE_PW0_OUTPUT(void);
static __inline void TOSH_SET_PW1_PIN(void);
#line 175
static __inline void TOSH_CLR_PW1_PIN(void);
#line 175
static __inline void TOSH_MAKE_PW1_OUTPUT(void);
static __inline void TOSH_SET_PW2_PIN(void);
#line 176
static __inline void TOSH_CLR_PW2_PIN(void);
#line 176
static __inline void TOSH_MAKE_PW2_OUTPUT(void);
static __inline void TOSH_SET_PW3_PIN(void);
#line 177
static __inline void TOSH_CLR_PW3_PIN(void);
#line 177
static __inline void TOSH_MAKE_PW3_OUTPUT(void);
static __inline void TOSH_SET_PW4_PIN(void);
#line 178
static __inline void TOSH_CLR_PW4_PIN(void);
#line 178
static __inline void TOSH_MAKE_PW4_OUTPUT(void);
static __inline void TOSH_SET_PW5_PIN(void);
#line 179
static __inline void TOSH_CLR_PW5_PIN(void);
#line 179
static __inline void TOSH_MAKE_PW5_OUTPUT(void);
static __inline void TOSH_SET_PW6_PIN(void);
#line 180
static __inline void TOSH_MAKE_PW6_OUTPUT(void);
static __inline void TOSH_MAKE_PW7_OUTPUT(void);


static __inline void TOSH_SET_I2C_BUS1_SCL_PIN(void);
#line 184
static __inline void TOSH_CLR_I2C_BUS1_SCL_PIN(void);
#line 184
static __inline void TOSH_MAKE_I2C_BUS1_SCL_OUTPUT(void);
static __inline void TOSH_SET_I2C_BUS1_SDA_PIN(void);
#line 185
static __inline void TOSH_CLR_I2C_BUS1_SDA_PIN(void);
#line 185
static __inline int TOSH_READ_I2C_BUS1_SDA_PIN(void);
#line 185
static __inline void TOSH_MAKE_I2C_BUS1_SDA_OUTPUT(void);
#line 185
static __inline void TOSH_MAKE_I2C_BUS1_SDA_INPUT(void);
#line 212
static inline void TOSH_SET_PIN_DIRECTIONS(void );
#line 265
enum __nesc_unnamed4249 {
  TOSH_ADC_PORTMAPSIZE = 12
};

enum __nesc_unnamed4250 {


  TOSH_ACTUAL_VOLTAGE_PORT = 30, 
  TOSH_ACTUAL_BANDGAP_PORT = 30, 
  TOSH_ACTUAL_GND_PORT = 31
};

enum __nesc_unnamed4251 {


  TOS_ADC_VOLTAGE_PORT = 7, 
  TOS_ADC_BANDGAP_PORT = 10, 
  TOS_ADC_GND_PORT = 11
};




uint32_t TOS_UART0_BAUDRATE = 57600u;
# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\types\\dbg_modes.h"
typedef long long TOS_dbg_mode;



enum __nesc_unnamed4252 {
  DBG_ALL = ~0ULL, 


  DBG_BOOT = 1ULL << 0, 
  DBG_CLOCK = 1ULL << 1, 
  DBG_TASK = 1ULL << 2, 
  DBG_SCHED = 1ULL << 3, 
  DBG_SENSOR = 1ULL << 4, 
  DBG_LED = 1ULL << 5, 
  DBG_CRYPTO = 1ULL << 6, 


  DBG_ROUTE = 1ULL << 7, 
  DBG_AM = 1ULL << 8, 
  DBG_CRC = 1ULL << 9, 
  DBG_PACKET = 1ULL << 10, 
  DBG_ENCODE = 1ULL << 11, 
  DBG_RADIO = 1ULL << 12, 


  DBG_LOG = 1ULL << 13, 
  DBG_ADC = 1ULL << 14, 
  DBG_I2C = 1ULL << 15, 
  DBG_UART = 1ULL << 16, 
  DBG_PROG = 1ULL << 17, 
  DBG_SOUNDER = 1ULL << 18, 
  DBG_TIME = 1ULL << 19, 
  DBG_POWER = 1ULL << 20, 



  DBG_SIM = 1ULL << 21, 
  DBG_QUEUE = 1ULL << 22, 
  DBG_SIMRADIO = 1ULL << 23, 
  DBG_HARD = 1ULL << 24, 
  DBG_MEM = 1ULL << 25, 



  DBG_USR1 = 1ULL << 27, 
  DBG_USR2 = 1ULL << 28, 
  DBG_USR3 = 1ULL << 29, 
  DBG_TEMP = 1ULL << 30, 

  DBG_ERROR = 1ULL << 31, 
  DBG_NONE = 0, 

  DBG_DEFAULT = DBG_ALL
};
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\sched.c"
#line 39
typedef struct __nesc_unnamed4253 {
  void (*tp)(void);
} TOSH_sched_entry_T;

enum __nesc_unnamed4254 {






  TOSH_MAX_TASKS = 32, 

  TOSH_TASK_BITMASK = TOSH_MAX_TASKS - 1
};

volatile TOSH_sched_entry_T TOSH_queue[TOSH_MAX_TASKS];
uint8_t TOSH_sched_full;
volatile uint8_t TOSH_sched_free;

static inline void TOSH_sched_init(void );








bool TOS_post(void (*tp)(void));
#line 82
bool TOS_post(void (*tp)(void))  ;
#line 116
static inline bool TOSH_run_next_task(void);
#line 139
static inline void TOSH_run_task(void);
# 187 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\tos.h"
static void *nmemcpy(void *to, const void *from, size_t n);









static inline void *nmemset(void *to, int val, size_t n);
# 14 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\Ident.h"
enum __nesc_unnamed4255 {

  IDENT_MAX_PROGRAM_NAME_LENGTH = 17
};






#line 19
typedef struct __nesc_unnamed4256 {

  uint32_t unix_time;
  uint32_t user_hash;
  char program_name[IDENT_MAX_PROGRAM_NAME_LENGTH];
} Ident_t;
# 34 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\apps\\xmesh\\XMDA300\\sensorboardApp.h"
#line 29
typedef struct XMeshHeader {
  uint8_t board_id;
  uint8_t packet_id;

  uint16_t parent;
} __attribute((packed))  XMeshHeader;









#line 36
typedef struct PData1 {
  uint16_t analogCh0;
  uint16_t analogCh1;
  uint16_t analogCh2;
  uint16_t analogCh3;
  uint16_t analogCh4;
  uint16_t analogCh5;
  uint16_t analogCh6;
} __attribute((packed))  PData1;









#line 46
typedef struct PData2 {
  uint16_t analogCh7;
  uint16_t analogCh8;
  uint16_t analogCh9;
  uint16_t analogCh10;
  uint16_t analogCh11;
  uint16_t analogCh12;
  uint16_t analogCh13;
} __attribute((packed))  PData2;








#line 56
typedef struct PData3 {
  uint16_t digitalCh0;
  uint16_t digitalCh1;
  uint16_t digitalCh2;
  uint16_t digitalCh3;
  uint16_t digitalCh4;
  uint16_t digitalCh5;
} __attribute((packed))  PData3;






#line 65
typedef struct PData4 {
  uint16_t batt;
  uint16_t hum;
  uint16_t temp;
  uint16_t counter;
} __attribute((packed))  PData4;









#line 72
typedef struct PData5 {
  uint16_t seq_no;
  uint16_t adc0;
  uint16_t adc1;
  uint16_t adc2;
  uint16_t vref;
  uint16_t humid;
  uint16_t humtemp;
} __attribute((packed))  PData5;
#line 93
#line 83
typedef struct PData6 {
  uint16_t vref;
  uint16_t humid;
  uint16_t humtemp;
  uint16_t adc0;
  uint16_t adc1;
  uint16_t adc2;
  uint16_t dig0;
  uint16_t dig1;
  uint16_t dig2;
} __attribute((packed))  PData6;






#line 95
typedef struct XDataMsg {
  XMeshHeader xmeshHeader;
  union __nesc_unnamed4257 {
    PData6 datap6;
  } xData;
} __attribute((packed))  XDataMsg;



enum __nesc_unnamed4258 {
  AM_XSXMSG = 0
};

enum __nesc_unnamed4259 {
  Sample_Packet = 6
};

enum __nesc_unnamed4260 {
  RADIO_TEST, 
  UART_TEST
};
enum __nesc_unnamed4261 {
  AM_XDEBUG_MSG = 49, 
  AM_XSENSOR_MSG = 50, 
  AM_XMULTIHOP_MSG = 51
};






uint32_t XSENSOR_SAMPLE_RATE = 1843;



uint32_t timer_rate;
# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\AM.h"
enum __nesc_unnamed4262 {
  TOS_BCAST_ADDR = 0xffff, 
  TOS_UART_ADDR = 0x007e
};
#line 70
enum __nesc_unnamed4263 {
  TOS_DEFAULT_AM_GROUP = 0x7d
};


uint8_t TOS_AM_GROUP = TOS_DEFAULT_AM_GROUP;
#line 124
#line 100
typedef struct TOS_Msg {


  uint8_t length;
  uint8_t fcfhi;
  uint8_t fcflo;
  uint8_t dsn;
  uint16_t destpan;
  uint16_t addr;
  uint8_t type;
  uint8_t group;
  int8_t data[55];







  uint8_t strength;
  uint8_t lqi;
  bool crc;
  uint8_t ack;
  uint16_t time;
} TOS_Msg;




#line 126
typedef struct TinySec_Msg {

  uint8_t invalid;
} TinySec_Msg;
enum __nesc_unnamed4264 {

  MSG_HEADER_SIZE = (size_t )& ((struct TOS_Msg *)0)->data - 1, 

  MSG_FOOTER_SIZE = 2, 

  MSG_DATA_SIZE = (size_t )& ((struct TOS_Msg *)0)->strength + sizeof(uint16_t ), 

  DATA_LENGTH = 55, 

  LENGTH_BYTE_NUMBER = (size_t )& ((struct TOS_Msg *)0)->length + 1, 

  TOS_HEADER_SIZE = 5
};

typedef TOS_Msg *TOS_MsgPtr;
# 18 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.h"
enum __nesc_unnamed4265 {
  TIMER_REPEAT = 0, 
  TIMER_ONE_SHOT = 1, 
  NUM_TIMERS = 12U + 0U + 0U
};
# 40 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\byteorder.h"
static __inline int is_host_lsb(void);





static __inline uint16_t toLSB16(uint16_t a);




static __inline uint16_t fromLSB16(uint16_t a);
# 12 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\Clock.h"
enum __nesc_unnamed4266 {
  TOS_I1000PS = 32, TOS_S1000PS = 1, 
  TOS_I100PS = 40, TOS_S100PS = 2, 
  TOS_I10PS = 101, TOS_S10PS = 3, 
  TOS_I1024PS = 0, TOS_S1024PS = 3, 
  TOS_I512PS = 1, TOS_S512PS = 3, 
  TOS_I256PS = 3, TOS_S256PS = 3, 
  TOS_I128PS = 7, TOS_S128PS = 3, 
  TOS_I64PS = 15, TOS_S64PS = 3, 
  TOS_I32PS = 31, TOS_S32PS = 3, 
  TOS_I16PS = 63, TOS_S16PS = 3, 
  TOS_I8PS = 127, TOS_S8PS = 3, 
  TOS_I4PS = 255, TOS_S4PS = 3, 
  TOS_I2PS = 15, TOS_S2PS = 7, 
  TOS_I1PS = 31, TOS_S1PS = 7, 
  TOS_I0PS = 0, TOS_S0PS = 0
};
enum __nesc_unnamed4267 {
  DEFAULT_SCALE = 3, DEFAULT_INTERVAL = 127
};
# 11 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\crc.h"
uint16_t crcTable[256] __attribute((__progmem__))  = { 
0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7, 
0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef, 
0x1231, 0x0210, 0x3273, 0x2252, 0x52b5, 0x4294, 0x72f7, 0x62d6, 
0x9339, 0x8318, 0xb37b, 0xa35a, 0xd3bd, 0xc39c, 0xf3ff, 0xe3de, 
0x2462, 0x3443, 0x0420, 0x1401, 0x64e6, 0x74c7, 0x44a4, 0x5485, 
0xa56a, 0xb54b, 0x8528, 0x9509, 0xe5ee, 0xf5cf, 0xc5ac, 0xd58d, 
0x3653, 0x2672, 0x1611, 0x0630, 0x76d7, 0x66f6, 0x5695, 0x46b4, 
0xb75b, 0xa77a, 0x9719, 0x8738, 0xf7df, 0xe7fe, 0xd79d, 0xc7bc, 
0x48c4, 0x58e5, 0x6886, 0x78a7, 0x0840, 0x1861, 0x2802, 0x3823, 
0xc9cc, 0xd9ed, 0xe98e, 0xf9af, 0x8948, 0x9969, 0xa90a, 0xb92b, 
0x5af5, 0x4ad4, 0x7ab7, 0x6a96, 0x1a71, 0x0a50, 0x3a33, 0x2a12, 
0xdbfd, 0xcbdc, 0xfbbf, 0xeb9e, 0x9b79, 0x8b58, 0xbb3b, 0xab1a, 
0x6ca6, 0x7c87, 0x4ce4, 0x5cc5, 0x2c22, 0x3c03, 0x0c60, 0x1c41, 
0xedae, 0xfd8f, 0xcdec, 0xddcd, 0xad2a, 0xbd0b, 0x8d68, 0x9d49, 
0x7e97, 0x6eb6, 0x5ed5, 0x4ef4, 0x3e13, 0x2e32, 0x1e51, 0x0e70, 
0xff9f, 0xefbe, 0xdfdd, 0xcffc, 0xbf1b, 0xaf3a, 0x9f59, 0x8f78, 
0x9188, 0x81a9, 0xb1ca, 0xa1eb, 0xd10c, 0xc12d, 0xf14e, 0xe16f, 
0x1080, 0x00a1, 0x30c2, 0x20e3, 0x5004, 0x4025, 0x7046, 0x6067, 
0x83b9, 0x9398, 0xa3fb, 0xb3da, 0xc33d, 0xd31c, 0xe37f, 0xf35e, 
0x02b1, 0x1290, 0x22f3, 0x32d2, 0x4235, 0x5214, 0x6277, 0x7256, 
0xb5ea, 0xa5cb, 0x95a8, 0x8589, 0xf56e, 0xe54f, 0xd52c, 0xc50d, 
0x34e2, 0x24c3, 0x14a0, 0x0481, 0x7466, 0x6447, 0x5424, 0x4405, 
0xa7db, 0xb7fa, 0x8799, 0x97b8, 0xe75f, 0xf77e, 0xc71d, 0xd73c, 
0x26d3, 0x36f2, 0x0691, 0x16b0, 0x6657, 0x7676, 0x4615, 0x5634, 
0xd94c, 0xc96d, 0xf90e, 0xe92f, 0x99c8, 0x89e9, 0xb98a, 0xa9ab, 
0x5844, 0x4865, 0x7806, 0x6827, 0x18c0, 0x08e1, 0x3882, 0x28a3, 
0xcb7d, 0xdb5c, 0xeb3f, 0xfb1e, 0x8bf9, 0x9bd8, 0xabbb, 0xbb9a, 
0x4a75, 0x5a54, 0x6a37, 0x7a16, 0x0af1, 0x1ad0, 0x2ab3, 0x3a92, 
0xfd2e, 0xed0f, 0xdd6c, 0xcd4d, 0xbdaa, 0xad8b, 0x9de8, 0x8dc9, 
0x7c26, 0x6c07, 0x5c64, 0x4c45, 0x3ca2, 0x2c83, 0x1ce0, 0x0cc1, 
0xef1f, 0xff3e, 0xcf5d, 0xdf7c, 0xaf9b, 0xbfba, 0x8fd9, 0x9ff8, 
0x6e17, 0x7e36, 0x4e55, 0x5e74, 0x2e93, 0x3eb2, 0x0ed1, 0x1ef0 };





static inline uint16_t crcByte(uint16_t oldCrc, uint8_t byte);
# 19 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\types\\MultiHop.h"
#line 13
typedef struct MultihopMsg {
  uint16_t sourceaddr;
  uint16_t originaddr;
  int16_t seqno;
  uint8_t socket;
  uint8_t data[55 - 7];
} __attribute((packed))  TOS_MHopMsg;




#line 21
typedef struct ACKMsg {
  uint16_t source;
  uint8_t type;
} __attribute((packed))  ACK_Msg;









enum __nesc_unnamed4268 {
  NBRFLAG_VALID = 0x01, 
  NBRFLAG_NEW = 0x02, 
  NBRFLAG_EST_INIT = 0x04, 
  NBRFLAG_EST_SLEEP = 0x08, 
  NBRFLAG_EST_HOLD = 0x10
};




enum __nesc_unnamed4269 {
  MODE_UPSTREAM, 
  MODE_UPSTREAM_ACK, 
  MODE_DOWNSTREAM, 
  MODE_DOWNSTREAM_ACK, 
  MODE_ANY2ANY, 
  MODE_ONE_HOP_BROADCAST
};




enum __nesc_unnamed4270 {
  RS_RESENT = 0x01, 
  RS_FORCE_MONITOR = 0x02, 
  RS_UPDATE_DSCTBL = 0x04, 
  RS_SEARCH_DSCTBL = 0x08
};
#line 79
enum __nesc_unnamed4271 {
  BASE_STATION_ADDRESS = 0, 



  ROUTE_TABLE_SIZE = 15, 

  ESTIMATE_TO_ROUTE_RATIO = 5, 
  ACCEPTABLE_MISSED = -20, 




  DESCENDANT_TABLE_SIZE = 50, 


  SWITCH_THRESHOLD = 384, 
  MAX_ALLOWABLE_LINK_COST = 256 * 6, 
  LIVELINESS = 2, 
  MAX_DESCENDANT = 5, 
  MAX_RETRY = 8
};



uint8_t NBR_ADVERT_THRESHOLD = 100;








uint32_t TOS_ROUTE_UPDATE = 36000u;
#line 141
uint32_t TOS_HEALTH_UPDATE = 60;
#line 155
enum __nesc_unnamed4272 {
  ROUTE_INVALID = 0xff
};

enum __nesc_unnamed4273 {
  FWD_QUEUE_SIZE = 8
};

enum __nesc_unnamed4274 {
  UPSTREAM, 
  DOWNSTREAM
};

enum __nesc_unnamed4275 {
  HIGHPOWER, 
  LOWPOWER
};

enum __nesc_unnamed4276 {
  LitPathOff, 
  LitPathOn, 
  LitPathOtap
};




#line 179
typedef struct RPEstEntry {
  uint16_t id;
  uint8_t receiveEst;
} __attribute((packed))  RPEstEntry;






#line 184
typedef struct RoutePacket {
  uint16_t parent;
  uint16_t cost;
  uint8_t estEntries;
  RPEstEntry estList[0];
} __attribute((packed))  RoutePacket;
#line 220
#line 207
typedef struct TableEntry {
  uint16_t id;
  uint16_t parent;
  uint16_t cost;
  uint8_t childLiveliness;
  uint16_t missed;
  uint16_t received;
  int16_t lastSeqno;
  uint8_t flags;
  uint8_t liveliness;
  uint8_t hop;
  uint8_t receiveEst;
  uint8_t sendEst;
} __attribute((packed))  TableEntry;




#line 222
typedef struct __nesc_unnamed4277 {
  uint16_t origin;
  uint16_t from;
} __attribute((packed))  DescendantTbl;




#line 227
typedef struct __nesc_unnamed4278 {
  uint8_t cmd_type;
  uint16_t duration;
} __attribute((packed))  LitPathCmd;
# 34 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\types\\Messages.h"
enum __nesc_unnamed4279 {
  AM_HEALTH = 3, 
  AM_DEBUGPACKET = 3, 
  AM_DATA2BASE = 11, 
  AM_DATA2NODE = 12, 
  AM_DATAACK2BASE = 13, 
  AM_DATAACK2NODE = 14, 
  AM_ANY2ANY = 15, 

  AM_TIMESYNC = 239, 
  AM_PREAMBLE = 240, 
  AM_DOWNSTREAM_ACK = 246, 
  AM_UPSTREAM_ACK = 247, 
  AM_PATH_LIGHT_DOWN = 248, 
  AM_PATH_LIGHT_UP = 249, 
  AM_MULTIHOPMSG = 250, 
  AM_ONE_HOP = 251, 
  AM_HEARTBEAT = 253, 

  AM_MGMT = 90, 
  AM_BULKXFER = 91, 
  AM_MGMTRESP = 92
};
# 23 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\types\\Health.h"
#line 18
typedef struct _health_node_quality {
  uint16_t node_id;
  uint8_t link_quality;
  uint8_t path_cost;
  uint8_t radio_link_indicator;
} __attribute((packed))  hn_quality;
#line 57
#line 48
typedef struct _health_hdr_ {





  uint8_t type_nodes;
  uint8_t version_num;
  uint8_t type;
} __attribute((packed))  HealthHdr;
#line 80
#line 63
typedef struct _health_msg_ {

  HealthHdr health_hdr;

  uint16_t seq_num;
  uint16_t num_node_pkts;
  uint16_t num_fwd_pkts;
  uint16_t num_drop_pkts;
  uint16_t num_rexmits;


  uint8_t battery_voltage;
  uint16_t power_sum;
  uint8_t rsvd_app_type;


  hn_quality nodeinfo[2];
} __attribute((packed))  HealthMsg;







#line 85
typedef struct _health_neighbor_ {
  HealthHdr health_hdr;
  hn_quality nodeinfo[3];
} __attribute((packed))  HealthNeighbor;
# 13 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.h"
enum __nesc_unnamed4280 {
  TOS_ADCSample3750ns = 0, 
  TOS_ADCSample7500ns = 1, 
  TOS_ADCSample15us = 2, 
  TOS_ADCSample30us = 3, 
  TOS_ADCSample60us = 4, 
  TOS_ADCSample120us = 5, 
  TOS_ADCSample240us = 6, 
  TOS_ADCSample480us = 7
};
# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XCommand.h"
enum __nesc_unnamed4281 {

  XCOMMAND_RESET = 0x10, 
  XCOMMAND_SLEEP, 
  XCOMMAND_WAKEUP, 


  XCOMMAND_SET_RATE = 0x20, 


  XCOMMAND_GET_CONFIG = 0x30, 
  XCOMMAND_SET_NODEID, 
  XCOMMAND_SET_GROUP, 
  XCOMMAND_SET_RF_POWER, 
  XCOMMAND_SET_RF_CHANNEL, 
  XCOMMAND_CONFIG_UID, 


  XCOMMAND_ACTUATE = 0x40, 


  XCOMMAND_CUSTOM_ACTION = 0x60
};

enum __nesc_unnamed4282 {
  XCMD_DEVICE_LED_GREEN, 
  XCMD_DEVICE_LED_YELLOW, 
  XCMD_DEVICE_LED_RED, 
  XCMD_DEVICE_LEDS, 
  XCMD_DEVICE_SOUNDER, 
  XCMD_DEVICE_RELAY1, 
  XCMD_DEVICE_RELAY2, 
  XCMD_DEVICE_RELAY3
};


enum __nesc_unnamed4283 {
  XCMD_STATE_OFF = 0, 
  XCMD_STATE_ON = 1, 
  XCMD_STATE_TOGGLE
};

enum __nesc_unnamed4284 {
  XCMD_RES_FAIL = 0, 
  XCMD_RES_SUCCESS = 1
};
#line 108
#line 81
typedef struct XCommandOp {
  uint16_t cmd;
  uint8_t cmdkey;
  union __nesc_unnamed4285 {
    uint32_t newrate;
    uint16_t nodeid;
    uint8_t group;
    uint8_t rf_power;
    uint8_t rf_channel;


    struct __nesc_unnamed4286 {
      uint16_t device;
      uint16_t state;
    } actuate;

    struct __nesc_unnamed4287 {
      uint16_t type;
      uint16_t value;
    } custom_data;


    struct __nesc_unnamed4288 {
      uint8_t serialid[8];
      uint16_t nodeid;
    } uidconfig;
  } param;
} __attribute((packed))  XCommandOp;





#line 111
typedef struct XCommandMsg {
  uint16_t dest;
  XCommandOp inst;
} __attribute((packed))  XCommandMsg;



#line 116
typedef struct XMeshMsg {
  XCommandOp inst;
} __attribute((packed))  XMeshMsg;







#line 120
typedef struct XCmdDataHeader {
  uint8_t board_id;
  uint8_t packet_id;
  uint16_t node_id;
  uint8_t responseCode;
  uint8_t cmdkey;
} __attribute((packed))  XCmdDataHeader;







#line 128
typedef struct ConfigData {
  uint8_t uid[8];
  uint16_t nodeid;
  uint8_t group;
  uint8_t rf_power;
  uint8_t rf_channel;
} __attribute((packed))  ConfigData;






#line 136
typedef struct UidConfigData {
  uint16_t oldNodeid;
  uint16_t nodeid;
  uint8_t serialid[8];
  uint8_t isSuccess;
} UidConfigData;
#line 158
#line 144
typedef struct XCmdDataMsg {
  XCmdDataHeader xHeader;
  union __nesc_unnamed4289 {
    uint32_t newrate;
    ConfigData configdata1;
    UidConfigData uidData1;
    uint16_t nodeid;
    uint8_t groupid;
    uint8_t rf_channel;
    struct RFData {
      uint8_t rf_power;
      uint8_t rf_channel;
    } rfParams;
  } xData;
} __attribute((packed))  XCmdDataMsg;
#line 174
enum __nesc_unnamed4290 {
  AM_XCOMMAND_MSG = 48
};
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\sensorboard.h"
enum __nesc_unnamed4291 {
  SAMPLER_DEFAULT = 0x00, 
  AVERAGE_FOUR = 0x01, 
  AVERAGE_EIGHT = 0x02, 
  AVERAGE_SIXTEEN = 0x04, 
  EXCITATION_25 = 0x08, 
  EXCITATION_33 = 0x10, 
  EXCITATION_50 = 0x20, 
  EXCITATION_ALWAYS_ON = 0x40, 
  DELAY_BEFORE_MEASUREMENT = 0x80
};


enum __nesc_unnamed4292 {

  RISING_EDGE = 0x01, 
  FALLING_EDGE = 0x02, 
  EVENT = 0x04, 
  EEPROM_TOTALIZER = 0x08, 


  RESET_ZERO_AFTER_READ = 0x30, 
  DIG_OUTPUT = 0x40, 
  DIG_LOGIC = 0x80
};

enum __nesc_unnamed4293 {
  InputChannel = 0, 
  OutputChannel = 1
};

enum __nesc_unnamed4294 {
  RisingEdge = 0, 
  FallingEdge = 1, 
  Edge = 2
};


enum __nesc_unnamed4295 {
  NO_EXCITATION = 0, 
  ADCREF = 1, 
  THREE_VOLT = 2, 
  FIVE_VOLT = 3, 
  ALL_EXCITATION = 4, 
  NO_ADCREF = 5, 
  NO_THREE_VOLT = 6, 
  NO_FIVE_VOLT = 7
};

enum __nesc_unnamed4296 {
  POWER_SAVING_MODE = 0, 
  NO_POWER_SAVING_MODE = 1
};

enum __nesc_unnamed4297 {
  FAST_COVERSION_MODE = 0, 
  SLOW_COVERSION_MODE = 1
};








enum __nesc_unnamed4298 {
  ATTENTION_PACKET = 9
};

enum __nesc_unnamed4299 {
  ANALOG = 0, 
  BATTERY = 1, 
  TEMPERATURE = 2, 
  HUMIDITY = 3, 
  DIGITAL = 4, 
  COUNTER = 5
};

enum __nesc_unnamed4300 {
  PENDING, 
  NOT_PENDING
};

enum __nesc_unnamed4301 {
  MUX_CHANNEL_SEVEN = 0xC0, 
  MUX_CHANNEL_EIGHT = 0x30, 
  MUX_CHANNEL_NINE = 0x0C, 
  MUX_CHANNEL_TEN = 0x03
};

enum __nesc_unnamed4302 {
  LOCK, 
  UNLOCK
};

enum __nesc_unnamed4303 {
  SAMPLE_RECORD_FREE = -1, 
  SAMPLE_ONCE = -2
};

enum __nesc_unnamed4304 {
  NORMALY_OPEN = 6, 
  NORMALY_CLOSED = 7, 
  SET_HIGH, 
  SET_LOW, 
  SET_TOGGLE, 
  SET_CLOSE, 
  SET_OPEN
};
# 57 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\config.h"
typedef uint32_t AppParamID_t;


typedef uint8_t ParameterID_t;


typedef uint16_t ParamCRC_t;
#line 93
enum ApplicationID {

  TOS_INVALID_APPLICATION = 0, 
  TOS_SYSTEM = 1, 
  TOS_CROSSBOW = 2, 
  TOS_RADIO = 3, 

  TOS_XMESHAPP = 5, 



  TOS_TEST_APPLICATION = 0xfffffeL, 


  TOS_NO_APPLICATION = 0xffffffL
};
#line 126
#line 111
typedef struct __nesc_unnamed4305 {
  ParamCRC_t crc;

  uint8_t majorVersion;
  uint8_t minorVersion;
  uint16_t buildNumber;
  uint8_t bytes;
} 







__attribute((packed))  FlashVersionHeader_t;

enum __nesc_unnamed4306 {
  ParameterIgnoreVersion = 0xff
};
#line 150
#line 148
typedef struct __nesc_unnamed4307 {
  uint8_t data[16 - sizeof(FlashVersionHeader_t )];
} __attribute((packed))  FlashVersionData_t;










#line 158
typedef struct __nesc_unnamed4308 {
  FlashVersionHeader_t vHdr;
  FlashVersionData_t d;
} __attribute((packed))  FlashVersionBlock_t;





enum ParameterID {
  TOS_UNUSED_PARAMETER = 0, 
  TOS_IGNORE_PARAMETER = 0xfe, 

  TOS_NO_PARAMETER = 0xff
};
#line 201
#line 196
typedef struct __nesc_unnamed4309 {
  ParamCRC_t crc;
  uint32_t applicationID : 24;
  uint32_t paramID : 8;
  uint8_t count;
} __attribute((packed))  ParameterHeader_t;





#line 204
typedef struct __nesc_unnamed4310 {
  ParameterHeader_t paHdr;
  uint8_t data[16];
} __attribute((packed))  ParameterBlock_t;




enum systemParamID {
  TOS_MOTE_ID = 1, 
  TOS_MOTE_GROUP = 2, 
  TOS_MOTE_MODEL = 3, 
  TOS_MOTE_SUBMODEL = 4, 
  TOS_MOTE_CPU_TYPE = 5, 
  TOS_MOTE_RADIO_TYPE = 6, 
  TOS_MOTE_VENDOR = 7, 
  TOS_MOTE_SERIAL = 8, 


  TOS_MOTE_CPU_OSCILLATOR_HZ = 9
};



enum modelID {
  TOS_MODEL_UNKNOWN = 1, 
  TOS_MODEL_MICA1 = 2, 
  TOS_MODEL_MICA2 = 3, 
  TOS_MODEL_MICA2DOT = 4, 
  TOS_MODEL_H900 = 5
};


enum subModelID {
  TOS_SUBMODEL_UNKNOWN = 1, 
  TOS_SUBMODEL_DEFAULT = 2
};


enum cpuTypeID {
  TOS_CPU_TYPE_UNKNOWN = 1, 
  TOS_CPU_TYPE_ATMEGA128 = 2
};


enum radioTypeID {
  TOS_RADIO_TYPE_UNKNOWN = 1, 
  TOS_RADIO_TYPE_CC1000 = 2, 
  TOS_RADIO_TYPE_H900 = 3, 
  TOS_RADIO_TYPE_CC2420 = 4
};


enum vendorID {
  TOS_VENDOR_UNKNOWN = 1, 
  TOS_VENDOR_CROSSBOW = 2, 
  TOS_VENDOR_SENSICAST = 3
};




enum RadioParamID {
  TOS_RADIO_TUNE_HZ = 1, 
  TOS_RADIO_LOWER_HZ = 2, 
  TOS_RADIO_UPPER_HZ = 3, 
  TOS_RADIO_RF_POWER = 4, 
  TOS_RADIO_RF_CHANNEL = 5
};





enum crossbowID {
  TOS_FACTORY_INFO1 = 1, 
  TOS_FACTORY_INFO2 = 2, 
  TOS_FACTORY_INFO3 = 3, 
  TOS_FACTORY_INFO4 = 4
};




enum xmeshappParamID {
  TOS_XMESH_TIMER_RATE = 1
};







enum __nesc_unnamed4311 {
  CONFIG_NO_APPLICATION = (AppParamID_t )(((uint32_t )TOS_NO_APPLICATION << 8) | (ParameterID_t )TOS_NO_PARAMETER), 
  CONFIG_MOTE_ID = (AppParamID_t )(((uint32_t )TOS_SYSTEM << 8) | (ParameterID_t )TOS_MOTE_ID), 
  CONFIG_MOTE_GROUP = (AppParamID_t )(((uint32_t )TOS_SYSTEM << 8) | (ParameterID_t )TOS_MOTE_GROUP), 
  CONFIG_MOTE_MODEL = (AppParamID_t )(((uint32_t )TOS_SYSTEM << 8) | (ParameterID_t )TOS_MOTE_MODEL), 
  CONFIG_MOTE_SUBMODEL = (AppParamID_t )(((uint32_t )TOS_SYSTEM << 8) | (ParameterID_t )TOS_MOTE_SUBMODEL), 
  CONFIG_MOTE_CPU_TYPE = (AppParamID_t )(((uint32_t )TOS_SYSTEM << 8) | (ParameterID_t )TOS_MOTE_CPU_TYPE), 
  CONFIG_MOTE_RADIO_TYPE = (AppParamID_t )(((uint32_t )TOS_SYSTEM << 8) | (ParameterID_t )TOS_MOTE_RADIO_TYPE), 
  CONFIG_MOTE_VENDOR = (AppParamID_t )(((uint32_t )TOS_SYSTEM << 8) | (ParameterID_t )TOS_MOTE_VENDOR), 
  CONFIG_MOTE_SERIAL = (AppParamID_t )(((uint32_t )TOS_SYSTEM << 8) | (ParameterID_t )TOS_MOTE_SERIAL), 
  CONFIG_MOTE_CPU_OSCILLATOR_HZ = (AppParamID_t )(((uint32_t )TOS_SYSTEM << 8) | (ParameterID_t )TOS_MOTE_CPU_OSCILLATOR_HZ), 
  CONFIG_FACTORY_INFO1 = (AppParamID_t )(((uint32_t )TOS_CROSSBOW << 8) | (ParameterID_t )TOS_FACTORY_INFO1), 
  CONFIG_FACTORY_INFO2 = (AppParamID_t )(((uint32_t )TOS_CROSSBOW << 8) | (ParameterID_t )TOS_FACTORY_INFO2), 
  CONFIG_FACTORY_INFO3 = (AppParamID_t )(((uint32_t )TOS_CROSSBOW << 8) | (ParameterID_t )TOS_FACTORY_INFO3), 
  CONFIG_FACTORY_INFO4 = (AppParamID_t )(((uint32_t )TOS_CROSSBOW << 8) | (ParameterID_t )TOS_FACTORY_INFO4), 
  CONFIG_RF_CHANNEL = (AppParamID_t )(((uint32_t )TOS_RADIO << 8) | (ParameterID_t )TOS_RADIO_RF_CHANNEL), 
  CONFIG_RF_POWER = (AppParamID_t )(((uint32_t )TOS_RADIO << 8) | (ParameterID_t )TOS_RADIO_RF_POWER), 
  CONFIG_XMESHAPP_TIMER_RATE = (AppParamID_t )(((uint32_t )TOS_XMESHAPP << 8) | (ParameterID_t )TOS_XMESH_TIMER_RATE)
};

enum RFCHANNEL {
  CC1K_MAX_RF_CHANNEL = 34
};
# 15 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica\\HardwareId.h"
enum __nesc_unnamed4312 {
  HARDWARE_ID_LEN = 8
};
# 30 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Broadcast\\Bcast.h"
#line 27
typedef struct _BcastMsg {
  int16_t seqno;
  uint8_t data[55 - 2];
} __attribute((packed))  TOS_BcastMsg;
# 57 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Pot.nc"
static  result_t PotM$Pot$init(uint8_t arg_0x1a5051b8);
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLPot.nc"
static  result_t HPLPotC$Pot$finalise(void);
#line 38
static  result_t HPLPotC$Pot$decrease(void);







static  result_t HPLPotC$Pot$increase(void);
# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\HPLInit.nc"
static  result_t HPLInit$init(void);
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
static  TOS_MsgPtr AMPromiscuous$ReceiveMsg$default$receive(
# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
uint8_t arg_0x1a592720, 
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
TOS_MsgPtr arg_0x1a581c80);
# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
static  result_t AMPromiscuous$ActivityTimer$fired(void);
# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BareSendMsg.nc"
static  result_t AMPromiscuous$UARTSend$sendDone(TOS_MsgPtr arg_0x1a5a1360, result_t arg_0x1a5a14f0);
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
static  TOS_MsgPtr AMPromiscuous$RadioReceive$receive(TOS_MsgPtr arg_0x1a581c80);
# 49 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\CommControl.nc"
static  bool AMPromiscuous$CommControl$getPromiscuous(void);
#line 29
static  result_t AMPromiscuous$CommControl$setCRCCheck(bool arg_0x1a550210);




static  bool AMPromiscuous$CommControl$getCRCCheck(void);









static  result_t AMPromiscuous$CommControl$setPromiscuous(bool arg_0x1a550e60);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t AMPromiscuous$Control$init(void);






static  result_t AMPromiscuous$Control$start(void);







static  result_t AMPromiscuous$Control$stop(void);
# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static  result_t AMPromiscuous$default$sendDone(void);
# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BareSendMsg.nc"
static  result_t AMPromiscuous$RadioSend$sendDone(TOS_MsgPtr arg_0x1a5a1360, result_t arg_0x1a5a14f0);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
static  result_t AMPromiscuous$SendMsg$send(
# 35 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
uint8_t arg_0x1a592088, 
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
uint16_t arg_0x1a583670, uint8_t arg_0x1a5837f8, TOS_MsgPtr arg_0x1a583988);
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
static  TOS_MsgPtr AMPromiscuous$UARTReceive$receive(TOS_MsgPtr arg_0x1a581c80);
# 40 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\TimerJiffyAsync.nc"
static   result_t CC2420RadioM$BackoffTimerJiffy$fired(void);
# 73 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static   TOS_MsgPtr CC2420RadioM$default$asyncReceive(TOS_MsgPtr arg_0x1a6d69c8);
# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BareSendMsg.nc"
static  result_t CC2420RadioM$Send$send(TOS_MsgPtr arg_0x1a5a3be8);
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\MacControl.nc"
static   void CC2420RadioM$MacControl$disableAck(void);







static   void CC2420RadioM$MacControl$disableAddrDecode(void);
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420.nc"
static   result_t CC2420RadioM$HPLChipcon$FIFOPIntr(void);
# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\RadioPower.nc"
static  result_t CC2420RadioM$RadioPower$SetListeningMode(uint8_t arg_0x1a642378);
static  result_t CC2420RadioM$RadioPower$SetTransmitMode(uint8_t arg_0x1a642810);
# 15 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\RadioCoordinator.nc"
static   void CC2420RadioM$RadioSendCoordinator$default$startSymbol(uint8_t arg_0x1a6a46c0, uint8_t arg_0x1a6a4848, TOS_MsgPtr arg_0x1a6a49d8);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t CC2420RadioM$StdControl$init(void);






static  result_t CC2420RadioM$StdControl$start(void);







static  result_t CC2420RadioM$StdControl$stop(void);
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\MacBackoff.nc"
static   int16_t CC2420RadioM$MacBackoff$default$initialBackoff(TOS_MsgPtr arg_0x1a6733e8);
static   int16_t CC2420RadioM$MacBackoff$default$congestionBackoff(TOS_MsgPtr arg_0x1a6738a8);
# 74 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static   void CC2420RadioM$default$shortReceived(void);
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420.nc"
static   result_t CC2420ControlM$HPLChipcon$FIFOPIntr(void);
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420RAM.nc"
static   result_t CC2420ControlM$HPLChipconRAM$writeDone(uint16_t arg_0x1a7c6cc8, uint8_t arg_0x1a7c6e50, uint8_t *arg_0x1a7c4010);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t CC2420ControlM$StdControl$init(void);






static  result_t CC2420ControlM$StdControl$start(void);







static  result_t CC2420ControlM$StdControl$stop(void);
# 148 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420Control.nc"
static   result_t CC2420ControlM$CC2420Control$disableAutoAck(void);
#line 127
static  result_t CC2420ControlM$CC2420Control$SetRFPower(uint8_t arg_0x1a664d48);
#line 52
static  result_t CC2420ControlM$CC2420Control$TunePreset(uint8_t arg_0x1a6516c8);
#line 112
static   result_t CC2420ControlM$CC2420Control$RxMode(void);
#line 168
static   result_t CC2420ControlM$CC2420Control$disableAddrDecode(void);
#line 155
static  result_t CC2420ControlM$CC2420Control$setShortAddress(uint16_t arg_0x1a6627b8);
#line 83
static   result_t CC2420ControlM$CC2420Control$OscillatorOn(void);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420.nc"
static   result_t HPLCC2420M$HPLCC2420$enableFIFOP(void);
#line 65
static   uint16_t HPLCC2420M$HPLCC2420$read(uint8_t arg_0x1a6c6500);
#line 58
static   uint8_t HPLCC2420M$HPLCC2420$write(uint8_t arg_0x1a6b1bb0, uint16_t arg_0x1a6b1d40);
#line 51
static   uint8_t HPLCC2420M$HPLCC2420$cmd(uint8_t arg_0x1a6b14f8);
#line 42
static   result_t HPLCC2420M$HPLCC2420$disableFIFOP(void);
# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420RAM.nc"
static   result_t HPLCC2420M$HPLCC2420RAM$write(uint16_t arg_0x1a7c6458, uint8_t arg_0x1a7c65e0, uint8_t *arg_0x1a7c6788);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t HPLCC2420M$StdControl$init(void);






static  result_t HPLCC2420M$StdControl$start(void);







static  result_t HPLCC2420M$StdControl$stop(void);
# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420FIFO.nc"
static   result_t HPLCC2420FIFOM$HPLCC2420FIFO$writeTXFIFO(uint8_t arg_0x1a6c3f00, uint8_t *arg_0x1a6c20d0);
#line 46
static   result_t HPLCC2420FIFOM$HPLCC2420FIFO$readRXFIFO(uint8_t arg_0x1a6c3518, uint8_t *arg_0x1a6c36c0);
# 42 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Random.nc"
static   uint16_t RandomLFSR$Random$rand(void);
#line 36
static   result_t RandomLFSR$Random$init(void);
# 159 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Clock.nc"
static   result_t TimerM$Clock$fire(void);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t TimerM$StdControl$init(void);






static  result_t TimerM$StdControl$start(void);
# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
static  result_t TimerM$Timer$default$fired(
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\TimerM.nc"
uint8_t arg_0x1a8b62b0);
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
static  result_t TimerM$Timer$start(
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\TimerM.nc"
uint8_t arg_0x1a8b62b0, 
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
char arg_0x1a5d5368, uint32_t arg_0x1a5d5500);








static  result_t TimerM$Timer$stop(
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\TimerM.nc"
uint8_t arg_0x1a8b62b0);
# 84 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Clock.nc"
static   void HPLClock$Clock$setInterval(uint8_t arg_0x1a8d22d0);
#line 132
static   uint8_t HPLClock$Clock$readCounter(void);
#line 75
static   result_t HPLClock$Clock$setRate(char arg_0x1a8d84d8, char arg_0x1a8d8658);
#line 100
static   uint8_t HPLClock$Clock$getInterval(void);
# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
static   result_t NoLeds$Leds$yellowOff(void);
#line 93
static   result_t NoLeds$Leds$yellowOn(void);
#line 35
static   result_t NoLeds$Leds$init(void);
#line 76
static   result_t NoLeds$Leds$greenOff(void);








static   result_t NoLeds$Leds$greenToggle(void);
#line 60
static   result_t NoLeds$Leds$redToggle(void);
#line 128
static   result_t NoLeds$Leds$set(uint8_t arg_0x1a5b5a40);
#line 68
static   result_t NoLeds$Leds$greenOn(void);
# 19 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\PowerManagement.nc"
static   uint8_t HPLPowerManagementM$PowerManagement$adjustPower(void);
# 32 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLPowerManagementM.nc"
static  result_t HPLPowerManagementM$Enable(void);
# 34 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\TimerJiffyAsync.nc"
static   result_t TimerJiffyAsyncM$TimerJiffyAsync$setOneShot(uint32_t arg_0x1a6d5460);



static   bool TimerJiffyAsyncM$TimerJiffyAsync$isSet(void);
#line 36
static   result_t TimerJiffyAsyncM$TimerJiffyAsync$stop(void);
# 159 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Clock.nc"
static   result_t TimerJiffyAsyncM$Timer$fire(void);
#line 127
static   result_t HPLTimer2$Timer2$setIntervalAndScale(uint8_t arg_0x1a8d01b8, uint8_t arg_0x1a8d0340);
#line 147
static   void HPLTimer2$Timer2$intDisable(void);
# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
static   result_t LedsC$Leds$yellowOff(void);
#line 93
static   result_t LedsC$Leds$yellowOn(void);
#line 76
static   result_t LedsC$Leds$greenOff(void);
#line 51
static   result_t LedsC$Leds$redOff(void);
#line 85
static   result_t LedsC$Leds$greenToggle(void);
#line 110
static   result_t LedsC$Leds$yellowToggle(void);
#line 60
static   result_t LedsC$Leds$redToggle(void);
#line 128
static   result_t LedsC$Leds$set(uint8_t arg_0x1a5b5a40);
#line 43
static   result_t LedsC$Leds$redOn(void);
#line 68
static   result_t LedsC$Leds$greenOn(void);
# 62 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ByteComm.nc"
static   result_t FramerM$ByteComm$txDone(void);
#line 54
static   result_t FramerM$ByteComm$txByteReady(bool arg_0x1aa08200);
#line 45
static   result_t FramerM$ByteComm$rxByteReady(uint8_t arg_0x1aa0a708, bool arg_0x1aa0a890, uint16_t arg_0x1aa0aa28);
# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BareSendMsg.nc"
static  result_t FramerM$BareSendMsg$send(TOS_MsgPtr arg_0x1a5a3be8);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t FramerM$StdControl$init(void);






static  result_t FramerM$StdControl$start(void);







static  result_t FramerM$StdControl$stop(void);
# 59 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\TokenReceiveMsg.nc"
static  result_t FramerM$TokenReceiveMsg$ReflectToken(uint8_t arg_0x1aa23a68);
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
static  TOS_MsgPtr FramerAckM$ReceiveMsg$receive(TOS_MsgPtr arg_0x1a581c80);
# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\TokenReceiveMsg.nc"
static  TOS_MsgPtr FramerAckM$TokenReceiveMsg$receive(TOS_MsgPtr arg_0x1aa23068, uint8_t arg_0x1aa231f0);
# 66 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLUART.nc"
static   result_t UARTM$HPLUART$get(uint8_t arg_0x1aaaad48);







static   result_t UARTM$HPLUART$putDone(void);
# 34 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ByteComm.nc"
static   result_t UARTM$ByteComm$txByte(uint8_t arg_0x1aa0a010);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t UARTM$Control$init(void);






static  result_t UARTM$Control$start(void);







static  result_t UARTM$Control$stop(void);
# 40 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLUART.nc"
static   result_t HPLUART0M$UART$init(void);
#line 58
static   result_t HPLUART0M$UART$put(uint8_t arg_0x1aaaa610);
#line 48
static   result_t HPLUART0M$UART$stop(void);
# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\HPLUART0M.nc"
static   result_t HPLUART0M$Setbaud(uint32_t arg_0x1aab7088);
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
 TOS_MsgPtr XMeshC$ReceiveDownstreamMsg$receive(
# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\XMeshC.nc"
uint8_t arg_0x1ab74c98, 
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
TOS_MsgPtr arg_0x1a581c80);
# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
 result_t XMeshC$ElpTimer$fired(void);
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
 TOS_MsgPtr XMeshC$ReceiveMsg$receive(
# 32 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\XMeshC.nc"
uint8_t arg_0x1ab746a8, 
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
TOS_MsgPtr arg_0x1a581c80);
#line 53
 TOS_MsgPtr XMeshC$ReceiveDownstreamMsgWithAck$receive(
# 35 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\XMeshC.nc"
uint8_t arg_0x1ab73930, 
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
TOS_MsgPtr arg_0x1a581c80);
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\XMeshC.nc"
 void XMeshC$health_packet(bool arg_0x1ab76010, uint16_t arg_0x1ab761a8);
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\XOtapLoader.nc"
 result_t XMeshC$XOtapLoader$boot(uint8_t arg_0x1ab640b0);
# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
 result_t XMeshC$EwmaTimer$fired(void);
# 23 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\XMeshC.nc"
 HealthMsg *XMeshC$HealthMsgGet(void);
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
 result_t XMeshC$MhopSend$send(
# 12 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\XMeshC.nc"
uint8_t arg_0x1ab7b010, 
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
uint16_t arg_0x1ab219b8, uint8_t arg_0x1ab21b40, TOS_MsgPtr arg_0x1ab21cd0, uint16_t arg_0x1ab21e60);
#line 88
 void *XMeshC$MhopSend$getBuffer(
# 12 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\XMeshC.nc"
uint8_t arg_0x1ab7b010, 
# 88 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
TOS_MsgPtr arg_0x1ab4b7c0, uint16_t *arg_0x1ab4b970);
# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
 result_t XMeshC$Window$fired(void);
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
 TOS_MsgPtr XMeshC$ReceiveMsgWithAck$receive(
# 34 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\XMeshC.nc"
uint8_t arg_0x1ab73338, 
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
TOS_MsgPtr arg_0x1a581c80);
# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
 result_t XMeshC$ElpTimeOut$fired(void);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
 result_t XMeshC$SendMsg$sendDone(
# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\XMeshC.nc"
uint8_t arg_0x1ab74010, 
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
TOS_MsgPtr arg_0x1a583e38, result_t arg_0x1a561010);
# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
 result_t XMeshC$HealthTimer$fired(void);
#line 51
 result_t XMeshC$EngineTimer$fired(void);
#line 51
 result_t XMeshC$XOtapTimer$fired(void);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
 result_t XMeshC$StdControl$init(void);






 result_t XMeshC$StdControl$start(void);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\RouteControl.nc"
 uint16_t XMeshC$RouteControl$getParent(void);
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
  result_t XMeshC$Batt$dataReady(uint16_t arg_0x1ab86808);
# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
static  result_t ShimLayerM$MhopSendActual$sendDone(
# 25 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abb5c00, 
# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
TOS_MsgPtr arg_0x1ab4a408, result_t arg_0x1ab4a598);
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Intercept.nc"
static  result_t ShimLayerM$Intercept$default$intercept(
# 13 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abbac00, 
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Intercept.nc"
TOS_MsgPtr arg_0x1ab5a010, void *arg_0x1ab5a1b0, uint16_t arg_0x1ab5a348);
#line 65
static  result_t ShimLayerM$InterceptActual$intercept(
# 23 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abb5030, 
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Intercept.nc"
TOS_MsgPtr arg_0x1ab5a010, void *arg_0x1ab5a1b0, uint16_t arg_0x1ab5a348);
#line 65
static  result_t ShimLayerM$Snoop$default$intercept(
# 14 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abb8208, 
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Intercept.nc"
TOS_MsgPtr arg_0x1ab5a010, void *arg_0x1ab5a1b0, uint16_t arg_0x1ab5a348);
# 68 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Send.nc"
static  result_t ShimLayerM$Send$default$sendDone(
# 16 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abb7010, 
# 68 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Send.nc"
TOS_MsgPtr arg_0x1ab46908, result_t arg_0x1ab46a98);
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\XOtapLoader.nc"
static  result_t ShimLayerM$XOtapLoaderActual$boot_request(uint8_t arg_0x1ab65920);
#line 17
static  result_t ShimLayerM$XOtapLoader$default$boot_request(uint8_t arg_0x1ab65920);




static  result_t ShimLayerM$XOtapLoader$boot(uint8_t arg_0x1ab640b0);
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
static  TOS_MsgPtr ShimLayerM$Receive$default$receive(
# 11 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abba068, 
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
TOS_MsgPtr arg_0x1ab42878, void *arg_0x1ab42a18, uint16_t arg_0x1ab42bb0);
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
static  result_t ShimLayerM$MhopSend$send(
# 15 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abb87c0, 
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
uint16_t arg_0x1ab219b8, uint8_t arg_0x1ab21b40, TOS_MsgPtr arg_0x1ab21cd0, uint16_t arg_0x1ab21e60);
#line 88
static  void *ShimLayerM$MhopSend$getBuffer(
# 15 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abb87c0, 
# 88 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
TOS_MsgPtr arg_0x1ab4b7c0, uint16_t *arg_0x1ab4b970);
#line 101
static  result_t ShimLayerM$MhopSend$default$sendDone(
# 15 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abb87c0, 
# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
TOS_MsgPtr arg_0x1ab4a408, result_t arg_0x1ab4a598);
# 68 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Send.nc"
static  result_t ShimLayerM$SendActual$sendDone(
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abb34e8, 
# 68 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Send.nc"
TOS_MsgPtr arg_0x1ab46908, result_t arg_0x1ab46a98);
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
static  TOS_MsgPtr ShimLayerM$ReceiveActual$receive(
# 21 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abb6448, 
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
TOS_MsgPtr arg_0x1ab42878, void *arg_0x1ab42a18, uint16_t arg_0x1ab42bb0);
# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ElpI.nc"
static  result_t ShimLayerM$ElpIActual$wake_done(result_t arg_0x1ab55a30);
#line 46
static  result_t ShimLayerM$ElpIActual$route_discover_done(result_t arg_0x1ab547e8, uint16_t arg_0x1ab54978);
#line 25
static  result_t ShimLayerM$ElpIActual$sleep_done(result_t arg_0x1ab55208);
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
static  TOS_MsgPtr ShimLayerM$ReceiveAck$default$receive(
# 12 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abba648, 
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
TOS_MsgPtr arg_0x1ab42878, void *arg_0x1ab42a18, uint16_t arg_0x1ab42bb0);
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Intercept.nc"
static  result_t ShimLayerM$SnoopActual$intercept(
# 24 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abb5618, 
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Intercept.nc"
TOS_MsgPtr arg_0x1ab5a010, void *arg_0x1ab5a1b0, uint16_t arg_0x1ab5a348);
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
static  TOS_MsgPtr ShimLayerM$ReceiveAckActual$receive(
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abb6a30, 
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
TOS_MsgPtr arg_0x1ab42878, void *arg_0x1ab42a18, uint16_t arg_0x1ab42bb0);
# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ElpI.nc"
static  result_t ShimLayerM$ElpI$default$wake_done(result_t arg_0x1ab55a30);
#line 46
static  result_t ShimLayerM$ElpI$default$route_discover_done(result_t arg_0x1ab547e8, uint16_t arg_0x1ab54978);
#line 25
static  result_t ShimLayerM$ElpI$default$sleep_done(result_t arg_0x1ab55208);
# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
static  void BoundaryM$BoundaryI$set_nbrtbl_childLiveliness(uint8_t arg_0x1ab92960, uint8_t arg_0x1ab92ae8);
#line 51
static  void BoundaryM$BoundaryI$new_nbrtbl_entry(uint8_t arg_0x1ab94b38, uint16_t arg_0x1ab94cc8);



static  void BoundaryM$BoundaryI$set_nbrtbl_cost(uint8_t arg_0x1ab92330, uint16_t arg_0x1ab924c0);
#line 40
static  uint16_t BoundaryM$BoundaryI$get_nbrtbl_parent(uint8_t arg_0x1ab98660);
#line 31
static  void BoundaryM$BoundaryI$set_tos_cc_channel(uint8_t arg_0x1ab9a010);
#line 85
static  TOS_MsgPtr BoundaryM$BoundaryI$get_fwd_buf_ptr(uint8_t arg_0x1aba4648);
#line 65
static  uint8_t BoundaryM$BoundaryI$get_nbrtbl_size(void);
#line 22
static  uint8_t BoundaryM$BoundaryI$get_tos_data_length(void);
#line 60
static  void BoundaryM$BoundaryI$set_nbrtbl_flags(uint8_t arg_0x1abac338, uint8_t arg_0x1abac4c0);
#line 58
static  void BoundaryM$BoundaryI$set_nbrtbl_received(uint8_t arg_0x1ab90638, uint16_t arg_0x1ab907c8);
#line 75
static  void BoundaryM$BoundaryI$set_dsctbl_from(uint8_t arg_0x1aba6330, uint16_t arg_0x1aba64c0);
#line 32
static  uint8_t BoundaryM$BoundaryI$get_tos_cc_channel(void);
#line 59
static  void BoundaryM$BoundaryI$set_nbrtbl_lastSeqno(uint8_t arg_0x1ab90c60, uint16_t arg_0x1ab90df0);
#line 57
static  void BoundaryM$BoundaryI$set_nbrtbl_missed(uint8_t arg_0x1ab90010, uint16_t arg_0x1ab901a0);
#line 23
static  uint8_t BoundaryM$BoundaryI$get_power_model(void);

static  uint8_t BoundaryM$BoundaryI$get_nbr_advert_threshold(void);







static  void BoundaryM$BoundaryI$set_tos_cc_txpower(uint8_t arg_0x1ab9a828);







static  uint16_t BoundaryM$BoundaryI$get_nbrtbl_cost(uint8_t arg_0x1ab98af8);
#line 66
static  TableEntry *BoundaryM$BoundaryI$get_nbrtbl_addr(uint8_t arg_0x1aba9640);






static  uint16_t BoundaryM$BoundaryI$get_dsctbl_from(uint8_t arg_0x1aba87e0);
static  void BoundaryM$BoundaryI$set_dsctbl_origin(uint8_t arg_0x1aba8c70, uint16_t arg_0x1aba8e00);
#line 48
static  uint8_t BoundaryM$BoundaryI$get_nbrtbl_hop(uint8_t arg_0x1ab96d68);
#line 47
static  uint8_t BoundaryM$BoundaryI$get_nbrtbl_liveliness(uint8_t arg_0x1ab967d8);
#line 19
static  TOS_MsgPtr BoundaryM$BoundaryI$xalloc(uint8_t arg_0x1ab814d8);
#line 49
static  uint8_t BoundaryM$BoundaryI$get_nbrtbl_receiveEst(uint8_t arg_0x1ab94210);
#line 34
static  uint8_t BoundaryM$BoundaryI$get_tos_cc_txpower(void);
#line 61
static  void BoundaryM$BoundaryI$set_nbrtbl_liveliness(uint8_t arg_0x1abac958, uint8_t arg_0x1abacae0);
#line 44
static  uint16_t BoundaryM$BoundaryI$get_nbrtbl_received(uint8_t arg_0x1ab97950);
#line 63
static  void BoundaryM$BoundaryI$set_nbrtbl_receiveEst(uint8_t arg_0x1abab630, uint8_t arg_0x1abab7b8);
#line 83
static  void BoundaryM$BoundaryI$set_fwd_buf_status(uint8_t arg_0x1aba5cc8, uint8_t arg_0x1aba5e50);
#line 43
static  uint16_t BoundaryM$BoundaryI$get_nbrtbl_missed(uint8_t arg_0x1ab974b0);
#line 20
static  void *BoundaryM$BoundaryI$get_strength(TOS_MsgPtr arg_0x1ab819d0);





static  uint32_t BoundaryM$BoundaryI$get_route_update_interval(void);
#line 39
static  uint16_t BoundaryM$BoundaryI$get_nbrtbl_id(uint8_t arg_0x1ab98188);


static  uint8_t BoundaryM$BoundaryI$get_nbrtbl_childLiveliness(uint8_t arg_0x1ab97010);
#line 28
static  uint8_t BoundaryM$BoundaryI$get_max_retry(void);
#line 71
static  uint8_t BoundaryM$BoundaryI$find_dsctbl_entry(uint16_t arg_0x1aba9ca0, uint8_t arg_0x1aba9e28);
#line 46
static  uint8_t BoundaryM$BoundaryI$get_nbrtbl_flags(uint8_t arg_0x1ab96340);
#line 76
static  DescendantTbl *BoundaryM$BoundaryI$get_dsctbl_addr(uint8_t arg_0x1aba6b60);
#line 30
static  bool BoundaryM$BoundaryI$set_built_from_factory(void);
#line 29
static  uint8_t BoundaryM$BoundaryI$get_descendant_table_size(void);
#line 62
static  void BoundaryM$BoundaryI$set_nbrtbl_hop(uint8_t arg_0x1abab010, uint8_t arg_0x1abab198);

static  void BoundaryM$BoundaryI$set_nbrtbl_sendEst(uint8_t arg_0x1ababc50, uint8_t arg_0x1ababdd8);
#line 24
static  uint8_t BoundaryM$BoundaryI$get_platform(void);
#line 21
static  uint8_t BoundaryM$BoundaryI$get_ack(TOS_MsgPtr arg_0x1ab81e80);
#line 54
static  void BoundaryM$BoundaryI$set_nbrtbl_parent(uint8_t arg_0x1ab93c40, uint16_t arg_0x1ab93dd0);
#line 82
static  uint8_t BoundaryM$BoundaryI$get_fwd_buf_status(uint8_t arg_0x1aba5838);
#line 45
static  uint16_t BoundaryM$BoundaryI$get_nbrtbl_lastSeqno(uint8_t arg_0x1ab97df0);




static  uint8_t BoundaryM$BoundaryI$get_nbrtbl_sendEst(uint8_t arg_0x1ab946a8);
#line 27
static  uint8_t BoundaryM$BoundaryI$get_route_table_size(void);
#line 53
static  void BoundaryM$BoundaryI$set_nbrtbl_id(uint8_t arg_0x1ab93618, uint16_t arg_0x1ab937a8);
#line 72
static  uint16_t BoundaryM$BoundaryI$get_dsctbl_origin(uint8_t arg_0x1aba8348);








static  void BoundaryM$BoundaryI$set_fwd_buf_ptr(uint8_t arg_0x1aba51d0, TOS_MsgPtr arg_0x1aba5360);
#line 52
static  uint8_t BoundaryM$BoundaryI$find_nbrtbl_entry(uint16_t arg_0x1ab93190);
#line 84
static  uint8_t BoundaryM$BoundaryI$get_fwd_buf_size(void);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
static  result_t QueuedSendM$QueueSendMsg$send(
# 38 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Queue\\QueuedSendM.nc"
uint8_t arg_0x1ac5b210, 
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
uint16_t arg_0x1a583670, uint8_t arg_0x1a5837f8, TOS_MsgPtr arg_0x1a583988);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t QueuedSendM$StdControl$init(void);






static  result_t QueuedSendM$StdControl$start(void);







static  result_t QueuedSendM$StdControl$stop(void);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
static  result_t QueuedSendM$SerialSendMsg$sendDone(
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Queue\\QueuedSendM.nc"
uint8_t arg_0x1ac5bd18, 
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
TOS_MsgPtr arg_0x1a583e38, result_t arg_0x1a561010);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t VoltageM$StdControl$init(void);






static  result_t VoltageM$StdControl$start(void);







static  result_t VoltageM$StdControl$stop(void);
# 78 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLADC.nc"
static   result_t ADCREFM$HPLADC$dataReady(uint16_t arg_0x1ac988f8);
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
static   result_t ADCREFM$CalADC$default$dataReady(
# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCREFM.nc"
uint8_t arg_0x1ac801b0, 
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
uint16_t arg_0x1ab86808);
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCControl.nc"
static  result_t ADCREFM$ADCControl$bindPort(uint8_t arg_0x1ac8c2c8, uint8_t arg_0x1ac8c450);
#line 26
static  result_t ADCREFM$ADCControl$init(void);
#line 73
static   result_t ADCREFM$ADCControl$manualCalibrate(void);
# 30 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
static   result_t ADCREFM$ADC$getData(
# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCREFM.nc"
uint8_t arg_0x1ac819f8);
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
static   result_t ADCREFM$ADC$getContinuousData(
# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCREFM.nc"
uint8_t arg_0x1ac819f8);
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
static   result_t ADCREFM$ADC$default$dataReady(
# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCREFM.nc"
uint8_t arg_0x1ac819f8, 
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
uint16_t arg_0x1ab86808);
# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
static  result_t ADCREFM$Timer$fired(void);
# 49 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLADC.nc"
static   result_t HPLADCM$ADC$bindPort(uint8_t arg_0x1ac9aec8, uint8_t arg_0x1ac99068);
#line 33
static   result_t HPLADCM$ADC$init(void);
#line 56
static   result_t HPLADCM$ADC$samplePort(uint8_t arg_0x1ac99778);
# 20 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XEEControl.nc"
static  result_t XMDA300M$XEEControl$restoreDone(result_t arg_0x1ad06218);
# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
static  result_t XMDA300M$Send$sendDone(TOS_MsgPtr arg_0x1ab4a408, result_t arg_0x1ab4a598);
# 21 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Sample.nc"
static  result_t XMDA300M$Sample$dataReady(uint8_t arg_0x1ad03e30, uint8_t arg_0x1ad01010, uint16_t arg_0x1ad011a0);
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XCommand.nc"
static  result_t XMDA300M$XCommand$received(XCommandOp *arg_0x1ad09a60);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t XMDA300M$StdControl$init(void);






static  result_t XMDA300M$StdControl$start(void);







static  result_t XMDA300M$StdControl$stop(void);
# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
static  result_t XMDA300M$Timer$fired(void);
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
static  size_t RecoverParamsM$ExternalConfig$get(
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
AppParamID_t arg_0x1ad7cd80, 
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
void *arg_0x1ad7b6b8, size_t arg_0x1ad7b840);
#line 57
static  result_t RecoverParamsM$ExternalConfig$set(
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
AppParamID_t arg_0x1ad7cd80, 
# 57 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
void *arg_0x1ad7bcf0, size_t arg_0x1ad7be78);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt16.nc"
static  uint16_t RecoverParamsM$ConfigInt16$default$get(
# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
AppParamID_t arg_0x1ad5d010);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt16.nc"
static  result_t RecoverParamsM$ConfigInt16$default$set(
# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
AppParamID_t arg_0x1ad5d010, 
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt16.nc"
uint16_t arg_0x1ad5baa8);
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
static  size_t RecoverParamsM$Config$default$get(
# 29 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
AppParamID_t arg_0x1ad73460, 
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
void *arg_0x1ad7b6b8, size_t arg_0x1ad7b840);
#line 57
static  result_t RecoverParamsM$Config$default$set(
# 29 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
AppParamID_t arg_0x1ad73460, 
# 57 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
void *arg_0x1ad7bcf0, size_t arg_0x1ad7be78);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt8.nc"
static  uint8_t RecoverParamsM$ConfigInt8$default$get(
# 30 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
AppParamID_t arg_0x1ad5e3c8);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt8.nc"
static  result_t RecoverParamsM$ConfigInt8$default$set(
# 30 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
AppParamID_t arg_0x1ad5e3c8, 
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt8.nc"
uint8_t arg_0x1ad71f10);
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
static  size_t RecoverSystemParamsM$CrossbowFactoryInfo1$get(void *arg_0x1ad7b6b8, size_t arg_0x1ad7b840);
#line 57
static  result_t RecoverSystemParamsM$CrossbowFactoryInfo1$set(void *arg_0x1ad7bcf0, size_t arg_0x1ad7be78);
#line 43
static  size_t RecoverSystemParamsM$CrossbowFactoryInfo4$get(void *arg_0x1ad7b6b8, size_t arg_0x1ad7b840);
#line 57
static  result_t RecoverSystemParamsM$CrossbowFactoryInfo4$set(void *arg_0x1ad7bcf0, size_t arg_0x1ad7be78);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt8.nc"
static  uint8_t RecoverSystemParamsM$SystemGroupNumber$get(void);
static  result_t RecoverSystemParamsM$SystemGroupNumber$set(uint8_t arg_0x1ad71f10);
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
static  size_t RecoverSystemParamsM$SystemSerialNumber$get(void *arg_0x1ad7b6b8, size_t arg_0x1ad7b840);
#line 57
static  result_t RecoverSystemParamsM$SystemSerialNumber$set(void *arg_0x1ad7bcf0, size_t arg_0x1ad7be78);
#line 43
static  size_t RecoverSystemParamsM$CrossbowFactoryInfo2$get(void *arg_0x1ad7b6b8, size_t arg_0x1ad7b840);
#line 57
static  result_t RecoverSystemParamsM$CrossbowFactoryInfo2$set(void *arg_0x1ad7bcf0, size_t arg_0x1ad7be78);
#line 43
static  size_t RecoverSystemParamsM$XmeshAppTimerRate$get(void *arg_0x1ad7b6b8, size_t arg_0x1ad7b840);
#line 57
static  result_t RecoverSystemParamsM$XmeshAppTimerRate$set(void *arg_0x1ad7bcf0, size_t arg_0x1ad7be78);
#line 43
static  size_t RecoverSystemParamsM$SystemCPUOscillatorFrequency$get(void *arg_0x1ad7b6b8, size_t arg_0x1ad7b840);
#line 57
static  result_t RecoverSystemParamsM$SystemCPUOscillatorFrequency$set(void *arg_0x1ad7bcf0, size_t arg_0x1ad7be78);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt8.nc"
static  uint8_t RecoverSystemParamsM$SystemModelType$get(void);
static  result_t RecoverSystemParamsM$SystemModelType$set(uint8_t arg_0x1ad71f10);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t RecoverSystemParamsM$XEESubControl$init(void);






static  result_t RecoverSystemParamsM$XEESubControl$start(void);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt16.nc"
static  uint16_t RecoverSystemParamsM$SystemMoteID$get(void);
static  result_t RecoverSystemParamsM$SystemMoteID$set(uint16_t arg_0x1ad5baa8);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt8.nc"
static  uint8_t RecoverSystemParamsM$SystemMoteCPUType$get(void);
static  result_t RecoverSystemParamsM$SystemMoteCPUType$set(uint8_t arg_0x1ad71f10);
#line 26
static  uint8_t RecoverSystemParamsM$RadioPower$get(void);
static  result_t RecoverSystemParamsM$RadioPower$set(uint8_t arg_0x1ad71f10);
#line 26
static  uint8_t RecoverSystemParamsM$SystemRadioType$get(void);
static  result_t RecoverSystemParamsM$SystemRadioType$set(uint8_t arg_0x1ad71f10);
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
static  size_t RecoverSystemParamsM$CrossbowFactoryInfo3$get(void *arg_0x1ad7b6b8, size_t arg_0x1ad7b840);
#line 57
static  result_t RecoverSystemParamsM$CrossbowFactoryInfo3$set(void *arg_0x1ad7bcf0, size_t arg_0x1ad7be78);
# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HardwareId.nc"
static  result_t RecoverSystemParamsM$HardwareId$readDone(uint8_t *arg_0x1ad9da40, result_t arg_0x1ad9dbd0);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt16.nc"
static  uint16_t RecoverSystemParamsM$SystemVendorID$get(void);
static  result_t RecoverSystemParamsM$SystemVendorID$set(uint16_t arg_0x1ad5baa8);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt8.nc"
static  uint8_t RecoverSystemParamsM$RadioChannel$get(void);
static  result_t RecoverSystemParamsM$RadioChannel$set(uint8_t arg_0x1ad71f10);
#line 26
static  uint8_t RecoverSystemParamsM$SystemSuModelType$get(void);
static  result_t RecoverSystemParamsM$SystemSuModelType$set(uint8_t arg_0x1ad71f10);
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HardwareId.nc"
static  result_t SerialId$HardwareId$read(uint8_t *arg_0x1ad9d338);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t SerialId$StdControl$init(void);






static  result_t SerialId$StdControl$start(void);







static  result_t SerialId$StdControl$stop(void);
# 42 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReadData.nc"
static  result_t EEPROMConfigM$ReadData$readDone(uint8_t *arg_0x1ae35010, uint32_t arg_0x1ae351a8, result_t arg_0x1ae35338);
# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigSave.nc"
static  result_t EEPROMConfigM$ConfigSave$save(AppParamID_t arg_0x1ad77730, AppParamID_t arg_0x1ad778c0);
# 42 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\WriteData.nc"
static  result_t EEPROMConfigM$WriteData$writeDone(uint8_t *arg_0x1ae39500, uint32_t arg_0x1ae39698, result_t arg_0x1ae39828);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t EEPROMConfigM$StdControl$init(void);






static  result_t EEPROMConfigM$StdControl$start(void);
# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReadData.nc"
static  result_t InternalEEPROMM$ReadData$read(uint32_t arg_0x1ae364d0, uint8_t *arg_0x1ae36678, uint32_t arg_0x1ae36810);
# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\WriteData.nc"
static  result_t InternalEEPROMM$WriteData$write(uint32_t arg_0x1ae3a9e0, uint8_t *arg_0x1ae3ab88, uint32_t arg_0x1ae3ad20);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t InternalEEPROMM$StdControl$init(void);






static  result_t InternalEEPROMM$StdControl$start(void);
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
static  TOS_MsgPtr XCommandM$Bcast$receive(TOS_MsgPtr arg_0x1ab42878, void *arg_0x1ab42a18, uint16_t arg_0x1ab42bb0);
# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
static  result_t XCommandM$Send$sendDone(TOS_MsgPtr arg_0x1ab4a408, result_t arg_0x1ab4a598);
# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigSave.nc"
static  result_t XCommandM$ConfigSave$saveDone(result_t arg_0x1ad77d68, AppParamID_t arg_0x1ad77ef8);
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
static  TOS_MsgPtr XCommandM$CmdRcv$receive(TOS_MsgPtr arg_0x1ab42878, void *arg_0x1ab42a18, uint16_t arg_0x1ab42bb0);
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
static  TOS_MsgPtr BcastM$ReceiveMsg$receive(
# 23 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Broadcast\\BcastM.nc"
uint8_t arg_0x1af8cc28, 
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
TOS_MsgPtr arg_0x1a581c80);
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
static  TOS_MsgPtr BcastM$Receive$default$receive(
# 19 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Broadcast\\BcastM.nc"
uint8_t arg_0x1af8c118, 
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
TOS_MsgPtr arg_0x1ab42878, void *arg_0x1ab42a18, uint16_t arg_0x1ab42bb0);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
static  result_t BcastM$SendMsg$sendDone(
# 24 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Broadcast\\BcastM.nc"
uint8_t arg_0x1af8b200, 
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
TOS_MsgPtr arg_0x1a583e38, result_t arg_0x1a561010);
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC6$dataReady(uint16_t arg_0x1afcb010);
#line 44
static  result_t SamplerM$ADC0$dataReady(uint16_t arg_0x1afcb010);
# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t SamplerM$Dio2$dataReady(uint16_t arg_0x1afee368);
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC9$dataReady(uint16_t arg_0x1afcb010);
#line 44
static  result_t SamplerM$ADC3$dataReady(uint16_t arg_0x1afcb010);
# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t SamplerM$Dio5$dataReady(uint16_t arg_0x1afee368);
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC12$dataReady(uint16_t arg_0x1afcb010);
#line 44
static  result_t SamplerM$ADC4$dataReady(uint16_t arg_0x1afcb010);
# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t SamplerM$Dio0$dataReady(uint16_t arg_0x1afee368);
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$Hum$dataReady(uint16_t arg_0x1afcb010);
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
static   result_t SamplerM$Battery$dataReady(uint16_t arg_0x1ab86808);
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC7$dataReady(uint16_t arg_0x1afcb010);
# 24 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Sample.nc"
static  result_t SamplerM$Sample$sampleNow(void);
#line 19
static  int8_t SamplerM$Sample$getSample(uint8_t arg_0x1ad07e70, uint8_t arg_0x1ad03030, uint16_t arg_0x1ad031c8, uint8_t arg_0x1ad03350);



static  result_t SamplerM$Sample$stop(int8_t arg_0x1ad01c70);
# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
static  result_t SamplerM$SamplerTimer$fired(void);
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC1$dataReady(uint16_t arg_0x1afcb010);
#line 44
static  result_t SamplerM$ADC10$dataReady(uint16_t arg_0x1afcb010);
# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t SamplerM$Dio3$dataReady(uint16_t arg_0x1afee368);
# 24 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static  result_t SamplerM$PlugPlay(void);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t SamplerM$SamplerControl$init(void);






static  result_t SamplerM$SamplerControl$start(void);







static  result_t SamplerM$SamplerControl$stop(void);
# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t SamplerM$Counter$dataReady(uint16_t arg_0x1afee368);
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC13$dataReady(uint16_t arg_0x1afcb010);
#line 44
static  result_t SamplerM$ADC5$dataReady(uint16_t arg_0x1afcb010);
#line 44
static  result_t SamplerM$Temp$dataReady(uint16_t arg_0x1afcb010);
# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t SamplerM$Dio1$dataReady(uint16_t arg_0x1afee368);
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC8$dataReady(uint16_t arg_0x1afcb010);
#line 44
static  result_t SamplerM$ADC2$dataReady(uint16_t arg_0x1afcb010);
# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t SamplerM$Dio4$dataReady(uint16_t arg_0x1afee368);
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC11$dataReady(uint16_t arg_0x1afcb010);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2C.nc"
static  result_t I2CM$I2C$sendEnd(void);






static  result_t I2CM$I2C$read(bool arg_0x1b088a00);
#line 20
static  result_t I2CM$I2C$sendStart(void);
#line 41
static  result_t I2CM$I2C$write(char arg_0x1b0870f0);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t I2CM$StdControl$init(void);
# 55 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2C.nc"
static  result_t I2CPacketM$I2C$sendEndDone(void);
#line 48
static  result_t I2CPacketM$I2C$sendStartDone(void);
#line 71
static  result_t I2CPacketM$I2C$writeDone(bool arg_0x1b085978);
#line 62
static  result_t I2CPacketM$I2C$readDone(char arg_0x1b0852b8);
# 78 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
static  result_t I2CPacketM$I2CPacket$default$writePacketDone(
# 24 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\I2CPacketM.nc"
uint8_t arg_0x1b0c4930, 
# 78 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
bool arg_0x1b0909e8);
#line 70
static  result_t I2CPacketM$I2CPacket$default$readPacketDone(
# 24 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\I2CPacketM.nc"
uint8_t arg_0x1b0c4930, 
# 70 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
char arg_0x1b090010, char *arg_0x1b0901b0);
#line 56
static  result_t I2CPacketM$I2CPacket$writePacket(
# 24 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\I2CPacketM.nc"
uint8_t arg_0x1b0c4930, 
# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
char arg_0x1b0913c0, char *arg_0x1b091560, char arg_0x1b0916e0);
#line 39
static  result_t I2CPacketM$I2CPacket$readPacket(
# 24 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\I2CPacketM.nc"
uint8_t arg_0x1b0c4930, 
# 39 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
char arg_0x1b093858, char arg_0x1b0939d8);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t I2CPacketM$StdControl$init(void);
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t DioM$Dio$low(
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
uint8_t arg_0x1b1087d0);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t DioM$Dio$setparam(
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
uint8_t arg_0x1b1087d0, 
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
uint8_t arg_0x1afefeb0);
#line 20
static  result_t DioM$Dio$getData(
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
uint8_t arg_0x1b1087d0);
# 21 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t DioM$Dio$high(
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
uint8_t arg_0x1b1087d0);
# 23 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t DioM$Dio$Toggle(
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
uint8_t arg_0x1b1087d0);
# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t DioM$Dio$default$dataReady(
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
uint8_t arg_0x1b1087d0, 
# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
uint16_t arg_0x1afee368);
# 78 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
static  result_t DioM$I2CPacket$writePacketDone(bool arg_0x1b0909e8);
#line 70
static  result_t DioM$I2CPacket$readPacketDone(char arg_0x1b090010, char *arg_0x1b0901b0);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t DioM$StdControl$init(void);






static  result_t DioM$StdControl$start(void);







static  result_t DioM$StdControl$stop(void);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Switch.nc"
static  result_t IBADCM$Switch$setDone(bool arg_0x1b194338);
static  result_t IBADCM$Switch$setAllDone(bool arg_0x1b1947d0);
# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
static  result_t IBADCM$PowerStabalizingTimer$fired(void);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t IBADCM$ADConvert$getData(
# 25 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
uint8_t arg_0x1b1694c0);
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t IBADCM$ADConvert$default$dataReady(
# 25 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
uint8_t arg_0x1b1694c0, 
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
uint16_t arg_0x1afcb010);
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SetParam.nc"
static  result_t IBADCM$SetParam$setParam(
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
uint8_t arg_0x1b169c38, 
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SetParam.nc"
uint8_t arg_0x1afc7e18);
# 78 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
static  result_t IBADCM$I2CPacket$writePacketDone(bool arg_0x1b0909e8);
#line 70
static  result_t IBADCM$I2CPacket$readPacketDone(char arg_0x1b090010, char *arg_0x1b0901b0);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t IBADCM$StdControl$init(void);






static  result_t IBADCM$StdControl$start(void);







static  result_t IBADCM$StdControl$stop(void);
#line 41
static  result_t SwitchM$SwitchControl$init(void);






static  result_t SwitchM$SwitchControl$start(void);







static  result_t SwitchM$SwitchControl$stop(void);
# 24 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Switch.nc"
static  result_t SwitchM$Switch$setAll(char arg_0x1b160a08);
# 78 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
static  result_t SwitchM$I2CPacket$writePacketDone(bool arg_0x1b0909e8);
#line 70
static  result_t SwitchM$I2CPacket$readPacketDone(char arg_0x1b090010, char *arg_0x1b0901b0);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t CounterM$Counter$setparam(uint8_t arg_0x1afefeb0);
#line 20
static  result_t CounterM$Counter$getData(void);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t CounterM$CounterControl$init(void);






static  result_t CounterM$CounterControl$start(void);







static  result_t CounterM$CounterControl$stop(void);
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\CounterM.nc"
static  result_t CounterM$Plugged(void);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t TempHumM$TempSensor$getData(void);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t TempHumM$StdControl$init(void);






static  result_t TempHumM$StdControl$start(void);







static  result_t TempHumM$StdControl$stop(void);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t TempHumM$HumSensor$getData(void);
# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t RelayM$Dio7$dataReady(uint16_t arg_0x1afee368);
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Relay.nc"
static  result_t RelayM$relay_normally_closed$toggle(void);
#line 20
static  result_t RelayM$relay_normally_closed$open(void);
static  result_t RelayM$relay_normally_closed$close(void);
static  result_t RelayM$relay_normally_open$toggle(void);
#line 20
static  result_t RelayM$relay_normally_open$open(void);
static  result_t RelayM$relay_normally_open$close(void);
# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t RelayM$Dio6$dataReady(uint16_t arg_0x1afee368);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\RealMain.nc"
static  result_t RealMain$hardwareInit(void);
# 57 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Pot.nc"
static  result_t RealMain$Pot$init(uint8_t arg_0x1a5051b8);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t RealMain$StdControl$init(void);






static  result_t RealMain$StdControl$start(void);
# 34 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\RealMain.nc"
int main(void)   ;
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLPot.nc"
static  result_t PotM$HPLPot$finalise(void);
#line 38
static  result_t PotM$HPLPot$decrease(void);







static  result_t PotM$HPLPot$increase(void);
# 70 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\PotM.nc"
uint8_t PotM$potSetting;

static inline void PotM$setPot(uint8_t value);
#line 85
static inline  result_t PotM$Pot$init(uint8_t initialSetting);
# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\HPLPotC.nc"
static inline  result_t HPLPotC$Pot$decrease(void);








static inline  result_t HPLPotC$Pot$increase(void);








static inline  result_t HPLPotC$Pot$finalise(void);
# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\HPLInit.nc"
static inline  result_t HPLInit$init(void);
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
static  TOS_MsgPtr AMPromiscuous$ReceiveMsg$receive(
# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
uint8_t arg_0x1a592720, 
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
TOS_MsgPtr arg_0x1a581c80);
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
static  result_t AMPromiscuous$ActivityTimer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500);








static  result_t AMPromiscuous$ActivityTimer$stop(void);
# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BareSendMsg.nc"
static  result_t AMPromiscuous$UARTSend$send(TOS_MsgPtr arg_0x1a5a3be8);
# 19 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\PowerManagement.nc"
static   uint8_t AMPromiscuous$PowerManagement$adjustPower(void);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t AMPromiscuous$RadioControl$init(void);






static  result_t AMPromiscuous$RadioControl$start(void);







static  result_t AMPromiscuous$RadioControl$stop(void);
#line 41
static  result_t AMPromiscuous$TimerControl$init(void);






static  result_t AMPromiscuous$TimerControl$start(void);
#line 41
static  result_t AMPromiscuous$UARTControl$init(void);






static  result_t AMPromiscuous$UARTControl$start(void);







static  result_t AMPromiscuous$UARTControl$stop(void);
# 85 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
static   result_t AMPromiscuous$Leds$greenToggle(void);
# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static  result_t AMPromiscuous$sendDone(void);
# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BareSendMsg.nc"
static  result_t AMPromiscuous$RadioSend$send(TOS_MsgPtr arg_0x1a5a3be8);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
static  result_t AMPromiscuous$SendMsg$sendDone(
# 35 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
uint8_t arg_0x1a592088, 
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
TOS_MsgPtr arg_0x1a583e38, result_t arg_0x1a561010);
# 64 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
bool AMPromiscuous$state;
TOS_MsgPtr AMPromiscuous$buffer;
uint16_t AMPromiscuous$lastCount;
uint16_t AMPromiscuous$counter;
bool AMPromiscuous$promiscuous_mode;
bool AMPromiscuous$crc_check;


static  result_t AMPromiscuous$Control$init(void);
#line 89
static  result_t AMPromiscuous$Control$start(void);
#line 106
static inline  result_t AMPromiscuous$Control$stop(void);










static inline  result_t AMPromiscuous$CommControl$setCRCCheck(bool value);




static inline  bool AMPromiscuous$CommControl$getCRCCheck(void);



static inline  result_t AMPromiscuous$CommControl$setPromiscuous(bool value);




static inline  bool AMPromiscuous$CommControl$getPromiscuous(void);







static inline void AMPromiscuous$dbgPacket(TOS_MsgPtr data);










static result_t AMPromiscuous$reportSendDone(TOS_MsgPtr msg, result_t success);








static inline  result_t AMPromiscuous$ActivityTimer$fired(void);








static inline   result_t AMPromiscuous$default$sendDone(void);




static inline  void AMPromiscuous$sendTask(void);
#line 186
static inline  result_t AMPromiscuous$SendMsg$send(uint8_t id, uint16_t addr, uint8_t length, TOS_MsgPtr data);
#line 225
static inline  result_t AMPromiscuous$UARTSend$sendDone(TOS_MsgPtr msg, result_t success);


static inline  result_t AMPromiscuous$RadioSend$sendDone(TOS_MsgPtr msg, result_t success);




TOS_MsgPtr prom_received(TOS_MsgPtr packet)   ;
#line 263
static inline   TOS_MsgPtr AMPromiscuous$ReceiveMsg$default$receive(uint8_t id, TOS_MsgPtr msg);



static inline  TOS_MsgPtr AMPromiscuous$UARTReceive$receive(TOS_MsgPtr packet);



static inline  TOS_MsgPtr AMPromiscuous$RadioReceive$receive(TOS_MsgPtr packet);
# 34 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\TimerJiffyAsync.nc"
static   result_t CC2420RadioM$BackoffTimerJiffy$setOneShot(uint32_t arg_0x1a6d5460);



static   bool CC2420RadioM$BackoffTimerJiffy$isSet(void);
#line 36
static   result_t CC2420RadioM$BackoffTimerJiffy$stop(void);
# 73 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static   TOS_MsgPtr CC2420RadioM$asyncReceive(TOS_MsgPtr arg_0x1a6d69c8);
# 42 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Random.nc"
static   uint16_t CC2420RadioM$Random$rand(void);
#line 36
static   result_t CC2420RadioM$Random$init(void);
# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BareSendMsg.nc"
static  result_t CC2420RadioM$Send$sendDone(TOS_MsgPtr arg_0x1a5a1360, result_t arg_0x1a5a14f0);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t CC2420RadioM$TimerControl$init(void);
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
static  TOS_MsgPtr CC2420RadioM$Receive$receive(TOS_MsgPtr arg_0x1a581c80);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420.nc"
static   result_t CC2420RadioM$HPLChipcon$enableFIFOP(void);
#line 65
static   uint16_t CC2420RadioM$HPLChipcon$read(uint8_t arg_0x1a6c6500);
#line 58
static   uint8_t CC2420RadioM$HPLChipcon$write(uint8_t arg_0x1a6b1bb0, uint16_t arg_0x1a6b1d40);
#line 51
static   uint8_t CC2420RadioM$HPLChipcon$cmd(uint8_t arg_0x1a6b14f8);
#line 42
static   result_t CC2420RadioM$HPLChipcon$disableFIFOP(void);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t CC2420RadioM$CC2420StdControl$init(void);






static  result_t CC2420RadioM$CC2420StdControl$start(void);







static  result_t CC2420RadioM$CC2420StdControl$stop(void);
# 15 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\RadioCoordinator.nc"
static   void CC2420RadioM$RadioSendCoordinator$startSymbol(uint8_t arg_0x1a6a46c0, uint8_t arg_0x1a6a4848, TOS_MsgPtr arg_0x1a6a49d8);
# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420FIFO.nc"
static   result_t CC2420RadioM$HPLChipconFIFO$writeTXFIFO(uint8_t arg_0x1a6c3f00, uint8_t *arg_0x1a6c20d0);
#line 46
static   result_t CC2420RadioM$HPLChipconFIFO$readRXFIFO(uint8_t arg_0x1a6c3518, uint8_t *arg_0x1a6c36c0);
# 148 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420Control.nc"
static   result_t CC2420RadioM$CC2420Control$disableAutoAck(void);
#line 112
static   result_t CC2420RadioM$CC2420Control$RxMode(void);
#line 168
static   result_t CC2420RadioM$CC2420Control$disableAddrDecode(void);
# 70 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static  uint8_t CC2420RadioM$EnableLowPower(void);
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\MacBackoff.nc"
static   int16_t CC2420RadioM$MacBackoff$initialBackoff(TOS_MsgPtr arg_0x1a6733e8);
static   int16_t CC2420RadioM$MacBackoff$congestionBackoff(TOS_MsgPtr arg_0x1a6738a8);
# 74 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static   void CC2420RadioM$shortReceived(void);
#line 120
enum CC2420RadioM$__nesc_unnamed4313 {
  CC2420RadioM$DISABLED_STATE = 0, 
  CC2420RadioM$IDLE_STATE, 
  CC2420RadioM$PRE_TX_STATE, 
  CC2420RadioM$TX_STATE, 
  CC2420RadioM$POST_TX_STATE, 
  CC2420RadioM$RAW_TX_STATE, 



  CC2420RadioM$TIMER_IDLE = 0, 
  CC2420RadioM$TIMER_INITIAL, 
  CC2420RadioM$TIMER_BACKOFF, 
  CC2420RadioM$TIMER_ACK, 
  CC2420RadioM$TIMER_SNIFF
};



 uint8_t CC2420RadioM$stateTimer;
 bool CC2420RadioM$bAckEnable;
 bool CC2420RadioM$bAckManual;



 uint8_t CC2420RadioM$cnttryToSend;



uint8_t CC2420RadioM$RadioState;
uint8_t CC2420RadioM$bRxBufLocked;
uint8_t CC2420RadioM$currentDSN;
uint16_t CC2420RadioM$txlength;
uint16_t CC2420RadioM$rxlength;
TOS_MsgPtr CC2420RadioM$txbufptr;
TOS_MsgPtr CC2420RadioM$rxbufptr;
TOS_Msg CC2420RadioM$RxBuf;



result_t CC2420RadioM$gImmedSendDone;

volatile result_t CC2420RadioM$gSniffDone;








volatile uint16_t CC2420RadioM$LocalAddr;



static __inline void CC2420RadioM$immedPacketSent(void);
static __inline void CC2420RadioM$immedPacketRcvd(void);
static void CC2420RadioM$fSendAborted(void);
static result_t CC2420RadioM$sendPacket(void);
static inline void CC2420RadioM$tryToSend(void);
static inline uint8_t CC2420RadioM$fTXPacket(uint8_t len, uint8_t *pMsg);



static inline  void CC2420RadioM$PacketRcvd(void);
static inline  void CC2420RadioM$PacketSent(void);
#line 204
static __inline result_t CC2420RadioM$setInitialTimer(uint16_t jiffy);
#line 216
static __inline result_t CC2420RadioM$setBackoffTimer(uint16_t jiffy);
#line 231
static __inline result_t CC2420RadioM$setAckTimer(uint16_t jiffy);
#line 247
static inline result_t CC2420RadioM$fTXPacket(uint8_t len, uint8_t *pMsg);
#line 286
static result_t CC2420RadioM$sendPacket(void);
#line 377
static inline void CC2420RadioM$tryToSend(void);
#line 415
static void CC2420RadioM$fSendAborted(void);
#line 458
static __inline void CC2420RadioM$immedPacketSent(void);
#line 502
static __inline void CC2420RadioM$immedPacketRcvd(void);
#line 546
static inline  void CC2420RadioM$PacketRcvd(void);




static inline  void CC2420RadioM$PacketSent(void);





static inline  result_t CC2420RadioM$StdControl$init(void);
#line 590
static inline  result_t CC2420RadioM$StdControl$stop(void);
#line 609
static inline  result_t CC2420RadioM$StdControl$start(void);
#line 658
static   result_t CC2420RadioM$BackoffTimerJiffy$fired(void);
#line 727
static inline  result_t CC2420RadioM$Send$send(TOS_MsgPtr pMsg);
#line 906
static inline   result_t CC2420RadioM$HPLChipcon$FIFOPIntr(void);
#line 1082
static inline   void CC2420RadioM$MacControl$disableAddrDecode(void);
#line 1110
static inline   void CC2420RadioM$MacControl$disableAck(void);
#line 1273
static inline  result_t CC2420RadioM$RadioPower$SetTransmitMode(uint8_t power);



static inline  result_t CC2420RadioM$RadioPower$SetListeningMode(uint8_t power);
#line 1298
static inline    TOS_MsgPtr CC2420RadioM$default$asyncReceive(TOS_MsgPtr pBuf);






static inline    void CC2420RadioM$default$shortReceived(void);







static inline    int16_t CC2420RadioM$MacBackoff$default$initialBackoff(TOS_MsgPtr m);







static inline    int16_t CC2420RadioM$MacBackoff$default$congestionBackoff(TOS_MsgPtr m);




static inline    
#line 1325
void CC2420RadioM$RadioSendCoordinator$default$startSymbol(
uint8_t bitsPerBlock, uint8_t offset, TOS_MsgPtr msgBuff);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420.nc"
static   result_t CC2420ControlM$HPLChipcon$enableFIFOP(void);
#line 65
static   uint16_t CC2420ControlM$HPLChipcon$read(uint8_t arg_0x1a6c6500);
#line 58
static   uint8_t CC2420ControlM$HPLChipcon$write(uint8_t arg_0x1a6b1bb0, uint16_t arg_0x1a6b1d40);
#line 51
static   uint8_t CC2420ControlM$HPLChipcon$cmd(uint8_t arg_0x1a6b14f8);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t CC2420ControlM$HPLChipconControl$init(void);






static  result_t CC2420ControlM$HPLChipconControl$start(void);







static  result_t CC2420ControlM$HPLChipconControl$stop(void);
# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420RAM.nc"
static   result_t CC2420ControlM$HPLChipconRAM$write(uint16_t arg_0x1a7c6458, uint8_t arg_0x1a7c65e0, uint8_t *arg_0x1a7c6788);
# 87 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420ControlM.nc"
 uint16_t CC2420ControlM$gCurrentParameters[14];






static inline bool CC2420ControlM$SetRegs(void);
#line 126
static inline  result_t CC2420ControlM$StdControl$init(void);
#line 201
static inline  result_t CC2420ControlM$StdControl$stop(void);
#line 213
static inline  result_t CC2420ControlM$StdControl$start(void);
#line 249
static  result_t CC2420ControlM$CC2420Control$TunePreset(uint8_t chnl);
#line 301
static inline   result_t CC2420ControlM$CC2420Control$RxMode(void);










static  result_t CC2420ControlM$CC2420Control$SetRFPower(uint8_t power);
#line 343
static inline   result_t CC2420ControlM$CC2420Control$OscillatorOn(void);
#line 381
static   result_t CC2420ControlM$CC2420Control$disableAutoAck(void);




static inline  result_t CC2420ControlM$CC2420Control$setShortAddress(uint16_t addr);




static inline   result_t CC2420ControlM$HPLChipcon$FIFOPIntr(void);







static inline   result_t CC2420ControlM$HPLChipconRAM$writeDone(uint16_t addr, uint8_t length, uint8_t *buffer);
#line 413
static inline   result_t CC2420ControlM$CC2420Control$disableAddrDecode(void);
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420.nc"
static   result_t HPLCC2420M$HPLCC2420$FIFOPIntr(void);
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420RAM.nc"
static   result_t HPLCC2420M$HPLCC2420RAM$writeDone(uint16_t arg_0x1a7c6cc8, uint8_t arg_0x1a7c6e50, uint8_t *arg_0x1a7c4010);
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLCC2420M.nc"
 bool HPLCC2420M$bSpiAvail;
 uint8_t *HPLCC2420M$rambuf;
 uint8_t HPLCC2420M$ramlen;
 uint16_t HPLCC2420M$ramaddr;






static inline  result_t HPLCC2420M$StdControl$init(void);
#line 87
static inline  result_t HPLCC2420M$StdControl$start(void);
static inline  result_t HPLCC2420M$StdControl$stop(void);
#line 103
static   result_t HPLCC2420M$HPLCC2420$enableFIFOP(void);










static inline   result_t HPLCC2420M$HPLCC2420$disableFIFOP(void);







static   uint8_t HPLCC2420M$HPLCC2420$cmd(uint8_t addr);
#line 147
static   result_t HPLCC2420M$HPLCC2420$write(uint8_t addr, uint16_t data);
#line 178
static   uint16_t HPLCC2420M$HPLCC2420$read(uint8_t addr);
#line 202
void __vector_7(void)   __attribute((signal)) ;
#line 220
static inline  void HPLCC2420M$signalRAMWr(void);










static inline   result_t HPLCC2420M$HPLCC2420RAM$write(uint16_t addr, uint8_t length, uint8_t *buffer);
# 47 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLCC2420FIFOM.nc"
 bool HPLCC2420FIFOM$bSpiAvail;
 uint8_t *HPLCC2420FIFOM$txbuf;
#line 48
uint8_t *HPLCC2420FIFOM$rxbuf;
 uint8_t HPLCC2420FIFOM$txlength;
#line 49
 uint8_t HPLCC2420FIFOM$rxlength;
#line 71
static   result_t HPLCC2420FIFOM$HPLCC2420FIFO$writeTXFIFO(uint8_t len, uint8_t *msg);
#line 125
static   result_t HPLCC2420FIFOM$HPLCC2420FIFO$readRXFIFO(uint8_t len, uint8_t *msg);
# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\RandomLFSR.nc"
uint16_t RandomLFSR$shiftReg;
uint16_t RandomLFSR$initSeed;
uint16_t RandomLFSR$mask;


static   result_t RandomLFSR$Random$init(void);










static   uint16_t RandomLFSR$Random$rand(void);
# 19 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\PowerManagement.nc"
static   uint8_t TimerM$PowerManagement$adjustPower(void);
# 84 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Clock.nc"
static   void TimerM$Clock$setInterval(uint8_t arg_0x1a8d22d0);
#line 132
static   uint8_t TimerM$Clock$readCounter(void);
#line 75
static   result_t TimerM$Clock$setRate(char arg_0x1a8d84d8, char arg_0x1a8d8658);
#line 100
static   uint8_t TimerM$Clock$getInterval(void);
# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
static  result_t TimerM$Timer$fired(
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\TimerM.nc"
uint8_t arg_0x1a8b62b0);









uint32_t TimerM$mState;
uint8_t TimerM$setIntervalFlag;
uint8_t TimerM$mScale;
#line 38
uint8_t TimerM$mInterval;
int8_t TimerM$queue_head;
int8_t TimerM$queue_tail;
uint8_t TimerM$queue_size;
uint8_t TimerM$queue[NUM_TIMERS];
volatile uint16_t TimerM$interval_outstanding;





#line 45
struct TimerM$timer_s {
  uint8_t type;
  int32_t ticks;
  int32_t ticksLeft;
} TimerM$mTimerList[NUM_TIMERS];

enum TimerM$__nesc_unnamed4314 {
  TimerM$maxTimerInterval = 230
};
static  result_t TimerM$StdControl$init(void);









static inline  result_t TimerM$StdControl$start(void);










static  result_t TimerM$Timer$start(uint8_t id, char type, 
uint32_t interval);
#line 106
inline static void TimerM$adjustInterval(void);
#line 145
static  result_t TimerM$Timer$stop(uint8_t id);
#line 159
static inline   result_t TimerM$Timer$default$fired(uint8_t id);



static inline void TimerM$enqueue(uint8_t value);







static inline uint8_t TimerM$dequeue(void);









static inline  void TimerM$signalOneTimer(void);





static inline  void TimerM$HandleFire(void);
#line 230
static inline   result_t TimerM$Clock$fire(void);
# 159 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Clock.nc"
static   result_t HPLClock$Clock$fire(void);
# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\HPLClock.nc"
uint8_t HPLClock$set_flag;
uint8_t HPLClock$mscale;
#line 34
uint8_t HPLClock$nextScale;
#line 34
uint8_t HPLClock$minterval;
#line 66
static inline   void HPLClock$Clock$setInterval(uint8_t value);









static inline   uint8_t HPLClock$Clock$getInterval(void);
#line 113
static inline   uint8_t HPLClock$Clock$readCounter(void);
#line 128
static inline   result_t HPLClock$Clock$setRate(char interval, char scale);
#line 146
void __vector_15(void)   __attribute((interrupt)) ;
# 30 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\NoLeds.nc"
static inline   result_t NoLeds$Leds$init(void);
#line 42
static inline   result_t NoLeds$Leds$redToggle(void);



static inline   result_t NoLeds$Leds$greenOn(void);



static inline   result_t NoLeds$Leds$greenOff(void);



static inline   result_t NoLeds$Leds$greenToggle(void);



static inline   result_t NoLeds$Leds$yellowOn(void);



static inline   result_t NoLeds$Leds$yellowOff(void);
#line 74
static inline   result_t NoLeds$Leds$set(uint8_t value);
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLPowerManagementM.nc"
bool HPLPowerManagementM$disabled = TRUE;

enum HPLPowerManagementM$__nesc_unnamed4315 {
  HPLPowerManagementM$IDLE = 0, 
  HPLPowerManagementM$ADC_NR = 1 << 3, 
  HPLPowerManagementM$POWER_DOWN = 1 << 4, 
  HPLPowerManagementM$POWER_SAVE = (1 << 3) + (1 << 4), 
  HPLPowerManagementM$STANDBY = (1 << 2) + (1 << 4), 
  HPLPowerManagementM$EXT_STANDBY = (1 << 3) + (1 << 4) + (1 << 2)
};




static inline uint8_t HPLPowerManagementM$getPowerLevel(void);
#line 101
static inline  void HPLPowerManagementM$doAdjustment(void);
#line 121
static   uint8_t HPLPowerManagementM$PowerManagement$adjustPower(void);
#line 135
static inline  result_t HPLPowerManagementM$Enable(void);
# 40 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\TimerJiffyAsync.nc"
static   result_t TimerJiffyAsyncM$TimerJiffyAsync$fired(void);
# 19 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\PowerManagement.nc"
static   uint8_t TimerJiffyAsyncM$PowerManagement$adjustPower(void);
# 127 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Clock.nc"
static   result_t TimerJiffyAsyncM$Timer$setIntervalAndScale(uint8_t arg_0x1a8d01b8, uint8_t arg_0x1a8d0340);
#line 147
static   void TimerJiffyAsyncM$Timer$intDisable(void);
# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\TimerJiffyAsyncM.nc"
uint32_t TimerJiffyAsyncM$jiffy;
bool TimerJiffyAsyncM$bSet;
#line 73
static inline   result_t TimerJiffyAsyncM$Timer$fire(void);
#line 93
static   result_t TimerJiffyAsyncM$TimerJiffyAsync$setOneShot(uint32_t _jiffy);
#line 110
static inline   bool TimerJiffyAsyncM$TimerJiffyAsync$isSet(void);




static inline   result_t TimerJiffyAsyncM$TimerJiffyAsync$stop(void);
# 159 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Clock.nc"
static   result_t HPLTimer2$Timer2$fire(void);
# 52 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLTimer2.nc"
uint8_t HPLTimer2$set_flag;
uint8_t HPLTimer2$mscale;
#line 53
uint8_t HPLTimer2$nextScale;
#line 53
uint8_t HPLTimer2$minterval;
#line 114
static   result_t HPLTimer2$Timer2$setIntervalAndScale(uint8_t interval, uint8_t scale);
#line 162
static inline   void HPLTimer2$Timer2$intDisable(void);






void __vector_9(void)   __attribute((interrupt)) ;
# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\LedsC.nc"
uint8_t LedsC$ledsOn;

enum LedsC$__nesc_unnamed4316 {
  LedsC$RED_BIT = 1, 
  LedsC$GREEN_BIT = 2, 
  LedsC$YELLOW_BIT = 4
};
#line 50
static   result_t LedsC$Leds$redOn(void);








static   result_t LedsC$Leds$redOff(void);








static inline   result_t LedsC$Leds$redToggle(void);










static   result_t LedsC$Leds$greenOn(void);








static   result_t LedsC$Leds$greenOff(void);








static inline   result_t LedsC$Leds$greenToggle(void);










static   result_t LedsC$Leds$yellowOn(void);








static   result_t LedsC$Leds$yellowOff(void);








static inline   result_t LedsC$Leds$yellowToggle(void);
#line 145
static inline   result_t LedsC$Leds$set(uint8_t ledsNum);
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
static  TOS_MsgPtr FramerM$ReceiveMsg$receive(TOS_MsgPtr arg_0x1a581c80);
# 34 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ByteComm.nc"
static   result_t FramerM$ByteComm$txByte(uint8_t arg_0x1aa0a010);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t FramerM$ByteControl$init(void);






static  result_t FramerM$ByteControl$start(void);







static  result_t FramerM$ByteControl$stop(void);
# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BareSendMsg.nc"
static  result_t FramerM$BareSendMsg$sendDone(TOS_MsgPtr arg_0x1a5a1360, result_t arg_0x1a5a14f0);
# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\TokenReceiveMsg.nc"
static  TOS_MsgPtr FramerM$TokenReceiveMsg$receive(TOS_MsgPtr arg_0x1aa23068, uint8_t arg_0x1aa231f0);
# 54 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\FramerM.nc"
enum FramerM$__nesc_unnamed4317 {
  FramerM$HDLC_QUEUESIZE = 2, 

  FramerM$HDLC_MTU = sizeof(TOS_Msg ) - 5, 



  FramerM$HDLC_FLAG_BYTE = 0x7e, 
  FramerM$HDLC_CTLESC_BYTE = 0x7d, 
  FramerM$PROTO_ACK = 64, 
  FramerM$PROTO_PACKET_ACK = 65, 
  FramerM$PROTO_PACKET_NOACK = 66, 
  FramerM$PROTO_UNKNOWN = 255
};

enum FramerM$__nesc_unnamed4318 {
  FramerM$RXSTATE_NOSYNC, 
  FramerM$RXSTATE_PROTO, 
  FramerM$RXSTATE_TOKEN, 
  FramerM$RXSTATE_INFO, 
  FramerM$RXSTATE_ESC
};

enum FramerM$__nesc_unnamed4319 {
  FramerM$TXSTATE_IDLE, 
  FramerM$TXSTATE_PROTO, 
  FramerM$TXSTATE_INFO, 
  FramerM$TXSTATE_ESC, 
  FramerM$TXSTATE_FCS1, 
  FramerM$TXSTATE_FCS2, 
  FramerM$TXSTATE_ENDFLAG, 
  FramerM$TXSTATE_FINISH, 
  FramerM$TXSTATE_ERROR
};

enum FramerM$__nesc_unnamed4320 {
  FramerM$FLAGS_TOKENPEND = 0x2, 
  FramerM$FLAGS_DATAPEND = 0x4, 
  FramerM$FLAGS_UNKNOWN = 0x8
};

TOS_Msg FramerM$gMsgRcvBuf[FramerM$HDLC_QUEUESIZE];






#line 97
typedef struct FramerM$_MsgRcvEntry {
  uint8_t Proto;
  uint8_t Token;
  uint16_t Length;
  TOS_MsgPtr pMsg;
} FramerM$MsgRcvEntry_t;

FramerM$MsgRcvEntry_t FramerM$gMsgRcvTbl[FramerM$HDLC_QUEUESIZE];

uint8_t *FramerM$gpRxBuf;
uint8_t *FramerM$gpTxBuf;

uint8_t FramerM$gFlags;


 uint8_t FramerM$gTxState;
 uint8_t FramerM$gPrevTxState;
 uint8_t FramerM$gTxProto;
 uint16_t FramerM$gTxByteCnt;
 uint16_t FramerM$gTxLength;
 uint16_t FramerM$gTxRunningCRC;


uint8_t FramerM$gRxState;
uint8_t FramerM$gRxHeadIndex;
uint8_t FramerM$gRxTailIndex;
uint16_t FramerM$gRxByteCnt;

uint16_t FramerM$gRxRunningCRC;

TOS_MsgPtr FramerM$gpTxMsg;
uint8_t FramerM$gTxTokenBuf;
uint8_t FramerM$gTxUnknownBuf;
 uint8_t FramerM$gTxEscByte;

static  void FramerM$PacketSent(void);

static uint8_t FramerM$fRemapRxPos(uint8_t InPos);






static uint8_t FramerM$fRemapRxPos(uint8_t InPos);
#line 156
static result_t FramerM$StartTx(void);
#line 216
static inline  void FramerM$PacketUnknown(void);







static inline  void FramerM$PacketRcvd(void);
#line 263
static  void FramerM$PacketSent(void);
#line 285
static void FramerM$HDLCInitialize(void);
#line 308
static inline  result_t FramerM$StdControl$init(void);




static inline  result_t FramerM$StdControl$start(void);




static inline  result_t FramerM$StdControl$stop(void);




static inline  result_t FramerM$BareSendMsg$send(TOS_MsgPtr pMsg);
#line 345
static inline  result_t FramerM$TokenReceiveMsg$ReflectToken(uint8_t Token);
#line 365
static inline   result_t FramerM$ByteComm$rxByteReady(uint8_t data, bool error, uint16_t strength);
#line 497
static result_t FramerM$TxArbitraryByte(uint8_t inByte);
#line 510
static inline   result_t FramerM$ByteComm$txByteReady(bool LastByteSuccess);
#line 588
static inline   result_t FramerM$ByteComm$txDone(void);
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
static  TOS_MsgPtr FramerAckM$ReceiveCombined$receive(TOS_MsgPtr arg_0x1a581c80);
# 59 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\TokenReceiveMsg.nc"
static  result_t FramerAckM$TokenReceiveMsg$ReflectToken(uint8_t arg_0x1aa23a68);
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\FramerAckM.nc"
uint8_t FramerAckM$gTokenBuf;

static inline  void FramerAckM$SendAckTask(void);




static inline  TOS_MsgPtr FramerAckM$TokenReceiveMsg$receive(TOS_MsgPtr Msg, uint8_t token);
#line 56
static inline  TOS_MsgPtr FramerAckM$ReceiveMsg$receive(TOS_MsgPtr Msg);
# 40 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLUART.nc"
static   result_t UARTM$HPLUART$init(void);
#line 58
static   result_t UARTM$HPLUART$put(uint8_t arg_0x1aaaa610);
#line 48
static   result_t UARTM$HPLUART$stop(void);
# 62 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ByteComm.nc"
static   result_t UARTM$ByteComm$txDone(void);
#line 54
static   result_t UARTM$ByteComm$txByteReady(bool arg_0x1aa08200);
#line 45
static   result_t UARTM$ByteComm$rxByteReady(uint8_t arg_0x1aa0a708, bool arg_0x1aa0a890, uint16_t arg_0x1aa0aa28);
# 38 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\UARTM.nc"
bool UARTM$state;

static inline  result_t UARTM$Control$init(void);







static inline  result_t UARTM$Control$start(void);



static inline  result_t UARTM$Control$stop(void);




static inline   result_t UARTM$HPLUART$get(uint8_t data);









static inline   result_t UARTM$HPLUART$putDone(void);
#line 90
static   result_t UARTM$ByteComm$txByte(uint8_t data);
# 66 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLUART.nc"
static   result_t HPLUART0M$UART$get(uint8_t arg_0x1aaaad48);







static   result_t HPLUART0M$UART$putDone(void);
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\HPLUART0M.nc"
static inline   result_t HPLUART0M$Setbaud(uint32_t baud_rate);
#line 87
static inline   result_t HPLUART0M$UART$init(void);





static inline   result_t HPLUART0M$UART$stop(void);








void __vector_18(void)   __attribute((signal)) ;









void __vector_20(void)   __attribute((interrupt)) ;




static inline   result_t HPLUART0M$UART$put(uint8_t data);
# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\NoCRCPacket.nc"
enum NoCRCPacket$__nesc_unnamed4321 {
  NoCRCPacket$IDLE, 
  NoCRCPacket$PACKET, 
  NoCRCPacket$BYTES
};
# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
 void XMeshC$BoundaryI$set_nbrtbl_childLiveliness(uint8_t arg_0x1ab92960, uint8_t arg_0x1ab92ae8);
#line 51
 void XMeshC$BoundaryI$new_nbrtbl_entry(uint8_t arg_0x1ab94b38, uint16_t arg_0x1ab94cc8);



 void XMeshC$BoundaryI$set_nbrtbl_cost(uint8_t arg_0x1ab92330, uint16_t arg_0x1ab924c0);
#line 40
 uint16_t XMeshC$BoundaryI$get_nbrtbl_parent(uint8_t arg_0x1ab98660);
#line 31
 void XMeshC$BoundaryI$set_tos_cc_channel(uint8_t arg_0x1ab9a010);
#line 85
 TOS_MsgPtr XMeshC$BoundaryI$get_fwd_buf_ptr(uint8_t arg_0x1aba4648);
#line 65
 uint8_t XMeshC$BoundaryI$get_nbrtbl_size(void);
#line 22
 uint8_t XMeshC$BoundaryI$get_tos_data_length(void);
#line 60
 void XMeshC$BoundaryI$set_nbrtbl_flags(uint8_t arg_0x1abac338, uint8_t arg_0x1abac4c0);
#line 58
 void XMeshC$BoundaryI$set_nbrtbl_received(uint8_t arg_0x1ab90638, uint16_t arg_0x1ab907c8);
#line 75
 void XMeshC$BoundaryI$set_dsctbl_from(uint8_t arg_0x1aba6330, uint16_t arg_0x1aba64c0);
#line 32
 uint8_t XMeshC$BoundaryI$get_tos_cc_channel(void);
#line 59
 void XMeshC$BoundaryI$set_nbrtbl_lastSeqno(uint8_t arg_0x1ab90c60, uint16_t arg_0x1ab90df0);
#line 57
 void XMeshC$BoundaryI$set_nbrtbl_missed(uint8_t arg_0x1ab90010, uint16_t arg_0x1ab901a0);
#line 23
 uint8_t XMeshC$BoundaryI$get_power_model(void);

 uint8_t XMeshC$BoundaryI$get_nbr_advert_threshold(void);







 void XMeshC$BoundaryI$set_tos_cc_txpower(uint8_t arg_0x1ab9a828);







 uint16_t XMeshC$BoundaryI$get_nbrtbl_cost(uint8_t arg_0x1ab98af8);
#line 66
 TableEntry *XMeshC$BoundaryI$get_nbrtbl_addr(uint8_t arg_0x1aba9640);






 uint16_t XMeshC$BoundaryI$get_dsctbl_from(uint8_t arg_0x1aba87e0);
 void XMeshC$BoundaryI$set_dsctbl_origin(uint8_t arg_0x1aba8c70, uint16_t arg_0x1aba8e00);
#line 48
 uint8_t XMeshC$BoundaryI$get_nbrtbl_hop(uint8_t arg_0x1ab96d68);
#line 47
 uint8_t XMeshC$BoundaryI$get_nbrtbl_liveliness(uint8_t arg_0x1ab967d8);
#line 19
 TOS_MsgPtr XMeshC$BoundaryI$xalloc(uint8_t arg_0x1ab814d8);
#line 49
 uint8_t XMeshC$BoundaryI$get_nbrtbl_receiveEst(uint8_t arg_0x1ab94210);
#line 34
 uint8_t XMeshC$BoundaryI$get_tos_cc_txpower(void);
#line 61
 void XMeshC$BoundaryI$set_nbrtbl_liveliness(uint8_t arg_0x1abac958, uint8_t arg_0x1abacae0);
#line 44
 uint16_t XMeshC$BoundaryI$get_nbrtbl_received(uint8_t arg_0x1ab97950);
#line 63
 void XMeshC$BoundaryI$set_nbrtbl_receiveEst(uint8_t arg_0x1abab630, uint8_t arg_0x1abab7b8);
#line 83
 void XMeshC$BoundaryI$set_fwd_buf_status(uint8_t arg_0x1aba5cc8, uint8_t arg_0x1aba5e50);
#line 43
 uint16_t XMeshC$BoundaryI$get_nbrtbl_missed(uint8_t arg_0x1ab974b0);
#line 20
 void *XMeshC$BoundaryI$get_strength(TOS_MsgPtr arg_0x1ab819d0);





 uint32_t XMeshC$BoundaryI$get_route_update_interval(void);
#line 39
 uint16_t XMeshC$BoundaryI$get_nbrtbl_id(uint8_t arg_0x1ab98188);


 uint8_t XMeshC$BoundaryI$get_nbrtbl_childLiveliness(uint8_t arg_0x1ab97010);
#line 28
 uint8_t XMeshC$BoundaryI$get_max_retry(void);
#line 71
 uint8_t XMeshC$BoundaryI$find_dsctbl_entry(uint16_t arg_0x1aba9ca0, uint8_t arg_0x1aba9e28);
#line 46
 uint8_t XMeshC$BoundaryI$get_nbrtbl_flags(uint8_t arg_0x1ab96340);
#line 76
 DescendantTbl *XMeshC$BoundaryI$get_dsctbl_addr(uint8_t arg_0x1aba6b60);
#line 30
 bool XMeshC$BoundaryI$set_built_from_factory(void);
#line 29
 uint8_t XMeshC$BoundaryI$get_descendant_table_size(void);
#line 62
 void XMeshC$BoundaryI$set_nbrtbl_hop(uint8_t arg_0x1abab010, uint8_t arg_0x1abab198);

 void XMeshC$BoundaryI$set_nbrtbl_sendEst(uint8_t arg_0x1ababc50, uint8_t arg_0x1ababdd8);
#line 24
 uint8_t XMeshC$BoundaryI$get_platform(void);
#line 21
 uint8_t XMeshC$BoundaryI$get_ack(TOS_MsgPtr arg_0x1ab81e80);
#line 54
 void XMeshC$BoundaryI$set_nbrtbl_parent(uint8_t arg_0x1ab93c40, uint16_t arg_0x1ab93dd0);
#line 82
 uint8_t XMeshC$BoundaryI$get_fwd_buf_status(uint8_t arg_0x1aba5838);
#line 45
 uint16_t XMeshC$BoundaryI$get_nbrtbl_lastSeqno(uint8_t arg_0x1ab97df0);




 uint8_t XMeshC$BoundaryI$get_nbrtbl_sendEst(uint8_t arg_0x1ab946a8);
#line 27
 uint8_t XMeshC$BoundaryI$get_route_table_size(void);
#line 53
 void XMeshC$BoundaryI$set_nbrtbl_id(uint8_t arg_0x1ab93618, uint16_t arg_0x1ab937a8);
#line 72
 uint16_t XMeshC$BoundaryI$get_dsctbl_origin(uint8_t arg_0x1aba8348);








 void XMeshC$BoundaryI$set_fwd_buf_ptr(uint8_t arg_0x1aba51d0, TOS_MsgPtr arg_0x1aba5360);
#line 52
 uint8_t XMeshC$BoundaryI$find_nbrtbl_entry(uint16_t arg_0x1ab93190);
#line 84
 uint8_t XMeshC$BoundaryI$get_fwd_buf_size(void);
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
 result_t XMeshC$ElpTimer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500);








 result_t XMeshC$ElpTimer$stop(void);
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Intercept.nc"
 result_t XMeshC$Intercept$intercept(
# 16 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\XMeshC.nc"
uint8_t arg_0x1ab7aab8, 
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Intercept.nc"
TOS_MsgPtr arg_0x1ab5a010, void *arg_0x1ab5a1b0, uint16_t arg_0x1ab5a348);
#line 65
 result_t XMeshC$Snoop$intercept(
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\XMeshC.nc"
uint8_t arg_0x1ab780b0, 
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Intercept.nc"
TOS_MsgPtr arg_0x1ab5a010, void *arg_0x1ab5a1b0, uint16_t arg_0x1ab5a348);
# 42 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Random.nc"
  uint16_t XMeshC$Random$rand(void);
#line 36
  result_t XMeshC$Random$init(void);
# 68 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Send.nc"
 result_t XMeshC$Send$sendDone(
# 13 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\XMeshC.nc"
uint8_t arg_0x1ab7b780, 
# 68 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Send.nc"
TOS_MsgPtr arg_0x1ab46908, result_t arg_0x1ab46a98);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
 result_t XMeshC$BattControl$init(void);






 result_t XMeshC$BattControl$start(void);







 result_t XMeshC$BattControl$stop(void);
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\XOtapLoader.nc"
 result_t XMeshC$XOtapLoader$boot_request(uint8_t arg_0x1ab65920);
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
 result_t XMeshC$EwmaTimer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500);








 result_t XMeshC$EwmaTimer$stop(void);
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
 TOS_MsgPtr XMeshC$Receive$receive(
# 14 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\XMeshC.nc"
uint8_t arg_0x1ab7bef0, 
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
TOS_MsgPtr arg_0x1ab42878, void *arg_0x1ab42a18, uint16_t arg_0x1ab42bb0);
# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
 result_t XMeshC$MhopSend$sendDone(
# 12 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\XMeshC.nc"
uint8_t arg_0x1ab7b010, 
# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
TOS_MsgPtr arg_0x1ab4a408, result_t arg_0x1ab4a598);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
 result_t XMeshC$GCStdControl$init(void);






 result_t XMeshC$GCStdControl$start(void);







 result_t XMeshC$GCStdControl$stop(void);
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
 result_t XMeshC$Window$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500);








 result_t XMeshC$Window$stop(void);
# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\RadioPower.nc"
 result_t XMeshC$RadioPower$SetListeningMode(uint8_t arg_0x1a642378);
 result_t XMeshC$RadioPower$SetTransmitMode(uint8_t arg_0x1a642810);
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
 result_t XMeshC$ElpTimeOut$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500);








 result_t XMeshC$ElpTimeOut$stop(void);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
 result_t XMeshC$SendMsg$send(
# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\XMeshC.nc"
uint8_t arg_0x1ab74010, 
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
uint16_t arg_0x1a583670, uint8_t arg_0x1a5837f8, TOS_MsgPtr arg_0x1a583988);
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
 result_t XMeshC$HealthTimer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500);








 result_t XMeshC$HealthTimer$stop(void);
#line 37
 result_t XMeshC$EngineTimer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500);








 result_t XMeshC$EngineTimer$stop(void);
#line 37
 result_t XMeshC$XOtapTimer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500);








 result_t XMeshC$XOtapTimer$stop(void);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
 result_t XMeshC$QueueStdControl$init(void);






 result_t XMeshC$QueueStdControl$start(void);







 result_t XMeshC$QueueStdControl$stop(void);
# 49 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\CommControl.nc"
 bool XMeshC$GCCommControl$getPromiscuous(void);
#line 29
 result_t XMeshC$GCCommControl$setCRCCheck(bool arg_0x1a550210);




 bool XMeshC$GCCommControl$getCRCCheck(void);









 result_t XMeshC$GCCommControl$setPromiscuous(bool arg_0x1a550e60);
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
 TOS_MsgPtr XMeshC$ReceiveAck$receive(
# 15 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\XMeshC.nc"
uint8_t arg_0x1ab7a500, 
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
TOS_MsgPtr arg_0x1ab42878, void *arg_0x1ab42a18, uint16_t arg_0x1ab42bb0);
# 30 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
  result_t XMeshC$Batt$getData(void);






  result_t XMeshC$Batt$getContinuousData(void);
# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ElpI.nc"
 result_t XMeshC$ElpI$wake_done(result_t arg_0x1ab55a30);
#line 46
 result_t XMeshC$ElpI$route_discover_done(result_t arg_0x1ab547e8, uint16_t arg_0x1ab54978);
#line 25
 result_t XMeshC$ElpI$sleep_done(result_t arg_0x1ab55208);
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
static  result_t ShimLayerM$MhopSendActual$send(
# 25 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abb5c00, 
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
uint16_t arg_0x1ab219b8, uint8_t arg_0x1ab21b40, TOS_MsgPtr arg_0x1ab21cd0, uint16_t arg_0x1ab21e60);
#line 88
static  void *ShimLayerM$MhopSendActual$getBuffer(
# 25 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abb5c00, 
# 88 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
TOS_MsgPtr arg_0x1ab4b7c0, uint16_t *arg_0x1ab4b970);
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Intercept.nc"
static  result_t ShimLayerM$Intercept$intercept(
# 13 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abbac00, 
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Intercept.nc"
TOS_MsgPtr arg_0x1ab5a010, void *arg_0x1ab5a1b0, uint16_t arg_0x1ab5a348);
#line 65
static  result_t ShimLayerM$Snoop$intercept(
# 14 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abb8208, 
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Intercept.nc"
TOS_MsgPtr arg_0x1ab5a010, void *arg_0x1ab5a1b0, uint16_t arg_0x1ab5a348);
# 68 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Send.nc"
static  result_t ShimLayerM$Send$sendDone(
# 16 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abb7010, 
# 68 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Send.nc"
TOS_MsgPtr arg_0x1ab46908, result_t arg_0x1ab46a98);
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\XOtapLoader.nc"
static  result_t ShimLayerM$XOtapLoaderActual$boot(uint8_t arg_0x1ab640b0);
#line 17
static  result_t ShimLayerM$XOtapLoader$boot_request(uint8_t arg_0x1ab65920);
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
static  TOS_MsgPtr ShimLayerM$Receive$receive(
# 11 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abba068, 
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
TOS_MsgPtr arg_0x1ab42878, void *arg_0x1ab42a18, uint16_t arg_0x1ab42bb0);
# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
static  result_t ShimLayerM$MhopSend$sendDone(
# 15 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abb87c0, 
# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
TOS_MsgPtr arg_0x1ab4a408, result_t arg_0x1ab4a598);
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
static  TOS_MsgPtr ShimLayerM$ReceiveAck$receive(
# 12 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
uint8_t arg_0x1abba648, 
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
TOS_MsgPtr arg_0x1ab42878, void *arg_0x1ab42a18, uint16_t arg_0x1ab42bb0);
# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ElpI.nc"
static  result_t ShimLayerM$ElpI$wake_done(result_t arg_0x1ab55a30);
#line 46
static  result_t ShimLayerM$ElpI$route_discover_done(result_t arg_0x1ab547e8, uint16_t arg_0x1ab54978);
#line 25
static  result_t ShimLayerM$ElpI$sleep_done(result_t arg_0x1ab55208);
# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline  TOS_MsgPtr ShimLayerM$ReceiveActual$receive(uint8_t socket, TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen);



static inline   TOS_MsgPtr ShimLayerM$Receive$default$receive(uint8_t socket, TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen);


static inline  TOS_MsgPtr ShimLayerM$ReceiveAckActual$receive(uint8_t socket, TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen);



static inline   TOS_MsgPtr ShimLayerM$ReceiveAck$default$receive(uint8_t socket, TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen);


static inline  result_t ShimLayerM$InterceptActual$intercept(uint8_t socket, TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen);



static inline   result_t ShimLayerM$Intercept$default$intercept(uint8_t socket, TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen);


static inline  result_t ShimLayerM$SnoopActual$intercept(uint8_t socket, TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen);



static inline   result_t ShimLayerM$Snoop$default$intercept(uint8_t socket, TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen);










static inline  result_t ShimLayerM$SendActual$sendDone(uint8_t socket, TOS_MsgPtr pMsg, result_t success);



static inline   result_t ShimLayerM$Send$default$sendDone(uint8_t socket, TOS_MsgPtr pMsg, result_t success);



static inline  result_t ShimLayerM$MhopSend$send(uint8_t socket, uint16_t dest, uint8_t mode, TOS_MsgPtr pMsg, uint16_t PayloadLen);



static inline  void *ShimLayerM$MhopSend$getBuffer(uint8_t id, TOS_MsgPtr pMsg, uint16_t *length);




static inline  result_t ShimLayerM$MhopSendActual$sendDone(uint8_t socket, TOS_MsgPtr pMsg, result_t success);




static inline   result_t ShimLayerM$MhopSend$default$sendDone(uint8_t socket, TOS_MsgPtr pMsg, result_t success);
#line 109
static inline  result_t ShimLayerM$ElpIActual$sleep_done(result_t status);




static inline   result_t ShimLayerM$ElpI$default$sleep_done(result_t status);




static inline  result_t ShimLayerM$ElpIActual$route_discover_done(result_t success, uint16_t pID);





static inline   result_t ShimLayerM$ElpI$default$route_discover_done(result_t success, uint16_t pID);



static inline  result_t ShimLayerM$ElpIActual$wake_done(result_t status);





static inline   result_t ShimLayerM$ElpI$default$wake_done(result_t status);




static inline  result_t ShimLayerM$XOtapLoader$boot(uint8_t id);



static inline  result_t ShimLayerM$XOtapLoaderActual$boot_request(uint8_t imgID);



static inline   result_t ShimLayerM$XOtapLoader$default$boot_request(uint8_t imgID);
# 127 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420Control.nc"
static  result_t BoundaryM$CC2420Control$SetRFPower(uint8_t arg_0x1a664d48);
#line 52
static  result_t BoundaryM$CC2420Control$TunePreset(uint8_t arg_0x1a6516c8);
# 50 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
TableEntry BoundaryM$NeighborTbl[ROUTE_TABLE_SIZE];
DescendantTbl BoundaryM$DscTbl[DESCENDANT_TABLE_SIZE];
TOS_Msg BoundaryM$gTOSBuffer[FWD_QUEUE_SIZE + 5];
TOS_MsgPtr BoundaryM$FwdBufList[FWD_QUEUE_SIZE];
uint8_t BoundaryM$FwdBufStatus[FWD_QUEUE_SIZE];

static inline  TOS_MsgPtr BoundaryM$BoundaryI$xalloc(uint8_t iIndex);


static inline  uint8_t BoundaryM$BoundaryI$get_tos_data_length(void);


static inline  uint8_t BoundaryM$BoundaryI$get_route_table_size(void);


static inline  uint8_t BoundaryM$BoundaryI$get_descendant_table_size(void);


static inline  uint32_t BoundaryM$BoundaryI$get_route_update_interval(void);


static inline  uint8_t BoundaryM$BoundaryI$get_power_model(void);










static inline  uint8_t BoundaryM$BoundaryI$get_platform(void);









static inline  void *BoundaryM$BoundaryI$get_strength(TOS_MsgPtr pMsg);


static inline  uint8_t BoundaryM$BoundaryI$get_ack(TOS_MsgPtr pMsg);


static inline  uint8_t BoundaryM$BoundaryI$get_nbr_advert_threshold(void);


static inline  bool BoundaryM$BoundaryI$set_built_from_factory(void);






static inline  uint8_t BoundaryM$BoundaryI$get_tos_cc_txpower(void);
#line 124
static inline  void BoundaryM$BoundaryI$set_tos_cc_txpower(uint8_t power);
#line 141
static inline  uint8_t BoundaryM$BoundaryI$get_tos_cc_channel(void);
#line 156
static inline  void BoundaryM$BoundaryI$set_tos_cc_channel(uint8_t channel);
#line 175
static inline  uint16_t BoundaryM$BoundaryI$get_nbrtbl_id(uint8_t iIndex);


static inline  uint16_t BoundaryM$BoundaryI$get_nbrtbl_parent(uint8_t iIndex);


static inline  uint16_t BoundaryM$BoundaryI$get_nbrtbl_cost(uint8_t iIndex);


static inline  uint8_t BoundaryM$BoundaryI$get_nbrtbl_childLiveliness(uint8_t iIndex);


static inline  uint16_t BoundaryM$BoundaryI$get_nbrtbl_missed(uint8_t iIndex);


static inline  uint16_t BoundaryM$BoundaryI$get_nbrtbl_received(uint8_t iIndex);


static inline  uint16_t BoundaryM$BoundaryI$get_nbrtbl_lastSeqno(uint8_t iIndex);


static inline  uint8_t BoundaryM$BoundaryI$get_nbrtbl_flags(uint8_t iIndex);


static inline  uint8_t BoundaryM$BoundaryI$get_nbrtbl_liveliness(uint8_t iIndex);


static inline  uint8_t BoundaryM$BoundaryI$get_nbrtbl_hop(uint8_t iIndex);


static inline  uint8_t BoundaryM$BoundaryI$get_nbrtbl_receiveEst(uint8_t iIndex);


static inline  uint8_t BoundaryM$BoundaryI$get_nbrtbl_sendEst(uint8_t iIndex);




static inline  void BoundaryM$BoundaryI$new_nbrtbl_entry(uint8_t iIndex, uint16_t nodeid);
#line 227
static inline  uint8_t BoundaryM$BoundaryI$find_nbrtbl_entry(uint16_t id);
#line 240
static inline  uint8_t BoundaryM$BoundaryI$find_dsctbl_entry(uint16_t id, uint8_t size);









static inline  void BoundaryM$BoundaryI$set_nbrtbl_id(uint8_t iIndex, uint16_t value);


static inline  void BoundaryM$BoundaryI$set_nbrtbl_parent(uint8_t iIndex, uint16_t value);


static inline  void BoundaryM$BoundaryI$set_nbrtbl_cost(uint8_t iIndex, uint16_t value);


static inline  void BoundaryM$BoundaryI$set_nbrtbl_childLiveliness(uint8_t iIndex, uint8_t value);


static inline  void BoundaryM$BoundaryI$set_nbrtbl_missed(uint8_t iIndex, uint16_t value);


static inline  void BoundaryM$BoundaryI$set_nbrtbl_received(uint8_t iIndex, uint16_t value);


static inline  void BoundaryM$BoundaryI$set_nbrtbl_lastSeqno(uint8_t iIndex, uint16_t value);


static inline  void BoundaryM$BoundaryI$set_nbrtbl_flags(uint8_t iIndex, uint8_t value);


static inline  void BoundaryM$BoundaryI$set_nbrtbl_liveliness(uint8_t iIndex, uint8_t value);


static inline  void BoundaryM$BoundaryI$set_nbrtbl_hop(uint8_t iIndex, uint8_t value);


static inline  void BoundaryM$BoundaryI$set_nbrtbl_receiveEst(uint8_t iIndex, uint8_t value);


static inline  void BoundaryM$BoundaryI$set_nbrtbl_sendEst(uint8_t iIndex, uint8_t value);


static inline  TableEntry *BoundaryM$BoundaryI$get_nbrtbl_addr(uint8_t iIndex);


static inline  uint8_t BoundaryM$BoundaryI$get_nbrtbl_size(void);



static inline  uint16_t BoundaryM$BoundaryI$get_dsctbl_origin(uint8_t iIndex);


static inline  uint16_t BoundaryM$BoundaryI$get_dsctbl_from(uint8_t iIndex);


static inline  void BoundaryM$BoundaryI$set_dsctbl_origin(uint8_t iIndex, uint16_t value);


static inline  void BoundaryM$BoundaryI$set_dsctbl_from(uint8_t iIndex, uint16_t value);


static inline  DescendantTbl *BoundaryM$BoundaryI$get_dsctbl_addr(uint8_t iIndex);



static inline  TOS_MsgPtr BoundaryM$BoundaryI$get_fwd_buf_ptr(uint8_t iIndex);


static inline  void BoundaryM$BoundaryI$set_fwd_buf_ptr(uint8_t iIndex, TOS_MsgPtr pMsg);


static inline  uint8_t BoundaryM$BoundaryI$get_fwd_buf_status(uint8_t iIndex);





static inline  void BoundaryM$BoundaryI$set_fwd_buf_status(uint8_t iIndex, uint8_t status);


static inline  uint8_t BoundaryM$BoundaryI$get_fwd_buf_size(void);


static inline  uint8_t BoundaryM$BoundaryI$get_max_retry(void);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
static  result_t QueuedSendM$QueueSendMsg$sendDone(
# 38 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Queue\\QueuedSendM.nc"
uint8_t arg_0x1ac5b210, 
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
TOS_MsgPtr arg_0x1a583e38, result_t arg_0x1a561010);
# 85 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
static   result_t QueuedSendM$Leds$greenToggle(void);
#line 60
static   result_t QueuedSendM$Leds$redToggle(void);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
static  result_t QueuedSendM$SerialSendMsg$send(
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Queue\\QueuedSendM.nc"
uint8_t arg_0x1ac5bd18, 
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
uint16_t arg_0x1a583670, uint8_t arg_0x1a5837f8, TOS_MsgPtr arg_0x1a583988);
# 52 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Queue\\QueuedSendM.nc"
enum QueuedSendM$__nesc_unnamed4322 {
  QueuedSendM$MESSAGE_QUEUE_SIZE = 32, 
  QueuedSendM$MAX_RETRANSMIT_COUNT = 5
};







#line 57
struct QueuedSendM$_msgq_entry {
  uint16_t address;
  uint8_t length;
  uint8_t id;
  uint8_t xmit_count;
  TOS_MsgPtr pMsg;
} QueuedSendM$msgqueue[QueuedSendM$MESSAGE_QUEUE_SIZE];

uint16_t QueuedSendM$enqueue_next;
#line 65
uint16_t QueuedSendM$dequeue_next;
bool QueuedSendM$retransmit;
bool QueuedSendM$fQueueIdle;

static  result_t QueuedSendM$StdControl$init(void);
#line 84
static inline  result_t QueuedSendM$StdControl$start(void);


static inline  result_t QueuedSendM$StdControl$stop(void);
#line 99
static  void QueuedSendM$QueueServiceTask(void);
#line 121
static  result_t QueuedSendM$QueueSendMsg$send(uint8_t id, uint16_t address, uint8_t length, TOS_MsgPtr msg);
#line 164
static inline  result_t QueuedSendM$SerialSendMsg$sendDone(uint8_t id, TOS_MsgPtr msg, result_t success);
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCControl.nc"
static  result_t VoltageM$ADCControl$bindPort(uint8_t arg_0x1ac8c2c8, uint8_t arg_0x1ac8c450);
#line 26
static  result_t VoltageM$ADCControl$init(void);
# 29 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\VoltageM.nc"
static inline  result_t VoltageM$StdControl$init(void);




static inline  result_t VoltageM$StdControl$start(void);







static inline  result_t VoltageM$StdControl$stop(void);
# 49 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLADC.nc"
static   result_t ADCREFM$HPLADC$bindPort(uint8_t arg_0x1ac9aec8, uint8_t arg_0x1ac99068);
#line 33
static   result_t ADCREFM$HPLADC$init(void);
#line 56
static   result_t ADCREFM$HPLADC$samplePort(uint8_t arg_0x1ac99778);
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
static   result_t ADCREFM$CalADC$dataReady(
# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCREFM.nc"
uint8_t arg_0x1ac801b0, 
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
uint16_t arg_0x1ab86808);
#line 48
static   result_t ADCREFM$ADC$dataReady(
# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCREFM.nc"
uint8_t arg_0x1ac819f8, 
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
uint16_t arg_0x1ab86808);
# 59 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCREFM.nc"
enum ADCREFM$__nesc_unnamed4323 {
  ADCREFM$IDLE = 0, 
  ADCREFM$SINGLE_CONVERSION = 1, 
  ADCREFM$CONTINUOUS_CONVERSION = 2
};

uint16_t ADCREFM$ReqPort;
uint16_t ADCREFM$ReqVector;
uint16_t ADCREFM$ContReqMask;
uint16_t ADCREFM$CalReqMask;
uint32_t ADCREFM$RefVal;

static inline  void ADCREFM$CalTask(void);






static  result_t ADCREFM$ADCControl$init(void);
#line 93
static inline  result_t ADCREFM$ADCControl$bindPort(uint8_t port, uint8_t adcPort);



static inline    result_t ADCREFM$ADC$default$dataReady(uint8_t port, uint16_t data);



static inline    result_t ADCREFM$CalADC$default$dataReady(uint8_t port, uint16_t data);



static inline  result_t ADCREFM$Timer$fired(void);






static inline   result_t ADCREFM$HPLADC$dataReady(uint16_t data);
#line 177
static result_t ADCREFM$startGet(uint8_t port);
#line 201
static   result_t ADCREFM$ADC$getData(uint8_t port);
#line 229
static inline   result_t ADCREFM$ADC$getContinuousData(uint8_t port);
#line 263
static inline   result_t ADCREFM$ADCControl$manualCalibrate(void);
# 78 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLADC.nc"
static   result_t HPLADCM$ADC$dataReady(uint16_t arg_0x1ac988f8);
# 55 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLADCM.nc"
bool HPLADCM$init_portmap_done;
uint8_t HPLADCM$TOSH_adc_portmap[TOSH_ADC_PORTMAPSIZE];

static void HPLADCM$init_portmap(void);
#line 85
static inline   result_t HPLADCM$ADC$init(void);
#line 105
static   result_t HPLADCM$ADC$bindPort(uint8_t port, uint8_t adcPort);
#line 117
static   result_t HPLADCM$ADC$samplePort(uint8_t port);
#line 139
void __vector_21(void)   __attribute((signal)) ;
# 140 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\apps\\xmesh\\XMDA300\\XMDA300M.nc"
static  void XMDA300M$health_packet(bool arg_0x1ad1f618, uint16_t arg_0x1ad1f7a8);
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Relay.nc"
static  result_t XMDA300M$relay_normally_closed$toggle(void);
#line 20
static  result_t XMDA300M$relay_normally_closed$open(void);
static  result_t XMDA300M$relay_normally_closed$close(void);
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
static  result_t XMDA300M$Send$send(uint16_t arg_0x1ab219b8, uint8_t arg_0x1ab21b40, TOS_MsgPtr arg_0x1ab21cd0, uint16_t arg_0x1ab21e60);
#line 88
static  void *XMDA300M$Send$getBuffer(TOS_MsgPtr arg_0x1ab4b7c0, uint16_t *arg_0x1ab4b970);
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Relay.nc"
static  result_t XMDA300M$relay_normally_open$toggle(void);
#line 20
static  result_t XMDA300M$relay_normally_open$open(void);
static  result_t XMDA300M$relay_normally_open$close(void);
# 24 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Sample.nc"
static  result_t XMDA300M$Sample$sampleNow(void);
#line 19
static  int8_t XMDA300M$Sample$getSample(uint8_t arg_0x1ad07e70, uint8_t arg_0x1ad03030, uint16_t arg_0x1ad031c8, uint8_t arg_0x1ad03350);



static  result_t XMDA300M$Sample$stop(int8_t arg_0x1ad01c70);
# 133 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\apps\\xmesh\\XMDA300\\XMDA300M.nc"
static  result_t XMDA300M$PlugPlay(void);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t XMDA300M$SamplerControl$init(void);






static  result_t XMDA300M$SamplerControl$start(void);







static  result_t XMDA300M$SamplerControl$stop(void);
# 141 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\apps\\xmesh\\XMDA300\\XMDA300M.nc"
static  HealthMsg *XMDA300M$HealthMsgGet(void);
# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
static   result_t XMDA300M$Leds$yellowOff(void);
#line 93
static   result_t XMDA300M$Leds$yellowOn(void);
#line 35
static   result_t XMDA300M$Leds$init(void);
#line 76
static   result_t XMDA300M$Leds$greenOff(void);
#line 128
static   result_t XMDA300M$Leds$set(uint8_t arg_0x1a5b5a40);
#line 68
static   result_t XMDA300M$Leds$greenOn(void);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\RouteControl.nc"
static  uint16_t XMDA300M$RouteControl$getParent(void);
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
static  result_t XMDA300M$Timer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500);








static  result_t XMDA300M$Timer$stop(void);
# 161 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\apps\\xmesh\\XMDA300\\XMDA300M.nc"
enum XMDA300M$__nesc_unnamed4324 {
  XMDA300M$PENDING = 0, 
  XMDA300M$NO_MSG = 1
};

enum XMDA300M$__nesc_unnamed4325 {
  XMDA300M$MDA300_PACKET1 = 1, 
  XMDA300M$MDA300_PACKET2 = 2, 
  XMDA300M$MDA300_PACKET3 = 3, 
  XMDA300M$MDA300_PACKET4 = 4, 
  XMDA300M$MDA300_ERR_PACKET = 0xf8
};
#line 185
bool XMDA300M$sleeping;
bool XMDA300M$sending_packet;

XDataMsg *XMDA300M$tmppack;

TOS_Msg XMDA300M$packet;
TOS_Msg XMDA300M$msg_send_buffer;
TOS_MsgPtr XMDA300M$msg_ptr;
HealthMsg *XMDA300M$h_msg;

bool XMDA300M$bBoardOn = TRUE;

uint16_t XMDA300M$msg_status;
#line 197
uint16_t XMDA300M$pkt_full;
char XMDA300M$test;
uint8_t XMDA300M$samplebatt = 0;

int8_t XMDA300M$record[25];
static  void XMDA300M$send_radio_msg(void);
static void XMDA300M$initialize(void);
#line 221
inline static void XMDA300M$start(void);
#line 303
static inline  result_t XMDA300M$StdControl$init(void);
#line 334
static inline  result_t XMDA300M$StdControl$start(void);
#line 349
static  result_t XMDA300M$StdControl$stop(void);
#line 369
static  void XMDA300M$send_radio_msg(void);
#line 460
static  result_t XMDA300M$Send$sendDone(TOS_MsgPtr msg, result_t success);
#line 485
static  
#line 484
result_t 
XMDA300M$Sample$dataReady(uint8_t channel, uint8_t channelType, uint16_t data);
#line 595
static inline  result_t XMDA300M$Timer$fired(void);
#line 623
static inline  result_t XMDA300M$XCommand$received(XCommandOp *opcode);
#line 724
static  result_t XMDA300M$XEEControl$restoreDone(result_t result);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt16.nc"
static  uint16_t RecoverParamsM$ConfigInt16$get(
# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
AppParamID_t arg_0x1ad5d010);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt16.nc"
static  result_t RecoverParamsM$ConfigInt16$set(
# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
AppParamID_t arg_0x1ad5d010, 
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt16.nc"
uint16_t arg_0x1ad5baa8);
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
static  size_t RecoverParamsM$Config$get(
# 29 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
AppParamID_t arg_0x1ad73460, 
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
void *arg_0x1ad7b6b8, size_t arg_0x1ad7b840);
#line 57
static  result_t RecoverParamsM$Config$set(
# 29 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
AppParamID_t arg_0x1ad73460, 
# 57 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
void *arg_0x1ad7bcf0, size_t arg_0x1ad7be78);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt8.nc"
static  uint8_t RecoverParamsM$ConfigInt8$get(
# 30 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
AppParamID_t arg_0x1ad5e3c8);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt8.nc"
static  result_t RecoverParamsM$ConfigInt8$set(
# 30 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
AppParamID_t arg_0x1ad5e3c8, 
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt8.nc"
uint8_t arg_0x1ad71f10);
# 42 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
AppParamID_t RecoverParamsM$setParmID;
AppParamID_t RecoverParamsM$getParmID;

static inline  result_t RecoverParamsM$ExternalConfig$set(AppParamID_t id, void *buffer, size_t size);



static   result_t RecoverParamsM$Config$default$set(AppParamID_t id, void *buffer, size_t size);
#line 70
static inline   result_t RecoverParamsM$ConfigInt8$default$set(AppParamID_t id, uint8_t value);



static inline   result_t RecoverParamsM$ConfigInt16$default$set(AppParamID_t id, uint16_t value);



static inline  size_t RecoverParamsM$ExternalConfig$get(AppParamID_t id, void *buffer, size_t available);



static   size_t RecoverParamsM$Config$default$get(AppParamID_t id, void *buffer, size_t size);
#line 109
static inline   uint16_t RecoverParamsM$ConfigInt16$default$get(AppParamID_t id);




static inline   uint8_t RecoverParamsM$ConfigInt8$default$get(AppParamID_t id);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t RecoverSystemParamsM$DS2401$init(void);






static  result_t RecoverSystemParamsM$DS2401$start(void);







static  result_t RecoverSystemParamsM$DS2401$stop(void);
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HardwareId.nc"
static  result_t RecoverSystemParamsM$HardwareId$read(uint8_t *arg_0x1ad9d338);
# 127 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420Control.nc"
static  result_t RecoverSystemParamsM$CC2420Control$SetRFPower(uint8_t arg_0x1a664d48);
#line 52
static  result_t RecoverSystemParamsM$CC2420Control$TunePreset(uint8_t arg_0x1a6516c8);
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverSystemParamsM.nc"
uint8_t RecoverSystemParamsM$DSSerialID[8];

static inline  result_t RecoverSystemParamsM$XEESubControl$init(void);





static inline  result_t RecoverSystemParamsM$XEESubControl$start(void);
#line 84
static inline  uint16_t RecoverSystemParamsM$SystemMoteID$get(void);




static inline  result_t RecoverSystemParamsM$SystemMoteID$set(uint16_t value);
#line 101
static inline  uint8_t RecoverSystemParamsM$SystemGroupNumber$get(void);





static inline  result_t RecoverSystemParamsM$SystemGroupNumber$set(uint8_t value);




uint8_t RecoverSystemParamsM$sysModelType = TOS_MODEL_UNKNOWN;
static inline  uint8_t RecoverSystemParamsM$SystemModelType$get(void);



static inline  result_t RecoverSystemParamsM$SystemModelType$set(uint8_t value);




uint8_t RecoverSystemParamsM$sysSubModelType = TOS_SUBMODEL_UNKNOWN;
static inline  uint8_t RecoverSystemParamsM$SystemSuModelType$get(void);



static inline  result_t RecoverSystemParamsM$SystemSuModelType$set(uint8_t value);




uint8_t RecoverSystemParamsM$sysMoteCPUType = TOS_CPU_TYPE_UNKNOWN;
static inline  uint8_t RecoverSystemParamsM$SystemMoteCPUType$get(void);



static inline  result_t RecoverSystemParamsM$SystemMoteCPUType$set(uint8_t value);




uint8_t RecoverSystemParamsM$sysRadioType = TOS_RADIO_TYPE_UNKNOWN;
static inline  uint8_t RecoverSystemParamsM$SystemRadioType$get(void);



static inline  result_t RecoverSystemParamsM$SystemRadioType$set(uint8_t value);




uint16_t RecoverSystemParamsM$sysVendorID = TOS_VENDOR_UNKNOWN;
static inline  uint16_t RecoverSystemParamsM$SystemVendorID$get(void);



static inline  result_t RecoverSystemParamsM$SystemVendorID$set(uint16_t value);





static inline  size_t RecoverSystemParamsM$SystemSerialNumber$get(void *buffer, size_t size);






static inline  result_t RecoverSystemParamsM$HardwareId$readDone(uint8_t *id, result_t success);





static inline  result_t RecoverSystemParamsM$SystemSerialNumber$set(void *buffer, size_t size);



uint32_t RecoverSystemParamsM$sysCPUOscillatorFrequency = 0;

static inline  size_t RecoverSystemParamsM$SystemCPUOscillatorFrequency$get(void *buffer, size_t size);







static inline  result_t RecoverSystemParamsM$SystemCPUOscillatorFrequency$set(void *buffer, size_t size);










static inline  uint8_t RecoverSystemParamsM$RadioPower$get(void);



static inline  result_t RecoverSystemParamsM$RadioPower$set(uint8_t value);




static inline  uint8_t RecoverSystemParamsM$RadioChannel$get(void);







static inline  result_t RecoverSystemParamsM$RadioChannel$set(uint8_t value);





uint8_t RecoverSystemParamsM$xbowFacInfo1[16] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

static inline  size_t RecoverSystemParamsM$CrossbowFactoryInfo1$get(void *buffer, size_t size);






static inline  result_t RecoverSystemParamsM$CrossbowFactoryInfo1$set(void *buffer, size_t size);










uint8_t RecoverSystemParamsM$xbowFacInfo2[16] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

static inline  size_t RecoverSystemParamsM$CrossbowFactoryInfo2$get(void *buffer, size_t size);






static inline  result_t RecoverSystemParamsM$CrossbowFactoryInfo2$set(void *buffer, size_t size);









uint8_t RecoverSystemParamsM$xbowFacInfo3[16] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

static inline  size_t RecoverSystemParamsM$CrossbowFactoryInfo3$get(void *buffer, size_t size);






static inline  result_t RecoverSystemParamsM$CrossbowFactoryInfo3$set(void *buffer, size_t size);









uint8_t RecoverSystemParamsM$xbowFacInfo4[16] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

static inline  size_t RecoverSystemParamsM$CrossbowFactoryInfo4$get(void *buffer, size_t size);







static inline  result_t RecoverSystemParamsM$CrossbowFactoryInfo4$set(void *buffer, size_t size);










static inline  size_t RecoverSystemParamsM$XmeshAppTimerRate$get(void *buffer, size_t size);







static inline  result_t RecoverSystemParamsM$XmeshAppTimerRate$set(void *buffer, size_t size);
# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HardwareId.nc"
static  result_t SerialId$HardwareId$readDone(uint8_t *arg_0x1ad9da40, result_t arg_0x1ad9dbd0);
# 23 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\SerialId.nc"
bool SerialId$gfReadBusy;
uint8_t *SerialId$serialId;

static inline  result_t SerialId$StdControl$init(void);





static inline  result_t SerialId$StdControl$start(void);




static inline  result_t SerialId$StdControl$stop(void);
#line 52
static inline uint8_t SerialId$serialIdByteRead(void);
#line 69
static inline void SerialId$serialIdByteWrite(uint8_t data);
#line 85
static inline  void SerialId$serialIdRead(void);
#line 125
static inline  result_t SerialId$HardwareId$read(uint8_t *id);
# 20 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XEEControl.nc"
static  result_t EEPROMConfigM$XEEControl$restoreDone(result_t arg_0x1ad06218);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t EEPROMConfigM$EEPROMstdControl$init(void);






static  result_t EEPROMConfigM$EEPROMstdControl$start(void);
# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReadData.nc"
static  result_t EEPROMConfigM$ReadData$read(uint32_t arg_0x1ae364d0, uint8_t *arg_0x1ae36678, uint32_t arg_0x1ae36810);
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
static  size_t EEPROMConfigM$Config$get(
# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\EEPROMConfigM.nc"
AppParamID_t arg_0x1ae3e088, 
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
void *arg_0x1ad7b6b8, size_t arg_0x1ad7b840);
#line 57
static  result_t EEPROMConfigM$Config$set(
# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\EEPROMConfigM.nc"
AppParamID_t arg_0x1ae3e088, 
# 57 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
void *arg_0x1ad7bcf0, size_t arg_0x1ad7be78);
# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigSave.nc"
static  result_t EEPROMConfigM$ConfigSave$saveDone(result_t arg_0x1ad77d68, AppParamID_t arg_0x1ad77ef8);
# 35 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
static   result_t EEPROMConfigM$Leds$init(void);
#line 60
static   result_t EEPROMConfigM$Leds$redToggle(void);
# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\WriteData.nc"
static  result_t EEPROMConfigM$WriteData$write(uint32_t arg_0x1ae3a9e0, uint8_t *arg_0x1ae3ab88, uint32_t arg_0x1ae3ad20);
# 55 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\EEPROMConfigM.nc"
#line 46
enum EEPROMConfigM$__nesc_unnamed4326 {
  EEPROMConfigM$PARAM_NEVER_STARTED = 0, 
  EEPROMConfigM$PARAM_IDLE, 
  EEPROMConfigM$PARAM_READ_VERSION, 
  EEPROMConfigM$PARAM_READ_PARAMETER, 
  EEPROMConfigM$PARAM_SAVE_VERSION, 
  EEPROMConfigM$PARAM_SAVE_PARAMETERS, 
  EEPROMConfigM$PARAM_SAVE_NEW_PARAMETERS, 
  EEPROMConfigM$PARAM_SAVE_END_PARAM
} EEPROMConfigM$paramState;

uint16_t EEPROMConfigM$currentBlock;
uint8_t EEPROMConfigM$readBuffer[16];






uint8_t EEPROMConfigM$nextParamID;
AppParamID_t EEPROMConfigM$endAppParam;
bool EEPROMConfigM$rescanRequired;






#line 70
union EEPROMConfigM$__nesc_unnamed4327 {
  FlashVersionBlock_t versionInfo;
  ParameterBlock_t param;
  uint8_t data[1];
} EEPROMConfigM$flashTemp;

static inline  result_t EEPROMConfigM$StdControl$init(void);
#line 88
static inline  result_t EEPROMConfigM$StdControl$start(void);
#line 114
static uint16_t EEPROMConfigM$calcrc(uint8_t *ptr, uint8_t count);
#line 132
static bool EEPROMConfigM$checkBlockCRC(void *pBlock, size_t length);
#line 152
static void EEPROMConfigM$setBlockCRC(void *pBlock, size_t length);








static void EEPROMConfigM$writeTrailingParameter(void);
#line 173
static void EEPROMConfigM$findNextParameter(void);










static inline  result_t EEPROMConfigM$WriteData$writeDone(uint8_t *pWriteBuffer, uint32_t writeNumBytesWrite, result_t result);
#line 290
static inline  result_t EEPROMConfigM$ReadData$readDone(uint8_t *pReadBuffer, uint32_t readByteCount, result_t result);
#line 528
static  result_t EEPROMConfigM$ConfigSave$save(AppParamID_t startParam, AppParamID_t endParam);
# 42 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReadData.nc"
static  result_t InternalEEPROMM$ReadData$readDone(uint8_t *arg_0x1ae35010, uint32_t arg_0x1ae351a8, result_t arg_0x1ae35338);
# 42 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\WriteData.nc"
static  result_t InternalEEPROMM$WriteData$writeDone(uint8_t *arg_0x1ae39500, uint32_t arg_0x1ae39698, result_t arg_0x1ae39828);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\InternalEEPROMM.nc"
static inline  result_t InternalEEPROMM$StdControl$init(void);




static inline  result_t InternalEEPROMM$StdControl$start(void);










static uint8_t *InternalEEPROMM$pReadBuffer;
static uint16_t InternalEEPROMM$readNumBytesRead;

static  result_t InternalEEPROMM$ReadData$read(uint32_t offset, uint8_t *buffer, uint32_t numBytesRead);










static uint8_t *InternalEEPROMM$pWriteBuffer;
static uint16_t InternalEEPROMM$writeNumBytesWrite;

static  result_t InternalEEPROMM$WriteData$write(uint32_t offset, uint8_t *buffer, uint32_t numBytesWrite);
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
static  result_t XCommandM$Send$send(uint16_t arg_0x1ab219b8, uint8_t arg_0x1ab21b40, TOS_MsgPtr arg_0x1ab21cd0, uint16_t arg_0x1ab21e60);
#line 88
static  void *XCommandM$Send$getBuffer(TOS_MsgPtr arg_0x1ab4b7c0, uint16_t *arg_0x1ab4b970);
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
static  size_t XCommandM$Config$get(
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XCommandM.nc"
uint32_t arg_0x1aefcd98, 
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
void *arg_0x1ad7b6b8, size_t arg_0x1ad7b840);
#line 57
static  result_t XCommandM$Config$set(
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XCommandM.nc"
uint32_t arg_0x1aefcd98, 
# 57 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
void *arg_0x1ad7bcf0, size_t arg_0x1ad7be78);
# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigSave.nc"
static  result_t XCommandM$ConfigSave$save(AppParamID_t arg_0x1ad77730, AppParamID_t arg_0x1ad778c0);
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XCommand.nc"
static  result_t XCommandM$XCommand$received(XCommandOp *arg_0x1ad09a60);
# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
static   result_t XCommandM$Leds$yellowOff(void);
#line 93
static   result_t XCommandM$Leds$yellowOn(void);
#line 76
static   result_t XCommandM$Leds$greenOff(void);
#line 51
static   result_t XCommandM$Leds$redOff(void);
#line 85
static   result_t XCommandM$Leds$greenToggle(void);
#line 110
static   result_t XCommandM$Leds$yellowToggle(void);
#line 60
static   result_t XCommandM$Leds$redToggle(void);
#line 128
static   result_t XCommandM$Leds$set(uint8_t arg_0x1a5b5a40);
#line 43
static   result_t XCommandM$Leds$redOn(void);
#line 68
static   result_t XCommandM$Leds$greenOn(void);
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XCommandM.nc"
enum XCommandM$__nesc_unnamed4328 {
#line 48
  XCommandM$CONFIG_PKT = 0x81, 
  XCommandM$UID_PKT, 
  XCommandM$SETNODEID_PKT, 
  XCommandM$SETGROUPID_PKT, 
  XCommandM$SETFREQ_PKT, 
  XCommandM$SETRFPOWER_PKT, 
  XCommandM$SETTIMERRATE_PKT
};
enum XCommandM$__nesc_unnamed4329 {
#line 56
  XCommandM$IDLE, 
  XCommandM$GET_CONFIG, 
  XCommandM$CONFIG_UID, 
  XCommandM$SET_NODEID, 
  XCommandM$SET_GROUPID, 
  XCommandM$SET_RFFREQ, 
  XCommandM$SET_RFPOWER, 
  XCommandM$SET_TIMERRATE
};

TOS_Msg XCommandM$msg_buf;
XCmdDataMsg XCommandM$readings;
uint8_t XCommandM$nextPacketID;
uint8_t XCommandM$state;
uint8_t XCommandM$cmdkey;









static  void XCommandM$send_msg(void);
#line 110
inline static void XCommandM$XCommandAcctuate(uint16_t device, uint16_t cmd_state);
#line 146
static  result_t XCommandM$ConfigSave$saveDone(result_t success, AppParamID_t failed);
#line 200
static inline void XCommandM$getMyConfig(void);
#line 216
static inline void XCommandM$Uid_Config(void *ptrSerialid, uint16_t *ptrNodeid);
#line 237
static inline void XCommandM$Set_NodeID(uint16_t *ptrNodeid);
#line 252
static inline void XCommandM$Set_GroupID(uint8_t *ptrGroupid);
#line 267
static inline void XCommandM$Set_TimerRate(uint32_t *ptrTimerRate);
#line 283
static inline void XCommandM$Set_RFCHANNEL(uint8_t *ptrCH);
#line 299
static inline void XCommandM$Set_RFPOWER(uint8_t *ptrRFPower);
#line 316
static void XCommandM$handleCommand(XCommandOp *opcode, uint16_t addr);
#line 395
static inline  TOS_MsgPtr XCommandM$CmdRcv$receive(TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen);
#line 417
static inline  TOS_MsgPtr XCommandM$Bcast$receive(TOS_MsgPtr pMsg, void *payload, 
uint16_t payloadLen);
#line 444
static inline  result_t XCommandM$Send$sendDone(TOS_MsgPtr msg, result_t success);
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
static  TOS_MsgPtr BcastM$Receive$receive(
# 19 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Broadcast\\BcastM.nc"
uint8_t arg_0x1af8c118, 
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
TOS_MsgPtr arg_0x1ab42878, void *arg_0x1ab42a18, uint16_t arg_0x1ab42bb0);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
static  result_t BcastM$SendMsg$send(
# 24 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Broadcast\\BcastM.nc"
uint8_t arg_0x1af8b200, 
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
uint16_t arg_0x1a583670, uint8_t arg_0x1a5837f8, TOS_MsgPtr arg_0x1a583988);
# 30 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Broadcast\\BcastM.nc"
enum BcastM$__nesc_unnamed4330 {
  BcastM$FWD_QUEUE_SIZE = 4
};

int16_t BcastM$BcastSeqno;
TOS_Msg BcastM$FwdBuffer[BcastM$FWD_QUEUE_SIZE];
uint8_t BcastM$iFwdBufHead;
#line 36
uint8_t BcastM$iFwdBufTail;
#line 51
inline static bool BcastM$newBcast(int16_t proposed);
#line 71
inline static void BcastM$FwdBcast(TOS_BcastMsg *pRcvMsg, uint8_t Len, uint8_t id);
#line 106
static inline  result_t BcastM$SendMsg$sendDone(uint8_t id, TOS_MsgPtr pMsg, result_t success);






static inline  TOS_MsgPtr BcastM$ReceiveMsg$receive(uint8_t id, TOS_MsgPtr pMsg);
#line 126
static inline   TOS_MsgPtr BcastM$Receive$default$receive(uint8_t id, TOS_MsgPtr pMsg, void *payload, 
uint16_t payloadLen);
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SetParam.nc"
static  result_t SamplerM$SetParam8$setParam(uint8_t arg_0x1afc7e18);
#line 17
static  result_t SamplerM$SetParam11$setParam(uint8_t arg_0x1afc7e18);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC6$getData(void);
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SetParam.nc"
static  result_t SamplerM$SetParam0$setParam(uint8_t arg_0x1afc7e18);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC0$getData(void);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t SamplerM$Dio2$setparam(uint8_t arg_0x1afefeb0);
#line 20
static  result_t SamplerM$Dio2$getData(void);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC9$getData(void);
#line 26
static  result_t SamplerM$ADC3$getData(void);
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SetParam.nc"
static  result_t SamplerM$SetParam3$setParam(uint8_t arg_0x1afc7e18);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t SamplerM$Dio5$setparam(uint8_t arg_0x1afefeb0);
#line 20
static  result_t SamplerM$Dio5$getData(void);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC12$getData(void);
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SetParam.nc"
static  result_t SamplerM$SetParam6$setParam(uint8_t arg_0x1afc7e18);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC4$getData(void);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t SamplerM$Dio0$setparam(uint8_t arg_0x1afefeb0);
#line 20
static  result_t SamplerM$Dio0$getData(void);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$Hum$getData(void);
# 30 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
static   result_t SamplerM$Battery$getData(void);
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SetParam.nc"
static  result_t SamplerM$SetParam9$setParam(uint8_t arg_0x1afc7e18);
#line 17
static  result_t SamplerM$SetParam12$setParam(uint8_t arg_0x1afc7e18);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC7$getData(void);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t SamplerM$TempHumControl$init(void);






static  result_t SamplerM$TempHumControl$start(void);







static  result_t SamplerM$TempHumControl$stop(void);
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SetParam.nc"
static  result_t SamplerM$SetParam1$setParam(uint8_t arg_0x1afc7e18);
# 21 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Sample.nc"
static  result_t SamplerM$Sample$dataReady(uint8_t arg_0x1ad03e30, uint8_t arg_0x1ad01010, uint16_t arg_0x1ad011a0);
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
static  result_t SamplerM$SamplerTimer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC1$getData(void);
#line 26
static  result_t SamplerM$ADC10$getData(void);
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SetParam.nc"
static  result_t SamplerM$SetParam4$setParam(uint8_t arg_0x1afc7e18);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t SamplerM$Dio3$setparam(uint8_t arg_0x1afefeb0);
#line 20
static  result_t SamplerM$Dio3$getData(void);






static  result_t SamplerM$Counter$setparam(uint8_t arg_0x1afefeb0);
#line 20
static  result_t SamplerM$Counter$getData(void);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC13$getData(void);
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SetParam.nc"
static  result_t SamplerM$SetParam7$setParam(uint8_t arg_0x1afc7e18);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC5$getData(void);
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SetParam.nc"
static  result_t SamplerM$SetParam10$setParam(uint8_t arg_0x1afc7e18);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t SamplerM$IBADCcontrol$init(void);






static  result_t SamplerM$IBADCcontrol$start(void);







static  result_t SamplerM$IBADCcontrol$stop(void);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$Temp$getData(void);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t SamplerM$Dio1$setparam(uint8_t arg_0x1afefeb0);
#line 20
static  result_t SamplerM$Dio1$getData(void);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t SamplerM$CounterControl$init(void);






static  result_t SamplerM$CounterControl$start(void);







static  result_t SamplerM$CounterControl$stop(void);
#line 41
static  result_t SamplerM$DioControl$init(void);






static  result_t SamplerM$DioControl$start(void);







static  result_t SamplerM$DioControl$stop(void);
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SetParam.nc"
static  result_t SamplerM$SetParam13$setParam(uint8_t arg_0x1afc7e18);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t SamplerM$BatteryControl$init(void);






static  result_t SamplerM$BatteryControl$start(void);







static  result_t SamplerM$BatteryControl$stop(void);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC8$getData(void);
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SetParam.nc"
static  result_t SamplerM$SetParam2$setParam(uint8_t arg_0x1afc7e18);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC2$getData(void);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t SamplerM$Dio4$setparam(uint8_t arg_0x1afefeb0);
#line 20
static  result_t SamplerM$Dio4$getData(void);
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t SamplerM$ADC11$getData(void);
# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SetParam.nc"
static  result_t SamplerM$SetParam5$setParam(uint8_t arg_0x1afc7e18);
# 84 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static  result_t SamplerM$Plugged(void);
#line 96
uint8_t SamplerM$flag25;
#line 96
uint8_t SamplerM$flag33;
#line 96
uint8_t SamplerM$flag50;

 uint16_t SamplerM$batvalue;







#line 100
struct SamplerM$SampleRecords {
  uint8_t channel;
  uint8_t channelType;

  int16_t ticks_left;
  int16_t sampling_interval;
} SamplerM$SampleRecord[25];



static __inline int8_t SamplerM$get_avilable_SampleRecord(void);








static void SamplerM$next_schedule(void);
#line 141
static __inline void SamplerM$setparam_analog(uint8_t i, uint8_t param);
#line 191
static __inline void SamplerM$setparam_digital(int8_t i, uint8_t param);
#line 217
static __inline void SamplerM$setparam_counter(int8_t i, uint8_t param);





static inline  void SamplerM$sigbatt(void);




static inline void SamplerM$sampleRecord(uint8_t i);
#line 321
static inline  result_t SamplerM$SamplerControl$init(void);
#line 340
static inline  result_t SamplerM$SamplerControl$start(void);










static inline  result_t SamplerM$SamplerControl$stop(void);









static inline  result_t SamplerM$PlugPlay(void);





static inline  result_t SamplerM$SamplerTimer$fired(void);
#line 393
static inline  result_t SamplerM$Sample$sampleNow(void);





static  int8_t SamplerM$Sample$getSample(uint8_t channel, uint8_t channelType, uint16_t interval, uint8_t param);
#line 422
static inline  result_t SamplerM$Sample$stop(int8_t record);
#line 434
static inline  result_t SamplerM$ADC0$dataReady(uint16_t data);




static inline  result_t SamplerM$ADC1$dataReady(uint16_t data);




static inline  result_t SamplerM$ADC2$dataReady(uint16_t data);




static inline  result_t SamplerM$ADC3$dataReady(uint16_t data);




static inline  result_t SamplerM$ADC4$dataReady(uint16_t data);




static inline  result_t SamplerM$ADC5$dataReady(uint16_t data);




static inline  result_t SamplerM$ADC6$dataReady(uint16_t data);




static inline  result_t SamplerM$ADC7$dataReady(uint16_t data);




static inline  result_t SamplerM$ADC8$dataReady(uint16_t data);




static inline  result_t SamplerM$ADC9$dataReady(uint16_t data);




static inline  result_t SamplerM$ADC10$dataReady(uint16_t data);




static inline  result_t SamplerM$ADC11$dataReady(uint16_t data);




static inline  result_t SamplerM$ADC12$dataReady(uint16_t data);




static inline  result_t SamplerM$ADC13$dataReady(uint16_t data);





static inline   result_t SamplerM$Battery$dataReady(uint16_t data);






static inline  result_t SamplerM$Temp$dataReady(uint16_t data);




static inline  result_t SamplerM$Hum$dataReady(uint16_t data);




static inline  result_t SamplerM$Dio0$dataReady(uint16_t data);




static inline  result_t SamplerM$Dio1$dataReady(uint16_t data);




static inline  result_t SamplerM$Dio2$dataReady(uint16_t data);




static inline  result_t SamplerM$Dio3$dataReady(uint16_t data);




static inline  result_t SamplerM$Dio4$dataReady(uint16_t data);




static inline  result_t SamplerM$Dio5$dataReady(uint16_t data);
#line 576
static inline  result_t SamplerM$Counter$dataReady(uint16_t data);
# 55 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2C.nc"
static  result_t I2CM$I2C$sendEndDone(void);
#line 48
static  result_t I2CM$I2C$sendStartDone(void);
#line 71
static  result_t I2CM$I2C$writeDone(bool arg_0x1b085978);
#line 62
static  result_t I2CM$I2C$readDone(char arg_0x1b0852b8);
# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\I2CM.nc"
char I2CM$state;
char I2CM$local_data;



enum I2CM$__nesc_unnamed4331 {
#line 38
  I2CM$READ_DATA = 1, I2CM$WRITE_DATA, I2CM$SEND_START, I2CM$SEND_END
};






static inline void I2CM$SET_CLOCK(void);
static inline void I2CM$CLEAR_CLOCK(void);
static inline void I2CM$MAKE_CLOCK_OUTPUT(void);


static inline void I2CM$SET_DATA(void);
static inline void I2CM$CLEAR_DATA(void);
static inline void I2CM$MAKE_DATA_OUTPUT(void);
static inline void I2CM$MAKE_DATA_INPUT(void);
static inline char I2CM$GET_DATA(void);

static void I2CM$pulse_clock(void);






static char I2CM$read_bit(void);
#line 76
static inline char I2CM$i2c_read(void);
#line 88
static inline char I2CM$i2c_write(char c);
#line 104
static inline void I2CM$i2c_start(void);









static inline void I2CM$i2c_ack(void);





static inline void I2CM$i2c_nack(void);





static inline void I2CM$i2c_end(void);








static  void I2CM$I2C_task(void);
#line 155
static inline  result_t I2CM$StdControl$init(void);
#line 173
static  result_t I2CM$I2C$sendStart(void);







static  result_t I2CM$I2C$sendEnd(void);







static  result_t I2CM$I2C$read(bool ack);









static  result_t I2CM$I2C$write(char data);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2C.nc"
static  result_t I2CPacketM$I2C$sendEnd(void);






static  result_t I2CPacketM$I2C$read(bool arg_0x1b088a00);
#line 20
static  result_t I2CPacketM$I2C$sendStart(void);
#line 41
static  result_t I2CPacketM$I2C$write(char arg_0x1b0870f0);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t I2CPacketM$I2CStdControl$init(void);
# 78 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
static  result_t I2CPacketM$I2CPacket$writePacketDone(
# 24 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\I2CPacketM.nc"
uint8_t arg_0x1b0c4930, 
# 78 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
bool arg_0x1b0909e8);
#line 70
static  result_t I2CPacketM$I2CPacket$readPacketDone(
# 24 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\I2CPacketM.nc"
uint8_t arg_0x1b0c4930, 
# 70 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
char arg_0x1b090010, char *arg_0x1b0901b0);
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\I2CPacketM.nc"
enum I2CPacketM$__nesc_unnamed4332 {
#line 37
  I2CPacketM$IDLE = 99, 
  I2CPacketM$I2C_START_COMMAND = 1, 
  I2CPacketM$I2C_STOP_COMMAND = 2, 
  I2CPacketM$I2C_STOP_COMMAND_SENT = 3, 
  I2CPacketM$I2C_WRITE_ADDRESS = 10, 
  I2CPacketM$I2C_WRITE_DATA = 11, 
  I2CPacketM$I2C_READ_ADDRESS = 20, 
  I2CPacketM$I2C_READ_DATA = 21, 
  I2CPacketM$I2C_READ_DONE = 22
};
enum I2CPacketM$__nesc_unnamed4333 {
#line 47
  I2CPacketM$STOP_FLAG = 0x01, 
  I2CPacketM$ACK_FLAG = 0x02, 
  I2CPacketM$ACK_END_FLAG = 0x04, 
  I2CPacketM$ADDR_8BITS_FLAG = 0x80
};




char *I2CPacketM$data;




char I2CPacketM$length;




char I2CPacketM$index;




char I2CPacketM$state;




char I2CPacketM$addr;




char I2CPacketM$flags;




char I2CPacketM$temp[10];





static  result_t I2CPacketM$StdControl$init(void);
#line 125
static  result_t I2CPacketM$I2CPacket$writePacket(uint8_t id, char in_length, char *in_data, char in_flags);
#line 166
static  result_t I2CPacketM$I2CPacket$readPacket(uint8_t id, char in_length, 
char in_flags);
#line 199
static inline  result_t I2CPacketM$I2C$sendStartDone(void);
#line 215
static inline  result_t I2CPacketM$I2C$sendEndDone(void);
#line 253
static inline  result_t I2CPacketM$I2C$writeDone(bool result);
#line 296
static inline  result_t I2CPacketM$I2C$readDone(char in_data);
#line 318
static inline   result_t I2CPacketM$I2CPacket$default$readPacketDone(uint8_t id, char in_length, char *in_data);



static inline   result_t I2CPacketM$I2CPacket$default$writePacketDone(uint8_t id, bool result);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t DioM$I2CPacketControl$init(void);
# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t DioM$Dio$dataReady(
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
uint8_t arg_0x1b1087d0, 
# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
uint16_t arg_0x1afee368);
# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
static  result_t DioM$I2CPacket$writePacket(char arg_0x1b0913c0, char *arg_0x1b091560, char arg_0x1b0916e0);
#line 39
static  result_t DioM$I2CPacket$readPacket(char arg_0x1b093858, char arg_0x1b0939d8);
# 35 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
uint8_t DioM$state;
uint8_t DioM$io_value;
uint8_t DioM$mode[8];
uint16_t DioM$count[8];
uint8_t DioM$bitmap_high;
#line 39
uint8_t DioM$bitmap_low;
#line 39
uint8_t DioM$bitmap_toggle;
uint8_t DioM$i2c_data;
uint8_t DioM$intflag = 0;
uint8_t DioM$i2cwflag = 0;
uint8_t DioM$i2crflag = 0;
#line 57
enum DioM$__nesc_unnamed4334 {
#line 57
  DioM$GET_DATA, DioM$SET_OUTPUT_HIGH, DioM$SET_OUTPUT_LOW, DioM$SET_OUTPUT_TOGGLE, DioM$GET_THEN_SET_INPUT, DioM$IDLE, DioM$INIT
};

static inline  result_t DioM$StdControl$init(void);
#line 77
static  void DioM$init_io(void);









static  void DioM$read_io(void);

static inline  result_t DioM$StdControl$start(void);








static inline  result_t DioM$StdControl$stop(void);



static  result_t DioM$Dio$setparam(uint8_t channel, uint8_t modeToSet);
#line 118
static  void DioM$set_io_high(void);
#line 144
static  void DioM$set_io_low(void);
#line 170
static  void DioM$set_io_toggle(void);
#line 197
static  result_t DioM$Dio$Toggle(uint8_t channel);










static  result_t DioM$Dio$high(uint8_t channel);










static  result_t DioM$Dio$low(uint8_t channel);










static  result_t DioM$Dio$getData(uint8_t channel);








static   result_t DioM$Dio$default$dataReady(uint8_t channel, uint16_t data);
#line 253
static  void DioM$read_io(void);
#line 269
static  result_t DioM$I2CPacket$writePacketDone(bool result);
#line 284
static  result_t DioM$I2CPacket$readPacketDone(char length, char *data);
#line 346
void __vector_5(void)   __attribute((signal)) ;
# 24 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Switch.nc"
static  result_t IBADCM$Switch$setAll(char arg_0x1b160a08);
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
static  result_t IBADCM$PowerStabalizingTimer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t IBADCM$I2CPacketControl$init(void);
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t IBADCM$ADConvert$dataReady(
# 25 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
uint8_t arg_0x1b1694c0, 
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
uint16_t arg_0x1afcb010);
# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
static  result_t IBADCM$I2CPacket$writePacket(char arg_0x1b0913c0, char *arg_0x1b091560, char arg_0x1b0916e0);
#line 39
static  result_t IBADCM$I2CPacket$readPacket(char arg_0x1b093858, char arg_0x1b0939d8);
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
static  result_t IBADCM$SwitchControl$init(void);






static  result_t IBADCM$SwitchControl$start(void);







static  result_t IBADCM$SwitchControl$stop(void);
# 40 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
enum IBADCM$__nesc_unnamed4335 {
#line 40
  IBADCM$IDLE, IBADCM$PICK_CHANNEL, IBADCM$GET_SAMPLE, IBADCM$CONTINUE_SAMPLE, IBADCM$START_CONVERSION_PROCESS
};










char IBADCM$state;
uint16_t IBADCM$value;
uint8_t IBADCM$chan;
uint8_t IBADCM$param[13 + 1];
uint16_t IBADCM$adc_bitmap;
uint16_t IBADCM$adc_stopbitmap;
int8_t IBADCM$conversionNumber;


uint8_t IBADCM$condition;
uint8_t IBADCM$sflag;
uint8_t IBADCM$scount;
uint8_t IBADCM$initflag;
uint8_t IBADCM$i2cwflag = 0;
uint8_t IBADCM$i2crflag = 0;
uint8_t IBADCM$swsetallflag = 0;
uint8_t IBADCM$samplecount = 0;
#line 94
static result_t IBADCM$convert(void);
static  void IBADCM$adc_get_data(void);
static  void IBADCM$output_ref(void);

static inline void IBADCM$setExcitation(void);
#line 122
static void IBADCM$resetExcitation(void);
#line 181
static inline void IBADCM$setNumberOfConversions(void);








static  void IBADCM$output_ref(void);
#line 210
static  void IBADCM$stopchannel(void);
#line 306
static inline  result_t IBADCM$StdControl$init(void);
#line 332
static inline  result_t IBADCM$StdControl$start(void);










static inline  result_t IBADCM$StdControl$stop(void);
#line 372
static inline  result_t IBADCM$SetParam$setParam(uint8_t id, uint8_t mode);





static   result_t IBADCM$ADConvert$default$dataReady(uint8_t id, uint16_t data);



static  void IBADCM$adc_get_data(void);
#line 461
static result_t IBADCM$convert(void);
#line 526
static  result_t IBADCM$ADConvert$getData(uint8_t id);










static inline  result_t IBADCM$Switch$setAllDone(bool r);
#line 563
static inline  result_t IBADCM$PowerStabalizingTimer$fired(void);








static  result_t IBADCM$I2CPacket$readPacketDone(char length, char *data);
#line 620
static  result_t IBADCM$I2CPacket$writePacketDone(bool result);
#line 663
static inline  result_t IBADCM$Switch$setDone(bool r);
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Switch.nc"
static  result_t SwitchM$Switch$setDone(bool arg_0x1b194338);
static  result_t SwitchM$Switch$setAllDone(bool arg_0x1b1947d0);
# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
static  result_t SwitchM$I2CPacket$writePacket(char arg_0x1b0913c0, char *arg_0x1b091560, char arg_0x1b0916e0);
# 32 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SwitchM.nc"
enum SwitchM$__nesc_unnamed4336 {
#line 32
  SwitchM$GET_SWITCH, SwitchM$SET_SWITCH, SwitchM$SET_SWITCH_ALL, 
  SwitchM$SET_SWITCH_GET, SwitchM$IDLE
};
char SwitchM$sw_state;
char SwitchM$state;



uint8_t SwitchM$i2cwflag = 0;

static inline  result_t SwitchM$SwitchControl$init(void);





static inline  result_t SwitchM$SwitchControl$start(void);



static inline  result_t SwitchM$SwitchControl$stop(void);
#line 81
static inline  result_t SwitchM$Switch$setAll(char val);
#line 98
static  result_t SwitchM$I2CPacket$writePacketDone(bool result);
#line 113
static inline  result_t SwitchM$I2CPacket$readPacketDone(char length, char *data);
# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t CounterM$Counter$dataReady(uint16_t arg_0x1afee368);
# 34 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\CounterM.nc"
uint16_t CounterM$count;
uint8_t CounterM$state;
uint8_t CounterM$mode;
result_t CounterM$boardConnected;

static inline  result_t CounterM$CounterControl$init(void);
#line 64
static  result_t CounterM$CounterControl$start(void);









static inline  result_t CounterM$CounterControl$stop(void);




static inline  result_t CounterM$Counter$setparam(uint8_t modeToSet);










static inline  result_t CounterM$Plugged(void);
#line 121
static inline  result_t CounterM$Counter$getData(void);
#line 137
static  void CounterM$count_ready(void);








void __vector_6(void)   __attribute((signal)) ;
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t TempHumM$TempSensor$dataReady(uint16_t arg_0x1afcb010);
#line 44
static  result_t TempHumM$HumSensor$dataReady(uint16_t arg_0x1afcb010);
# 34 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\TempHumM.nc"
enum TempHumM$__nesc_unnamed4337 {
#line 34
  TempHumM$IDLE, TempHumM$TEMP_MEASUREMENT, TempHumM$HUM_MEASUREMENT
};
#line 74
static inline void TempHumM$delay(void);
#line 87
char TempHumM$state;


char TempHumM$pending_states;








static __inline void TempHumM$ack(void);










static __inline void TempHumM$initseq(void);
#line 129
static __inline void TempHumM$reset(void);
#line 143
static __inline char TempHumM$processCommand(int cmd);
#line 179
static inline  result_t TempHumM$StdControl$init(void);







static inline  result_t TempHumM$StdControl$start(void);



static inline  result_t TempHumM$StdControl$stop(void);
#line 207
static  void TempHumM$initiateTemperature(void);










static  void TempHumM$initiateHumidity(void);









static inline  void TempHumM$readSensor(void);
#line 308
void __vector_8(void)   __attribute((signal)) ;







static inline  result_t TempHumM$TempSensor$getData(void);





static inline  result_t TempHumM$HumSensor$getData(void);
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t RelayM$Dio7$low(void);
#line 21
static  result_t RelayM$Dio7$high(void);

static  result_t RelayM$Dio7$Toggle(void);
#line 22
static  result_t RelayM$Dio6$low(void);
#line 21
static  result_t RelayM$Dio6$high(void);

static  result_t RelayM$Dio6$Toggle(void);
# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\RelayM.nc"
static inline  result_t RelayM$relay_normally_closed$open(void);





static inline  result_t RelayM$relay_normally_closed$close(void);





static inline  result_t RelayM$relay_normally_closed$toggle(void);





static inline  result_t RelayM$relay_normally_open$open(void);





static inline  result_t RelayM$relay_normally_open$close(void);





static inline  result_t RelayM$relay_normally_open$toggle(void);





static inline  result_t RelayM$Dio6$dataReady(uint16_t data);



static inline  result_t RelayM$Dio7$dataReady(uint16_t data);
# 118 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline void TOSH_SET_GREEN_LED_PIN(void)
#line 118
{
#line 118
  * (volatile uint8_t *)(0x1B + 0x20) |= 1 << 1;
}

#line 119
static __inline void TOSH_SET_YELLOW_LED_PIN(void)
#line 119
{
#line 119
  * (volatile uint8_t *)(0x1B + 0x20) |= 1 << 0;
}

#line 117
static __inline void TOSH_SET_RED_LED_PIN(void)
#line 117
{
#line 117
  * (volatile uint8_t *)(0x1B + 0x20) |= 1 << 2;
}

#line 156
static __inline void TOSH_SET_FLASH_SELECT_PIN(void)
#line 156
{
#line 156
  * (volatile uint8_t *)(0x1B + 0x20) |= 1 << 3;
}

#line 157
static __inline void TOSH_MAKE_FLASH_CLK_OUTPUT(void)
#line 157
{
#line 157
  * (volatile uint8_t *)(0x11 + 0x20) |= 1 << 5;
}

#line 158
static __inline void TOSH_MAKE_FLASH_OUT_OUTPUT(void)
#line 158
{
#line 158
  * (volatile uint8_t *)(0x11 + 0x20) |= 1 << 3;
}

#line 156
static __inline void TOSH_MAKE_FLASH_SELECT_OUTPUT(void)
#line 156
{
#line 156
  * (volatile uint8_t *)(0x1A + 0x20) |= 1 << 3;
}

#line 121
static __inline void TOSH_CLR_SERIAL_ID_PIN(void)
#line 121
{
#line 121
  * (volatile uint8_t *)(0x1B + 0x20) &= ~(1 << 4);
}

#line 121
static __inline void TOSH_MAKE_SERIAL_ID_INPUT(void)
#line 121
{
#line 121
  * (volatile uint8_t *)(0x1A + 0x20) &= ~(1 << 4);
}

#line 153
static __inline void TOSH_MAKE_RADIO_CCA_INPUT(void)
#line 153
{
#line 153
  * (volatile uint8_t *)(0x11 + 0x20) &= ~(1 << 6);
}

#line 151
static __inline void TOSH_MAKE_CC_FIFO_INPUT(void)
#line 151
{
#line 151
  * (volatile uint8_t *)(0x17 + 0x20) &= ~(1 << 7);
}

#line 149
static __inline void TOSH_MAKE_CC_SFD_INPUT(void)
#line 149
{
#line 149
  * (volatile uint8_t *)(0x11 + 0x20) &= ~(1 << 4);
}

#line 148
static __inline void TOSH_MAKE_CC_CCA_INPUT(void)
#line 148
{
#line 148
  * (volatile uint8_t *)(0x11 + 0x20) &= ~(1 << 6);
}

#line 146
static __inline void TOSH_MAKE_CC_FIFOP1_INPUT(void)
#line 146
{
#line 146
  * (volatile uint8_t *)(0x02 + 0x20) &= ~(1 << 6);
}


static __inline void TOSH_MAKE_CC_CS_INPUT(void)
#line 150
{
#line 150
  * (volatile uint8_t *)(0x17 + 0x20) &= ~(1 << 0);
}

#line 143
static __inline void TOSH_MAKE_CC_VREN_OUTPUT(void)
#line 143
{
#line 143
  * (volatile uint8_t *)(0x1A + 0x20) |= 1 << 5;
}

#line 142
static __inline void TOSH_MAKE_CC_RSTN_OUTPUT(void)
#line 142
{
#line 142
  * (volatile uint8_t *)(0x1A + 0x20) |= 1 << 6;
}

#line 171
static __inline void TOSH_MAKE_SPI_SCK_OUTPUT(void)
#line 171
{
#line 171
  * (volatile uint8_t *)(0x17 + 0x20) |= 1 << 1;
}

#line 168
static __inline void TOSH_MAKE_MOSI_OUTPUT(void)
#line 168
{
#line 168
  * (volatile uint8_t *)(0x17 + 0x20) |= 1 << 2;
}

#line 169
static __inline void TOSH_MAKE_MISO_INPUT(void)
#line 169
{
#line 169
  * (volatile uint8_t *)(0x17 + 0x20) &= ~(1 << 3);
}



static __inline void TOSH_MAKE_PW0_OUTPUT(void)
#line 174
{
#line 174
  * (volatile uint8_t *)(0x14 + 0x20) |= 1 << 0;
}

#line 175
static __inline void TOSH_MAKE_PW1_OUTPUT(void)
#line 175
{
#line 175
  * (volatile uint8_t *)(0x14 + 0x20) |= 1 << 1;
}

#line 176
static __inline void TOSH_MAKE_PW2_OUTPUT(void)
#line 176
{
#line 176
  * (volatile uint8_t *)(0x14 + 0x20) |= 1 << 2;
}

#line 177
static __inline void TOSH_MAKE_PW3_OUTPUT(void)
#line 177
{
#line 177
  * (volatile uint8_t *)(0x14 + 0x20) |= 1 << 3;
}

#line 178
static __inline void TOSH_MAKE_PW4_OUTPUT(void)
#line 178
{
#line 178
  * (volatile uint8_t *)(0x14 + 0x20) |= 1 << 4;
}

#line 179
static __inline void TOSH_MAKE_PW5_OUTPUT(void)
#line 179
{
#line 179
  * (volatile uint8_t *)(0x14 + 0x20) |= 1 << 5;
}

#line 180
static __inline void TOSH_MAKE_PW6_OUTPUT(void)
#line 180
{
#line 180
  * (volatile uint8_t *)(0x14 + 0x20) |= 1 << 6;
}

#line 181
static __inline void TOSH_MAKE_PW7_OUTPUT(void)
#line 181
{
#line 181
  * (volatile uint8_t *)(0x14 + 0x20) |= 1 << 7;
}

#line 118
static __inline void TOSH_MAKE_GREEN_LED_OUTPUT(void)
#line 118
{
#line 118
  * (volatile uint8_t *)(0x1A + 0x20) |= 1 << 1;
}

#line 119
static __inline void TOSH_MAKE_YELLOW_LED_OUTPUT(void)
#line 119
{
#line 119
  * (volatile uint8_t *)(0x1A + 0x20) |= 1 << 0;
}

#line 117
static __inline void TOSH_MAKE_RED_LED_OUTPUT(void)
#line 117
{
#line 117
  * (volatile uint8_t *)(0x1A + 0x20) |= 1 << 2;
}

#line 212
static inline void TOSH_SET_PIN_DIRECTIONS(void )
{







  TOSH_MAKE_RED_LED_OUTPUT();
  TOSH_MAKE_YELLOW_LED_OUTPUT();
  TOSH_MAKE_GREEN_LED_OUTPUT();


  TOSH_MAKE_PW7_OUTPUT();
  TOSH_MAKE_PW6_OUTPUT();
  TOSH_MAKE_PW5_OUTPUT();
  TOSH_MAKE_PW4_OUTPUT();
  TOSH_MAKE_PW3_OUTPUT();
  TOSH_MAKE_PW2_OUTPUT();
  TOSH_MAKE_PW1_OUTPUT();
  TOSH_MAKE_PW0_OUTPUT();


  TOSH_MAKE_MISO_INPUT();
  TOSH_MAKE_MOSI_OUTPUT();
  TOSH_MAKE_SPI_SCK_OUTPUT();
  TOSH_MAKE_CC_RSTN_OUTPUT();
  TOSH_MAKE_CC_VREN_OUTPUT();
  TOSH_MAKE_CC_CS_INPUT();
  TOSH_MAKE_CC_FIFOP1_INPUT();
  TOSH_MAKE_CC_CCA_INPUT();
  TOSH_MAKE_CC_SFD_INPUT();
  TOSH_MAKE_CC_FIFO_INPUT();

  TOSH_MAKE_RADIO_CCA_INPUT();



  TOSH_MAKE_SERIAL_ID_INPUT();
  TOSH_CLR_SERIAL_ID_PIN();

  TOSH_MAKE_FLASH_SELECT_OUTPUT();
  TOSH_MAKE_FLASH_OUT_OUTPUT();
  TOSH_MAKE_FLASH_CLK_OUTPUT();
  TOSH_SET_FLASH_SELECT_PIN();

  TOSH_SET_RED_LED_PIN();
  TOSH_SET_YELLOW_LED_PIN();
  TOSH_SET_GREEN_LED_PIN();
}

# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\HPLInit.nc"
static inline  result_t HPLInit$init(void)
#line 36
{
  TOSH_SET_PIN_DIRECTIONS();
  return SUCCESS;
}

# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\RealMain.nc"
inline static  result_t RealMain$hardwareInit(void){
#line 27
  unsigned char result;
#line 27

#line 27
  result = HPLInit$init();
#line 27

#line 27
  return result;
#line 27
}
#line 27
# 54 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\HPLPotC.nc"
static inline  result_t HPLPotC$Pot$finalise(void)
#line 54
{


  return SUCCESS;
}

# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLPot.nc"
inline static  result_t PotM$HPLPot$finalise(void){
#line 53
  unsigned char result;
#line 53

#line 53
  result = HPLPotC$Pot$finalise();
#line 53

#line 53
  return result;
#line 53
}
#line 53
# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\HPLPotC.nc"
static inline  result_t HPLPotC$Pot$increase(void)
#line 45
{





  return SUCCESS;
}

# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLPot.nc"
inline static  result_t PotM$HPLPot$increase(void){
#line 46
  unsigned char result;
#line 46

#line 46
  result = HPLPotC$Pot$increase();
#line 46

#line 46
  return result;
#line 46
}
#line 46
# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\HPLPotC.nc"
static inline  result_t HPLPotC$Pot$decrease(void)
#line 36
{





  return SUCCESS;
}

# 38 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLPot.nc"
inline static  result_t PotM$HPLPot$decrease(void){
#line 38
  unsigned char result;
#line 38

#line 38
  result = HPLPotC$Pot$decrease();
#line 38

#line 38
  return result;
#line 38
}
#line 38
# 72 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\PotM.nc"
static inline void PotM$setPot(uint8_t value)
#line 72
{
  uint8_t i;

#line 74
  for (i = 0; i < 151; i++) 
    PotM$HPLPot$decrease();

  for (i = 0; i < value; i++) 
    PotM$HPLPot$increase();

  PotM$HPLPot$finalise();

  PotM$potSetting = value;
}

static inline  result_t PotM$Pot$init(uint8_t initialSetting)
#line 85
{
  PotM$setPot(initialSetting);
  return SUCCESS;
}

# 57 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Pot.nc"
inline static  result_t RealMain$Pot$init(uint8_t arg_0x1a5051b8){
#line 57
  unsigned char result;
#line 57

#line 57
  result = PotM$Pot$init(arg_0x1a5051b8);
#line 57

#line 57
  return result;
#line 57
}
#line 57
# 59 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\sched.c"
static inline void TOSH_sched_init(void )
{
  int i;

#line 62
  TOSH_sched_free = 0;
  TOSH_sched_full = 0;
  for (i = 0; i < TOSH_MAX_TASKS; i++) 
    TOSH_queue[i].tp = (void *)0;
}

# 158 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\tos.h"
static inline result_t rcombine(result_t r1, result_t r2)



{
  return r1 == FAIL ? FAIL : r2;
}

# 74 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\TempHumM.nc"
static inline void TempHumM$delay(void)
#line 74
{
   __asm volatile ("nop");
   __asm volatile ("nop");
   __asm volatile ("nop");}

#line 129
static __inline void TempHumM$reset(void)
{
  int i;

#line 132
  * (volatile uint8_t *)(0x02 + 0x20) |= 1 << 7;
  * (volatile uint8_t *)(0x03 + 0x20) |= 1 << 7;
  * (volatile uint8_t *)(0x15 + 0x20) &= ~(1 << 0);
  for (i = 0; i < 9; i++) {
      * (volatile uint8_t *)(0x15 + 0x20) |= 1 << 0;
      TempHumM$delay();
      * (volatile uint8_t *)(0x15 + 0x20) &= ~(1 << 0);
    }
}

#line 110
static __inline void TempHumM$initseq(void)
{
  * (volatile uint8_t *)(0x02 + 0x20) |= 1 << 7;
  * (volatile uint8_t *)(0x03 + 0x20) |= 1 << 7;
  * (volatile uint8_t *)(0x15 + 0x20) &= ~(1 << 0);
  TempHumM$delay();
  * (volatile uint8_t *)(0x15 + 0x20) |= 1 << 0;
  TempHumM$delay();
  * (volatile uint8_t *)(0x03 + 0x20) &= ~(1 << 7);
  TempHumM$delay();
  * (volatile uint8_t *)(0x15 + 0x20) &= ~(1 << 0);
  TempHumM$delay();
  * (volatile uint8_t *)(0x15 + 0x20) |= 1 << 0;
  TempHumM$delay();
  * (volatile uint8_t *)(0x03 + 0x20) |= 1 << 7;
  TempHumM$delay();
  * (volatile uint8_t *)(0x15 + 0x20) &= ~(1 << 0);
}

#line 143
static __inline char TempHumM$processCommand(int cmd)
{
  int i;
  int CMD = cmd;

#line 147
  cmd &= 0x1f;
  * (volatile uint8_t *)(0x39 + 0x20) &= ~(1 << 7);
  TempHumM$reset();
  TempHumM$initseq();
  for (i = 0; i < 8; i++) {
      if (cmd & 0x80) {
#line 152
        * (volatile uint8_t *)(0x03 + 0x20) |= 1 << 7;
        }
      else {
#line 153
        * (volatile uint8_t *)(0x03 + 0x20) &= ~(1 << 7);
        }
#line 154
      cmd = cmd << 1;
      * (volatile uint8_t *)(0x15 + 0x20) |= 1 << 0;
      TempHumM$delay();
      TempHumM$delay();
      * (volatile uint8_t *)(0x15 + 0x20) &= ~(1 << 0);
    }

  * (volatile uint8_t *)(0x02 + 0x20) &= ~(1 << 7);
  TempHumM$delay();
  * (volatile uint8_t *)(0x15 + 0x20) |= 1 << 0;
  TempHumM$delay();
  if ((* (volatile uint8_t *)(0x01 + 0x20) >> 7) & 0x1) 
    {
      TempHumM$reset();
      return 0;
    }
  TempHumM$delay();
  * (volatile uint8_t *)(0x15 + 0x20) &= ~(1 << 0);
  if (CMD == 0x03 || CMD == 0x05) {
      * (volatile uint8_t *)(0x39 + 0x20) |= 1 << 7;
    }
  return 1;
}


static inline  result_t TempHumM$StdControl$init(void)
#line 179
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 180
    {
#line 180
      TempHumM$state = TempHumM$IDLE;
#line 180
      TempHumM$pending_states = 0x0;
    }
#line 181
    __nesc_atomic_end(__nesc_atomic); }
#line 181
  * (volatile uint8_t *)(0x39 + 0x20) &= ~(1 << 7);
  * (volatile uint8_t *)(0x14 + 0x20) |= 1 << 0;
  TempHumM$reset();
  TempHumM$processCommand(0x1e);
  return SUCCESS;
}

# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t SamplerM$TempHumControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = TempHumM$StdControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCControl.nc"
inline static  result_t VoltageM$ADCControl$init(void){
#line 26
  unsigned char result;
#line 26

#line 26
  result = ADCREFM$ADCControl$init();
#line 26

#line 26
  return result;
#line 26
}
#line 26
# 49 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLADC.nc"
inline static   result_t ADCREFM$HPLADC$bindPort(uint8_t arg_0x1ac9aec8, uint8_t arg_0x1ac99068){
#line 49
  unsigned char result;
#line 49

#line 49
  result = HPLADCM$ADC$bindPort(arg_0x1ac9aec8, arg_0x1ac99068);
#line 49

#line 49
  return result;
#line 49
}
#line 49
# 93 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCREFM.nc"
static inline  result_t ADCREFM$ADCControl$bindPort(uint8_t port, uint8_t adcPort)
#line 93
{
  return ADCREFM$HPLADC$bindPort(port, adcPort);
}

# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCControl.nc"
inline static  result_t VoltageM$ADCControl$bindPort(uint8_t arg_0x1ac8c2c8, uint8_t arg_0x1ac8c450){
#line 65
  unsigned char result;
#line 65

#line 65
  result = ADCREFM$ADCControl$bindPort(arg_0x1ac8c2c8, arg_0x1ac8c450);
#line 65

#line 65
  return result;
#line 65
}
#line 65
# 29 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\VoltageM.nc"
static inline  result_t VoltageM$StdControl$init(void)
#line 29
{
  VoltageM$ADCControl$bindPort(TOS_ADC_VOLTAGE_PORT, TOSH_ACTUAL_BANDGAP_PORT);
  {
  }
#line 31
  ;
  return VoltageM$ADCControl$init();
}

# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t SamplerM$BatteryControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = VoltageM$StdControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 176 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline void TOSH_CLR_PW2_PIN(void)
#line 176
{
#line 176
  * (volatile uint8_t *)(0x15 + 0x20) &= ~(1 << 2);
}

#line 177
static __inline void TOSH_CLR_PW3_PIN(void)
#line 177
{
#line 177
  * (volatile uint8_t *)(0x15 + 0x20) &= ~(1 << 3);
}

#line 179
static __inline void TOSH_CLR_PW5_PIN(void)
#line 179
{
#line 179
  * (volatile uint8_t *)(0x15 + 0x20) &= ~(1 << 5);
}

#line 175
static __inline void TOSH_SET_PW1_PIN(void)
#line 175
{
#line 175
  * (volatile uint8_t *)(0x15 + 0x20) |= 1 << 1;
}



static __inline void TOSH_SET_PW6_PIN(void)
#line 180
{
#line 180
  * (volatile uint8_t *)(0x15 + 0x20) |= 1 << 6;
}

# 42 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SwitchM.nc"
static inline  result_t SwitchM$SwitchControl$init(void)
#line 42
{
  SwitchM$state = SwitchM$IDLE;

  return SUCCESS;
}

# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t IBADCM$SwitchControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = SwitchM$SwitchControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
inline static  result_t IBADCM$I2CPacketControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = I2CPacketM$StdControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 306 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
static inline  result_t IBADCM$StdControl$init(void)
#line 306
{
  int i;

#line 308
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 308
    {
      IBADCM$state = IBADCM$IDLE;
      IBADCM$sflag = 0;
      IBADCM$adc_bitmap = 0;
      IBADCM$adc_stopbitmap = 0;
      IBADCM$initflag = 0;
      for (i = 0; i < 13 + 1; i++) IBADCM$param[i] = 0x00;
    }
#line 315
    __nesc_atomic_end(__nesc_atomic); }
  IBADCM$I2CPacketControl$init();
  IBADCM$SwitchControl$init();
  TOSH_MAKE_PW1_OUTPUT();
  TOSH_MAKE_PW2_OUTPUT();
  TOSH_MAKE_PW3_OUTPUT();
  TOSH_MAKE_PW4_OUTPUT();
  TOSH_MAKE_PW5_OUTPUT();
  TOSH_MAKE_PW6_OUTPUT();
  TOSH_SET_PW6_PIN();
  TOSH_SET_PW1_PIN();
  TOSH_CLR_PW5_PIN();
  TOSH_CLR_PW3_PIN();
  TOSH_CLR_PW2_PIN();
  return SUCCESS;
}

# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t SamplerM$IBADCcontrol$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = IBADCM$StdControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
inline static  result_t DioM$I2CPacketControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = I2CPacketM$StdControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
static inline  result_t DioM$StdControl$init(void)
#line 60
{
  DioM$mode[0] = RISING_EDGE;
  DioM$mode[1] = RISING_EDGE;
  DioM$mode[2] = RISING_EDGE;
  DioM$mode[3] = RISING_EDGE;
  DioM$mode[4] = RISING_EDGE;
  DioM$mode[5] = RISING_EDGE;
  DioM$mode[6] = DIG_OUTPUT;
  DioM$mode[7] = DIG_OUTPUT;
  DioM$io_value = 0xff;
  DioM$state = DioM$INIT;
  DioM$I2CPacketControl$init();
  return SUCCESS;
}

# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t SamplerM$DioControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = DioM$StdControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 178 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline void TOSH_CLR_PW4_PIN(void)
#line 178
{
#line 178
  * (volatile uint8_t *)(0x15 + 0x20) &= ~(1 << 4);
}

#line 102
static void __inline TOSH_uwait(int u_sec)
#line 102
{
  while (u_sec > 0) {
       __asm volatile ("nop");
       __asm volatile ("nop");
       __asm volatile ("nop");
       __asm volatile ("nop");
       __asm volatile ("nop");
       __asm volatile ("nop");
       __asm volatile ("nop");
       __asm volatile ("nop");
      u_sec--;
    }
}

#line 178
static __inline void TOSH_SET_PW4_PIN(void)
#line 178
{
#line 178
  * (volatile uint8_t *)(0x15 + 0x20) |= 1 << 4;
}

# 39 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\CounterM.nc"
static inline  result_t CounterM$CounterControl$init(void)
#line 39
{
  char c;

#line 41
  * (volatile uint8_t *)(0x39 + 0x20) &= ~(1 << 5);
  TOSH_MAKE_PW4_OUTPUT();
  TOSH_CLR_PW4_PIN();
  TOSH_uwait(1);
  c = (* (volatile uint8_t *)(0x01 + 0x20) >> 5) & 0x1;
  TOSH_SET_PW4_PIN();
  TOSH_uwait(1);
  if (c == ((* (volatile uint8_t *)(0x01 + 0x20) >> 5) & 0x1)) {
#line 48
    CounterM$boardConnected = FALSE;
    }
  else {
#line 49
    CounterM$boardConnected = TRUE;
    }
#line 50
  TOSH_CLR_PW4_PIN();
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 51
    {
      CounterM$mode = RISING_EDGE;
      CounterM$count = 0;
      CounterM$state = 0;
    }
#line 55
    __nesc_atomic_end(__nesc_atomic); }
  * (volatile uint8_t *)(0x02 + 0x20) &= ~(1 << 5);
  * (volatile uint8_t *)(0x03 + 0x20) |= 1 << 5;



  return SUCCESS;
}

# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t SamplerM$CounterControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = CounterM$CounterControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 321 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static inline  result_t SamplerM$SamplerControl$init(void)
#line 321
{
  int i;

#line 323
  SamplerM$CounterControl$init();
  SamplerM$DioControl$init();
  SamplerM$IBADCcontrol$init();
  SamplerM$BatteryControl$init();
  SamplerM$TempHumControl$init();
  for (i = 0; i < 25; i++) {
      SamplerM$SampleRecord[i].sampling_interval = SAMPLE_RECORD_FREE;
      SamplerM$SampleRecord[i].ticks_left = 0xffff;
    }
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 332
    {
      SamplerM$flag25 = 0;
      SamplerM$flag33 = 0;
      SamplerM$flag50 = 0;
    }
#line 336
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t XMDA300M$SamplerControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = SamplerM$SamplerControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 30 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\NoLeds.nc"
static inline   result_t NoLeds$Leds$init(void)
#line 30
{
  return SUCCESS;
}

# 35 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
inline static   result_t XMDA300M$Leds$init(void){
#line 35
  unsigned char result;
#line 35

#line 35
  result = NoLeds$Leds$init();
#line 35

#line 35
  return result;
#line 35
}
#line 35
# 303 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\apps\\xmesh\\XMDA300\\XMDA300M.nc"
static inline  result_t XMDA300M$StdControl$init(void)
#line 303
{

  XMDA300M$Leds$init();
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 306
    {
      XMDA300M$msg_ptr = &XMDA300M$msg_send_buffer;
    }
#line 308
    __nesc_atomic_end(__nesc_atomic); }


  XMDA300M$msg_status = 0;
  XMDA300M$pkt_full = 0x1FF;

  * (volatile uint8_t *)(0x1A + 0x20) |= 1 << 5;
  * (volatile uint8_t *)0x61 &= ~(1 << 7);



  TOSH_MAKE_FLASH_OUT_OUTPUT();
  TOSH_MAKE_FLASH_CLK_OUTPUT();

  XMDA300M$SamplerControl$init();
  XMDA300M$initialize();
  return SUCCESS;
}

# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\SerialId.nc"
static inline  result_t SerialId$StdControl$init(void)
#line 26
{
  SerialId$gfReadBusy = FALSE;
  TOSH_MAKE_SERIAL_ID_INPUT();
  return SUCCESS;
}

# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t RecoverSystemParamsM$DS2401$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = SerialId$StdControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 62 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverSystemParamsM.nc"
static inline  result_t RecoverSystemParamsM$XEESubControl$init(void)
{
  RecoverSystemParamsM$DS2401$init();
  return SUCCESS;
}

# 35 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
inline static   result_t EEPROMConfigM$Leds$init(void){
#line 35
  unsigned char result;
#line 35

#line 35
  result = NoLeds$Leds$init();
#line 35

#line 35
  return result;
#line 35
}
#line 35
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\InternalEEPROMM.nc"
static inline  result_t InternalEEPROMM$StdControl$init(void)
{
  return SUCCESS;
}

# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t EEPROMConfigM$EEPROMstdControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = InternalEEPROMM$StdControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 76 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\EEPROMConfigM.nc"
static inline  result_t EEPROMConfigM$StdControl$init(void)
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 78
    {
      EEPROMConfigM$paramState = EEPROMConfigM$PARAM_NEVER_STARTED;
      EEPROMConfigM$nextParamID = 0;
    }
#line 81
    __nesc_atomic_end(__nesc_atomic); }
  EEPROMConfigM$EEPROMstdControl$init();
  EEPROMConfigM$Leds$init();
  return SUCCESS;
}

# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t RealMain$StdControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = TimerM$StdControl$init();
#line 41
  result = rcombine(result, TimerM$StdControl$init());
#line 41
  result = rcombine(result, EEPROMConfigM$StdControl$init());
#line 41
  result = rcombine(result, RecoverSystemParamsM$XEESubControl$init());
#line 41
  result = rcombine(result, TimerM$StdControl$init());
#line 41
  result = rcombine(result, XMDA300M$StdControl$init());
#line 41
  result = rcombine(result, QueuedSendM$StdControl$init());
#line 41
  result = rcombine(result, XMeshC$StdControl$init());
#line 41
  result = rcombine(result, AMPromiscuous$Control$init());
#line 41
  result = rcombine(result, TimerM$StdControl$init());
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 128 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\HPLClock.nc"
static inline   result_t HPLClock$Clock$setRate(char interval, char scale)
#line 128
{
  scale &= 0x7;
  scale |= 0x8;
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 131
    {
      * (volatile uint8_t *)(0x37 + 0x20) &= ~(1 << 0);
      * (volatile uint8_t *)(0x37 + 0x20) &= ~(1 << 1);
      * (volatile uint8_t *)(0x30 + 0x20) |= 1 << 3;


      * (volatile uint8_t *)(0x33 + 0x20) = scale;
      * (volatile uint8_t *)(0x32 + 0x20) = 0;
      * (volatile uint8_t *)(0x31 + 0x20) = interval;
      * (volatile uint8_t *)(0x37 + 0x20) |= 1 << 1;
    }
#line 141
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

# 75 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Clock.nc"
inline static   result_t TimerM$Clock$setRate(char arg_0x1a8d84d8, char arg_0x1a8d8658){
#line 75
  unsigned char result;
#line 75

#line 75
  result = HPLClock$Clock$setRate(arg_0x1a8d84d8, arg_0x1a8d8658);
#line 75

#line 75
  return result;
#line 75
}
#line 75
# 185 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline void TOSH_MAKE_I2C_BUS1_SDA_OUTPUT(void)
#line 185
{
#line 185
  * (volatile uint8_t *)(0x11 + 0x20) |= 1 << 1;
}

# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\I2CM.nc"
static inline void I2CM$MAKE_DATA_OUTPUT(void)
#line 53
{
#line 53
  TOSH_MAKE_I2C_BUS1_SDA_OUTPUT();
}

# 184 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline void TOSH_MAKE_I2C_BUS1_SCL_OUTPUT(void)
#line 184
{
#line 184
  * (volatile uint8_t *)(0x11 + 0x20) |= 1 << 0;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\I2CM.nc"
static inline void I2CM$MAKE_CLOCK_OUTPUT(void)
#line 48
{
#line 48
  TOSH_MAKE_I2C_BUS1_SCL_OUTPUT();
}

# 185 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline void TOSH_SET_I2C_BUS1_SDA_PIN(void)
#line 185
{
#line 185
  * (volatile uint8_t *)(0x12 + 0x20) |= 1 << 1;
}

# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\I2CM.nc"
static inline void I2CM$SET_DATA(void)
#line 51
{
#line 51
  TOSH_SET_I2C_BUS1_SDA_PIN();
}

# 184 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline void TOSH_SET_I2C_BUS1_SCL_PIN(void)
#line 184
{
#line 184
  * (volatile uint8_t *)(0x12 + 0x20) |= 1 << 0;
}

# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\I2CM.nc"
static inline void I2CM$SET_CLOCK(void)
#line 46
{
#line 46
  TOSH_SET_I2C_BUS1_SCL_PIN();
}

#line 155
static inline  result_t I2CM$StdControl$init(void)
#line 155
{
  I2CM$SET_CLOCK();
  I2CM$SET_DATA();
  I2CM$MAKE_CLOCK_OUTPUT();
  I2CM$MAKE_DATA_OUTPUT();
  I2CM$state = 0;
  I2CM$local_data = 0;
  return SUCCESS;
}

# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t I2CPacketM$I2CStdControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = I2CM$StdControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 85 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLADCM.nc"
static inline   result_t HPLADCM$ADC$init(void)
#line 85
{
  HPLADCM$init_portmap();



  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 90
    {
      * (volatile uint8_t *)(0x06 + 0x20) = (1 << 3) | (6 << 0);

      * (volatile uint8_t *)(0x07 + 0x20) = 0;
    }
#line 94
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLADC.nc"
inline static   result_t ADCREFM$HPLADC$init(void){
#line 33
  unsigned char result;
#line 33

#line 33
  result = HPLADCM$ADC$init();
#line 33

#line 33
  return result;
#line 33
}
#line 33
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t AMPromiscuous$TimerControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = TimerM$StdControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 40 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\UARTM.nc"
static inline  result_t UARTM$Control$init(void)
#line 40
{
  {
  }
#line 41
  ;
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 42
    {
      UARTM$state = FALSE;
    }
#line 44
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t FramerM$ByteControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = UARTM$Control$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 308 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\FramerM.nc"
static inline  result_t FramerM$StdControl$init(void)
#line 308
{
  FramerM$HDLCInitialize();
  return FramerM$ByteControl$init();
}

# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t AMPromiscuous$UARTControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = FramerM$StdControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 148 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420Control.nc"
inline static   result_t CC2420RadioM$CC2420Control$disableAutoAck(void){
#line 148
  unsigned char result;
#line 148

#line 148
  result = CC2420ControlM$CC2420Control$disableAutoAck();
#line 148

#line 148
  return result;
#line 148
}
#line 148
# 58 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420.nc"
inline static   uint8_t CC2420ControlM$HPLChipcon$write(uint8_t arg_0x1a6b1bb0, uint16_t arg_0x1a6b1d40){
#line 58
  unsigned char result;
#line 58

#line 58
  result = HPLCC2420M$HPLCC2420$write(arg_0x1a6b1bb0, arg_0x1a6b1d40);
#line 58

#line 58
  return result;
#line 58
}
#line 58
# 413 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420ControlM.nc"
static inline   result_t CC2420ControlM$CC2420Control$disableAddrDecode(void)
#line 413
{
  CC2420ControlM$gCurrentParameters[CP_MDMCTRL0] &= ~(1 << 11);
  return CC2420ControlM$HPLChipcon$write(0x11, CC2420ControlM$gCurrentParameters[CP_MDMCTRL0]);
}

# 168 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420Control.nc"
inline static   result_t CC2420RadioM$CC2420Control$disableAddrDecode(void){
#line 168
  unsigned char result;
#line 168

#line 168
  result = CC2420ControlM$CC2420Control$disableAddrDecode();
#line 168

#line 168
  return result;
#line 168
}
#line 168
# 1082 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static inline   void CC2420RadioM$MacControl$disableAddrDecode(void)
#line 1082
{
  CC2420RadioM$CC2420Control$disableAddrDecode();
  CC2420RadioM$CC2420Control$disableAutoAck();
  CC2420RadioM$bAckManual = TRUE;
}

#line 1110
static inline   void CC2420RadioM$MacControl$disableAck(void)
#line 1110
{
  CC2420RadioM$bAckEnable = FALSE;
  CC2420RadioM$CC2420Control$disableAutoAck();
}

# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Random.nc"
inline static   result_t CC2420RadioM$Random$init(void){
#line 36
  unsigned char result;
#line 36

#line 36
  result = RandomLFSR$Random$init();
#line 36

#line 36
  return result;
#line 36
}
#line 36
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t CC2420RadioM$TimerControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = TimerM$StdControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 150 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline void TOSH_MAKE_CC_CS_OUTPUT(void)
#line 150
{
#line 150
  * (volatile uint8_t *)(0x17 + 0x20) |= 1 << 0;
}

# 58 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLCC2420M.nc"
static inline  result_t HPLCC2420M$StdControl$init(void)
#line 58
{

  HPLCC2420M$bSpiAvail = TRUE;
  TOSH_MAKE_MISO_INPUT();
  TOSH_MAKE_MOSI_OUTPUT();
  TOSH_MAKE_SPI_SCK_OUTPUT();
  TOSH_MAKE_CC_RSTN_OUTPUT();
  TOSH_MAKE_CC_VREN_OUTPUT();
  TOSH_MAKE_CC_CS_OUTPUT();
  TOSH_MAKE_CC_FIFOP1_INPUT();
  TOSH_MAKE_CC_CCA_INPUT();
  TOSH_MAKE_CC_SFD_INPUT();
  TOSH_MAKE_CC_FIFO_INPUT();
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 71
    {
      TOSH_MAKE_SPI_SCK_OUTPUT();
      TOSH_MAKE_MISO_INPUT();
      TOSH_MAKE_MOSI_OUTPUT();
      * (volatile uint8_t *)(0x0E + 0x20) |= 1 << 0;
      * (volatile uint8_t *)(0x0D + 0x20) |= 1 << 4;
      * (volatile uint8_t *)(0x0D + 0x20) &= ~(1 << 3);
      * (volatile uint8_t *)(0x0D + 0x20) &= ~(1 << 2);
      * (volatile uint8_t *)(0x0D + 0x20) &= ~(1 << 1);
      * (volatile uint8_t *)(0x0D + 0x20) &= ~(1 << 0);

      * (volatile uint8_t *)(0x0D + 0x20) |= 1 << 6;
    }
#line 83
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t CC2420ControlM$HPLChipconControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = HPLCC2420M$StdControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 298 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420Const.h"
static void __inline TOSH_uwait2(int u_sec)
#line 298
{
  while (u_sec > 0) {
       __asm volatile ("nop");
      u_sec--;
    }
}

# 143 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline void TOSH_SET_CC_VREN_PIN(void)
#line 143
{
#line 143
  * (volatile uint8_t *)(0x1B + 0x20) |= 1 << 5;
}

# 126 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420ControlM.nc"
static inline  result_t CC2420ControlM$StdControl$init(void)
#line 126
{


  TOSH_SET_CC_VREN_PIN();
  TOSH_uwait2(600);

  CC2420ControlM$HPLChipconControl$init();


  CC2420ControlM$gCurrentParameters[CP_MAIN] = 0xf800;

  CC2420ControlM$gCurrentParameters[CP_MDMCTRL0] = ((((
  0 << 11) | (
  2 << 8)) | (3 << 6)) | (
  1 << 5)) | (2 << 0);

  CC2420ControlM$gCurrentParameters[CP_MDMCTRL1] = 20 << 6;

  CC2420ControlM$gCurrentParameters[CP_RSSI] = 0xE080;

  CC2420ControlM$gCurrentParameters[CP_SYNCWORD] = 0xA70F;

  CC2420ControlM$gCurrentParameters[CP_TXCTRL] = ((((
  1 << 14) | (
  1 << 13)) | (
  3 << 6)) | (
  1 << 5)) | (
  TOS_CC2420_TXPOWER << 0);

  CC2420ControlM$gCurrentParameters[CP_RXCTRL0] = (((((
  1 << 12) | (
  2 << 8)) | (
  3 << 6)) | (
  2 << 4)) | (
  1 << 2)) | (
  1 << 0);

  CC2420ControlM$gCurrentParameters[CP_RXCTRL1] = (((((
  1 << 11) | (
  1 << 9)) | (
  1 << 6)) | (
  1 << 4)) | (
  1 << 2)) | (
  2 << 0);

  CC2420ControlM$gCurrentParameters[CP_FSCTRL] = (
  1 << 14) | ((
  357 + 5 * (TOS_CC2420_CHANNEL - 11)) << 0);

  CC2420ControlM$gCurrentParameters[CP_SECCTRL0] = (((
  1 << 8) | (
  1 << 7)) | (
  1 << 6)) | (
  1 << 2);

  CC2420ControlM$gCurrentParameters[CP_SECCTRL1] = 0;
  CC2420ControlM$gCurrentParameters[CP_BATTMON] = 0;








  CC2420ControlM$gCurrentParameters[CP_IOCFG0] = (
  100 << 0) | (
  1 << 9);

  CC2420ControlM$gCurrentParameters[CP_IOCFG1] = 0;

  return SUCCESS;
}

# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t CC2420RadioM$CC2420StdControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = CC2420ControlM$StdControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 557 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static inline  result_t CC2420RadioM$StdControl$init(void)
#line 557
{

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 559
    {
      CC2420RadioM$RadioState = CC2420RadioM$DISABLED_STATE;
      CC2420RadioM$currentDSN = 0;
      CC2420RadioM$bAckEnable = FALSE;
      CC2420RadioM$bAckManual = TRUE;
      CC2420RadioM$rxbufptr = &CC2420RadioM$RxBuf;
      CC2420RadioM$rxbufptr->length = 0;
      CC2420RadioM$rxlength = MSG_DATA_SIZE - 2;

      CC2420RadioM$gImmedSendDone = FAIL;
    }
#line 569
    __nesc_atomic_end(__nesc_atomic); }

  CC2420RadioM$CC2420StdControl$init();
  CC2420RadioM$TimerControl$init();
  CC2420RadioM$Random$init();
  CC2420RadioM$LocalAddr = TOS_LOCAL_ADDRESS;

  CC2420RadioM$MacControl$disableAck();
  CC2420RadioM$MacControl$disableAddrDecode();








  return SUCCESS;
}

# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t AMPromiscuous$RadioControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = CC2420RadioM$StdControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 150 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline void TOSH_SET_CC_CS_PIN(void)
#line 150
{
#line 150
  * (volatile uint8_t *)(0x18 + 0x20) |= 1 << 0;
}

# 64 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\TimerM.nc"
static inline  result_t TimerM$StdControl$start(void)
#line 64
{
  return SUCCESS;
}

# 84 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Queue\\QueuedSendM.nc"
static inline  result_t QueuedSendM$StdControl$start(void)
#line 84
{
  return SUCCESS;
}

# 140 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\apps\\xmesh\\XMDA300\\XMDA300M.nc"
inline static  void XMDA300M$health_packet(bool arg_0x1ad1f618, uint16_t arg_0x1ad1f7a8){
#line 140
  XMeshC$health_packet(arg_0x1ad1f618, arg_0x1ad1f7a8);
#line 140
}
#line 140
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
inline static  result_t XMDA300M$Timer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500){
#line 37
  unsigned char result;
#line 37

#line 37
  result = TimerM$Timer$start(0U, arg_0x1a5d5368, arg_0x1a5d5500);
#line 37

#line 37
  return result;
#line 37
}
#line 37
# 141 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\apps\\xmesh\\XMDA300\\XMDA300M.nc"
inline static  HealthMsg *XMDA300M$HealthMsgGet(void){
#line 141
  struct _health_msg_ *result;
#line 141

#line 141
  result = XMeshC$HealthMsgGet();
#line 141

#line 141
  return result;
#line 141
}
#line 141
#line 334
static inline  result_t XMDA300M$StdControl$start(void)
#line 334
{

  XMDA300M$h_msg = XMDA300M$HealthMsgGet();
  XMDA300M$h_msg->rsvd_app_type = 0x81;
  XMDA300M$Timer$start(TIMER_REPEAT, timer_rate);
  XMDA300M$health_packet(TRUE, TOS_HEALTH_UPDATE);
  return SUCCESS;
}

# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\SerialId.nc"
static inline  result_t SerialId$StdControl$stop(void)
#line 37
{
  TOSH_CLR_SERIAL_ID_PIN();
  return SUCCESS;
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t RecoverSystemParamsM$DS2401$stop(void){
#line 56
  unsigned char result;
#line 56

#line 56
  result = SerialId$StdControl$stop();
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 170 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverSystemParamsM.nc"
static inline  result_t RecoverSystemParamsM$HardwareId$readDone(uint8_t *id, result_t success)
{
  RecoverSystemParamsM$DS2401$stop();
  return SUCCESS;
}

# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HardwareId.nc"
inline static  result_t SerialId$HardwareId$readDone(uint8_t *arg_0x1ad9da40, result_t arg_0x1ad9dbd0){
#line 31
  unsigned char result;
#line 31

#line 31
  result = RecoverSystemParamsM$HardwareId$readDone(arg_0x1ad9da40, arg_0x1ad9dbd0);
#line 31

#line 31
  return result;
#line 31
}
#line 31
# 121 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline int TOSH_READ_SERIAL_ID_PIN(void)
#line 121
{
#line 121
  return (* (volatile uint8_t *)(0x19 + 0x20) & (1 << 4)) != 0;
}

#line 121
static __inline void TOSH_SET_SERIAL_ID_PIN(void)
#line 121
{
#line 121
  * (volatile uint8_t *)(0x1B + 0x20) |= 1 << 4;
}

#line 121
static __inline void TOSH_MAKE_SERIAL_ID_OUTPUT(void)
#line 121
{
#line 121
  * (volatile uint8_t *)(0x1A + 0x20) |= 1 << 4;
}

# 52 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\SerialId.nc"
static inline uint8_t SerialId$serialIdByteRead(void)
#line 52
{
  uint8_t i;
#line 53
  uint8_t data = 0;

  for (i = 0; i < 8; i++) {
      data >>= 1;
      TOSH_MAKE_SERIAL_ID_OUTPUT();
#line 57
      TOSH_CLR_SERIAL_ID_PIN();
#line 57
      ;
      TOSH_uwait(1);
      TOSH_SET_SERIAL_ID_PIN();
#line 59
      TOSH_MAKE_SERIAL_ID_INPUT();
#line 59
      ;
      TOSH_uwait(10);
      if (TOSH_READ_SERIAL_ID_PIN()) {
          data |= 0x80;
        }
      TOSH_uwait(50);
    }
  return data;
}

static inline void SerialId$serialIdByteWrite(uint8_t data)
#line 69
{
  uint8_t i;

  for (i = 0; i < 8; i++) {
      TOSH_MAKE_SERIAL_ID_OUTPUT();
#line 73
      TOSH_CLR_SERIAL_ID_PIN();
#line 73
      ;
      TOSH_uwait(1);
      if (data & 0x1) {
          TOSH_SET_SERIAL_ID_PIN();
#line 76
          TOSH_MAKE_SERIAL_ID_INPUT();
#line 76
          ;
        }
      TOSH_uwait(70);
      TOSH_SET_SERIAL_ID_PIN();
#line 79
      TOSH_MAKE_SERIAL_ID_INPUT();
#line 79
      ;
      TOSH_uwait(2);
      data >>= 1;
    }
}

static inline  void SerialId$serialIdRead(void)
#line 85
{
  uint8_t cnt = 0;
  result_t success = FAIL;

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 89
    {

      TOSH_CLR_SERIAL_ID_PIN();

      TOSH_MAKE_SERIAL_ID_OUTPUT();
#line 93
      TOSH_CLR_SERIAL_ID_PIN();
#line 93
      ;
      TOSH_uwait(500);
      cnt = 0;
      TOSH_SET_SERIAL_ID_PIN();
#line 96
      TOSH_MAKE_SERIAL_ID_INPUT();
#line 96
      ;


      while (TOSH_READ_SERIAL_ID_PIN() && cnt < 30) {
          cnt++;
          TOSH_uwait(30);
        }


      while (0 == TOSH_READ_SERIAL_ID_PIN() && cnt < 30) {
          cnt++;
          TOSH_uwait(30);
        }

      if (cnt < 30) {
          TOSH_uwait(500);
          SerialId$serialIdByteWrite(0x33);
          for (cnt = 0; cnt < HARDWARE_ID_LEN; cnt++) 
            SerialId$serialId[cnt] = SerialId$serialIdByteRead();

          success = SUCCESS;
        }
    }
#line 118
    __nesc_atomic_end(__nesc_atomic); }


  SerialId$gfReadBusy = FALSE;
  SerialId$HardwareId$readDone(SerialId$serialId, success);
}

static inline  result_t SerialId$HardwareId$read(uint8_t *id)
#line 125
{
  if (!SerialId$gfReadBusy) {
      SerialId$gfReadBusy = TRUE;
      SerialId$serialId = id;
      TOS_post(SerialId$serialIdRead);
      return SUCCESS;
    }
  return FAIL;
}

# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HardwareId.nc"
inline static  result_t RecoverSystemParamsM$HardwareId$read(uint8_t *arg_0x1ad9d338){
#line 22
  unsigned char result;
#line 22

#line 22
  result = SerialId$HardwareId$read(arg_0x1ad9d338);
#line 22

#line 22
  return result;
#line 22
}
#line 22
# 32 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\SerialId.nc"
static inline  result_t SerialId$StdControl$start(void)
#line 32
{
  TOSH_SET_SERIAL_ID_PIN();
  return SUCCESS;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t RecoverSystemParamsM$DS2401$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = SerialId$StdControl$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 68 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverSystemParamsM.nc"
static inline  result_t RecoverSystemParamsM$XEESubControl$start(void)
{
  RecoverSystemParamsM$DS2401$start();
  RecoverSystemParamsM$HardwareId$read(&RecoverSystemParamsM$DSSerialID[0]);
  return SUCCESS;
}

# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReadData.nc"
inline static  result_t EEPROMConfigM$ReadData$read(uint32_t arg_0x1ae364d0, uint8_t *arg_0x1ae36678, uint32_t arg_0x1ae36810){
#line 33
  unsigned char result;
#line 33

#line 33
  result = InternalEEPROMM$ReadData$read(arg_0x1ae364d0, arg_0x1ae36678, arg_0x1ae36810);
#line 33

#line 33
  return result;
#line 33
}
#line 33
# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\InternalEEPROMM.nc"
static inline  result_t InternalEEPROMM$StdControl$start(void)
{
  return SUCCESS;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t EEPROMConfigM$EEPROMstdControl$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = InternalEEPROMM$StdControl$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 88 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\EEPROMConfigM.nc"
static inline  result_t EEPROMConfigM$StdControl$start(void)
{


  if (EEPROMConfigM$paramState == EEPROMConfigM$PARAM_IDLE) {
#line 92
    return SUCCESS;
    }
#line 93
  if (EEPROMConfigM$paramState == EEPROMConfigM$PARAM_NEVER_STARTED) {
      EEPROMConfigM$paramState = EEPROMConfigM$PARAM_IDLE;
      EEPROMConfigM$EEPROMstdControl$start();

      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 97
        {
          EEPROMConfigM$paramState = EEPROMConfigM$PARAM_READ_VERSION;
          EEPROMConfigM$currentBlock = 0;
          EEPROMConfigM$rescanRequired = FALSE;
        }
#line 101
        __nesc_atomic_end(__nesc_atomic); }
      EEPROMConfigM$ReadData$read(EEPROMConfigM$currentBlock, &EEPROMConfigM$flashTemp.data[0], sizeof(FlashVersionBlock_t ));
    }
  return SUCCESS;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t RealMain$StdControl$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = TimerM$StdControl$start();
#line 48
  result = rcombine(result, TimerM$StdControl$start());
#line 48
  result = rcombine(result, EEPROMConfigM$StdControl$start());
#line 48
  result = rcombine(result, RecoverSystemParamsM$XEESubControl$start());
#line 48
  result = rcombine(result, TimerM$StdControl$start());
#line 48
  result = rcombine(result, XMDA300M$StdControl$start());
#line 48
  result = rcombine(result, QueuedSendM$StdControl$start());
#line 48
  result = rcombine(result, XMeshC$StdControl$start());
#line 48
  result = rcombine(result, AMPromiscuous$Control$start());
#line 48
  result = rcombine(result, TimerM$StdControl$start());
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 189 "C:\\Crossbow\\cygwin\\usr\\local\\avr\\include\\avr\\eeprom.h" 3
#line 188
uint8_t 
eeprom_read_byte(const uint8_t *addr)
{
  uint8_t result;

#line 192
   __asm volatile (
  "call"" __eeprom_read_byte_""1C1D1E""\n\t"
  "mov %1,__tmp_reg__" : 
  "+x"(addr), 
  "=r"(result));

  return result;
}

# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigSave.nc"
inline static  result_t EEPROMConfigM$ConfigSave$saveDone(result_t arg_0x1ad77d68, AppParamID_t arg_0x1ad77ef8){
#line 45
  unsigned char result;
#line 45

#line 45
  result = XCommandM$ConfigSave$saveDone(arg_0x1ad77d68, arg_0x1ad77ef8);
#line 45

#line 45
  return result;
#line 45
}
#line 45
# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\WriteData.nc"
inline static  result_t EEPROMConfigM$WriteData$write(uint32_t arg_0x1ae3a9e0, uint8_t *arg_0x1ae3ab88, uint32_t arg_0x1ae3ad20){
#line 33
  unsigned char result;
#line 33

#line 33
  result = InternalEEPROMM$WriteData$write(arg_0x1ae3a9e0, arg_0x1ae3ab88, arg_0x1ae3ad20);
#line 33

#line 33
  return result;
#line 33
}
#line 33
# 78 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
static inline  size_t RecoverParamsM$ExternalConfig$get(AppParamID_t id, void *buffer, size_t available)
#line 78
{
  return RecoverParamsM$Config$get(id, buffer, available);
}

# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
inline static  size_t EEPROMConfigM$Config$get(AppParamID_t arg_0x1ae3e088, void *arg_0x1ad7b6b8, size_t arg_0x1ad7b840){
#line 43
  unsigned int result;
#line 43

#line 43
  result = RecoverParamsM$ExternalConfig$get(arg_0x1ae3e088, arg_0x1ad7b6b8, arg_0x1ad7b840);
#line 43

#line 43
  return result;
#line 43
}
#line 43
# 197 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\tos.h"
static inline void *nmemset(void *to, int val, size_t n)
{
  char *cto = to;

  while (n--) * cto++ = val;

  return to;
}

# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
static inline  result_t RecoverParamsM$ExternalConfig$set(AppParamID_t id, void *buffer, size_t size)
#line 45
{
  return RecoverParamsM$Config$set(id, buffer, size);
}

# 57 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
inline static  result_t EEPROMConfigM$Config$set(AppParamID_t arg_0x1ae3e088, void *arg_0x1ad7bcf0, size_t arg_0x1ad7be78){
#line 57
  unsigned char result;
#line 57

#line 57
  result = RecoverParamsM$ExternalConfig$set(arg_0x1ae3e088, arg_0x1ad7bcf0, arg_0x1ad7be78);
#line 57

#line 57
  return result;
#line 57
}
#line 57
# 20 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XEEControl.nc"
inline static  result_t EEPROMConfigM$XEEControl$restoreDone(result_t arg_0x1ad06218){
#line 20
  unsigned char result;
#line 20

#line 20
  result = XMDA300M$XEEControl$restoreDone(arg_0x1ad06218);
#line 20

#line 20
  return result;
#line 20
}
#line 20
# 290 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\EEPROMConfigM.nc"
static inline  result_t EEPROMConfigM$ReadData$readDone(uint8_t *pReadBuffer, uint32_t readByteCount, result_t result)
{
  char localState;
  uint16_t localBlock;

#line 294
  if (pReadBuffer != &EEPROMConfigM$flashTemp.data[0]) {




      EEPROMConfigM$paramState = EEPROMConfigM$PARAM_IDLE;
      return SUCCESS;
    }
  if (result == FAIL) {
      EEPROMConfigM$paramState = EEPROMConfigM$PARAM_IDLE;

      return SUCCESS;
    }
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 307
    localState = EEPROMConfigM$paramState;
#line 307
    __nesc_atomic_end(__nesc_atomic); }


  switch (localState) {
      case EEPROMConfigM$PARAM_READ_VERSION: 
        {
          if (1 != EEPROMConfigM$flashTemp.versionInfo.vHdr.majorVersion) {
              EEPROMConfigM$paramState = EEPROMConfigM$PARAM_IDLE;
              return SUCCESS;
            }
          if (!EEPROMConfigM$checkBlockCRC(& EEPROMConfigM$flashTemp.versionInfo, sizeof(FlashVersionBlock_t ))) {


              EEPROMConfigM$paramState = EEPROMConfigM$PARAM_IDLE;
              return SUCCESS;
            }
          EEPROMConfigM$paramState = EEPROMConfigM$PARAM_READ_PARAMETER;
          EEPROMConfigM$currentBlock += sizeof(FlashVersionBlock_t );
          EEPROMConfigM$ReadData$read(EEPROMConfigM$currentBlock, &EEPROMConfigM$flashTemp.data[0], sizeof(ParameterBlock_t ));
          return SUCCESS;
        }
      break;
      case EEPROMConfigM$PARAM_READ_PARAMETER: 
        {
          if (EEPROMConfigM$flashTemp.param.paHdr.paramID == TOS_UNUSED_PARAMETER) {


              EEPROMConfigM$paramState = EEPROMConfigM$PARAM_IDLE;
              return EEPROMConfigM$XEEControl$restoreDone(FAIL);
            }
          EEPROMConfigM$currentBlock += sizeof(ParameterHeader_t ) + EEPROMConfigM$flashTemp.param.paHdr.count;
          if (!EEPROMConfigM$checkBlockCRC(& EEPROMConfigM$flashTemp.param.paHdr, sizeof(ParameterHeader_t ) + EEPROMConfigM$flashTemp.param.paHdr.count)) {


              EEPROMConfigM$paramState = EEPROMConfigM$PARAM_IDLE;
              return EEPROMConfigM$XEEControl$restoreDone(FAIL);
            }
          if (EEPROMConfigM$flashTemp.param.paHdr.paramID == TOS_NO_PARAMETER) {

              EEPROMConfigM$paramState = EEPROMConfigM$PARAM_IDLE;
              return EEPROMConfigM$XEEControl$restoreDone(SUCCESS);
            }

          if (
#line 349
          EEPROMConfigM$flashTemp.param.paHdr.applicationID != TOS_NO_APPLICATION
           && EEPROMConfigM$flashTemp.param.paHdr.paramID != TOS_IGNORE_PARAMETER) {

              if (SUCCESS != EEPROMConfigM$Config$set((AppParamID_t )(((uint32_t )EEPROMConfigM$flashTemp.param.paHdr.applicationID << 8) | (ParameterID_t )EEPROMConfigM$flashTemp.param.paHdr.paramID), & EEPROMConfigM$flashTemp.param.data, 

              EEPROMConfigM$flashTemp.param.paHdr.count)) {
                }
            }

          EEPROMConfigM$paramState = EEPROMConfigM$PARAM_READ_PARAMETER;
          EEPROMConfigM$ReadData$read(EEPROMConfigM$currentBlock, &EEPROMConfigM$flashTemp.data[0], sizeof(ParameterBlock_t ));
          return SUCCESS;
        }
      break;
      case EEPROMConfigM$PARAM_SAVE_VERSION: 
        {









          if (1 != EEPROMConfigM$flashTemp.versionInfo.vHdr.majorVersion) {









              EEPROMConfigM$flashTemp.versionInfo.vHdr.majorVersion = 1;
              EEPROMConfigM$flashTemp.versionInfo.vHdr.minorVersion = 1;
              EEPROMConfigM$flashTemp.versionInfo.vHdr.buildNumber = 0;
              EEPROMConfigM$flashTemp.versionInfo.vHdr.bytes = sizeof(FlashVersionBlock_t ) - sizeof(FlashVersionHeader_t );
              nmemset(& EEPROMConfigM$flashTemp.versionInfo.d.data, 0, sizeof(FlashVersionData_t ));
              EEPROMConfigM$setBlockCRC(& EEPROMConfigM$flashTemp.versionInfo, sizeof(FlashVersionBlock_t ));
              EEPROMConfigM$currentBlock = 0;
              localBlock = EEPROMConfigM$currentBlock;
              EEPROMConfigM$currentBlock += sizeof(FlashVersionBlock_t );
              EEPROMConfigM$WriteData$write(localBlock, &EEPROMConfigM$flashTemp.data[0], sizeof(FlashVersionBlock_t ));

              return SUCCESS;
            }
          if (!EEPROMConfigM$checkBlockCRC(& EEPROMConfigM$flashTemp.versionInfo, sizeof(FlashVersionBlock_t ))) {


              EEPROMConfigM$paramState = EEPROMConfigM$PARAM_IDLE;
              EEPROMConfigM$ConfigSave$saveDone(FAIL, (AppParamID_t )(((uint32_t )((uint32_t )EEPROMConfigM$endAppParam >> 8) << 8) | (ParameterID_t )EEPROMConfigM$nextParamID));
              return SUCCESS;
            }
          if (1 != EEPROMConfigM$flashTemp.versionInfo.vHdr.majorVersion) {


              EEPROMConfigM$paramState = EEPROMConfigM$PARAM_IDLE;
              EEPROMConfigM$ConfigSave$saveDone(FAIL, (AppParamID_t )(((uint32_t )((uint32_t )EEPROMConfigM$endAppParam >> 8) << 8) | (ParameterID_t )EEPROMConfigM$nextParamID));
              return SUCCESS;
            }
          EEPROMConfigM$paramState = EEPROMConfigM$PARAM_SAVE_PARAMETERS;
          EEPROMConfigM$currentBlock += sizeof(FlashVersionBlock_t );
          EEPROMConfigM$ReadData$read(EEPROMConfigM$currentBlock, &EEPROMConfigM$flashTemp.data[0], sizeof(ParameterBlock_t ));

          return SUCCESS;
        }
      break;
      case EEPROMConfigM$PARAM_SAVE_PARAMETERS: 
        {
          if (EEPROMConfigM$flashTemp.param.paHdr.paramID == TOS_NO_PARAMETER) {




              EEPROMConfigM$paramState = EEPROMConfigM$PARAM_SAVE_NEW_PARAMETERS;
              EEPROMConfigM$writeTrailingParameter();
              return SUCCESS;
            }
          if (!EEPROMConfigM$checkBlockCRC(& EEPROMConfigM$flashTemp.param.paHdr, sizeof(ParameterHeader_t ) + EEPROMConfigM$flashTemp.param.paHdr.count)) {


              EEPROMConfigM$paramState = EEPROMConfigM$PARAM_IDLE;
              EEPROMConfigM$ConfigSave$saveDone(FAIL, (AppParamID_t )(((uint32_t )((uint32_t )EEPROMConfigM$endAppParam >> 8) << 8) | (ParameterID_t )EEPROMConfigM$nextParamID));
              return SUCCESS;
            }
          if ((uint32_t )EEPROMConfigM$endAppParam >> 8 == EEPROMConfigM$flashTemp.param.paHdr.applicationID) {
              if (EEPROMConfigM$flashTemp.param.paHdr.paramID == EEPROMConfigM$nextParamID) {

                  size_t paramSize;


                  paramSize = EEPROMConfigM$Config$get((AppParamID_t )(((uint32_t )((uint32_t )EEPROMConfigM$endAppParam >> 8) << 8) | (ParameterID_t )EEPROMConfigM$nextParamID), &EEPROMConfigM$flashTemp.param.data[0], sizeof  EEPROMConfigM$flashTemp.param.data);

                  if (paramSize != EEPROMConfigM$flashTemp.param.paHdr.count) {






                      EEPROMConfigM$flashTemp.param.paHdr.paramID = TOS_IGNORE_PARAMETER;
                    }
                  EEPROMConfigM$setBlockCRC(& EEPROMConfigM$flashTemp.param.paHdr, sizeof(ParameterHeader_t ) + EEPROMConfigM$flashTemp.param.paHdr.count);
                  localBlock = EEPROMConfigM$currentBlock;
                  EEPROMConfigM$currentBlock += sizeof(ParameterHeader_t ) + EEPROMConfigM$flashTemp.param.paHdr.count;
                  if (paramSize == EEPROMConfigM$flashTemp.param.paHdr.count) {
                      EEPROMConfigM$nextParamID += 1;
                    }
                  EEPROMConfigM$WriteData$write(localBlock, &EEPROMConfigM$flashTemp.data[0], sizeof(ParameterHeader_t ) + EEPROMConfigM$flashTemp.param.paHdr.count);
#line 473
                  return SUCCESS;
                }
              if (EEPROMConfigM$flashTemp.param.paHdr.paramID > EEPROMConfigM$nextParamID) {
#line 487
                  EEPROMConfigM$rescanRequired = TRUE;
                }
            }
          EEPROMConfigM$currentBlock += sizeof(ParameterHeader_t ) + EEPROMConfigM$flashTemp.param.paHdr.count;

          EEPROMConfigM$ReadData$read(EEPROMConfigM$currentBlock, &EEPROMConfigM$flashTemp.data[0], sizeof(ParameterBlock_t ));
          return SUCCESS;
        }
      break;
      case EEPROMConfigM$PARAM_SAVE_END_PARAM: 
        case EEPROMConfigM$PARAM_SAVE_NEW_PARAMETERS: 
          {
            EEPROMConfigM$paramState = EEPROMConfigM$PARAM_IDLE;
            EEPROMConfigM$ConfigSave$saveDone(FAIL, (AppParamID_t )(((uint32_t )((uint32_t )EEPROMConfigM$endAppParam >> 8) << 8) | (ParameterID_t )EEPROMConfigM$nextParamID));
            return FAIL;
          }

      default: 
        {
          EEPROMConfigM$paramState = EEPROMConfigM$PARAM_IDLE;
          return FAIL;
        }
      break;
    }
}

# 42 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReadData.nc"
inline static  result_t InternalEEPROMM$ReadData$readDone(uint8_t *arg_0x1ae35010, uint32_t arg_0x1ae351a8, result_t arg_0x1ae35338){
#line 42
  unsigned char result;
#line 42

#line 42
  result = EEPROMConfigM$ReadData$readDone(arg_0x1ae35010, arg_0x1ae351a8, arg_0x1ae35338);
#line 42

#line 42
  return result;
#line 42
}
#line 42
# 57 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLPowerManagementM.nc"
static inline uint8_t HPLPowerManagementM$getPowerLevel(void)
#line 57
{
  uint8_t diff;


  if (* (volatile uint8_t *)(0x37 + 0x20) & ~((1 << 1) | (1 << 0))) {
      return HPLPowerManagementM$IDLE;
    }
  else {
    if (* (volatile uint8_t *)(uint16_t )& * (volatile uint8_t *)(0x0D + 0x20) & (1 << 7)) {
        return HPLPowerManagementM$IDLE;
      }
    else {
#line 80
      if (* (volatile uint8_t *)0x9A & ((((1 << 7) | (1 << 6)) | (
      1 << 4)) | (1 << 3))) {
          return HPLPowerManagementM$IDLE;
        }
      else {
        if (* (volatile uint8_t *)(uint16_t )& * (volatile uint8_t *)(0x06 + 0x20) & (1 << 7)) {
            return HPLPowerManagementM$ADC_NR;
          }
        else {
          if (* (volatile uint8_t *)(0x37 + 0x20) & ((1 << 1) | (1 << 0))) {
              diff = * (volatile uint8_t *)(0x31 + 0x20) - * (volatile uint8_t *)(0x32 + 0x20);
              if (diff < 16) {
#line 91
                return HPLPowerManagementM$EXT_STANDBY;
                }
#line 92
              return HPLPowerManagementM$POWER_SAVE;
            }
          else {
              return HPLPowerManagementM$POWER_DOWN;
            }
          }
        }
      }
    }
}

#line 101
static inline  void HPLPowerManagementM$doAdjustment(void)
#line 101
{
  uint8_t foo;
#line 102
  uint8_t mcu;

#line 103
  foo = HPLPowerManagementM$getPowerLevel();
  mcu = * (volatile uint8_t *)(0x35 + 0x20);
  mcu &= 0xe3;
  if (foo == HPLPowerManagementM$EXT_STANDBY || foo == HPLPowerManagementM$POWER_SAVE) {
      mcu |= HPLPowerManagementM$IDLE;
      while ((* (volatile uint8_t *)(0x30 + 0x20) & 0x7) != 0) {
           __asm volatile ("nop");}

      mcu &= 0xe3;
    }
  mcu |= foo;
  * (volatile uint8_t *)(0x35 + 0x20) = mcu;
  * (volatile uint8_t *)(0x35 + 0x20) |= 1 << 5;
}

# 176 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverSystemParamsM.nc"
static inline  result_t RecoverSystemParamsM$SystemSerialNumber$set(void *buffer, size_t size)
#line 176
{
  return SUCCESS;
}











static inline  result_t RecoverSystemParamsM$SystemCPUOscillatorFrequency$set(void *buffer, size_t size)
#line 190
{
  int32_t value;

#line 192
  if (size != sizeof RecoverSystemParamsM$sysCPUOscillatorFrequency) {
    return FAIL;
    }
#line 194
  value = * (int32_t *)buffer;
  RecoverSystemParamsM$sysCPUOscillatorFrequency = value;
  return SUCCESS;
}

#line 233
static inline  result_t RecoverSystemParamsM$CrossbowFactoryInfo1$set(void *buffer, size_t size)
#line 233
{
  uint8_t *value;
  int i;

  if (size != 16 * sizeof(uint8_t )) {
    return FAIL;
    }
#line 239
  value = (uint8_t *)buffer;
  for (i = 0; i < 16; i++) RecoverSystemParamsM$xbowFacInfo1[i] = value[i];
  return SUCCESS;
}










static inline  result_t RecoverSystemParamsM$CrossbowFactoryInfo2$set(void *buffer, size_t size)
#line 253
{
  uint8_t *value;
  int i;

#line 256
  if (size != 16 * sizeof(uint8_t )) {
    return FAIL;
    }
#line 258
  value = (uint8_t *)buffer;
  for (i = 0; i < 16; i++) RecoverSystemParamsM$xbowFacInfo2[i] = value[i];
  return SUCCESS;
}










static inline  result_t RecoverSystemParamsM$CrossbowFactoryInfo3$set(void *buffer, size_t size)
#line 272
{
  uint8_t *value;
  int i;

#line 275
  if (size != 16 * sizeof(uint8_t )) {
    return FAIL;
    }
#line 277
  value = (uint8_t *)buffer;
  for (i = 0; i < 16; i++) RecoverSystemParamsM$xbowFacInfo3[i] = value[i];
  return SUCCESS;
}











static inline  result_t RecoverSystemParamsM$CrossbowFactoryInfo4$set(void *buffer, size_t size)
#line 292
{
  uint8_t *value;
  int i;

#line 295
  if (size != 16 * sizeof(uint8_t )) {
    return FAIL;
    }
#line 297
  value = (uint8_t *)buffer;
  for (i = 0; i < 16; i++) RecoverSystemParamsM$xbowFacInfo4[i] = value[i];
  return SUCCESS;
}










static inline  result_t RecoverSystemParamsM$XmeshAppTimerRate$set(void *buffer, size_t size)
#line 311
{
  int32_t value;

#line 313
  if (size != 4) {
    return FAIL;
    }
#line 315
  value = * (int32_t *)buffer;
  timer_rate = value;
  return SUCCESS;
}

#line 157
static inline  result_t RecoverSystemParamsM$SystemVendorID$set(uint16_t value)
#line 157
{
  RecoverSystemParamsM$sysVendorID = value;
  return SUCCESS;
}

#line 89
static inline  result_t RecoverSystemParamsM$SystemMoteID$set(uint16_t value)
#line 89
{




  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 94
    {
      TOS_LOCAL_ADDRESS = value;
    }
#line 96
    __nesc_atomic_end(__nesc_atomic); }

  return SUCCESS;
}

# 74 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
static inline   result_t RecoverParamsM$ConfigInt16$default$set(AppParamID_t id, uint16_t value)
#line 74
{
  return FAIL;
}

# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt16.nc"
inline static  result_t RecoverParamsM$ConfigInt16$set(AppParamID_t arg_0x1ad5d010, uint16_t arg_0x1ad5baa8){
#line 27
  unsigned char result;
#line 27

#line 27
  switch (arg_0x1ad5d010) {
#line 27
    case CONFIG_MOTE_ID:
#line 27
      result = RecoverSystemParamsM$SystemMoteID$set(arg_0x1ad5baa8);
#line 27
      break;
#line 27
    case CONFIG_MOTE_VENDOR:
#line 27
      result = RecoverSystemParamsM$SystemVendorID$set(arg_0x1ad5baa8);
#line 27
      break;
#line 27
    default:
#line 27
      result = RecoverParamsM$ConfigInt16$default$set(arg_0x1ad5d010, arg_0x1ad5baa8);
#line 27
      break;
#line 27
    }
#line 27

#line 27
  return result;
#line 27
}
#line 27
# 52 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420Control.nc"
inline static  result_t RecoverSystemParamsM$CC2420Control$TunePreset(uint8_t arg_0x1a6516c8){
#line 52
  unsigned char result;
#line 52

#line 52
  result = CC2420ControlM$CC2420Control$TunePreset(arg_0x1a6516c8);
#line 52

#line 52
  return result;
#line 52
}
#line 52
# 218 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverSystemParamsM.nc"
static inline  result_t RecoverSystemParamsM$RadioChannel$set(uint8_t value)
#line 218
{
  TOS_CC2420_CHANNEL = value;
#line 219
  RecoverSystemParamsM$CC2420Control$TunePreset(TOS_CC2420_CHANNEL);
  return SUCCESS;
}

# 127 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420Control.nc"
inline static  result_t RecoverSystemParamsM$CC2420Control$SetRFPower(uint8_t arg_0x1a664d48){
#line 127
  unsigned char result;
#line 127

#line 127
  result = CC2420ControlM$CC2420Control$SetRFPower(arg_0x1a664d48);
#line 127

#line 127
  return result;
#line 127
}
#line 127
# 205 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverSystemParamsM.nc"
static inline  result_t RecoverSystemParamsM$RadioPower$set(uint8_t value)
#line 205
{
  TOS_CC2420_TXPOWER = value;
#line 206
  RecoverSystemParamsM$CC2420Control$SetRFPower(TOS_CC2420_TXPOWER);
  return SUCCESS;
}

#line 147
static inline  result_t RecoverSystemParamsM$SystemRadioType$set(uint8_t value)
#line 147
{
  RecoverSystemParamsM$sysRadioType = value;
  return SUCCESS;
}

#line 137
static inline  result_t RecoverSystemParamsM$SystemMoteCPUType$set(uint8_t value)
#line 137
{
  RecoverSystemParamsM$sysMoteCPUType = value;
  return SUCCESS;
}

#line 127
static inline  result_t RecoverSystemParamsM$SystemSuModelType$set(uint8_t value)
#line 127
{
  RecoverSystemParamsM$sysSubModelType = value;
  return SUCCESS;
}

#line 117
static inline  result_t RecoverSystemParamsM$SystemModelType$set(uint8_t value)
#line 117
{
  RecoverSystemParamsM$sysModelType = value;
  return SUCCESS;
}

#line 107
static inline  result_t RecoverSystemParamsM$SystemGroupNumber$set(uint8_t value)
#line 107
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 108
    TOS_AM_GROUP = value;
#line 108
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

# 70 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
static inline   result_t RecoverParamsM$ConfigInt8$default$set(AppParamID_t id, uint8_t value)
#line 70
{
  return FAIL;
}

# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt8.nc"
inline static  result_t RecoverParamsM$ConfigInt8$set(AppParamID_t arg_0x1ad5e3c8, uint8_t arg_0x1ad71f10){
#line 27
  unsigned char result;
#line 27

#line 27
  switch (arg_0x1ad5e3c8) {
#line 27
    case CONFIG_MOTE_GROUP:
#line 27
      result = RecoverSystemParamsM$SystemGroupNumber$set(arg_0x1ad71f10);
#line 27
      break;
#line 27
    case CONFIG_MOTE_MODEL:
#line 27
      result = RecoverSystemParamsM$SystemModelType$set(arg_0x1ad71f10);
#line 27
      break;
#line 27
    case CONFIG_MOTE_SUBMODEL:
#line 27
      result = RecoverSystemParamsM$SystemSuModelType$set(arg_0x1ad71f10);
#line 27
      break;
#line 27
    case CONFIG_MOTE_CPU_TYPE:
#line 27
      result = RecoverSystemParamsM$SystemMoteCPUType$set(arg_0x1ad71f10);
#line 27
      break;
#line 27
    case CONFIG_MOTE_RADIO_TYPE:
#line 27
      result = RecoverSystemParamsM$SystemRadioType$set(arg_0x1ad71f10);
#line 27
      break;
#line 27
    case CONFIG_RF_POWER:
#line 27
      result = RecoverSystemParamsM$RadioPower$set(arg_0x1ad71f10);
#line 27
      break;
#line 27
    case CONFIG_RF_CHANNEL:
#line 27
      result = RecoverSystemParamsM$RadioChannel$set(arg_0x1ad71f10);
#line 27
      break;
#line 27
    default:
#line 27
      result = RecoverParamsM$ConfigInt8$default$set(arg_0x1ad5e3c8, arg_0x1ad71f10);
#line 27
      break;
#line 27
    }
#line 27

#line 27
  return result;
#line 27
}
#line 27
# 284 "C:\\Crossbow\\cygwin\\usr\\local\\avr\\include\\avr\\eeprom.h" 3
#line 283
void 
eeprom_write_byte(uint8_t *addr, uint8_t value)
{
   __asm volatile (
  "mov __tmp_reg__,%1""\n\t"
  "call"" __eeprom_write_byte_""1C1D1E" : 
  "+x"(addr) : 
  "r"(value) : 
  "memory");}

# 184 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\EEPROMConfigM.nc"
static inline  result_t EEPROMConfigM$WriteData$writeDone(uint8_t *pWriteBuffer, uint32_t writeNumBytesWrite, result_t result)
{
  uint16_t localBlock;

  switch (EEPROMConfigM$paramState) {
      case EEPROMConfigM$PARAM_SAVE_VERSION: 
        {



          EEPROMConfigM$paramState = EEPROMConfigM$PARAM_SAVE_NEW_PARAMETERS;
          EEPROMConfigM$writeTrailingParameter();
          return SUCCESS;
        }
      break;
      case EEPROMConfigM$PARAM_SAVE_NEW_PARAMETERS: 
        {

          if (!EEPROMConfigM$rescanRequired) {
#line 202
            EEPROMConfigM$findNextParameter();
            }
#line 203
          if (EEPROMConfigM$rescanRequired || EEPROMConfigM$nextParamID > (uint8_t )EEPROMConfigM$endAppParam) {







              EEPROMConfigM$paramState = EEPROMConfigM$PARAM_SAVE_END_PARAM;
              EEPROMConfigM$writeTrailingParameter();

              return SUCCESS;
            }
          {
            size_t paramSize;


            paramSize = EEPROMConfigM$Config$get((AppParamID_t )(((uint32_t )((uint32_t )EEPROMConfigM$endAppParam >> 8) << 8) | (ParameterID_t )EEPROMConfigM$nextParamID), &EEPROMConfigM$flashTemp.param.data[0], 
            sizeof  EEPROMConfigM$flashTemp.param.data);
            EEPROMConfigM$flashTemp.param.paHdr.count = paramSize < sizeof  EEPROMConfigM$flashTemp.param.data ? paramSize : sizeof  EEPROMConfigM$flashTemp.param.data;
            EEPROMConfigM$flashTemp.param.paHdr.applicationID = (uint32_t )EEPROMConfigM$endAppParam >> 8;
            EEPROMConfigM$flashTemp.param.paHdr.paramID = EEPROMConfigM$nextParamID;
            paramSize += sizeof(ParameterHeader_t );
            EEPROMConfigM$setBlockCRC(& EEPROMConfigM$flashTemp.param.paHdr, paramSize);
            localBlock = EEPROMConfigM$currentBlock;
            EEPROMConfigM$currentBlock += paramSize;
            EEPROMConfigM$nextParamID += 1;
            EEPROMConfigM$WriteData$write(localBlock, &EEPROMConfigM$flashTemp.data[0], paramSize);
          }
          return SUCCESS;
        }
      break;

      case EEPROMConfigM$PARAM_SAVE_PARAMETERS: 
        {




          while (TRUE) {
              size_t paramSize;

#line 244
              if (EEPROMConfigM$nextParamID > (uint8_t )EEPROMConfigM$endAppParam) {

                  EEPROMConfigM$paramState = EEPROMConfigM$PARAM_IDLE;
                  EEPROMConfigM$ConfigSave$saveDone(SUCCESS, EEPROMConfigM$endAppParam);
                  return SUCCESS;
                }
              paramSize = EEPROMConfigM$Config$get((AppParamID_t )(((uint32_t )((uint32_t )EEPROMConfigM$endAppParam >> 8) << 8) | (ParameterID_t )EEPROMConfigM$nextParamID), &EEPROMConfigM$readBuffer[0], 0);

              if (paramSize != 0) {

                  break;
                }
              EEPROMConfigM$nextParamID += 1;
            }
          EEPROMConfigM$ReadData$read(EEPROMConfigM$currentBlock, &EEPROMConfigM$flashTemp.data[0], sizeof(ParameterBlock_t ));
          return SUCCESS;
        }
      break;
      case EEPROMConfigM$PARAM_SAVE_END_PARAM: 
        {
          if (EEPROMConfigM$nextParamID > (uint8_t )EEPROMConfigM$endAppParam) {

              EEPROMConfigM$paramState = EEPROMConfigM$PARAM_IDLE;
              EEPROMConfigM$ConfigSave$saveDone(SUCCESS, EEPROMConfigM$endAppParam);
              return SUCCESS;
            }
          if (EEPROMConfigM$rescanRequired) {





              EEPROMConfigM$currentBlock = 0 + sizeof(FlashVersionBlock_t );
              EEPROMConfigM$rescanRequired = FALSE;
            }
          EEPROMConfigM$paramState = EEPROMConfigM$PARAM_SAVE_PARAMETERS;
          EEPROMConfigM$ReadData$read(EEPROMConfigM$currentBlock, &EEPROMConfigM$flashTemp.data[0], sizeof(ParameterBlock_t ));
          return SUCCESS;
        }
      break;
      default: 
        return FAIL;
      break;
    }
}

# 42 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\WriteData.nc"
inline static  result_t InternalEEPROMM$WriteData$writeDone(uint8_t *arg_0x1ae39500, uint32_t arg_0x1ae39698, result_t arg_0x1ae39828){
#line 42
  unsigned char result;
#line 42

#line 42
  result = EEPROMConfigM$WriteData$writeDone(arg_0x1ae39500, arg_0x1ae39698, arg_0x1ae39828);
#line 42

#line 42
  return result;
#line 42
}
#line 42
# 163 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverSystemParamsM.nc"
static inline  size_t RecoverSystemParamsM$SystemSerialNumber$get(void *buffer, size_t size)
#line 163
{
  if (buffer != (void *)0) {
      nmemcpy(buffer, &RecoverSystemParamsM$DSSerialID[0], 8);
    }
  return 8;
}

#line 182
static inline  size_t RecoverSystemParamsM$SystemCPUOscillatorFrequency$get(void *buffer, size_t size)
#line 182
{

  if (buffer != (void *)0) {
      nmemcpy(buffer, &RecoverSystemParamsM$sysCPUOscillatorFrequency, size < sizeof RecoverSystemParamsM$sysCPUOscillatorFrequency ? size : sizeof RecoverSystemParamsM$sysCPUOscillatorFrequency);
    }
#line 186
  ;
  return sizeof RecoverSystemParamsM$sysCPUOscillatorFrequency;
}

#line 226
static inline  size_t RecoverSystemParamsM$CrossbowFactoryInfo1$get(void *buffer, size_t size)
#line 226
{
  if (buffer != (void *)0) {
      nmemcpy(buffer, RecoverSystemParamsM$xbowFacInfo1, size < 16 * sizeof(uint8_t ) ? size : 16 * sizeof(uint8_t ));
    }
#line 229
  ;
  return 16 * sizeof(uint8_t );
}

#line 246
static inline  size_t RecoverSystemParamsM$CrossbowFactoryInfo2$get(void *buffer, size_t size)
#line 246
{
  if (buffer != (void *)0) {
      nmemcpy(buffer, RecoverSystemParamsM$xbowFacInfo2, size < 16 * sizeof(uint8_t ) ? size : 16 * sizeof(uint8_t ));
    }
#line 249
  ;
  return 16 * sizeof(uint8_t );
}

#line 265
static inline  size_t RecoverSystemParamsM$CrossbowFactoryInfo3$get(void *buffer, size_t size)
#line 265
{
  if (buffer != (void *)0) {
      nmemcpy(buffer, RecoverSystemParamsM$xbowFacInfo3, size < 16 * sizeof(uint8_t ) ? size : 16 * sizeof(uint8_t ));
    }
#line 268
  ;
  return 16 * sizeof(uint8_t );
}

#line 284
static inline  size_t RecoverSystemParamsM$CrossbowFactoryInfo4$get(void *buffer, size_t size)
#line 284
{
  if (buffer != (void *)0) {
      nmemcpy(buffer, RecoverSystemParamsM$xbowFacInfo4, size < 16 * sizeof(uint8_t ) ? size : 16 * sizeof(uint8_t ));
    }
#line 287
  ;
  return 16 * sizeof(uint8_t );
}

#line 303
static inline  size_t RecoverSystemParamsM$XmeshAppTimerRate$get(void *buffer, size_t size)
#line 303
{

  if (buffer != (void *)0) {
      nmemcpy(buffer, &timer_rate, size < 4 ? size : 4);
    }
#line 307
  ;
  return 4 * sizeof(uint8_t );
}

#line 153
static inline  uint16_t RecoverSystemParamsM$SystemVendorID$get(void)
#line 153
{
  return RecoverSystemParamsM$sysVendorID;
}

#line 84
static inline  uint16_t RecoverSystemParamsM$SystemMoteID$get(void)
#line 84
{

  return TOS_LOCAL_ADDRESS;
}

# 109 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
static inline   uint16_t RecoverParamsM$ConfigInt16$default$get(AppParamID_t id)
#line 109
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 110
    RecoverParamsM$getParmID = TOS_UNUSED_PARAMETER;
#line 110
    __nesc_atomic_end(__nesc_atomic); }
  return 0;
}

# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt16.nc"
inline static  uint16_t RecoverParamsM$ConfigInt16$get(AppParamID_t arg_0x1ad5d010){
#line 26
  unsigned short result;
#line 26

#line 26
  switch (arg_0x1ad5d010) {
#line 26
    case CONFIG_MOTE_ID:
#line 26
      result = RecoverSystemParamsM$SystemMoteID$get();
#line 26
      break;
#line 26
    case CONFIG_MOTE_VENDOR:
#line 26
      result = RecoverSystemParamsM$SystemVendorID$get();
#line 26
      break;
#line 26
    default:
#line 26
      result = RecoverParamsM$ConfigInt16$default$get(arg_0x1ad5d010);
#line 26
      break;
#line 26
    }
#line 26

#line 26
  return result;
#line 26
}
#line 26
# 210 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverSystemParamsM.nc"
static inline  uint8_t RecoverSystemParamsM$RadioChannel$get(void)
#line 210
{




  return TOS_CC2420_CHANNEL;
}

#line 201
static inline  uint8_t RecoverSystemParamsM$RadioPower$get(void)
#line 201
{
  return TOS_CC2420_TXPOWER;
}

#line 143
static inline  uint8_t RecoverSystemParamsM$SystemRadioType$get(void)
#line 143
{
  return RecoverSystemParamsM$sysRadioType;
}

#line 133
static inline  uint8_t RecoverSystemParamsM$SystemMoteCPUType$get(void)
#line 133
{
  return RecoverSystemParamsM$sysMoteCPUType;
}

#line 123
static inline  uint8_t RecoverSystemParamsM$SystemSuModelType$get(void)
#line 123
{
  return RecoverSystemParamsM$sysSubModelType;
}

#line 113
static inline  uint8_t RecoverSystemParamsM$SystemModelType$get(void)
#line 113
{
  return RecoverSystemParamsM$sysModelType;
}

#line 101
static inline  uint8_t RecoverSystemParamsM$SystemGroupNumber$get(void)
#line 101
{


  return TOS_AM_GROUP;
}

# 114 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
static inline   uint8_t RecoverParamsM$ConfigInt8$default$get(AppParamID_t id)
#line 114
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 115
    RecoverParamsM$getParmID = TOS_UNUSED_PARAMETER;
#line 115
    __nesc_atomic_end(__nesc_atomic); }
  return 0;
}

# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigInt8.nc"
inline static  uint8_t RecoverParamsM$ConfigInt8$get(AppParamID_t arg_0x1ad5e3c8){
#line 26
  unsigned char result;
#line 26

#line 26
  switch (arg_0x1ad5e3c8) {
#line 26
    case CONFIG_MOTE_GROUP:
#line 26
      result = RecoverSystemParamsM$SystemGroupNumber$get();
#line 26
      break;
#line 26
    case CONFIG_MOTE_MODEL:
#line 26
      result = RecoverSystemParamsM$SystemModelType$get();
#line 26
      break;
#line 26
    case CONFIG_MOTE_SUBMODEL:
#line 26
      result = RecoverSystemParamsM$SystemSuModelType$get();
#line 26
      break;
#line 26
    case CONFIG_MOTE_CPU_TYPE:
#line 26
      result = RecoverSystemParamsM$SystemMoteCPUType$get();
#line 26
      break;
#line 26
    case CONFIG_MOTE_RADIO_TYPE:
#line 26
      result = RecoverSystemParamsM$SystemRadioType$get();
#line 26
      break;
#line 26
    case CONFIG_RF_POWER:
#line 26
      result = RecoverSystemParamsM$RadioPower$get();
#line 26
      break;
#line 26
    case CONFIG_RF_CHANNEL:
#line 26
      result = RecoverSystemParamsM$RadioChannel$get();
#line 26
      break;
#line 26
    default:
#line 26
      result = RecoverParamsM$ConfigInt8$default$get(arg_0x1ad5e3c8);
#line 26
      break;
#line 26
    }
#line 26

#line 26
  return result;
#line 26
}
#line 26
# 88 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
inline static  void *ShimLayerM$MhopSendActual$getBuffer(uint8_t arg_0x1abb5c00, TOS_MsgPtr arg_0x1ab4b7c0, uint16_t *arg_0x1ab4b970){
#line 88
  void *result;
#line 88

#line 88
  result = XMeshC$MhopSend$getBuffer(arg_0x1abb5c00, arg_0x1ab4b7c0, arg_0x1ab4b970);
#line 88

#line 88
  return result;
#line 88
}
#line 88
# 81 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline  void *ShimLayerM$MhopSend$getBuffer(uint8_t id, TOS_MsgPtr pMsg, uint16_t *length)
{
  return ShimLayerM$MhopSendActual$getBuffer(id, pMsg, length);
}

# 88 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
inline static  void *XCommandM$Send$getBuffer(TOS_MsgPtr arg_0x1ab4b7c0, uint16_t *arg_0x1ab4b970){
#line 88
  void *result;
#line 88

#line 88
  result = ShimLayerM$MhopSend$getBuffer(AM_XCOMMAND_MSG, arg_0x1ab4b7c0, arg_0x1ab4b970);
#line 88

#line 88
  return result;
#line 88
}
#line 88
#line 65
inline static  result_t ShimLayerM$MhopSendActual$send(uint8_t arg_0x1abb5c00, uint16_t arg_0x1ab219b8, uint8_t arg_0x1ab21b40, TOS_MsgPtr arg_0x1ab21cd0, uint16_t arg_0x1ab21e60){
#line 65
  unsigned char result;
#line 65

#line 65
  result = XMeshC$MhopSend$send(arg_0x1abb5c00, arg_0x1ab219b8, arg_0x1ab21b40, arg_0x1ab21cd0, arg_0x1ab21e60);
#line 65

#line 65
  return result;
#line 65
}
#line 65
# 77 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline  result_t ShimLayerM$MhopSend$send(uint8_t socket, uint16_t dest, uint8_t mode, TOS_MsgPtr pMsg, uint16_t PayloadLen)
#line 77
{
  return ShimLayerM$MhopSendActual$send(socket, dest, mode, pMsg, PayloadLen);
}

# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
inline static  result_t XCommandM$Send$send(uint16_t arg_0x1ab219b8, uint8_t arg_0x1ab21b40, TOS_MsgPtr arg_0x1ab21cd0, uint16_t arg_0x1ab21e60){
#line 65
  unsigned char result;
#line 65

#line 65
  result = ShimLayerM$MhopSend$send(AM_XCOMMAND_MSG, arg_0x1ab219b8, arg_0x1ab21b40, arg_0x1ab21cd0, arg_0x1ab21e60);
#line 65

#line 65
  return result;
#line 65
}
#line 65
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t AMPromiscuous$TimerControl$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = TimerM$StdControl$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\HPLUART0M.nc"
static inline   result_t HPLUART0M$Setbaud(uint32_t baud_rate)
#line 48
{

  switch (baud_rate) {
      case 4800u: 
        * (volatile uint8_t *)0x90 = 0;
      * (volatile uint8_t *)(0x09 + 0x20) = 191;
      break;

      case 9600u: 
        * (volatile uint8_t *)0x90 = 0;
      * (volatile uint8_t *)(0x09 + 0x20) = 95;
      break;

      case 19200u: 
        * (volatile uint8_t *)0x90 = 0;
      * (volatile uint8_t *)(0x09 + 0x20) = 47;
      break;

      case 57600u: 
        * (volatile uint8_t *)0x90 = 0;
      * (volatile uint8_t *)(0x09 + 0x20) = 15;
      break;

      case 115200u: 
        * (volatile uint8_t *)0x90 = 0;
      * (volatile uint8_t *)(0x09 + 0x20) = 7;
      break;

      default: 
        return FAIL;
    }
  * (volatile uint8_t *)(0x0B + 0x20) = 1 << 1;
  * (volatile uint8_t *)0x95 = (1 << 2) | (1 << 1);
  * (volatile uint8_t *)(0x0A + 0x20) = (((1 << 7) | (1 << 6)) | (1 << 4)) | (1 << 3);
  return SUCCESS;
}



static inline   result_t HPLUART0M$UART$init(void)
#line 87
{

  HPLUART0M$Setbaud(TOS_UART0_BAUDRATE);
  return SUCCESS;
}

# 40 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLUART.nc"
inline static   result_t UARTM$HPLUART$init(void){
#line 40
  unsigned char result;
#line 40

#line 40
  result = HPLUART0M$UART$init();
#line 40

#line 40
  return result;
#line 40
}
#line 40
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\UARTM.nc"
static inline  result_t UARTM$Control$start(void)
#line 48
{
  return UARTM$HPLUART$init();
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t FramerM$ByteControl$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = UARTM$Control$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 313 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\FramerM.nc"
static inline  result_t FramerM$StdControl$start(void)
#line 313
{
  FramerM$HDLCInitialize();
  return FramerM$ByteControl$start();
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t AMPromiscuous$UARTControl$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = FramerM$StdControl$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420.nc"
inline static   uint8_t CC2420ControlM$HPLChipcon$cmd(uint8_t arg_0x1a6b14f8){
#line 51
  unsigned char result;
#line 51

#line 51
  result = HPLCC2420M$HPLCC2420$cmd(arg_0x1a6b14f8);
#line 51

#line 51
  return result;
#line 51
}
#line 51
# 301 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420ControlM.nc"
static inline   result_t CC2420ControlM$CC2420Control$RxMode(void)
#line 301
{
  CC2420ControlM$HPLChipcon$cmd(0x03);
  return SUCCESS;
}

# 112 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420Control.nc"
inline static   result_t CC2420RadioM$CC2420Control$RxMode(void){
#line 112
  unsigned char result;
#line 112

#line 112
  result = CC2420ControlM$CC2420Control$RxMode();
#line 112

#line 112
  return result;
#line 112
}
#line 112
# 58 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420.nc"
inline static   uint8_t CC2420RadioM$HPLChipcon$write(uint8_t arg_0x1a6b1bb0, uint16_t arg_0x1a6b1d40){
#line 58
  unsigned char result;
#line 58

#line 58
  result = HPLCC2420M$HPLCC2420$write(arg_0x1a6b1bb0, arg_0x1a6b1d40);
#line 58

#line 58
  return result;
#line 58
}
#line 58
#line 41
inline static   result_t CC2420ControlM$HPLChipcon$enableFIFOP(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = HPLCC2420M$HPLCC2420$enableFIFOP();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 399 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420ControlM.nc"
static inline   result_t CC2420ControlM$HPLChipconRAM$writeDone(uint16_t addr, uint8_t length, uint8_t *buffer)
#line 399
{
  return SUCCESS;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420RAM.nc"
inline static   result_t HPLCC2420M$HPLCC2420RAM$writeDone(uint16_t arg_0x1a7c6cc8, uint8_t arg_0x1a7c6e50, uint8_t *arg_0x1a7c4010){
#line 48
  unsigned char result;
#line 48

#line 48
  result = CC2420ControlM$HPLChipconRAM$writeDone(arg_0x1a7c6cc8, arg_0x1a7c6e50, arg_0x1a7c4010);
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 220 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLCC2420M.nc"
static inline  void HPLCC2420M$signalRAMWr(void)
#line 220
{
  HPLCC2420M$HPLCC2420RAM$writeDone(HPLCC2420M$ramaddr, HPLCC2420M$ramlen, HPLCC2420M$rambuf);
}

# 150 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline void TOSH_CLR_CC_CS_PIN(void)
#line 150
{
#line 150
  * (volatile uint8_t *)(0x18 + 0x20) &= ~(1 << 0);
}

# 231 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLCC2420M.nc"
static inline   result_t HPLCC2420M$HPLCC2420RAM$write(uint16_t addr, uint8_t length, uint8_t *buffer)
#line 231
{
  uint8_t i = 0;
  uint8_t status;

  if (!HPLCC2420M$bSpiAvail) {
    return FALSE;
    }
  /* atomic removed: atomic calls only */
#line 238
  {
    HPLCC2420M$bSpiAvail = FALSE;
    HPLCC2420M$ramaddr = addr;
    HPLCC2420M$ramlen = length;
    HPLCC2420M$rambuf = buffer;
    TOSH_CLR_CC_CS_PIN();
    * (volatile uint8_t *)(0x0F + 0x20) = (HPLCC2420M$ramaddr & 0x7F) | 0x80;
    while (!(* (volatile uint8_t *)(0x0E + 0x20) & 0x80)) {
      }
#line 245
    ;
    status = * (volatile uint8_t *)(0x0F + 0x20);
    * (volatile uint8_t *)(0x0F + 0x20) = (HPLCC2420M$ramaddr >> 1) & 0xC0;
    while (!(* (volatile uint8_t *)(0x0E + 0x20) & 0x80)) {
      }
#line 248
    ;
    status = * (volatile uint8_t *)(0x0F + 0x20);

    for (i = 0; i < HPLCC2420M$ramlen; i++) {
        * (volatile uint8_t *)(0x0F + 0x20) = HPLCC2420M$rambuf[i];

        while (!(* (volatile uint8_t *)(0x0E + 0x20) & 0x80)) {
          }
#line 254
        ;
      }
  }
  HPLCC2420M$bSpiAvail = TRUE;
  return TOS_post(HPLCC2420M$signalRAMWr);
}

# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420RAM.nc"
inline static   result_t CC2420ControlM$HPLChipconRAM$write(uint16_t arg_0x1a7c6458, uint8_t arg_0x1a7c65e0, uint8_t *arg_0x1a7c6788){
#line 46
  unsigned char result;
#line 46

#line 46
  result = HPLCC2420M$HPLCC2420RAM$write(arg_0x1a7c6458, arg_0x1a7c65e0, arg_0x1a7c6788);
#line 46

#line 46
  return result;
#line 46
}
#line 46
# 40 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\byteorder.h"
static __inline int is_host_lsb(void)
{
  const uint8_t n[2] = { 1, 0 };

#line 43
  return * (uint16_t *)n == 1;
}

static __inline uint16_t toLSB16(uint16_t a)
{
  return is_host_lsb() ? a : (a << 8) | (a >> 8);
}

# 386 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420ControlM.nc"
static inline  result_t CC2420ControlM$CC2420Control$setShortAddress(uint16_t addr)
#line 386
{
  addr = toLSB16(addr);
  return CC2420ControlM$HPLChipconRAM$write(0x16A, 2, (uint8_t *)&addr);
}

# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420.nc"
inline static   uint16_t CC2420ControlM$HPLChipcon$read(uint8_t arg_0x1a6c6500){
#line 65
  unsigned short result;
#line 65

#line 65
  result = HPLCC2420M$HPLCC2420$read(arg_0x1a6c6500);
#line 65

#line 65
  return result;
#line 65
}
#line 65
# 94 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420ControlM.nc"
static inline bool CC2420ControlM$SetRegs(void)
#line 94
{
  uint16_t data;

  CC2420ControlM$HPLChipcon$write(0x10, CC2420ControlM$gCurrentParameters[CP_MAIN]);
  CC2420ControlM$HPLChipcon$write(0x11, CC2420ControlM$gCurrentParameters[CP_MDMCTRL0]);
  data = CC2420ControlM$HPLChipcon$read(0x11);
  if (data != CC2420ControlM$gCurrentParameters[CP_MDMCTRL0]) {
#line 100
    return FALSE;
    }
  CC2420ControlM$HPLChipcon$write(0x12, CC2420ControlM$gCurrentParameters[CP_MDMCTRL1]);
  CC2420ControlM$HPLChipcon$write(0x13, CC2420ControlM$gCurrentParameters[CP_RSSI]);
  CC2420ControlM$HPLChipcon$write(0x14, CC2420ControlM$gCurrentParameters[CP_SYNCWORD]);
  CC2420ControlM$HPLChipcon$write(0x15, CC2420ControlM$gCurrentParameters[CP_TXCTRL]);
  CC2420ControlM$HPLChipcon$write(0x16, CC2420ControlM$gCurrentParameters[CP_RXCTRL0]);
  CC2420ControlM$HPLChipcon$write(0x17, CC2420ControlM$gCurrentParameters[CP_RXCTRL1]);
  CC2420ControlM$HPLChipcon$write(0x18, CC2420ControlM$gCurrentParameters[CP_FSCTRL]);

  CC2420ControlM$HPLChipcon$write(0x19, CC2420ControlM$gCurrentParameters[CP_SECCTRL0]);
  CC2420ControlM$HPLChipcon$write(0x1A, CC2420ControlM$gCurrentParameters[CP_SECCTRL1]);
  CC2420ControlM$HPLChipcon$write(0x1C, CC2420ControlM$gCurrentParameters[CP_IOCFG0]);
  CC2420ControlM$HPLChipcon$write(0x1D, CC2420ControlM$gCurrentParameters[CP_IOCFG1]);

  CC2420ControlM$HPLChipcon$cmd(0x09);
  CC2420ControlM$HPLChipcon$cmd(0x08);

  return TRUE;
}

#line 343
static inline   result_t CC2420ControlM$CC2420Control$OscillatorOn(void)
#line 343
{
  uint8_t i;
  uint8_t status;
  bool bXoscOn = FALSE;

  i = 0;
  CC2420ControlM$HPLChipcon$cmd(0x01);
  while (i < 200 && bXoscOn == FALSE) {
      TOSH_uwait(100);
      status = CC2420ControlM$HPLChipcon$cmd(0x00);
      status = status & (1 << 6);
      if (status) {
#line 354
        bXoscOn = TRUE;
        }
#line 355
      i++;
    }
  if (!bXoscOn) {
#line 357
    return FAIL;
    }
#line 358
  return SUCCESS;
}

# 142 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline void TOSH_SET_CC_RSTN_PIN(void)
#line 142
{
#line 142
  * (volatile uint8_t *)(0x1B + 0x20) |= 1 << 6;
}

#line 142
static __inline void TOSH_CLR_CC_RSTN_PIN(void)
#line 142
{
#line 142
  * (volatile uint8_t *)(0x1B + 0x20) &= ~(1 << 6);
}

# 87 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLCC2420M.nc"
static inline  result_t HPLCC2420M$StdControl$start(void)
#line 87
{
#line 87
  return SUCCESS;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t CC2420ControlM$HPLChipconControl$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = HPLCC2420M$StdControl$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 213 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420ControlM.nc"
static inline  result_t CC2420ControlM$StdControl$start(void)
#line 213
{
  result_t status;

  CC2420ControlM$HPLChipconControl$start();


  TOSH_CLR_CC_RSTN_PIN();
  TOSH_uwait2(5);


  TOSH_SET_CC_RSTN_PIN();
  TOSH_uwait2(5);



  status = CC2420ControlM$CC2420Control$OscillatorOn();


  status = CC2420ControlM$SetRegs() && status;
  status = status && CC2420ControlM$CC2420Control$setShortAddress(TOS_LOCAL_ADDRESS);
  status = status && CC2420ControlM$CC2420Control$TunePreset(TOS_CC2420_CHANNEL);

  CC2420ControlM$CC2420Control$RxMode();
  CC2420ControlM$HPLChipcon$enableFIFOP();
  return status;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t CC2420RadioM$CC2420StdControl$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = CC2420ControlM$StdControl$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 609 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static inline  result_t CC2420RadioM$StdControl$start(void)
#line 609
{
  uint8_t chkRadioState;

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 612
    chkRadioState = CC2420RadioM$RadioState;
#line 612
    __nesc_atomic_end(__nesc_atomic); }

  if (chkRadioState == CC2420RadioM$DISABLED_STATE) {




      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 619
        {
          CC2420RadioM$rxbufptr->length = 0;
          CC2420RadioM$RadioState = CC2420RadioM$IDLE_STATE;

          CC2420RadioM$CC2420StdControl$start();

          if (CC2420RadioM$gImmedSendDone) {

              CC2420RadioM$HPLChipcon$write(0x13, 0xE080);
            }

          CC2420RadioM$CC2420Control$RxMode();
        }
#line 631
        __nesc_atomic_end(__nesc_atomic); }
    }

  ;

  return SUCCESS;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t AMPromiscuous$RadioControl$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = CC2420RadioM$StdControl$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
inline static  result_t AMPromiscuous$ActivityTimer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500){
#line 37
  unsigned char result;
#line 37

#line 37
  result = TimerM$Timer$start(1U, arg_0x1a5d5368, arg_0x1a5d5500);
#line 37

#line 37
  return result;
#line 37
}
#line 37
# 171 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\tos.h"
static inline result_t rcombine4(result_t r1, result_t r2, result_t r3, 
result_t r4)
{
  return rcombine(r1, rcombine(r2, rcombine(r3, r4)));
}

# 165 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\avrhardware.h"
static __inline void __nesc_enable_interrupt(void)
#line 165
{
   __asm volatile ("sei");}

#line 150
 __inline void __nesc_atomic_end(__nesc_atomic_t oldSreg)
{
  * (volatile uint8_t *)(0x3F + 0x20) = oldSreg;
}

#line 128
static inline void TOSH_wait(void)
{
   __asm volatile ("nop");
   __asm volatile ("nop");}

#line 155
static __inline void __nesc_atomic_sleep(void)
{

   __asm volatile ("sei");
   __asm volatile ("sleep");
  TOSH_wait();
}

#line 143
 __inline __nesc_atomic_t __nesc_atomic_start(void )
{
  __nesc_atomic_t result = * (volatile uint8_t *)(0x3F + 0x20);

#line 146
   __asm volatile ("cli");
  return result;
}

# 116 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\sched.c"
static inline bool TOSH_run_next_task(void)
{
  __nesc_atomic_t fInterruptFlags;
  uint8_t old_full;
  void (*func)(void );

  fInterruptFlags = __nesc_atomic_start();
  old_full = TOSH_sched_full;
  func = TOSH_queue[old_full].tp;
  if (func == (void *)0) 
    {
      __nesc_atomic_sleep();
      return 0;
    }

  TOSH_queue[old_full].tp = (void *)0;
  TOSH_sched_full = (old_full + 1) & TOSH_TASK_BITMASK;
  __nesc_atomic_end(fInterruptFlags);
  func();

  return 1;
}

static inline void TOSH_run_task(void)
#line 139
{
  for (; ; ) 
    TOSH_run_next_task();
}

# 417 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XCommandM.nc"
static inline  TOS_MsgPtr XCommandM$Bcast$receive(TOS_MsgPtr pMsg, void *payload, 
uint16_t payloadLen)
{

  XCommandMsg *cmdMsg = (XCommandMsg *)payload;
  XCommandOp *opcode = & cmdMsg->inst;


  if (!(pMsg->group == 0xFF || pMsg->group == TOS_AM_GROUP)) {
    return pMsg;
    }

  if (cmdMsg->dest != 0xFFFF && cmdMsg->dest != TOS_LOCAL_ADDRESS) {
    return pMsg;
    }
  XCommandM$handleCommand(opcode, cmdMsg->dest);

  return pMsg;
}

# 126 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Broadcast\\BcastM.nc"
static inline   TOS_MsgPtr BcastM$Receive$default$receive(uint8_t id, TOS_MsgPtr pMsg, void *payload, 
uint16_t payloadLen)
#line 127
{
  return pMsg;
}

# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
inline static  TOS_MsgPtr BcastM$Receive$receive(uint8_t arg_0x1af8c118, TOS_MsgPtr arg_0x1ab42878, void *arg_0x1ab42a18, uint16_t arg_0x1ab42bb0){
#line 60
  struct TOS_Msg *result;
#line 60

#line 60
  switch (arg_0x1af8c118) {
#line 60
    case AM_XCOMMAND_MSG:
#line 60
      result = XCommandM$Bcast$receive(arg_0x1ab42878, arg_0x1ab42a18, arg_0x1ab42bb0);
#line 60
      break;
#line 60
    default:
#line 60
      result = BcastM$Receive$default$receive(arg_0x1af8c118, arg_0x1ab42878, arg_0x1ab42a18, arg_0x1ab42bb0);
#line 60
      break;
#line 60
    }
#line 60

#line 60
  return result;
#line 60
}
#line 60
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
inline static  result_t BcastM$SendMsg$send(uint8_t arg_0x1af8b200, uint16_t arg_0x1a583670, uint8_t arg_0x1a5837f8, TOS_MsgPtr arg_0x1a583988){
#line 26
  unsigned char result;
#line 26

#line 26
  result = QueuedSendM$QueueSendMsg$send(arg_0x1af8b200, arg_0x1a583670, arg_0x1a5837f8, arg_0x1a583988);
#line 26

#line 26
  return result;
#line 26
}
#line 26
# 71 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Broadcast\\BcastM.nc"
inline static void BcastM$FwdBcast(TOS_BcastMsg *pRcvMsg, uint8_t Len, uint8_t id)
#line 71
{
  TOS_BcastMsg *pFwdMsg;

  if ((BcastM$iFwdBufHead + 1) % BcastM$FWD_QUEUE_SIZE == BcastM$iFwdBufTail) {

      return;
    }

  pFwdMsg = (TOS_BcastMsg *)& BcastM$FwdBuffer[BcastM$iFwdBufHead].data;

  nmemcpy(pFwdMsg, pRcvMsg, Len);

  {
  }
#line 83
  ;
  if (BcastM$SendMsg$send(id, TOS_BCAST_ADDR, Len, &BcastM$FwdBuffer[BcastM$iFwdBufHead]) == SUCCESS) {
      BcastM$iFwdBufHead++;
#line 85
      BcastM$iFwdBufHead %= BcastM$FWD_QUEUE_SIZE;
    }
}

#line 51
inline static bool BcastM$newBcast(int16_t proposed)
#line 51
{







  if (proposed - BcastM$BcastSeqno > 0) {
      BcastM$BcastSeqno++;
      return TRUE;
    }
  else 
#line 62
    {
      return FALSE;
    }
}

#line 113
static inline  TOS_MsgPtr BcastM$ReceiveMsg$receive(uint8_t id, TOS_MsgPtr pMsg)
#line 113
{
  TOS_BcastMsg *pBCMsg = (TOS_BcastMsg *)pMsg->data;
  uint16_t Len = pMsg->length - (size_t )& ((TOS_BcastMsg *)0)->data;

  {
  }
#line 117
  ;

  if (BcastM$newBcast(pBCMsg->seqno)) {
      BcastM$FwdBcast(pBCMsg, pMsg->length, id);
      BcastM$Receive$receive(id, pMsg, &pBCMsg->data[0], Len);
    }
  return pMsg;
}

# 263 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static inline   TOS_MsgPtr AMPromiscuous$ReceiveMsg$default$receive(uint8_t id, TOS_MsgPtr msg)
#line 263
{
  return msg;
}

# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
inline static  TOS_MsgPtr AMPromiscuous$ReceiveMsg$receive(uint8_t arg_0x1a592720, TOS_MsgPtr arg_0x1a581c80){
#line 53
  struct TOS_Msg *result;
#line 53

#line 53
  switch (arg_0x1a592720) {
#line 53
    case AM_HEALTH:
#line 53
      result = XMeshC$ReceiveMsgWithAck$receive(AM_HEALTH, arg_0x1a581c80);
#line 53
      break;
#line 53
    case AM_DATA2BASE:
#line 53
      result = XMeshC$ReceiveMsg$receive(AM_DATA2BASE, arg_0x1a581c80);
#line 53
      break;
#line 53
    case AM_DATA2NODE:
#line 53
      result = XMeshC$ReceiveDownstreamMsg$receive(AM_DATA2NODE, arg_0x1a581c80);
#line 53
      break;
#line 53
    case AM_DATAACK2BASE:
#line 53
      result = XMeshC$ReceiveMsgWithAck$receive(AM_DATAACK2BASE, arg_0x1a581c80);
#line 53
      break;
#line 53
    case AM_DATAACK2NODE:
#line 53
      result = XMeshC$ReceiveDownstreamMsgWithAck$receive(AM_DATAACK2NODE, arg_0x1a581c80);
#line 53
      break;
#line 53
    case AM_XCOMMAND_MSG:
#line 53
      result = BcastM$ReceiveMsg$receive(AM_XCOMMAND_MSG, arg_0x1a581c80);
#line 53
      break;
#line 53
    case AM_XMULTIHOP_MSG:
#line 53
      result = XMeshC$ReceiveMsg$receive(AM_XMULTIHOP_MSG, arg_0x1a581c80);
#line 53
      break;
#line 53
    case AM_MGMT:
#line 53
      result = XMeshC$ReceiveDownstreamMsg$receive(AM_MGMT, arg_0x1a581c80);
#line 53
      break;
#line 53
    case AM_BULKXFER:
#line 53
      result = XMeshC$ReceiveDownstreamMsg$receive(AM_BULKXFER, arg_0x1a581c80);
#line 53
      break;
#line 53
    case AM_MGMTRESP:
#line 53
      result = XMeshC$ReceiveMsg$receive(AM_MGMTRESP, arg_0x1a581c80);
#line 53
      break;
#line 53
    case AM_DOWNSTREAM_ACK:
#line 53
      result = XMeshC$ReceiveDownstreamMsg$receive(AM_DOWNSTREAM_ACK, arg_0x1a581c80);
#line 53
      break;
#line 53
    case AM_UPSTREAM_ACK:
#line 53
      result = XMeshC$ReceiveMsg$receive(AM_UPSTREAM_ACK, arg_0x1a581c80);
#line 53
      break;
#line 53
    case AM_PATH_LIGHT_DOWN:
#line 53
      result = XMeshC$ReceiveDownstreamMsg$receive(AM_PATH_LIGHT_DOWN, arg_0x1a581c80);
#line 53
      break;
#line 53
    case AM_PATH_LIGHT_UP:
#line 53
      result = XMeshC$ReceiveMsg$receive(AM_PATH_LIGHT_UP, arg_0x1a581c80);
#line 53
      break;
#line 53
    case AM_MULTIHOPMSG:
#line 53
      result = XMeshC$ReceiveMsg$receive(AM_MULTIHOPMSG, arg_0x1a581c80);
#line 53
      break;
#line 53
    case AM_ONE_HOP:
#line 53
      result = XMeshC$ReceiveMsg$receive(AM_ONE_HOP, arg_0x1a581c80);
#line 53
      break;
#line 53
    default:
#line 53
      result = AMPromiscuous$ReceiveMsg$default$receive(arg_0x1a592720, arg_0x1a581c80);
#line 53
      break;
#line 53
    }
#line 53

#line 53
  return result;
#line 53
}
#line 53
# 54 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\NoLeds.nc"
static inline   result_t NoLeds$Leds$greenToggle(void)
#line 54
{
  return SUCCESS;
}

# 85 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
inline static   result_t QueuedSendM$Leds$greenToggle(void){
#line 85
  unsigned char result;
#line 85

#line 85
  result = NoLeds$Leds$greenToggle();
#line 85

#line 85
  return result;
#line 85
}
#line 85
# 139 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static inline void AMPromiscuous$dbgPacket(TOS_MsgPtr data)
#line 139
{
  uint8_t i;

  for (i = 0; i < sizeof(TOS_Msg ); i++) 
    {
      {
      }
#line 144
      ;
    }
  {
  }
#line 146
  ;
}

# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420.nc"
inline static   result_t CC2420RadioM$HPLChipcon$enableFIFOP(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = HPLCC2420M$HPLCC2420$enableFIFOP();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 34 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\TimerJiffyAsync.nc"
inline static   result_t CC2420RadioM$BackoffTimerJiffy$setOneShot(uint32_t arg_0x1a6d5460){
#line 34
  unsigned char result;
#line 34

#line 34
  result = TimerJiffyAsyncM$TimerJiffyAsync$setOneShot(arg_0x1a6d5460);
#line 34

#line 34
  return result;
#line 34
}
#line 34
# 204 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static __inline result_t CC2420RadioM$setInitialTimer(uint16_t jiffy)
#line 204
{
  CC2420RadioM$stateTimer = CC2420RadioM$TIMER_INITIAL;
  if (jiffy == 0x0000) {

      CC2420RadioM$BackoffTimerJiffy$fired();
      return SUCCESS;
    }
  else 
#line 210
    {

      return CC2420RadioM$BackoffTimerJiffy$setOneShot(jiffy);
    }
}

# 42 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Random.nc"
inline static   uint16_t CC2420RadioM$Random$rand(void){
#line 42
  unsigned short result;
#line 42

#line 42
  result = RandomLFSR$Random$rand();
#line 42

#line 42
  return result;
#line 42
}
#line 42
# 1313 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static inline    int16_t CC2420RadioM$MacBackoff$default$initialBackoff(TOS_MsgPtr m)
#line 1313
{
  return (CC2420RadioM$Random$rand() & 0xF) + 1;
}

# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\MacBackoff.nc"
inline static   int16_t CC2420RadioM$MacBackoff$initialBackoff(TOS_MsgPtr arg_0x1a6733e8){
#line 43
  short result;
#line 43

#line 43
  result = CC2420RadioM$MacBackoff$default$initialBackoff(arg_0x1a6733e8);
#line 43

#line 43
  return result;
#line 43
}
#line 43
# 727 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static inline  result_t CC2420RadioM$Send$send(TOS_MsgPtr pMsg)
#line 727
{


  uint8_t currentstate;
  int16_t backoffValue;

  TOSH_uwait2(30);

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 735
    {
      currentstate = CC2420RadioM$RadioState;
      if (currentstate == CC2420RadioM$IDLE_STATE) {
#line 737
        CC2420RadioM$RadioState = CC2420RadioM$PRE_TX_STATE;
        }
    }
#line 739
    __nesc_atomic_end(__nesc_atomic); }
  if (currentstate == CC2420RadioM$IDLE_STATE) {

      pMsg->fcflo = 0x08;
      if (CC2420RadioM$bAckEnable) {
        pMsg->fcfhi = 0x21;
        }
      else {
#line 746
        pMsg->fcfhi = 0x01;
        }

      pMsg->destpan = TOS_BCAST_ADDR;


      pMsg->addr = toLSB16(pMsg->addr);



      pMsg->length = pMsg->length + MSG_HEADER_SIZE + MSG_FOOTER_SIZE;


      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 759
        {

          pMsg->dsn = ++CC2420RadioM$currentDSN;



          CC2420RadioM$txlength = pMsg->length - MSG_FOOTER_SIZE;

          CC2420RadioM$txbufptr = pMsg;
        }
#line 768
        __nesc_atomic_end(__nesc_atomic); }



      backoffValue = CC2420RadioM$MacBackoff$initialBackoff(CC2420RadioM$txbufptr) * 10;
      if (CC2420RadioM$setInitialTimer(backoffValue)) {
          CC2420RadioM$cnttryToSend = 8;





          return SUCCESS;
        }


      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 784
        CC2420RadioM$RadioState = CC2420RadioM$IDLE_STATE;
#line 784
        __nesc_atomic_end(__nesc_atomic); }
      CC2420RadioM$HPLChipcon$enableFIFOP();
    }


  return FAIL;
}

# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BareSendMsg.nc"
inline static  result_t AMPromiscuous$RadioSend$send(TOS_MsgPtr arg_0x1a5a3be8){
#line 36
  unsigned char result;
#line 36

#line 36
  result = CC2420RadioM$Send$send(arg_0x1a5a3be8);
#line 36

#line 36
  return result;
#line 36
}
#line 36
# 323 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\FramerM.nc"
static inline  result_t FramerM$BareSendMsg$send(TOS_MsgPtr pMsg)
#line 323
{
  result_t Result = SUCCESS;

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 326
    {
      if (!(FramerM$gFlags & FramerM$FLAGS_DATAPEND)) {
          FramerM$gFlags |= FramerM$FLAGS_DATAPEND;
          FramerM$gpTxMsg = pMsg;
        }
      else 

        {
          Result = FAIL;
        }
    }
#line 336
    __nesc_atomic_end(__nesc_atomic); }

  if (Result == SUCCESS) {
      Result = FramerM$StartTx();
    }

  return Result;
}

# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BareSendMsg.nc"
inline static  result_t AMPromiscuous$UARTSend$send(TOS_MsgPtr arg_0x1a5a3be8){
#line 36
  unsigned char result;
#line 36

#line 36
  result = FramerM$BareSendMsg$send(arg_0x1a5a3be8);
#line 36

#line 36
  return result;
#line 36
}
#line 36
# 173 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static inline  void AMPromiscuous$sendTask(void)
#line 173
{
  result_t ok;

  if (AMPromiscuous$buffer->addr == TOS_UART_ADDR) {
    ok = AMPromiscuous$UARTSend$send(AMPromiscuous$buffer);
    }
  else {
#line 179
    ok = AMPromiscuous$RadioSend$send(AMPromiscuous$buffer);
    }
  if (ok == FAIL) {
    AMPromiscuous$reportSendDone(AMPromiscuous$buffer, FAIL);
    }
}

# 85 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
inline static   result_t AMPromiscuous$Leds$greenToggle(void){
#line 85
  unsigned char result;
#line 85

#line 85
  result = NoLeds$Leds$greenToggle();
#line 85

#line 85
  return result;
#line 85
}
#line 85
# 186 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static inline  result_t AMPromiscuous$SendMsg$send(uint8_t id, uint16_t addr, uint8_t length, TOS_MsgPtr data)
#line 186
{

  if (!AMPromiscuous$state) {
      AMPromiscuous$state = TRUE;
      AMPromiscuous$Leds$greenToggle();

      if (length > DATA_LENGTH) {
          {
          }
#line 193
          ;
          AMPromiscuous$state = FALSE;
          return FAIL;
        }
      if (!TOS_post(AMPromiscuous$sendTask)) {
          {
          }
#line 198
          ;
          AMPromiscuous$state = FALSE;
          return FAIL;
        }
      else {
          AMPromiscuous$buffer = data;
          data->length = length;
          data->addr = addr;
          data->type = id;



          if (AMPromiscuous$buffer->group != 0xFF) {
              AMPromiscuous$buffer->group = TOS_AM_GROUP;
            }


          AMPromiscuous$dbgPacket(data);
          {
          }
#line 216
          ;
        }
      return SUCCESS;
    }

  {
  }
#line 221
  ;
  return FAIL;
}

# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
inline static  result_t QueuedSendM$SerialSendMsg$send(uint8_t arg_0x1ac5bd18, uint16_t arg_0x1a583670, uint8_t arg_0x1a5837f8, TOS_MsgPtr arg_0x1a583988){
#line 26
  unsigned char result;
#line 26

#line 26
  result = AMPromiscuous$SendMsg$send(arg_0x1ac5bd18, arg_0x1a583670, arg_0x1a5837f8, arg_0x1a583988);
#line 26

#line 26
  return result;
#line 26
}
#line 26
# 117 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\HPLUART0M.nc"
static inline   result_t HPLUART0M$UART$put(uint8_t data)
#line 117
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 118
    {
      * (volatile uint8_t *)(0x0C + 0x20) = data;
      * (volatile uint8_t *)(0x0B + 0x20) |= 1 << 6;
    }
#line 121
    __nesc_atomic_end(__nesc_atomic); }

  return SUCCESS;
}

# 58 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLUART.nc"
inline static   result_t UARTM$HPLUART$put(uint8_t arg_0x1aaaa610){
#line 58
  unsigned char result;
#line 58

#line 58
  result = HPLUART0M$UART$put(arg_0x1aaaa610);
#line 58

#line 58
  return result;
#line 58
}
#line 58
# 225 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static inline  result_t AMPromiscuous$UARTSend$sendDone(TOS_MsgPtr msg, result_t success)
#line 225
{
  return AMPromiscuous$reportSendDone(msg, success);
}

# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BareSendMsg.nc"
inline static  result_t FramerM$BareSendMsg$sendDone(TOS_MsgPtr arg_0x1a5a1360, result_t arg_0x1a5a14f0){
#line 45
  unsigned char result;
#line 45

#line 45
  result = AMPromiscuous$UARTSend$sendDone(arg_0x1a5a1360, arg_0x1a5a14f0);
#line 45

#line 45
  return result;
#line 45
}
#line 45
# 42 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\NoLeds.nc"
static inline   result_t NoLeds$Leds$redToggle(void)
#line 42
{
  return SUCCESS;
}

# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
inline static   result_t QueuedSendM$Leds$redToggle(void){
#line 60
  unsigned char result;
#line 60

#line 60
  result = NoLeds$Leds$redToggle();
#line 60

#line 60
  return result;
#line 60
}
#line 60
# 164 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Queue\\QueuedSendM.nc"
static inline  result_t QueuedSendM$SerialSendMsg$sendDone(uint8_t id, TOS_MsgPtr msg, result_t success)
#line 164
{
  if (msg != QueuedSendM$msgqueue[QueuedSendM$dequeue_next].pMsg) {
      return FAIL;
    }


  if ((!QueuedSendM$retransmit || msg->ack != 0) || QueuedSendM$msgqueue[QueuedSendM$dequeue_next].address == TOS_UART_ADDR) {

      QueuedSendM$QueueSendMsg$sendDone(id, msg, success);
      QueuedSendM$msgqueue[QueuedSendM$dequeue_next].pMsg = (void *)0;
      {
      }
#line 174
      ;
      QueuedSendM$dequeue_next++;
#line 175
      QueuedSendM$dequeue_next %= QueuedSendM$MESSAGE_QUEUE_SIZE;
    }
  else {
      QueuedSendM$Leds$redToggle();
      if (++ QueuedSendM$msgqueue[QueuedSendM$dequeue_next].xmit_count > QueuedSendM$MAX_RETRANSMIT_COUNT) {


          QueuedSendM$QueueSendMsg$sendDone(id, msg, FAIL);
          QueuedSendM$msgqueue[QueuedSendM$dequeue_next].pMsg = (void *)0;
          QueuedSendM$dequeue_next++;
#line 184
          QueuedSendM$dequeue_next %= QueuedSendM$MESSAGE_QUEUE_SIZE;
        }
    }


  TOS_post(QueuedSendM$QueueServiceTask);

  return SUCCESS;
}

# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
inline static  result_t AMPromiscuous$SendMsg$sendDone(uint8_t arg_0x1a592088, TOS_MsgPtr arg_0x1a583e38, result_t arg_0x1a561010){
#line 27
  unsigned char result;
#line 27

#line 27
  result = QueuedSendM$SerialSendMsg$sendDone(arg_0x1a592088, arg_0x1a583e38, arg_0x1a561010);
#line 27

#line 27
  return result;
#line 27
}
#line 27
# 106 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Broadcast\\BcastM.nc"
static inline  result_t BcastM$SendMsg$sendDone(uint8_t id, TOS_MsgPtr pMsg, result_t success)
#line 106
{
  if (pMsg == &BcastM$FwdBuffer[BcastM$iFwdBufTail]) {
      BcastM$iFwdBufTail++;
#line 108
      BcastM$iFwdBufTail %= BcastM$FWD_QUEUE_SIZE;
    }
  return SUCCESS;
}

# 168 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static inline   result_t AMPromiscuous$default$sendDone(void)
#line 168
{
  return SUCCESS;
}

#line 46
inline static  result_t AMPromiscuous$sendDone(void){
#line 46
  unsigned char result;
#line 46

#line 46
  result = AMPromiscuous$default$sendDone();
#line 46

#line 46
  return result;
#line 46
}
#line 46
# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420FIFO.nc"
inline static   result_t CC2420RadioM$HPLChipconFIFO$writeTXFIFO(uint8_t arg_0x1a6c3f00, uint8_t *arg_0x1a6c20d0){
#line 56
  unsigned char result;
#line 56

#line 56
  result = HPLCC2420FIFOM$HPLCC2420FIFO$writeTXFIFO(arg_0x1a6c3f00, arg_0x1a6c20d0);
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420.nc"
inline static   uint8_t CC2420RadioM$HPLChipcon$cmd(uint8_t arg_0x1a6b14f8){
#line 51
  unsigned char result;
#line 51

#line 51
  result = HPLCC2420M$HPLCC2420$cmd(arg_0x1a6b14f8);
#line 51

#line 51
  return result;
#line 51
}
#line 51
# 247 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static inline result_t CC2420RadioM$fTXPacket(uint8_t len, uint8_t *pMsg)
#line 247
{

  uint8_t lenToWrite;


  if (!CC2420RadioM$HPLChipcon$cmd(0x09)) {
#line 252
    return FAIL;
    }




  lenToWrite = (size_t )& ((TOS_Msg *)0)->data;
  if (!(lenToWrite = CC2420RadioM$HPLChipconFIFO$writeTXFIFO(lenToWrite, (uint8_t *)pMsg))) {
    return FAIL;
    }








  return SUCCESS;
}

#line 1326
static inline    
#line 1325
void CC2420RadioM$RadioSendCoordinator$default$startSymbol(
uint8_t bitsPerBlock, uint8_t offset, TOS_MsgPtr msgBuff)
#line 1326
{
}

# 15 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\RadioCoordinator.nc"
inline static   void CC2420RadioM$RadioSendCoordinator$startSymbol(uint8_t arg_0x1a6a46c0, uint8_t arg_0x1a6a4848, TOS_MsgPtr arg_0x1a6a49d8){
#line 15
  CC2420RadioM$RadioSendCoordinator$default$startSymbol(arg_0x1a6a46c0, arg_0x1a6a4848, arg_0x1a6a49d8);
#line 15
}
#line 15
# 231 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static __inline result_t CC2420RadioM$setAckTimer(uint16_t jiffy)
#line 231
{
  CC2420RadioM$stateTimer = CC2420RadioM$TIMER_ACK;
  return CC2420RadioM$BackoffTimerJiffy$setOneShot(jiffy);
}

#line 216
static __inline result_t CC2420RadioM$setBackoffTimer(uint16_t jiffy)
#line 216
{
  CC2420RadioM$stateTimer = CC2420RadioM$TIMER_BACKOFF;

  if (jiffy == 0xffff) {
      return FAIL;
    }
  else 
#line 221
    {
      return CC2420RadioM$BackoffTimerJiffy$setOneShot(jiffy);
    }
}

#line 1321
static inline    int16_t CC2420RadioM$MacBackoff$default$congestionBackoff(TOS_MsgPtr m)
#line 1321
{
  return (CC2420RadioM$Random$rand() & 0xF) + 1;
}

# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\MacBackoff.nc"
inline static   int16_t CC2420RadioM$MacBackoff$congestionBackoff(TOS_MsgPtr arg_0x1a6738a8){
#line 44
  short result;
#line 44

#line 44
  result = CC2420RadioM$MacBackoff$default$congestionBackoff(arg_0x1a6738a8);
#line 44

#line 44
  return result;
#line 44
}
#line 44
# 114 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLCC2420M.nc"
static inline   result_t HPLCC2420M$HPLCC2420$disableFIFOP(void)
#line 114
{
  * (volatile uint8_t *)(0x39 + 0x20) &= ~(1 << 6);
  return SUCCESS;
}

# 42 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420.nc"
inline static   result_t CC2420RadioM$HPLChipcon$disableFIFOP(void){
#line 42
  unsigned char result;
#line 42

#line 42
  result = HPLCC2420M$HPLCC2420$disableFIFOP();
#line 42

#line 42
  return result;
#line 42
}
#line 42
# 153 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline int TOSH_READ_RADIO_CCA_PIN(void)
#line 153
{
#line 153
  return (* (volatile uint8_t *)(0x10 + 0x20) & (1 << 6)) != 0;
}

# 377 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static inline void CC2420RadioM$tryToSend(void)
#line 377
{
  uint8_t currentstate;
  int16_t backoffValue;

#line 380
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 380
    currentstate = CC2420RadioM$RadioState;
#line 380
    __nesc_atomic_end(__nesc_atomic); }


  if (currentstate == CC2420RadioM$PRE_TX_STATE || currentstate == CC2420RadioM$TX_STATE) {

      if (TOSH_READ_RADIO_CCA_PIN()) {
          { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 386
            CC2420RadioM$RadioState = CC2420RadioM$TX_STATE;
#line 386
            __nesc_atomic_end(__nesc_atomic); }
          CC2420RadioM$HPLChipcon$disableFIFOP();
          CC2420RadioM$sendPacket();
        }
      else 
#line 389
        {

          if (CC2420RadioM$cnttryToSend-- <= 0) {
              CC2420RadioM$fSendAborted();
              return;
            }

          backoffValue = CC2420RadioM$MacBackoff$congestionBackoff(CC2420RadioM$txbufptr) * 10;
          if (!CC2420RadioM$setBackoffTimer(backoffValue)) {
#line 397
            CC2420RadioM$fSendAborted();
            }
        }
    }
}

# 74 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\NoLeds.nc"
static inline   result_t NoLeds$Leds$set(uint8_t value)
#line 74
{
  return SUCCESS;
}

# 128 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
inline static   result_t XMDA300M$Leds$set(uint8_t arg_0x1a5b5a40){
#line 128
  unsigned char result;
#line 128

#line 128
  result = NoLeds$Leds$set(arg_0x1a5b5a40);
#line 128

#line 128
  return result;
#line 128
}
#line 128
# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
inline static  result_t XMDA300M$Timer$stop(void){
#line 46
  unsigned char result;
#line 46

#line 46
  result = TimerM$Timer$stop(0U);
#line 46

#line 46
  return result;
#line 46
}
#line 46
# 23 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
inline static  result_t RelayM$Dio6$Toggle(void){
#line 23
  unsigned char result;
#line 23

#line 23
  result = DioM$Dio$Toggle(6);
#line 23

#line 23
  return result;
#line 23
}
#line 23
# 76 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\RelayM.nc"
static inline  result_t RelayM$relay_normally_open$toggle(void)
{
  RelayM$Dio6$Toggle();
  return SUCCESS;
}

# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Relay.nc"
inline static  result_t XMDA300M$relay_normally_open$toggle(void){
#line 22
  unsigned char result;
#line 22

#line 22
  result = RelayM$relay_normally_open$toggle();
#line 22

#line 22
  return result;
#line 22
}
#line 22
# 23 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
inline static  result_t RelayM$Dio7$Toggle(void){
#line 23
  unsigned char result;
#line 23

#line 23
  result = DioM$Dio$Toggle(7);
#line 23

#line 23
  return result;
#line 23
}
#line 23
# 58 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\RelayM.nc"
static inline  result_t RelayM$relay_normally_closed$toggle(void)
{
  RelayM$Dio7$Toggle();
  return SUCCESS;
}

# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Relay.nc"
inline static  result_t XMDA300M$relay_normally_closed$toggle(void){
#line 22
  unsigned char result;
#line 22

#line 22
  result = RelayM$relay_normally_closed$toggle();
#line 22

#line 22
  return result;
#line 22
}
#line 22
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
inline static  result_t RelayM$Dio7$low(void){
#line 22
  unsigned char result;
#line 22

#line 22
  result = DioM$Dio$low(7);
#line 22

#line 22
  return result;
#line 22
}
#line 22
# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\RelayM.nc"
static inline  result_t RelayM$relay_normally_closed$open(void)
{
  RelayM$Dio7$low();
  return SUCCESS;
}

# 20 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Relay.nc"
inline static  result_t XMDA300M$relay_normally_closed$open(void){
#line 20
  unsigned char result;
#line 20

#line 20
  result = RelayM$relay_normally_closed$open();
#line 20

#line 20
  return result;
#line 20
}
#line 20
# 21 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
inline static  result_t RelayM$Dio7$high(void){
#line 21
  unsigned char result;
#line 21

#line 21
  result = DioM$Dio$high(7);
#line 21

#line 21
  return result;
#line 21
}
#line 21
# 52 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\RelayM.nc"
static inline  result_t RelayM$relay_normally_closed$close(void)
{
  RelayM$Dio7$high();
  return SUCCESS;
}

# 21 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Relay.nc"
inline static  result_t XMDA300M$relay_normally_closed$close(void){
#line 21
  unsigned char result;
#line 21

#line 21
  result = RelayM$relay_normally_closed$close();
#line 21

#line 21
  return result;
#line 21
}
#line 21
# 21 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
inline static  result_t RelayM$Dio6$high(void){
#line 21
  unsigned char result;
#line 21

#line 21
  result = DioM$Dio$high(6);
#line 21

#line 21
  return result;
#line 21
}
#line 21
# 64 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\RelayM.nc"
static inline  result_t RelayM$relay_normally_open$open(void)
{
  RelayM$Dio6$high();
  return SUCCESS;
}

# 20 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Relay.nc"
inline static  result_t XMDA300M$relay_normally_open$open(void){
#line 20
  unsigned char result;
#line 20

#line 20
  result = RelayM$relay_normally_open$open();
#line 20

#line 20
  return result;
#line 20
}
#line 20
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
inline static  result_t RelayM$Dio6$low(void){
#line 22
  unsigned char result;
#line 22

#line 22
  result = DioM$Dio$low(6);
#line 22

#line 22
  return result;
#line 22
}
#line 22
# 70 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\RelayM.nc"
static inline  result_t RelayM$relay_normally_open$close(void)
{
  RelayM$Dio6$low();
  return SUCCESS;
}

# 21 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Relay.nc"
inline static  result_t XMDA300M$relay_normally_open$close(void){
#line 21
  unsigned char result;
#line 21

#line 21
  result = RelayM$relay_normally_open$close();
#line 21

#line 21
  return result;
#line 21
}
#line 21
# 623 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\apps\\xmesh\\XMDA300\\XMDA300M.nc"
static inline  result_t XMDA300M$XCommand$received(XCommandOp *opcode)
#line 623
{

  switch (opcode->cmd) {
      case XCOMMAND_SET_RATE: 

        timer_rate = opcode->param.newrate;
      XMDA300M$Timer$stop();
      XMDA300M$Timer$start(TIMER_REPEAT, timer_rate);
      break;

      case XCOMMAND_ACTUATE: 

        if (opcode->param.actuate.device == XCMD_DEVICE_RELAY1) 
          {
            if (opcode->param.actuate.state == XCMD_STATE_OFF) {
#line 637
                XMDA300M$relay_normally_open$close();
              }
            else {
#line 638
              if (opcode->param.actuate.state == XCMD_STATE_ON) {
#line 638
                  XMDA300M$relay_normally_open$open();
                }
              else {
#line 639
                if (opcode->param.actuate.state == XCMD_STATE_TOGGLE) {

                    if (XMDA300M$test != 0) {
                        XMDA300M$test = 0;
                        XMDA300M$relay_normally_closed$toggle();
                      }
                    else {
                        XMDA300M$test = 1;
                        XMDA300M$relay_normally_open$toggle();
                      }
                  }
                }
              }
          }
#line 652
      if (opcode->param.actuate.device == XCMD_DEVICE_RELAY2) 
        {
          if (opcode->param.actuate.state == XCMD_STATE_OFF) {
#line 654
              XMDA300M$relay_normally_closed$close();
            }
          else {
#line 655
            if (opcode->param.actuate.state == XCMD_STATE_ON) {
#line 655
                XMDA300M$relay_normally_closed$open();
              }
            else {
#line 656
              if (opcode->param.actuate.state == XCMD_STATE_TOGGLE) {

                  if (XMDA300M$test != 0) {
                      XMDA300M$test = 0;
                      XMDA300M$relay_normally_closed$toggle();
                    }
                  else {
                      XMDA300M$test = 1;
                      XMDA300M$relay_normally_open$toggle();
                    }
                }
              }
            }
        }
#line 668
      break;

      case XCOMMAND_SLEEP: 

        XMDA300M$sleeping = TRUE;
      XMDA300M$StdControl$stop();
      XMDA300M$Timer$stop();
      XMDA300M$Leds$set(0);
      break;

      case XCOMMAND_WAKEUP: 

        if (XMDA300M$sleeping) {
            XMDA300M$initialize();
            XMDA300M$Timer$start(TIMER_REPEAT, timer_rate);
            XMDA300M$sleeping = FALSE;
          }
      break;

      case XCOMMAND_RESET: 

        break;

      default: 
        break;
    }

  return SUCCESS;
}

# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XCommand.nc"
inline static  result_t XCommandM$XCommand$received(XCommandOp *arg_0x1ad09a60){
#line 43
  unsigned char result;
#line 43

#line 43
  result = XMDA300M$XCommand$received(arg_0x1ad09a60);
#line 43

#line 43
  return result;
#line 43
}
#line 43
# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
inline static  result_t DioM$I2CPacket$writePacket(char arg_0x1b0913c0, char *arg_0x1b091560, char arg_0x1b0916e0){
#line 56
  unsigned char result;
#line 56

#line 56
  result = I2CPacketM$I2CPacket$writePacket(63, arg_0x1b0913c0, arg_0x1b091560, arg_0x1b0916e0);
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 20 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2C.nc"
inline static  result_t I2CPacketM$I2C$sendStart(void){
#line 20
  unsigned char result;
#line 20

#line 20
  result = I2CM$I2C$sendStart();
#line 20

#line 20
  return result;
#line 20
}
#line 20
# 113 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SwitchM.nc"
static inline  result_t SwitchM$I2CPacket$readPacketDone(char length, char *data)
#line 113
{
#line 178
  return SUCCESS;
}

# 318 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\I2CPacketM.nc"
static inline   result_t I2CPacketM$I2CPacket$default$readPacketDone(uint8_t id, char in_length, char *in_data)
#line 318
{
  return SUCCESS;
}

# 70 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
inline static  result_t I2CPacketM$I2CPacket$readPacketDone(uint8_t arg_0x1b0c4930, char arg_0x1b090010, char *arg_0x1b0901b0){
#line 70
  unsigned char result;
#line 70

#line 70
  switch (arg_0x1b0c4930) {
#line 70
    case 63:
#line 70
      result = DioM$I2CPacket$readPacketDone(arg_0x1b090010, arg_0x1b0901b0);
#line 70
      break;
#line 70
    case 74:
#line 70
      result = IBADCM$I2CPacket$readPacketDone(arg_0x1b090010, arg_0x1b0901b0);
#line 70
      break;
#line 70
    case 75:
#line 70
      result = SwitchM$I2CPacket$readPacketDone(arg_0x1b090010, arg_0x1b0901b0);
#line 70
      break;
#line 70
    default:
#line 70
      result = I2CPacketM$I2CPacket$default$readPacketDone(arg_0x1b0c4930, arg_0x1b090010, arg_0x1b0901b0);
#line 70
      break;
#line 70
    }
#line 70

#line 70
  return result;
#line 70
}
#line 70
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2C.nc"
inline static  result_t I2CPacketM$I2C$sendEnd(void){
#line 27
  unsigned char result;
#line 27

#line 27
  result = I2CM$I2C$sendEnd();
#line 27

#line 27
  return result;
#line 27
}
#line 27







inline static  result_t I2CPacketM$I2C$read(bool arg_0x1b088a00){
#line 34
  unsigned char result;
#line 34

#line 34
  result = I2CM$I2C$read(arg_0x1b088a00);
#line 34

#line 34
  return result;
#line 34
}
#line 34
# 296 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\I2CPacketM.nc"
static inline  result_t I2CPacketM$I2C$readDone(char in_data)
#line 296
{
  I2CPacketM$temp[I2CPacketM$index - 1] = in_data;
  I2CPacketM$index++;
  if (I2CPacketM$index == I2CPacketM$length) {
    I2CPacketM$I2C$read((I2CPacketM$flags & I2CPacketM$ACK_END_FLAG) == I2CPacketM$ACK_END_FLAG);
    }
  else {
#line 301
    if (I2CPacketM$index < I2CPacketM$length) {
      I2CPacketM$I2C$read((I2CPacketM$flags & I2CPacketM$ACK_FLAG) == I2CPacketM$ACK_FLAG);
      }
    else {
#line 303
      if (I2CPacketM$index > I2CPacketM$length) 
        {
          I2CPacketM$state = I2CPacketM$I2C_READ_DONE;
          I2CPacketM$data = (char *)&I2CPacketM$temp;
          if (I2CPacketM$flags & I2CPacketM$STOP_FLAG) {
            I2CPacketM$I2C$sendEnd();
            }
          else {
              I2CPacketM$state = I2CPacketM$IDLE;
              I2CPacketM$I2CPacket$readPacketDone(I2CPacketM$addr, I2CPacketM$length, I2CPacketM$data);
            }
        }
      }
    }
#line 315
  return SUCCESS;
}

# 62 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2C.nc"
inline static  result_t I2CM$I2C$readDone(char arg_0x1b0852b8){
#line 62
  unsigned char result;
#line 62

#line 62
  result = I2CPacketM$I2C$readDone(arg_0x1b0852b8);
#line 62

#line 62
  return result;
#line 62
}
#line 62
# 21 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Sample.nc"
inline static  result_t SamplerM$Sample$dataReady(uint8_t arg_0x1ad03e30, uint8_t arg_0x1ad01010, uint16_t arg_0x1ad011a0){
#line 21
  unsigned char result;
#line 21

#line 21
  result = XMDA300M$Sample$dataReady(arg_0x1ad03e30, arg_0x1ad01010, arg_0x1ad011a0);
#line 21

#line 21
  return result;
#line 21
}
#line 21
# 434 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static inline  result_t SamplerM$ADC0$dataReady(uint16_t data)
#line 434
{
  if (data != 0xffff) {
#line 435
    SamplerM$Sample$dataReady(0, ANALOG, data);
    }
#line 436
  return SUCCESS;
}

# 88 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
inline static  void *XMDA300M$Send$getBuffer(TOS_MsgPtr arg_0x1ab4b7c0, uint16_t *arg_0x1ab4b970){
#line 88
  void *result;
#line 88

#line 88
  result = ShimLayerM$MhopSend$getBuffer(AM_XMULTIHOP_MSG, arg_0x1ab4b7c0, arg_0x1ab4b970);
#line 88

#line 88
  return result;
#line 88
}
#line 88
# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\RouteControl.nc"
inline static  uint16_t XMDA300M$RouteControl$getParent(void){
#line 27
  unsigned short result;
#line 27

#line 27
  result = XMeshC$RouteControl$getParent();
#line 27

#line 27
  return result;
#line 27
}
#line 27
# 58 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\NoLeds.nc"
static inline   result_t NoLeds$Leds$yellowOn(void)
#line 58
{
  return SUCCESS;
}

# 93 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
inline static   result_t XMDA300M$Leds$yellowOn(void){
#line 93
  unsigned char result;
#line 93

#line 93
  result = NoLeds$Leds$yellowOn();
#line 93

#line 93
  return result;
#line 93
}
#line 93
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
inline static  result_t XMDA300M$Send$send(uint16_t arg_0x1ab219b8, uint8_t arg_0x1ab21b40, TOS_MsgPtr arg_0x1ab21cd0, uint16_t arg_0x1ab21e60){
#line 65
  unsigned char result;
#line 65

#line 65
  result = ShimLayerM$MhopSend$send(AM_XMULTIHOP_MSG, arg_0x1ab219b8, arg_0x1ab21b40, arg_0x1ab21cd0, arg_0x1ab21e60);
#line 65

#line 65
  return result;
#line 65
}
#line 65
# 50 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\NoLeds.nc"
static inline   result_t NoLeds$Leds$greenOff(void)
#line 50
{
  return SUCCESS;
}

# 76 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
inline static   result_t XMDA300M$Leds$greenOff(void){
#line 76
  unsigned char result;
#line 76

#line 76
  result = NoLeds$Leds$greenOff();
#line 76

#line 76
  return result;
#line 76
}
#line 76
# 422 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static inline  result_t SamplerM$Sample$stop(int8_t record)
{
  if (record < 0 || record > 25) {
#line 424
    return FAIL;
    }
#line 425
  SamplerM$SampleRecord[record].sampling_interval = SAMPLE_RECORD_FREE;
  return SUCCESS;
}

# 23 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Sample.nc"
inline static  result_t XMDA300M$Sample$stop(int8_t arg_0x1ad01c70){
#line 23
  unsigned char result;
#line 23

#line 23
  result = SamplerM$Sample$stop(arg_0x1ad01c70);
#line 23

#line 23
  return result;
#line 23
}
#line 23
# 191 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\TempHumM.nc"
static inline  result_t TempHumM$StdControl$stop(void)
#line 191
{
  return SUCCESS;
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t SamplerM$TempHumControl$stop(void){
#line 56
  unsigned char result;
#line 56

#line 56
  result = TempHumM$StdControl$stop();
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 42 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\VoltageM.nc"
static inline  result_t VoltageM$StdControl$stop(void)
#line 42
{



  return SUCCESS;
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t SamplerM$BatteryControl$stop(void){
#line 56
  unsigned char result;
#line 56

#line 56
  result = VoltageM$StdControl$stop();
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 52 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SwitchM.nc"
static inline  result_t SwitchM$SwitchControl$stop(void)
#line 52
{
  return SUCCESS;
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t IBADCM$SwitchControl$stop(void){
#line 56
  unsigned char result;
#line 56

#line 56
  result = SwitchM$SwitchControl$stop();
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 343 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
static inline  result_t IBADCM$StdControl$stop(void)
#line 343
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 344
    {
      IBADCM$sflag = 0;
      IBADCM$state = IBADCM$IDLE;
      IBADCM$scount = 0;
    }
#line 348
    __nesc_atomic_end(__nesc_atomic); }
  if (IBADCM$initflag == 1) 
    {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 351
        IBADCM$adc_bitmap = 0;
#line 351
        __nesc_atomic_end(__nesc_atomic); }
    }
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 353
    {
      if (IBADCM$scount == 0) 
        {
          TOS_post(IBADCM$stopchannel);
          IBADCM$scount = 1;
        }
    }
#line 359
    __nesc_atomic_end(__nesc_atomic); }

  TOSH_SET_PW6_PIN();
  IBADCM$resetExcitation();
  if (IBADCM$initflag == 0) 
    {
      IBADCM$initflag = 1;
    }
  IBADCM$SwitchControl$stop();
  return SUCCESS;
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t SamplerM$IBADCcontrol$stop(void){
#line 56
  unsigned char result;
#line 56

#line 56
  result = IBADCM$StdControl$stop();
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 98 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
static inline  result_t DioM$StdControl$stop(void)
#line 98
{
  return SUCCESS;
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t SamplerM$DioControl$stop(void){
#line 56
  unsigned char result;
#line 56

#line 56
  result = DioM$StdControl$stop();
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 74 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\CounterM.nc"
static inline  result_t CounterM$CounterControl$stop(void)
#line 74
{
  * (volatile uint8_t *)(0x39 + 0x20) &= ~(1 << 5);
  return SUCCESS;
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t SamplerM$CounterControl$stop(void){
#line 56
  unsigned char result;
#line 56

#line 56
  result = CounterM$CounterControl$stop();
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 351 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static inline  result_t SamplerM$SamplerControl$stop(void)
#line 351
{
  SamplerM$CounterControl$stop();
  SamplerM$DioControl$stop();
  SamplerM$IBADCcontrol$stop();
  SamplerM$BatteryControl$stop();
  SamplerM$TempHumControl$stop();
  return SUCCESS;
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t XMDA300M$SamplerControl$stop(void){
#line 56
  unsigned char result;
#line 56

#line 56
  result = SamplerM$SamplerControl$stop();
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
inline static  result_t IBADCM$I2CPacket$writePacket(char arg_0x1b0913c0, char *arg_0x1b091560, char arg_0x1b0916e0){
#line 56
  unsigned char result;
#line 56

#line 56
  result = I2CPacketM$I2CPacket$writePacket(74, arg_0x1b0913c0, arg_0x1b091560, arg_0x1b0916e0);
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 439 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static inline  result_t SamplerM$ADC1$dataReady(uint16_t data)
#line 439
{
  if (data != 0xffff) {
#line 440
    SamplerM$Sample$dataReady(1, ANALOG, data);
    }
#line 441
  return SUCCESS;
}

static inline  result_t SamplerM$ADC2$dataReady(uint16_t data)
#line 444
{
  if (data != 0xffff) {
#line 445
    SamplerM$Sample$dataReady(2, ANALOG, data);
    }
#line 446
  return SUCCESS;
}

static inline  result_t SamplerM$ADC3$dataReady(uint16_t data)
#line 449
{
  if (data != 0xffff) {
#line 450
    SamplerM$Sample$dataReady(3, ANALOG, data);
    }
#line 451
  return SUCCESS;
}

static inline  result_t SamplerM$ADC4$dataReady(uint16_t data)
#line 454
{
  if (data != 0xffff) {
#line 455
    SamplerM$Sample$dataReady(4, ANALOG, data);
    }
#line 456
  return SUCCESS;
}

static inline  result_t SamplerM$ADC5$dataReady(uint16_t data)
#line 459
{
  if (data != 0xffff) {
#line 460
    SamplerM$Sample$dataReady(5, ANALOG, data);
    }
#line 461
  return SUCCESS;
}

static inline  result_t SamplerM$ADC6$dataReady(uint16_t data)
#line 464
{
  if (data != 0xffff) {
#line 465
    SamplerM$Sample$dataReady(6, ANALOG, data);
    }
#line 466
  return SUCCESS;
}

static inline  result_t SamplerM$ADC7$dataReady(uint16_t data)
#line 469
{
  if (data != 0xffff) {
#line 470
    SamplerM$Sample$dataReady(7, ANALOG, data);
    }
#line 471
  return SUCCESS;
}

static inline  result_t SamplerM$ADC8$dataReady(uint16_t data)
#line 474
{
  if (data != 0xffff) {
#line 475
    SamplerM$Sample$dataReady(8, ANALOG, data);
    }
#line 476
  return SUCCESS;
}

static inline  result_t SamplerM$ADC9$dataReady(uint16_t data)
#line 479
{
  if (data != 0xffff) {
#line 480
    SamplerM$Sample$dataReady(9, ANALOG, data);
    }
#line 481
  return SUCCESS;
}

static inline  result_t SamplerM$ADC10$dataReady(uint16_t data)
#line 484
{
  if (data != 0xffff) {
#line 485
    SamplerM$Sample$dataReady(10, ANALOG, data);
    }
#line 486
  return SUCCESS;
}

static inline  result_t SamplerM$ADC11$dataReady(uint16_t data)
#line 489
{
  if (data != 0xffff) {
#line 490
    SamplerM$Sample$dataReady(11, ANALOG, data);
    }
#line 491
  return SUCCESS;
}

static inline  result_t SamplerM$ADC12$dataReady(uint16_t data)
#line 494
{
  if (data != 0xffff) {
#line 495
    SamplerM$Sample$dataReady(12, ANALOG, data);
    }
#line 496
  return SUCCESS;
}

static inline  result_t SamplerM$ADC13$dataReady(uint16_t data)
#line 499
{
  if (data != 0xffff) {
#line 500
    SamplerM$Sample$dataReady(13, ANALOG, data);
    }
#line 501
  return SUCCESS;
}

# 175 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline void TOSH_CLR_PW1_PIN(void)
#line 175
{
#line 175
  * (volatile uint8_t *)(0x15 + 0x20) &= ~(1 << 1);
}


static __inline void TOSH_SET_PW5_PIN(void)
#line 179
{
#line 179
  * (volatile uint8_t *)(0x15 + 0x20) |= 1 << 5;
}

#line 177
static __inline void TOSH_SET_PW3_PIN(void)
#line 177
{
#line 177
  * (volatile uint8_t *)(0x15 + 0x20) |= 1 << 3;
}

#line 176
static __inline void TOSH_SET_PW2_PIN(void)
#line 176
{
#line 176
  * (volatile uint8_t *)(0x15 + 0x20) |= 1 << 2;
}

# 98 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
static inline void IBADCM$setExcitation(void)
{
  uint8_t i = 0;

#line 101
  if (IBADCM$param[IBADCM$chan] & EXCITATION_25) 
    {
      i++;
      TOSH_SET_PW2_PIN();
    }
  if (IBADCM$param[IBADCM$chan] & EXCITATION_33) 
    {
      i++;
      TOSH_SET_PW3_PIN();
    }
  if (IBADCM$param[IBADCM$chan] & EXCITATION_50) 
    {
      i++;
      TOSH_SET_PW5_PIN();
    }
  if (i > 0) 
    {
      TOSH_CLR_PW1_PIN();
    }
}

#line 181
static inline void IBADCM$setNumberOfConversions(void)
{
  IBADCM$conversionNumber = 1;
  if (IBADCM$param[IBADCM$chan] & AVERAGE_FOUR) {
#line 184
    IBADCM$conversionNumber = 4;
    }
#line 185
  if (IBADCM$param[IBADCM$chan] & AVERAGE_EIGHT) {
#line 185
    IBADCM$conversionNumber = 8;
    }
#line 186
  if (IBADCM$param[IBADCM$chan] & AVERAGE_SIXTEEN) {
#line 186
    IBADCM$conversionNumber = 16;
    }
#line 187
  return;
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
inline static  result_t SwitchM$I2CPacket$writePacket(char arg_0x1b0913c0, char *arg_0x1b091560, char arg_0x1b0916e0){
#line 56
  unsigned char result;
#line 56

#line 56
  result = I2CPacketM$I2CPacket$writePacket(75, arg_0x1b0913c0, arg_0x1b091560, arg_0x1b0916e0);
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 81 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SwitchM.nc"
static inline  result_t SwitchM$Switch$setAll(char val)
#line 81
{
  if (SwitchM$state == SwitchM$IDLE) 
    {
      SwitchM$state = SwitchM$SET_SWITCH_ALL;
      SwitchM$sw_state = val;
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 86
        SwitchM$i2cwflag = 1;
#line 86
        __nesc_atomic_end(__nesc_atomic); }
      if (SwitchM$I2CPacket$writePacket(1, (char *)&SwitchM$sw_state, 0x03) == FAIL) 
        {
          { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 89
            SwitchM$i2cwflag = 0;
#line 89
            __nesc_atomic_end(__nesc_atomic); }
          SwitchM$state = SwitchM$IDLE;
          return FAIL;
        }
      else {
#line 93
        return SUCCESS;
        }
    }
#line 95
  return FAIL;
}

# 24 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Switch.nc"
inline static  result_t IBADCM$Switch$setAll(char arg_0x1b160a08){
#line 24
  unsigned char result;
#line 24

#line 24
  result = SwitchM$Switch$setAll(arg_0x1b160a08);
#line 24

#line 24
  return result;
#line 24
}
#line 24
# 82 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\RelayM.nc"
static inline  result_t RelayM$Dio6$dataReady(uint16_t data)
#line 82
{
  return SUCCESS;
}

static inline  result_t RelayM$Dio7$dataReady(uint16_t data)
#line 86
{
  return SUCCESS;
}

# 522 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static inline  result_t SamplerM$Dio0$dataReady(uint16_t data)
#line 522
{
  SamplerM$Sample$dataReady(0, DIGITAL, data);
  return SUCCESS;
}

static inline  result_t SamplerM$Dio1$dataReady(uint16_t data)
#line 527
{
  SamplerM$Sample$dataReady(1, DIGITAL, data);
  return SUCCESS;
}

static inline  result_t SamplerM$Dio2$dataReady(uint16_t data)
#line 532
{
  SamplerM$Sample$dataReady(2, DIGITAL, data);
  return SUCCESS;
}

static inline  result_t SamplerM$Dio3$dataReady(uint16_t data)
#line 537
{
  SamplerM$Sample$dataReady(3, DIGITAL, data);
  return SUCCESS;
}

static inline  result_t SamplerM$Dio4$dataReady(uint16_t data)
#line 542
{
  SamplerM$Sample$dataReady(4, DIGITAL, data);
  return SUCCESS;
}

static inline  result_t SamplerM$Dio5$dataReady(uint16_t data)
#line 547
{
  SamplerM$Sample$dataReady(5, DIGITAL, data);
  return SUCCESS;
}

# 76 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\I2CM.nc"
static inline char I2CM$i2c_read(void)
#line 76
{
  uint8_t data = 0;
  uint8_t i = 0;

#line 79
  for (i = 0; i < 8; i++) {
      data = (data << 1) & 0xfe;
      if (I2CM$read_bit() == 1) {
          data |= 0x1;
        }
    }
  return data;
}

# 185 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline void TOSH_MAKE_I2C_BUS1_SDA_INPUT(void)
#line 185
{
#line 185
  * (volatile uint8_t *)(0x11 + 0x20) &= ~(1 << 1);
}

# 54 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\I2CM.nc"
static inline void I2CM$MAKE_DATA_INPUT(void)
#line 54
{
#line 54
  TOSH_MAKE_I2C_BUS1_SDA_INPUT();
}

# 185 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline int TOSH_READ_I2C_BUS1_SDA_PIN(void)
#line 185
{
#line 185
  return (* (volatile uint8_t *)(0x10 + 0x20) & (1 << 1)) != 0;
}

# 55 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\I2CM.nc"
static inline char I2CM$GET_DATA(void)
#line 55
{
#line 55
  return TOSH_READ_I2C_BUS1_SDA_PIN();
}

# 185 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline void TOSH_CLR_I2C_BUS1_SDA_PIN(void)
#line 185
{
#line 185
  * (volatile uint8_t *)(0x12 + 0x20) &= ~(1 << 1);
}

# 52 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\I2CM.nc"
static inline void I2CM$CLEAR_DATA(void)
#line 52
{
#line 52
  TOSH_CLR_I2C_BUS1_SDA_PIN();
}

#line 114
static inline void I2CM$i2c_ack(void)
#line 114
{
  I2CM$MAKE_DATA_OUTPUT();
  I2CM$CLEAR_DATA();
  I2CM$pulse_clock();
}

static inline void I2CM$i2c_nack(void)
#line 120
{
  I2CM$MAKE_DATA_OUTPUT();
  I2CM$SET_DATA();
  I2CM$pulse_clock();
}

# 322 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\I2CPacketM.nc"
static inline   result_t I2CPacketM$I2CPacket$default$writePacketDone(uint8_t id, bool result)
#line 322
{
  return SUCCESS;
}

# 78 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
inline static  result_t I2CPacketM$I2CPacket$writePacketDone(uint8_t arg_0x1b0c4930, bool arg_0x1b0909e8){
#line 78
  unsigned char result;
#line 78

#line 78
  switch (arg_0x1b0c4930) {
#line 78
    case 63:
#line 78
      result = DioM$I2CPacket$writePacketDone(arg_0x1b0909e8);
#line 78
      break;
#line 78
    case 74:
#line 78
      result = IBADCM$I2CPacket$writePacketDone(arg_0x1b0909e8);
#line 78
      break;
#line 78
    case 75:
#line 78
      result = SwitchM$I2CPacket$writePacketDone(arg_0x1b0909e8);
#line 78
      break;
#line 78
    default:
#line 78
      result = I2CPacketM$I2CPacket$default$writePacketDone(arg_0x1b0c4930, arg_0x1b0909e8);
#line 78
      break;
#line 78
    }
#line 78

#line 78
  return result;
#line 78
}
#line 78
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2C.nc"
inline static  result_t I2CPacketM$I2C$write(char arg_0x1b0870f0){
#line 41
  unsigned char result;
#line 41

#line 41
  result = I2CM$I2C$write(arg_0x1b0870f0);
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 253 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\I2CPacketM.nc"
static inline  result_t I2CPacketM$I2C$writeDone(bool result)
#line 253
{
  if (result == FAIL) {
      I2CPacketM$state = I2CPacketM$IDLE;
      I2CPacketM$I2CPacket$writePacketDone(I2CPacketM$addr, FAIL);
      return FAIL;
    }
  if (I2CPacketM$state == I2CPacketM$I2C_WRITE_DATA && I2CPacketM$index < I2CPacketM$length) 
    {
      I2CPacketM$index++;
      if (I2CPacketM$index == I2CPacketM$length) {
          I2CPacketM$state = I2CPacketM$I2C_STOP_COMMAND;
        }
      return I2CPacketM$I2C$write(I2CPacketM$data[I2CPacketM$index - 1]);
    }
  else {
#line 267
    if (I2CPacketM$state == I2CPacketM$I2C_STOP_COMMAND) 
      {
        I2CPacketM$state = I2CPacketM$I2C_STOP_COMMAND_SENT;
        if (I2CPacketM$flags & I2CPacketM$STOP_FLAG) 
          {
            return I2CPacketM$I2C$sendEnd();
          }
        else {
            I2CPacketM$state = I2CPacketM$IDLE;
            return I2CPacketM$I2CPacket$writePacketDone(I2CPacketM$addr, SUCCESS);
          }
      }
    else {
#line 279
      if (I2CPacketM$state == I2CPacketM$I2C_READ_DATA) 
        {
          if (I2CPacketM$index == I2CPacketM$length) 
            {
              return I2CPacketM$I2C$read((I2CPacketM$flags & I2CPacketM$ACK_END_FLAG) == I2CPacketM$ACK_END_FLAG);
            }
          else {
#line 285
            if (I2CPacketM$index < I2CPacketM$length) {
              return I2CPacketM$I2C$read((I2CPacketM$flags & I2CPacketM$ACK_FLAG) == I2CPacketM$ACK_FLAG);
              }
            }
        }
      }
    }
#line 289
  return SUCCESS;
}

# 71 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2C.nc"
inline static  result_t I2CM$I2C$writeDone(bool arg_0x1b085978){
#line 71
  unsigned char result;
#line 71

#line 71
  result = I2CPacketM$I2C$writeDone(arg_0x1b085978);
#line 71

#line 71
  return result;
#line 71
}
#line 71
# 663 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
static inline  result_t IBADCM$Switch$setDone(bool r)
{
  return SUCCESS;
}

# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Switch.nc"
inline static  result_t SwitchM$Switch$setDone(bool arg_0x1b194338){
#line 27
  unsigned char result;
#line 27

#line 27
  result = IBADCM$Switch$setDone(arg_0x1b194338);
#line 27

#line 27
  return result;
#line 27
}
#line 27
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
inline static  result_t IBADCM$PowerStabalizingTimer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500){
#line 37
  unsigned char result;
#line 37

#line 37
  result = TimerM$Timer$start(11U, arg_0x1a5d5368, arg_0x1a5d5500);
#line 37

#line 37
  return result;
#line 37
}
#line 37
# 537 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
static inline  result_t IBADCM$Switch$setAllDone(bool r)
{
  if (IBADCM$swsetallflag == 0) {
#line 539
    return SUCCESS;
    }
#line 540
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 540
    IBADCM$swsetallflag = 0;
#line 540
    __nesc_atomic_end(__nesc_atomic); }
  if (!r) {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 542
        IBADCM$state = IBADCM$IDLE;
#line 542
        __nesc_atomic_end(__nesc_atomic); }
      TOSH_SET_PW6_PIN();
      TOS_post(IBADCM$adc_get_data);
      IBADCM$resetExcitation();
      return FAIL;
    }



  if (IBADCM$param[IBADCM$chan] & DELAY_BEFORE_MEASUREMENT) {
      IBADCM$PowerStabalizingTimer$start(TIMER_ONE_SHOT, 100);
      return SUCCESS;
    }
  else {
      return IBADCM$convert();
    }
  return SUCCESS;
}

# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Switch.nc"
inline static  result_t SwitchM$Switch$setAllDone(bool arg_0x1b1947d0){
#line 28
  unsigned char result;
#line 28

#line 28
  result = IBADCM$Switch$setAllDone(arg_0x1b1947d0);
#line 28

#line 28
  return result;
#line 28
}
#line 28
# 39 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
inline static  result_t IBADCM$I2CPacket$readPacket(char arg_0x1b093858, char arg_0x1b0939d8){
#line 39
  unsigned char result;
#line 39

#line 39
  result = I2CPacketM$I2CPacket$readPacket(74, arg_0x1b093858, arg_0x1b0939d8);
#line 39

#line 39
  return result;
#line 39
}
#line 39
# 88 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\I2CM.nc"
static inline char I2CM$i2c_write(char c)
#line 88
{
  uint8_t i;

#line 90
  I2CM$MAKE_DATA_OUTPUT();
  for (i = 0; i < 8; i++) {
      if (c & 0x80) {
          I2CM$SET_DATA();
        }
      else 
#line 94
        {
          I2CM$CLEAR_DATA();
        }
      I2CM$pulse_clock();
      c = c << 1;
    }
  i = I2CM$read_bit();
  return i == 0;
}

# 184 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline void TOSH_CLR_I2C_BUS1_SCL_PIN(void)
#line 184
{
#line 184
  * (volatile uint8_t *)(0x12 + 0x20) &= ~(1 << 0);
}

# 47 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\I2CM.nc"
static inline void I2CM$CLEAR_CLOCK(void)
#line 47
{
#line 47
  TOSH_CLR_I2C_BUS1_SCL_PIN();
}

#line 104
static inline void I2CM$i2c_start(void)
#line 104
{
  I2CM$SET_DATA();
  I2CM$SET_CLOCK();
  I2CM$MAKE_DATA_OUTPUT();
  TOSH_uwait(5);
  I2CM$CLEAR_DATA();
  TOSH_uwait(5);
  I2CM$CLEAR_CLOCK();
}

# 199 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\I2CPacketM.nc"
static inline  result_t I2CPacketM$I2C$sendStartDone(void)
#line 199
{
  if (I2CPacketM$state == I2CPacketM$I2C_WRITE_ADDRESS) {
      I2CPacketM$state = I2CPacketM$I2C_WRITE_DATA;
      I2CPacketM$I2C$write(I2CPacketM$flags & I2CPacketM$ADDR_8BITS_FLAG ? I2CPacketM$addr : (I2CPacketM$addr << 1) + 0);
    }
  else {
#line 204
    if (I2CPacketM$state == I2CPacketM$I2C_READ_ADDRESS) {
        I2CPacketM$state = I2CPacketM$I2C_READ_DATA;
        I2CPacketM$I2C$write(I2CPacketM$flags & I2CPacketM$ADDR_8BITS_FLAG ? I2CPacketM$addr : (I2CPacketM$addr << 1) + 1);
        I2CPacketM$index++;
      }
    }
#line 209
  return 1;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2C.nc"
inline static  result_t I2CM$I2C$sendStartDone(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = I2CPacketM$I2C$sendStartDone();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 126 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\I2CM.nc"
static inline void I2CM$i2c_end(void)
#line 126
{
  I2CM$MAKE_DATA_OUTPUT();
  I2CM$CLEAR_DATA();
  TOSH_uwait(5);
  I2CM$SET_CLOCK();
  TOSH_uwait(5);
  I2CM$SET_DATA();
}

# 215 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\I2CPacketM.nc"
static inline  result_t I2CPacketM$I2C$sendEndDone(void)
#line 215
{
  char *out_data;
  char out_length;
  char out_addr;

  out_addr = I2CPacketM$addr;
  out_length = I2CPacketM$length;
  out_data = I2CPacketM$data;

  if (I2CPacketM$state == I2CPacketM$I2C_STOP_COMMAND_SENT) {

      I2CPacketM$state = I2CPacketM$IDLE;
      I2CPacketM$I2CPacket$writePacketDone(out_addr, SUCCESS);
    }
  else {
#line 229
    if (I2CPacketM$state == I2CPacketM$I2C_READ_DONE) {
        I2CPacketM$state = I2CPacketM$IDLE;
        I2CPacketM$I2CPacket$readPacketDone(out_addr, out_length, out_data);
      }
    }
  return SUCCESS;
}

# 55 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2C.nc"
inline static  result_t I2CM$I2C$sendEndDone(void){
#line 55
  unsigned char result;
#line 55

#line 55
  result = I2CPacketM$I2C$sendEndDone();
#line 55

#line 55
  return result;
#line 55
}
#line 55
# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
inline static  size_t XCommandM$Config$get(uint32_t arg_0x1aefcd98, void *arg_0x1ad7b6b8, size_t arg_0x1ad7b840){
#line 43
  unsigned int result;
#line 43

#line 43
  result = RecoverParamsM$ExternalConfig$get(arg_0x1aefcd98, arg_0x1ad7b6b8, arg_0x1ad7b840);
#line 43

#line 43
  return result;
#line 43
}
#line 43
# 200 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XCommandM.nc"
static inline void XCommandM$getMyConfig(void)
{
  XCommandM$state = XCommandM$GET_CONFIG;
  XCommandM$Config$get(CONFIG_MOTE_SERIAL, &XCommandM$readings.xData.configdata1.uid[0], 8);
  XCommandM$Config$get(CONFIG_MOTE_ID, & XCommandM$readings.xData.configdata1.nodeid, sizeof(uint16_t ));
  XCommandM$Config$get(CONFIG_MOTE_GROUP, & XCommandM$readings.xData.configdata1.group, sizeof(uint8_t ));
  XCommandM$Config$get(CONFIG_RF_POWER, & XCommandM$readings.xData.configdata1.rf_power, sizeof(uint8_t ));
  XCommandM$Config$get(CONFIG_RF_CHANNEL, & XCommandM$readings.xData.configdata1.rf_channel, sizeof(uint8_t ));
  XCommandM$readings.xHeader.responseCode = XCMD_RES_SUCCESS;
  XCommandM$state = XCommandM$IDLE;
  XCommandM$nextPacketID = XCommandM$CONFIG_PKT;
  TOS_post(XCommandM$send_msg);
  return;
}

# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\ConfigSave.nc"
inline static  result_t XCommandM$ConfigSave$save(AppParamID_t arg_0x1ad77730, AppParamID_t arg_0x1ad778c0){
#line 36
  unsigned char result;
#line 36

#line 36
  result = EEPROMConfigM$ConfigSave$save(arg_0x1ad77730, arg_0x1ad778c0);
#line 36

#line 36
  return result;
#line 36
}
#line 36
# 57 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
inline static  result_t XCommandM$Config$set(uint32_t arg_0x1aefcd98, void *arg_0x1ad7bcf0, size_t arg_0x1ad7be78){
#line 57
  unsigned char result;
#line 57

#line 57
  result = RecoverParamsM$ExternalConfig$set(arg_0x1aefcd98, arg_0x1ad7bcf0, arg_0x1ad7be78);
#line 57

#line 57
  return result;
#line 57
}
#line 57
# 267 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XCommandM.nc"
static inline void XCommandM$Set_TimerRate(uint32_t *ptrTimerRate)
{
  XCommandM$state = XCommandM$SET_TIMERRATE;

  XCommandM$Config$set(CONFIG_XMESHAPP_TIMER_RATE, ptrTimerRate, 4 * sizeof(uint8_t ));
  if (XCommandM$ConfigSave$save(CONFIG_XMESHAPP_TIMER_RATE, CONFIG_XMESHAPP_TIMER_RATE) != SUCCESS) 
    {
      XCommandM$readings.xHeader.responseCode = XCMD_RES_FAIL;
      XCommandM$readings.xData.newrate = timer_rate;
      XCommandM$state = XCommandM$IDLE;
      XCommandM$nextPacketID = XCommandM$SETTIMERRATE_PKT;
      TOS_post(XCommandM$send_msg);
    }
  return;
}

# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
inline static   result_t EEPROMConfigM$Leds$redToggle(void){
#line 60
  unsigned char result;
#line 60

#line 60
  result = NoLeds$Leds$redToggle();
#line 60

#line 60
  return result;
#line 60
}
#line 60
# 237 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XCommandM.nc"
static inline void XCommandM$Set_NodeID(uint16_t *ptrNodeid)
{
  XCommandM$state = XCommandM$SET_NODEID;
  XCommandM$Config$set(CONFIG_MOTE_ID, ptrNodeid, sizeof(uint16_t ));
  if (XCommandM$ConfigSave$save(CONFIG_MOTE_ID, CONFIG_MOTE_ID) != SUCCESS) 
    {
      XCommandM$readings.xHeader.responseCode = XCMD_RES_FAIL;
      XCommandM$readings.xData.nodeid = TOS_LOCAL_ADDRESS;
      XCommandM$state = XCommandM$IDLE;
      XCommandM$nextPacketID = XCommandM$SETNODEID_PKT;
      TOS_post(XCommandM$send_msg);
    }
  return;
}

static inline void XCommandM$Set_GroupID(uint8_t *ptrGroupid)
{
  XCommandM$state = XCommandM$SET_GROUPID;
  XCommandM$Config$set(CONFIG_MOTE_GROUP, ptrGroupid, sizeof(uint8_t ));
  if (XCommandM$ConfigSave$save(CONFIG_MOTE_GROUP, CONFIG_MOTE_GROUP) != SUCCESS) 
    {
      XCommandM$readings.xHeader.responseCode = XCMD_RES_FAIL;
      XCommandM$readings.xData.groupid = TOS_AM_GROUP;
      XCommandM$state = XCommandM$IDLE;
      XCommandM$nextPacketID = XCommandM$SETGROUPID_PKT;
      TOS_post(XCommandM$send_msg);
    }
  return;
}

#line 299
static inline void XCommandM$Set_RFPOWER(uint8_t *ptrRFPower)
{
  XCommandM$state = XCommandM$SET_RFPOWER;
  XCommandM$Config$set(CONFIG_RF_POWER, ptrRFPower, sizeof(uint8_t ));
  if (XCommandM$ConfigSave$save(CONFIG_RF_POWER, CONFIG_RF_POWER) != SUCCESS) 
    {
      XCommandM$readings.xHeader.responseCode = XCMD_RES_FAIL;
      XCommandM$Config$get(CONFIG_RF_CHANNEL, & XCommandM$readings.xData.rfParams.rf_channel, sizeof(uint8_t ));
      XCommandM$Config$get(CONFIG_RF_POWER, & XCommandM$readings.xData.rfParams.rf_power, sizeof(uint8_t ));
      XCommandM$state = XCommandM$IDLE;
      XCommandM$nextPacketID = XCommandM$SETRFPOWER_PKT;
      TOS_post(XCommandM$send_msg);
    }
  return;
}

#line 283
static inline void XCommandM$Set_RFCHANNEL(uint8_t *ptrCH)
{
  XCommandM$state = XCommandM$SET_RFFREQ;
  XCommandM$Config$set(CONFIG_RF_CHANNEL, ptrCH, sizeof(uint8_t ));
  if (XCommandM$ConfigSave$save(CONFIG_RF_CHANNEL, CONFIG_RF_CHANNEL) != SUCCESS) 
    {
      XCommandM$readings.xHeader.responseCode = XCMD_RES_FAIL;
      XCommandM$Config$get(CONFIG_RF_CHANNEL, & XCommandM$readings.xData.rf_channel, sizeof(uint8_t ));
      XCommandM$state = XCommandM$IDLE;
      XCommandM$nextPacketID = XCommandM$SETFREQ_PKT;

      TOS_post(XCommandM$send_msg);
    }
  return;
}

#line 216
static inline void XCommandM$Uid_Config(void *ptrSerialid, uint16_t *ptrNodeid)
{

  XCommandM$state = XCommandM$CONFIG_UID;
  XCommandM$Config$get(CONFIG_MOTE_SERIAL, (uint8_t *)&XCommandM$readings.xData.uidData1.serialid[0], 8);

  memcmp(XCommandM$readings.xData.uidData1.serialid, ptrSerialid, 8);
  XCommandM$readings.xData.uidData1.oldNodeid = TOS_LOCAL_ADDRESS;
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 224
    XCommandM$Config$set(CONFIG_MOTE_ID, ptrNodeid, sizeof(uint16_t ));
#line 224
    __nesc_atomic_end(__nesc_atomic); }
  if (XCommandM$ConfigSave$save(CONFIG_MOTE_ID, CONFIG_MOTE_ID) != SUCCESS) 
    {
      XCommandM$readings.xHeader.responseCode = XCMD_RES_FAIL;
      XCommandM$readings.xData.uidData1.nodeid = TOS_LOCAL_ADDRESS;
      XCommandM$state = XCommandM$IDLE;
      XCommandM$nextPacketID = XCommandM$UID_PKT;
      TOS_post(XCommandM$send_msg);
    }

  return;
}

# 126 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\LedsC.nc"
static inline   result_t LedsC$Leds$yellowToggle(void)
#line 126
{
  result_t rval;

#line 128
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 128
    {
      if (LedsC$ledsOn & LedsC$YELLOW_BIT) {
        rval = LedsC$Leds$yellowOff();
        }
      else {
#line 132
        rval = LedsC$Leds$yellowOn();
        }
    }
#line 134
    __nesc_atomic_end(__nesc_atomic); }
#line 134
  return rval;
}

# 110 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
inline static   result_t XCommandM$Leds$yellowToggle(void){
#line 110
  unsigned char result;
#line 110

#line 110
  result = LedsC$Leds$yellowToggle();
#line 110

#line 110
  return result;
#line 110
}
#line 110
#line 93
inline static   result_t XCommandM$Leds$yellowOn(void){
#line 93
  unsigned char result;
#line 93

#line 93
  result = LedsC$Leds$yellowOn();
#line 93

#line 93
  return result;
#line 93
}
#line 93








inline static   result_t XCommandM$Leds$yellowOff(void){
#line 101
  unsigned char result;
#line 101

#line 101
  result = LedsC$Leds$yellowOff();
#line 101

#line 101
  return result;
#line 101
}
#line 101
# 68 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\LedsC.nc"
static inline   result_t LedsC$Leds$redToggle(void)
#line 68
{
  result_t rval;

#line 70
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 70
    {
      if (LedsC$ledsOn & LedsC$RED_BIT) {
        rval = LedsC$Leds$redOff();
        }
      else {
#line 74
        rval = LedsC$Leds$redOn();
        }
    }
#line 76
    __nesc_atomic_end(__nesc_atomic); }
#line 76
  return rval;
}

# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
inline static   result_t XCommandM$Leds$redToggle(void){
#line 60
  unsigned char result;
#line 60

#line 60
  result = LedsC$Leds$redToggle();
#line 60

#line 60
  return result;
#line 60
}
#line 60
#line 43
inline static   result_t XCommandM$Leds$redOn(void){
#line 43
  unsigned char result;
#line 43

#line 43
  result = LedsC$Leds$redOn();
#line 43

#line 43
  return result;
#line 43
}
#line 43








inline static   result_t XCommandM$Leds$redOff(void){
#line 51
  unsigned char result;
#line 51

#line 51
  result = LedsC$Leds$redOff();
#line 51

#line 51
  return result;
#line 51
}
#line 51
# 97 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\LedsC.nc"
static inline   result_t LedsC$Leds$greenToggle(void)
#line 97
{
  result_t rval;

#line 99
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 99
    {
      if (LedsC$ledsOn & LedsC$GREEN_BIT) {
        rval = LedsC$Leds$greenOff();
        }
      else {
#line 103
        rval = LedsC$Leds$greenOn();
        }
    }
#line 105
    __nesc_atomic_end(__nesc_atomic); }
#line 105
  return rval;
}

# 85 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
inline static   result_t XCommandM$Leds$greenToggle(void){
#line 85
  unsigned char result;
#line 85

#line 85
  result = LedsC$Leds$greenToggle();
#line 85

#line 85
  return result;
#line 85
}
#line 85
#line 68
inline static   result_t XCommandM$Leds$greenOn(void){
#line 68
  unsigned char result;
#line 68

#line 68
  result = LedsC$Leds$greenOn();
#line 68

#line 68
  return result;
#line 68
}
#line 68








inline static   result_t XCommandM$Leds$greenOff(void){
#line 76
  unsigned char result;
#line 76

#line 76
  result = LedsC$Leds$greenOff();
#line 76

#line 76
  return result;
#line 76
}
#line 76
# 117 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline void TOSH_CLR_RED_LED_PIN(void)
#line 117
{
#line 117
  * (volatile uint8_t *)(0x1B + 0x20) &= ~(1 << 2);
}

#line 119
static __inline void TOSH_CLR_YELLOW_LED_PIN(void)
#line 119
{
#line 119
  * (volatile uint8_t *)(0x1B + 0x20) &= ~(1 << 0);
}

#line 118
static __inline void TOSH_CLR_GREEN_LED_PIN(void)
#line 118
{
#line 118
  * (volatile uint8_t *)(0x1B + 0x20) &= ~(1 << 1);
}

# 145 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\LedsC.nc"
static inline   result_t LedsC$Leds$set(uint8_t ledsNum)
#line 145
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 146
    {
      LedsC$ledsOn = ledsNum & 0x7;
      if (LedsC$ledsOn & LedsC$GREEN_BIT) {
        TOSH_CLR_GREEN_LED_PIN();
        }
      else {
#line 151
        TOSH_SET_GREEN_LED_PIN();
        }
#line 152
      if (LedsC$ledsOn & LedsC$YELLOW_BIT) {
        TOSH_CLR_YELLOW_LED_PIN();
        }
      else {
#line 155
        TOSH_SET_YELLOW_LED_PIN();
        }
#line 156
      if (LedsC$ledsOn & LedsC$RED_BIT) {
        TOSH_CLR_RED_LED_PIN();
        }
      else {
#line 159
        TOSH_SET_RED_LED_PIN();
        }
    }
#line 161
    __nesc_atomic_end(__nesc_atomic); }
#line 161
  return SUCCESS;
}

# 128 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
inline static   result_t XCommandM$Leds$set(uint8_t arg_0x1a5b5a40){
#line 128
  unsigned char result;
#line 128

#line 128
  result = LedsC$Leds$set(arg_0x1a5b5a40);
#line 128

#line 128
  return result;
#line 128
}
#line 128
# 110 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XCommandM.nc"
inline static void XCommandM$XCommandAcctuate(uint16_t device, uint16_t cmd_state)
#line 110
{
  switch (device) {

      case XCMD_DEVICE_LEDS: 
        XCommandM$Leds$set(cmd_state);
      break;

      case XCMD_DEVICE_LED_GREEN: 
        switch (cmd_state) {
            case 0: XCommandM$Leds$greenOff();
#line 119
            break;
            case 1: XCommandM$Leds$greenOn();
#line 120
            break;
            case 2: XCommandM$Leds$greenToggle();
#line 121
            break;
          }
      break;

      case XCMD_DEVICE_LED_RED: 
        switch (cmd_state) {
            case 0: XCommandM$Leds$redOff();
#line 127
            break;
            case 1: XCommandM$Leds$redOn();
#line 128
            break;
            case 2: XCommandM$Leds$redToggle();
#line 129
            break;
          }
      break;

      case XCMD_DEVICE_LED_YELLOW: 
        switch (cmd_state) {
            case 0: XCommandM$Leds$yellowOff();
#line 135
            break;
            case 1: XCommandM$Leds$yellowOn();
#line 136
            break;
            case 2: XCommandM$Leds$yellowToggle();
#line 137
            break;
          }
      break;

      default: break;
    }
}

# 391 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420ControlM.nc"
static inline   result_t CC2420ControlM$HPLChipcon$FIFOPIntr(void)
#line 391
{
  return SUCCESS;
}

# 271 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static inline  TOS_MsgPtr AMPromiscuous$RadioReceive$receive(TOS_MsgPtr packet)
#line 271
{
  return prom_received(packet);
}

# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
inline static  TOS_MsgPtr CC2420RadioM$Receive$receive(TOS_MsgPtr arg_0x1a581c80){
#line 53
  struct TOS_Msg *result;
#line 53

#line 53
  result = AMPromiscuous$RadioReceive$receive(arg_0x1a581c80);
#line 53

#line 53
  return result;
#line 53
}
#line 53
# 1298 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static inline    TOS_MsgPtr CC2420RadioM$default$asyncReceive(TOS_MsgPtr pBuf)
#line 1298
{
  return pBuf;
}

#line 73
inline static   TOS_MsgPtr CC2420RadioM$asyncReceive(TOS_MsgPtr arg_0x1a6d69c8){
#line 73
  struct TOS_Msg *result;
#line 73

#line 73
  result = CC2420RadioM$default$asyncReceive(arg_0x1a6d69c8);
#line 73

#line 73
  return result;
#line 73
}
#line 73
#line 502
static __inline void CC2420RadioM$immedPacketRcvd(void)
#line 502
{
  TOS_MsgPtr pBuf;


  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 506
    {
      CC2420RadioM$rxbufptr->time = 0;
      pBuf = CC2420RadioM$rxbufptr;
    }
#line 509
    __nesc_atomic_end(__nesc_atomic); }









  if (CC2420RadioM$gImmedSendDone) {
      pBuf = CC2420RadioM$asyncReceive((TOS_MsgPtr )pBuf);
    }
  else 
#line 521
    {
      pBuf = CC2420RadioM$Receive$receive((TOS_MsgPtr )pBuf);
    }

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 525
    {



      if (pBuf) {
#line 529
        CC2420RadioM$rxbufptr = pBuf;
        }
#line 530
      CC2420RadioM$rxbufptr->length = 0;
      CC2420RadioM$bRxBufLocked = FALSE;
    }
#line 532
    __nesc_atomic_end(__nesc_atomic); }






  CC2420RadioM$HPLChipcon$enableFIFOP();

  ;
}



static inline  void CC2420RadioM$PacketRcvd(void)
#line 546
{
  CC2420RadioM$immedPacketRcvd();
}

# 149 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline int TOSH_READ_CC_SFD_PIN(void)
#line 149
{
#line 149
  return (* (volatile uint8_t *)(0x10 + 0x20) & (1 << 4)) != 0;
}

# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\byteorder.h"
static __inline uint16_t fromLSB16(uint16_t a)
{
  return is_host_lsb() ? a : (a << 8) | (a >> 8);
}

# 162 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLTimer2.nc"
static inline   void HPLTimer2$Timer2$intDisable(void)
#line 162
{
  * (volatile uint8_t *)(0x37 + 0x20) &= ~(1 << 7);
}

# 147 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Clock.nc"
inline static   void TimerJiffyAsyncM$Timer$intDisable(void){
#line 147
  HPLTimer2$Timer2$intDisable();
#line 147
}
#line 147
# 115 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\TimerJiffyAsyncM.nc"
static inline   result_t TimerJiffyAsyncM$TimerJiffyAsync$stop(void)
{
  /* atomic removed: atomic calls only */
#line 117
  {
    TimerJiffyAsyncM$bSet = FALSE;
    TimerJiffyAsyncM$Timer$intDisable();
  }
  return SUCCESS;
}

# 36 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\TimerJiffyAsync.nc"
inline static   result_t CC2420RadioM$BackoffTimerJiffy$stop(void){
#line 36
  unsigned char result;
#line 36

#line 36
  result = TimerJiffyAsyncM$TimerJiffyAsync$stop();
#line 36

#line 36
  return result;
#line 36
}
#line 36
# 228 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static inline  result_t AMPromiscuous$RadioSend$sendDone(TOS_MsgPtr msg, result_t success)
#line 228
{
  return AMPromiscuous$reportSendDone(msg, success);
}

# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BareSendMsg.nc"
inline static  result_t CC2420RadioM$Send$sendDone(TOS_MsgPtr arg_0x1a5a1360, result_t arg_0x1a5a14f0){
#line 45
  unsigned char result;
#line 45

#line 45
  result = AMPromiscuous$RadioSend$sendDone(arg_0x1a5a1360, arg_0x1a5a14f0);
#line 45

#line 45
  return result;
#line 45
}
#line 45
# 458 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static __inline void CC2420RadioM$immedPacketSent(void)
#line 458
{

  TOS_MsgPtr pBuf;
  uint8_t currentstate;

#line 462
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 462
    currentstate = CC2420RadioM$RadioState;
#line 462
    __nesc_atomic_end(__nesc_atomic); }

  if (currentstate == CC2420RadioM$POST_TX_STATE) {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 465
        {
          CC2420RadioM$RadioState = CC2420RadioM$IDLE_STATE;
          CC2420RadioM$txbufptr->time = 0;
          pBuf = CC2420RadioM$txbufptr;

          pBuf->length = pBuf->length - MSG_HEADER_SIZE - MSG_FOOTER_SIZE;
        }
#line 471
        __nesc_atomic_end(__nesc_atomic); }





      while (TOSH_READ_CC_SFD_PIN()) {
        }
#line 477
      ;

      ;

      CC2420RadioM$Send$sendDone(pBuf, SUCCESS);
    }






  return;
}

#line 551
static inline  void CC2420RadioM$PacketSent(void)
#line 551
{
  CC2420RadioM$immedPacketSent();
}

#line 1305
static inline    void CC2420RadioM$default$shortReceived(void)
#line 1305
{
  return;
}

#line 74
inline static   void CC2420RadioM$shortReceived(void){
#line 74
  CC2420RadioM$default$shortReceived();
#line 74
}
#line 74
# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420FIFO.nc"
inline static   result_t CC2420RadioM$HPLChipconFIFO$readRXFIFO(uint8_t arg_0x1a6c3518, uint8_t *arg_0x1a6c36c0){
#line 46
  unsigned char result;
#line 46

#line 46
  result = HPLCC2420FIFOM$HPLCC2420FIFO$readRXFIFO(arg_0x1a6c3518, arg_0x1a6c36c0);
#line 46

#line 46
  return result;
#line 46
}
#line 46
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420.nc"
inline static   uint16_t CC2420RadioM$HPLChipcon$read(uint8_t arg_0x1a6c6500){
#line 65
  unsigned short result;
#line 65

#line 65
  result = HPLCC2420M$HPLCC2420$read(arg_0x1a6c6500);
#line 65

#line 65
  return result;
#line 65
}
#line 65
# 151 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\hardware.h"
static __inline int TOSH_READ_CC_FIFO_PIN(void)
#line 151
{
#line 151
  return (* (volatile uint8_t *)(0x16 + 0x20) & (1 << 7)) != 0;
}

# 110 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\TimerJiffyAsyncM.nc"
static inline   bool TimerJiffyAsyncM$TimerJiffyAsync$isSet(void)
{
  return TimerJiffyAsyncM$bSet;
}

# 38 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\TimerJiffyAsync.nc"
inline static   bool CC2420RadioM$BackoffTimerJiffy$isSet(void){
#line 38
  unsigned char result;
#line 38

#line 38
  result = TimerJiffyAsyncM$TimerJiffyAsync$isSet();
#line 38

#line 38
  return result;
#line 38
}
#line 38
# 906 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static inline   result_t CC2420RadioM$HPLChipcon$FIFOPIntr(void)
#line 906
{


  uint8_t *pData;
  uint8_t length = MSG_DATA_SIZE;
  uint8_t currentstate;
  int16_t backoffValue;

  /* atomic removed: atomic calls only */
#line 914
  currentstate = CC2420RadioM$RadioState;

  ;






  if (CC2420RadioM$bAckEnable && currentstate == CC2420RadioM$PRE_TX_STATE) {
      if (CC2420RadioM$BackoffTimerJiffy$isSet()) {
          CC2420RadioM$BackoffTimerJiffy$stop();
          backoffValue = CC2420RadioM$MacBackoff$congestionBackoff(CC2420RadioM$txbufptr)
           * 10 + 20;
          CC2420RadioM$BackoffTimerJiffy$setOneShot(backoffValue);
        }
    }


  if (!TOSH_READ_CC_FIFO_PIN() || CC2420RadioM$bRxBufLocked) {
      CC2420RadioM$HPLChipcon$read(0x3F);
      CC2420RadioM$HPLChipcon$cmd(0x08);
      CC2420RadioM$HPLChipcon$cmd(0x08);
      return FAIL;
    }


  pData = (uint8_t *)CC2420RadioM$rxbufptr;
  length = CC2420RadioM$HPLChipconFIFO$readRXFIFO(1, pData);


  CC2420RadioM$rxbufptr->length &= 0x7f;


  length = CC2420RadioM$rxbufptr->length;


  if (length > MSG_DATA_SIZE - 1) {
      CC2420RadioM$HPLChipcon$read(0x3F);
      CC2420RadioM$HPLChipcon$cmd(0x08);
      CC2420RadioM$HPLChipcon$cmd(0x08);
      /* atomic removed: atomic calls only */
#line 955
      CC2420RadioM$bRxBufLocked = FALSE;
      return FAIL;
    }


  pData = (uint8_t *)CC2420RadioM$rxbufptr + 1;
  length = CC2420RadioM$HPLChipconFIFO$readRXFIFO(length, pData);






  if (!(pData[length - 1] & 0x80)) {
      /* atomic removed: atomic calls only */
#line 969
      CC2420RadioM$bRxBufLocked = FALSE;
      return SUCCESS;
    }


  if (CC2420RadioM$rxbufptr->length < 5) {
      /* atomic removed: atomic calls only */
#line 975
      CC2420RadioM$bRxBufLocked = FALSE;
      CC2420RadioM$shortReceived();
      return SUCCESS;
    }




  if ((
#line 981
  CC2420RadioM$rxbufptr->fcfhi & 0x03) == 0x02 && 
  CC2420RadioM$rxbufptr->dsn == CC2420RadioM$currentDSN && (
  CC2420RadioM$bAckEnable || CC2420RadioM$bAckManual) && 
  currentstate == CC2420RadioM$POST_TX_STATE) {

      CC2420RadioM$txbufptr->ack = 1;

      {
#line 988
        ;
#line 988
        TOSH_uwait(50);
#line 988
        ;
      }
#line 988
      ;



      if (TOS_post(CC2420RadioM$PacketSent)) {
#line 992
        CC2420RadioM$BackoffTimerJiffy$stop();
        }
      ;

      return SUCCESS;
    }



  if ((CC2420RadioM$rxbufptr->fcfhi & 0x03) != 0x01) {
      /* atomic removed: atomic calls only */
#line 1002
      CC2420RadioM$bRxBufLocked = FALSE;
      return SUCCESS;
    }
  /* atomic removed: atomic calls only */
  CC2420RadioM$bRxBufLocked = TRUE;

  CC2420RadioM$rxbufptr->length = CC2420RadioM$rxbufptr->length - MSG_HEADER_SIZE - MSG_FOOTER_SIZE;


  CC2420RadioM$rxbufptr->addr = fromLSB16(CC2420RadioM$rxbufptr->addr);


  CC2420RadioM$rxbufptr->crc = pData[length - 1] >> 7;


  CC2420RadioM$rxbufptr->strength = pData[length - 2];
  CC2420RadioM$rxbufptr->ack = FALSE;



  if (CC2420RadioM$bAckManual) {
      if (CC2420RadioM$rxbufptr->addr == TOS_LOCAL_ADDRESS && 
      CC2420RadioM$rxbufptr->group == TOS_AM_GROUP) {

          CC2420RadioM$HPLChipcon$cmd(0x0A);
          while (!TOSH_READ_CC_SFD_PIN()) {
            }
#line 1027
          ;

          {
#line 1029
            ;
#line 1029
            TOSH_uwait(50);
#line 1029
            ;
          }
#line 1029
          ;
        }
    }









  while (TOSH_READ_CC_SFD_PIN()) {
    }
#line 1041
  ;



  if (CC2420RadioM$gImmedSendDone) {
      CC2420RadioM$immedPacketRcvd();
    }
  else {
#line 1048
    if (!TOS_post(CC2420RadioM$PacketRcvd)) {
      /* atomic removed: atomic calls only */
#line 1049
      CC2420RadioM$bRxBufLocked = FALSE;
      }
    }
#line 1051
  return SUCCESS;
}

# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\HPLCC2420.nc"
inline static   result_t HPLCC2420M$HPLCC2420$FIFOPIntr(void){
#line 44
  unsigned char result;
#line 44

#line 44
  result = CC2420RadioM$HPLChipcon$FIFOPIntr();
#line 44
  result = rcombine(result, CC2420ControlM$HPLChipcon$FIFOPIntr());
#line 44

#line 44
  return result;
#line 44
}
#line 44
# 76 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\HPLClock.nc"
static inline   uint8_t HPLClock$Clock$getInterval(void)
#line 76
{
  return * (volatile uint8_t *)(0x31 + 0x20);
}

# 100 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Clock.nc"
inline static   uint8_t TimerM$Clock$getInterval(void){
#line 100
  unsigned char result;
#line 100

#line 100
  result = HPLClock$Clock$getInterval();
#line 100

#line 100
  return result;
#line 100
}
#line 100
# 19 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\PowerManagement.nc"
inline static   uint8_t TimerM$PowerManagement$adjustPower(void){
#line 19
  unsigned char result;
#line 19

#line 19
  result = HPLPowerManagementM$PowerManagement$adjustPower();
#line 19

#line 19
  return result;
#line 19
}
#line 19
# 66 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\HPLClock.nc"
static inline   void HPLClock$Clock$setInterval(uint8_t value)
#line 66
{
  * (volatile uint8_t *)(0x31 + 0x20) = value;
}

# 84 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Clock.nc"
inline static   void TimerM$Clock$setInterval(uint8_t arg_0x1a8d22d0){
#line 84
  HPLClock$Clock$setInterval(arg_0x1a8d22d0);
#line 84
}
#line 84
# 113 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\HPLClock.nc"
static inline   uint8_t HPLClock$Clock$readCounter(void)
#line 113
{
  return * (volatile uint8_t *)(0x32 + 0x20);
}

# 132 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Clock.nc"
inline static   uint8_t TimerM$Clock$readCounter(void){
#line 132
  unsigned char result;
#line 132

#line 132
  result = HPLClock$Clock$readCounter();
#line 132

#line 132
  return result;
#line 132
}
#line 132
# 106 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\TimerM.nc"
inline static void TimerM$adjustInterval(void)
#line 106
{
  uint8_t i;
#line 107
  uint8_t val = TimerM$maxTimerInterval;

#line 108
  if (TimerM$mState) {
      for (i = 0; i < NUM_TIMERS; i++) {
          if (TimerM$mState & (0x1L << i) && TimerM$mTimerList[i].ticksLeft < val) {
              val = TimerM$mTimerList[i].ticksLeft;
            }
        }
#line 125
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 125
        {
          i = TimerM$Clock$readCounter() + 3;
          if (val < i) {
              val = i;
            }
          TimerM$mInterval = val;
          TimerM$Clock$setInterval(TimerM$mInterval);
          TimerM$setIntervalFlag = 0;
        }
#line 133
        __nesc_atomic_end(__nesc_atomic); }
    }
  else {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 136
        {
          TimerM$mInterval = TimerM$maxTimerInterval;
          TimerM$Clock$setInterval(TimerM$mInterval);
          TimerM$setIntervalFlag = 0;
        }
#line 140
        __nesc_atomic_end(__nesc_atomic); }
    }
  TimerM$PowerManagement$adjustPower();
}

#line 163
static inline void TimerM$enqueue(uint8_t value)
#line 163
{
  if (TimerM$queue_tail == NUM_TIMERS - 1) {
    TimerM$queue_tail = -1;
    }
#line 166
  TimerM$queue_tail++;
  TimerM$queue_size++;
  TimerM$queue[(uint8_t )TimerM$queue_tail] = value;
}

# 393 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static inline  result_t SamplerM$Sample$sampleNow(void)
{
  SamplerM$next_schedule();
  return SUCCESS;
}

# 24 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Sample.nc"
inline static  result_t XMDA300M$Sample$sampleNow(void){
#line 24
  unsigned char result;
#line 24

#line 24
  result = SamplerM$Sample$sampleNow();
#line 24

#line 24
  return result;
#line 24
}
#line 24
#line 19
inline static  int8_t XMDA300M$Sample$getSample(uint8_t arg_0x1ad07e70, uint8_t arg_0x1ad03030, uint16_t arg_0x1ad031c8, uint8_t arg_0x1ad03350){
#line 19
  signed char result;
#line 19

#line 19
  result = SamplerM$Sample$getSample(arg_0x1ad07e70, arg_0x1ad03030, arg_0x1ad031c8, arg_0x1ad03350);
#line 19

#line 19
  return result;
#line 19
}
#line 19
# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\NoLeds.nc"
static inline   result_t NoLeds$Leds$greenOn(void)
#line 46
{
  return SUCCESS;
}

# 68 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
inline static   result_t XMDA300M$Leds$greenOn(void){
#line 68
  unsigned char result;
#line 68

#line 68
  result = NoLeds$Leds$greenOn();
#line 68

#line 68
  return result;
#line 68
}
#line 68
# 90 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\CounterM.nc"
static inline  result_t CounterM$Plugged(void)
#line 90
{
  char c;

#line 92
  * (volatile uint8_t *)(0x39 + 0x20) &= ~(1 << 5);
  TOSH_MAKE_PW4_OUTPUT();
  TOSH_CLR_PW4_PIN();
  TOSH_uwait(1);
  c = (* (volatile uint8_t *)(0x01 + 0x20) >> 5) & 0x1;
  TOSH_SET_PW4_PIN();
  TOSH_uwait(1);
  if (c == ((* (volatile uint8_t *)(0x01 + 0x20) >> 5) & 0x1)) {
#line 99
    CounterM$boardConnected = FALSE;
    }
  else {
#line 100
    CounterM$boardConnected = TRUE;
    }
#line 101
  TOSH_CLR_PW4_PIN();
  * (volatile uint8_t *)(0x39 + 0x20) |= 1 << 5;
  return CounterM$boardConnected;
}

# 84 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
inline static  result_t SamplerM$Plugged(void){
#line 84
  unsigned char result;
#line 84

#line 84
  result = CounterM$Plugged();
#line 84

#line 84
  return result;
#line 84
}
#line 84
#line 361
static inline  result_t SamplerM$PlugPlay(void)
{
  return SamplerM$Plugged();
}

# 133 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\apps\\xmesh\\XMDA300\\XMDA300M.nc"
inline static  result_t XMDA300M$PlugPlay(void){
#line 133
  unsigned char result;
#line 133

#line 133
  result = SamplerM$PlugPlay();
#line 133

#line 133
  return result;
#line 133
}
#line 133
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t SamplerM$CounterControl$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = CounterM$CounterControl$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 187 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\TempHumM.nc"
static inline  result_t TempHumM$StdControl$start(void)
#line 187
{
  return SUCCESS;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t SamplerM$TempHumControl$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = TempHumM$StdControl$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 34 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\VoltageM.nc"
static inline  result_t VoltageM$StdControl$start(void)
#line 34
{




  return SUCCESS;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t SamplerM$BatteryControl$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = VoltageM$StdControl$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SwitchM.nc"
static inline  result_t SwitchM$SwitchControl$start(void)
#line 48
{
  return SUCCESS;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t IBADCM$SwitchControl$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = SwitchM$SwitchControl$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 332 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
static inline  result_t IBADCM$StdControl$start(void)
#line 332
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 333
    {
      IBADCM$adc_stopbitmap = 0;
      IBADCM$samplecount = 0;
      IBADCM$chan = 13 + 1;
    }
#line 337
    __nesc_atomic_end(__nesc_atomic); }
  TOS_post(IBADCM$output_ref);
  IBADCM$SwitchControl$start();
  return SUCCESS;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t SamplerM$IBADCcontrol$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = IBADCM$StdControl$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 89 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
static inline  result_t DioM$StdControl$start(void)
#line 89
{
  * (volatile uint8_t *)(0x02 + 0x20) &= ~(1 << 4);



  TOS_post(DioM$init_io);
  return SUCCESS;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t SamplerM$DioControl$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = DioM$StdControl$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 340 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static inline  result_t SamplerM$SamplerControl$start(void)
#line 340
{
  SamplerM$CounterControl$start();
  SamplerM$DioControl$start();
  SamplerM$IBADCcontrol$start();
  SamplerM$BatteryControl$start();
  SamplerM$TempHumControl$start();
  SamplerM$CounterControl$start();

  return SUCCESS;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t XMDA300M$SamplerControl$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = SamplerM$SamplerControl$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 221 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\apps\\xmesh\\XMDA300\\XMDA300M.nc"
inline static void XMDA300M$start(void)
{
  XMDA300M$bBoardOn = TRUE;
  XMDA300M$SamplerControl$start();
  if (XMDA300M$PlugPlay()) 
    {

      XMDA300M$bBoardOn = TRUE;



      XMDA300M$record[14] = XMDA300M$Sample$getSample(0, TEMPERATURE, 110, SAMPLER_DEFAULT);

      XMDA300M$record[15] = XMDA300M$Sample$getSample(0, HUMIDITY, 110, SAMPLER_DEFAULT);

      XMDA300M$record[16] = XMDA300M$Sample$getSample(0, BATTERY, 110, SAMPLER_DEFAULT);



      XMDA300M$record[0] = XMDA300M$Sample$getSample(0, ANALOG, 90, (SAMPLER_DEFAULT | EXCITATION_33) | DELAY_BEFORE_MEASUREMENT);

      XMDA300M$record[1] = XMDA300M$Sample$getSample(1, ANALOG, 90, (SAMPLER_DEFAULT | EXCITATION_25) | DELAY_BEFORE_MEASUREMENT);

      XMDA300M$record[2] = XMDA300M$Sample$getSample(2, ANALOG, 90, (SAMPLER_DEFAULT | EXCITATION_50) | DELAY_BEFORE_MEASUREMENT);
#line 271
      XMDA300M$record[17] = XMDA300M$Sample$getSample(0, DIGITAL, 100, DIG_LOGIC | EVENT);

      XMDA300M$record[18] = XMDA300M$Sample$getSample(1, DIGITAL, 100, DIG_LOGIC | EVENT);

      XMDA300M$record[19] = XMDA300M$Sample$getSample(2, DIGITAL, 100, DIG_LOGIC | EVENT);










      XMDA300M$Leds$greenOn();
    }
  else 
    {
      XMDA300M$bBoardOn = FALSE;
      XMDA300M$record[16] = XMDA300M$Sample$getSample(0, BATTERY, 110, SAMPLER_DEFAULT);
    }
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 293
    XMDA300M$samplebatt = 1;
#line 293
    __nesc_atomic_end(__nesc_atomic); }
  XMDA300M$Sample$sampleNow();
  return;
}

#line 595
static inline  result_t XMDA300M$Timer$fired(void)
#line 595
{
  if (XMDA300M$sending_packet && XMDA300M$msg_status != 0) {
    return SUCCESS;
    }
#line 598
  XMDA300M$start();
#line 610
  return SUCCESS;
}

# 159 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static inline  result_t AMPromiscuous$ActivityTimer$fired(void)
#line 159
{
  AMPromiscuous$lastCount = AMPromiscuous$counter;
  AMPromiscuous$counter = 0;
  return SUCCESS;
}

# 263 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCREFM.nc"
static inline   result_t ADCREFM$ADCControl$manualCalibrate(void)
#line 263
{
  result_t Result;

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 266
    {
      Result = ADCREFM$startGet(TOS_ADC_BANDGAP_PORT);
    }
#line 268
    __nesc_atomic_end(__nesc_atomic); }

  return Result;
}

#line 71
static inline  void ADCREFM$CalTask(void)
#line 71
{

  ADCREFM$ADCControl$manualCalibrate();

  return;
}

#line 105
static inline  result_t ADCREFM$Timer$fired(void)
#line 105
{

  TOS_post(ADCREFM$CalTask);

  return SUCCESS;
}

# 576 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static inline  result_t SamplerM$Counter$dataReady(uint16_t data)
#line 576
{
  SamplerM$Sample$dataReady(0, COUNTER, data);
  return SUCCESS;
}

# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
inline static  result_t CounterM$Counter$dataReady(uint16_t arg_0x1afee368){
#line 28
  unsigned char result;
#line 28

#line 28
  result = SamplerM$Counter$dataReady(arg_0x1afee368);
#line 28

#line 28
  return result;
#line 28
}
#line 28
# 121 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\CounterM.nc"
static inline  result_t CounterM$Counter$getData(void)
{
  uint16_t counter;

#line 124
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 124
    {
      counter = CounterM$count;
      if (RESET_ZERO_AFTER_READ & CounterM$mode) {
#line 126
        CounterM$count = 0;
        }
    }
#line 128
    __nesc_atomic_end(__nesc_atomic); }
#line 128
  CounterM$Counter$dataReady(counter);
  return SUCCESS;
}

# 20 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
inline static  result_t SamplerM$Counter$getData(void){
#line 20
  unsigned char result;
#line 20

#line 20
  result = CounterM$Counter$getData();
#line 20

#line 20
  return result;
#line 20
}
#line 20
inline static  result_t SamplerM$Dio5$getData(void){
#line 20
  unsigned char result;
#line 20

#line 20
  result = DioM$Dio$getData(5);
#line 20

#line 20
  return result;
#line 20
}
#line 20
inline static  result_t SamplerM$Dio4$getData(void){
#line 20
  unsigned char result;
#line 20

#line 20
  result = DioM$Dio$getData(4);
#line 20

#line 20
  return result;
#line 20
}
#line 20
inline static  result_t SamplerM$Dio3$getData(void){
#line 20
  unsigned char result;
#line 20

#line 20
  result = DioM$Dio$getData(3);
#line 20

#line 20
  return result;
#line 20
}
#line 20
inline static  result_t SamplerM$Dio2$getData(void){
#line 20
  unsigned char result;
#line 20

#line 20
  result = DioM$Dio$getData(2);
#line 20

#line 20
  return result;
#line 20
}
#line 20
inline static  result_t SamplerM$Dio1$getData(void){
#line 20
  unsigned char result;
#line 20

#line 20
  result = DioM$Dio$getData(1);
#line 20

#line 20
  return result;
#line 20
}
#line 20
inline static  result_t SamplerM$Dio0$getData(void){
#line 20
  unsigned char result;
#line 20

#line 20
  result = DioM$Dio$getData(0);
#line 20

#line 20
  return result;
#line 20
}
#line 20
# 322 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\TempHumM.nc"
static inline  result_t TempHumM$HumSensor$getData(void)
{
  if (!TOS_post(TempHumM$initiateHumidity)) {
#line 324
    return FAIL;
    }
#line 325
  return SUCCESS;
}

# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
inline static  result_t SamplerM$Hum$getData(void){
#line 26
  unsigned char result;
#line 26

#line 26
  result = TempHumM$HumSensor$getData();
#line 26

#line 26
  return result;
#line 26
}
#line 26
# 316 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\TempHumM.nc"
static inline  result_t TempHumM$TempSensor$getData(void)
{
  if (!TOS_post(TempHumM$initiateTemperature)) {
#line 318
    return FAIL;
    }
#line 319
  return SUCCESS;
}

# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
inline static  result_t SamplerM$Temp$getData(void){
#line 26
  unsigned char result;
#line 26

#line 26
  result = TempHumM$TempSensor$getData();
#line 26

#line 26
  return result;
#line 26
}
#line 26
# 30 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
inline static   result_t SamplerM$Battery$getData(void){
#line 30
  unsigned char result;
#line 30

#line 30
  result = ADCREFM$ADC$getData(TOS_ADC_VOLTAGE_PORT);
#line 30

#line 30
  return result;
#line 30
}
#line 30
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
inline static  result_t SamplerM$ADC13$getData(void){
#line 26
  unsigned char result;
#line 26

#line 26
  result = IBADCM$ADConvert$getData(13);
#line 26

#line 26
  return result;
#line 26
}
#line 26
inline static  result_t SamplerM$ADC12$getData(void){
#line 26
  unsigned char result;
#line 26

#line 26
  result = IBADCM$ADConvert$getData(12);
#line 26

#line 26
  return result;
#line 26
}
#line 26
inline static  result_t SamplerM$ADC11$getData(void){
#line 26
  unsigned char result;
#line 26

#line 26
  result = IBADCM$ADConvert$getData(11);
#line 26

#line 26
  return result;
#line 26
}
#line 26
inline static  result_t SamplerM$ADC10$getData(void){
#line 26
  unsigned char result;
#line 26

#line 26
  result = IBADCM$ADConvert$getData(10);
#line 26

#line 26
  return result;
#line 26
}
#line 26
inline static  result_t SamplerM$ADC9$getData(void){
#line 26
  unsigned char result;
#line 26

#line 26
  result = IBADCM$ADConvert$getData(9);
#line 26

#line 26
  return result;
#line 26
}
#line 26
inline static  result_t SamplerM$ADC8$getData(void){
#line 26
  unsigned char result;
#line 26

#line 26
  result = IBADCM$ADConvert$getData(8);
#line 26

#line 26
  return result;
#line 26
}
#line 26
inline static  result_t SamplerM$ADC7$getData(void){
#line 26
  unsigned char result;
#line 26

#line 26
  result = IBADCM$ADConvert$getData(7);
#line 26

#line 26
  return result;
#line 26
}
#line 26
inline static  result_t SamplerM$ADC6$getData(void){
#line 26
  unsigned char result;
#line 26

#line 26
  result = IBADCM$ADConvert$getData(6);
#line 26

#line 26
  return result;
#line 26
}
#line 26
inline static  result_t SamplerM$ADC5$getData(void){
#line 26
  unsigned char result;
#line 26

#line 26
  result = IBADCM$ADConvert$getData(5);
#line 26

#line 26
  return result;
#line 26
}
#line 26
inline static  result_t SamplerM$ADC4$getData(void){
#line 26
  unsigned char result;
#line 26

#line 26
  result = IBADCM$ADConvert$getData(4);
#line 26

#line 26
  return result;
#line 26
}
#line 26
inline static  result_t SamplerM$ADC3$getData(void){
#line 26
  unsigned char result;
#line 26

#line 26
  result = IBADCM$ADConvert$getData(3);
#line 26

#line 26
  return result;
#line 26
}
#line 26
inline static  result_t SamplerM$ADC2$getData(void){
#line 26
  unsigned char result;
#line 26

#line 26
  result = IBADCM$ADConvert$getData(2);
#line 26

#line 26
  return result;
#line 26
}
#line 26
inline static  result_t SamplerM$ADC1$getData(void){
#line 26
  unsigned char result;
#line 26

#line 26
  result = IBADCM$ADConvert$getData(1);
#line 26

#line 26
  return result;
#line 26
}
#line 26
inline static  result_t SamplerM$ADC0$getData(void){
#line 26
  unsigned char result;
#line 26

#line 26
  result = IBADCM$ADConvert$getData(0);
#line 26

#line 26
  return result;
#line 26
}
#line 26
# 228 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static inline void SamplerM$sampleRecord(uint8_t i)
{
  if (SamplerM$SampleRecord[i].channelType == ANALOG) {
      switch (SamplerM$SampleRecord[i].channel) {
          case 0: 
            SamplerM$ADC0$getData();
          break;
          case 1: 
            SamplerM$ADC1$getData();
          break;
          case 2: 
            SamplerM$ADC2$getData();
          break;
          case 3: 
            SamplerM$ADC3$getData();
          break;
          case 4: 
            SamplerM$ADC4$getData();
          break;
          case 5: 
            SamplerM$ADC5$getData();
          break;
          case 6: 
            SamplerM$ADC6$getData();
          break;
          case 7: 
            SamplerM$ADC7$getData();
          break;
          case 8: 
            SamplerM$ADC8$getData();
          break;
          case 9: 
            SamplerM$ADC9$getData();
          break;
          case 10: 
            SamplerM$ADC10$getData();
          break;
          case 11: 
            SamplerM$ADC11$getData();
          break;
          case 12: 
            SamplerM$ADC12$getData();
          break;
          case 13: 
            SamplerM$ADC13$getData();
          break;
          default: ;
        }
      return;
    }
  if (SamplerM$SampleRecord[i].channelType == BATTERY) {
      SamplerM$Battery$getData();
      return;
    }


  if (SamplerM$SampleRecord[i].channelType == TEMPERATURE || SamplerM$SampleRecord[i].channelType == HUMIDITY) {
      if (SamplerM$SampleRecord[i].channelType == TEMPERATURE) {
#line 285
        SamplerM$Temp$getData();
        }
#line 286
      if (SamplerM$SampleRecord[i].channelType == HUMIDITY) {
#line 286
        SamplerM$Hum$getData();
        }
#line 287
      return;
    }

  if (SamplerM$SampleRecord[i].channelType == DIGITAL) {
      switch (SamplerM$SampleRecord[i].channel) {
          case 0: 
            SamplerM$Dio0$getData();
          break;
          case 1: 
            SamplerM$Dio1$getData();
          break;
          case 2: 
            SamplerM$Dio2$getData();
          break;
          case 3: 
            SamplerM$Dio3$getData();
          break;
          case 4: 
            SamplerM$Dio4$getData();
          break;
          case 5: 
            SamplerM$Dio5$getData();
          break;
          default: ;
        }
      return;
    }
  if (SamplerM$SampleRecord[i].channelType == COUNTER) {
      SamplerM$Counter$getData();
      return;
    }
  return;
}

#line 367
static inline  result_t SamplerM$SamplerTimer$fired(void)
#line 367
{
  uint8_t i;

  for (i = 0; i < 25; i++) 
    {
      if (SamplerM$SampleRecord[i].sampling_interval != SAMPLE_RECORD_FREE) 
        {
          if (SamplerM$SampleRecord[i].ticks_left == 0) 
            {
              SamplerM$SampleRecord[i].ticks_left = SamplerM$SampleRecord[i].sampling_interval;
              SamplerM$sampleRecord(i);
            }
        }
    }


  SamplerM$next_schedule();
  return SUCCESS;
}

# 563 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
static inline  result_t IBADCM$PowerStabalizingTimer$fired(void)
#line 563
{
  return IBADCM$convert();
}

# 159 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\TimerM.nc"
static inline   result_t TimerM$Timer$default$fired(uint8_t id)
#line 159
{
  return SUCCESS;
}

# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
inline static  result_t TimerM$Timer$fired(uint8_t arg_0x1a8b62b0){
#line 51
  unsigned char result;
#line 51

#line 51
  switch (arg_0x1a8b62b0) {
#line 51
    case 0U:
#line 51
      result = XMDA300M$Timer$fired();
#line 51
      break;
#line 51
    case 1U:
#line 51
      result = AMPromiscuous$ActivityTimer$fired();
#line 51
      break;
#line 51
    case 2U:
#line 51
      result = XMeshC$EngineTimer$fired();
#line 51
      break;
#line 51
    case 3U:
#line 51
      result = XMeshC$EwmaTimer$fired();
#line 51
      break;
#line 51
    case 4U:
#line 51
      result = XMeshC$ElpTimer$fired();
#line 51
      break;
#line 51
    case 5U:
#line 51
      result = XMeshC$ElpTimeOut$fired();
#line 51
      break;
#line 51
    case 6U:
#line 51
      result = XMeshC$Window$fired();
#line 51
      break;
#line 51
    case 7U:
#line 51
      result = XMeshC$HealthTimer$fired();
#line 51
      break;
#line 51
    case 8U:
#line 51
      result = XMeshC$XOtapTimer$fired();
#line 51
      break;
#line 51
    case 9U:
#line 51
      result = ADCREFM$Timer$fired();
#line 51
      break;
#line 51
    case 10U:
#line 51
      result = SamplerM$SamplerTimer$fired();
#line 51
      break;
#line 51
    case 11U:
#line 51
      result = IBADCM$PowerStabalizingTimer$fired();
#line 51
      break;
#line 51
    default:
#line 51
      result = TimerM$Timer$default$fired(arg_0x1a8b62b0);
#line 51
      break;
#line 51
    }
#line 51

#line 51
  return result;
#line 51
}
#line 51
# 171 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\TimerM.nc"
static inline uint8_t TimerM$dequeue(void)
#line 171
{
  if (TimerM$queue_size == 0) {
    return NUM_TIMERS;
    }
#line 174
  if (TimerM$queue_head == NUM_TIMERS - 1) {
    TimerM$queue_head = -1;
    }
#line 176
  TimerM$queue_head++;
  TimerM$queue_size--;
  return TimerM$queue[(uint8_t )TimerM$queue_head];
}

static inline  void TimerM$signalOneTimer(void)
#line 181
{
  uint8_t itimer = TimerM$dequeue();

#line 183
  if (itimer < NUM_TIMERS) {
    TimerM$Timer$fired(itimer);
    }
}

#line 187
static inline  void TimerM$HandleFire(void)
#line 187
{
  uint8_t i;
  uint16_t int_out;

#line 190
  TimerM$setIntervalFlag = 1;


  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 193
    {
      int_out = TimerM$interval_outstanding;
      TimerM$interval_outstanding = 0;
    }
#line 196
    __nesc_atomic_end(__nesc_atomic); }
  if (TimerM$mState) {
      for (i = 0; i < NUM_TIMERS; i++) {
          if (TimerM$mState & (0x1L << i)) {
              TimerM$mTimerList[i].ticksLeft -= int_out;
              if (TimerM$mTimerList[i].ticksLeft <= 2) {


                  if (TOS_post(TimerM$signalOneTimer)) {
                      if (TimerM$mTimerList[i].type == TIMER_REPEAT) {
                          TimerM$mTimerList[i].ticksLeft += TimerM$mTimerList[i].ticks;
                        }
                      else 
#line 207
                        {
                          TimerM$mState &= ~(0x1L << i);
                        }
                      TimerM$enqueue(i);
                    }
                  else {
                      {
                      }
#line 213
                      ;


                      TimerM$mTimerList[i].ticksLeft = TimerM$mInterval;
                    }
                }
            }
        }
    }


  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 224
    int_out = TimerM$interval_outstanding;
#line 224
    __nesc_atomic_end(__nesc_atomic); }
  if (int_out == 0) {
    TimerM$adjustInterval();
    }
}

static inline   result_t TimerM$Clock$fire(void)
#line 230
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 231
    {



      if (TimerM$interval_outstanding == 0) {
        TOS_post(TimerM$HandleFire);
        }
      else {
        }
#line 238
      ;

      TimerM$interval_outstanding += TimerM$Clock$getInterval() + 1;
    }
#line 241
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

# 159 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Clock.nc"
inline static   result_t HPLClock$Clock$fire(void){
#line 159
  unsigned char result;
#line 159

#line 159
  result = TimerM$Clock$fire();
#line 159

#line 159
  return result;
#line 159
}
#line 159
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
inline static  result_t SamplerM$SamplerTimer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500){
#line 37
  unsigned char result;
#line 37

#line 37
  result = TimerM$Timer$start(10U, arg_0x1a5d5368, arg_0x1a5d5500);
#line 37

#line 37
  return result;
#line 37
}
#line 37
# 39 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\I2CPacket.nc"
inline static  result_t DioM$I2CPacket$readPacket(char arg_0x1b093858, char arg_0x1b0939d8){
#line 39
  unsigned char result;
#line 39

#line 39
  result = I2CPacketM$I2CPacket$readPacket(63, arg_0x1b093858, arg_0x1b0939d8);
#line 39

#line 39
  return result;
#line 39
}
#line 39
# 110 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static __inline int8_t SamplerM$get_avilable_SampleRecord(void)
{
  int8_t i;

#line 113
  for (i = 0; i < 25; i++) if (SamplerM$SampleRecord[i].sampling_interval == SAMPLE_RECORD_FREE) {
#line 113
      return i;
      }
#line 114
  return -1;
}

# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
inline static  result_t SamplerM$Dio5$setparam(uint8_t arg_0x1afefeb0){
#line 27
  unsigned char result;
#line 27

#line 27
  result = DioM$Dio$setparam(5, arg_0x1afefeb0);
#line 27

#line 27
  return result;
#line 27
}
#line 27
inline static  result_t SamplerM$Dio4$setparam(uint8_t arg_0x1afefeb0){
#line 27
  unsigned char result;
#line 27

#line 27
  result = DioM$Dio$setparam(4, arg_0x1afefeb0);
#line 27

#line 27
  return result;
#line 27
}
#line 27
inline static  result_t SamplerM$Dio3$setparam(uint8_t arg_0x1afefeb0){
#line 27
  unsigned char result;
#line 27

#line 27
  result = DioM$Dio$setparam(3, arg_0x1afefeb0);
#line 27

#line 27
  return result;
#line 27
}
#line 27
inline static  result_t SamplerM$Dio2$setparam(uint8_t arg_0x1afefeb0){
#line 27
  unsigned char result;
#line 27

#line 27
  result = DioM$Dio$setparam(2, arg_0x1afefeb0);
#line 27

#line 27
  return result;
#line 27
}
#line 27
inline static  result_t SamplerM$Dio1$setparam(uint8_t arg_0x1afefeb0){
#line 27
  unsigned char result;
#line 27

#line 27
  result = DioM$Dio$setparam(1, arg_0x1afefeb0);
#line 27

#line 27
  return result;
#line 27
}
#line 27
inline static  result_t SamplerM$Dio0$setparam(uint8_t arg_0x1afefeb0){
#line 27
  unsigned char result;
#line 27

#line 27
  result = DioM$Dio$setparam(0, arg_0x1afefeb0);
#line 27

#line 27
  return result;
#line 27
}
#line 27
# 191 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static __inline void SamplerM$setparam_digital(int8_t i, uint8_t param)
{
  switch (SamplerM$SampleRecord[i].channel) {
      case 0: 
        SamplerM$Dio0$setparam(param);
      break;
      case 1: 
        SamplerM$Dio1$setparam(param);
      break;
      case 2: 
        SamplerM$Dio2$setparam(param);
      break;
      case 3: 
        SamplerM$Dio3$setparam(param);
      break;
      case 4: 
        SamplerM$Dio4$setparam(param);
      break;
      case 5: 
        SamplerM$Dio5$setparam(param);
      break;
      default: ;
    }
  return;
}

# 79 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\CounterM.nc"
static inline  result_t CounterM$Counter$setparam(uint8_t modeToSet)
{


  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 83
    {
      CounterM$mode = modeToSet;
      if (((CounterM$mode & RISING_EDGE) == 0) & ((CounterM$mode & FALLING_EDGE) == 0)) {
        CounterM$mode |= RISING_EDGE;
        }
    }
#line 88
    __nesc_atomic_end(__nesc_atomic); }
#line 88
  return SUCCESS;
}

# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
inline static  result_t SamplerM$Counter$setparam(uint8_t arg_0x1afefeb0){
#line 27
  unsigned char result;
#line 27

#line 27
  result = CounterM$Counter$setparam(arg_0x1afefeb0);
#line 27

#line 27
  return result;
#line 27
}
#line 27
# 217 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static __inline void SamplerM$setparam_counter(int8_t i, uint8_t param)
{
  SamplerM$Counter$setparam(param);
  return;
}

# 372 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
static inline  result_t IBADCM$SetParam$setParam(uint8_t id, uint8_t mode)
#line 372
{
  IBADCM$param[id] = mode;
  return SUCCESS;
}

# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SetParam.nc"
inline static  result_t SamplerM$SetParam13$setParam(uint8_t arg_0x1afc7e18){
#line 17
  unsigned char result;
#line 17

#line 17
  result = IBADCM$SetParam$setParam(13, arg_0x1afc7e18);
#line 17

#line 17
  return result;
#line 17
}
#line 17
inline static  result_t SamplerM$SetParam12$setParam(uint8_t arg_0x1afc7e18){
#line 17
  unsigned char result;
#line 17

#line 17
  result = IBADCM$SetParam$setParam(12, arg_0x1afc7e18);
#line 17

#line 17
  return result;
#line 17
}
#line 17
inline static  result_t SamplerM$SetParam11$setParam(uint8_t arg_0x1afc7e18){
#line 17
  unsigned char result;
#line 17

#line 17
  result = IBADCM$SetParam$setParam(11, arg_0x1afc7e18);
#line 17

#line 17
  return result;
#line 17
}
#line 17
inline static  result_t SamplerM$SetParam10$setParam(uint8_t arg_0x1afc7e18){
#line 17
  unsigned char result;
#line 17

#line 17
  result = IBADCM$SetParam$setParam(10, arg_0x1afc7e18);
#line 17

#line 17
  return result;
#line 17
}
#line 17
inline static  result_t SamplerM$SetParam9$setParam(uint8_t arg_0x1afc7e18){
#line 17
  unsigned char result;
#line 17

#line 17
  result = IBADCM$SetParam$setParam(9, arg_0x1afc7e18);
#line 17

#line 17
  return result;
#line 17
}
#line 17
inline static  result_t SamplerM$SetParam8$setParam(uint8_t arg_0x1afc7e18){
#line 17
  unsigned char result;
#line 17

#line 17
  result = IBADCM$SetParam$setParam(8, arg_0x1afc7e18);
#line 17

#line 17
  return result;
#line 17
}
#line 17
inline static  result_t SamplerM$SetParam7$setParam(uint8_t arg_0x1afc7e18){
#line 17
  unsigned char result;
#line 17

#line 17
  result = IBADCM$SetParam$setParam(7, arg_0x1afc7e18);
#line 17

#line 17
  return result;
#line 17
}
#line 17
inline static  result_t SamplerM$SetParam6$setParam(uint8_t arg_0x1afc7e18){
#line 17
  unsigned char result;
#line 17

#line 17
  result = IBADCM$SetParam$setParam(6, arg_0x1afc7e18);
#line 17

#line 17
  return result;
#line 17
}
#line 17
inline static  result_t SamplerM$SetParam5$setParam(uint8_t arg_0x1afc7e18){
#line 17
  unsigned char result;
#line 17

#line 17
  result = IBADCM$SetParam$setParam(5, arg_0x1afc7e18);
#line 17

#line 17
  return result;
#line 17
}
#line 17
inline static  result_t SamplerM$SetParam4$setParam(uint8_t arg_0x1afc7e18){
#line 17
  unsigned char result;
#line 17

#line 17
  result = IBADCM$SetParam$setParam(4, arg_0x1afc7e18);
#line 17

#line 17
  return result;
#line 17
}
#line 17
inline static  result_t SamplerM$SetParam3$setParam(uint8_t arg_0x1afc7e18){
#line 17
  unsigned char result;
#line 17

#line 17
  result = IBADCM$SetParam$setParam(3, arg_0x1afc7e18);
#line 17

#line 17
  return result;
#line 17
}
#line 17
inline static  result_t SamplerM$SetParam2$setParam(uint8_t arg_0x1afc7e18){
#line 17
  unsigned char result;
#line 17

#line 17
  result = IBADCM$SetParam$setParam(2, arg_0x1afc7e18);
#line 17

#line 17
  return result;
#line 17
}
#line 17
inline static  result_t SamplerM$SetParam1$setParam(uint8_t arg_0x1afc7e18){
#line 17
  unsigned char result;
#line 17

#line 17
  result = IBADCM$SetParam$setParam(1, arg_0x1afc7e18);
#line 17

#line 17
  return result;
#line 17
}
#line 17
inline static  result_t SamplerM$SetParam0$setParam(uint8_t arg_0x1afc7e18){
#line 17
  unsigned char result;
#line 17

#line 17
  result = IBADCM$SetParam$setParam(0, arg_0x1afc7e18);
#line 17

#line 17
  return result;
#line 17
}
#line 17
# 141 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static __inline void SamplerM$setparam_analog(uint8_t i, uint8_t param)
{
  switch (SamplerM$SampleRecord[i].channel) {
      case 0: 
        SamplerM$SetParam0$setParam(param);
      break;
      case 1: 
        SamplerM$SetParam1$setParam(param);
      break;
      case 2: 
        SamplerM$SetParam2$setParam(param);
      break;
      case 3: 
        SamplerM$SetParam3$setParam(param);
      break;
      case 4: 
        SamplerM$SetParam4$setParam(param);
      break;
      case 5: 
        SamplerM$SetParam5$setParam(param);
      break;
      case 6: 
        SamplerM$SetParam6$setParam(param);
      break;
      case 7: 
        SamplerM$SetParam7$setParam(param);
      break;
      case 8: 
        SamplerM$SetParam8$setParam(param);
      break;
      case 9: 
        SamplerM$SetParam9$setParam(param);
      break;
      case 10: 
        SamplerM$SetParam10$setParam(param);
      break;
      case 11: 
        SamplerM$SetParam11$setParam(param);
      break;
      case 12: 
        SamplerM$SetParam12$setParam(param);
      break;
      case 13: 
        SamplerM$SetParam13$setParam(param);
      break;
      default: ;
    }
  return;
}

# 127 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Clock.nc"
inline static   result_t TimerJiffyAsyncM$Timer$setIntervalAndScale(uint8_t arg_0x1a8d01b8, uint8_t arg_0x1a8d0340){
#line 127
  unsigned char result;
#line 127

#line 127
  result = HPLTimer2$Timer2$setIntervalAndScale(arg_0x1a8d01b8, arg_0x1a8d0340);
#line 127

#line 127
  return result;
#line 127
}
#line 127
# 19 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\PowerManagement.nc"
inline static   uint8_t TimerJiffyAsyncM$PowerManagement$adjustPower(void){
#line 19
  unsigned char result;
#line 19

#line 19
  result = HPLPowerManagementM$PowerManagement$adjustPower();
#line 19

#line 19
  return result;
#line 19
}
#line 19
# 40 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\TimerJiffyAsync.nc"
inline static   result_t TimerJiffyAsyncM$TimerJiffyAsync$fired(void){
#line 40
  unsigned char result;
#line 40

#line 40
  result = CC2420RadioM$BackoffTimerJiffy$fired();
#line 40

#line 40
  return result;
#line 40
}
#line 40
# 73 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\TimerJiffyAsyncM.nc"
static inline   result_t TimerJiffyAsyncM$Timer$fire(void)
#line 73
{
  uint16_t localjiffy;

#line 75
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 75
    localjiffy = TimerJiffyAsyncM$jiffy;
#line 75
    __nesc_atomic_end(__nesc_atomic); }
  if (localjiffy < 0xFF) {
      TimerJiffyAsyncM$Timer$intDisable();
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 78
        TimerJiffyAsyncM$bSet = FALSE;
#line 78
        __nesc_atomic_end(__nesc_atomic); }
      TimerJiffyAsyncM$TimerJiffyAsync$fired();
      TimerJiffyAsyncM$PowerManagement$adjustPower();
    }
  else {

      localjiffy = localjiffy >> 8;
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 85
        TimerJiffyAsyncM$jiffy = localjiffy;
#line 85
        __nesc_atomic_end(__nesc_atomic); }
      TimerJiffyAsyncM$Timer$setIntervalAndScale(localjiffy, 0x4);
    }
  return SUCCESS;
}

# 159 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Clock.nc"
inline static   result_t HPLTimer2$Timer2$fire(void){
#line 159
  unsigned char result;
#line 159

#line 159
  result = TimerJiffyAsyncM$Timer$fire();
#line 159

#line 159
  return result;
#line 159
}
#line 159
# 49 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\crc.h"
static inline uint16_t crcByte(uint16_t oldCrc, uint8_t byte)
{

  uint16_t *table = crcTable;
  uint16_t newCrc;

   __asm ("eor %1,%B3\n"
  "\tlsl %1\n"
  "\tadc %B2, __zero_reg__\n"
  "\tadd %A2, %1\n"
  "\tadc %B2, __zero_reg__\n"
  "\tlpm\n"
  "\tmov %B0, %A3\n"
  "\tmov %A0, r0\n"
  "\tadiw r30,1\n"
  "\tlpm\n"
  "\teor %B0, r0" : 
  "=r"(newCrc), "+r"(byte), "+z"(table) : "r"(oldCrc));
  return newCrc;
}

# 216 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\FramerM.nc"
static inline  void FramerM$PacketUnknown(void)
#line 216
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 217
    {
      FramerM$gFlags |= FramerM$FLAGS_UNKNOWN;
    }
#line 219
    __nesc_atomic_end(__nesc_atomic); }

  FramerM$StartTx();
}

# 267 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static inline  TOS_MsgPtr AMPromiscuous$UARTReceive$receive(TOS_MsgPtr packet)
#line 267
{
  packet->group = TOS_AM_GROUP;
  return prom_received(packet);
}

# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
inline static  TOS_MsgPtr FramerAckM$ReceiveCombined$receive(TOS_MsgPtr arg_0x1a581c80){
#line 53
  struct TOS_Msg *result;
#line 53

#line 53
  result = AMPromiscuous$UARTReceive$receive(arg_0x1a581c80);
#line 53

#line 53
  return result;
#line 53
}
#line 53
# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\FramerAckM.nc"
static inline  TOS_MsgPtr FramerAckM$ReceiveMsg$receive(TOS_MsgPtr Msg)
#line 56
{
  TOS_MsgPtr pBuf;

  pBuf = FramerAckM$ReceiveCombined$receive(Msg);

  return pBuf;
}

# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ReceiveMsg.nc"
inline static  TOS_MsgPtr FramerM$ReceiveMsg$receive(TOS_MsgPtr arg_0x1a581c80){
#line 53
  struct TOS_Msg *result;
#line 53

#line 53
  result = FramerAckM$ReceiveMsg$receive(arg_0x1a581c80);
#line 53

#line 53
  return result;
#line 53
}
#line 53
# 345 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\FramerM.nc"
static inline  result_t FramerM$TokenReceiveMsg$ReflectToken(uint8_t Token)
#line 345
{
  result_t Result = SUCCESS;

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 348
    {
      if (!(FramerM$gFlags & FramerM$FLAGS_TOKENPEND)) {
          FramerM$gFlags |= FramerM$FLAGS_TOKENPEND;
          FramerM$gTxTokenBuf = Token;
        }
      else {
          Result = FAIL;
        }
    }
#line 356
    __nesc_atomic_end(__nesc_atomic); }

  if (Result == SUCCESS) {
      Result = FramerM$StartTx();
    }

  return Result;
}

# 59 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\TokenReceiveMsg.nc"
inline static  result_t FramerAckM$TokenReceiveMsg$ReflectToken(uint8_t arg_0x1aa23a68){
#line 59
  unsigned char result;
#line 59

#line 59
  result = FramerM$TokenReceiveMsg$ReflectToken(arg_0x1aa23a68);
#line 59

#line 59
  return result;
#line 59
}
#line 59
# 39 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\FramerAckM.nc"
static inline  void FramerAckM$SendAckTask(void)
#line 39
{

  FramerAckM$TokenReceiveMsg$ReflectToken(FramerAckM$gTokenBuf);
}

static inline  TOS_MsgPtr FramerAckM$TokenReceiveMsg$receive(TOS_MsgPtr Msg, uint8_t token)
#line 44
{
  TOS_MsgPtr pBuf;

  FramerAckM$gTokenBuf = token;

  TOS_post(FramerAckM$SendAckTask);

  pBuf = FramerAckM$ReceiveCombined$receive(Msg);

  return pBuf;
}

# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\TokenReceiveMsg.nc"
inline static  TOS_MsgPtr FramerM$TokenReceiveMsg$receive(TOS_MsgPtr arg_0x1aa23068, uint8_t arg_0x1aa231f0){
#line 46
  struct TOS_Msg *result;
#line 46

#line 46
  result = FramerAckM$TokenReceiveMsg$receive(arg_0x1aa23068, arg_0x1aa231f0);
#line 46

#line 46
  return result;
#line 46
}
#line 46
# 224 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\FramerM.nc"
static inline  void FramerM$PacketRcvd(void)
#line 224
{
  FramerM$MsgRcvEntry_t *pRcv = &FramerM$gMsgRcvTbl[FramerM$gRxTailIndex];
  TOS_MsgPtr pBuf = pRcv->pMsg;



  if (pRcv->Length >= 5) {



      switch (pRcv->Proto) {
          case FramerM$PROTO_ACK: 
            break;
          case FramerM$PROTO_PACKET_ACK: 
            pBuf->crc = 1;
          pBuf = FramerM$TokenReceiveMsg$receive(pBuf, pRcv->Token);
          break;
          case FramerM$PROTO_PACKET_NOACK: 
            pBuf->crc = 1;
          pBuf = FramerM$ReceiveMsg$receive(pBuf);
          break;
          default: 
            FramerM$gTxUnknownBuf = pRcv->Proto;
          TOS_post(FramerM$PacketUnknown);
          break;
        }
    }

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 252
    {
      if (pBuf) {
          pRcv->pMsg = pBuf;
        }
      pRcv->Length = 0;
      pRcv->Token = 0;
      FramerM$gRxTailIndex++;
      FramerM$gRxTailIndex %= FramerM$HDLC_QUEUESIZE;
    }
#line 260
    __nesc_atomic_end(__nesc_atomic); }
}

#line 365
static inline   result_t FramerM$ByteComm$rxByteReady(uint8_t data, bool error, uint16_t strength)
#line 365
{

  switch (FramerM$gRxState) {

      case FramerM$RXSTATE_NOSYNC: 
        if (data == FramerM$HDLC_FLAG_BYTE && FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].Length == 0) {

            FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].Token = 0;
            FramerM$gRxByteCnt = FramerM$gRxRunningCRC = 0;
            FramerM$gpRxBuf = (uint8_t *)FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].pMsg;
            FramerM$gRxState = FramerM$RXSTATE_PROTO;
          }
      break;

      case FramerM$RXSTATE_PROTO: 
        if (data == FramerM$HDLC_FLAG_BYTE) {
            break;
          }
      FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].Proto = data;
      FramerM$gRxRunningCRC = crcByte(FramerM$gRxRunningCRC, data);
      switch (data) {
          case FramerM$PROTO_PACKET_ACK: 
            FramerM$gRxState = FramerM$RXSTATE_TOKEN;
          break;
          case FramerM$PROTO_PACKET_NOACK: 
            FramerM$gRxState = FramerM$RXSTATE_INFO;
          break;
          default: 
            FramerM$gRxState = FramerM$RXSTATE_NOSYNC;
          break;
        }
      break;

      case FramerM$RXSTATE_TOKEN: 
        if (data == FramerM$HDLC_FLAG_BYTE) {
            FramerM$gRxState = FramerM$RXSTATE_NOSYNC;
          }
        else {
#line 402
          if (data == FramerM$HDLC_CTLESC_BYTE) {
              FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].Token = 0x20;
            }
          else {
              FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].Token ^= data;
              FramerM$gRxRunningCRC = crcByte(FramerM$gRxRunningCRC, FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].Token);
              FramerM$gRxState = FramerM$RXSTATE_INFO;
            }
          }
#line 410
      break;


      case FramerM$RXSTATE_INFO: 
        if (FramerM$gRxByteCnt > FramerM$HDLC_MTU) {
            FramerM$gRxByteCnt = FramerM$gRxRunningCRC = 0;
            FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].Length = 0;
            FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].Token = 0;
            FramerM$gRxState = FramerM$RXSTATE_NOSYNC;
          }
        else {
#line 420
          if (data == FramerM$HDLC_CTLESC_BYTE) {
              FramerM$gRxState = FramerM$RXSTATE_ESC;
            }
          else {
#line 423
            if (data == FramerM$HDLC_FLAG_BYTE) {
                if (FramerM$gRxByteCnt >= 2) {

                    uint16_t usRcvdCRC = FramerM$gpRxBuf[FramerM$fRemapRxPos(FramerM$gRxByteCnt - 1)] & 0xff;

#line 427
                    usRcvdCRC = (usRcvdCRC << 8) | (FramerM$gpRxBuf[FramerM$fRemapRxPos(FramerM$gRxByteCnt - 2)] & 0xff);






                    if (usRcvdCRC == FramerM$gRxRunningCRC) {
                        FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].Length = FramerM$gRxByteCnt - 2;
                        TOS_post(FramerM$PacketRcvd);
                        FramerM$gRxHeadIndex++;
#line 437
                        FramerM$gRxHeadIndex %= FramerM$HDLC_QUEUESIZE;
                      }
                    else {
                        FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].Length = 0;
                        FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].Token = 0;
                        FramerM$gRxState = FramerM$RXSTATE_NOSYNC;
                        FramerM$gRxByteCnt = FramerM$gRxRunningCRC = 0;
                        break;
                      }
                    if (FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].Length == 0) {
                        FramerM$gpRxBuf = (uint8_t *)FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].pMsg;
                        FramerM$gRxState = FramerM$RXSTATE_PROTO;
                      }
                    else {
                        FramerM$gRxState = FramerM$RXSTATE_NOSYNC;
                      }
                  }
                else {
                    FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].Length = 0;
                    FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].Token = 0;
                    FramerM$gRxState = FramerM$RXSTATE_NOSYNC;
                  }
                FramerM$gRxByteCnt = FramerM$gRxRunningCRC = 0;
              }
            else {
                FramerM$gpRxBuf[FramerM$fRemapRxPos(FramerM$gRxByteCnt)] = data;
                if (FramerM$gRxByteCnt >= 2) {
                    FramerM$gRxRunningCRC = crcByte(FramerM$gRxRunningCRC, FramerM$gpRxBuf[FramerM$fRemapRxPos(FramerM$gRxByteCnt - 2)]);
                  }
                FramerM$gRxByteCnt++;
              }
            }
          }
#line 468
      break;

      case FramerM$RXSTATE_ESC: 
        if (data == FramerM$HDLC_FLAG_BYTE) {

            FramerM$gRxByteCnt = FramerM$gRxRunningCRC = 0;
            FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].Length = 0;
            FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].Token = 0;
            FramerM$gRxState = FramerM$RXSTATE_NOSYNC;
          }
        else {
            data = data ^ 0x20;
            FramerM$gpRxBuf[FramerM$fRemapRxPos(FramerM$gRxByteCnt)] = data;
            if (FramerM$gRxByteCnt >= 2) {
                FramerM$gRxRunningCRC = crcByte(FramerM$gRxRunningCRC, FramerM$gpRxBuf[FramerM$fRemapRxPos(FramerM$gRxByteCnt - 2)]);
              }
            FramerM$gRxByteCnt++;
            FramerM$gRxState = FramerM$RXSTATE_INFO;
          }
      break;

      default: 
        FramerM$gRxState = FramerM$RXSTATE_NOSYNC;
      break;
    }

  return SUCCESS;
}

# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ByteComm.nc"
inline static   result_t UARTM$ByteComm$rxByteReady(uint8_t arg_0x1aa0a708, bool arg_0x1aa0a890, uint16_t arg_0x1aa0aa28){
#line 45
  unsigned char result;
#line 45

#line 45
  result = FramerM$ByteComm$rxByteReady(arg_0x1aa0a708, arg_0x1aa0a890, arg_0x1aa0aa28);
#line 45

#line 45
  return result;
#line 45
}
#line 45
# 57 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\UARTM.nc"
static inline   result_t UARTM$HPLUART$get(uint8_t data)
#line 57
{




  UARTM$ByteComm$rxByteReady(data, FALSE, 0);
  {
  }
#line 63
  ;
  return SUCCESS;
}

# 66 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLUART.nc"
inline static   result_t HPLUART0M$UART$get(uint8_t arg_0x1aaaad48){
#line 66
  unsigned char result;
#line 66

#line 66
  result = UARTM$HPLUART$get(arg_0x1aaaad48);
#line 66

#line 66
  return result;
#line 66
}
#line 66
# 34 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ByteComm.nc"
inline static   result_t FramerM$ByteComm$txByte(uint8_t arg_0x1aa0a010){
#line 34
  unsigned char result;
#line 34

#line 34
  result = UARTM$ByteComm$txByte(arg_0x1aa0a010);
#line 34

#line 34
  return result;
#line 34
}
#line 34
# 510 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\FramerM.nc"
static inline   result_t FramerM$ByteComm$txByteReady(bool LastByteSuccess)
#line 510
{
  result_t TxResult = SUCCESS;
  uint8_t nextByte;

  if (LastByteSuccess != TRUE) {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 515
        FramerM$gTxState = FramerM$TXSTATE_ERROR;
#line 515
        __nesc_atomic_end(__nesc_atomic); }
      TOS_post(FramerM$PacketSent);
      return SUCCESS;
    }

  switch (FramerM$gTxState) {

      case FramerM$TXSTATE_PROTO: 
        FramerM$gTxState = FramerM$TXSTATE_INFO;
      FramerM$gTxRunningCRC = crcByte(FramerM$gTxRunningCRC, FramerM$gTxProto);
      TxResult = FramerM$ByteComm$txByte(FramerM$gTxProto);
      break;

      case FramerM$TXSTATE_INFO: 
        if (FramerM$gTxProto == FramerM$PROTO_ACK) {
          nextByte = FramerM$gpTxBuf[0];
          }
        else {
#line 532
          nextByte = FramerM$gpTxBuf[FramerM$gTxByteCnt];
          }
#line 533
      FramerM$gTxRunningCRC = crcByte(FramerM$gTxRunningCRC, nextByte);
      FramerM$gTxByteCnt++;

      if (FramerM$gTxByteCnt == 10) {
        FramerM$gTxByteCnt = 0;
        }
#line 538
      if (FramerM$gTxByteCnt == 1) {
        FramerM$gTxByteCnt = 10;
        }
      if (FramerM$gTxByteCnt >= FramerM$gTxLength) {
          FramerM$gTxState = FramerM$TXSTATE_FCS1;
        }

      TxResult = FramerM$TxArbitraryByte(nextByte);
      break;

      case FramerM$TXSTATE_ESC: 

        TxResult = FramerM$ByteComm$txByte(FramerM$gTxEscByte ^ 0x20);
      FramerM$gTxState = FramerM$gPrevTxState;
      break;

      case FramerM$TXSTATE_FCS1: 
        nextByte = (uint8_t )(FramerM$gTxRunningCRC & 0xff);
      FramerM$gTxState = FramerM$TXSTATE_FCS2;
      TxResult = FramerM$TxArbitraryByte(nextByte);
      break;

      case FramerM$TXSTATE_FCS2: 
        nextByte = (uint8_t )((FramerM$gTxRunningCRC >> 8) & 0xff);
      FramerM$gTxState = FramerM$TXSTATE_ENDFLAG;
      TxResult = FramerM$TxArbitraryByte(nextByte);
      break;

      case FramerM$TXSTATE_ENDFLAG: 
        FramerM$gTxState = FramerM$TXSTATE_FINISH;
      TxResult = FramerM$ByteComm$txByte(FramerM$HDLC_FLAG_BYTE);

      break;

      case FramerM$TXSTATE_FINISH: 
        case FramerM$TXSTATE_ERROR: 

          default: 
            break;
    }


  if (TxResult != SUCCESS) {
      FramerM$gTxState = FramerM$TXSTATE_ERROR;
      TOS_post(FramerM$PacketSent);
    }

  return SUCCESS;
}

# 54 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ByteComm.nc"
inline static   result_t UARTM$ByteComm$txByteReady(bool arg_0x1aa08200){
#line 54
  unsigned char result;
#line 54

#line 54
  result = FramerM$ByteComm$txByteReady(arg_0x1aa08200);
#line 54

#line 54
  return result;
#line 54
}
#line 54
# 588 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\FramerM.nc"
static inline   result_t FramerM$ByteComm$txDone(void)
#line 588
{

  if (FramerM$gTxState == FramerM$TXSTATE_FINISH) {
      FramerM$gTxState = FramerM$TXSTATE_IDLE;
      TOS_post(FramerM$PacketSent);
    }

  return SUCCESS;
}

# 62 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ByteComm.nc"
inline static   result_t UARTM$ByteComm$txDone(void){
#line 62
  unsigned char result;
#line 62

#line 62
  result = FramerM$ByteComm$txDone();
#line 62

#line 62
  return result;
#line 62
}
#line 62
# 67 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\UARTM.nc"
static inline   result_t UARTM$HPLUART$putDone(void)
#line 67
{
  bool oldState;

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 70
    {
      {
      }
#line 71
      ;
      oldState = UARTM$state;
      UARTM$state = FALSE;
    }
#line 74
    __nesc_atomic_end(__nesc_atomic); }








  if (oldState) {
      UARTM$ByteComm$txDone();
      UARTM$ByteComm$txByteReady(TRUE);
    }
  return SUCCESS;
}

# 74 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLUART.nc"
inline static   result_t HPLUART0M$UART$putDone(void){
#line 74
  unsigned char result;
#line 74

#line 74
  result = UARTM$HPLUART$putDone();
#line 74

#line 74
  return result;
#line 74
}
#line 74
# 223 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static inline  void SamplerM$sigbatt(void)
{
  SamplerM$Sample$dataReady(0, BATTERY, SamplerM$batvalue);
}

#line 505
static inline   result_t SamplerM$Battery$dataReady(uint16_t data)
#line 505
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 506
    SamplerM$batvalue = data;
#line 506
    __nesc_atomic_end(__nesc_atomic); }
  TOS_post(SamplerM$sigbatt);
  return SUCCESS;
}

# 97 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCREFM.nc"
static inline    result_t ADCREFM$ADC$default$dataReady(uint8_t port, uint16_t data)
#line 97
{
  return FAIL;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
inline static   result_t ADCREFM$ADC$dataReady(uint8_t arg_0x1ac819f8, uint16_t arg_0x1ab86808){
#line 48
  unsigned char result;
#line 48

#line 48
  switch (arg_0x1ac819f8) {
#line 48
    case TOS_ADC_VOLTAGE_PORT:
#line 48
      result = SamplerM$Battery$dataReady(arg_0x1ab86808);
#line 48
      result = rcombine(result, XMeshC$Batt$dataReady(arg_0x1ab86808));
#line 48
      break;
#line 48
    default:
#line 48
      result = ADCREFM$ADC$default$dataReady(arg_0x1ac819f8, arg_0x1ab86808);
#line 48
      break;
#line 48
    }
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCREFM.nc"
static inline    result_t ADCREFM$CalADC$default$dataReady(uint8_t port, uint16_t data)
#line 101
{
  return FAIL;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
inline static   result_t ADCREFM$CalADC$dataReady(uint8_t arg_0x1ac801b0, uint16_t arg_0x1ab86808){
#line 48
  unsigned char result;
#line 48

#line 48
    result = ADCREFM$CalADC$default$dataReady(arg_0x1ac801b0, arg_0x1ab86808);
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLADC.nc"
inline static   result_t ADCREFM$HPLADC$samplePort(uint8_t arg_0x1ac99778){
#line 56
  unsigned char result;
#line 56

#line 56
  result = HPLADCM$ADC$samplePort(arg_0x1ac99778);
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 112 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCREFM.nc"
static inline   result_t ADCREFM$HPLADC$dataReady(uint16_t data)
#line 112
{
  uint16_t doneValue = data;
  uint8_t donePort;
  uint8_t nextPort = 0xff;
  bool fCalResult = FALSE;
  result_t Result = SUCCESS;

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 119
    {
      if (ADCREFM$ReqPort == TOS_ADC_BANDGAP_PORT) {
          ADCREFM$RefVal = data;
        }
      donePort = ADCREFM$ReqPort;

      if (((1 << donePort) & ADCREFM$ContReqMask) == 0) {
          ADCREFM$ReqVector ^= 1 << donePort;
        }


      if ((1 << donePort) & ADCREFM$CalReqMask) {
          fCalResult = TRUE;
          if (((1 << donePort) & ADCREFM$ContReqMask) == 0) {
              ADCREFM$CalReqMask ^= 1 << donePort;
            }
        }

      if (ADCREFM$ReqVector) {


          do {
              ADCREFM$ReqPort++;
              ADCREFM$ReqPort = ADCREFM$ReqPort == TOSH_ADC_PORTMAPSIZE ? 0 : ADCREFM$ReqPort;
            }
          while (((
#line 143
          1 << ADCREFM$ReqPort) & ADCREFM$ReqVector) == 0);
          nextPort = ADCREFM$ReqPort;
        }
    }
#line 146
    __nesc_atomic_end(__nesc_atomic); }


  if (nextPort != 0xff) {
      ADCREFM$HPLADC$samplePort(nextPort);
    }

  {
  }
#line 153
  ;
  if (donePort != TOS_ADC_BANDGAP_PORT) {
      if (fCalResult) {
          uint32_t tmp = (uint32_t )data;

#line 157
          tmp = tmp << 10;
          { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 158
            tmp = tmp / ADCREFM$RefVal;
#line 158
            __nesc_atomic_end(__nesc_atomic); }
          doneValue = (uint16_t )tmp;
          Result = ADCREFM$CalADC$dataReady(donePort, doneValue);
        }
      else {
          Result = ADCREFM$ADC$dataReady(donePort, doneValue);
        }
    }

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 167
    {
      if (ADCREFM$ContReqMask & (1 << donePort) && Result == FAIL) {
          ADCREFM$ContReqMask ^= 1 << donePort;
        }
    }
#line 171
    __nesc_atomic_end(__nesc_atomic); }

  return SUCCESS;
}

# 78 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLADC.nc"
inline static   result_t HPLADCM$ADC$dataReady(uint16_t arg_0x1ac988f8){
#line 78
  unsigned char result;
#line 78

#line 78
  result = ADCREFM$HPLADC$dataReady(arg_0x1ac988f8);
#line 78

#line 78
  return result;
#line 78
}
#line 78
# 517 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static inline  result_t SamplerM$Hum$dataReady(uint16_t data)
#line 517
{
  SamplerM$Sample$dataReady(0, HUMIDITY, data);
  return SUCCESS;
}

# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
inline static  result_t TempHumM$HumSensor$dataReady(uint16_t arg_0x1afcb010){
#line 44
  unsigned char result;
#line 44

#line 44
  result = SamplerM$Hum$dataReady(arg_0x1afcb010);
#line 44

#line 44
  return result;
#line 44
}
#line 44
# 512 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static inline  result_t SamplerM$Temp$dataReady(uint16_t data)
#line 512
{
  SamplerM$Sample$dataReady(0, TEMPERATURE, data);
  return SUCCESS;
}

# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
inline static  result_t TempHumM$TempSensor$dataReady(uint16_t arg_0x1afcb010){
#line 44
  unsigned char result;
#line 44

#line 44
  result = SamplerM$Temp$dataReady(arg_0x1afcb010);
#line 44

#line 44
  return result;
#line 44
}
#line 44
# 99 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\TempHumM.nc"
static __inline void TempHumM$ack(void)
{
  * (volatile uint8_t *)(0x02 + 0x20) |= 1 << 7;
  * (volatile uint8_t *)(0x03 + 0x20) &= ~(1 << 7);
  TempHumM$delay();
  * (volatile uint8_t *)(0x15 + 0x20) |= 1 << 0;
  TempHumM$delay();
  * (volatile uint8_t *)(0x15 + 0x20) &= ~(1 << 0);
  * (volatile uint8_t *)(0x02 + 0x20) &= ~(1 << 7);
}

#line 228
static inline  void TempHumM$readSensor(void)
{
  char i;
  char CRC = 0;
  uint16_t data;
  uint16_t temp;
#line 233
  uint16_t hum;



  data = 0;
  for (i = 0; i < 8; i++) {
      * (volatile uint8_t *)(0x15 + 0x20) |= 1 << 0;
      TempHumM$delay();
      data |= (* (volatile uint8_t *)(0x01 + 0x20) >> 7) & 0x1;
      data = data << 1;

      * (volatile uint8_t *)(0x15 + 0x20) &= ~(1 << 0);
    }
  TempHumM$ack();
  for (i = 0; i < 8; i++) {
      * (volatile uint8_t *)(0x15 + 0x20) |= 1 << 0;
      TempHumM$delay();
      data |= (* (volatile uint8_t *)(0x01 + 0x20) >> 7) & 0x1;

      if (i != 7) {
#line 252
        data = data << 1;
        }
#line 253
      * (volatile uint8_t *)(0x15 + 0x20) &= ~(1 << 0);
    }

  TempHumM$ack();
  for (i = 0; i < 8; i++) {
      * (volatile uint8_t *)(0x15 + 0x20) |= 1 << 0;
      TempHumM$delay();
      CRC |= (* (volatile uint8_t *)(0x01 + 0x20) >> 7) & 0x1;
      if (i != 7) {
#line 261
        CRC = CRC << 1;
        }
#line 262
      * (volatile uint8_t *)(0x15 + 0x20) &= ~(1 << 0);
    }

  * (volatile uint8_t *)(0x02 + 0x20) |= 1 << 7;
  * (volatile uint8_t *)(0x03 + 0x20) |= 1 << 7;
  TempHumM$delay();
  * (volatile uint8_t *)(0x15 + 0x20) |= 1 << 0;
  TempHumM$delay();
  * (volatile uint8_t *)(0x15 + 0x20) &= ~(1 << 0);

  if (TempHumM$state == TempHumM$TEMP_MEASUREMENT) {
      temp = data;
#line 290
      TempHumM$TempSensor$dataReady(temp);
      if (TempHumM$pending_states & 0x02) {
#line 291
          TempHumM$pending_states = 0;
#line 291
          TOS_post(TempHumM$initiateHumidity);
        }
    }
  else {
#line 293
    if (TempHumM$state == TempHumM$HUM_MEASUREMENT) {
        hum = data;







        TempHumM$HumSensor$dataReady(hum);
        if (TempHumM$pending_states & 0x01) {
#line 303
            TempHumM$pending_states = 0;
#line 303
            TOS_post(TempHumM$initiateTemperature);
          }
      }
    }
#line 305
  TempHumM$state = TempHumM$IDLE;
}

# 259 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  void BoundaryM$BoundaryI$set_nbrtbl_childLiveliness(uint8_t iIndex, uint8_t value)
#line 259
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 260
    BoundaryM$NeighborTbl[iIndex].childLiveliness = value;
    }
#line 260
  ;
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_nbrtbl_childLiveliness(uint8_t arg_0x1ab92960, uint8_t arg_0x1ab92ae8){
#line 56
  BoundaryM$BoundaryI$set_nbrtbl_childLiveliness(arg_0x1ab92960, arg_0x1ab92ae8);
#line 56
}
#line 56
# 213 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  void BoundaryM$BoundaryI$new_nbrtbl_entry(uint8_t iIndex, uint16_t nodeid)
#line 213
{
  BoundaryM$NeighborTbl[iIndex].id = nodeid;
  BoundaryM$NeighborTbl[iIndex].flags = NBRFLAG_VALID | NBRFLAG_NEW;
  BoundaryM$NeighborTbl[iIndex].liveliness = 0;
  BoundaryM$NeighborTbl[iIndex].parent = ROUTE_INVALID;
  BoundaryM$NeighborTbl[iIndex].cost = ROUTE_INVALID;
  BoundaryM$NeighborTbl[iIndex].childLiveliness = 0;
  BoundaryM$NeighborTbl[iIndex].hop = ROUTE_INVALID;
  BoundaryM$NeighborTbl[iIndex].missed = 0;
  BoundaryM$NeighborTbl[iIndex].received = 0;
  BoundaryM$NeighborTbl[iIndex].receiveEst = 0;
  BoundaryM$NeighborTbl[iIndex].sendEst = 0;
}

#line 256
static inline  void BoundaryM$BoundaryI$set_nbrtbl_cost(uint8_t iIndex, uint16_t value)
#line 256
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 257
    BoundaryM$NeighborTbl[iIndex].cost = value;
    }
#line 257
  ;
}

# 55 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_nbrtbl_cost(uint8_t arg_0x1ab92330, uint16_t arg_0x1ab924c0){
#line 55
  BoundaryM$BoundaryI$set_nbrtbl_cost(arg_0x1ab92330, arg_0x1ab924c0);
#line 55
}
#line 55
# 178 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint16_t BoundaryM$BoundaryI$get_nbrtbl_parent(uint8_t iIndex)
#line 178
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 179
    return BoundaryM$NeighborTbl[iIndex].parent;
    }
  else {
#line 179
    return 0xffff;
    }
#line 179
  ;
}

# 52 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420Control.nc"
inline static  result_t BoundaryM$CC2420Control$TunePreset(uint8_t arg_0x1a6516c8){
#line 52
  unsigned char result;
#line 52

#line 52
  result = CC2420ControlM$CC2420Control$TunePreset(arg_0x1a6516c8);
#line 52

#line 52
  return result;
#line 52
}
#line 52
# 156 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  void BoundaryM$BoundaryI$set_tos_cc_channel(uint8_t channel)
#line 156
{









  TOS_CC2420_CHANNEL = channel;
  BoundaryM$CC2420Control$TunePreset(TOS_CC2420_CHANNEL);
}

# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_tos_cc_channel(uint8_t arg_0x1ab9a010){
#line 31
  BoundaryM$BoundaryI$set_tos_cc_channel(arg_0x1ab9a010);
#line 31
}
#line 31
# 309 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  TOS_MsgPtr BoundaryM$BoundaryI$get_fwd_buf_ptr(uint8_t iIndex)
#line 309
{
  return BoundaryM$FwdBufList[iIndex];
}

# 85 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  TOS_MsgPtr XMeshC$BoundaryI$get_fwd_buf_ptr(uint8_t arg_0x1aba4648){
#line 85
  struct TOS_Msg *result;
#line 85

#line 85
  result = BoundaryM$BoundaryI$get_fwd_buf_ptr(arg_0x1aba4648);
#line 85

#line 85
  return result;
#line 85
}
#line 85
# 289 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint8_t BoundaryM$BoundaryI$get_nbrtbl_size(void)
#line 289
{
  return sizeof BoundaryM$NeighborTbl / sizeof BoundaryM$NeighborTbl[0];
}

# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  uint8_t XMeshC$BoundaryI$get_nbrtbl_size(void){
#line 65
  unsigned char result;
#line 65

#line 65
  result = BoundaryM$BoundaryI$get_nbrtbl_size();
#line 65

#line 65
  return result;
#line 65
}
#line 65
# 59 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint8_t BoundaryM$BoundaryI$get_tos_data_length(void)
#line 59
{
  return 55;
}

# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  uint8_t XMeshC$BoundaryI$get_tos_data_length(void){
#line 22
  unsigned char result;
#line 22

#line 22
  result = BoundaryM$BoundaryI$get_tos_data_length();
#line 22

#line 22
  return result;
#line 22
}
#line 22
# 271 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  void BoundaryM$BoundaryI$set_nbrtbl_flags(uint8_t iIndex, uint8_t value)
#line 271
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 272
    BoundaryM$NeighborTbl[iIndex].flags = value;
    }
#line 272
  ;
}

# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_nbrtbl_flags(uint8_t arg_0x1abac338, uint8_t arg_0x1abac4c0){
#line 60
  BoundaryM$BoundaryI$set_nbrtbl_flags(arg_0x1abac338, arg_0x1abac4c0);
#line 60
}
#line 60
# 265 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  void BoundaryM$BoundaryI$set_nbrtbl_received(uint8_t iIndex, uint16_t value)
#line 265
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 266
    BoundaryM$NeighborTbl[iIndex].received = value;
    }
#line 266
  ;
}

# 58 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_nbrtbl_received(uint8_t arg_0x1ab90638, uint16_t arg_0x1ab907c8){
#line 58
  BoundaryM$BoundaryI$set_nbrtbl_received(arg_0x1ab90638, arg_0x1ab907c8);
#line 58
}
#line 58
# 302 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  void BoundaryM$BoundaryI$set_dsctbl_from(uint8_t iIndex, uint16_t value)
#line 302
{
  if (iIndex < DESCENDANT_TABLE_SIZE) {
#line 303
    BoundaryM$DscTbl[iIndex].from = value;
    }
#line 303
  ;
}

# 75 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_dsctbl_from(uint8_t arg_0x1aba6330, uint16_t arg_0x1aba64c0){
#line 75
  BoundaryM$BoundaryI$set_dsctbl_from(arg_0x1aba6330, arg_0x1aba64c0);
#line 75
}
#line 75
# 141 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint8_t BoundaryM$BoundaryI$get_tos_cc_channel(void)
#line 141
{








  return TOS_CC2420_CHANNEL;
}

# 32 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  uint8_t XMeshC$BoundaryI$get_tos_cc_channel(void){
#line 32
  unsigned char result;
#line 32

#line 32
  result = BoundaryM$BoundaryI$get_tos_cc_channel();
#line 32

#line 32
  return result;
#line 32
}
#line 32
# 268 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  void BoundaryM$BoundaryI$set_nbrtbl_lastSeqno(uint8_t iIndex, uint16_t value)
#line 268
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 269
    BoundaryM$NeighborTbl[iIndex].lastSeqno = value;
    }
#line 269
  ;
}

# 59 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_nbrtbl_lastSeqno(uint8_t arg_0x1ab90c60, uint16_t arg_0x1ab90df0){
#line 59
  BoundaryM$BoundaryI$set_nbrtbl_lastSeqno(arg_0x1ab90c60, arg_0x1ab90df0);
#line 59
}
#line 59
# 262 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  void BoundaryM$BoundaryI$set_nbrtbl_missed(uint8_t iIndex, uint16_t value)
#line 262
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 263
    BoundaryM$NeighborTbl[iIndex].missed = value;
    }
#line 263
  ;
}

# 57 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_nbrtbl_missed(uint8_t arg_0x1ab90010, uint16_t arg_0x1ab901a0){
#line 57
  BoundaryM$BoundaryI$set_nbrtbl_missed(arg_0x1ab90010, arg_0x1ab901a0);
#line 57
}
#line 57
# 71 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint8_t BoundaryM$BoundaryI$get_power_model(void)
#line 71
{



  return 1;
}

# 23 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  uint8_t XMeshC$BoundaryI$get_power_model(void){
#line 23
  unsigned char result;
#line 23

#line 23
  result = BoundaryM$BoundaryI$get_power_model();
#line 23

#line 23
  return result;
#line 23
}
#line 23
# 98 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint8_t BoundaryM$BoundaryI$get_nbr_advert_threshold(void)
#line 98
{
  return NBR_ADVERT_THRESHOLD;
}

# 25 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  uint8_t XMeshC$BoundaryI$get_nbr_advert_threshold(void){
#line 25
  unsigned char result;
#line 25

#line 25
  result = BoundaryM$BoundaryI$get_nbr_advert_threshold();
#line 25

#line 25
  return result;
#line 25
}
#line 25
# 127 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420Control.nc"
inline static  result_t BoundaryM$CC2420Control$SetRFPower(uint8_t arg_0x1a664d48){
#line 127
  unsigned char result;
#line 127

#line 127
  result = CC2420ControlM$CC2420Control$SetRFPower(arg_0x1a664d48);
#line 127

#line 127
  return result;
#line 127
}
#line 127
# 124 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  void BoundaryM$BoundaryI$set_tos_cc_txpower(uint8_t power)
#line 124
{








  TOS_CC2420_TXPOWER = power;
  BoundaryM$CC2420Control$SetRFPower(power);
}

# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_tos_cc_txpower(uint8_t arg_0x1ab9a828){
#line 33
  BoundaryM$BoundaryI$set_tos_cc_txpower(arg_0x1ab9a828);
#line 33
}
#line 33
# 181 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint16_t BoundaryM$BoundaryI$get_nbrtbl_cost(uint8_t iIndex)
#line 181
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 182
    return BoundaryM$NeighborTbl[iIndex].cost;
    }
  else {
#line 182
    return 0xffff;
    }
#line 182
  ;
}

#line 286
static inline  TableEntry *BoundaryM$BoundaryI$get_nbrtbl_addr(uint8_t iIndex)
#line 286
{
  return (TableEntry *)&BoundaryM$NeighborTbl[iIndex];
}

# 66 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  TableEntry *XMeshC$BoundaryI$get_nbrtbl_addr(uint8_t arg_0x1aba9640){
#line 66
  struct TableEntry *result;
#line 66

#line 66
  result = BoundaryM$BoundaryI$get_nbrtbl_addr(arg_0x1aba9640);
#line 66

#line 66
  return result;
#line 66
}
#line 66
# 296 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint16_t BoundaryM$BoundaryI$get_dsctbl_from(uint8_t iIndex)
#line 296
{
  if (iIndex < DESCENDANT_TABLE_SIZE) {
#line 297
    return BoundaryM$DscTbl[iIndex].from;
    }
  else {
#line 297
    return 0xffff;
    }
#line 297
  ;
}

#line 299
static inline  void BoundaryM$BoundaryI$set_dsctbl_origin(uint8_t iIndex, uint16_t value)
#line 299
{
  if (iIndex < DESCENDANT_TABLE_SIZE) {
#line 300
    BoundaryM$DscTbl[iIndex].origin = value;
    }
#line 300
  ;
}

# 74 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_dsctbl_origin(uint8_t arg_0x1aba8c70, uint16_t arg_0x1aba8e00){
#line 74
  BoundaryM$BoundaryI$set_dsctbl_origin(arg_0x1aba8c70, arg_0x1aba8e00);
#line 74
}
#line 74
# 202 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint8_t BoundaryM$BoundaryI$get_nbrtbl_hop(uint8_t iIndex)
#line 202
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 203
    return BoundaryM$NeighborTbl[iIndex].hop;
    }
  else {
#line 203
    return 0xff;
    }
#line 203
  ;
}

#line 199
static inline  uint8_t BoundaryM$BoundaryI$get_nbrtbl_liveliness(uint8_t iIndex)
#line 199
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 200
    return BoundaryM$NeighborTbl[iIndex].liveliness;
    }
  else {
#line 200
    return 0;
    }
#line 200
  ;
}

#line 56
static inline  TOS_MsgPtr BoundaryM$BoundaryI$xalloc(uint8_t iIndex)
#line 56
{
  return &BoundaryM$gTOSBuffer[iIndex];
}

# 19 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  TOS_MsgPtr XMeshC$BoundaryI$xalloc(uint8_t arg_0x1ab814d8){
#line 19
  struct TOS_Msg *result;
#line 19

#line 19
  result = BoundaryM$BoundaryI$xalloc(arg_0x1ab814d8);
#line 19

#line 19
  return result;
#line 19
}
#line 19
# 205 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint8_t BoundaryM$BoundaryI$get_nbrtbl_receiveEst(uint8_t iIndex)
#line 205
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 206
    return BoundaryM$NeighborTbl[iIndex].receiveEst;
    }
  else {
#line 206
    return 0;
    }
#line 206
  ;
}

#line 108
static inline  uint8_t BoundaryM$BoundaryI$get_tos_cc_txpower(void)
#line 108
{








  return TOS_CC2420_TXPOWER;




  return 0;
}

# 34 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  uint8_t XMeshC$BoundaryI$get_tos_cc_txpower(void){
#line 34
  unsigned char result;
#line 34

#line 34
  result = BoundaryM$BoundaryI$get_tos_cc_txpower();
#line 34

#line 34
  return result;
#line 34
}
#line 34
# 274 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  void BoundaryM$BoundaryI$set_nbrtbl_liveliness(uint8_t iIndex, uint8_t value)
#line 274
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 275
    BoundaryM$NeighborTbl[iIndex].liveliness = value;
    }
#line 275
  ;
}

# 61 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_nbrtbl_liveliness(uint8_t arg_0x1abac958, uint8_t arg_0x1abacae0){
#line 61
  BoundaryM$BoundaryI$set_nbrtbl_liveliness(arg_0x1abac958, arg_0x1abacae0);
#line 61
}
#line 61
# 190 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint16_t BoundaryM$BoundaryI$get_nbrtbl_received(uint8_t iIndex)
#line 190
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 191
    return BoundaryM$NeighborTbl[iIndex].received;
    }
  else {
#line 191
    return 0xffff;
    }
#line 191
  ;
}

#line 280
static inline  void BoundaryM$BoundaryI$set_nbrtbl_receiveEst(uint8_t iIndex, uint8_t value)
#line 280
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 281
    BoundaryM$NeighborTbl[iIndex].receiveEst = value;
    }
#line 281
  ;
}

# 63 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_nbrtbl_receiveEst(uint8_t arg_0x1abab630, uint8_t arg_0x1abab7b8){
#line 63
  BoundaryM$BoundaryI$set_nbrtbl_receiveEst(arg_0x1abab630, arg_0x1abab7b8);
#line 63
}
#line 63
# 321 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  void BoundaryM$BoundaryI$set_fwd_buf_status(uint8_t iIndex, uint8_t status)
#line 321
{
  if (iIndex < FWD_QUEUE_SIZE) {
#line 322
    BoundaryM$FwdBufStatus[iIndex] = status;
    }
}

# 83 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_fwd_buf_status(uint8_t arg_0x1aba5cc8, uint8_t arg_0x1aba5e50){
#line 83
  BoundaryM$BoundaryI$set_fwd_buf_status(arg_0x1aba5cc8, arg_0x1aba5e50);
#line 83
}
#line 83
# 187 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint16_t BoundaryM$BoundaryI$get_nbrtbl_missed(uint8_t iIndex)
#line 187
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 188
    return BoundaryM$NeighborTbl[iIndex].missed;
    }
  else {
#line 188
    return 0xffff;
    }
#line 188
  ;
}

#line 92
static inline  void *BoundaryM$BoundaryI$get_strength(TOS_MsgPtr pMsg)
#line 92
{
  return & pMsg->strength;
}

# 20 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void *XMeshC$BoundaryI$get_strength(TOS_MsgPtr arg_0x1ab819d0){
#line 20
  void *result;
#line 20

#line 20
  result = BoundaryM$BoundaryI$get_strength(arg_0x1ab819d0);
#line 20

#line 20
  return result;
#line 20
}
#line 20
# 68 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint32_t BoundaryM$BoundaryI$get_route_update_interval(void)
#line 68
{
  return TOS_ROUTE_UPDATE;
}

# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  uint32_t XMeshC$BoundaryI$get_route_update_interval(void){
#line 26
  unsigned long result;
#line 26

#line 26
  result = BoundaryM$BoundaryI$get_route_update_interval();
#line 26

#line 26
  return result;
#line 26
}
#line 26
# 175 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint16_t BoundaryM$BoundaryI$get_nbrtbl_id(uint8_t iIndex)
#line 175
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 176
    return BoundaryM$NeighborTbl[iIndex].id;
    }
  else {
#line 176
    return 0xffff;
    }
#line 176
  ;
}






static inline  uint8_t BoundaryM$BoundaryI$get_nbrtbl_childLiveliness(uint8_t iIndex)
#line 184
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 185
    return BoundaryM$NeighborTbl[iIndex].childLiveliness;
    }
  else {
#line 185
    return 0;
    }
#line 185
  ;
}

#line 327
static inline  uint8_t BoundaryM$BoundaryI$get_max_retry(void)
#line 327
{
  return MAX_RETRY;
}

# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  uint8_t XMeshC$BoundaryI$get_max_retry(void){
#line 28
  unsigned char result;
#line 28

#line 28
  result = BoundaryM$BoundaryI$get_max_retry();
#line 28

#line 28
  return result;
#line 28
}
#line 28
# 240 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint8_t BoundaryM$BoundaryI$find_dsctbl_entry(uint16_t id, uint8_t size)
#line 240
{
  uint8_t i;

#line 242
  i = 0;
  while (i < size) {
      if (BoundaryM$DscTbl[i].origin == id) {
#line 244
        return i;
        }
#line 245
      i++;
    }
  return ROUTE_INVALID;
}

#line 196
static inline  uint8_t BoundaryM$BoundaryI$get_nbrtbl_flags(uint8_t iIndex)
#line 196
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 197
    return BoundaryM$NeighborTbl[iIndex].flags;
    }
  else {
#line 197
    return 0;
    }
#line 197
  ;
}

#line 305
static inline  DescendantTbl *BoundaryM$BoundaryI$get_dsctbl_addr(uint8_t iIndex)
#line 305
{
  return (DescendantTbl *)&BoundaryM$DscTbl[iIndex];
}

# 76 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  DescendantTbl *XMeshC$BoundaryI$get_dsctbl_addr(uint8_t arg_0x1aba6b60){
#line 76
  struct __nesc_unnamed4277 *result;
#line 76

#line 76
  result = BoundaryM$BoundaryI$get_dsctbl_addr(arg_0x1aba6b60);
#line 76

#line 76
  return result;
#line 76
}
#line 76
# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  bool BoundaryM$BoundaryI$set_built_from_factory(void)
#line 101
{



  return FALSE;
}

# 30 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  bool XMeshC$BoundaryI$set_built_from_factory(void){
#line 30
  unsigned char result;
#line 30

#line 30
  result = BoundaryM$BoundaryI$set_built_from_factory();
#line 30

#line 30
  return result;
#line 30
}
#line 30
# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint8_t BoundaryM$BoundaryI$get_descendant_table_size(void)
#line 65
{
  return DESCENDANT_TABLE_SIZE;
}

# 29 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  uint8_t XMeshC$BoundaryI$get_descendant_table_size(void){
#line 29
  unsigned char result;
#line 29

#line 29
  result = BoundaryM$BoundaryI$get_descendant_table_size();
#line 29

#line 29
  return result;
#line 29
}
#line 29
# 277 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  void BoundaryM$BoundaryI$set_nbrtbl_hop(uint8_t iIndex, uint8_t value)
#line 277
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 278
    BoundaryM$NeighborTbl[iIndex].hop = value;
    }
#line 278
  ;
}

# 62 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_nbrtbl_hop(uint8_t arg_0x1abab010, uint8_t arg_0x1abab198){
#line 62
  BoundaryM$BoundaryI$set_nbrtbl_hop(arg_0x1abab010, arg_0x1abab198);
#line 62
}
#line 62
# 283 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  void BoundaryM$BoundaryI$set_nbrtbl_sendEst(uint8_t iIndex, uint8_t value)
#line 283
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 284
    BoundaryM$NeighborTbl[iIndex].sendEst = value;
    }
#line 284
  ;
}

# 64 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_nbrtbl_sendEst(uint8_t arg_0x1ababc50, uint8_t arg_0x1ababdd8){
#line 64
  BoundaryM$BoundaryI$set_nbrtbl_sendEst(arg_0x1ababc50, arg_0x1ababdd8);
#line 64
}
#line 64
# 82 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint8_t BoundaryM$BoundaryI$get_platform(void)
#line 82
{





  return 3;

  return 0;
}

# 24 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  uint8_t XMeshC$BoundaryI$get_platform(void){
#line 24
  unsigned char result;
#line 24

#line 24
  result = BoundaryM$BoundaryI$get_platform();
#line 24

#line 24
  return result;
#line 24
}
#line 24
# 95 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint8_t BoundaryM$BoundaryI$get_ack(TOS_MsgPtr pMsg)
#line 95
{
  return pMsg->ack;
}

# 21 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  uint8_t XMeshC$BoundaryI$get_ack(TOS_MsgPtr arg_0x1ab81e80){
#line 21
  unsigned char result;
#line 21

#line 21
  result = BoundaryM$BoundaryI$get_ack(arg_0x1ab81e80);
#line 21

#line 21
  return result;
#line 21
}
#line 21
# 253 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  void BoundaryM$BoundaryI$set_nbrtbl_parent(uint8_t iIndex, uint16_t value)
#line 253
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 254
    BoundaryM$NeighborTbl[iIndex].parent = value;
    }
#line 254
  ;
}

# 54 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_nbrtbl_parent(uint8_t arg_0x1ab93c40, uint16_t arg_0x1ab93dd0){
#line 54
  BoundaryM$BoundaryI$set_nbrtbl_parent(arg_0x1ab93c40, arg_0x1ab93dd0);
#line 54
}
#line 54
# 315 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint8_t BoundaryM$BoundaryI$get_fwd_buf_status(uint8_t iIndex)
#line 315
{
  if (iIndex < FWD_QUEUE_SIZE) {
    return BoundaryM$FwdBufStatus[iIndex];
    }
  else {
#line 319
    return 0;
    }
}

# 82 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  uint8_t XMeshC$BoundaryI$get_fwd_buf_status(uint8_t arg_0x1aba5838){
#line 82
  unsigned char result;
#line 82

#line 82
  result = BoundaryM$BoundaryI$get_fwd_buf_status(arg_0x1aba5838);
#line 82

#line 82
  return result;
#line 82
}
#line 82
# 193 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint16_t BoundaryM$BoundaryI$get_nbrtbl_lastSeqno(uint8_t iIndex)
#line 193
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 194
    return BoundaryM$NeighborTbl[iIndex].lastSeqno;
    }
  else {
#line 194
    return 0;
    }
#line 194
  ;
}

#line 208
static inline  uint8_t BoundaryM$BoundaryI$get_nbrtbl_sendEst(uint8_t iIndex)
#line 208
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 209
    return BoundaryM$NeighborTbl[iIndex].sendEst;
    }
  else {
#line 209
    return 0;
    }
#line 209
  ;
}

#line 62
static inline  uint8_t BoundaryM$BoundaryI$get_route_table_size(void)
#line 62
{
  return ROUTE_TABLE_SIZE;
}

# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  uint8_t XMeshC$BoundaryI$get_route_table_size(void){
#line 27
  unsigned char result;
#line 27

#line 27
  result = BoundaryM$BoundaryI$get_route_table_size();
#line 27

#line 27
  return result;
#line 27
}
#line 27
# 250 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  void BoundaryM$BoundaryI$set_nbrtbl_id(uint8_t iIndex, uint16_t value)
#line 250
{
  if (iIndex < ROUTE_TABLE_SIZE) {
#line 251
    BoundaryM$NeighborTbl[iIndex].id = value;
    }
#line 251
  ;
}

# 53 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_nbrtbl_id(uint8_t arg_0x1ab93618, uint16_t arg_0x1ab937a8){
#line 53
  BoundaryM$BoundaryI$set_nbrtbl_id(arg_0x1ab93618, arg_0x1ab937a8);
#line 53
}
#line 53
# 293 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint16_t BoundaryM$BoundaryI$get_dsctbl_origin(uint8_t iIndex)
#line 293
{
  if (iIndex < DESCENDANT_TABLE_SIZE) {
#line 294
    return BoundaryM$DscTbl[iIndex].origin;
    }
  else {
#line 294
    return 0xffff;
    }
#line 294
  ;
}

#line 312
static inline  void BoundaryM$BoundaryI$set_fwd_buf_ptr(uint8_t iIndex, TOS_MsgPtr pMsg)
#line 312
{
  if (iIndex < FWD_QUEUE_SIZE) {
#line 313
    BoundaryM$FwdBufList[iIndex] = pMsg;
    }
}

# 81 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  void XMeshC$BoundaryI$set_fwd_buf_ptr(uint8_t arg_0x1aba51d0, TOS_MsgPtr arg_0x1aba5360){
#line 81
  BoundaryM$BoundaryI$set_fwd_buf_ptr(arg_0x1aba51d0, arg_0x1aba5360);
#line 81
}
#line 81
# 227 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\BoundaryM.nc"
static inline  uint8_t BoundaryM$BoundaryI$find_nbrtbl_entry(uint16_t id)
#line 227
{
  uint8_t i;

#line 229
  for (i = 0; i < ROUTE_TABLE_SIZE; i++) 
    {
      if (BoundaryM$NeighborTbl[i].flags & NBRFLAG_VALID && 
      BoundaryM$NeighborTbl[i].id == id) 
        {
          return i;
        }
    }
  return ROUTE_INVALID;
}

#line 324
static inline  uint8_t BoundaryM$BoundaryI$get_fwd_buf_size(void)
#line 324
{
  return FWD_QUEUE_SIZE;
}

# 84 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
inline  uint8_t XMeshC$BoundaryI$get_fwd_buf_size(void){
#line 84
  unsigned char result;
#line 84

#line 84
  result = BoundaryM$BoundaryI$get_fwd_buf_size();
#line 84

#line 84
  return result;
#line 84
}
#line 84
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
inline  result_t XMeshC$ElpTimer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500){
#line 37
  unsigned char result;
#line 37

#line 37
  result = TimerM$Timer$start(4U, arg_0x1a5d5368, arg_0x1a5d5500);
#line 37

#line 37
  return result;
#line 37
}
#line 37









inline  result_t XMeshC$ElpTimer$stop(void){
#line 46
  unsigned char result;
#line 46

#line 46
  result = TimerM$Timer$stop(4U);
#line 46

#line 46
  return result;
#line 46
}
#line 46
# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline   result_t ShimLayerM$Intercept$default$intercept(uint8_t socket, TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen)
#line 51
{
  return SUCCESS;
}

# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Intercept.nc"
inline static  result_t ShimLayerM$Intercept$intercept(uint8_t arg_0x1abbac00, TOS_MsgPtr arg_0x1ab5a010, void *arg_0x1ab5a1b0, uint16_t arg_0x1ab5a348){
#line 65
  unsigned char result;
#line 65

#line 65
    result = ShimLayerM$Intercept$default$intercept(arg_0x1abbac00, arg_0x1ab5a010, arg_0x1ab5a1b0, arg_0x1ab5a348);
#line 65

#line 65
  return result;
#line 65
}
#line 65
# 47 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline  result_t ShimLayerM$InterceptActual$intercept(uint8_t socket, TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen)
#line 47
{
  ShimLayerM$Intercept$intercept(socket, pMsg, payload, payloadLen);
  return SUCCESS;
}

# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Intercept.nc"
inline  result_t XMeshC$Intercept$intercept(uint8_t arg_0x1ab7aab8, TOS_MsgPtr arg_0x1ab5a010, void *arg_0x1ab5a1b0, uint16_t arg_0x1ab5a348){
#line 65
  unsigned char result;
#line 65

#line 65
  result = ShimLayerM$InterceptActual$intercept(arg_0x1ab7aab8, arg_0x1ab5a010, arg_0x1ab5a1b0, arg_0x1ab5a348);
#line 65

#line 65
  return result;
#line 65
}
#line 65
# 58 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline   result_t ShimLayerM$Snoop$default$intercept(uint8_t socket, TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen)
#line 58
{
  return SUCCESS;
}

# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Intercept.nc"
inline static  result_t ShimLayerM$Snoop$intercept(uint8_t arg_0x1abb8208, TOS_MsgPtr arg_0x1ab5a010, void *arg_0x1ab5a1b0, uint16_t arg_0x1ab5a348){
#line 65
  unsigned char result;
#line 65

#line 65
    result = ShimLayerM$Snoop$default$intercept(arg_0x1abb8208, arg_0x1ab5a010, arg_0x1ab5a1b0, arg_0x1ab5a348);
#line 65

#line 65
  return result;
#line 65
}
#line 65
# 54 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline  result_t ShimLayerM$SnoopActual$intercept(uint8_t socket, TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen)
#line 54
{
  ShimLayerM$Snoop$intercept(socket, pMsg, payload, payloadLen);
  return SUCCESS;
}

# 65 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Intercept.nc"
inline  result_t XMeshC$Snoop$intercept(uint8_t arg_0x1ab780b0, TOS_MsgPtr arg_0x1ab5a010, void *arg_0x1ab5a1b0, uint16_t arg_0x1ab5a348){
#line 65
  unsigned char result;
#line 65

#line 65
  result = ShimLayerM$SnoopActual$intercept(arg_0x1ab780b0, arg_0x1ab5a010, arg_0x1ab5a1b0, arg_0x1ab5a348);
#line 65

#line 65
  return result;
#line 65
}
#line 65
# 42 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Random.nc"
inline   uint16_t XMeshC$Random$rand(void){
#line 42
  unsigned short result;
#line 42

#line 42
  result = RandomLFSR$Random$rand();
#line 42

#line 42
  return result;
#line 42
}
#line 42
#line 36
inline   result_t XMeshC$Random$init(void){
#line 36
  unsigned char result;
#line 36

#line 36
  result = RandomLFSR$Random$init();
#line 36

#line 36
  return result;
#line 36
}
#line 36
# 73 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline   result_t ShimLayerM$Send$default$sendDone(uint8_t socket, TOS_MsgPtr pMsg, result_t success)
#line 73
{
  return SUCCESS;
}

# 68 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Send.nc"
inline static  result_t ShimLayerM$Send$sendDone(uint8_t arg_0x1abb7010, TOS_MsgPtr arg_0x1ab46908, result_t arg_0x1ab46a98){
#line 68
  unsigned char result;
#line 68

#line 68
    result = ShimLayerM$Send$default$sendDone(arg_0x1abb7010, arg_0x1ab46908, arg_0x1ab46a98);
#line 68

#line 68
  return result;
#line 68
}
#line 68
# 69 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline  result_t ShimLayerM$SendActual$sendDone(uint8_t socket, TOS_MsgPtr pMsg, result_t success)
#line 69
{
  ShimLayerM$Send$sendDone(socket, pMsg, success);
  return SUCCESS;
}

# 68 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Send.nc"
inline  result_t XMeshC$Send$sendDone(uint8_t arg_0x1ab7b780, TOS_MsgPtr arg_0x1ab46908, result_t arg_0x1ab46a98){
#line 68
  unsigned char result;
#line 68

#line 68
  result = ShimLayerM$SendActual$sendDone(arg_0x1ab7b780, arg_0x1ab46908, arg_0x1ab46a98);
#line 68

#line 68
  return result;
#line 68
}
#line 68
# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline  result_t XMeshC$BattControl$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = VoltageM$StdControl$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48








inline  result_t XMeshC$BattControl$stop(void){
#line 56
  unsigned char result;
#line 56

#line 56
  result = VoltageM$StdControl$stop();
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 22 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\XOtapLoader.nc"
inline static  result_t ShimLayerM$XOtapLoaderActual$boot(uint8_t arg_0x1ab640b0){
#line 22
  unsigned char result;
#line 22

#line 22
  result = XMeshC$XOtapLoader$boot(arg_0x1ab640b0);
#line 22

#line 22
  return result;
#line 22
}
#line 22
# 140 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline  result_t ShimLayerM$XOtapLoader$boot(uint8_t id)
#line 140
{
  return ShimLayerM$XOtapLoaderActual$boot(id);
}





static inline   result_t ShimLayerM$XOtapLoader$default$boot_request(uint8_t imgID)
#line 148
{
  ShimLayerM$XOtapLoader$boot(imgID);
  return SUCCESS;
}

# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\XOtapLoader.nc"
inline static  result_t ShimLayerM$XOtapLoader$boot_request(uint8_t arg_0x1ab65920){
#line 17
  unsigned char result;
#line 17

#line 17
  result = ShimLayerM$XOtapLoader$default$boot_request(arg_0x1ab65920);
#line 17

#line 17
  return result;
#line 17
}
#line 17
# 144 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline  result_t ShimLayerM$XOtapLoaderActual$boot_request(uint8_t imgID)
#line 144
{
  return ShimLayerM$XOtapLoader$boot_request(imgID);
}

# 17 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\XOtapLoader.nc"
inline  result_t XMeshC$XOtapLoader$boot_request(uint8_t arg_0x1ab65920){
#line 17
  unsigned char result;
#line 17

#line 17
  result = ShimLayerM$XOtapLoaderActual$boot_request(arg_0x1ab65920);
#line 17

#line 17
  return result;
#line 17
}
#line 17
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
inline  result_t XMeshC$EwmaTimer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500){
#line 37
  unsigned char result;
#line 37

#line 37
  result = TimerM$Timer$start(3U, arg_0x1a5d5368, arg_0x1a5d5500);
#line 37

#line 37
  return result;
#line 37
}
#line 37









inline  result_t XMeshC$EwmaTimer$stop(void){
#line 46
  unsigned char result;
#line 46

#line 46
  result = TimerM$Timer$stop(3U);
#line 46

#line 46
  return result;
#line 46
}
#line 46
# 395 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XCommandM.nc"
static inline  TOS_MsgPtr XCommandM$CmdRcv$receive(TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen)
{
  XMeshMsg *cmdMsg = (XMeshMsg *)payload;
  XCommandOp *opcode = & cmdMsg->inst;


  XCommandM$handleCommand(opcode, TOS_LOCAL_ADDRESS);

  return pMsg;
}

# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline   TOS_MsgPtr ShimLayerM$Receive$default$receive(uint8_t socket, TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen)
#line 37
{
  return pMsg;
}

# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
inline static  TOS_MsgPtr ShimLayerM$Receive$receive(uint8_t arg_0x1abba068, TOS_MsgPtr arg_0x1ab42878, void *arg_0x1ab42a18, uint16_t arg_0x1ab42bb0){
#line 60
  struct TOS_Msg *result;
#line 60

#line 60
  switch (arg_0x1abba068) {
#line 60
    case AM_XCOMMAND_MSG:
#line 60
      result = XCommandM$CmdRcv$receive(arg_0x1ab42878, arg_0x1ab42a18, arg_0x1ab42bb0);
#line 60
      break;
#line 60
    default:
#line 60
      result = ShimLayerM$Receive$default$receive(arg_0x1abba068, arg_0x1ab42878, arg_0x1ab42a18, arg_0x1ab42bb0);
#line 60
      break;
#line 60
    }
#line 60

#line 60
  return result;
#line 60
}
#line 60
# 33 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline  TOS_MsgPtr ShimLayerM$ReceiveActual$receive(uint8_t socket, TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen)
#line 33
{
  pMsg = ShimLayerM$Receive$receive(socket, pMsg, payload, payloadLen);
  return pMsg;
}

# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
inline  TOS_MsgPtr XMeshC$Receive$receive(uint8_t arg_0x1ab7bef0, TOS_MsgPtr arg_0x1ab42878, void *arg_0x1ab42a18, uint16_t arg_0x1ab42bb0){
#line 60
  struct TOS_Msg *result;
#line 60

#line 60
  result = ShimLayerM$ReceiveActual$receive(arg_0x1ab7bef0, arg_0x1ab42878, arg_0x1ab42a18, arg_0x1ab42bb0);
#line 60

#line 60
  return result;
#line 60
}
#line 60
# 444 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XCommandM.nc"
static inline  result_t XCommandM$Send$sendDone(TOS_MsgPtr msg, result_t success)
{
  return SUCCESS;
}

# 91 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline   result_t ShimLayerM$MhopSend$default$sendDone(uint8_t socket, TOS_MsgPtr pMsg, result_t success)
#line 91
{
  return SUCCESS;
}

# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
inline static  result_t ShimLayerM$MhopSend$sendDone(uint8_t arg_0x1abb87c0, TOS_MsgPtr arg_0x1ab4a408, result_t arg_0x1ab4a598){
#line 101
  unsigned char result;
#line 101

#line 101
  switch (arg_0x1abb87c0) {
#line 101
    case AM_XCOMMAND_MSG:
#line 101
      result = XCommandM$Send$sendDone(arg_0x1ab4a408, arg_0x1ab4a598);
#line 101
      break;
#line 101
    case AM_XMULTIHOP_MSG:
#line 101
      result = XMDA300M$Send$sendDone(arg_0x1ab4a408, arg_0x1ab4a598);
#line 101
      break;
#line 101
    default:
#line 101
      result = ShimLayerM$MhopSend$default$sendDone(arg_0x1abb87c0, arg_0x1ab4a408, arg_0x1ab4a598);
#line 101
      break;
#line 101
    }
#line 101

#line 101
  return result;
#line 101
}
#line 101
# 86 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline  result_t ShimLayerM$MhopSendActual$sendDone(uint8_t socket, TOS_MsgPtr pMsg, result_t success)
#line 86
{
  ShimLayerM$MhopSend$sendDone(socket, pMsg, success);
  return SUCCESS;
}

# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\MhopSend.nc"
inline  result_t XMeshC$MhopSend$sendDone(uint8_t arg_0x1ab7b010, TOS_MsgPtr arg_0x1ab4a408, result_t arg_0x1ab4a598){
#line 101
  unsigned char result;
#line 101

#line 101
  result = ShimLayerM$MhopSendActual$sendDone(arg_0x1ab7b010, arg_0x1ab4a408, arg_0x1ab4a598);
#line 101

#line 101
  return result;
#line 101
}
#line 101
# 62 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\NoLeds.nc"
static inline   result_t NoLeds$Leds$yellowOff(void)
#line 62
{
  return SUCCESS;
}

# 101 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Leds.nc"
inline static   result_t XMDA300M$Leds$yellowOff(void){
#line 101
  unsigned char result;
#line 101

#line 101
  result = NoLeds$Leds$yellowOff();
#line 101

#line 101
  return result;
#line 101
}
#line 101
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline  result_t XMeshC$GCStdControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = AMPromiscuous$Control$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41







inline  result_t XMeshC$GCStdControl$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = AMPromiscuous$Control$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 166 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\tos.h"
static inline result_t rcombine3(result_t r1, result_t r2, result_t r3)
{
  return rcombine(r1, rcombine(r2, r3));
}

# 19 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\PowerManagement.nc"
inline static   uint8_t AMPromiscuous$PowerManagement$adjustPower(void){
#line 19
  unsigned char result;
#line 19

#line 19
  result = HPLPowerManagementM$PowerManagement$adjustPower();
#line 19

#line 19
  return result;
#line 19
}
#line 19
# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
inline static  result_t AMPromiscuous$ActivityTimer$stop(void){
#line 46
  unsigned char result;
#line 46

#line 46
  result = TimerM$Timer$stop(1U);
#line 46

#line 46
  return result;
#line 46
}
#line 46
# 88 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLCC2420M.nc"
static inline  result_t HPLCC2420M$StdControl$stop(void)
#line 88
{
  HPLCC2420M$HPLCC2420$cmd(0x06);
  HPLCC2420M$HPLCC2420$cmd(0x07);
  return SUCCESS;
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t CC2420ControlM$HPLChipconControl$stop(void){
#line 56
  unsigned char result;
#line 56

#line 56
  result = HPLCC2420M$StdControl$stop();
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 201 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420ControlM.nc"
static inline  result_t CC2420ControlM$StdControl$stop(void)
#line 201
{
  return CC2420ControlM$HPLChipconControl$stop();
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t CC2420RadioM$CC2420StdControl$stop(void){
#line 56
  unsigned char result;
#line 56

#line 56
  result = CC2420ControlM$StdControl$stop();
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 135 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLPowerManagementM.nc"
static inline  result_t HPLPowerManagementM$Enable(void)
#line 135
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 136
    HPLPowerManagementM$disabled = FALSE;
#line 136
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

# 70 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
inline static  uint8_t CC2420RadioM$EnableLowPower(void){
#line 70
  unsigned char result;
#line 70

#line 70
  result = HPLPowerManagementM$Enable();
#line 70

#line 70
  return result;
#line 70
}
#line 70
#line 590
static inline  result_t CC2420RadioM$StdControl$stop(void)
#line 590
{




  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 595
    CC2420RadioM$RadioState = CC2420RadioM$DISABLED_STATE;
#line 595
    __nesc_atomic_end(__nesc_atomic); }
  if (TOS_LOCAL_ADDRESS != 0) {
    CC2420RadioM$EnableLowPower();
    }
  CC2420RadioM$CC2420StdControl$stop();

  ;



  return SUCCESS;
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t AMPromiscuous$RadioControl$stop(void){
#line 56
  unsigned char result;
#line 56

#line 56
  result = CC2420RadioM$StdControl$stop();
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 93 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\HPLUART0M.nc"
static inline   result_t HPLUART0M$UART$stop(void)
#line 93
{
  * (volatile uint8_t *)(0x0B + 0x20) = 0x00;
  * (volatile uint8_t *)(0x0A + 0x20) = 0x00;
  * (volatile uint8_t *)0x95 = 0x00;
  return SUCCESS;
}

# 48 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\HPLUART.nc"
inline static   result_t UARTM$HPLUART$stop(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = HPLUART0M$UART$stop();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 52 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\UARTM.nc"
static inline  result_t UARTM$Control$stop(void)
#line 52
{

  return UARTM$HPLUART$stop();
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t FramerM$ByteControl$stop(void){
#line 56
  unsigned char result;
#line 56

#line 56
  result = UARTM$Control$stop();
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 318 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\FramerM.nc"
static inline  result_t FramerM$StdControl$stop(void)
#line 318
{
  return FramerM$ByteControl$stop();
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline static  result_t AMPromiscuous$UARTControl$stop(void){
#line 56
  unsigned char result;
#line 56

#line 56
  result = FramerM$StdControl$stop();
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 106 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static inline  result_t AMPromiscuous$Control$stop(void)
#line 106
{
  result_t ok1;
#line 107
  result_t ok2;
#line 107
  result_t ok3;

#line 108
  if (AMPromiscuous$state) {
#line 108
    return FALSE;
    }
#line 109
  ok1 = AMPromiscuous$UARTControl$stop();
  ok2 = AMPromiscuous$RadioControl$stop();
  ok3 = AMPromiscuous$ActivityTimer$stop();

  AMPromiscuous$PowerManagement$adjustPower();
  return rcombine3(ok1, ok2, ok3);
}

# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
inline  result_t XMeshC$Window$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500){
#line 37
  unsigned char result;
#line 37

#line 37
  result = TimerM$Timer$start(6U, arg_0x1a5d5368, arg_0x1a5d5500);
#line 37

#line 37
  return result;
#line 37
}
#line 37









inline  result_t XMeshC$Window$stop(void){
#line 46
  unsigned char result;
#line 46

#line 46
  result = TimerM$Timer$stop(6U);
#line 46

#line 46
  return result;
#line 46
}
#line 46
# 1277 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static inline  result_t CC2420RadioM$RadioPower$SetListeningMode(uint8_t power)
#line 1277
{
  return SUCCESS;
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\RadioPower.nc"
inline  result_t XMeshC$RadioPower$SetListeningMode(uint8_t arg_0x1a642378){
#line 56
  unsigned char result;
#line 56

#line 56
  result = CC2420RadioM$RadioPower$SetListeningMode(arg_0x1a642378);
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 1273 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static inline  result_t CC2420RadioM$RadioPower$SetTransmitMode(uint8_t power)
#line 1273
{
  return SUCCESS;
}

# 57 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\RadioPower.nc"
inline  result_t XMeshC$RadioPower$SetTransmitMode(uint8_t arg_0x1a642810){
#line 57
  unsigned char result;
#line 57

#line 57
  result = CC2420RadioM$RadioPower$SetTransmitMode(arg_0x1a642810);
#line 57

#line 57
  return result;
#line 57
}
#line 57
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
inline  result_t XMeshC$ElpTimeOut$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500){
#line 37
  unsigned char result;
#line 37

#line 37
  result = TimerM$Timer$start(5U, arg_0x1a5d5368, arg_0x1a5d5500);
#line 37

#line 37
  return result;
#line 37
}
#line 37









inline  result_t XMeshC$ElpTimeOut$stop(void){
#line 46
  unsigned char result;
#line 46

#line 46
  result = TimerM$Timer$stop(5U);
#line 46

#line 46
  return result;
#line 46
}
#line 46
# 26 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
inline  result_t XMeshC$SendMsg$send(uint8_t arg_0x1ab74010, uint16_t arg_0x1a583670, uint8_t arg_0x1a5837f8, TOS_MsgPtr arg_0x1a583988){
#line 26
  unsigned char result;
#line 26

#line 26
  result = QueuedSendM$QueueSendMsg$send(arg_0x1ab74010, arg_0x1a583670, arg_0x1a5837f8, arg_0x1a583988);
#line 26

#line 26
  return result;
#line 26
}
#line 26
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\Timer.nc"
inline  result_t XMeshC$HealthTimer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500){
#line 37
  unsigned char result;
#line 37

#line 37
  result = TimerM$Timer$start(7U, arg_0x1a5d5368, arg_0x1a5d5500);
#line 37

#line 37
  return result;
#line 37
}
#line 37









inline  result_t XMeshC$HealthTimer$stop(void){
#line 46
  unsigned char result;
#line 46

#line 46
  result = TimerM$Timer$stop(7U);
#line 46

#line 46
  return result;
#line 46
}
#line 46
#line 37
inline  result_t XMeshC$EngineTimer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500){
#line 37
  unsigned char result;
#line 37

#line 37
  result = TimerM$Timer$start(2U, arg_0x1a5d5368, arg_0x1a5d5500);
#line 37

#line 37
  return result;
#line 37
}
#line 37









inline  result_t XMeshC$EngineTimer$stop(void){
#line 46
  unsigned char result;
#line 46

#line 46
  result = TimerM$Timer$stop(2U);
#line 46

#line 46
  return result;
#line 46
}
#line 46
#line 37
inline  result_t XMeshC$XOtapTimer$start(char arg_0x1a5d5368, uint32_t arg_0x1a5d5500){
#line 37
  unsigned char result;
#line 37

#line 37
  result = TimerM$Timer$start(8U, arg_0x1a5d5368, arg_0x1a5d5500);
#line 37

#line 37
  return result;
#line 37
}
#line 37









inline  result_t XMeshC$XOtapTimer$stop(void){
#line 46
  unsigned char result;
#line 46

#line 46
  result = TimerM$Timer$stop(8U);
#line 46

#line 46
  return result;
#line 46
}
#line 46
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline  result_t XMeshC$QueueStdControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = QueuedSendM$StdControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41







inline  result_t XMeshC$QueueStdControl$start(void){
#line 48
  unsigned char result;
#line 48

#line 48
  result = QueuedSendM$StdControl$start();
#line 48

#line 48
  return result;
#line 48
}
#line 48
# 87 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Queue\\QueuedSendM.nc"
static inline  result_t QueuedSendM$StdControl$stop(void)
#line 87
{
  return SUCCESS;
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
inline  result_t XMeshC$QueueStdControl$stop(void){
#line 56
  unsigned char result;
#line 56

#line 56
  result = QueuedSendM$StdControl$stop();
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 131 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static inline  bool AMPromiscuous$CommControl$getPromiscuous(void)
#line 131
{
  return AMPromiscuous$promiscuous_mode;
}

# 49 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\CommControl.nc"
inline  bool XMeshC$GCCommControl$getPromiscuous(void){
#line 49
  unsigned char result;
#line 49

#line 49
  result = AMPromiscuous$CommControl$getPromiscuous();
#line 49

#line 49
  return result;
#line 49
}
#line 49
# 117 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static inline  result_t AMPromiscuous$CommControl$setCRCCheck(bool value)
#line 117
{
  AMPromiscuous$crc_check = value;
  return SUCCESS;
}

# 29 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\CommControl.nc"
inline  result_t XMeshC$GCCommControl$setCRCCheck(bool arg_0x1a550210){
#line 29
  unsigned char result;
#line 29

#line 29
  result = AMPromiscuous$CommControl$setCRCCheck(arg_0x1a550210);
#line 29

#line 29
  return result;
#line 29
}
#line 29
# 122 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static inline  bool AMPromiscuous$CommControl$getCRCCheck(void)
#line 122
{
  return AMPromiscuous$crc_check;
}

# 34 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\CommControl.nc"
inline  bool XMeshC$GCCommControl$getCRCCheck(void){
#line 34
  unsigned char result;
#line 34

#line 34
  result = AMPromiscuous$CommControl$getCRCCheck();
#line 34

#line 34
  return result;
#line 34
}
#line 34
# 126 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static inline  result_t AMPromiscuous$CommControl$setPromiscuous(bool value)
#line 126
{
  AMPromiscuous$promiscuous_mode = value;
  return SUCCESS;
}

# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\CommControl.nc"
inline  result_t XMeshC$GCCommControl$setPromiscuous(bool arg_0x1a550e60){
#line 44
  unsigned char result;
#line 44

#line 44
  result = AMPromiscuous$CommControl$setPromiscuous(arg_0x1a550e60);
#line 44

#line 44
  return result;
#line 44
}
#line 44
# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline   TOS_MsgPtr ShimLayerM$ReceiveAck$default$receive(uint8_t socket, TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen)
#line 44
{
  return pMsg;
}

# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
inline static  TOS_MsgPtr ShimLayerM$ReceiveAck$receive(uint8_t arg_0x1abba648, TOS_MsgPtr arg_0x1ab42878, void *arg_0x1ab42a18, uint16_t arg_0x1ab42bb0){
#line 60
  struct TOS_Msg *result;
#line 60

#line 60
    result = ShimLayerM$ReceiveAck$default$receive(arg_0x1abba648, arg_0x1ab42878, arg_0x1ab42a18, arg_0x1ab42bb0);
#line 60

#line 60
  return result;
#line 60
}
#line 60
# 40 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline  TOS_MsgPtr ShimLayerM$ReceiveAckActual$receive(uint8_t socket, TOS_MsgPtr pMsg, void *payload, uint16_t payloadLen)
#line 40
{
  pMsg = ShimLayerM$ReceiveAck$receive(socket, pMsg, payload, payloadLen);
  return pMsg;
}

# 60 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\Receive.nc"
inline  TOS_MsgPtr XMeshC$ReceiveAck$receive(uint8_t arg_0x1ab7a500, TOS_MsgPtr arg_0x1ab42878, void *arg_0x1ab42a18, uint16_t arg_0x1ab42bb0){
#line 60
  struct TOS_Msg *result;
#line 60

#line 60
  result = ShimLayerM$ReceiveAckActual$receive(arg_0x1ab7a500, arg_0x1ab42878, arg_0x1ab42a18, arg_0x1ab42bb0);
#line 60

#line 60
  return result;
#line 60
}
#line 60
# 30 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
inline   result_t XMeshC$Batt$getData(void){
#line 30
  unsigned char result;
#line 30

#line 30
  result = ADCREFM$ADC$getData(TOS_ADC_VOLTAGE_PORT);
#line 30

#line 30
  return result;
#line 30
}
#line 30
# 229 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCREFM.nc"
static inline   result_t ADCREFM$ADC$getContinuousData(uint8_t port)
#line 229
{
  result_t Result = SUCCESS;

  if (port > TOSH_ADC_PORTMAPSIZE) {
      return FAIL;
    }
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 235
    {
      ADCREFM$ContReqMask |= 1 << port;
      Result = ADCREFM$startGet(port);
      if (Result == FAIL) {
          ADCREFM$ContReqMask ^= 1 << port;
        }
    }
#line 241
    __nesc_atomic_end(__nesc_atomic); }
  return Result;
}

# 135 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline   result_t ShimLayerM$ElpI$default$wake_done(result_t status)
{
  return status;
}

# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ElpI.nc"
inline static  result_t ShimLayerM$ElpI$wake_done(result_t arg_0x1ab55a30){
#line 31
  unsigned char result;
#line 31

#line 31
  result = ShimLayerM$ElpI$default$wake_done(arg_0x1ab55a30);
#line 31

#line 31
  return result;
#line 31
}
#line 31
# 129 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline  result_t ShimLayerM$ElpIActual$wake_done(result_t status)
{
  ShimLayerM$ElpI$wake_done(status);
  return status;
}

# 31 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ElpI.nc"
inline  result_t XMeshC$ElpI$wake_done(result_t arg_0x1ab55a30){
#line 31
  unsigned char result;
#line 31

#line 31
  result = ShimLayerM$ElpIActual$wake_done(arg_0x1ab55a30);
#line 31

#line 31
  return result;
#line 31
}
#line 31
# 125 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline   result_t ShimLayerM$ElpI$default$route_discover_done(result_t success, uint16_t pID)
{
  return SUCCESS;
}

# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ElpI.nc"
inline static  result_t ShimLayerM$ElpI$route_discover_done(result_t arg_0x1ab547e8, uint16_t arg_0x1ab54978){
#line 46
  unsigned char result;
#line 46

#line 46
  result = ShimLayerM$ElpI$default$route_discover_done(arg_0x1ab547e8, arg_0x1ab54978);
#line 46

#line 46
  return result;
#line 46
}
#line 46
# 119 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline  result_t ShimLayerM$ElpIActual$route_discover_done(result_t success, uint16_t pID)
{
  ShimLayerM$ElpI$route_discover_done(success, pID);
  return SUCCESS;
}

# 46 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ElpI.nc"
inline  result_t XMeshC$ElpI$route_discover_done(result_t arg_0x1ab547e8, uint16_t arg_0x1ab54978){
#line 46
  unsigned char result;
#line 46

#line 46
  result = ShimLayerM$ElpIActual$route_discover_done(arg_0x1ab547e8, arg_0x1ab54978);
#line 46

#line 46
  return result;
#line 46
}
#line 46
# 114 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline   result_t ShimLayerM$ElpI$default$sleep_done(result_t status)
{
  return status;
}

# 25 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ElpI.nc"
inline static  result_t ShimLayerM$ElpI$sleep_done(result_t arg_0x1ab55208){
#line 25
  unsigned char result;
#line 25

#line 25
  result = ShimLayerM$ElpI$default$sleep_done(arg_0x1ab55208);
#line 25

#line 25
  return result;
#line 25
}
#line 25
# 109 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XMeshBin\\ShimLayerM.nc"
static inline  result_t ShimLayerM$ElpIActual$sleep_done(result_t status)
{
  ShimLayerM$ElpI$sleep_done(status);
  return status;
}

# 25 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ElpI.nc"
inline  result_t XMeshC$ElpI$sleep_done(result_t arg_0x1ab55208){
#line 25
  unsigned char result;
#line 25

#line 25
  result = ShimLayerM$ElpIActual$sleep_done(arg_0x1ab55208);
#line 25

#line 25
  return result;
#line 25
}
#line 25
# 82 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\sched.c"
 bool TOS_post(void (*tp)(void))
#line 82
{
  __nesc_atomic_t fInterruptFlags;
  uint8_t tmp;



  fInterruptFlags = __nesc_atomic_start();

  tmp = TOSH_sched_free;

  if (TOSH_queue[tmp].tp == (void *)0) {
      TOSH_sched_free = (tmp + 1) & TOSH_TASK_BITMASK;
      TOSH_queue[tmp].tp = tp;
      __nesc_atomic_end(fInterruptFlags);

      return TRUE;
    }
  else {
      __nesc_atomic_end(fInterruptFlags);

      return FALSE;
    }
}

# 34 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\RealMain.nc"
  int main(void)
#line 34
{


  uint8_t local_symbol_ref;

  local_symbol_ref = TOS_PLATFORM;
  local_symbol_ref = TOS_BASE_STATION;
  local_symbol_ref = TOS_DATA_LENGTH;

  local_symbol_ref = TOS_ROUTE_PROTOCOL;








  RealMain$hardwareInit();
  RealMain$Pot$init(10);
  TOSH_sched_init();

  RealMain$StdControl$init();
  RealMain$StdControl$start();
  __nesc_enable_interrupt();

  while (1) {
      TOSH_run_task();
    }
}

# 54 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\TimerM.nc"
static  result_t TimerM$StdControl$init(void)
#line 54
{
  TimerM$mState = 0;
  TimerM$setIntervalFlag = 0;
  TimerM$queue_head = TimerM$queue_tail = -1;
  TimerM$queue_size = 0;
  TimerM$mScale = 3;
  TimerM$mInterval = TimerM$maxTimerInterval;
  return TimerM$Clock$setRate(TimerM$mInterval, TimerM$mScale);
}

# 92 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\I2CPacketM.nc"
static  result_t I2CPacketM$StdControl$init(void)
#line 92
{

  I2CPacketM$I2CStdControl$init();
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 95
    {
      I2CPacketM$state = I2CPacketM$IDLE;
      I2CPacketM$index = 0;
    }
#line 98
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

# 105 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLADCM.nc"
static   result_t HPLADCM$ADC$bindPort(uint8_t port, uint8_t adcPort)
#line 105
{

  if (
#line 106
  port < TOSH_ADC_PORTMAPSIZE && 
  port != TOS_ADC_BANDGAP_PORT && 
  port != TOS_ADC_GND_PORT) {
      HPLADCM$init_portmap();
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 110
        HPLADCM$TOSH_adc_portmap[port] = adcPort;
#line 110
        __nesc_atomic_end(__nesc_atomic); }
      return SUCCESS;
    }
  else {
    return FAIL;
    }
}

#line 58
static void HPLADCM$init_portmap(void)
#line 58
{

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 60
    {
      if (HPLADCM$init_portmap_done == FALSE) {
          int i;

#line 63
          for (i = 0; i < TOSH_ADC_PORTMAPSIZE; i++) 
            HPLADCM$TOSH_adc_portmap[i] = i;


          HPLADCM$TOSH_adc_portmap[TOS_ADC_BANDGAP_PORT] = TOSH_ACTUAL_BANDGAP_PORT;
          HPLADCM$TOSH_adc_portmap[TOS_ADC_GND_PORT] = TOSH_ACTUAL_GND_PORT;
          HPLADCM$init_portmap_done = TRUE;
        }
    }
#line 71
    __nesc_atomic_end(__nesc_atomic); }
}

# 78 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCREFM.nc"
static  result_t ADCREFM$ADCControl$init(void)
#line 78
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 79
    {
      ADCREFM$ReqPort = 0;
      ADCREFM$ReqVector = ADCREFM$ContReqMask = ADCREFM$CalReqMask = 0;
      ADCREFM$RefVal = 381;
    }
#line 83
    __nesc_atomic_end(__nesc_atomic); }
  {
  }
#line 84
  ;

  return ADCREFM$HPLADC$init();
}

# 203 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\apps\\xmesh\\XMDA300\\XMDA300M.nc"
static void XMDA300M$initialize(void)
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
    {
      XMDA300M$sleeping = FALSE;
      XMDA300M$sending_packet = FALSE;






      timer_rate = XSENSOR_SAMPLE_RATE + (TOS_LOCAL_ADDRESS % 255 << 2);
    }
#line 216
    __nesc_atomic_end(__nesc_atomic); }
}

# 69 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Queue\\QueuedSendM.nc"
static  result_t QueuedSendM$StdControl$init(void)
#line 69
{
  int i;

#line 71
  for (i = 0; i < QueuedSendM$MESSAGE_QUEUE_SIZE; i++) {
      QueuedSendM$msgqueue[i].length = 0;
      QueuedSendM$msgqueue[i].pMsg = (void *)0;
    }

  QueuedSendM$retransmit = FALSE;

  QueuedSendM$enqueue_next = 0;
  QueuedSendM$dequeue_next = 0;
  QueuedSendM$fQueueIdle = TRUE;
  return SUCCESS;
}

# 72 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static  result_t AMPromiscuous$Control$init(void)
#line 72
{
  result_t ok1;
#line 73
  result_t ok2;

#line 74
  AMPromiscuous$TimerControl$init();
  ok1 = AMPromiscuous$UARTControl$init();
  ok2 = AMPromiscuous$RadioControl$init();
  AMPromiscuous$state = FALSE;
  AMPromiscuous$lastCount = 0;
  AMPromiscuous$counter = 0;
  AMPromiscuous$promiscuous_mode = FALSE;
  AMPromiscuous$crc_check = TRUE;
  {
  }
#line 82
  ;

  return rcombine(ok1, ok2);
}

# 285 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\FramerM.nc"
static void FramerM$HDLCInitialize(void)
#line 285
{
  int i;

#line 287
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 287
    {
      for (i = 0; i < FramerM$HDLC_QUEUESIZE; i++) {
          FramerM$gMsgRcvTbl[i].pMsg = &FramerM$gMsgRcvBuf[i];
          FramerM$gMsgRcvTbl[i].Length = 0;
          FramerM$gMsgRcvTbl[i].Token = 0;
        }
      FramerM$gTxState = FramerM$TXSTATE_IDLE;
      FramerM$gTxByteCnt = 0;
      FramerM$gTxLength = 0;
      FramerM$gTxRunningCRC = 0;
      FramerM$gpTxMsg = (void *)0;

      FramerM$gRxState = FramerM$RXSTATE_NOSYNC;
      FramerM$gRxHeadIndex = 0;
      FramerM$gRxTailIndex = 0;
      FramerM$gRxByteCnt = 0;
      FramerM$gRxRunningCRC = 0;
      FramerM$gpRxBuf = (uint8_t *)FramerM$gMsgRcvTbl[FramerM$gRxHeadIndex].pMsg;
    }
#line 305
    __nesc_atomic_end(__nesc_atomic); }
}

# 38 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\RandomLFSR.nc"
static   result_t RandomLFSR$Random$init(void)
#line 38
{
  {
  }
#line 39
  ;
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 40
    {
      RandomLFSR$shiftReg = 119 * 119 * (TOS_LOCAL_ADDRESS + 1);
      RandomLFSR$initSeed = RandomLFSR$shiftReg;
      RandomLFSR$mask = 137 * 29 * (TOS_LOCAL_ADDRESS + 1);
    }
#line 44
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

# 381 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420ControlM.nc"
static   result_t CC2420ControlM$CC2420Control$disableAutoAck(void)
#line 381
{
  CC2420ControlM$gCurrentParameters[CP_MDMCTRL0] &= ~(1 << 4);
  return CC2420ControlM$HPLChipcon$write(0x11, CC2420ControlM$gCurrentParameters[CP_MDMCTRL0]);
}

# 147 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLCC2420M.nc"
static   result_t HPLCC2420M$HPLCC2420$write(uint8_t addr, uint16_t data)
#line 147
{
  uint8_t status;



  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 152
    {
      HPLCC2420M$bSpiAvail = FALSE;
      TOSH_CLR_CC_CS_PIN();
      * (volatile uint8_t *)(0x0F + 0x20) = addr;
      while (!(* (volatile uint8_t *)(0x0E + 0x20) & 0x80)) {
        }
#line 156
      ;
      status = * (volatile uint8_t *)(0x0F + 0x20);
      if (addr > 0x0E) {
          * (volatile uint8_t *)(0x0F + 0x20) = data >> 8;
          while (!(* (volatile uint8_t *)(0x0E + 0x20) & 0x80)) {
            }
#line 160
          ;
          * (volatile uint8_t *)(0x0F + 0x20) = data & 0xff;
          while (!(* (volatile uint8_t *)(0x0E + 0x20) & 0x80)) {
            }
#line 162
          ;
        }
      HPLCC2420M$bSpiAvail = TRUE;
    }
#line 165
    __nesc_atomic_end(__nesc_atomic); }
  TOSH_SET_CC_CS_PIN();
  return status;
}

# 45 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\InternalEEPROMM.nc"
static  result_t InternalEEPROMM$ReadData$read(uint32_t offset, uint8_t *buffer, uint32_t numBytesRead)
#line 45
{
  uint16_t i;

#line 47
  InternalEEPROMM$pReadBuffer = buffer;
  InternalEEPROMM$readNumBytesRead = (uint16_t )numBytesRead;
  for (i = 0; i < InternalEEPROMM$readNumBytesRead; i += 1) {
      buffer[i] = eeprom_read_byte((uint8_t *)((uint16_t )offset + i));
    }
#line 51
  ;
  InternalEEPROMM$ReadData$readDone(InternalEEPROMM$pReadBuffer, InternalEEPROMM$readNumBytesRead, SUCCESS);
  return SUCCESS;
}

# 132 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\EEPROMConfigM.nc"
static bool EEPROMConfigM$checkBlockCRC(void *pBlock, size_t length)
{
  ParamCRC_t calcCRC;

  calcCRC = * (ParamCRC_t *)pBlock;
  if (length < sizeof(ParamCRC_t )) {
#line 137
    return FALSE;
    }
#line 138
  if (length == sizeof(ParamCRC_t )) {
#line 138
    return TRUE;
    }
#line 139
  if (calcCRC != EEPROMConfigM$calcrc((uint8_t *)pBlock + sizeof(ParamCRC_t ), (uint8_t )(length - sizeof(ParamCRC_t )))) {
    return FALSE;
    }
#line 141
  return TRUE;
}

#line 114
static uint16_t EEPROMConfigM$calcrc(uint8_t *ptr, uint8_t count)
{
  uint16_t crc;

#line 117
  crc = 0;
  while (count-- > 0) 
    crc = crcByte(crc, * ptr++);
  return crc;
}

# 724 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\apps\\xmesh\\XMDA300\\XMDA300M.nc"
static  result_t XMDA300M$XEEControl$restoreDone(result_t result)
{
  if (result) {
      XMDA300M$Timer$stop();
      XMDA300M$Timer$start(TIMER_REPEAT, timer_rate);
    }
  return SUCCESS;
}

# 145 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\TimerM.nc"
static  result_t TimerM$Timer$stop(uint8_t id)
#line 145
{

  if (id >= NUM_TIMERS) {
#line 147
    return FAIL;
    }
#line 148
  if (TimerM$mState & (0x1L << id)) {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 149
        TimerM$mState &= ~(0x1L << id);
#line 149
        __nesc_atomic_end(__nesc_atomic); }
      if (!TimerM$mState) {
          TimerM$setIntervalFlag = 1;
        }
      return SUCCESS;
    }
  return FAIL;
}

#line 75
static  result_t TimerM$Timer$start(uint8_t id, char type, 
uint32_t interval)
#line 76
{
  uint8_t diff;

#line 78
  if (id >= NUM_TIMERS) {
#line 78
    return FAIL;
    }
#line 79
  if (type > TIMER_ONE_SHOT) {
#line 79
    return FAIL;
    }





  if (type == TIMER_REPEAT && interval <= 2) {
#line 86
    return FAIL;
    }
  TimerM$mTimerList[id].ticks = interval;
  TimerM$mTimerList[id].type = type;

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 91
    {
      diff = TimerM$Clock$readCounter();
      interval += diff;
      TimerM$mTimerList[id].ticksLeft = interval;
      TimerM$mState |= 0x1L << id;
      if (interval < TimerM$mInterval) {
          TimerM$mInterval = interval;
          TimerM$Clock$setInterval(TimerM$mInterval);
          TimerM$setIntervalFlag = 0;
          TimerM$PowerManagement$adjustPower();
        }
    }
#line 102
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

# 121 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLPowerManagementM.nc"
static   uint8_t HPLPowerManagementM$PowerManagement$adjustPower(void)
#line 121
{
  uint8_t mcu;

#line 123
  if (!HPLPowerManagementM$disabled) {
    TOS_post(HPLPowerManagementM$doAdjustment);
    }
  else 
#line 125
    {
      mcu = * (volatile uint8_t *)(0x35 + 0x20);
      mcu &= 0xe3;
      mcu |= HPLPowerManagementM$IDLE;
      * (volatile uint8_t *)(0x35 + 0x20) = mcu;
      * (volatile uint8_t *)(0x35 + 0x20) |= 1 << 5;
    }
  return 0;
}

# 49 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
static   result_t RecoverParamsM$Config$default$set(AppParamID_t id, void *buffer, size_t size)
#line 49
{
  int16_t value;

  if (size != sizeof(uint16_t ) && size != sizeof(uint8_t )) {
      return FAIL;
    }
#line 54
  ;


  value = 0;
  nmemcpy(&value, buffer, size < sizeof value ? size : sizeof value);
  if (RecoverParamsM$ConfigInt16$set(id, value)) {
      RecoverParamsM$setParmID = id;
      return SUCCESS;
    }
  if (RecoverParamsM$ConfigInt8$set(id, (uint8_t )(value & 0xFF))) {
      RecoverParamsM$setParmID = id;
      return SUCCESS;
    }
  return FAIL;
}

# 57 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
static  result_t RecoverParamsM$Config$set(AppParamID_t arg_0x1ad73460, void *arg_0x1ad7bcf0, size_t arg_0x1ad7be78){
#line 57
  unsigned char result;
#line 57

#line 57
  switch (arg_0x1ad73460) {
#line 57
    case CONFIG_MOTE_SERIAL:
#line 57
      result = RecoverSystemParamsM$SystemSerialNumber$set(arg_0x1ad7bcf0, arg_0x1ad7be78);
#line 57
      break;
#line 57
    case CONFIG_MOTE_CPU_OSCILLATOR_HZ:
#line 57
      result = RecoverSystemParamsM$SystemCPUOscillatorFrequency$set(arg_0x1ad7bcf0, arg_0x1ad7be78);
#line 57
      break;
#line 57
    case CONFIG_FACTORY_INFO1:
#line 57
      result = RecoverSystemParamsM$CrossbowFactoryInfo1$set(arg_0x1ad7bcf0, arg_0x1ad7be78);
#line 57
      break;
#line 57
    case CONFIG_FACTORY_INFO2:
#line 57
      result = RecoverSystemParamsM$CrossbowFactoryInfo2$set(arg_0x1ad7bcf0, arg_0x1ad7be78);
#line 57
      break;
#line 57
    case CONFIG_FACTORY_INFO3:
#line 57
      result = RecoverSystemParamsM$CrossbowFactoryInfo3$set(arg_0x1ad7bcf0, arg_0x1ad7be78);
#line 57
      break;
#line 57
    case CONFIG_FACTORY_INFO4:
#line 57
      result = RecoverSystemParamsM$CrossbowFactoryInfo4$set(arg_0x1ad7bcf0, arg_0x1ad7be78);
#line 57
      break;
#line 57
    case CONFIG_XMESHAPP_TIMER_RATE:
#line 57
      result = RecoverSystemParamsM$XmeshAppTimerRate$set(arg_0x1ad7bcf0, arg_0x1ad7be78);
#line 57
      break;
#line 57
    default:
#line 57
      result = RecoverParamsM$Config$default$set(arg_0x1ad73460, arg_0x1ad7bcf0, arg_0x1ad7be78);
#line 57
      break;
#line 57
    }
#line 57

#line 57
  return result;
#line 57
}
#line 57
# 187 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\tos.h"
static void *nmemcpy(void *to, const void *from, size_t n)
{
  char *cto = to;
  const char *cfrom = from;

  while (n--) * cto++ = * cfrom++;

  return to;
}

# 312 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420ControlM.nc"
static  result_t CC2420ControlM$CC2420Control$SetRFPower(uint8_t power)
#line 312
{
  result_t value;









  if (
#line 317
  power != 3 && 
  power != 7 && 
  power != 11 && 
  power != 15 && 
  power != 19 && 
  power != 23 && 
  power != 27 && 
  power != 31) {
#line 324
    return FAIL;
    }

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 327
    {
      CC2420ControlM$gCurrentParameters[CP_TXCTRL] = (CC2420ControlM$gCurrentParameters[CP_TXCTRL] & 0xffe0) | (power << 0);
      value = CC2420ControlM$HPLChipcon$write(0x15, CC2420ControlM$gCurrentParameters[CP_TXCTRL]);
    }
#line 330
    __nesc_atomic_end(__nesc_atomic); }

  return value;
}

#line 249
static  result_t CC2420ControlM$CC2420Control$TunePreset(uint8_t chnl)
#line 249
{
  int fsctrl;

  fsctrl = 357 + 5 * (chnl - 11);
  CC2420ControlM$gCurrentParameters[CP_FSCTRL] = (CC2420ControlM$gCurrentParameters[CP_FSCTRL] & 0xfc00) | (fsctrl << 0);
  CC2420ControlM$HPLChipcon$write(0x18, CC2420ControlM$gCurrentParameters[CP_FSCTRL]);
  return SUCCESS;
}

# 152 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\EEPROMConfigM.nc"
static void EEPROMConfigM$setBlockCRC(void *pBlock, size_t length)
{
  if (length < sizeof(ParamCRC_t )) {
#line 154
    return;
    }
#line 155
  * (ParamCRC_t *)pBlock = EEPROMConfigM$calcrc((uint8_t *)pBlock + sizeof(ParamCRC_t ), (uint8_t )(length - sizeof(ParamCRC_t )));
  return;
}

# 59 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\InternalEEPROMM.nc"
static  result_t InternalEEPROMM$WriteData$write(uint32_t offset, uint8_t *buffer, uint32_t numBytesWrite)
#line 59
{
  uint16_t i;

#line 61
  InternalEEPROMM$pWriteBuffer = buffer;
  InternalEEPROMM$writeNumBytesWrite = (uint16_t )numBytesWrite;
  for (i = 0; i < InternalEEPROMM$writeNumBytesWrite; i += 1) {
      eeprom_write_byte((uint8_t *)((uint16_t )offset + i), buffer[i]);
    }
#line 65
  ;
  InternalEEPROMM$WriteData$writeDone(InternalEEPROMM$pWriteBuffer, InternalEEPROMM$writeNumBytesWrite, SUCCESS);
  return SUCCESS;
}

# 161 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\EEPROMConfigM.nc"
static void EEPROMConfigM$writeTrailingParameter(void)
#line 161
{
  EEPROMConfigM$flashTemp.param.paHdr.count = 0;
  EEPROMConfigM$flashTemp.param.paHdr.applicationID = TOS_NO_APPLICATION;
  EEPROMConfigM$flashTemp.param.paHdr.paramID = TOS_NO_PARAMETER;
  EEPROMConfigM$setBlockCRC(& EEPROMConfigM$flashTemp.param.paHdr, sizeof(ParameterHeader_t ));
  EEPROMConfigM$WriteData$write(EEPROMConfigM$currentBlock, &EEPROMConfigM$flashTemp.data[0], sizeof(ParameterHeader_t ));
  return;
}




static void EEPROMConfigM$findNextParameter(void)
#line 173
{
  while (TRUE) {
      uint16_t paramSize;

#line 176
      if (EEPROMConfigM$nextParamID > (uint8_t )EEPROMConfigM$endAppParam) {
#line 176
        return;
        }
#line 177
      paramSize = EEPROMConfigM$Config$get((AppParamID_t )(((uint32_t )((uint32_t )EEPROMConfigM$endAppParam >> 8) << 8) | (ParameterID_t )EEPROMConfigM$nextParamID), &EEPROMConfigM$readBuffer[0], 0);

      if (paramSize != 0) {
#line 179
        return;
        }
#line 180
      EEPROMConfigM$nextParamID += 1;
    }
}

# 82 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\RecoverParamsM.nc"
static   size_t RecoverParamsM$Config$default$get(AppParamID_t id, void *buffer, size_t size)
#line 82
{
  uint16_t value;
  uint8_t short_value;
  AppParamID_t curParmID;
  size_t sizeret;


  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 89
    RecoverParamsM$getParmID = TOS_NO_PARAMETER;
#line 89
    __nesc_atomic_end(__nesc_atomic); }
  value = RecoverParamsM$ConfigInt16$get(id);
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 91
    curParmID = RecoverParamsM$getParmID;
#line 91
    __nesc_atomic_end(__nesc_atomic); }
  if (curParmID != TOS_UNUSED_PARAMETER) {
      nmemcpy(buffer, &value, sizeof(int16_t ));
      curParmID = id;
      sizeret = sizeof(uint16_t );
      return sizeof(int16_t );
    }
#line 97
  ;
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 98
    RecoverParamsM$getParmID = TOS_NO_PARAMETER;
#line 98
    __nesc_atomic_end(__nesc_atomic); }
  short_value = RecoverParamsM$ConfigInt8$get(id);
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 100
    curParmID = RecoverParamsM$getParmID;
#line 100
    __nesc_atomic_end(__nesc_atomic); }
  if (curParmID != TOS_UNUSED_PARAMETER) {
      nmemcpy(buffer, &short_value, sizeof(int8_t ));
      curParmID = id;
      return sizeof(uint8_t );
    }
#line 105
  ;
  return 0;
}

# 43 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\Config.nc"
static  size_t RecoverParamsM$Config$get(AppParamID_t arg_0x1ad73460, void *arg_0x1ad7b6b8, size_t arg_0x1ad7b840){
#line 43
  unsigned int result;
#line 43

#line 43
  switch (arg_0x1ad73460) {
#line 43
    case CONFIG_MOTE_SERIAL:
#line 43
      result = RecoverSystemParamsM$SystemSerialNumber$get(arg_0x1ad7b6b8, arg_0x1ad7b840);
#line 43
      break;
#line 43
    case CONFIG_MOTE_CPU_OSCILLATOR_HZ:
#line 43
      result = RecoverSystemParamsM$SystemCPUOscillatorFrequency$get(arg_0x1ad7b6b8, arg_0x1ad7b840);
#line 43
      break;
#line 43
    case CONFIG_FACTORY_INFO1:
#line 43
      result = RecoverSystemParamsM$CrossbowFactoryInfo1$get(arg_0x1ad7b6b8, arg_0x1ad7b840);
#line 43
      break;
#line 43
    case CONFIG_FACTORY_INFO2:
#line 43
      result = RecoverSystemParamsM$CrossbowFactoryInfo2$get(arg_0x1ad7b6b8, arg_0x1ad7b840);
#line 43
      break;
#line 43
    case CONFIG_FACTORY_INFO3:
#line 43
      result = RecoverSystemParamsM$CrossbowFactoryInfo3$get(arg_0x1ad7b6b8, arg_0x1ad7b840);
#line 43
      break;
#line 43
    case CONFIG_FACTORY_INFO4:
#line 43
      result = RecoverSystemParamsM$CrossbowFactoryInfo4$get(arg_0x1ad7b6b8, arg_0x1ad7b840);
#line 43
      break;
#line 43
    case CONFIG_XMESHAPP_TIMER_RATE:
#line 43
      result = RecoverSystemParamsM$XmeshAppTimerRate$get(arg_0x1ad7b6b8, arg_0x1ad7b840);
#line 43
      break;
#line 43
    default:
#line 43
      result = RecoverParamsM$Config$default$get(arg_0x1ad73460, arg_0x1ad7b6b8, arg_0x1ad7b840);
#line 43
      break;
#line 43
    }
#line 43

#line 43
  return result;
#line 43
}
#line 43
# 146 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XCommandM.nc"
static  result_t XCommandM$ConfigSave$saveDone(result_t success, AppParamID_t failed)
{
  switch (XCommandM$state) {
      case XCommandM$CONFIG_UID: 
        XCommandM$readings.xData.uidData1.nodeid = TOS_LOCAL_ADDRESS;
      XCommandM$readings.xHeader.responseCode = XCMD_RES_SUCCESS;
      XCommandM$state = XCommandM$IDLE;
      XCommandM$nextPacketID = XCommandM$UID_PKT;
      TOS_post(XCommandM$send_msg);
      break;
      case XCommandM$SET_NODEID: 
        XCommandM$readings.xHeader.responseCode = XCMD_RES_SUCCESS;

      XCommandM$readings.xData.nodeid = TOS_LOCAL_ADDRESS;
      XCommandM$state = XCommandM$IDLE;
      XCommandM$nextPacketID = XCommandM$SETNODEID_PKT;
      TOS_post(XCommandM$send_msg);
      break;
      case XCommandM$SET_GROUPID: 
        XCommandM$readings.xHeader.responseCode = XCMD_RES_SUCCESS;
      XCommandM$readings.xData.groupid = TOS_AM_GROUP;
      XCommandM$state = XCommandM$IDLE;
      XCommandM$nextPacketID = XCommandM$SETGROUPID_PKT;
      TOS_post(XCommandM$send_msg);
      break;
      case XCommandM$SET_RFFREQ: 
        XCommandM$readings.xHeader.responseCode = XCMD_RES_SUCCESS;
      XCommandM$Config$get(CONFIG_RF_CHANNEL, & XCommandM$readings.xData.rf_channel, sizeof(uint8_t ));
      XCommandM$state = XCommandM$IDLE;
      XCommandM$nextPacketID = XCommandM$SETFREQ_PKT;
      TOS_post(XCommandM$send_msg);
      break;
      case XCommandM$SET_RFPOWER: 
        XCommandM$readings.xHeader.responseCode = XCMD_RES_SUCCESS;
      TOSH_uwait(5);
      XCommandM$Config$get(CONFIG_RF_POWER, & XCommandM$readings.xData.rfParams.rf_power, sizeof(uint8_t ));
      XCommandM$Config$get(CONFIG_RF_CHANNEL, & XCommandM$readings.xData.rfParams.rf_channel, sizeof(uint8_t ));
      XCommandM$state = XCommandM$IDLE;
      XCommandM$nextPacketID = XCommandM$SETRFPOWER_PKT;
      TOS_post(XCommandM$send_msg);
      break;
      case XCommandM$SET_TIMERRATE: 
        XCommandM$readings.xHeader.responseCode = XCMD_RES_SUCCESS;
      XCommandM$readings.xData.newrate = timer_rate;
      XCommandM$state = XCommandM$IDLE;
      XCommandM$nextPacketID = XCommandM$SETTIMERRATE_PKT;
      TOS_post(XCommandM$send_msg);
      break;
      default: 
        break;
    }
  return SUCCESS;
}

#line 80
static  void XCommandM$send_msg(void)
#line 80
{
  uint8_t i;
  uint16_t len;
  XCmdDataMsg *data;


  data = (XCmdDataMsg *)XCommandM$Send$getBuffer(&XCommandM$msg_buf, &len);

  for (i = 0; i <= sizeof(XCmdDataMsg ) - 1; i++) (
    (uint8_t *)data)[i] = ((uint8_t *)&XCommandM$readings)[i];

  data->xHeader.board_id = 0x62;
  data->xHeader.node_id = TOS_LOCAL_ADDRESS;
  data->xHeader.packet_id = XCommandM$nextPacketID;

  data->xHeader.cmdkey = XCommandM$cmdkey;

  if (XCommandM$Send$send(BASE_STATION_ADDRESS, MODE_UPSTREAM, &XCommandM$msg_buf, sizeof(XCmdDataMsg )) != SUCCESS) {
    }


  return;
}

# 89 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static  result_t AMPromiscuous$Control$start(void)
#line 89
{
  result_t ok0;
#line 90
  result_t ok1;
#line 90
  result_t ok2;
#line 90
  result_t ok3;

  ok0 = AMPromiscuous$TimerControl$start();
  ok1 = AMPromiscuous$UARTControl$start();
  ok2 = AMPromiscuous$RadioControl$start();
  ok3 = AMPromiscuous$ActivityTimer$start(TIMER_REPEAT, 1000);
  AMPromiscuous$PowerManagement$adjustPower();



  AMPromiscuous$state = FALSE;

  return rcombine4(ok0, ok1, ok2, ok3);
}

# 122 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLCC2420M.nc"
static   uint8_t HPLCC2420M$HPLCC2420$cmd(uint8_t addr)
#line 122
{
  uint8_t status;

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 125
    {
      TOSH_CLR_CC_CS_PIN();
      * (volatile uint8_t *)(0x0F + 0x20) = addr;
      while (!(* (volatile uint8_t *)(0x0E + 0x20) & 0x80)) {
        }
#line 128
      ;
      status = * (volatile uint8_t *)(0x0F + 0x20);
    }
#line 130
    __nesc_atomic_end(__nesc_atomic); }
  TOSH_SET_CC_CS_PIN();
  return status;
}

#line 178
static   uint16_t HPLCC2420M$HPLCC2420$read(uint8_t addr)
#line 178
{

  uint16_t data = 0;
  uint8_t status;


  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 184
    {
      HPLCC2420M$bSpiAvail = FALSE;
      TOSH_CLR_CC_CS_PIN();
      * (volatile uint8_t *)(0x0F + 0x20) = addr | 0x40;
      while (!(* (volatile uint8_t *)(0x0E + 0x20) & 0x80)) {
        }
#line 188
      ;
      status = * (volatile uint8_t *)(0x0F + 0x20);
      * (volatile uint8_t *)(0x0F + 0x20) = 0;
      while (!(* (volatile uint8_t *)(0x0E + 0x20) & 0x80)) {
        }
#line 191
      ;
      data = * (volatile uint8_t *)(0x0F + 0x20);
      * (volatile uint8_t *)(0x0F + 0x20) = 0;
      while (!(* (volatile uint8_t *)(0x0E + 0x20) & 0x80)) {
        }
#line 194
      ;
      data = (data << 8) | * (volatile uint8_t *)(0x0F + 0x20);
      TOSH_SET_CC_CS_PIN();
      HPLCC2420M$bSpiAvail = TRUE;
    }
#line 198
    __nesc_atomic_end(__nesc_atomic); }
  return data;
}

#line 103
static   result_t HPLCC2420M$HPLCC2420$enableFIFOP(void)
#line 103
{
  * (volatile uint8_t *)(0x3A + 0x20) &= ~(1 << 4);
  * (volatile uint8_t *)(0x3A + 0x20) &= ~(1 << 5);

  * (volatile uint8_t *)(0x39 + 0x20) |= 1 << 6;
  return SUCCESS;
}

# 233 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
  TOS_MsgPtr prom_received(TOS_MsgPtr packet)
#line 233
{
  AMPromiscuous$counter++;
  {
  }
#line 235
  ;







  if ((
#line 239
  packet->group == TOS_AM_GROUP || packet->group == 0xFF) && ((

  AMPromiscuous$promiscuous_mode == TRUE || 
  packet->addr == TOS_BCAST_ADDR) || 
  packet->addr == TOS_LOCAL_ADDRESS) && (
  AMPromiscuous$crc_check == FALSE || packet->crc == 1)) 
    {
      uint8_t type = packet->type;
      TOS_MsgPtr tmp;


      {
      }
#line 250
      ;
      AMPromiscuous$dbgPacket(packet);
      {
      }
#line 252
      ;


      tmp = AMPromiscuous$ReceiveMsg$receive(type, packet);
      if (tmp) {
        packet = tmp;
        }
    }
#line 259
  return packet;
}

# 121 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\Queue\\QueuedSendM.nc"
static  result_t QueuedSendM$QueueSendMsg$send(uint8_t id, uint16_t address, uint8_t length, TOS_MsgPtr msg)
#line 121
{
  uint8_t ret_val = SUCCESS;

#line 123
  {
  }
#line 123
  ;

  if (length > 55) {
      {
      }
#line 126
      ;
      return FAIL;
    }

  if (msg == (void *)0) {
      {
      }
#line 131
      ;
      return FAIL;
    }

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 135
    {

      if ((QueuedSendM$enqueue_next + 1) % QueuedSendM$MESSAGE_QUEUE_SIZE == QueuedSendM$dequeue_next) {
          {
          }
#line 138
          ;
          ret_val = FAIL;
        }
      else 
#line 140
        {
          QueuedSendM$msgqueue[QueuedSendM$enqueue_next].address = address;
          QueuedSendM$msgqueue[QueuedSendM$enqueue_next].length = length;
          QueuedSendM$msgqueue[QueuedSendM$enqueue_next].id = id;
          QueuedSendM$msgqueue[QueuedSendM$enqueue_next].pMsg = msg;
          QueuedSendM$msgqueue[QueuedSendM$enqueue_next].xmit_count = 0;
          QueuedSendM$msgqueue[QueuedSendM$enqueue_next].pMsg->ack = 0;

          QueuedSendM$enqueue_next++;
#line 148
          QueuedSendM$enqueue_next %= QueuedSendM$MESSAGE_QUEUE_SIZE;

          if (QueuedSendM$fQueueIdle) {
              QueuedSendM$fQueueIdle = FALSE;
              TOS_post(QueuedSendM$QueueServiceTask);
            }
          {
          }
#line 154
          ;
        }
    }
#line 156
    __nesc_atomic_end(__nesc_atomic); }

  return ret_val;
}

#line 99
static  void QueuedSendM$QueueServiceTask(void)
#line 99
{
  uint8_t id;

  if (QueuedSendM$msgqueue[QueuedSendM$dequeue_next].pMsg != (void *)0) {
      QueuedSendM$Leds$greenToggle();
      {
      }
#line 104
      ;
      id = QueuedSendM$msgqueue[QueuedSendM$dequeue_next].id;

      if (!QueuedSendM$SerialSendMsg$send(id, QueuedSendM$msgqueue[QueuedSendM$dequeue_next].address, 
      QueuedSendM$msgqueue[QueuedSendM$dequeue_next].length, 
      QueuedSendM$msgqueue[QueuedSendM$dequeue_next].pMsg)) {

          TOS_post(QueuedSendM$QueueServiceTask);

          {
          }
#line 113
          ;
        }
    }
  else {
      QueuedSendM$fQueueIdle = TRUE;
    }
}

# 156 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\FramerM.nc"
static result_t FramerM$StartTx(void)
#line 156
{
  result_t Result = SUCCESS;
  bool fInitiate = FALSE;

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 160
    {
      if (FramerM$gTxState == FramerM$TXSTATE_IDLE) {
          if (FramerM$gFlags & FramerM$FLAGS_TOKENPEND) {

              FramerM$gpTxBuf = (uint8_t *)&FramerM$gTxTokenBuf;




              FramerM$gTxProto = FramerM$PROTO_ACK;
              FramerM$gTxLength = sizeof FramerM$gTxTokenBuf;
              fInitiate = TRUE;
              FramerM$gTxState = FramerM$TXSTATE_PROTO;
            }
          else {
#line 174
            if (FramerM$gFlags & FramerM$FLAGS_DATAPEND) {
                FramerM$gpTxBuf = (uint8_t *)FramerM$gpTxMsg;
                FramerM$gTxProto = FramerM$PROTO_PACKET_NOACK;


                FramerM$gTxLength = FramerM$gpTxMsg->length + TOS_HEADER_SIZE + 2 + 3;



                fInitiate = TRUE;
                FramerM$gTxState = FramerM$TXSTATE_PROTO;
              }
            else {
#line 186
              if (FramerM$gFlags & FramerM$FLAGS_UNKNOWN) {
                  FramerM$gpTxBuf = (uint8_t *)&FramerM$gTxUnknownBuf;
                  FramerM$gTxProto = FramerM$PROTO_UNKNOWN;
                  FramerM$gTxLength = sizeof FramerM$gTxUnknownBuf;
                  fInitiate = TRUE;
                  FramerM$gTxState = FramerM$TXSTATE_PROTO;
                }
              }
            }
        }
    }
#line 196
    __nesc_atomic_end(__nesc_atomic); }
#line 196
  if (fInitiate) {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 197
        {

          FramerM$gTxRunningCRC = 0;
          FramerM$gTxByteCnt = (size_t )& ((struct TOS_Msg *)0)->addr;
        }
#line 201
        __nesc_atomic_end(__nesc_atomic); }




      Result = FramerM$ByteComm$txByte(FramerM$HDLC_FLAG_BYTE);
      if (Result != SUCCESS) {
          { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 208
            FramerM$gTxState = FramerM$TXSTATE_ERROR;
#line 208
            __nesc_atomic_end(__nesc_atomic); }
          TOS_post(FramerM$PacketSent);
        }
    }

  return Result;
}

# 90 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\UARTM.nc"
static   result_t UARTM$ByteComm$txByte(uint8_t data)
#line 90
{
  bool oldState;

  {
  }
#line 93
  ;

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 95
    {
      oldState = UARTM$state;
      UARTM$state = TRUE;
    }
#line 98
    __nesc_atomic_end(__nesc_atomic); }
  if (oldState) {
    return FAIL;
    }
  UARTM$HPLUART$put(data);

  return SUCCESS;
}

# 263 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\FramerM.nc"
static  void FramerM$PacketSent(void)
#line 263
{
  result_t TxResult = SUCCESS;

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 266
    {
      if (FramerM$gTxState == FramerM$TXSTATE_ERROR) {
          TxResult = FAIL;
          FramerM$gTxState = FramerM$TXSTATE_IDLE;
        }
    }
#line 271
    __nesc_atomic_end(__nesc_atomic); }
  if (FramerM$gTxProto == FramerM$PROTO_ACK) {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 273
        FramerM$gFlags ^= FramerM$FLAGS_TOKENPEND;
#line 273
        __nesc_atomic_end(__nesc_atomic); }
    }
  else {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 276
        FramerM$gFlags ^= FramerM$FLAGS_DATAPEND;
#line 276
        __nesc_atomic_end(__nesc_atomic); }
      FramerM$BareSendMsg$sendDone((TOS_MsgPtr )FramerM$gpTxMsg, TxResult);
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 278
        FramerM$gpTxMsg = (void *)0;
#line 278
        __nesc_atomic_end(__nesc_atomic); }
    }


  FramerM$StartTx();
}

# 150 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\AMPromiscuous.nc"
static result_t AMPromiscuous$reportSendDone(TOS_MsgPtr msg, result_t success)
#line 150
{
  {
  }
#line 151
  ;
  AMPromiscuous$state = FALSE;
  AMPromiscuous$SendMsg$sendDone(msg->type, msg, success);
  AMPromiscuous$sendDone();

  return SUCCESS;
}

# 27 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\SendMsg.nc"
static  result_t QueuedSendM$QueueSendMsg$sendDone(uint8_t arg_0x1ac5b210, TOS_MsgPtr arg_0x1a583e38, result_t arg_0x1a561010){
#line 27
  unsigned char result;
#line 27

#line 27
  result = BcastM$SendMsg$sendDone(arg_0x1ac5b210, arg_0x1a583e38, arg_0x1a561010);
#line 27
  result = rcombine(result, XMeshC$SendMsg$sendDone(arg_0x1ac5b210, arg_0x1a583e38, arg_0x1a561010));
#line 27

#line 27
  return result;
#line 27
}
#line 27
# 49 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\RandomLFSR.nc"
static   uint16_t RandomLFSR$Random$rand(void)
#line 49
{
  bool endbit;
  uint16_t tmpShiftReg;

#line 52
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 52
    {
      tmpShiftReg = RandomLFSR$shiftReg;
      endbit = (tmpShiftReg & 0x8000) != 0;
      tmpShiftReg <<= 1;
      if (endbit) {
        tmpShiftReg ^= 0x100b;
        }
#line 58
      tmpShiftReg++;
      RandomLFSR$shiftReg = tmpShiftReg;
      tmpShiftReg = tmpShiftReg ^ RandomLFSR$mask;
    }
#line 61
    __nesc_atomic_end(__nesc_atomic); }
  return tmpShiftReg;
}

# 658 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static   result_t CC2420RadioM$BackoffTimerJiffy$fired(void)
#line 658
{
  uint8_t cret;
  uint8_t currentstate;

#line 661
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 661
    currentstate = CC2420RadioM$RadioState;
#line 661
    __nesc_atomic_end(__nesc_atomic); }

  switch (CC2420RadioM$stateTimer) {

      case CC2420RadioM$TIMER_INITIAL: 
        CC2420RadioM$stateTimer = CC2420RadioM$TIMER_IDLE;


      CC2420RadioM$HPLChipcon$disableFIFOP();


      cret = CC2420RadioM$fTXPacket(CC2420RadioM$txlength + 1, (uint8_t *)CC2420RadioM$txbufptr);


      if (!cret) {
          { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 676
            CC2420RadioM$RadioState = CC2420RadioM$IDLE_STATE;
#line 676
            __nesc_atomic_end(__nesc_atomic); }
          CC2420RadioM$fSendAborted();
        }
      else 


        {
          CC2420RadioM$sendPacket();
        }


      CC2420RadioM$HPLChipcon$enableFIFOP();
      break;

      case CC2420RadioM$TIMER_BACKOFF: 
        CC2420RadioM$stateTimer = CC2420RadioM$TIMER_IDLE;
      CC2420RadioM$tryToSend();
      break;

      case CC2420RadioM$TIMER_ACK: 
        CC2420RadioM$stateTimer = CC2420RadioM$TIMER_IDLE;
      if (currentstate == CC2420RadioM$POST_TX_STATE) {
          CC2420RadioM$txbufptr->ack = 0;
          if (!TOS_post(CC2420RadioM$PacketSent)) {
              CC2420RadioM$fSendAborted();
            }
        }
      break;


      case CC2420RadioM$TIMER_SNIFF: 
        CC2420RadioM$stateTimer = CC2420RadioM$TIMER_IDLE;
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 708
        CC2420RadioM$gSniffDone = SUCCESS;
#line 708
        __nesc_atomic_end(__nesc_atomic); }
      break;
    }

  return SUCCESS;
}

# 71 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLCC2420FIFOM.nc"
static   result_t HPLCC2420FIFOM$HPLCC2420FIFO$writeTXFIFO(uint8_t len, uint8_t *msg)
#line 71
{
  uint8_t i = 0;
  uint8_t status;



  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 77
    {
      HPLCC2420FIFOM$bSpiAvail = FALSE;
      HPLCC2420FIFOM$txlength = len;
      HPLCC2420FIFOM$txbuf = msg;
      TOSH_CLR_CC_CS_PIN();
      * (volatile uint8_t *)(0x0F + 0x20) = 0x3E;
      while (!(* (volatile uint8_t *)(0x0E + 0x20) & 0x80)) {
        }
#line 83
      ;
      status = * (volatile uint8_t *)(0x0F + 0x20);
      for (i = 0; i < HPLCC2420FIFOM$txlength; i++) {
          * (volatile uint8_t *)(0x0F + 0x20) = *HPLCC2420FIFOM$txbuf;
          HPLCC2420FIFOM$txbuf++;
          while (!(* (volatile uint8_t *)(0x0E + 0x20) & 0x80)) {
            }
#line 88
          ;
        }
      HPLCC2420FIFOM$bSpiAvail = TRUE;
    }
#line 91
    __nesc_atomic_end(__nesc_atomic); }
  TOSH_SET_CC_CS_PIN();




  if (!status) {
    HPLCC2420FIFOM$txlength = status;
    }
#line 99
  return HPLCC2420FIFOM$txlength;
}

# 415 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\radio\\cc2420\\CC2420RadioM.nc"
static void CC2420RadioM$fSendAborted(void)
#line 415
{
  TOS_MsgPtr pBuf;
  uint8_t currentstate;


  CC2420RadioM$HPLChipcon$read(0x3F);
  CC2420RadioM$HPLChipcon$cmd(0x08);
  CC2420RadioM$HPLChipcon$read(0x3F);
  CC2420RadioM$HPLChipcon$cmd(0x08);


  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 426
    currentstate = CC2420RadioM$RadioState;
#line 426
    __nesc_atomic_end(__nesc_atomic); }
  if (currentstate >= CC2420RadioM$PRE_TX_STATE && currentstate <= CC2420RadioM$POST_TX_STATE) {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 428
        {
          CC2420RadioM$txbufptr->time = 0;
          pBuf = CC2420RadioM$txbufptr;

          pBuf->length = pBuf->length - MSG_HEADER_SIZE - MSG_FOOTER_SIZE;
          CC2420RadioM$RadioState = CC2420RadioM$IDLE_STATE;
        }
#line 434
        __nesc_atomic_end(__nesc_atomic); }
      CC2420RadioM$Send$sendDone(pBuf, FAIL);
    }








  CC2420RadioM$HPLChipcon$enableFIFOP();
  return;
}

#line 286
static result_t CC2420RadioM$sendPacket(void)
#line 286
{
  uint8_t status;
  uint16_t fail_count = 0;
  uint8_t currentstate;
  int16_t backoffValue;
  uint8_t offset;

  CC2420RadioM$HPLChipcon$cmd(0x05);


  ;

  status = CC2420RadioM$HPLChipcon$cmd(0x00);
  if ((status >> 3) & 0x01) {

      while (!TOSH_READ_CC_SFD_PIN()) {
          fail_count++;
          TOSH_uwait(5);
          if (fail_count > 1000) {
              CC2420RadioM$fSendAborted();

              ;

              return FAIL;
            }
        }
#line 311
      ;


      CC2420RadioM$RadioSendCoordinator$startSymbol(8, 0, CC2420RadioM$txbufptr);
      offset = (size_t )& ((TOS_Msg *)0)->data;


      CC2420RadioM$HPLChipconFIFO$writeTXFIFO(CC2420RadioM$txlength + 1 - offset, (uint8_t *)CC2420RadioM$txbufptr + offset);

      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 320
        currentstate = CC2420RadioM$RadioState;
#line 320
        __nesc_atomic_end(__nesc_atomic); }
      switch (currentstate) {
          case CC2420RadioM$PRE_TX_STATE: 
            case CC2420RadioM$TX_STATE: 
              { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 324
                CC2420RadioM$RadioState = CC2420RadioM$POST_TX_STATE;
#line 324
                __nesc_atomic_end(__nesc_atomic); }
          CC2420RadioM$HPLChipcon$enableFIFOP();
          CC2420RadioM$txbufptr->ack = 1;


          if ((CC2420RadioM$bAckEnable || CC2420RadioM$bAckManual) && CC2420RadioM$txbufptr->addr != TOS_BCAST_ADDR) {
              CC2420RadioM$txbufptr->ack = 0;
              while (TOSH_READ_CC_SFD_PIN()) {
                }
#line 331
              ;
              if (CC2420RadioM$setAckTimer(2 * 20)) {
                return SUCCESS;
                }
            }





          if (CC2420RadioM$gImmedSendDone) {
              CC2420RadioM$immedPacketSent();
            }
          else 
#line 343
            {
              if (!TOS_post(CC2420RadioM$PacketSent)) {
                  CC2420RadioM$fSendAborted();
                  return FAIL;
                }
            }
          break;

          default: 
            { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 352
              CC2420RadioM$RadioState = CC2420RadioM$IDLE_STATE;
#line 352
              __nesc_atomic_end(__nesc_atomic); }
          CC2420RadioM$HPLChipcon$enableFIFOP();
          return FAIL;
          break;
        }

      return SUCCESS;
    }
  else {

      backoffValue = CC2420RadioM$MacBackoff$congestionBackoff(CC2420RadioM$txbufptr) * 10;
      if (!CC2420RadioM$setBackoffTimer(backoffValue)) {
#line 363
        CC2420RadioM$fSendAborted();
        }
    }
  return SUCCESS;
}

# 93 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\TimerJiffyAsyncM.nc"
static   result_t TimerJiffyAsyncM$TimerJiffyAsync$setOneShot(uint32_t _jiffy)
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 95
    {
      TimerJiffyAsyncM$jiffy = _jiffy;
      TimerJiffyAsyncM$bSet = TRUE;
    }
#line 98
    __nesc_atomic_end(__nesc_atomic); }
  if (_jiffy > 0xFF) {
      TimerJiffyAsyncM$Timer$setIntervalAndScale(0xFF, 0x4);
    }
  else {
      TimerJiffyAsyncM$Timer$setIntervalAndScale(_jiffy, 0x4);
    }

  TimerJiffyAsyncM$PowerManagement$adjustPower();
  return SUCCESS;
}

# 114 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLTimer2.nc"
static   result_t HPLTimer2$Timer2$setIntervalAndScale(uint8_t interval, uint8_t scale)
#line 114
{

  if (scale > 7) {
#line 116
    return FAIL;
    }
#line 117
  scale |= 0x8;
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 118
    {
      * (volatile uint8_t *)(0x25 + 0x20) = 0;
      * (volatile uint8_t *)(0x37 + 0x20) &= ~(1 << 7);
      * (volatile uint8_t *)(0x37 + 0x20) &= ~(1 << 6);
      HPLTimer2$mscale = scale;
      HPLTimer2$minterval = interval;
      * (volatile uint8_t *)(0x24 + 0x20) = 0;
      * (volatile uint8_t *)(0x23 + 0x20) = interval;
      * (volatile uint8_t *)(0x36 + 0x20) |= 1 << 7;
      * (volatile uint8_t *)(0x37 + 0x20) |= 1 << 7;
      * (volatile uint8_t *)(0x25 + 0x20) = scale;
    }
#line 129
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

# 316 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\XCommandM.nc"
static void XCommandM$handleCommand(XCommandOp *opcode, uint16_t addr)
#line 316
{


  if (XCommandM$XCommand$received(opcode) != SUCCESS) {
#line 319
    return;
    }

  XCommandM$cmdkey = opcode->cmdkey;


  switch (opcode->cmd) {

      case XCOMMAND_SLEEP: 
        break;

      case XCOMMAND_WAKEUP: 
        break;

      case XCOMMAND_RESET: 

         __asm volatile ("in __tmp_reg__, __SREG__""\n\t""cli""\n\t""out %0, %1""\n\t""out %0, __zero_reg__""\n\t""out __SREG__,__tmp_reg__""\n\t" :  : "I"((uint16_t )& * (volatile uint8_t *)(0x21 + 0x20) - 0x20), "r"((uint8_t )((1 << 4) | (1 << 3))) : "r0");
       __asm volatile ("in __tmp_reg__,__SREG__""\n\t""cli""\n\t""wdr""\n\t""out %0,%1""\n\t""out __SREG__,__tmp_reg__""\n\t""out %0,%2" :  : "I"((uint16_t )& * (volatile uint8_t *)(0x21 + 0x20) - 0x20), "r"((1 << 4) | (1 << 3)), "r"((uint8_t )(((1 & 0x08 ? 0x00 : 0x00) | (1 << 3)) | (1 & 0x07))) : "r0");while (1) ;
      break;
      break;

      case XCOMMAND_GET_CONFIG: 
        XCommandM$getMyConfig();
      break;


      case XCOMMAND_SET_RATE: 
        XCommandM$Set_TimerRate(& opcode->param.newrate);
      break;

      case XCOMMAND_SET_NODEID: 


        if (addr == 0xFFFF) {
          break;
          }
#line 354
      XCommandM$Set_NodeID(& opcode->param.nodeid);
      break;

      case XCOMMAND_SET_GROUP: 
        XCommandM$Set_GroupID(& opcode->param.group);
      break;

      case XCOMMAND_SET_RF_POWER: 
        XCommandM$Set_RFPOWER(& opcode->param.rf_power);
      break;

      case XCOMMAND_SET_RF_CHANNEL: 
        XCommandM$Set_RFCHANNEL(& opcode->param.rf_channel);
      break;

      case XCOMMAND_CONFIG_UID: 
        XCommandM$Uid_Config(&opcode->param.uidconfig.serialid[0], & opcode->param.uidconfig.nodeid);
      break;



      case XCOMMAND_ACTUATE: {
          uint16_t device = opcode->param.actuate.device;
          uint16_t l_state = opcode->param.actuate.state;

#line 378
          XCommandM$XCommandAcctuate(device, l_state);
          break;
        }

      default: 
        break;
    }
}

# 219 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
static  result_t DioM$Dio$low(uint8_t channel)
{
  if (DIG_OUTPUT & DioM$mode[channel]) 
    {
      DioM$bitmap_low |= 1 << channel;
      TOS_post(DioM$set_io_low);
      return SUCCESS;
    }
  else {
#line 227
    return FALSE;
    }
}

#line 144
static  void DioM$set_io_low(void)
{
  uint8_t status;
  uint8_t i;

#line 148
  status = FALSE;
  if (DioM$state == DioM$IDLE) {
#line 149
    DioM$state = DioM$SET_OUTPUT_LOW;
    }
  else 
#line 150
    {
#line 150
      status = TRUE;
#line 150
      TOS_post(DioM$set_io_low);
    }
#line 151
  if (status == TRUE) {
#line 151
    return;
    }
#line 152
  DioM$i2c_data = DioM$io_value;

  for (i = 0; i <= 7; i++) {
      if (DioM$bitmap_low & (1 << i)) {
          DioM$i2c_data &= ~(1 << i);
        }
      if (!(DioM$mode[i] & DIG_OUTPUT)) {
#line 158
        DioM$i2c_data |= 1 << i;
        }
    }
#line 160
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 160
    DioM$i2cwflag = 1;
#line 160
    __nesc_atomic_end(__nesc_atomic); }
  if (DioM$I2CPacket$writePacket(1, (char *)&DioM$i2c_data, 0x01) == FAIL) 
    {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 163
        DioM$i2cwflag = 0;
#line 163
        __nesc_atomic_end(__nesc_atomic); }
      DioM$state = DioM$IDLE;
      TOS_post(DioM$set_io_low);
    }
  else {
#line 167
    DioM$bitmap_low = 0x0;
    }
}

# 125 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\I2CPacketM.nc"
static  result_t I2CPacketM$I2CPacket$writePacket(uint8_t id, char in_length, char *in_data, char in_flags)
#line 125
{

  uint8_t status;

#line 128
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 128
    {
      status = FALSE;
      if (I2CPacketM$state == I2CPacketM$IDLE) 
        {

          I2CPacketM$addr = id;
          I2CPacketM$data = in_data;
          I2CPacketM$index = 0;
          I2CPacketM$length = in_length;
          I2CPacketM$flags = in_flags;
          I2CPacketM$state = I2CPacketM$I2C_WRITE_ADDRESS;
          status = TRUE;
        }
    }
#line 141
    __nesc_atomic_end(__nesc_atomic); }
  if (status == FALSE) {
      return FAIL;
    }


  if (I2CPacketM$I2C$sendStart()) 
    {
      return SUCCESS;
    }
  else 
    {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 153
        {
#line 153
          I2CPacketM$state = I2CPacketM$IDLE;
        }
#line 154
        __nesc_atomic_end(__nesc_atomic); }
#line 154
      return FAIL;
    }
}

# 173 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\I2CM.nc"
static  result_t I2CM$I2C$sendStart(void)
#line 173
{
  if (I2CM$state != 0) {
    return FAIL;
    }
#line 176
  I2CM$state = I2CM$SEND_START;
  TOS_post(I2CM$I2C_task);
  return SUCCESS;
}

#line 135
static  void I2CM$I2C_task(void)
#line 135
{
  uint8_t current_state = I2CM$state;

#line 137
  I2CM$state = 0;
  if ((current_state & 0xf) == I2CM$READ_DATA) {
      I2CM$I2C$readDone(I2CM$i2c_read());
      if (current_state & 0xf0) {
        I2CM$i2c_ack();
        }
      else {
#line 143
        I2CM$i2c_nack();
        }
    }
  else {
#line 144
    if (current_state == I2CM$WRITE_DATA) {
        I2CM$I2C$writeDone(I2CM$i2c_write(I2CM$local_data));
      }
    else {
#line 146
      if (current_state == I2CM$SEND_START) {
          I2CM$i2c_start();
          I2CM$I2C$sendStartDone();
        }
      else {
#line 149
        if (current_state == I2CM$SEND_END) {
            I2CM$i2c_end();
            I2CM$I2C$sendEndDone();
          }
        }
      }
    }
}

#line 189
static  result_t I2CM$I2C$read(bool ack)
#line 189
{
  if (I2CM$state != 0) {
    return FAIL;
    }
#line 192
  I2CM$state = I2CM$READ_DATA;
  if (ack) {
    I2CM$state |= 0x10;
    }
#line 195
  TOS_post(I2CM$I2C_task);
  return SUCCESS;
}

#line 181
static  result_t I2CM$I2C$sendEnd(void)
#line 181
{
  if (I2CM$state != 0) {
    return FAIL;
    }
#line 184
  I2CM$state = I2CM$SEND_END;
  TOS_post(I2CM$I2C_task);
  return SUCCESS;
}

# 572 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
static  result_t IBADCM$I2CPacket$readPacketDone(char length, char *data)
#line 572
{
  if (IBADCM$i2crflag == 0) {
#line 573
    return SUCCESS;
    }
#line 574
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 574
    IBADCM$i2crflag = 0;
#line 574
    __nesc_atomic_end(__nesc_atomic); }
  if (length != 2) 
    {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 577
        IBADCM$state = IBADCM$IDLE;
#line 577
        __nesc_atomic_end(__nesc_atomic); }
      TOSH_SET_PW6_PIN();
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 579
        {
#line 579
          IBADCM$adc_bitmap &= ~(1 << IBADCM$chan);
        }
#line 580
        __nesc_atomic_end(__nesc_atomic); }
#line 580
      IBADCM$ADConvert$dataReady(IBADCM$chan, 0xffff);
      TOS_post(IBADCM$adc_get_data);
      IBADCM$resetExcitation();
      return FAIL;
    }

  if (IBADCM$state == IBADCM$GET_SAMPLE) 
    {
      IBADCM$value += (data[1] & 0xff) + ((data[0] << 8) & 0x0f00);
      IBADCM$conversionNumber--;


      if (IBADCM$conversionNumber == 0) {
          { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 593
            IBADCM$state = IBADCM$IDLE;
#line 593
            __nesc_atomic_end(__nesc_atomic); }
          if (IBADCM$param[IBADCM$chan] & AVERAGE_SIXTEEN) {
            IBADCM$value = ((IBADCM$value + 8) >> 4) & 0x0fff;
            }
          else {
#line 596
            if (IBADCM$param[IBADCM$chan] & AVERAGE_EIGHT) {
              IBADCM$value = ((IBADCM$value + 4) >> 3) & 0x0fff;
              }
            else {
#line 598
              if (IBADCM$param[IBADCM$chan] & AVERAGE_FOUR) {
                IBADCM$value = ((IBADCM$value + 2) >> 2) & 0x0fff;
                }
              }
            }
#line 601
          TOSH_SET_PW6_PIN();
          { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 602
            IBADCM$samplecount++;
#line 602
            __nesc_atomic_end(__nesc_atomic); }

          if (IBADCM$samplecount != 1) 
            {
              { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 606
                {
#line 606
                  IBADCM$adc_bitmap &= ~(1 << IBADCM$chan);
                }
#line 607
                __nesc_atomic_end(__nesc_atomic); }
#line 607
              IBADCM$ADConvert$dataReady(IBADCM$chan, IBADCM$value);
            }
          TOS_post(IBADCM$adc_get_data);
          IBADCM$resetExcitation();
        }
      else {
          { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 613
            IBADCM$state = IBADCM$CONTINUE_SAMPLE;
#line 613
            __nesc_atomic_end(__nesc_atomic); }
          IBADCM$convert();
        }
    }
  return SUCCESS;
}

#line 378
static   result_t IBADCM$ADConvert$default$dataReady(uint8_t id, uint16_t data)
#line 378
{
  return SUCCESS;
}

# 44 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\ADConvert.nc"
static  result_t IBADCM$ADConvert$dataReady(uint8_t arg_0x1b1694c0, uint16_t arg_0x1afcb010){
#line 44
  unsigned char result;
#line 44

#line 44
  switch (arg_0x1b1694c0) {
#line 44
    case 0:
#line 44
      result = SamplerM$ADC0$dataReady(arg_0x1afcb010);
#line 44
      break;
#line 44
    case 1:
#line 44
      result = SamplerM$ADC1$dataReady(arg_0x1afcb010);
#line 44
      break;
#line 44
    case 2:
#line 44
      result = SamplerM$ADC2$dataReady(arg_0x1afcb010);
#line 44
      break;
#line 44
    case 3:
#line 44
      result = SamplerM$ADC3$dataReady(arg_0x1afcb010);
#line 44
      break;
#line 44
    case 4:
#line 44
      result = SamplerM$ADC4$dataReady(arg_0x1afcb010);
#line 44
      break;
#line 44
    case 5:
#line 44
      result = SamplerM$ADC5$dataReady(arg_0x1afcb010);
#line 44
      break;
#line 44
    case 6:
#line 44
      result = SamplerM$ADC6$dataReady(arg_0x1afcb010);
#line 44
      break;
#line 44
    case 7:
#line 44
      result = SamplerM$ADC7$dataReady(arg_0x1afcb010);
#line 44
      break;
#line 44
    case 8:
#line 44
      result = SamplerM$ADC8$dataReady(arg_0x1afcb010);
#line 44
      break;
#line 44
    case 9:
#line 44
      result = SamplerM$ADC9$dataReady(arg_0x1afcb010);
#line 44
      break;
#line 44
    case 10:
#line 44
      result = SamplerM$ADC10$dataReady(arg_0x1afcb010);
#line 44
      break;
#line 44
    case 11:
#line 44
      result = SamplerM$ADC11$dataReady(arg_0x1afcb010);
#line 44
      break;
#line 44
    case 12:
#line 44
      result = SamplerM$ADC12$dataReady(arg_0x1afcb010);
#line 44
      break;
#line 44
    case 13:
#line 44
      result = SamplerM$ADC13$dataReady(arg_0x1afcb010);
#line 44
      break;
#line 44
    default:
#line 44
      result = IBADCM$ADConvert$default$dataReady(arg_0x1b1694c0, arg_0x1afcb010);
#line 44
      break;
#line 44
    }
#line 44

#line 44
  return result;
#line 44
}
#line 44
# 485 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\apps\\xmesh\\XMDA300\\XMDA300M.nc"
static  
#line 484
result_t 
XMDA300M$Sample$dataReady(uint8_t channel, uint8_t channelType, uint16_t data)
{

  switch (channelType) {
      case ANALOG: 
        switch (channel) {

            case 0: 
              XMDA300M$tmppack = (XDataMsg *)XMDA300M$packet.data;
            XMDA300M$tmppack->xData.datap6.adc0 = data;
            { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 495
              {
#line 495
                XMDA300M$msg_status |= 0x01;
              }
#line 496
              __nesc_atomic_end(__nesc_atomic); }
#line 496
            break;

            case 1: 
              XMDA300M$tmppack = (XDataMsg *)XMDA300M$packet.data;
            XMDA300M$tmppack->xData.datap6.adc1 = data;
            { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 501
              {
#line 501
                XMDA300M$msg_status |= 0x02;
              }
#line 502
              __nesc_atomic_end(__nesc_atomic); }
#line 502
            break;

            case 2: 
              XMDA300M$tmppack = (XDataMsg *)XMDA300M$packet.data;
            XMDA300M$tmppack->xData.datap6.adc2 = data;
            { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 507
              {
#line 507
                XMDA300M$msg_status |= 0x04;
              }
#line 508
              __nesc_atomic_end(__nesc_atomic); }
#line 508
            break;



            default: 
              break;
          }
      break;

      case DIGITAL: 
        switch (channel) {
            case 0: 
              { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 520
                {
                  XMDA300M$tmppack = (XDataMsg *)XMDA300M$packet.data;
                  XMDA300M$tmppack->xData.datap6.dig0 = data;
                  XMDA300M$msg_status |= 0x08;
                }
#line 524
                __nesc_atomic_end(__nesc_atomic); }
#line 524
            break;

            case 1: 
              { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 527
                {
                  XMDA300M$tmppack = (XDataMsg *)XMDA300M$packet.data;
                  XMDA300M$tmppack->xData.datap6.dig1 = data;
                  XMDA300M$msg_status |= 0x10;
                }
#line 531
                __nesc_atomic_end(__nesc_atomic); }
#line 531
            break;

            case 2: 
              { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 534
                {
                  XMDA300M$tmppack = (XDataMsg *)XMDA300M$packet.data;
                  XMDA300M$tmppack->xData.datap6.dig2 = data;
                  XMDA300M$msg_status |= 0x20;
                }
#line 538
                __nesc_atomic_end(__nesc_atomic); }
#line 538
            break;


            default: 
              break;
          }
      break;

      case BATTERY: 
        if (XMDA300M$samplebatt == 0) {
#line 547
          break;
          }
#line 548
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 548
        {
          XMDA300M$samplebatt = 0;
          XMDA300M$tmppack = (XDataMsg *)XMDA300M$packet.data;
          XMDA300M$tmppack->xData.datap6.vref = data;
          XMDA300M$msg_status |= 0x40;
        }
#line 553
        __nesc_atomic_end(__nesc_atomic); }
#line 553
      if (!XMDA300M$bBoardOn) 
        {
          TOS_post(XMDA300M$send_radio_msg);
        }
      break;

      case HUMIDITY: 
        { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 560
          {
            XMDA300M$tmppack = (XDataMsg *)XMDA300M$packet.data;
            XMDA300M$tmppack->xData.datap6.humid = data;
            XMDA300M$msg_status |= 0x80;
          }
#line 564
          __nesc_atomic_end(__nesc_atomic); }
#line 564
      break;

      case TEMPERATURE: 
        { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 567
          {
            XMDA300M$tmppack = (XDataMsg *)XMDA300M$packet.data;
            XMDA300M$tmppack->xData.datap6.humtemp = data;
            XMDA300M$msg_status |= 0x100;
          }
#line 571
          __nesc_atomic_end(__nesc_atomic); }
#line 571
      break;


      default: 
        break;
    }


  if (XMDA300M$sending_packet) {
    return SUCCESS;
    }
  if (XMDA300M$msg_status == XMDA300M$pkt_full) {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 583
        XMDA300M$msg_status = 0;
#line 583
        __nesc_atomic_end(__nesc_atomic); }
      XMDA300M$StdControl$stop();
      TOS_post(XMDA300M$send_radio_msg);
    }

  return SUCCESS;
}

#line 369
static  void XMDA300M$send_radio_msg(void)
{
  uint8_t i;
  uint16_t len;
  XDataMsg *data;

#line 374
  if (XMDA300M$sending_packet) {
    return;
    }
#line 376
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 376
    XMDA300M$sending_packet = TRUE;
#line 376
    __nesc_atomic_end(__nesc_atomic); }

  data = (XDataMsg *)XMDA300M$Send$getBuffer(XMDA300M$msg_ptr, &len);
  XMDA300M$tmppack = (XDataMsg *)XMDA300M$packet.data;
  for (i = 0; i <= sizeof(XDataMsg ) - 1; i++) (
    (uint8_t *)data)[i] = ((uint8_t *)XMDA300M$tmppack)[i];

  if (XMDA300M$bBoardOn) 
    {
      data->xmeshHeader.packet_id = 6;
    }
  else 
    {
      data->xmeshHeader.packet_id = 7;
    }
  data->xmeshHeader.board_id = 0x81;

  data->xmeshHeader.parent = XMDA300M$RouteControl$getParent();
  data->xmeshHeader.packet_id = data->xmeshHeader.packet_id | 0x80;
#line 412
  {

    XMDA300M$Leds$yellowOn();
    if (XMDA300M$Send$send(BASE_STATION_ADDRESS, MODE_UPSTREAM, XMDA300M$msg_ptr, sizeof(XDataMsg )) != SUCCESS) {
        { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 416
          XMDA300M$sending_packet = FALSE;
#line 416
          __nesc_atomic_end(__nesc_atomic); }
        XMDA300M$Leds$yellowOn();
        XMDA300M$Leds$greenOff();
      }
  }
}

#line 349
static  result_t XMDA300M$StdControl$stop(void)
#line 349
{

  int i;

#line 352
  for (i = 0; i < 25; i++) 
    {
      XMDA300M$Sample$stop(i);
    }
  XMDA300M$SamplerControl$stop();

  return SUCCESS;
}

# 210 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
static  void IBADCM$stopchannel(void)
{
  uint16_t myflag;
  uint8_t i;
#line 213
  uint8_t conval;
#line 213
  uint8_t val;
#line 213
  uint8_t alwayson_flag;

#line 214
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 214
    {
      if (IBADCM$scount > 0) {
#line 215
        IBADCM$scount = 0;
        }
#line 216
      myflag = IBADCM$adc_stopbitmap;
      conval = 0;
      alwayson_flag = 0;
    }
#line 219
    __nesc_atomic_end(__nesc_atomic); }

  for (i = 0; i <= 13; i++) 
    {
      if (IBADCM$param[i] & EXCITATION_ALWAYS_ON) 
        {
          alwayson_flag = 1;
          break;
        }
    }
  for (i = 0; i <= 13; i++) 
    {
      if ((myflag & (1 << i)) == 0) 
        {

          if (i != 11) 
            {
              continue;
            }
        }
      switch (i) {
          case 0: 
            conval = 8;
          break;
          case 1: 
            conval = 12;
          break;
          case 2: 
            conval = 9;
          break;
          case 3: 
            conval = 13;
          break;
          case 4: 
            conval = 10;
          break;
          case 5: 
            conval = 14;
          break;
          case 6: 
            conval = 11;
          break;
          case 7: 
            case 8: 
              case 9: 
                case 10: 

                  conval = 15;
          break;
          case 11: 
            conval = 0;
          break;
          case 12: 
            conval = 1;
          break;
          case 13: 
            conval = 2;
          break;
        }

      val = (conval << 4) & 0xf0;
      if (alwayson_flag) 
        {
          val = val | 0x0f;
        }
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 284
        IBADCM$i2cwflag = 3;
#line 284
        __nesc_atomic_end(__nesc_atomic); }
      if (IBADCM$I2CPacket$writePacket(1, (char *)&val, 0x03) == FAIL) 
        {
          { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 287
            {
              IBADCM$i2cwflag = 0;
              if (IBADCM$scount == 0) 
                {
                  TOS_post(IBADCM$stopchannel);
                  IBADCM$scount = 1;
                }
            }
#line 294
            __nesc_atomic_end(__nesc_atomic); }
          TOSH_uwait(10);
        }
      else 
        {
          { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 299
            {
              IBADCM$adc_stopbitmap &= ~(1 << i);
            }
#line 301
            __nesc_atomic_end(__nesc_atomic); }
        }
    }
}

#line 122
static void IBADCM$resetExcitation(void)
{
  uint8_t i;
  uint8_t flag25 = 0;
#line 125
  uint8_t flag33 = 0;
#line 125
  uint8_t flag50 = 0;

#line 126
  for (i = 0; i < 13 + 1; i++) 
    {
      if (IBADCM$param[i] & EXCITATION_ALWAYS_ON) 
        {
          if (IBADCM$param[i] & EXCITATION_25) {
#line 130
            flag25 = 1;
            }
#line 131
          if (IBADCM$param[i] & EXCITATION_33) {
#line 131
            flag33 = 1;
            }
#line 132
          if (IBADCM$param[i] & EXCITATION_50) {
#line 132
            flag50 = 1;
            }
        }
    }
#line 135
  if (flag25 == 0) {
#line 135
    TOSH_CLR_PW2_PIN();
    }
#line 136
  if (flag33 == 0) {
#line 136
    TOSH_CLR_PW3_PIN();
    }
#line 137
  if (flag50 == 0) {
#line 137
    TOSH_CLR_PW5_PIN();
    }
#line 138
  if (!flag25 && !flag33 && !flag50) 
    {
      TOSH_SET_PW1_PIN();
    }
}

#line 382
static  void IBADCM$adc_get_data(void)
{
  uint8_t myIndex;
  uint8_t count;
  uint8_t val;
  uint16_t my_bitmap;

#line 388
  if (IBADCM$state != IBADCM$IDLE) {
#line 388
    return;
    }
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 390
    IBADCM$state = IBADCM$START_CONVERSION_PROCESS;
#line 390
    __nesc_atomic_end(__nesc_atomic); }
  if (IBADCM$sflag == 0) 
    {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 393
        IBADCM$state = IBADCM$IDLE;
#line 393
        __nesc_atomic_end(__nesc_atomic); }
      return;
    }
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 396
    {
      IBADCM$value = 0;
      my_bitmap = IBADCM$adc_bitmap;

      count = 0;
      myIndex = IBADCM$chan + 1;
    }
#line 402
    __nesc_atomic_end(__nesc_atomic); }
  if (myIndex > 13) {
#line 403
    myIndex = 0;
    }
#line 404
  while (!(my_bitmap & (1 << myIndex))) 
    {
      myIndex++;
      if (myIndex > 13) {
#line 407
        myIndex = 0;
        }
#line 408
      count++;
      if (count > 13) {
#line 409
          IBADCM$state = IBADCM$IDLE;
#line 409
          return;
        }
    }
#line 411
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 411
    {
      IBADCM$chan = myIndex;
      IBADCM$setExcitation();
      IBADCM$setNumberOfConversions();
    }
#line 415
    __nesc_atomic_end(__nesc_atomic); }

  if (((IBADCM$chan == 7 || IBADCM$chan == 8) || IBADCM$chan == 9) || IBADCM$chan == 10) 
    {
      char muxChannel;

#line 420
      TOSH_SET_PW6_PIN();
      switch (IBADCM$chan) {
          default: 
            case 7: 
              muxChannel = MUX_CHANNEL_SEVEN;
          break;
          case 8: 
            muxChannel = MUX_CHANNEL_EIGHT;
          break;
          case 9: 
            muxChannel = MUX_CHANNEL_NINE;
          break;
          case 10: 
            muxChannel = MUX_CHANNEL_TEN;
          break;
        }
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 436
        IBADCM$swsetallflag = 1;
#line 436
        __nesc_atomic_end(__nesc_atomic); }
      if (IBADCM$Switch$setAll(muxChannel) == FAIL) 
        {

          { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 440
            {
              IBADCM$swsetallflag = 0;
              IBADCM$state = IBADCM$IDLE;
            }
#line 443
            __nesc_atomic_end(__nesc_atomic); }
          TOSH_SET_PW6_PIN();
          TOS_post(IBADCM$adc_get_data);
          IBADCM$resetExcitation();
        }
    }
  else {


      if (IBADCM$param[IBADCM$chan] & DELAY_BEFORE_MEASUREMENT) {
          IBADCM$PowerStabalizingTimer$start(TIMER_ONE_SHOT, 100);
        }
      else {
          IBADCM$convert();
        }
    }
}

static result_t IBADCM$convert(void)
#line 461
{
  if (IBADCM$state == IBADCM$START_CONVERSION_PROCESS || IBADCM$state == IBADCM$CONTINUE_SAMPLE) 
    {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 464
        IBADCM$state = IBADCM$PICK_CHANNEL;
#line 464
        __nesc_atomic_end(__nesc_atomic); }

      switch (IBADCM$chan) {
          default: 
            case 0: 
              IBADCM$condition = 8;
          break;
          case 1: 
            IBADCM$condition = 12;
          break;
          case 2: 
            IBADCM$condition = 9;
          break;
          case 3: 
            IBADCM$condition = 13;
          break;
          case 4: 
            IBADCM$condition = 10;
          break;
          case 5: 
            IBADCM$condition = 14;
          break;
          case 6: 
            IBADCM$condition = 11;
          break;
          case 7: 
            case 8: 
              case 9: 
                case 10: 

                  IBADCM$condition = 15;
          break;
          case 11: 
            IBADCM$condition = 0;
          break;
          case 12: 
            IBADCM$condition = 1;
          break;
          case 13: 
            IBADCM$condition = 2;
          break;
        }
    }

  IBADCM$condition = (IBADCM$condition << 4) & 0xf0;
  IBADCM$condition = IBADCM$condition | 0x0f;

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 511
    IBADCM$i2cwflag = 1;
#line 511
    __nesc_atomic_end(__nesc_atomic); }
  if (IBADCM$I2CPacket$writePacket(1, (char *)&IBADCM$condition, 0x03) == FAIL) 
    {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 514
        IBADCM$state = IBADCM$IDLE;
#line 514
        __nesc_atomic_end(__nesc_atomic); }
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 515
        IBADCM$i2cwflag = 0;
#line 515
        __nesc_atomic_end(__nesc_atomic); }
      TOSH_uwait(100);
      TOS_post(IBADCM$adc_get_data);
      IBADCM$resetExcitation();
      return FALSE;
    }
  return SUCCESS;
  TOSH_SET_PW6_PIN();
}

# 284 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
static  result_t DioM$I2CPacket$readPacketDone(char length, char *data)
#line 284
{
  uint8_t ChangedState;
  int i;

#line 287
  if (DioM$i2crflag == 0) {
#line 287
    return SUCCESS;
    }
#line 288
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 288
    DioM$i2crflag = 0;
#line 288
    __nesc_atomic_end(__nesc_atomic); }
  DioM$i2c_data = *data;
  if (length != 1) 
    {
      DioM$state = DioM$IDLE;
      * (volatile uint8_t *)(0x39 + 0x20) |= 1 << 4;
      return FALSE;
    }


  if (DioM$state == DioM$INIT) 
    {
      DioM$io_value = DioM$i2c_data;
      DioM$state = DioM$IDLE;
      * (volatile uint8_t *)(0x39 + 0x20) |= 1 << 4;
    }

  if (DioM$state == DioM$GET_DATA) {
      DioM$intflag = 1;
      ChangedState = (DioM$io_value & ~DioM$i2c_data) | (~DioM$io_value & DioM$i2c_data);
      for (i = 0; i < 8; i++) {
          if (!(DioM$mode[i] & DIG_OUTPUT)) {
              if (DioM$mode[i] & DIG_LOGIC) 
                {
                  if ((DioM$i2c_data & (1 << i)) != 0) {
                    DioM$count[i] = 1;
                    }
                  else {
#line 315
                    DioM$count[i] = 0;
                    }
#line 316
                  DioM$Dio$dataReady(i, DioM$count[i]);
                  continue;
                }
              if (ChangedState & (1 << i)) {
                  if (DioM$mode[i] & RISING_EDGE) 
                    {
                      if ((DioM$io_value & (1 << i)) == 0 && (DioM$i2c_data & (1 << i)) != 0) {
                          if (EVENT & DioM$mode[i]) {
#line 323
                            DioM$Dio$dataReady(i, DioM$count[i]);
                            }
                          DioM$count[i]++;
                        }
                    }
                  if (DioM$mode[i] & FALLING_EDGE) 
                    {
                      if ((DioM$io_value & (1 << i)) != 0 && (DioM$i2c_data & (1 << i)) == 0) {
                          if (EVENT & DioM$mode[i]) {
#line 331
                            DioM$Dio$dataReady(i, DioM$count[i]);
                            }
                          DioM$count[i]++;
                        }
                    }
                }
            }
        }
      DioM$io_value = DioM$i2c_data;
      * (volatile uint8_t *)(0x39 + 0x20) |= 1 << 4;
      DioM$state = DioM$IDLE;
    }
  return SUCCESS;
}

#line 239
static   result_t DioM$Dio$default$dataReady(uint8_t channel, uint16_t data)
{
  return SUCCESS;
}

# 28 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\Dio.nc"
static  result_t DioM$Dio$dataReady(uint8_t arg_0x1b1087d0, uint16_t arg_0x1afee368){
#line 28
  unsigned char result;
#line 28

#line 28
  switch (arg_0x1b1087d0) {
#line 28
    case 0:
#line 28
      result = SamplerM$Dio0$dataReady(arg_0x1afee368);
#line 28
      break;
#line 28
    case 1:
#line 28
      result = SamplerM$Dio1$dataReady(arg_0x1afee368);
#line 28
      break;
#line 28
    case 2:
#line 28
      result = SamplerM$Dio2$dataReady(arg_0x1afee368);
#line 28
      break;
#line 28
    case 3:
#line 28
      result = SamplerM$Dio3$dataReady(arg_0x1afee368);
#line 28
      break;
#line 28
    case 4:
#line 28
      result = SamplerM$Dio4$dataReady(arg_0x1afee368);
#line 28
      break;
#line 28
    case 5:
#line 28
      result = SamplerM$Dio5$dataReady(arg_0x1afee368);
#line 28
      break;
#line 28
    case 6:
#line 28
      result = RelayM$Dio6$dataReady(arg_0x1afee368);
#line 28
      break;
#line 28
    case 7:
#line 28
      result = RelayM$Dio7$dataReady(arg_0x1afee368);
#line 28
      break;
#line 28
    default:
#line 28
      result = DioM$Dio$default$dataReady(arg_0x1b1087d0, arg_0x1afee368);
#line 28
      break;
#line 28
    }
#line 28

#line 28
  return result;
#line 28
}
#line 28
# 64 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\I2CM.nc"
static char I2CM$read_bit(void)
#line 64
{
  uint8_t i;

  I2CM$MAKE_DATA_INPUT();
  TOSH_uwait(5);
  I2CM$SET_CLOCK();
  TOSH_uwait(5);
  i = I2CM$GET_DATA();
  I2CM$CLEAR_CLOCK();
  return i;
}

#line 57
static void I2CM$pulse_clock(void)
#line 57
{
  TOSH_uwait(5);
  I2CM$SET_CLOCK();
  TOSH_uwait(5);
  I2CM$CLEAR_CLOCK();
}

# 98 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SwitchM.nc"
static  result_t SwitchM$I2CPacket$writePacketDone(bool result)
#line 98
{
  if (SwitchM$i2cwflag == 0) {
#line 99
    return SUCCESS;
    }
#line 100
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 100
    SwitchM$i2cwflag = 0;
#line 100
    __nesc_atomic_end(__nesc_atomic); }
  if (SwitchM$state == SwitchM$SET_SWITCH) 
    {
      SwitchM$state = SwitchM$IDLE;
      SwitchM$Switch$setDone(result);
    }
  else {
#line 106
    if (SwitchM$state == SwitchM$SET_SWITCH_ALL) {
        SwitchM$state = SwitchM$IDLE;
        SwitchM$Switch$setAllDone(result);
      }
    }
#line 110
  return SUCCESS;
}

# 620 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
static  result_t IBADCM$I2CPacket$writePacketDone(bool result)
#line 620
{
  if (IBADCM$i2cwflag == 0) {
#line 621
    return SUCCESS;
    }
#line 622
  if (IBADCM$i2cwflag != 1) 
    {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 624
        {
          IBADCM$i2cwflag = 0;
        }
#line 626
        __nesc_atomic_end(__nesc_atomic); }
      return SUCCESS;
    }
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 629
    IBADCM$i2cwflag = 0;
#line 629
    __nesc_atomic_end(__nesc_atomic); }
  if (!result) 
    {
      IBADCM$state = IBADCM$IDLE;
      TOSH_SET_PW6_PIN();
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 634
        {
#line 634
          IBADCM$adc_bitmap &= ~(1 << IBADCM$chan);
        }
#line 635
        __nesc_atomic_end(__nesc_atomic); }
#line 635
      IBADCM$ADConvert$dataReady(IBADCM$chan, 0xffff);
      TOS_post(IBADCM$adc_get_data);
      IBADCM$resetExcitation();
      return FAIL;
    }
  if (IBADCM$state == IBADCM$PICK_CHANNEL) 
    {
      IBADCM$state = IBADCM$GET_SAMPLE;
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 643
        IBADCM$i2crflag = 1;
#line 643
        __nesc_atomic_end(__nesc_atomic); }
      if (IBADCM$I2CPacket$readPacket(2, 0x03) == 0) 
        {

          { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 647
            IBADCM$i2crflag = 0;
#line 647
            __nesc_atomic_end(__nesc_atomic); }
          IBADCM$state = IBADCM$IDLE;
          TOS_post(IBADCM$adc_get_data);
          IBADCM$resetExcitation();
          return FAIL;
        }
    }
  return SUCCESS;
}

# 166 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\I2CPacketM.nc"
static  result_t I2CPacketM$I2CPacket$readPacket(uint8_t id, char in_length, 
char in_flags)
#line 167
{
  uint8_t status;

#line 169
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 169
    {
      status = FALSE;
      if (I2CPacketM$state == I2CPacketM$IDLE) 
        {
          I2CPacketM$addr = id;
          I2CPacketM$index = 0;
          I2CPacketM$length = in_length;
          I2CPacketM$flags = in_flags;
          I2CPacketM$state = I2CPacketM$I2C_READ_ADDRESS;
          status = TRUE;
        }
    }
#line 180
    __nesc_atomic_end(__nesc_atomic); }
  if (status == FALSE) {
      return FAIL;
    }

  if (I2CPacketM$I2C$sendStart()) 
    {
      return SUCCESS;
    }
  else 
    {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 191
        {
#line 191
          I2CPacketM$state = I2CPacketM$IDLE;
        }
#line 192
        __nesc_atomic_end(__nesc_atomic); }
#line 192
      return FAIL;
    }
}

# 269 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
static  result_t DioM$I2CPacket$writePacketDone(bool result)
#line 269
{
  if (DioM$i2cwflag == 0) {
#line 270
    return SUCCESS;
    }
#line 271
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 271
    DioM$i2cwflag = 0;
#line 271
    __nesc_atomic_end(__nesc_atomic); }
  if (result) {
      if ((DioM$state == DioM$SET_OUTPUT_HIGH || DioM$state == DioM$SET_OUTPUT_LOW) || DioM$state == DioM$SET_OUTPUT_TOGGLE) {

          DioM$state = DioM$IDLE;
        }
    }



  return SUCCESS;
}

# 199 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\I2CM.nc"
static  result_t I2CM$I2C$write(char data)
#line 199
{
  if (I2CM$state != 0) {
    return FAIL;
    }
#line 202
  I2CM$state = I2CM$WRITE_DATA;
  I2CM$local_data = data;
  TOS_post(I2CM$I2C_task);
  return SUCCESS;
}

# 208 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
static  result_t DioM$Dio$high(uint8_t channel)
{
  if (DIG_OUTPUT & DioM$mode[channel]) 
    {
      DioM$bitmap_high |= 1 << channel;
      TOS_post(DioM$set_io_high);
      return SUCCESS;
    }
  else {
#line 216
    return FALSE;
    }
}

#line 118
static  void DioM$set_io_high(void)
{
  uint8_t status;
  uint8_t i;

#line 122
  status = FALSE;
  if (DioM$state == DioM$IDLE) {
#line 123
    DioM$state = DioM$SET_OUTPUT_HIGH;
    }
  else 
#line 124
    {
#line 124
      status = TRUE;
#line 124
      TOS_post(DioM$set_io_high);
    }
#line 125
  if (status == TRUE) {
#line 125
    return;
    }
#line 126
  DioM$i2c_data = DioM$io_value;
  for (i = 0; i <= 7; i++) {
      if (DioM$bitmap_high & (1 << i)) {
          DioM$i2c_data |= 1 << i;
        }
      if (!(DioM$mode[i] & DIG_OUTPUT)) {
#line 131
        DioM$i2c_data |= 1 << i;
        }
    }
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 134
    DioM$i2cwflag = 1;
#line 134
    __nesc_atomic_end(__nesc_atomic); }
  if (DioM$I2CPacket$writePacket(1, (char *)&DioM$i2c_data, 0x01) == FAIL) 
    {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 137
        DioM$i2cwflag = 0;
#line 137
        __nesc_atomic_end(__nesc_atomic); }
      DioM$state = DioM$IDLE;
      TOS_post(DioM$set_io_high);
    }
  else {
#line 141
    DioM$bitmap_high = 0x0;
    }
}

#line 197
static  result_t DioM$Dio$Toggle(uint8_t channel)
{
  if (DIG_OUTPUT & DioM$mode[channel]) 
    {
      DioM$bitmap_toggle |= 1 << channel;
      TOS_post(DioM$set_io_toggle);
      return SUCCESS;
    }
  else {
#line 205
    return FALSE;
    }
}

#line 170
static  void DioM$set_io_toggle(void)
{
  uint8_t i;

#line 173
  if (DioM$state == DioM$IDLE) {
#line 173
    DioM$state = DioM$SET_OUTPUT_TOGGLE;
    }
  else 
#line 174
    {
#line 174
      TOS_post(DioM$set_io_toggle);
#line 174
      return;
    }
#line 175
  DioM$i2c_data = DioM$io_value;

  for (i = 0; i <= 7; i++) {
      if (DioM$bitmap_toggle & (1 << i)) {
          if (DioM$i2c_data & (1 << i)) {
              DioM$i2c_data &= ~(1 << i);
            }
          else 
#line 181
            {
              DioM$i2c_data |= 1 << i;
            }
        }
      if (!(DioM$mode[i] & DIG_OUTPUT)) {
#line 185
        DioM$i2c_data |= 1 << i;
        }
    }
#line 187
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 187
    DioM$i2cwflag = 1;
#line 187
    __nesc_atomic_end(__nesc_atomic); }
  if (DioM$I2CPacket$writePacket(1, (char *)&DioM$i2c_data, 0x01) == FAIL) 
    {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 190
        DioM$i2cwflag = 0;
#line 190
        __nesc_atomic_end(__nesc_atomic); }
      DioM$state = DioM$IDLE;
      TOS_post(DioM$set_io_toggle);
    }
  else {
#line 194
    DioM$bitmap_toggle = 0x0;
    }
}

# 528 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\lib\\XLib\\EEPROMConfigM.nc"
static  result_t EEPROMConfigM$ConfigSave$save(AppParamID_t startParam, AppParamID_t endParam)
{

  EEPROMConfigM$Leds$redToggle();
  if (EEPROMConfigM$paramState != EEPROMConfigM$PARAM_IDLE) {


      return FAIL;
    }
  if ((uint32_t )startParam >> 8 != (uint32_t )endParam >> 8) {


      return FAIL;
    }

  EEPROMConfigM$endAppParam = endParam;
  EEPROMConfigM$nextParamID = (uint8_t )startParam;
  if ((uint8_t )EEPROMConfigM$endAppParam < EEPROMConfigM$nextParamID) {

      EEPROMConfigM$nextParamID = 0;
      return FAIL;
    }

  EEPROMConfigM$Leds$redToggle();


  EEPROMConfigM$findNextParameter();

  EEPROMConfigM$paramState = EEPROMConfigM$PARAM_SAVE_VERSION;
  EEPROMConfigM$EEPROMstdControl$start();
  EEPROMConfigM$currentBlock = 0;
  EEPROMConfigM$ReadData$read(EEPROMConfigM$currentBlock, &EEPROMConfigM$flashTemp.data[0], sizeof(FlashVersionBlock_t ));
  return SUCCESS;
}

# 88 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\system\\LedsC.nc"
static   result_t LedsC$Leds$greenOff(void)
#line 88
{
  {
  }
#line 89
  ;
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 90
    {
      TOSH_SET_GREEN_LED_PIN();
      LedsC$ledsOn &= ~LedsC$GREEN_BIT;
    }
#line 93
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

#line 79
static   result_t LedsC$Leds$greenOn(void)
#line 79
{
  {
  }
#line 80
  ;
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 81
    {
      TOSH_CLR_GREEN_LED_PIN();
      LedsC$ledsOn |= LedsC$GREEN_BIT;
    }
#line 84
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

#line 59
static   result_t LedsC$Leds$redOff(void)
#line 59
{
  {
  }
#line 60
  ;
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 61
    {
      TOSH_SET_RED_LED_PIN();
      LedsC$ledsOn &= ~LedsC$RED_BIT;
    }
#line 64
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

#line 50
static   result_t LedsC$Leds$redOn(void)
#line 50
{
  {
  }
#line 51
  ;
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 52
    {
      TOSH_CLR_RED_LED_PIN();
      LedsC$ledsOn |= LedsC$RED_BIT;
    }
#line 55
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

#line 117
static   result_t LedsC$Leds$yellowOff(void)
#line 117
{
  {
  }
#line 118
  ;
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 119
    {
      TOSH_SET_YELLOW_LED_PIN();
      LedsC$ledsOn &= ~LedsC$YELLOW_BIT;
    }
#line 122
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

#line 108
static   result_t LedsC$Leds$yellowOn(void)
#line 108
{
  {
  }
#line 109
  ;
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 110
    {
      TOSH_CLR_YELLOW_LED_PIN();
      LedsC$ledsOn |= LedsC$YELLOW_BIT;
    }
#line 113
    __nesc_atomic_end(__nesc_atomic); }
  return SUCCESS;
}

# 202 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLCC2420M.nc"
  __attribute((signal)) void __vector_7(void)
#line 202
{

  HPLCC2420M$HPLCC2420$FIFOPIntr();
}

# 125 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLCC2420FIFOM.nc"
static   result_t HPLCC2420FIFOM$HPLCC2420FIFO$readRXFIFO(uint8_t len, uint8_t *msg)
#line 125
{
  uint8_t status;
#line 126
  uint8_t i;

  /* atomic removed: atomic calls only */

  {
    HPLCC2420FIFOM$bSpiAvail = FALSE;
    HPLCC2420FIFOM$rxbuf = msg;
    HPLCC2420FIFOM$rxlength = len;
    TOSH_CLR_CC_CS_PIN();
    * (volatile uint8_t *)(0x0F + 0x20) = 0x3F | 0x40;
    while (!(* (volatile uint8_t *)(0x0E + 0x20) & 0x80)) {
      }
#line 136
    ;
    status = * (volatile uint8_t *)(0x0F + 0x20);

    i = 0;
    while (TOSH_READ_CC_FIFO_PIN() && i < HPLCC2420FIFOM$rxlength) {
        * (volatile uint8_t *)(0x0F + 0x20) = 0;
        while (!(* (volatile uint8_t *)(0x0E + 0x20) & 0x80)) {
          }
#line 142
        ;
        HPLCC2420FIFOM$rxbuf[i] = * (volatile uint8_t *)(0x0F + 0x20);
        i++;
      }
    HPLCC2420FIFOM$rxlength = i;
    HPLCC2420FIFOM$bSpiAvail = TRUE;
  }
  TOSH_SET_CC_CS_PIN();








  return HPLCC2420FIFOM$rxlength;
}

# 146 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\atm128\\HPLClock.nc"
  __attribute((interrupt)) void __vector_15(void)
#line 146
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 147
    {
      if (HPLClock$set_flag) {
          HPLClock$mscale = HPLClock$nextScale;
          HPLClock$nextScale |= 0x8;
          * (volatile uint8_t *)(0x33 + 0x20) = HPLClock$nextScale;

          * (volatile uint8_t *)(0x31 + 0x20) = HPLClock$minterval;
          HPLClock$set_flag = 0;
        }
    }
#line 156
    __nesc_atomic_end(__nesc_atomic); }
  HPLClock$Clock$fire();
}

# 526 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
static  result_t IBADCM$ADConvert$getData(uint8_t id)
#line 526
{
  if (id > 13) {
#line 527
    return FAIL;
    }
#line 528
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 528
    {
      IBADCM$adc_bitmap |= 1 << id;
      IBADCM$adc_stopbitmap |= 1 << id;
    }
#line 531
    __nesc_atomic_end(__nesc_atomic); }
  TOS_post(IBADCM$adc_get_data);
  return SUCCESS;
}

# 201 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\ADCREFM.nc"
static   result_t ADCREFM$ADC$getData(uint8_t port)
#line 201
{
  result_t Result;

#line 203
  if (port > TOSH_ADC_PORTMAPSIZE) {
      return FAIL;
    }

  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 207
    {
      Result = ADCREFM$startGet(port);
    }
#line 209
    __nesc_atomic_end(__nesc_atomic); }
  return Result;
}

#line 177
static result_t ADCREFM$startGet(uint8_t port)
#line 177
{
  uint16_t PortMask;
#line 178
  uint16_t oldReqVector = 1;
  result_t Result = SUCCESS;

  PortMask = 1 << port;

  if ((PortMask & ADCREFM$ReqVector) != 0) {

      Result = FAIL;
    }
  else {
      oldReqVector = ADCREFM$ReqVector;
      ADCREFM$ReqVector |= PortMask;
      if (oldReqVector == 0) {
          if ((Result = ADCREFM$HPLADC$samplePort(port))) {
              ADCREFM$ReqPort = port;
            }
        }
    }

  return Result;
}

# 117 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLADCM.nc"
static   result_t HPLADCM$ADC$samplePort(uint8_t port)
#line 117
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 118
    {
      * (volatile uint8_t *)(0x07 + 0x20) = HPLADCM$TOSH_adc_portmap[port] & 0x1F;
    }
#line 120
    __nesc_atomic_end(__nesc_atomic); }
  * (volatile uint8_t *)(0x06 + 0x20) |= 1 << 7;
  * (volatile uint8_t *)(0x06 + 0x20) |= 1 << 6;

  return SUCCESS;
}

# 207 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\TempHumM.nc"
static  void TempHumM$initiateTemperature(void)
#line 207
{
  if (TempHumM$state != TempHumM$IDLE) {
      TempHumM$pending_states |= 0x01;
      return;
    }
#line 211
  ;
  TempHumM$state = TempHumM$TEMP_MEASUREMENT;
  TempHumM$processCommand(0x03);
  return;
}


static  void TempHumM$initiateHumidity(void)
#line 218
{
  if (TempHumM$state != TempHumM$IDLE) {
      TempHumM$pending_states |= 0x02;
      return;
    }
#line 222
  ;
  TempHumM$state = TempHumM$HUM_MEASUREMENT;
  TempHumM$processCommand(0x05);
  return;
}

# 230 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
static  result_t DioM$Dio$getData(uint8_t channel)
{
  uint16_t counter;

#line 233
  counter = DioM$count[channel];
  if (RESET_ZERO_AFTER_READ & DioM$mode[channel]) {
#line 234
      DioM$count[channel] = 0;
    }
#line 235
  DioM$Dio$dataReady(channel, counter);
  return SUCCESS;
}

# 119 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static void SamplerM$next_schedule(void)
#line 119
{
  int8_t i;
  int16_t min = 150;

  for (i = 0; i < 25; i++) 
    {
      if (SamplerM$SampleRecord[i].sampling_interval != SAMPLE_RECORD_FREE) 
        {
          if (SamplerM$SampleRecord[i].ticks_left < min) {
#line 127
            min = SamplerM$SampleRecord[i].ticks_left;
            }
        }
    }
#line 130
  for (i = 0; i < 25; i++) 
    {
      if (SamplerM$SampleRecord[i].sampling_interval != SAMPLE_RECORD_FREE) 
        {
          SamplerM$SampleRecord[i].ticks_left = SamplerM$SampleRecord[i].ticks_left - min;
        }
    }
  min = min * 100;
  SamplerM$SamplerTimer$start(TIMER_ONE_SHOT, min);
}

# 64 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\CounterM.nc"
static  result_t CounterM$CounterControl$start(void)
#line 64
{
  TOSH_CLR_PW4_PIN();
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 66
    {

      CounterM$state = 0;
    }
#line 69
    __nesc_atomic_end(__nesc_atomic); }
  * (volatile uint8_t *)(0x39 + 0x20) |= 1 << 5;
  return SUCCESS;
}

# 77 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
static  void DioM$init_io(void)
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 79
    DioM$i2crflag = 1;
#line 79
    __nesc_atomic_end(__nesc_atomic); }
  if (DioM$I2CPacket$readPacket(1, 0x03) == FAIL) 
    {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 82
        DioM$i2crflag = 0;
#line 82
        __nesc_atomic_end(__nesc_atomic); }
      TOS_post(DioM$init_io);
    }
}

# 190 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\IBADCM.nc"
static  void IBADCM$output_ref(void)
{
  uint8_t val;

#line 193
  val = 0x08;
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 194
    IBADCM$i2cwflag = 3;
#line 194
    __nesc_atomic_end(__nesc_atomic); }
  if (IBADCM$I2CPacket$writePacket(1, (char *)&val, 0x03) == FAIL) 
    {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 197
        IBADCM$i2cwflag = 0;
#line 197
        __nesc_atomic_end(__nesc_atomic); }
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 198
        IBADCM$state = IBADCM$IDLE;
#line 198
        __nesc_atomic_end(__nesc_atomic); }
      TOSH_uwait(100);
      TOS_post(IBADCM$output_ref);
      return;
    }
  else 
    {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 205
        IBADCM$sflag = 1;
#line 205
        __nesc_atomic_end(__nesc_atomic); }
      TOS_post(IBADCM$adc_get_data);
    }
}

# 399 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\SamplerM.nc"
static  int8_t SamplerM$Sample$getSample(uint8_t channel, uint8_t channelType, uint16_t interval, uint8_t param)
{
  int8_t i;

#line 402
  i = SamplerM$get_avilable_SampleRecord();
  if (i == -1) {
#line 403
    return i;
    }
#line 404
  SamplerM$SampleRecord[i].channel = channel;
  SamplerM$SampleRecord[i].channelType = channelType;
  SamplerM$SampleRecord[i].ticks_left = 0;
  SamplerM$SampleRecord[i].sampling_interval = interval;

  if (SamplerM$SampleRecord[i].channelType == DIGITAL) {
#line 409
    SamplerM$setparam_digital(i, param);
    }
#line 410
  if (SamplerM$SampleRecord[i].channelType == COUNTER) {
#line 410
    SamplerM$setparam_counter(i, param);
    }
#line 411
  if (SamplerM$SampleRecord[i].channelType == ANALOG) {
#line 411
    SamplerM$setparam_analog(i, param);
    }
#line 412
  return i;
}

# 102 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
static  result_t DioM$Dio$setparam(uint8_t channel, uint8_t modeToSet)
{

  DioM$mode[channel] = modeToSet;
  if (((modeToSet & RISING_EDGE) == 0) & ((modeToSet & FALLING_EDGE) == 0)) {
#line 106
    DioM$mode[channel] |= RISING_EDGE;
    }
#line 107
  if ((modeToSet & DIG_LOGIC) != 0) 
    {
      if (DioM$intflag == 0) 
        {
          DioM$state = DioM$IDLE;
          TOS_post(DioM$read_io);
        }
    }
  return FAIL;
}

#line 253
static  void DioM$read_io(void)
{
  uint8_t status;

#line 256
  status = FALSE;
  if (DioM$state == DioM$IDLE) {
#line 257
    DioM$state = DioM$GET_DATA;
    }
  else 
#line 258
    {
#line 258
      status = TRUE;
#line 258
      TOS_post(DioM$read_io);
    }
#line 259
  if (status == TRUE) {
#line 259
    return;
    }
#line 260
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 260
    DioM$i2crflag = 1;
#line 260
    __nesc_atomic_end(__nesc_atomic); }
  if (DioM$I2CPacket$readPacket(1, 0x03) == FAIL) 
    {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 263
        DioM$i2crflag = 0;
#line 263
        __nesc_atomic_end(__nesc_atomic); }
      DioM$state = DioM$IDLE;
      TOS_post(DioM$read_io);
    }
}

# 169 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLTimer2.nc"
  __attribute((interrupt)) void __vector_9(void)
#line 169
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 170
    {
      if (HPLTimer2$set_flag) {
          HPLTimer2$mscale = HPLTimer2$nextScale;
          HPLTimer2$nextScale |= 0x8;
          * (volatile uint8_t *)(0x25 + 0x20) = HPLTimer2$nextScale;
          * (volatile uint8_t *)(0x23 + 0x20) = HPLTimer2$minterval;
          HPLTimer2$set_flag = 0;
        }
    }
#line 178
    __nesc_atomic_end(__nesc_atomic); }
  HPLTimer2$Timer2$fire();
}

# 102 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\HPLUART0M.nc"
  __attribute((signal)) void __vector_18(void)
#line 102
{
  if (* (volatile uint8_t *)(0x0B + 0x20) & (1 << 7)) {
    HPLUART0M$UART$get(* (volatile uint8_t *)(0x0C + 0x20));
    }
}

# 141 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\FramerM.nc"
static uint8_t FramerM$fRemapRxPos(uint8_t InPos)
#line 141
{


  if (InPos < 4) {
    return InPos + (size_t )& ((struct TOS_Msg *)0)->addr;
    }
  else {
#line 146
    if (InPos == 4) {
      return (size_t )& ((struct TOS_Msg *)0)->length;
      }
    else {
#line 149
      return InPos + (size_t )& ((struct TOS_Msg *)0)->addr - 1;
      }
    }
}

# 112 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\mica2\\HPLUART0M.nc"
  __attribute((interrupt)) void __vector_20(void)
#line 112
{
  HPLUART0M$UART$putDone();
}

# 497 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\FramerM.nc"
static result_t FramerM$TxArbitraryByte(uint8_t inByte)
#line 497
{
  if (inByte == FramerM$HDLC_FLAG_BYTE || inByte == FramerM$HDLC_CTLESC_BYTE) {
      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 499
        {
          FramerM$gPrevTxState = FramerM$gTxState;
          FramerM$gTxState = FramerM$TXSTATE_ESC;
          FramerM$gTxEscByte = inByte;
        }
#line 503
        __nesc_atomic_end(__nesc_atomic); }
      inByte = FramerM$HDLC_CTLESC_BYTE;
    }

  return FramerM$ByteComm$txByte(inByte);
}

# 139 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\platform\\micaz\\HPLADCM.nc"
  __attribute((signal)) void __vector_21(void)
#line 139
{
  uint16_t data = * (volatile uint16_t *)& * (volatile uint8_t *)(0x04 + 0x20);

#line 141
  data &= 0x3ff;
  * (volatile uint8_t *)(0x06 + 0x20) |= 1 << 4;
  * (volatile uint8_t *)(0x06 + 0x20) &= ~(1 << 7);
  __nesc_enable_interrupt();
  HPLADCM$ADC$dataReady(data);
}

# 346 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\DioM.nc"
  __attribute((signal)) void __vector_5(void)
{
  * (volatile uint8_t *)(0x39 + 0x20) &= ~(1 << 4);
  if (!TOS_post(DioM$read_io)) {
#line 349
    * (volatile uint8_t *)(0x39 + 0x20) |= 1 << 4;
    }
#line 350
  return;
}

# 146 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\CounterM.nc"
  __attribute((signal)) void __vector_6(void)
{
  /* atomic removed: atomic calls only */
#line 148
  {

    if (CounterM$state == 0) {
        TOSH_CLR_PW4_PIN();
        CounterM$state = 1;
        if (CounterM$mode & FALLING_EDGE) {
            CounterM$count++;
            if (EVENT & CounterM$mode) {
#line 155
              TOS_post(CounterM$count_ready);
              }
          }
      }
    else 
#line 158
      {
        TOSH_SET_PW4_PIN();
        CounterM$state = 0;
        if (CounterM$mode & RISING_EDGE) {
            CounterM$count++;
            if (EVENT & CounterM$mode) {
#line 163
              TOS_post(CounterM$count_ready);
              }
          }
      }
  }
  return;
}

#line 137
static  void CounterM$count_ready(void)
{
  uint16_t counter;

#line 140
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 140
    {
      counter = CounterM$count;
    }
#line 142
    __nesc_atomic_end(__nesc_atomic); }
  CounterM$Counter$dataReady(counter);
}

# 308 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\sensorboards\\mda300\\TempHumM.nc"
  __attribute((signal)) void __vector_8(void)
{
  * (volatile uint8_t *)(0x39 + 0x20) &= ~(1 << 7);
  TOS_post(TempHumM$readSensor);
  return;
}

# 51 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\BoundaryI.nc"
 void XMeshC$BoundaryI$new_nbrtbl_entry(uint8_t arg_0x1ab94b38, uint16_t arg_0x1ab94cc8){
#line 51
  BoundaryM$BoundaryI$new_nbrtbl_entry(arg_0x1ab94b38, arg_0x1ab94cc8);
#line 51
}
#line 51
#line 40
 uint16_t XMeshC$BoundaryI$get_nbrtbl_parent(uint8_t arg_0x1ab98660){
#line 40
  unsigned short result;
#line 40

#line 40
  result = BoundaryM$BoundaryI$get_nbrtbl_parent(arg_0x1ab98660);
#line 40

#line 40
  return result;
#line 40
}
#line 40

 uint16_t XMeshC$BoundaryI$get_nbrtbl_cost(uint8_t arg_0x1ab98af8){
#line 41
  unsigned short result;
#line 41

#line 41
  result = BoundaryM$BoundaryI$get_nbrtbl_cost(arg_0x1ab98af8);
#line 41

#line 41
  return result;
#line 41
}
#line 41
#line 73
 uint16_t XMeshC$BoundaryI$get_dsctbl_from(uint8_t arg_0x1aba87e0){
#line 73
  unsigned short result;
#line 73

#line 73
  result = BoundaryM$BoundaryI$get_dsctbl_from(arg_0x1aba87e0);
#line 73

#line 73
  return result;
#line 73
}
#line 73
#line 48
 uint8_t XMeshC$BoundaryI$get_nbrtbl_hop(uint8_t arg_0x1ab96d68){
#line 48
  unsigned char result;
#line 48

#line 48
  result = BoundaryM$BoundaryI$get_nbrtbl_hop(arg_0x1ab96d68);
#line 48

#line 48
  return result;
#line 48
}
#line 48
#line 47
 uint8_t XMeshC$BoundaryI$get_nbrtbl_liveliness(uint8_t arg_0x1ab967d8){
#line 47
  unsigned char result;
#line 47

#line 47
  result = BoundaryM$BoundaryI$get_nbrtbl_liveliness(arg_0x1ab967d8);
#line 47

#line 47
  return result;
#line 47
}
#line 47


 uint8_t XMeshC$BoundaryI$get_nbrtbl_receiveEst(uint8_t arg_0x1ab94210){
#line 49
  unsigned char result;
#line 49

#line 49
  result = BoundaryM$BoundaryI$get_nbrtbl_receiveEst(arg_0x1ab94210);
#line 49

#line 49
  return result;
#line 49
}
#line 49
#line 44
 uint16_t XMeshC$BoundaryI$get_nbrtbl_received(uint8_t arg_0x1ab97950){
#line 44
  unsigned short result;
#line 44

#line 44
  result = BoundaryM$BoundaryI$get_nbrtbl_received(arg_0x1ab97950);
#line 44

#line 44
  return result;
#line 44
}
#line 44
#line 43
 uint16_t XMeshC$BoundaryI$get_nbrtbl_missed(uint8_t arg_0x1ab974b0){
#line 43
  unsigned short result;
#line 43

#line 43
  result = BoundaryM$BoundaryI$get_nbrtbl_missed(arg_0x1ab974b0);
#line 43

#line 43
  return result;
#line 43
}
#line 43
#line 39
 uint16_t XMeshC$BoundaryI$get_nbrtbl_id(uint8_t arg_0x1ab98188){
#line 39
  unsigned short result;
#line 39

#line 39
  result = BoundaryM$BoundaryI$get_nbrtbl_id(arg_0x1ab98188);
#line 39

#line 39
  return result;
#line 39
}
#line 39



 uint8_t XMeshC$BoundaryI$get_nbrtbl_childLiveliness(uint8_t arg_0x1ab97010){
#line 42
  unsigned char result;
#line 42

#line 42
  result = BoundaryM$BoundaryI$get_nbrtbl_childLiveliness(arg_0x1ab97010);
#line 42

#line 42
  return result;
#line 42
}
#line 42
#line 71
 uint8_t XMeshC$BoundaryI$find_dsctbl_entry(uint16_t arg_0x1aba9ca0, uint8_t arg_0x1aba9e28){
#line 71
  unsigned char result;
#line 71

#line 71
  result = BoundaryM$BoundaryI$find_dsctbl_entry(arg_0x1aba9ca0, arg_0x1aba9e28);
#line 71

#line 71
  return result;
#line 71
}
#line 71
#line 46
 uint8_t XMeshC$BoundaryI$get_nbrtbl_flags(uint8_t arg_0x1ab96340){
#line 46
  unsigned char result;
#line 46

#line 46
  result = BoundaryM$BoundaryI$get_nbrtbl_flags(arg_0x1ab96340);
#line 46

#line 46
  return result;
#line 46
}
#line 46
#line 45
 uint16_t XMeshC$BoundaryI$get_nbrtbl_lastSeqno(uint8_t arg_0x1ab97df0){
#line 45
  unsigned short result;
#line 45

#line 45
  result = BoundaryM$BoundaryI$get_nbrtbl_lastSeqno(arg_0x1ab97df0);
#line 45

#line 45
  return result;
#line 45
}
#line 45





 uint8_t XMeshC$BoundaryI$get_nbrtbl_sendEst(uint8_t arg_0x1ab946a8){
#line 50
  unsigned char result;
#line 50

#line 50
  result = BoundaryM$BoundaryI$get_nbrtbl_sendEst(arg_0x1ab946a8);
#line 50

#line 50
  return result;
#line 50
}
#line 50
#line 72
 uint16_t XMeshC$BoundaryI$get_dsctbl_origin(uint8_t arg_0x1aba8348){
#line 72
  unsigned short result;
#line 72

#line 72
  result = BoundaryM$BoundaryI$get_dsctbl_origin(arg_0x1aba8348);
#line 72

#line 72
  return result;
#line 72
}
#line 72
#line 52
 uint8_t XMeshC$BoundaryI$find_nbrtbl_entry(uint16_t arg_0x1ab93190){
#line 52
  unsigned char result;
#line 52

#line 52
  result = BoundaryM$BoundaryI$find_nbrtbl_entry(arg_0x1ab93190);
#line 52

#line 52
  return result;
#line 52
}
#line 52
# 41 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
 result_t XMeshC$BattControl$init(void){
#line 41
  unsigned char result;
#line 41

#line 41
  result = VoltageM$StdControl$init();
#line 41

#line 41
  return result;
#line 41
}
#line 41
# 460 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\apps\\xmesh\\XMDA300\\XMDA300M.nc"
static  result_t XMDA300M$Send$sendDone(TOS_MsgPtr msg, result_t success)
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
#line 462
    {
      XMDA300M$msg_ptr = msg;
      XMDA300M$sending_packet = FALSE;
    }
#line 465
    __nesc_atomic_end(__nesc_atomic); }
  XMDA300M$Leds$yellowOff();






  return SUCCESS;
}

# 56 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\StdControl.nc"
 result_t XMeshC$GCStdControl$stop(void){
#line 56
  unsigned char result;
#line 56

#line 56
  result = AMPromiscuous$Control$stop();
#line 56

#line 56
  return result;
#line 56
}
#line 56
# 37 "C:\\Crossbow\\cygwin\\opt\\MoteWorks\\tos\\interfaces\\ADC.nc"
  result_t XMeshC$Batt$getContinuousData(void){
#line 37
  unsigned char result;
#line 37

#line 37
  result = ADCREFM$ADC$getContinuousData(TOS_ADC_VOLTAGE_PORT);
#line 37

#line 37
  return result;
#line 37
}
#line 37
