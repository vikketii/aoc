import sys

d = set()
for l in sys.stdin:
    d.add(int(l))

for i in d:
    for j in d:
        if ((2020-i-j) in d):
            print(i * j * (2020-i-j))
