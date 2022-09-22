#!/bin/python3

import re

HEX_REGEX = r"(\#[a-f0-9]{3,6})[\;\,\)]{1}"

for i in range(int(input())):
    match = re.findall(HEX_REGEX, input(), re.I)
    if match:
        for j in list(match):
            print(j)
