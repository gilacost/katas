#!/bin/bash

read N
acc=0

for (( i=0; i<$N; i++ ))
do
  read el
  acc=$(echo "$acc+$el" | bc)
done
echo "scale=3;$acc/$N" | bc
