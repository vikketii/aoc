#!/usr/bin/env python3
import sys


def parts(lines):
    masks = [0]*3
    r = {"0": 0, "1": 1, "X": 2}
    mem1 = {}
    mem2 = {}

    for line in lines:
        splitted = line.split()
        if splitted[0] == "mask":
            read_mask = splitted[2]
            masks = [0]*3
            for i in read_mask:
                masks = [x << 1 for x in masks]
                masks[r[i]] += 1

        elif splitted[0][:3] == "mem":
            pos1, value2 = int(splitted[0][4:-1]), int(splitted[2])

            pos2 = pos1 | masks[1]
            insert_to_mem(pos2, masks[2], 35, value2, mem2)

            value1 = value2 & ~masks[0]
            value1 |= masks[1]
            mem1[pos1] = value1

    return (sum([x for x in mem1.values()]), sum([x for x in mem2.values()]))


def insert_to_mem(pos, maskx, n, value, mem):
    if (n < 0):
        mem[pos] = value
        return

    mask = 1 << n

    if (maskx & mask):
        insert_to_mem(pos | mask, maskx, n - 1, value, mem)
        insert_to_mem(pos & ~mask, maskx, n - 1, value, mem)
    else:
        insert_to_mem(pos, maskx, n - 1, value, mem)


def main():
    lines = sys.stdin.read().rstrip().splitlines()
    print(parts(lines))


main()
