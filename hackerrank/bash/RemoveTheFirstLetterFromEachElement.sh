#!/bin/bash

ARR=()
while read s; do
    ARR+=(".${s:1}")
done
echo "${ARR[@]}"
