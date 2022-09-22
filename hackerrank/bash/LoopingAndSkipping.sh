#!/bin/bash

for (( i=1; i<100; i++ ))
do
  if [ $( echo "$i%2" | bc) != 0 ] ; then
    echo $i
  fi
done
