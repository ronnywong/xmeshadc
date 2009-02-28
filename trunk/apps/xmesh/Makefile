#-*-makefile-*-
######################################################################
# 
# Makes the entire suite of TinyOS applications for a given platform.
#
# Author: 	Martin Turon
# Date:		August 18, 2005
#
# One question: Why is Makefile syntax so cryptic?? 
#
######################################################################
# $Id: Makefile,v 1.3.4.4 2007/04/24 06:34:14 mturon Exp $

MICA2DIRS = XMTS101 XMTS300 XMTS310 XMTS400 XMTS410 XMTS420 XMTS450 XMDA100 XMDA300 XMDA320 XMDA325 XMEP410 XMSP410 XMeshBase XMTS300cb XMTS310cb XMTS420cc XMDA100cb XMDA300_d
MICAZDIRS = XMTS101 XMTS300 XMTS310 XMTS400 XMTS410 XMTS420 XMTS450 XMDA100 XMDA300 XMDA320 XMDA325 XMeshBase XMTS300cb XMTS310cb XMTS420cc XMDA100cb XMDA300_d
IRISDIRS = XMTS101 XMTS300 XMTS310 XMTS400 XMTS410 XMTS420 XMTS450 XMDA100 XMDA300 XMDA320 XMDA325 XMeshBase XMTS300cb XMTS310cb XMTS420cc XMDA100cb XMDA300_d
DOTDIRS = XMTS510 XMDA500 XMEP510 XMeshBase

M9100DIRS = XMTS101 XMTS300 XMTS310 XMTS400 XMTS410 XMTS420 XMTS450 XMDA100 XMDA300 XMDA320 XMDA325 XMEP410 XMeshBase XMTS300cb XMTS310cb XMTS420cc XMDA100cb XMDA300_d
M2100DIRS = XMTS101 XMTS300 XMTS310 XMTS400 XMTS410 XMTS420 XMTS450 XMDA100 XMDA300 XMDA320 XMDA325 XMeshBase XMTS300cb XMTS310cb XMTS420cc XMDA100cb XMDA300_d

all: micaz mica2 mica2dot iris 
# m9100 mica2_c micaz_c m9100_c m2100_c m2110_c m2100

mica2: here
	@for i in $(MICA2DIRS); do \
	  if [ -d $$i ]; then \
	    if [ ! -d Suite/mica2 ]; then \
	  	mkdir Suite Suite/mica2; \
	    fi; \
	    if [ -f $$i/Makefile ]; then \
		rm $$i/build/mica2/*.exe; \
		$(MAKE) -C $$i -f ../Makefile.mica mica2; \
		cp $$i/build/mica2/*.exe Suite/mica2; \
	    else \
		echo "***" no Makefile in directory: $(PWD)/$$i; \
	    fi \
	  else \
		echo "***" skipping missing directory: $(PWD)/$$i; \
	  fi; \
	  rm Suite/mica2/main.exe; \
	done

micaz: here
	@for i in $(MICAZDIRS); do \
	  if [ -d $$i ]; then \
	    if [ ! -d Suite/micaz ]; then \
	  	mkdir Suite Suite/micaz; \
	    fi; \
	    if [ -f $$i/Makefile ]; then \
		rm $$i/build/micaz/*.exe; \
		$(MAKE) -C $$i -f ../Makefile.mica micaz; \
		cp $$i/build/micaz/*.exe Suite/micaz; \
	    else \
		echo "***" no Makefile in directory: $(PWD)/$$i; \
	    fi \
	  else \
		echo "***" skipping missing directory: $(PWD)/$$i; \
	  fi; \
	  rm Suite/micaz/main.exe; \
	done
	
mica2dot: here
	@for i in $(DOTDIRS); do \
	  if [ -d $$i ]; then \
	    if [ ! -d Suite/mica2dot ]; then \
	  	mkdir Suite Suite/mica2dot; \
	    fi; \
	    if [ -f $$i/Makefile ]; then \
		rm $$i/build/mica2dot/*.exe; \
		$(MAKE) -C $$i -f ../Makefile.mica2dot; \
		cp $$i/build/mica2dot/*.exe Suite/mica2dot; \
	    else \
		echo "***" no Makefile in directory: $(PWD)/$$i; \
	    fi \
	  else \
		echo "***" skipping missing directory: $(PWD)/$$i; \
	  fi; \
	  rm Suite/mica2dot/main.exe; \
	done

m9100: here
	@for i in $(M9100DIRS); do \
	  if [ -d $$i ]; then \
	    if [ ! -d Suite/m9100 ]; then \
	  	mkdir Suite Suite/m9100; \
	    fi; \
	    if [ -f $$i/Makefile ]; then \
		rm $$i/build/m9100/*.exe; \
		$(MAKE) -C $$i -f ../Makefile.mica m9100; \
		cp $$i/build/m9100/*.exe Suite/m9100; \
	    else \
		echo "***" no Makefile in directory: $(PWD)/$$i; \
	    fi \
	  else \
		echo "***" skipping missing directory: $(PWD)/$$i; \
	  fi; \
	  rm Suite/m9100/main.exe; \
	done
	
m2100: here
	@for i in $(M2100DIRS); do \
	  if [ -d $$i ]; then \
	    if [ ! -d Suite/m2100 ]; then \
	  	mkdir Suite Suite/m2100; \
	    fi; \
	    if [ -f $$i/Makefile ]; then \
		rm $$i/build/m2100/*.exe; \
		$(MAKE) -C $$i -f ../Makefile.mica m2100; \
		cp $$i/build/m2100/*.exe Suite/m2100; \
	    else \
		echo "***" no Makefile in directory: $(PWD)/$$i; \
	    fi \
	  else \
		echo "***" skipping missing directory: $(PWD)/$$i; \
	  fi; \
	  rm Suite/m2100/main.exe; \
	done

iris: here
	@for i in $(IRISDIRS); do \
	  if [ -d $$i ]; then \
	    if [ ! -d Suite/iris ]; then \
	  	mkdir Suite Suite/iris; \
	    fi; \
	    if [ -f $$i/Makefile ]; then \
		rm $$i/build/iris/*.exe; \
		$(MAKE) -C $$i -f ../Makefile.iris iris; \
		cp $$i/build/iris/*.exe Suite/iris; \
	    else \
		echo "***" no Makefile in directory: $(PWD)/$$i; \
	    fi \
	  else \
		echo "***" skipping missing directory: $(PWD)/$$i; \
	  fi; \
	  rm Suite/iris/main.exe; \
	done

here: printdir FORCE

printdir:
	@echo "Building... $(PWD)"; 

FORCE:
