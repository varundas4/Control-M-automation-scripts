#!/bin/sh

set -x;
cd $HOME
find -L *[Cc][Oo][Rr][Ee]*
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



