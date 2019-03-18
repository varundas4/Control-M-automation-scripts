#!/bin/sh
#################################################################################################################################
##Script Name: core_check.sh                                                                                                   ##
##Description: Script to check for availability of an CORE DUMP file in Control-M EM/Server's path. The file is undesirable and##
##             may cause problems in proper functionality of Control-M services.                                               ##
##Created by: Varun Das                                                                                                        ##
##Date: 5th February 2019                                                                                                      ##
#################################################################################################################################

set +x;
cd $HOME #path to check for 'core dump' file
find -L *[Cc][Oo][Rr][Ee]* #case-insensitive search
RESULT=$?
echo "result: $RESULT"
if [ $RESULT -eq 0 ]; then 
status=1
echo "status= $status"
exit $status
else 
status=0
echo "status= $status"
exit $status
fi
