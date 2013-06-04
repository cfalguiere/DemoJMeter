#!/bin/bash

# Author : Claude Falguiere
# Date : 21/05/2010
# this script runs a jmeter script in GUI mode
# Usage jmeter-gui 


CURRENT_DIR=$PWD

# override JMeter properties
TEST_OPTIONS="-Jtest.home=${CURRENT_DIR}"

TEST_HOME=${CURRENT_DIR}
JMETER_HOME=/Users/cfalguiere/Tools/apache-jmeter-2.8
echo "TEST_HOME=${TEST_HOME}"

PROP_FILE=jmeter_custom.properties
echo "PROP_FILE=${PROP_FILE}"


JMETER_SCRIPT_OPTION="--propfile  ${TEST_HOME}/Data/${PROP_FILE}"
${JMETER_HOME}/bin/jmeter.sh ${GUI_OPTION} ${JMETER_SCRIPT_OPTION} --homedir ${JMETER_HOME} ${TEST_OPTIONS}

