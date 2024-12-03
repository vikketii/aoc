def check_row(row):
    previous = row[0]

    for curr in row[1:]:
        if not previous < curr <= previous + 3:
            return False

        previous = curr

    return True


def answer(l):
    part1 = part2 = 0

    for row in l:
        reverse_row = row[::-1]

        if check_row(row) or check_row(reverse_row):
            part1 += 1
            part2 += 1
        else:
            for i in range(len(row)):
                new_row = row[:i] + row[i + 1 :]
                new_reverse_row = reverse_row[:i] + reverse_row[i + 1 :]

                if check_row(new_row) or check_row(new_reverse_row):
                    part2 += 1
                    break

    print(f"part1: {part1}, part2: {part2}")


def main():
    l = []

    with open("input.txt") as f:
        for row in f:
            l.append([int(x) for x in row.split(" ")])

    answer(l)


main()
