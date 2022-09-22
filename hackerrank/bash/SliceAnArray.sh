#!/bin/bash

ARR=()
while read s; do
  ARR+=($s)
done

echo "${ARR[@]:3:5}"
