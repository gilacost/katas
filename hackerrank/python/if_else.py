#!/bin/python3

import math
import os
import random
import re
import sys



if __name__ == '__main__':
    n = int(input().strip())
    is_odd = (n % 2) != 0
    if is_odd:
      print("Weird")
    elif 2 <= n < 5:
      print("Not Weird")
    elif 6 <= n <= 20:
      print("Weird")
    else:
      print("Not Weird")

