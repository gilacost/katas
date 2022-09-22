#!/bin/bash

ARR=()

while read s; do
if [[ "$s" == *"a"* ]]; then
    ARR=$ARR
else
  if [[ "$s" == *"A"* ]]; then
    ARR=$ARR
  else
    ARR+=($s)
  fi
fi
done

echo "${ARR[@]}" | tr -d ' '
