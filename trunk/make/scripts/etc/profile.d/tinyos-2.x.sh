# script for profile.d for bash shells, adjusted for each users
# installation by substituting /opt for the actual tinyos tree
# installation point.
# $Id: tinyos-2.x.sh,v 1.1.2.1 2006/05/19 23:19:51 mturon Exp $

export TOSROOT="/opt/tinyos-2.x"
export TOSDIR="$TOSROOT/tos"
export MAKERULES="$TOSROOT/support/make/Makerules"

#deprecated java
#export CLASSPATH=`$TOSROOT/tools/java/javapath`

AVARICE_ARGS=-j/dev/ttyS0
export AVARICE_ARGS

echo $PATH | grep -q /usr/local/bin ||  PATH=/usr/local/bin:$PATH
