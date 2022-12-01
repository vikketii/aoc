#!/usr/bin/env python3
import sys
import re


def parts(lines):
    results = [0, 0]

    for line in lines:
        m = re.match(r'([0-9]+)-([0-9]+).+?([a-z]):.+?([a-z]+)', line)
        if m:
            a, b, c, s = m.group(1, 2, 3, 4)
            if (int(a) <= s.count(c) and s.count(c) <= int(b)):
                results[0] += 1
            if ((s[int(a)-1] == c) ^ (s[int(b)-1] == c)):
                results[1] += 1

    return results


lines = sys.stdin.readlines()
print(parts(lines))
