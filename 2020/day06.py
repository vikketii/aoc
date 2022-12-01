#!/usr/bin/env python3
import sys


def part1(lines):
    result = 0

    for line in lines.split("\n\n"):
        s = set()
        for c in line.rstrip():
            if (97 <= ord(c) <= 122):
                s.add(c)
        result += len(s)

    return result


def part2(lines):
    result = 0

    for group in lines.split("\n\n"):
        d = {}
        people = group.split("\n")
        for person in people:
            for c in person:
                if (97 <= ord(c) <= 122):
                    d[c] = d.get(c, 0) + 1

        result += len([x for x in d if d[x] == len(people)])

    return result


lines = sys.stdin.read()
print(part1(lines))
print(part2(lines))
