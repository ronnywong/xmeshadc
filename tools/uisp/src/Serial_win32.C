// $Id: Serial_win32.C,v 1.1.2.1 2007/01/26 06:23:19 pipeng Exp $

/*
*
****************************************************************************
*
* uisp - The Micro In-System Programmer for Atmel AVR microcontrollers.
* Copyright (C) 1997, 1998, 1999, 2000, 2001, 2002, 2003  Uros Platise
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*
****************************************************************************
*/

/*

Serial Interface for Win32
Freddy Feng, (c) 2006-2007
*/
#include "Global.h"
#include <winsock2.h>
#include "Serial.h"

#pragma comment(lib, "ws2_32") 

int parse_baudrate(int requested);
int xserial_set_speed(XIOSerial* channel, DWORD baud_rate);
char* xserial_parse_device(char* dev);
XIOSerial* xserial_open(char *dev, DWORD baud_rate);
int xserial_close(XIOSerial* channel);
int xserial_read(XIOSerial* channel, char *buffer, int buffersize, int timeout);
int xserial_write(XIOSerial* channel, char *buffer, int count);
void* xmalloc(size_t s);
XIOSocket* xsocket_open(const char* name, unsigned long port);
int xsocket_read(XIOSocket* channel, char* buffer, int count, int timeout);
int xsocket_write(XIOSocket* channel, char* buffer, int count);
int xsocket_close(XIOSocket* channel);
int xsocket_wait(XIOSocket* handle, int timeout);

int TSerial::Tx(unsigned char* queue, int queue_size)
{
	DWORD nwritten = 0;
	DWORD rvwait;
	char* ch_queue=(char*)queue;
	Info(4, "Transmit: { ");
	for (int n=0; n<queue_size; n++) {
		Info(4, "%c [%02x] ", isprint(queue[n])?(char) queue[n]:'.', queue[n]);
	}
	Info(4, "}\n");
	if(remote)
	{
		return xsocket_write((XIOSocket*)serline,ch_queue,queue_size);
	}
	else
	{
		return xserial_write((XIOSerial*)serline,ch_queue,queue_size);
	}
	return -1;
}

int TSerial::Rx(unsigned char* queue, int queue_size, timeval* timeout){
	char* ch_queue=(char*)queue;
	DWORD dwRead = 0;
	DWORD rvwait;
	int tout_val,size;
	tout_val=timeout->tv_sec*1000;
	if(remote)
	{
//			size = xsocket_read((XIOSocket*)serline,ch_queue,queue_size,timeout->tv_sec);
		if(((XIOSocket*)(serline))){
			//add the timeout watch on the socket
			if(xsocket_wait(((XIOSocket*)(serline)),tout_val) < 0){
				return -2;
			}

			while (1){
				int n = recv((SOCKET)(((XIOSocket*)(serline))->socket_handle), (char*)queue, queue_size,0);

				//if there is a interrupt or a temp resource block
				//go ahead and try again
				if (n == -1 && WSAGetLastError() == WSAEINTR)
					continue;
				if (n == -1 && WSAGetLastError() == WSAEWOULDBLOCK)
					continue;

				if (n == -1){
					return -1;
				}
				//if i've gotten here well then i've read
				//what i can so return
				dwRead = n;
				break;
			}
		}
	}
	else
	{
//		size = xserial_read((XIOSerial*)serline,ch_queue,queue_size,tout_val);
		if(((XIOSerial*)(serline))->waiting == 0){
			WaitCommEvent(((XIOSerial*)(serline))->serial_handle,&(((XIOSerial*)(serline))->result),NULL);
		}

		if (!ReadFile(((XIOSerial*)(serline))->serial_handle,ch_queue,queue_size,&dwRead,&(((XIOSerial*)(serline))->overlapped))){
			//check if we're still waiting for the read
			if(GetLastError()==ERROR_IO_PENDING){
				if(tout_val == 0){
					//printf("timeout %d.",timeout);
					rvwait = WaitForSingleObject(((XIOSerial*)(serline))->overlapped.hEvent,INFINITE);
				}else{
					//printf("timeout %d.",timeout);
					rvwait = WaitForSingleObject(((XIOSerial*)(serline))->overlapped.hEvent,tout_val);
				}
				if(rvwait == WAIT_TIMEOUT){
					printf("timer timedout\n");
				}

				if( rvwait != WAIT_OBJECT_0 ){
					//xdebug(XDBG_2,"Serial read from %s has reached timeout %i\n",channel->devname,timeout);
					return -2;
				}
				GetOverlappedResult(((XIOSerial*)(serline))->serial_handle,&(((XIOSerial*)(serline))->overlapped),&dwRead,TRUE);
			}
		}
	}

	size = dwRead;

	Info(4, "Receive: { ");
	for (int n=0; n<size; n++) {
		Info(4, "%c [%02x] ", isprint(queue[n])?(char)queue[n]:'.', queue[n]);
	}
	Info(4, "}\n");
	return size;
}

