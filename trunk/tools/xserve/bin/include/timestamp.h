/**
 * Parts of this code were developed as part of
 * the NSF-ITR FireBug project.
 *
 * @author David M. Doolin
 *
 * @url http://firebug.sourceforge.net
 *
 * $Id: timestamp.h,v 1.9.2.10 2007/03/13 22:29:44 rkapur Exp $
 */

#ifndef FB_TIMESTAMP_H
#define FB_TIMESTAMP_H

#ifdef __cplusplus
extern "C" {
#endif

#define TIMESTRING_SIZE 128

/** Incomplete type, easier to extend later.
 */
typedef struct _timestamp Timestamp;


Timestamp *  timestamp_new        (void);

void         timestamp_delete     (Timestamp * ts);

/** A handy format matching a mysql's time stamping syntax.
 * The date written as text can be imported directly into
 * a mysql table.
 */
void         timestamp_get_ymdhms (Timestamp * ts,
				   char * timestring);
void         timestamp_get_string (Timestamp * ts,
				   char * timestring);

#ifdef __cplusplus
}
#endif


#endif  /* FB_TIMESTAMP_H */
