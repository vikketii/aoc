import re


def main():
    part1 = part2 = 0

    with open("input.txt") as f:
        data = f.read()

        m = re.findall(r"mul\((\d+),(\d+)\)|(don't\(\))|(do\(\))", data)

        enabled = True
        for a, b, dont, do in m:
            if do or dont:
                enabled = bool(do)
            if a and b:
                part1 += int(a) * int(b)
                if enabled:
                    part2 += int(a) * int(b)

    print(f"part1: {part1}, part2: {part2}")


main()
