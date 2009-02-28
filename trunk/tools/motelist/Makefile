# Makefile for xlisten 
# $Id: Makefile,v 1.1 2006/01/12 10:24:15 mturon Exp $

CC      = g++
CFLAGS  = -O -Wall

all: motelist

motelist: motelist.o

clean: 
	rm -f motelist motelist.exe
	rm -f *.o
	for dir in ${SUBDIRS} ; do ( rm -f $${dir}/*.o ; ) ; done


