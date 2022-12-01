#!/usr/bin/env python3
import sys


def parts(line):
    """d[number] = (before last, last)"""
    part1 = 0
    d = {}
    x = 0
    previous = 0
    for i, v in enumerate(line.split(",")):
        v = int(v)
        d[v] = (i+1, i+1)
        previous = v
        x += 1

    while x < 30000000:
        x += 1
        previous = d[previous][1] - d[previous][0]
        if previous not in d:
            d[previous] = (x, x)
        else:
            d[previous] = (d[previous][1], x)

        if x == 2020:
            part1 = previous

    return part1, previous


def main():
    line = sys.stdin.read().rstrip()
    print(parts(line))


main()
