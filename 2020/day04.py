#!/usr/bin/env python3
import sys
import re


def parts(lines):
    result = [0, 0]
    lines = lines.split("\n\n")
    required = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

    for line in lines:
        d = {}
        for pair in line.split():
            key, value = pair.split(":")
            d[key] = value

        if all([x in d.keys() for x in required]):
            result[0] += 1
            if all([validate(k, v) for k, v in d.items()]):
                result[1] += 1

    return result


def validate(key, value):
    if key == "byr":
        return (1920 <= int(value)) and (int(value) <= 2002)
    elif key == "iyr":
        return (2010 <= int(value)) and (int(value) <= 2020)
    elif key == "eyr":
        return (2020 <= int(value)) and (int(value) <= 2030)
    elif key == "hgt":
        value, t = value[:-2], value[-2:]
        if t == "cm":
            return (150 <= int(value)) and (int(value) <= 193)
        elif t == "in":
            return (59 <= int(value)) and (int(value) <= 76)
    elif key == "hcl":
        return re.match("^#[0-9a-f]{6}$", value) is not None
    elif key == "ecl":
        return value in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
    elif key == "pid":
        return re.match("^[0-9]{9}$", value) is not None
    elif key == "cid":
        return True

    return False


lines = sys.stdin.read()
print(parts(lines))
