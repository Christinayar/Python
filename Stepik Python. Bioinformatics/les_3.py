# 1-------------------------------------------------------
def f(n):
    return n * 10 + 5


print(f(f(f(10))))


# 2-------------------------------------------------------

def f(x):
    if x <= -2:
        return 1 - (x + 2) ** 2
    if x <= 2:
        return -x / 2
    return (x - 2) ** 2 + 1


# 3-------------------------------------------------------

def modify_list(l):
    l[:] = [i // 2 for i in l if not i % 2]


def modify_list(l):
    for i in reversed(range(len(l))):
        if l[i] % 2 == 1:
            del l[i]
        else:
            l[i] //= 2


# 4-------------------------------------------------------

def update_dictionary(d, key, value):
    if key in d:
        d[key].append(value)
    else:
        if 2 * key not in d: d[2 * key] = []
        update_dictionary(d, 2 * key, value)


# 5-------------------------------------------------------

import math

r = float(input())
p = math.pi * r * 2
print(p)

# 6-------------------------------------------------------

dest = {'север': (0, 1), 'запад': (-1, 0), 'юг': (0, -1), 'восток': (1, 0)}
n = int(input(''))
x_list = [(input('')).split(' ') for x in range(n)]
d = [(dest[x][0] * int(y), dest[x][1] * int(y)) for x, y in x_list]
res = (sum([x for x, y in d]), sum([y for x, y in d]))
print(' '.join(map(str, res)))
