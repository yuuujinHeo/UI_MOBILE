#!/bin/bash

while [ 1 ]
do
     pid=`ps -ef | grep "SLAMNAV" | grep -v 'grep' | awk '{print $2}'`
     if [ -z $pid ]
     then
         /home/odroid/code/build-SLAMNAV-Desktop-Release/SLAMNAV
     else
         kill -9 $pid
         /home/odroid/code/build-SLAMNAV-Desktop-Release/SLAMNAV
     fi
done
