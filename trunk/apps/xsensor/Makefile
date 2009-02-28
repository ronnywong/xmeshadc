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
# $Id: Makefile,v 1.1 2006/01/03 07:41:42 mturon Exp $

# MAKECMDGOALS is the way to get the arguments passed into a Makefile ...
TARGET=$(MAKECMDGOALS)

# Here is a way to get the list of subdirectories in a Makefile ...
ROOT=.
SUBDIRS := ${wildcard *}

# Okay, match any target, and recurse the subdirectories
%: 
	@for i in $(SUBDIRS); do \
	  if [ -d $$i ]; then \
	    if [ -f $$i/Makefile ]; then \
		  echo ;\
		  echo ========================================================================= ;\
		  echo Building ... $(PWD)/$$i; \
		  echo make $(TARGET); \
		  cd $$i; \
		  $(MAKE) $(TARGET); \
		  cd ..; \
	    else \
		  echo "***" no Makefile in directory: $(PWD)/$$i; \
	    fi \
	  else \
		echo "***" not a directory: $(PWD)/$$i; \
	  fi; \
	done

