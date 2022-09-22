#!/bin/python3

import re
regex_pattern = r'^[7-9]\d{9}$'

N = int(input())

for _ in range(N):
    phone_number = input()
    if bool(re.search(regex_pattern, phone_number)) == True:
        print("YES")
    else:
        print("NO")
