#!/usr/bin/env python3
import sys


def part1(lines):
    result = 0
    lines = lines.splitlines()
    s = set()
    i = 0

    while True:
        if i in s:
            break
        s.add(i)
        inst, value = lines[i].split()
        if inst == "acc":
            result += int(value)
        elif inst == "jmp":
            i += int(value)
            continue
        i += 1

    return result


def part2(lines, result, i, branch, used):
    while True:
        if i == len(lines):
            return (True, result)

        if i in used or i > len(lines):
            return (False, result)

        used.add(i)
        inst, value = lines[i].split()
        value = int(value)

        if inst == "acc":
            result += value
            i += 1
        elif inst == "jmp":
            if branch:
                final, tempresult = part2(lines, result, i+1, False, used.copy())
                if final:
                    return (final, tempresult)
            i += value
        else:
            if branch:
                final, tempresult = part2(lines, result, i+value, False, used.copy())
                if final:
                    return (final, tempresult)
            i += 1

    return (False, result)


def main():
    lines = sys.stdin.read().rstrip()
    print(part1(lines))
    print(part2(lines.splitlines(), 0, 0, True, set())[1])


main()
