#!/bin/bash

# Author : Claude Falguiere
# Date : 21/05/2010
# this script runs a jmeter script in non-GUI mode
# requires SCRIPT_NAME SCRIPT_ID SITE_CODE MODE_CODE GUI_OPTION USAGE_OPTIONS
# Usage jmeter-common [groupid]

CURRENT_DIR=$PWD
TEST_HOME=${CURRENT_DIR}

JMETER_HOME=/Users/cfalguiere/Tools/apache-jmeter-2.8

RESULTS_DIR_NAME=../../Results 
DATA_DIR_NAME=Data
SCENARIO_DIR_NAME=Scenario

JMETER_PROP_FILE=jmeter_custom.properties


############# 
# compute file names and options

# indtance id

echo "SCRIPT_ID:$SCRIPT_ID SITE_CODE:$SITE_CODE MODE_CODE:$MODE_CODE"

if [ "$1" = "" ] 
then INSTANCE_CODE=ALL
else INSTANCE_CODE=$1
fi
echo "INSTANCE_CODE $INSTANCE_CODE"


# override JMeter properties

TEST_OPTIONS=" -Jtest.home=${CURRENT_DIR}  -Jtest.instancegroup=${INSTANCE_CODE} "

echo "TEST_HOME=${TEST_HOME}"

# file names 

SCENARIO_PROP_FILE=${SCRIPT_ID}_${MODE_CODE}_${SITE_CODE}_${INSTANCE_CODE}.properties

echo "TEST_FILE=${SCRIPT_NAME}"
echo "JMETER_PROP_FILE=${JMETER_PROP_FILE}"
echo "SCENARIO_PROP_FILE=${SCENARIO_PROP_FILE}"

#DATE_TAG=`date '+%Y%m%d-%H%M'`
DATE_TAG=`date --date "+1 hour" '+%Y%m%d-%H%M'` 
echo "DATE_TAG ${DATE_TAG}"
RUN_ID=${DATE_TAG}_${SCRIPT_ID}_${MODE_CODE}_${SITE_CODE}_${INSTANCE_CODE}
echo "RUN_ID=${RUN_ID}"


RESULT_DIR=${TEST_HOME}/${RESULTS_DIR_NAME}/${RUN_ID}
mkdir -p ${RESULT_DIR}
echo "RESULT_DIR=${RESULT_DIR}"

RESULT_FILE_PATH=${RESULT_DIR}/results.jtl
LOG_FILE_PATH=${RESULT_DIR}/jmeter.log
echo "RESULT_FILE_PATH ${RESULT_FILE_PATH}"
echo "LOG_FILE_PATH ${LOG_FILE_PATH}"

############# 
# backup script and config file
if [ -f ${TEST_HOME}/${SCENARIO_DIR_NAME}/${SCRIPT_NAME} ] 
then cp ${TEST_HOME}/${SCENARIO_DIR_NAME}/${SCRIPT_NAME} ${RESULT_DIR}/${SCRIPT_NAME}
else echo "Could not backup ${TEST_HOME}/${SCENARIO_DIR_NAME}/${SCRIPT_NAME}";exit -1
fi
if [ -f ${TEST_HOME}/${DATA_DIR_NAME}/${JMETER_PROP_FILE} ] 
then cp ${TEST_HOME}/${DATA_DIR_NAME}/${JMETER_PROP_FILE} ${RESULT_DIR}/${JMETER_PROP_FILE}
else echo "Could not backup ${TEST_HOME}/${DATA_DIR_NAME}/${JMETER_PROP_FILE}";exit -1
fi

if [ -f ${TEST_HOME}/${DATA_DIR_NAME}/${SCENARIO_PROP_FILE} ] 
then cp ${TEST_HOME}/${DATA_DIR_NAME}/${SCENARIO_PROP_FILE} ${RESULT_DIR}/${SCENARIO_PROP_FILE}
else echo "Could not backup ${TEST_HOME}/${DATA_DIR_NAME}/${SCENARIO_PROP_FILE}";exit -1
fi




############# 
# run JMeter 
#cd ${JMETER_HOME}/bin
#echo Running JMeter in  ${JMETER_HOME}/bin
echo Running JMeter

JMETER_SCRIPT_OPTION="--testfile ${TEST_HOME}/${SCENARIO_DIR_NAME}/${SCRIPT_NAME} --propfile  ${TEST_HOME}/${DATA_DIR_NAME}/${JMETER_PROP_FILE} --addprop  ${TEST_HOME}/${DATA_DIR_NAME}/${SCENARIO_PROP_FILE}"
JMETER_LOG_OPTION="--logfile ${RESULT_FILE_PATH} --jmeterlogfile ${LOG_FILE_PATH}"
${JMETER_HOME}/bin/jmeter.sh ${GUI_OPTION} ${JMETER_SCRIPT_OPTION} ${JMETER_LOG_OPTION} --homedir ${JMETER_HOME}  ${TEST_OPTIONS} 

