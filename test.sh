#!/bin/bash

run () {
   $1
   if [ $? -eq 0 ]; then
   	echo OK
   else
   	echo FAIL
   fi
}
 
run ""