int TSerial::Send(unsigned char* queue, int queue_size, int rec_queue_size,
				  int timeout)
{
	timeval tval;
	tval.tv_sec=timeout;
	PurgeComm(((XIOSerial*)serline)->serial_handle,PURGE_TXCLEAR|PURGE_RXCLEAR);
	if(	Tx(queue, queue_size)<=0) 
	{
		return -1;
	}
	if (rec_queue_size==-1){rec_queue_size = queue_size;}
	int total_len=0;  
	while(total_len<rec_queue_size){
		total_len += Rx(&queue[total_len], rec_queue_size - total_len, &tval);
	}
	if(total_len<=0)
	{
		return -2;
	}
	return total_len;
}

//xmit a buffer only, empty the rcv buffer
//for MIB510 only. May have bad chars in uart rcv bfr from mote.
//need to flush them.
void TSerial::SendOnly(unsigned char* queue, int queue_size)
{
	Tx(queue, queue_size);
	if (!remote) {
	SleepEx(100,false);
	}
	PurgeComm(((XIOSerial*)serline)->serial_handle,PURGE_TXCLEAR|PURGE_RXCLEAR);
}

/* Constructor/Destructor
*/

TSerial::TSerial(){
	/* Parse Command Line Parameters */
	if (GetCmdParam("-dhost")) {
		remote = true;
		OpenTcp();
	}
	else {
		remote = false;
		OpenPort();
	}
}

void TSerial::OpenTcp() {
  /* Parse Command Line Parameters */
  struct sockaddr_in serv_addr;
  struct hostent *server;
  short  sPort = 10001;

  serline = xsocket_open(GetCmdParam("-dhost"),sPort);
  if(serline <= 0 ) {
    throw Error_Device("Error resolving server name.");
  }


	remote = true;
}

void TSerial::OpenPort() { 
	char* dev_name = "/dev/ttyS0";
	int val;
	const char* pstr;  
  DWORD speed = CBR_115200;	/* default speed */
  
 /* Open port and set serial attributes */
  if (strcmp(GetCmdParam("-dprog",false), "stk500") == 0 ||
      strcmp(GetCmdParam("-dprog",false), "mib510") == 0 ||
      strcmp(GetCmdParam("-dprog",false), "mib520") == 0) {
    speed = CBR_115200;        /* default STK500 speed */
  }

  if ((pstr=GetCmdParam("-dserial",true))){dev_name = (char*)pstr;}
  if ((pstr=GetCmdParam("-dspeed",false))){
	  val=atoi(pstr);
	  speed = parse_baudrate(val);
   }

  // COMn and cygwin don't interact well. Use /dev/ttyS<n-1> instead
  dev_name = xserial_parse_device(dev_name);
  if ((serline = xserial_open(dev_name,speed)) <= 0) {
    throw Error_C(dev_name);
  }  
  remote = false;
}

TSerial::~TSerial(){
	if(remote)
	{
		xsocket_close((XIOSocket*)serline);
	}
	else
	{
		xserial_close((XIOSerial*)serline);
	}
}

