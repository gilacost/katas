#!/bin/bash

read x
read y
read z

if [ $x == $y ] && [ $y == $z ]; then
    echo "EQUILATERAL"
else
  if [ $x != $y ] && [ $y != $z ] && [ $z != $x ]; then
      echo "SCALENE"
  else
    echo "ISOSCELES"
  fi
fi
