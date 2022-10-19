#!/bin/python3

if __name__ == '__main__':

    # N = int(input())

    # list = []

    # for _ in range(N):

    #     command = input()

    #     match command.split():
    #         case["insert", index, value]:
    #             list[index] = value
    #         case["remove", value]:
    #             list = list.remove(value)
    #         case["append", value]:
    #             list = list.append(value)
    #         case["sort"]:
    #             list = list.sort()
    #         case["reverse"]:
    #             list = list.reverse()
    #         case["pop"]:
    #             list = list.pop()
    #         case["print"]:
    #             print(list)
    #         case _:
    #             print(f"Command '{command}' not understood")

n = int(input())
l = []
for _ in range(n):
    s = input().strip().split(' ')
    cmd = s[0]
    args = s[1:]
    if cmd != "print":
        cmd += "("+",".join(args) + ")"
        eval("l."+cmd)
    else:
        print(l)
