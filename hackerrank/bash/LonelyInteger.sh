#!/bin/bash

read
ARR=($(cat))
echo "${ARR[@]}" | tr ' ' '\n' | sort | uniq -u | tr '\n' ' '