//Follow function porting from XServe
/** Confirms that desired baud rate is legal. */

int parse_baudrate(int requested)
{
	switch (requested) {
	  case    110: return CBR_110;
	  case    300: return CBR_300;
	  case    600: return CBR_600;
	  case   1200: return CBR_1200;
	  case   2400: return CBR_2400;
	  case   4800: return CBR_4800;
	  case   9600: return CBR_9600;
	  case  14400: return CBR_14400;
	  case  19200: return CBR_19200;
	  case  38400: return CBR_38400;
	  case  56000: return CBR_56000;
	  case  57600: return CBR_57600;
	  case 115200: return CBR_115200;
	  case 128000: return CBR_128000;
	  case 256000: return CBR_256000;
	  default:     return 0;
	}
}
/**
* Effects: sets the baud rate of the raw serial device
*
* @return  0 on success, -1 otherwise
*/
int xserial_set_speed(XIOSerial* channel, DWORD baud_rate){
	DCB   dcb;
	//COMMTIMEOUTS Timeouts;
	DWORD baud = baud_rate;
	if (baud == 0) return -1;

	if (!(GetCommState( channel->serial_handle, &dcb ) && SetCommState(channel->serial_handle, &dcb))) {
		return -1;
	}
	dcb.DCBlength = sizeof(DCB);
	dcb.BaudRate = baud;
	dcb.fBinary = TRUE;
	dcb.ByteSize = 8;
	dcb.Parity = NOPARITY;
	dcb.StopBits = ONESTOPBIT;

	if (!SetCommState( channel->serial_handle, &dcb )) {
		return -1;
	}
	return 0;
}

/**
* Effects: get right device name
*
*/
char* xserial_parse_device(char* dev)
{
	int commnum;
	char* dstr;
	dstr=(char*) malloc(20);
	if (_tcsncmp(dev, "/dev/ttyS", 9) == 0){
		commnum=atoi(dev+9);
		sprintf(dstr, "\\\\.\\COM%d",commnum+1);
		printf("Warning: Converting Cygwin %s device to Windows device.\n", dev);
	}else{
		if (_tcsncmp(dev, "com", 3) == 0)
		{
			commnum=atoi(dev+3);
			sprintf(dstr, "\\\\.\\COM%d",commnum);
		}
	}
	return dstr;
}

/**
* Effects: opens serial port device at specified baud_rate. If non_blocking
*    is true, read_serial_packet calls will be non-blocking (writes are
*    always blocking, for now at least)
*
* @return descriptor for serial forwarder at host:port, or
* @n        -1 for failure (bad device or bad baud rate)
*/
XIOSerial* xserial_open(char *dev, DWORD baud_rate){
	DWORD errors;
	XIOSerial* xio=NULL;
	HANDLE hComm = CreateFile( dev,GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL|FILE_FLAG_OVERLAPPED, NULL);
	if ( (int)hComm <= 0 ){
		return NULL;
	}

	xio = (XIOSerial*)xmalloc(sizeof(XIOSerial));
	memset(xio,0,sizeof(XIOSerial));

	xio->event = CreateEvent(NULL,  TRUE ,FALSE, NULL);

	if(xio->event == NULL){
		CloseHandle(hComm);
		free(xio);
		return NULL;
	}
	xio->type = 1;
	xio->devname = dev;
	xio->serial_handle = hComm;

	//set the overlapped object to be associated with the nodes event.
	xio->overlapped.hEvent = xio->event;
	xserial_set_speed(xio, baud_rate);
	SetCommMask(hComm,EV_ERR|EV_RXCHAR);
	PurgeComm(hComm,PURGE_TXCLEAR|PURGE_RXCLEAR);
	ClearCommError( hComm, &errors, NULL );
	return xio;
}

