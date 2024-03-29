#ifndef SERIALSOURCE_H
#define SERIALSOURCE_H

#include "xpl_serial.h"

typedef struct serial_source *serial_source;

typedef enum {
  msg_unknown_packet_type,	/* packet of unknown type received */
  msg_ack_timeout, 		/* ack not received within timeout */
  msg_sync,			/* sync achieved */
  msg_too_long,			/* greater than MTU (256 bytes) */
  msg_too_short,		/* less than 4 bytes */
  msg_bad_sync,			/* unexpected sync byte received */
  msg_bad_crc,			/* received packet has bad crc */
  msg_closed,			/* serial port closed itself */
  msg_no_memory,		/* malloc failed */
  msg_unix_error		/* check errno for details */
} serial_source_msg;

serial_source serial_source_new(serial_handle fd, int non_blocking,
				void (*message)(serial_source_msg problem));

serial_source serial_source_open(const char *device, int baud_rate,
				 int non_blocking,
				 void (*message)(serial_source_msg problem));
/* Effects: opens serial port device at specified baud_rate. If non_blocking
     is true, read_serial_packet calls will be non-blocking (writes are
     always blocking, for now at least)
     If non-null, message will be called to signal various problems during
     execution.
   Returns: descriptor for serial forwarder at host:port, or
     NULL for failure
 */

serial_handle serial_source_fd(serial_source src);
/* Returns: the file descriptor used by serial source src (useful when
     non-blocking reads were requested)
*/

int serial_source_empty(serial_source src);
/* Returns: true if serial source does not contain any pending data, i.e.,
     if the result is true and there is no data available on the source's
     file descriptor, then read_serial_packet will:
       - return NULL if the source is non-blocking
       - block if it is blocking

    (Note: the presence of this calls allows the serial_source to do some
    internal buffering)
*/

int close_serial_source(serial_source src);
/* Effects: closes serial source src
   Returns: 0 if successful, -1 if some problem occured (but source is
     considered closed anyway)
 */

void *read_serial_packet(serial_source src, int *len);
/* Effects: Read the serial source src. If a packet is available, return it.
     If in blocking mode and no packet is available, wait for one.
   Returns: the packet read (in newly allocated memory), with *len is
     set to the packet length, or NULL if no packet is yet available and
     the serial source is in non-blocking mode
*/

int write_serial_packet(serial_source src, const void *packet, int len, char proto);
/* Effects: writes len byte packet to serial source src
 * proto - this determines if we use a FRAMER-PROTO-ACK or NO-ACK
   Returns: 0 if packet successfully written, 1 if successfully written
     but not acknowledged, -1 otherwise
*/

int change_serial_speed(serial_source src, int baud_rate);

//hack until i can get it to link correctly
int external_source_write(serial_source src, const void *buffer, int count);


#endif
