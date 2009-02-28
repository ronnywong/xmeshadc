# Script for profile.d of bash shells. 
# MoteWorks tree installation point 
# and default path is defined here.
# Copyright (c) 2006 Crossbow Technology, Inc.
# $Id: xbow.sh,v 1.4.4.1 2006/05/19 23:19:50 mturon Exp $

# Setup the basic environment: TOSROOT, TOSDIR, and MAKERULES
export TOSROOT="/opt/MoteWorks"
export TOSDIR="$TOSROOT/tos"
export MAKERULES="$TOSROOT/make/Makerules"

# Default COM port for ice-insight.
export AVARICE_ARGS=-j/dev/ttyS0

#
# Extend path, but do so carefully, so multiple runs of this script won't
# grow the path indefinitely.  This script can be run multiple times by
# the usetos script.
#
echo $PATH | grep -q /usr/local/bin ||  PATH=/usr/local/bin:$PATH
echo $PATH | grep -q /opt/MoteWorks/make/scripts || PATH=$PATH:/opt/MoteWorks/make/scripts
echo $PATH | grep -q /opt/MoteWorks/tools/bin || PATH=$PATH:/opt/MoteWorks/tools/bin
echo $PATH | grep -q . || PATH=$PATH:.

#
# XServe configuration...
#
export PATH=.:/opt/MoteWorks/tools/xserve/bin/lib:/opt/MoteWorks/tools/xserve/bin/lib/datasinks:/opt/MoteWorks/tools/xserve/bin/lib/commands:/opt/MoteWorks/tools/xserve/bin/lib/parsers:/opt/MoteWorks/tools/xserve/bin/3rdparty/gdome2/lib:/opt/MoteWorks/tools/xserve/bin/3rdparty/httpd/lib:/opt/MoteWorks/tools/xserve/bin/3rdparty/libmatheval/lib:/opt/MoteWorks/tools/xserve/bin/3rdparty/libxml2/lib:/opt/MoteWorks/tools/xserve/bin/3rdparty/modbus/lib:/opt/MoteWorks/tools/xserve/bin/3rdparty/postgresql/lib:/opt/MoteWorks/tools/xserve/bin/3rdparty/xmlrpc/lib:.:/opt/MoteWorks/tools/xserve/bin/3rdparty/libxml2/bin:/opt/MoteWorks/tools/xserve/bin/3rdparty/postgresql/bin:/opt/MoteWorks/tools/xserve/bin/3rdparty/xmlrpc/bin:/opt/MoteWorks/tools/xserve/bin/bin:$PATH

export LD_ LIBRARY_PATH=.:/opt/MoteWorks/tools/xserve/bin/lib:/opt/MoteWorks/tools/xserve/bin/lib/datasinks:/opt/MoteWorks/tools/xserve/bin/lib/commands:/opt/MoteWorks/tools/xserve/bin/lib/parsers:/opt/MoteWorks/tools/xserve/bin/3rdparty/gdome2/lib:/opt/MoteWorks/tools/xserve/bin/3rdparty/httpd/lib:/opt/MoteWorks/tools/xserve/bin/3rdparty/libmatheval/lib:/opt/MoteWorks/tools/xserve/bin/3rdparty/libxml2/lib:/opt/MoteWorks/tools/xserve/bin/3rdparty/modbus/lib:/opt/MoteWorks/tools/xserve/bin/3rdparty/postgresql/lib:/opt/MoteWorks/tools/xserve/bin/3rdparty/xmlrpc/lib:.:/opt/MoteWorks/tools/xserve/bin/3rdparty/libxml2/bin:/opt/MoteWorks/tools/xserve/bin/3rdparty/postgresql/bin:/opt/MoteWorks/tools/xserve/bin/3rdparty/xmlrpc/bin:/opt/MoteWorks/tools/xserve/bin/bin:$LD_LIBRARY_PATH

export XSERVE_PARAMETER_FILE=/opt/MoteWorks/tools/xserve/bin/xparams.properties 



# Deprecated...
# Extend path for java
#CLASSPATH=`$TOSROOT/tools/java/javapath`
#export CLASSPATH
#type java >/dev/null 2>/dev/null || PATH=`/usr/local/bin/locate-jre --java`:$PATH
#type javac >/dev/null 2>/dev/null || PATH=`/usr/local/bin/locate-jre --javac`:$PATH
#echo $PATH | grep -q /usr/local/bin ||  PATH=/usr/local/bin:$PATH

# Some neat aliases
alias ..='pushd'
alias ...='pushd +1'
alias .-='popd'
alias d='dirs'
alias h='history'
alias j='jobs'
alias l='ls -C'
alias la='ls -a'
alias ll='ls -l'
alias ls='ls --color -F'

# Xbow devel aliases
alias jtagmica2="ice-insight build/mica2/main.exe"
alias jtagmica2dot="ice-insight build/mica2dot/main.exe"
alias jtagmicaz="ice-insight build/micaz/main.exe"