/**
* Effects: Closes serial source src.
*
* @return  0 if successful, -1 if some problem occured (but
* @n       source is considered closed anyway)
*/
int xserial_close(XIOSerial* channel){
	int ok;
	if(channel->event != NULL){
		CloseHandle(channel->event);
	}
	channel->event = NULL;
	ok = CloseHandle( channel->serial_handle );
	channel->serial_handle=INVALID_HANDLE_VALUE;
	return ok;
}

int xserial_read(XIOSerial* channel, char *buffer, int buffersize, int timeout){
	DWORD dwRead = 0;
	DWORD rvwait;
	int rval;

		if(channel->waiting == 0){
			WaitCommEvent(channel->serial_handle,&(channel->result),NULL);
		}

		if (!ReadFile(channel->serial_handle,buffer,buffersize,&dwRead,&(channel->overlapped))){
			//check if we're still waiting for the read
			if(GetLastError()==ERROR_IO_PENDING){
				if(timeout == 0){
					//printf("timeout %d.",timeout);
					rvwait = WaitForSingleObject(channel->overlapped.hEvent,INFINITE);
				}else{
					//printf("timeout %d.",timeout);
					rvwait = WaitForSingleObject(channel->overlapped.hEvent,timeout);
				}
				if(rvwait == WAIT_TIMEOUT){
					printf("timer timedout\n");
				}

				if( rvwait != WAIT_OBJECT_0 ){
					//xdebug(XDBG_2,"Serial read from %s has reached timeout %i\n",channel->devname,timeout);
					return -2;
				}
				GetOverlappedResult(channel->serial_handle,&(channel->overlapped),&dwRead,TRUE);
			}
		}
	rval=(int)dwRead;
	return rval;
}

/** Low level block write to serial port. */
int xserial_write(XIOSerial* channel, char *buffer, int count){
	DWORD nwritten = 0;
	DWORD rvwait;
	OVERLAPPED owrite={0,0,0,0,NULL};
	if(channel){
		owrite.hEvent = CreateEvent( NULL, FALSE, FALSE, NULL );
		if(!WriteFile(channel->serial_handle, buffer, count, &nwritten, &owrite ) ){
			if (GetLastError() == ERROR_IO_PENDING ){
				rvwait = WaitForSingleObject(owrite.hEvent,INFINITE);
				if( rvwait != WAIT_OBJECT_0 ){
					//strange error since how did the wait time out with infinite
					return 0;
				}
				GetOverlappedResult(channel->serial_handle,&owrite,&nwritten,TRUE);
			}
		}
		CloseHandle(owrite.hEvent);
		return nwritten;
	}
	return -1;
}

/**
* Effects: judge whether handle is valid.
*
* @return  -1 if not valid, 0 if valid
*/
int xserial_valid(XIOSerial* channel){
	if(channel){
		if(channel->serial_handle > 0){
			return 0;
		}
	}
	return -1;
}

int xserial_wait(XIOSerial* handle, int timeout){
	return 1;
}

void* xmalloc(size_t s){
	void *p = malloc (s);
	if (!p){
		//xdebug(XDBG_ERROR, "Virtual Memory Exhausted! \n");
		exit(2);
	}
	memset(p,0,s);
	return p;
}

int xsocket_read(XIOSocket* channel, char* buffer, int count, int timeout){
	if(channel){
		//add the timeout watch on the socket
		if(xsocket_wait(channel,timeout) < 0){
			return -2;
		}


		while (1){
			int n = recv((SOCKET)channel->socket_handle, buffer, count,0);

			//if there is a interrupt or a temp resource block
			//go ahead and try again
			if (n == -1 && WSAGetLastError() == WSAEINTR)
				continue;
			if (n == -1 && WSAGetLastError() == WSAEWOULDBLOCK)
				continue;

			if (n == -1){
				return -1;
			}
			//if i've gotten here well then i've read
			//what i can so return
			return n;
		}
	}
	return -1;
}

