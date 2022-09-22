#!/bin/python3

import re

S = input()
k = input()
matches = list(re.finditer(r'(?={})'.format(k), S))

if matches:
    for m in matches:
        print((m.start(), m.end() + len(k) - 1))
else:
    print((-1, -1))
