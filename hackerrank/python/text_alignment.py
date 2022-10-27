#!/bin/python3

width = int(input())
filling_c = "H"
filling = filling_c * width

# Top cone
for i in range(width):
    print((filling_c * i).rjust(width - 1) +
          filling_c + (filling_c * i).ljust(width - 1))

# Top collumns
for i in range(width + 1):
    print((filling).center(width * 2) +
          (filling).center(width * 6))

middle_row = filling * 5

# Middle row
for i in range((width + 1) // 2):
    print((middle_row).center(width * 6))

# Bottom collumns
for i in range(width + 1):
    print((filling).center(width * 2) +
          (filling).center(width * 6))

# Bottom cone
for i in range(width-1, -1, -1):
    print((filling_c * i).rjust((width * 5) - 1) +
          filling_c + (filling_c * i).ljust((width * 5) - 1))
