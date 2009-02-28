#ifndef __STDDEFINE_H
#define __STDDEFINE_H 1

#ifdef __WIN32__
#define _WIN32_WINNT 0x0500
#include <windows.h>

#include <time.h>
#include <tchar.h>		//string operation
#include <direct.h>
#include <io.h>
#include <sys/types.h>
#include <stdlib.h>
#include <fcntl.h>
#include <ctype.h>
#include <errno.h>
#include <string.h>
#include <tchar.h>
#include "Error.h"

//define common type for win32
typedef HANDLE		XPL_HANDLE;
typedef DWORD		XPL_STATUS;
typedef OVERLAPPED XPL_OVERLAPPED;
typedef struct termios{
	int data;
}termios;

typedef unsigned char		uint8_t;
typedef unsigned short		uint16_t;
typedef unsigned int		uint32_t;
typedef unsigned __int64	uint64_t;

typedef struct _xioserial{
	int type;
	char* devname;
	XPL_HANDLE serial_handle;
	XPL_OVERLAPPED overlapped;
	XPL_HANDLE event;
	XPL_STATUS result;
	int waiting;
} XIOSerial;

typedef struct _xiosocket{
	int type;
	char* hostname;
	unsigned long port;
	XPL_HANDLE socket_handle;
	XPL_HANDLE event;

} XIOSocket;

typedef void*		XPL_SERIAL;
#define XPL_INVALID_HANDLE	 NULL
#define XPL_CLOSE_FILE	 CloseHandle

#else

#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <termios.h>
#include <ctype.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>



//define common type for posix
typedef int			XPL_HANDLE;
typedef int			XPL_STATUS;
typedef int			XPL_SERIAL;

#define XPL_INVALID_HANDLE	 -1
#define XPL_CLOSE_FILE	 close
#endif

#endif
