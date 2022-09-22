#!/bin/python3

if __name__ == '__main__':
    x = int(input()) + 1
    y = int(input()) + 1
    z = int(input()) + 1
    n = int(input())

    permutations = [[i, j, k] for i in range(x) for j in range(y) for k in range(z) if i+j+k!=n]
    print(permutations)
