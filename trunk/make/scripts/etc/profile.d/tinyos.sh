# script for profile.d for bash shells, adjusted for each users
# installation by substituting /opt for the actual tinyos tree
# installation point.
# $Id: tinyos.sh,v 1.1.2.2 2006/05/19 23:25:13 mturon Exp $

export TOSROOT="/opt/tinyos-1.x"
export TOSDIR="$TOSROOT/tos"
export MAKERULES="$TOSROOT/tools/make/Makerules"

export AVARICE_ARGS=-j/dev/ttyS0

# Extend path for java
#export CLASSPATH=`$TOSROOT/tools/java/javapath`
#type java >/dev/null 2>/dev/null || PATH=`/usr/local/bin/locate-jre --java`:$PATH
#type javac >/dev/null 2>/dev/null || PATH=`/usr/local/bin/locate-jre --javac`:$PATH
echo $PATH | grep -q /usr/local/bin ||  PATH=/usr/local/bin:$PATH
