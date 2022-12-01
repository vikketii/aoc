#!/usr/bin/env python3
import sys
import re


def get_rules(lines):
    rules = {}
    pattern1 = re.compile(r".+no other bags.$")

    for line in lines.splitlines():
        if not re.match(pattern1, line):
            line = line.split()
            key = " ".join(line[:2])
            contains = []
            line = " ".join(line[4:])

            for x in line.split(","):
                x = x.split()
                n, color = int(x[0]), " ".join(x[1:3])
                contains.append((color, n))

            rules[key] = contains

    return rules


def bags_containing(name, rules, s):
    for i in rules.keys():
        for j in rules[i]:
            if j[0] == name:
                s.add(i)
                s = s.union(bags_containing(i, rules, s))

    return s


def count_bags(name, rules):
    result = 1
    if not rules.get(name):
        return result

    for bag in rules.get(name):
        for i in range(bag[1]):
            result += count_bags(bag[0], rules)

    return result


def parts(lines):
    rules = get_rules(lines)
    return (len(bags_containing("shiny gold", rules, set())),
            count_bags("shiny gold", rules) - 1)


def main():
    lines = sys.stdin.read().rstrip()
    print(parts(lines))


main()
