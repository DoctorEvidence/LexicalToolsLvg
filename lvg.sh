#!/bin/sh -f
# ---------------------------------
# This is the batch file that sets
# the initial classpath, and runs
# the java lexical tools programs.
# ---------------------------------


JAVA=java

# ------------------
# Set the LVG_DIR
# ------------------
LVG_DIR=/opt/lvg
JDBC=

# ------------------
# Set the classpath
# ------------------
CLASSPATH="${JDBC}:${LVG_DIR}:${LVG_DIR}/lib/lvg2023dist.jar:"

export LVG_DIR JAVA CLASSPATH

# ------------------
# Run the command
# ------------------
${JAVA}  -Xms32m -Xmx128m -classpath ${CLASSPATH} gov.nih.nlm.nls.lvg.Tools.CmdLineTools.lvg ${*}


