#!/bin/python3

# My proposal
# import email.utils
# import re

# regex_email = r'([A-Za-z0-9]+[.-_])*[A-Za-z0-9]+@[A-Za-z0-9-]+(\.[A-Z|a-z]{2,})+'

# N = int(input())

# for _ in range(N):
#     (name, email) = email.utils.parseaddr(input())

#     if re.match(regex_email, email):
#         print(email.utils.formataddr((name, email)))
#
# HACKERRANK ONLY ACCEPTS
import re

EMAIL_REGEX = re.compile(r'^[a-zA-Z]{1}[\w\-\.]+@[a-zA-Z]+\.[a-zA-Z]{1,3}$')

for _ in range(int(input())):
    name, email = input().strip().split()
    if (re.match(EMAIL_REGEX, email[1:-1])):
        print(name, email)
