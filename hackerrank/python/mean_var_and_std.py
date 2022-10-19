#!/bin/python3

import numpy

n, m = input().split()

points = []

for _ in range(int(n)):
    points.append(list(map(int, input().split())))

np = numpy.array(points)

print(numpy.mean(np, axis=1))
print(numpy.var(np, axis=0))
print(numpy.round(numpy.std(np, axis=None), 11))