int xsocket_write(XIOSocket* channel, char* buffer, int count){
    if(channel){
		int actual = 0;
		while (count > 0){

			int n = send((SOCKET)channel->socket_handle, buffer, count,0);

			if (n == -1 && WSAGetLastError() == WSAEINTR){
				continue;
			}
			if (n == -1 && WSAGetLastError() == WSAEWOULDBLOCK)
				continue;

			if (n == -1){
				return -1;
			}

			count -= n;
			actual += n;
			buffer += n;
		}
		return actual;
	}
	return -1;
}


XIOSocket* xsocket_open(const char* name, unsigned long port){
    /* open socket for read/write */
    struct hostent    *l_host;
    struct sockaddr_in l_socket;
    XPL_HANDLE fd = 0;
    XIOSocket* xio=NULL;
    int connect_retry=0;

     //check if winsock is available with the correct version
    WORD wVersionRequested;
    WSADATA wsaData;
    wVersionRequested = MAKEWORD( 2, 0 );
    if (WSAStartup( wVersionRequested, &wsaData ) != 0) {
    	/* Tell the user that we couldn't find a usable */
    	/* WinSock DLL. */
    	return NULL;
    }

    l_socket.sin_family = AF_INET;
    l_socket.sin_port = htons(port);
    l_socket.sin_addr.s_addr = INADDR_ANY;

    l_host = gethostbyname(name);
    if (l_host == NULL) {
		return NULL;
    }

    memcpy(&(l_socket.sin_addr), l_host->h_addr, l_host->h_length);

    fd = (XPL_HANDLE)socket(PF_INET, SOCK_STREAM, 0);
    if (fd < 0){
		return NULL;
    }

    while ((connect((SOCKET)fd, (struct sockaddr *)&l_socket, sizeof(l_socket)) < 0) && connect_retry < 3){
		connect_retry++;
		Sleep(1);
    }

	if(connect_retry == 3){
		return NULL;
	}

	//were good to go so create the xiochannel
	xio = (XIOSocket*)(xmalloc(sizeof(XIOSocket)));
	memset(xio,0,sizeof(XIOSocket));
	xio->type = 2;
	xio->hostname =(char*)name;
	xio->port = port;
	xio->socket_handle = fd;

	//create an event for this socket and bind it ot the READ and CLOSE events
	xio->event = WSACreateEvent();
	if (xio->event == WSA_INVALID_EVENT){
			free(xio);
			closesocket((SOCKET)fd);
			return NULL;
  	}
  	if (WSAEventSelect((SOCKET)fd,xio->event,FD_READ|FD_CLOSE) == SOCKET_ERROR){
		CloseHandle(xio->event);
		closesocket((SOCKET)fd);
		free(xio);
		return NULL;
  	}

    return xio;
}

int xsocket_close(XIOSocket* channel){
  	int ok = -1;
  	if(channel){
		if(channel->event != NULL){
			WSAEventSelect((SOCKET)channel->socket_handle, channel->event, 0);
			CloseHandle(channel->event);
			channel->event = NULL;
		}
    	ok = closesocket((SOCKET)channel->socket_handle);
		channel->socket_handle = NULL;

	}
  	return ok;
}

int xsocket_wait(XIOSocket* handle, int timeout){
  	XPL_HANDLE fd = handle->socket_handle;
  	struct timeval tv;
  	fd_set fds;
  	int cnt;
  	//get  time in usec
  	long timeus = timeout * 1000;
	long stime=clock();
	long etime=0;


	//add time to current (timeout is in millisecs)
	tv.tv_sec = timeus / 1000000;
	tv.tv_usec = timeus % 1000000;

	//go into a loop decrementing time and waiting for an event
	while(1){
		etime=clock();
		if (etime-stime >timeout){
			return -1;
		}

		FD_ZERO(&fds);
		FD_SET((SOCKET)fd, &fds);
		cnt = select((int)fd + 1, &fds, NULL, NULL,&tv);
		if (cnt < 0){
			if (WSAGetLastError()==WSAEINTR){
				continue;
			}
			return -1;
		}
		if (cnt == 0){
			return -1;
		}

		return cnt;
    }
	return 0;
}
