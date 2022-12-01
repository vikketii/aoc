#!/usr/bin/env python3
import sys
from functools import reduce


def parts(lines):
    results = [0] * 5
    x = [0] * 5

    for count, line in enumerate(lines[1:]):
        line = line.rstrip()

        for i in range(4):
            x[i] += i*2 + 1
            if (x[i] >= len(line)):
                x[i] %= len(line)

            if (line[x[i]] == '#'):
                results[i] += 1

        if ((count+1) % 2 == 0):
            x[4] += 1

            if (x[4] >= len(line)):
                x[4] = 0

            if (line[x[4]] == '#'):
                results[4] += 1

    return (results[1], reduce(lambda x, y: x*y, results))


lines = sys.stdin.readlines()
print(parts(lines))
