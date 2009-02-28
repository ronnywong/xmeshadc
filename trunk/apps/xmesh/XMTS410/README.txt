README

STATE MACHINE:
  Timer fired ---> Battery ---> ADC5 ---> ADC6 ---> Accelerometer ---> TAOS light
  ---> Humidity ---> Intersema Pressure (---> Microphone) ---> send packet via radio

DESCRIPTION:
  --Read battary,temperature, humidity, light, accel,pressure,PIR,mic sensor readings
  --control two relays
  --Output message to uart port
  --Output message to radio port

FEATURE: 
  -- PIR sensor works at interrupting mode.
  -- Every packet contains the PIR event statistics of the last timer_rate interval.
  -- User can change PIR paramters via xserveterm(special version  for HM)
  -- When the user changes the PIR parameters via XCommand, a pir info packet will be sent to the user.