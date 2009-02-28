#!/bin/bash

if [ $# -lt 2 ]; then
	echo This script will list the location of all files in this compile
	echo USAGE: location.sh [make directive]
	echo EX: location.sh make mica2 route,lp2
else
	#$* PFLAGS+=-v 2>&1 | grep preprocess | sort
	$* NESC_FLAGS+=-Wnesc-all NESC_FLAGS+=-v 2>&1 | grep preprocess | sort
fi
